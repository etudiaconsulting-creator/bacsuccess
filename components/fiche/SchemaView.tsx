'use client'

import { useMemo, useState, useEffect } from 'react'
import { useTheme } from 'next-themes'
import { Maximize2, X } from 'lucide-react'
import type { SchemaContent, SchemaNode, SchemaEdge } from '@/lib/supabase/types'

interface SchemaViewProps {
  schema: SchemaContent
}

// --- Sizing ---

const CHAR_WIDTH = 8
const LINE_HEIGHT = 20
const PADDING_X = 24
const PADDING_Y = 16
const MIN_WIDTH = 140
const MAX_WIDTH = 280
const LEVEL_GAP_Y = 120
const NODE_GAP_X = 40

type NodeStyle = { fill: string; stroke: string; textFill: string; fontSize: number; fontWeight: number }

function getNodeStyles(isDark: boolean): Record<SchemaNode['type'], NodeStyle> {
  if (isDark) {
    return {
      main: { fill: '#1B4332', stroke: '#2D6A4F', textFill: '#FFFFFF', fontSize: 16, fontWeight: 700 },
      branch: { fill: '#78350f', stroke: '#D97706', textFill: '#FCD34D', fontSize: 14, fontWeight: 600 },
      leaf: { fill: '#1F2937', stroke: '#4B5563', textFill: '#F3F4F6', fontSize: 13, fontWeight: 400 },
    }
  }
  return {
    main: { fill: '#1B4332', stroke: '#1B4332', textFill: '#FFFFFF', fontSize: 16, fontWeight: 700 },
    branch: { fill: '#FEF3C7', stroke: '#D97706', textFill: '#92400E', fontSize: 14, fontWeight: 600 },
    leaf: { fill: '#FFFFFF', stroke: '#D1D5DB', textFill: '#1A1A1A', fontSize: 13, fontWeight: 400 },
  }
}

function getEdgeColors(isDark: boolean) {
  return {
    stroke: isDark ? '#6B7280' : '#9CA3AF',
    labelBg: isDark ? '#1F2937' : 'white',
    labelText: isDark ? '#9CA3AF' : '#6B7280',
  }
}

// --- Compute node dimensions based on text ---

interface LayoutNode {
  id: string
  label: string
  type: SchemaNode['type']
  lines: string[]
  width: number
  height: number
  x: number
  y: number
  children: string[]
}

function computeNodeSize(node: SchemaNode): { width: number; height: number; lines: string[] } {
  const lines = node.label.split('\n')
  const maxLineLen = Math.max(...lines.map((l) => l.length))
  const textWidth = maxLineLen * CHAR_WIDTH
  const width = Math.min(MAX_WIDTH, Math.max(MIN_WIDTH, textWidth + PADDING_X * 2))
  const height = lines.length * LINE_HEIGHT + PADDING_Y * 2
  return { width, height, lines }
}

// --- Tree layout algorithm ---

interface TreeNode {
  id: string
  children: TreeNode[]
}

function buildTree(nodes: SchemaNode[], edges: SchemaEdge[]): TreeNode | null {
  if (nodes.length === 0) return null

  const childrenMap: Record<string, string[]> = {}
  const targetSet = new Set<string>()

  for (const n of nodes) {
    childrenMap[n.id] = []
  }
  for (const e of edges) {
    if (childrenMap[e.from]) {
      childrenMap[e.from].push(e.to)
    }
    targetSet.add(e.to)
  }

  // Root = node with type "main", or node that is never a target
  let rootId = nodes.find((n) => n.type === 'main')?.id
  if (!rootId) {
    rootId = nodes.find((n) => !targetSet.has(n.id))?.id
  }
  if (!rootId) {
    rootId = nodes[0].id
  }

  const visited = new Set<string>()
  function build(id: string): TreeNode {
    visited.add(id)
    const kids = (childrenMap[id] || []).filter((cid) => !visited.has(cid))
    return { id, children: kids.map((cid) => build(cid)) }
  }

  const tree = build(rootId)

  // Add orphan nodes as children of root
  for (const n of nodes) {
    if (!visited.has(n.id)) {
      tree.children.push({ id: n.id, children: [] })
    }
  }

  return tree
}

