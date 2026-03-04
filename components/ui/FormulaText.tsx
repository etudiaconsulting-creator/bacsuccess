'use client'

import type { ReactNode } from 'react'

interface FormulaTextProps {
  text: string
  className?: string
}

/**
 * Parses text and renders math notation:
 * - ^n or ^(expr) → superscript
 * - _ followed by digit or _(expr) → subscript
 * - " x " (space x space) → " × " when in formula context
 */
function parseFormula(text: string): ReactNode[] {
  const elements: ReactNode[] = []
  let i = 0
  let key = 0
  let buffer = ''

  const isFormulaContext = /[=^×÷+\-*/]/.test(text) || /\d/.test(text)

  function flushBuffer() {
    if (buffer) {
      // Replace " x " with " × " in formula context
      let processed = buffer
      if (isFormulaContext) {
        processed = processed.replace(/ x /g, ' × ')
      }
      elements.push(<span key={key++}>{processed}</span>)
      buffer = ''
    }
  }

  while (i < text.length) {
    // Handle caret for superscript: ^n or ^(expr)
    if (text[i] === '^') {
      flushBuffer()
      i++ // skip ^

      if (i >= text.length) break

      if (text[i] === '(') {
        // ^(expr) — read until matching closing paren
        i++ // skip (
        let depth = 1
        let superContent = ''
        while (i < text.length && depth > 0) {
          if (text[i] === '(') depth++
          else if (text[i] === ')') {
            depth--
            if (depth === 0) { i++; break }
          }
          superContent += text[i]
          i++
        }
        elements.push(
          <sup key={key++} className="text-[0.7em] align-super font-semibold">
            {superContent}
          </sup>
        )
      } else {
        // ^n — single character or number sequence
        let superContent = ''
        while (i < text.length && /[0-9a-zA-Z.]/.test(text[i])) {
          superContent += text[i]
          i++
        }
        if (!superContent) {
          // Edge case: ^ followed by non-alphanumeric
          buffer += '^'
          continue
        }
        elements.push(
          <sup key={key++} className="text-[0.7em] align-super font-semibold">
            {superContent}
          </sup>
        )
      }
      continue
    }

    // Handle underscore for subscript: _n or _(expr)
    if (text[i] === '_' && i + 1 < text.length && (/[0-9a-zA-Z(]/.test(text[i + 1]))) {
      flushBuffer()
      i++ // skip _

      if (text[i] === '(') {
        i++ // skip (
        let depth = 1
        let subContent = ''
        while (i < text.length && depth > 0) {
          if (text[i] === '(') depth++
          else if (text[i] === ')') {
            depth--
            if (depth === 0) { i++; break }
          }
          subContent += text[i]
          i++
        }
        elements.push(
          <sub key={key++} className="text-[0.7em] align-sub">
            {subContent}
          </sub>
        )
      } else {
        let subContent = ''
        while (i < text.length && /[0-9a-zA-Z]/.test(text[i])) {
          subContent += text[i]
          i++
        }
        elements.push(
          <sub key={key++} className="text-[0.7em] align-sub">
            {subContent}
          </sub>
        )
      }
      continue
    }

    buffer += text[i]
    i++
  }

  flushBuffer()
  return elements
}

export default function FormulaText({ text, className = '' }: FormulaTextProps) {
  // Split by newlines and render each line
  const lines = text.split('\n')

  if (lines.length === 1) {
    return <span className={className}>{parseFormula(text)}</span>
  }

  return (
    <span className={className}>
      {lines.map((line, i) => (
        <span key={i}>
          {parseFormula(line)}
          {i < lines.length - 1 && <br />}
        </span>
      ))}
    </span>
  )
}
