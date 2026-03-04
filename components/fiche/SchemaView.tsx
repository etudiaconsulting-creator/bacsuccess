'use client'

import { useMemo } from 'react'
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

const NODE_STYLES: Record<
  SchemaNode['type'],
  { fill: string; stroke: string; textFill: string; fontSize: number; fontWeight: number }
> = {
  main: { fill: '#1B4332', stroke: '#1B4332', textFill: '#FFFFFF', fontSize: 16, fontWeight: 700 },
  branch: { fill: '#FEF3C7', stroke: '#D97706', textFill: '#92400E', fontSize: 14, fontWeight: 600 },
  leaf: { fill: '#FFFFFF', stroke: '#D1D5DB', textFill: '#1A1A1A', fontSize: 13, fontWeight: 400 },
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

function renderNode(layoutNode: LayoutNode) {
  const style = NODE_STYLES[layoutNode.type]
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
  index: number
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
        stroke="#9CA3AF"
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
            fill="white"
            fillOpacity={0.9}
          />
          <text
            x={midX}
            y={midY}
            textAnchor="middle"
            dominantBaseline="central"
            fontSize={11}
            fill="#6B7280"
          >
            {edge.label}
          </text>
        </>
      )}
    </g>
  )
}

// --- Main component ---

export default function SchemaView({ schema }: SchemaViewProps) {
  const { layoutNodes, totalWidth, totalHeight, nodeMap } = useMemo(() => {
    // Build layout nodes
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

    // Build and layout tree
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
    <div className="w-full">
      <h3 className="text-lg font-semibold text-foreground mb-6 text-center flex items-center justify-center gap-3">
        <span className="h-px w-12 bg-gray-300" />
        {schema.title}
        <span className="h-px w-12 bg-gray-300" />
      </h3>
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
              <polygon points="0 0, 10 3.5, 0 7" fill="#9CA3AF" />
            </marker>
          </defs>

          {schema.edges.map((edge, i) => renderEdge(edge, nodeMap, i))}
          {layoutNodes.map((node) => renderNode(node))}
        </svg>
      </div>
    </div>
  )
}
