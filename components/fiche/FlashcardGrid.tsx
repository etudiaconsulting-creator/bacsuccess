'use client'

import { useState } from 'react'
import { RotateCcw } from 'lucide-react'
import type { Flashcard } from '@/lib/supabase/types'
import FormulaText from '@/components/ui/FormulaText'

interface FlashcardGridProps {
  flashcards: Flashcard[]
}

const CATEGORY_COLORS: Record<string, string> = {
  'Définition': '#2563EB',
  'Definition': '#2563EB',
  'Formule': '#059669',
  'Méthode': '#EA580C',
  'Methode': '#EA580C',
  'Distinction': '#7C3AED',
  'Concept': '#0891B2',
  'Exemple': '#CA8A04',
  'Philosophe': '#DB2777',
}

function getCategoryColor(category: string): string {
  return CATEGORY_COLORS[category] ?? '#6B7280'
}

/** Check if text looks like a math formula (has = and math operators) */
function isFormulaExpr(text: string): boolean {
  if (!/=/.test(text)) return false
  return /[\/^×÷]/.test(text) || / [x*+\-] /i.test(text)
}

/** Split text into sentences at ". " followed by uppercase letter */
function splitSentences(text: string): string[] {
  const result: string[] = []
  const regex = /\.\s+(?=[A-ZÀÂÆÇÉÈÊËÏÎÔŒÙÛÜŸ])/g
  let lastIndex = 0
  let match
  while ((match = regex.exec(text)) !== null) {
    result.push(text.slice(lastIndex, match.index + 1).trim())
    lastIndex = match.index + match[0].length
  }
  if (lastIndex < text.length) {
    result.push(text.slice(lastIndex).trim())
  }
  return result.filter(Boolean)
}

/** Extract numbered list items: "intro: 1. item 2. item 3. item" */
function splitNumberedItems(
  text: string
): { intro?: string; items: { num: string; text: string }[] } | null {
  const regex = /(\d+)[.)]\s/g
  const matches: { index: number; num: string; len: number }[] = []
  let m
  while ((m = regex.exec(text)) !== null) {
    matches.push({ index: m.index, num: m[1], len: m[0].length })
  }
  if (matches.length < 2 || parseInt(matches[0].num) !== 1) return null

  const intro =
    matches[0].index > 0
      ? text.slice(0, matches[0].index).trim()
      : undefined

  const items: { num: string; text: string }[] = []
  for (let i = 0; i < matches.length; i++) {
    const start = matches[i].index + matches[i].len
    const end = i + 1 < matches.length ? matches[i + 1].index : text.length
    items.push({
      num: matches[i].num,
      text: text.slice(start, end).trim().replace(/\.\s*$/, ''),
    })
  }
  return { intro, items }
}

/** Extract chronology items: "1947: event. 1960: event. 2024: event" */
function splitChronology(
  text: string
): { intro?: string; dates: { year: string; text: string }[] } | null {
  const regex = /(\d{4}(?:\s*-\s*\d{2,4})?)\s*:\s*/g
  const matches: { index: number; year: string; len: number }[] = []
  let m
  while ((m = regex.exec(text)) !== null) {
    matches.push({ index: m.index, year: m[1], len: m[0].length })
  }
  if (matches.length < 2) return null

  const intro =
    matches[0].index > 0
      ? text.slice(0, matches[0].index).trim()
      : undefined

  const dates: { year: string; text: string }[] = []
  for (let i = 0; i < matches.length; i++) {
    const start = matches[i].index + matches[i].len
    const end = i + 1 < matches.length ? matches[i + 1].index : text.length
    dates.push({
      year: matches[i].year,
      text: text.slice(start, end).trim().replace(/\.\s*$/, ''),
    })
  }
  return { intro, dates }
}

/** Render text with bold keywords before colons and formula styling */
function renderRichText(text: string) {
  // Full formula expression → monospace bg
  if (isFormulaExpr(text)) {
    return (
      <span className="bg-gray-100 px-1.5 py-0.5 rounded text-[14px] font-mono">
        <FormulaText text={text} />
      </span>
    )
  }

  // "Keyword: rest" → bold keyword
  const colonMatch = text.match(/^([A-ZÀ-Ÿ][^:]{0,35}):\s*(.*)$/)
  if (colonMatch) {
    const keyword = colonMatch[1]
    const rest = colonMatch[2]

    if (!rest) {
      return (
        <strong className="font-semibold text-[#1A1A1A]">
          {keyword}&thinsp;:
        </strong>
      )
    }

    if (isFormulaExpr(rest)) {
      return (
        <>
          <strong className="font-semibold text-[#1A1A1A]">
            {keyword}&thinsp;:
          </strong>{' '}
          <span className="bg-gray-100 px-1.5 py-0.5 rounded text-[14px] font-mono">
            <FormulaText text={rest} />
          </span>
        </>
      )
    }

    return (
      <>
        <strong className="font-semibold text-[#1A1A1A]">
          {keyword}&thinsp;:
        </strong>{' '}
        <FormulaText text={rest} />
      </>
    )
  }

  return <FormulaText text={text} />
}