function layoutTree(
  tree: TreeNode,
  nodeMap: Record<string, LayoutNode>
): { totalWidth: number; totalHeight: number } {
  // 1. Compute subtree widths bottom-up
  const subtreeWidths: Record<string, number> = {}

  function computeSubtreeWidth(t: TreeNode): number {
    const node = nodeMap[t.id]
    if (t.children.length === 0) {
      subtreeWidths[t.id] = node.width
      return node.width
    }
    const childrenTotalWidth = t.children.reduce(
      (sum, c) => sum + computeSubtreeWidth(c),
      0
    ) + (t.children.length - 1) * NODE_GAP_X

    subtreeWidths[t.id] = Math.max(node.width, childrenTotalWidth)
    return subtreeWidths[t.id]
  }

  const totalWidth = computeSubtreeWidth(tree)

  // 2. Assign positions top-down
  let maxY = 0

  function assignPositions(t: TreeNode, x: number, y: number) {
    const node = nodeMap[t.id]
    node.x = x + subtreeWidths[t.id] / 2
    node.y = y + node.height / 2
    maxY = Math.max(maxY, y + node.height)

    if (t.children.length === 0) return

    const childrenTotalWidth = t.children.reduce(
      (sum, c) => sum + subtreeWidths[c.id],
      0
    ) + (t.children.length - 1) * NODE_GAP_X

    let childX = x + (subtreeWidths[t.id] - childrenTotalWidth) / 2
    const childY = y + node.height + LEVEL_GAP_Y

    for (const child of t.children) {
      assignPositions(child, childX, childY)
      childX += subtreeWidths[child.id] + NODE_GAP_X
    }
  }

  assignPositions(tree, 0, 0)

  return { totalWidth, totalHeight: maxY }
}

// --- Rendering helpers ---

function renderMultilineText(
  lines: string[],
  x: number,
  y: number,
  fontSize: number,
  fontWeight: number,
  fill: string
) {
  const lineH = LINE_HEIGHT
  const startY = y - ((lines.length - 1) * lineH) / 2

  return lines.map((line, i) => {
    const parts: React.ReactNode[] = []
    let j = 0
    let partKey = 0
    let buf = ''

    while (j < line.length) {
      if (line[j] === '^') {
        if (buf) {
          parts.push(<tspan key={partKey++}>{buf}</tspan>)
          buf = ''
        }
        j++
        if (j < line.length && line[j] === '(') {
          j++
          let sup = ''
          let depth = 1
          while (j < line.length && depth > 0) {
            if (line[j] === '(') depth++
            else if (line[j] === ')') { depth--; if (depth === 0) { j++; break } }
            sup += line[j]
            j++
          }
          parts.push(
            <tspan key={partKey++} baselineShift="super" fontSize={fontSize * 0.7}>
              {sup}
            </tspan>
          )
        } else {
          let sup = ''
          while (j < line.length && /[0-9a-zA-Z.]/.test(line[j])) {
            sup += line[j]
            j++
          }
          if (sup) {
            parts.push(
              <tspan key={partKey++} baselineShift="super" fontSize={fontSize * 0.7}>
                {sup}
              </tspan>
            )
          } else {
            buf += '^'
          }
        }
        continue
      }
      buf += line[j]
      j++
    }
    if (buf) parts.push(<tspan key={partKey++}>{buf}</tspan>)

    return (
      <text
        key={i}
        x={x}
        y={startY + i * lineH}
        textAnchor="middle"
        dominantBaseline="central"
        fontSize={fontSize}
        fontWeight={fontWeight}
        fill={fill}
      >
        {parts}
      </text>
    )
  })
}

function renderNode(layoutNode: LayoutNode, nodeStyles: Record<SchemaNode['type'], NodeStyle>) {
  const style = nodeStyles[layoutNode.type]
  const rx = 8
  const halfW = layoutNode.width / 2
  const halfH = layoutNode.height / 2

  return (
    <g key={layoutNode.id}>
      {layoutNode.type === 'main' && (
        <rect
          x={layoutNode.x - halfW + 3}
          y={layoutNode.y - halfH + 3}
          width={layoutNode.width}
          height={layoutNode.height}
          rx={rx}
          fill="rgba(0,0,0,0.12)"
        />
      )}
      <rect
        x={layoutNode.x - halfW}
        y={layoutNode.y - halfH}
        width={layoutNode.width}
        height={layoutNode.height}
        rx={rx}
        fill={style.fill}
        stroke={style.stroke}
        strokeWidth={layoutNode.type === 'leaf' ? 1.5 : layoutNode.type === 'branch' ? 2 : 0}
      />
      {renderMultilineText(
        layoutNode.lines,
        layoutNode.x,
        layoutNode.y,
        style.fontSize,
        style.fontWeight,
        style.textFill
      )}
    </g>
  )
}

function renderEdge(
  edge: SchemaEdge,
  nodeMap: Record<string, LayoutNode>,
  index: number,
  edgeColors: { stroke: string; labelBg: string; labelText: string }
) {
  const from = nodeMap[edge.from]
  const to = nodeMap[edge.to]
  if (!from || !to) return null

  // Bottom of parent -> top of child
  const x1 = from.x
  const y1 = from.y + from.height / 2
  const x2 = to.x
  const y2 = to.y - to.height / 2

  // Bezier control points
  const cy1 = y1 + (y2 - y1) * 0.4
  const cy2 = y1 + (y2 - y1) * 0.6
  const d = `M ${x1} ${y1} C ${x1} ${cy1}, ${x2} ${cy2}, ${x2} ${y2}`

  const midX = (x1 + x2) / 2
  const midY = (y1 + y2) / 2

  return (
    <g key={`edge-${index}`}>
      <path
        d={d}
        fill="none"
        stroke={edgeColors.stroke}
        strokeWidth={1.5}
        markerEnd="url(#schema-arrow)"
      />
      {edge.label && (
        <>
          <rect
            x={midX - (edge.label.length * 3.5 + 6)}
            y={midY - 9}
            width={edge.label.length * 7 + 12}
            height={18}
            rx={4}
            fill={edgeColors.labelBg}
            fillOpacity={0.9}
          />
          <text
            x={midX}
            y={midY}
            textAnchor="middle"
            dominantBaseline="central"
            fontSize={11}
            fill={edgeColors.labelText}
          >
            {edge.label}
          </text>
        </>
      )}
    </g>
  )
}

// --- SVG Schema (desktop) ---

function SvgSchema({ schema, isDark = false }: { schema: SchemaContent; isDark?: boolean }) {
  const nodeStyles = getNodeStyles(isDark)
  const edgeColors = getEdgeColors(isDark)
  const { layoutNodes, totalWidth, totalHeight, nodeMap } = useMemo(() => {
    const nm: Record<string, LayoutNode> = {}
    for (const node of schema.nodes) {
      const { width, height, lines } = computeNodeSize(node)
      nm[node.id] = {
        id: node.id,
        label: node.label,
        type: node.type,
        lines,
        width,
        height,
        x: 0,
        y: 0,
        children: [],
      }
    }

    const tree = buildTree(schema.nodes, schema.edges)
    let tw = 800
    let th = 400
    if (tree) {
      const result = layoutTree(tree, nm)
      tw = result.totalWidth
      th = result.totalHeight
    }

    return {
      layoutNodes: Object.values(nm),
      totalWidth: tw,
      totalHeight: th,
      nodeMap: nm,
    }
  }, [schema])

  const padding = 50
  const viewBox = `${-padding} ${-padding} ${totalWidth + padding * 2} ${totalHeight + padding * 2}`

  return (
    <div className="w-full overflow-x-auto">
      <svg
        width="100%"
        viewBox={viewBox}
        className="min-w-[400px] h-auto"
        xmlns="http://www.w3.org/2000/svg"
      >
        <defs>
          <marker
            id="schema-arrow"
            markerWidth="10"
            markerHeight="7"
            refX="9"
            refY="3.5"
            orient="auto"
            markerUnits="strokeWidth"
          >
            <polygon points="0 0, 10 3.5, 0 7" fill={edgeColors.stroke} />
          </marker>
        </defs>

        {schema.edges.map((edge, i) => renderEdge(edge, nodeMap, i, edgeColors))}
        {layoutNodes.map((node) => renderNode(node, nodeStyles))}
      </svg>
    </div>
  )
}

// --- Mobile vertical layout ---

interface MobileTreeNode {
  id: string
  node: SchemaNode
  children: MobileTreeNode[]
}

function buildMobileTree(nodes: SchemaNode[], edges: SchemaEdge[]): MobileTreeNode | null {
  if (nodes.length === 0) return null

  const nodeById: Record<string, SchemaNode> = {}
  const childrenMap: Record<string, string[]> = {}
  const targetSet = new Set<string>()

  for (const n of nodes) {
    nodeById[n.id] = n
    childrenMap[n.id] = []
  }
  for (const e of edges) {
    if (childrenMap[e.from]) childrenMap[e.from].push(e.to)
    targetSet.add(e.to)
  }

  let rootId = nodes.find((n) => n.type === 'main')?.id
  if (!rootId) rootId = nodes.find((n) => !targetSet.has(n.id))?.id
  if (!rootId) rootId = nodes[0].id

  const edgeLabelMap: Record<string, string> = {}
  for (const e of edges) {
    if (e.label) edgeLabelMap[`${e.from}->${e.to}`] = e.label
  }

  const visited = new Set<string>()
  function build(id: string): MobileTreeNode {
    visited.add(id)
    const kids = (childrenMap[id] || []).filter((cid) => !visited.has(cid))
    return { id, node: nodeById[id], children: kids.map((cid) => build(cid)) }
  }

  const tree = build(rootId)
  for (const n of nodes) {
    if (!visited.has(n.id)) {
      tree.children.push({ id: n.id, node: nodeById[n.id], children: [] })
    }
  }

  return tree
}

function getEdgeLabel(edges: SchemaEdge[], fromId: string, toId: string): string | undefined {
  return edges.find((e) => e.from === fromId && e.to === toId)?.label
}