/** Main answer formatter — applies all parsing rules */
function formatAnswer(text: string) {
  const elements: React.ReactNode[] = []
  let key = 0

  // Rule 3: split by explicit \n first
  const segments = text.split('\n')

  for (const segment of segments) {
    const trimmed = segment.trim()
    if (!trimmed) {
      elements.push(<div key={key++} className="h-2" />)
      continue
    }

    // Rule 1: numbered list items (1. 2. 3. embedded in text)
    const numbered = splitNumberedItems(trimmed)
    if (numbered) {
      if (numbered.intro) {
        elements.push(
          <p key={key++} className="mb-2">
            {renderRichText(numbered.intro)}
          </p>
        )
      }
      for (const item of numbered.items) {
        elements.push(
          <div key={key++} className="flex gap-2 mb-2">
            <span className="font-semibold text-gray-500 shrink-0">
              {item.num}.
            </span>
            <span>{renderRichText(item.text)}</span>
          </div>
        )
      }
      continue
    }

    // Chronology: "1947: event. 1960: event."
    const chrono = splitChronology(trimmed)
    if (chrono) {
      if (chrono.intro) {
        elements.push(
          <p key={key++} className="mb-2">
            {renderRichText(chrono.intro)}
          </p>
        )
      }
      for (const item of chrono.dates) {
        elements.push(
          <div key={key++} className="flex gap-2 mb-2">
            <strong className="font-semibold text-[#1A1A1A] shrink-0">
              {item.year}&thinsp;:
            </strong>
            <span><FormulaText text={item.text} /></span>
          </div>
        )
      }
      continue
    }

    // Rule 2: dash list items
    if (trimmed.startsWith('- ') || trimmed.startsWith('— ')) {
      elements.push(
        <div key={key++} className="flex gap-2 mb-1.5">
          <span className="text-gray-400 shrink-0">&#8226;</span>
          <span>{renderRichText(trimmed.slice(2))}</span>
        </div>
      )
      continue
    }

    // Rule 4: split long text into sentences for readability
    const sentences = splitSentences(trimmed)
    for (const sentence of sentences) {
      elements.push(
        <p key={key++} className="mb-1.5">
          {renderRichText(sentence)}
        </p>
      )
    }
  }

  return elements
}

function FlashcardCard({ card }: { card: Flashcard }) {
  const [flipped, setFlipped] = useState(false)
  const color = getCategoryColor(card.category)

  return (
    <div
      className="perspective cursor-pointer group"
      onClick={() => setFlipped(!flipped)}
    >
      <div
        className={`flip-card-inner min-h-[220px] ${flipped ? 'flipped' : ''}`}
      >
        {/* Front — Question */}
        <div
          className="flip-card-front rounded-xl shadow-md group-hover:shadow-lg transition-shadow duration-300"
          style={{ borderLeft: `5px solid ${color}` }}
        >
          <div className="h-full bg-white rounded-xl flex flex-col p-6">
            <span
              className="inline-block self-start text-xs font-semibold px-3 py-1 rounded-full mb-4"
              style={{
                backgroundColor: `${color}15`,
                color: color,
              }}
            >
              {card.category}
            </span>
            <div className="flex-1 flex items-center">
              <p className="text-[17px] font-semibold text-[#1A1A1A] leading-relaxed">
                <FormulaText text={card.question} />
              </p>
            </div>
            <div className="flex items-center justify-center gap-1.5 text-xs text-gray-400 mt-4">
              <RotateCcw className="w-3 h-3" />
              <span>Cliquer pour révéler</span>
            </div>
          </div>
        </div>

        {/* Back — Answer */}
        <div
          className="flip-card-back rounded-xl shadow-md group-hover:shadow-lg transition-shadow duration-300"
          style={{ borderLeft: `5px solid ${color}` }}
        >
          <div
            className="h-full rounded-xl flex flex-col p-6 overflow-y-auto"
            style={{ backgroundColor: `${color}08` }}
          >
            <span
              className="inline-block self-start text-xs font-semibold px-3 py-1 rounded-full mb-4"
              style={{
                backgroundColor: `${color}15`,
                color: color,
              }}
            >
              {card.category}
            </span>
            <div className="text-[15px] text-[#374151] leading-[1.6]">
              {formatAnswer(card.answer)}
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default function FlashcardGrid({ flashcards }: FlashcardGridProps) {
  return (
    <div>
      <p className="text-sm text-muted mb-6">
        {flashcards.length} flashcard{flashcards.length > 1 ? 's' : ''} — Clique sur une carte pour révéler la réponse
      </p>
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {flashcards.map((card) => (
          <FlashcardCard key={card.id} card={card} />
        ))}
      </div>
    </div>
  )
}