function MobileSchema({ schema }: { schema: SchemaContent }) {
  const tree = useMemo(() => buildMobileTree(schema.nodes, schema.edges), [schema])

  if (!tree) return null

  return (
    <div className="space-y-4">
      {/* Main node */}
      <div className="rounded-xl bg-[#1B4332] px-5 py-4 text-center">
        <p className="text-base font-bold text-white whitespace-pre-line">{tree.node.label}</p>
      </div>

      {/* Branch nodes */}
      {tree.children.map((branch) => {
        const edgeLabel = getEdgeLabel(schema.edges, tree.id, branch.id)
        return (
          <div key={branch.id}>
            {edgeLabel && (
              <div className="flex justify-center mb-2">
                <span className="rounded-full bg-gray-100 px-3 py-0.5 text-xs text-gray-500">{edgeLabel}</span>
              </div>
            )}
            <div className="rounded-xl border-2 border-amber-500 bg-amber-50 px-4 py-3">
              <p className="font-semibold text-amber-900 whitespace-pre-line">{branch.node.label}</p>

              {branch.children.length > 0 && (
                <div className="mt-3 space-y-1.5 border-l-2 border-gray-300 pl-4 ml-1">
                  {branch.children.map((leaf) => {
                    const leafEdge = getEdgeLabel(schema.edges, branch.id, leaf.id)
                    return (
                      <div key={leaf.id}>
                        {leafEdge && (
                          <span className="text-[11px] text-gray-400 mb-0.5 block">{leafEdge}</span>
                        )}
                        <p className="text-sm text-gray-700 whitespace-pre-line">{leaf.node.label}</p>
                      </div>
                    )
                  })}
                </div>
              )}
            </div>
          </div>
        )
      })}
    </div>
  )
}

// --- Fullscreen SVG modal ---

function FullscreenModal({ schema, onClose, isDark }: { schema: SchemaContent; onClose: () => void; isDark: boolean }) {
  useEffect(() => {
    document.body.style.overflow = 'hidden'
    return () => { document.body.style.overflow = '' }
  }, [])

  return (
    <div className="fixed inset-0 z-50 bg-white dark:bg-gray-900 flex flex-col">
      <div className="flex items-center justify-between px-4 py-3 border-b border-gray-200">
        <p className="text-sm font-semibold text-foreground">{schema.title}</p>
        <button onClick={onClose} className="p-2 rounded-lg hover:bg-gray-100 cursor-pointer">
          <X className="h-5 w-5 text-gray-600" />
        </button>
      </div>
      <div className="flex-1 overflow-auto" style={{ touchAction: 'manipulation' }}>
        <div className="min-w-[600px] p-4">
          <SvgSchema schema={schema} isDark={isDark} />
        </div>
      </div>
    </div>
  )
}

// --- Main component ---

export default function SchemaView({ schema }: SchemaViewProps) {
  const { theme } = useTheme()
  const [isMobile, setIsMobile] = useState(false)
  const [showFullscreen, setShowFullscreen] = useState(false)
  const [mounted, setMounted] = useState(false)
  const isDark = mounted && theme === 'dark'

  useEffect(() => {
    setMounted(true)
    const check = () => setIsMobile(window.innerWidth < 640)
    check()
    window.addEventListener('resize', check)
    return () => window.removeEventListener('resize', check)
  }, [])

  if (schema.nodes.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center rounded-xl border border-dashed border-gray-300 bg-white px-6 py-16 text-center">
        <svg xmlns="http://www.w3.org/2000/svg" className="mb-4 h-12 w-12 text-muted" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round"><line x1="6" x2="6" y1="3" y2="15"/><circle cx="18" cy="6" r="3"/><circle cx="6" cy="18" r="3"/><path d="M18 9a9 9 0 0 1-9 9"/></svg>
        <h2 className="text-lg font-semibold text-foreground">Le schéma de synthèse sera bientôt disponible !</h2>
      </div>
    )
  }

  return (
    <div className="w-full">
      <h3 className="text-lg font-semibold text-foreground mb-6 text-center flex items-center justify-center gap-3">
        <span className="h-px w-12 bg-gray-300" />
        {schema.title}
        <span className="h-px w-12 bg-gray-300" />
      </h3>

      {isMobile ? (
        <>
          <MobileSchema schema={schema} />
          <button
            onClick={() => setShowFullscreen(true)}
            className="mt-6 w-full flex items-center justify-center gap-2 rounded-xl border border-gray-200 bg-white py-3 text-sm font-medium text-foreground hover:bg-gray-50 cursor-pointer"
          >
            <Maximize2 className="h-4 w-4" />
            Voir le schéma complet
          </button>
          {showFullscreen && (
            <FullscreenModal schema={schema} onClose={() => setShowFullscreen(false)} isDark={isDark} />
          )}
        </>
      ) : (
        <SvgSchema schema={schema} isDark={isDark} />
      )}
    </div>
  )
}
