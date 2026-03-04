'use client'

import { useState, useEffect, useCallback, useMemo } from 'react'
import { Clock, Flag, ChevronLeft, ChevronRight, CheckCircle2, XCircle, AlertTriangle, Trophy, RotateCcw, ArrowLeft } from 'lucide-react'
import type { QuizQuestion } from '@/lib/supabase/types'
import FormulaText from '@/components/ui/FormulaText'
import Link from 'next/link'
import { usePathname } from 'next/navigation'

interface ExamQuestion extends QuizQuestion {
  chapterTitle: string
  chapterNumber: number
  ficheTitle: string
}

interface ExamPlayerProps {
  questions: ExamQuestion[]
  subjectName: string
  subjectColor?: string
}

type ExamPhase = 'setup' | 'exam' | 'results'

const SUBJECT_COLORS: Record<string, string> = {
  eco: '#2563EB',
  compta: '#059669',
  philo: '#7C3AED',
  droit: '#DC2626',
  maths: '#EA580C',
  francais: '#0891B2',
  histgeo: '#CA8A04',
  anglais: '#4F46E5',
  svt: '#059669',
  physique: '#2563EB',
  chimie: '#7C3AED',
  ecm: '#CA8A04',
  eps: '#EA580C',
  sociologie: '#8B5CF6',
  histoire: '#B45309',
  geographie: '#059669',
}

function shuffleArray<T>(arr: T[]): T[] {
  const shuffled = [...arr]
  for (let i = shuffled.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [shuffled[i], shuffled[j]] = [shuffled[j], shuffled[i]]
  }
  return shuffled
}

function formatTime(seconds: number): string {
  const m = Math.floor(seconds / 60)
  const s = seconds % 60
  return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`
}

export default function ExamPlayer({ questions, subjectName, subjectColor }: ExamPlayerProps) {
  const pathname = usePathname()
  const backHref = pathname.replace(/\/exam$/, '')
  const color = subjectColor ? (SUBJECT_COLORS[subjectColor] ?? '#1B4332') : '#1B4332'

  const [phase, setPhase] = useState<ExamPhase>('setup')
  const [questionCount, setQuestionCount] = useState(Math.min(20, questions.length))
  const [durationMinutes, setDurationMinutes] = useState(30)

  // Exam state
  const [examQuestions, setExamQuestions] = useState<ExamQuestion[]>([])
  const [currentIndex, setCurrentIndex] = useState(0)
  const [answers, setAnswers] = useState<Record<number, number>>({})
  const [flagged, setFlagged] = useState<Set<number>>(new Set())
  const [timeLeft, setTimeLeft] = useState(0)

  // Shuffled options mapping: for each question index, maps new option index to original option index
  const [optionMaps, setOptionMaps] = useState<number[][]>([])

  const totalQuestions = examQuestions.length

  function startExam() {
    // Shuffle and pick questions
    const shuffled = shuffleArray(questions)
    const selected = shuffled.slice(0, questionCount)

    // Shuffle options for each question
    const maps: number[][] = []
    const remapped = selected.map((q) => {
      const indices = q.options.map((_, i) => i)
      const shuffledIndices = shuffleArray(indices)
      maps.push(shuffledIndices)
      return {
        ...q,
        options: shuffledIndices.map((i) => q.options[i]),
        correct: shuffledIndices.indexOf(q.correct),
      }
    })

    setExamQuestions(remapped)
    setOptionMaps(maps)
    setAnswers({})
    setFlagged(new Set())
    setCurrentIndex(0)
    setTimeLeft(durationMinutes * 60)
    setPhase('exam')
  }

  // Timer
  useEffect(() => {
    if (phase !== 'exam') return
    if (timeLeft <= 0) {
      setPhase('results')
      return
    }

    const timer = setInterval(() => {
      setTimeLeft((prev) => {
        if (prev <= 1) {
          setPhase('results')
          return 0
        }
        return prev - 1
      })
    }, 1000)

    return () => clearInterval(timer)
  }, [phase, timeLeft])

  function selectAnswer(questionIndex: number, optionIndex: number) {
    setAnswers((prev) => ({ ...prev, [questionIndex]: optionIndex }))
  }

  function toggleFlag(questionIndex: number) {
    setFlagged((prev) => {
      const next = new Set(prev)
      if (next.has(questionIndex)) {
        next.delete(questionIndex)
      } else {
        next.add(questionIndex)
      }
      return next
    })
  }

  function finishExam() {
    setPhase('results')
  }

  // Results computation
  const results = useMemo(() => {
    if (phase !== 'results') return null

    let correct = 0
    let incorrect = 0
    let unanswered = 0

    const details: {
      question: ExamQuestion
      selectedAnswer: number | undefined
      isCorrect: boolean
      chapterTitle: string
      chapterNumber: number
    }[] = []

    for (let i = 0; i < examQuestions.length; i++) {
      const q = examQuestions[i]
      const answer = answers[i]

      if (answer === undefined) {
        unanswered++
        details.push({ question: q, selectedAnswer: undefined, isCorrect: false, chapterTitle: q.chapterTitle, chapterNumber: q.chapterNumber })
      } else if (answer === q.correct) {
        correct++
        details.push({ question: q, selectedAnswer: answer, isCorrect: true, chapterTitle: q.chapterTitle, chapterNumber: q.chapterNumber })
      } else {
        incorrect++
        details.push({ question: q, selectedAnswer: answer, isCorrect: false, chapterTitle: q.chapterTitle, chapterNumber: q.chapterNumber })
      }
    }

    const percentage = totalQuestions > 0 ? Math.round((correct / totalQuestions) * 100) : 0

    // Group by chapter
    const byChapter: Record<string, { title: string; number: number; correct: number; total: number }> = {}
    for (const d of details) {
      const key = d.chapterTitle
      if (!byChapter[key]) {
        byChapter[key] = { title: d.chapterTitle, number: d.chapterNumber, correct: 0, total: 0 }
      }
      byChapter[key].total++
      if (d.isCorrect) byChapter[key].correct++
    }

    return { correct, incorrect, unanswered, percentage, details, byChapter: Object.values(byChapter).sort((a, b) => a.number - b.number) }
  }, [phase, examQuestions, answers, totalQuestions])

  // SETUP PHASE
  if (phase === 'setup') {
    const maxQuestions = questions.length

    if (maxQuestions === 0) {
      return (
        <div className="py-16 text-center">
          <AlertTriangle className="mx-auto mb-4 h-12 w-12 text-muted" />
          <h2 className="text-lg font-semibold text-foreground">Pas assez de questions</h2>
          <p className="mt-2 text-sm text-muted">
            Il n&apos;y a pas encore de quiz disponibles pour cette matière.
          </p>
          <Link
            href={backHref}
            className="mt-6 inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 font-semibold text-white hover:bg-primary-light transition-colors"
          >
            <ArrowLeft className="h-4 w-4" />
            Retour aux chapitres
          </Link>
        </div>
      )
    }

    return (
      <div className="py-8">
        <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
          Mode Examen - {subjectName}
        </h1>
        <p className="mt-2 text-muted">
          Configure ton examen blanc multi-chapitres
        </p>

        <div className="mt-8 max-w-lg mx-auto">
          <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-8 space-y-6">
            {/* Question count */}
            <div>
              <label className="block text-sm font-semibold text-foreground mb-2">
                Nombre de questions
              </label>
              <div className="flex items-center gap-4">
                <input
                  type="range"
                  min={5}
                  max={Math.min(50, maxQuestions)}
                  step={5}
                  value={questionCount}
                  onChange={(e) => setQuestionCount(Number(e.target.value))}
                  className="flex-1 accent-primary"
                />
                <span className="text-lg font-bold text-foreground w-12 text-center">
                  {questionCount}
                </span>
              </div>
              <p className="text-xs text-muted mt-1">{maxQuestions} questions disponibles</p>
            </div>

            {/* Duration */}
            <div>
              <label className="block text-sm font-semibold text-foreground mb-2">
                Durée (minutes)
              </label>
              <div className="flex gap-2">
                {[15, 30, 45, 60].map((mins) => (
                  <button
                    key={mins}
                    onClick={() => setDurationMinutes(mins)}
                    className={`flex-1 rounded-lg px-4 py-2.5 text-sm font-medium transition-all cursor-pointer ${
                      durationMinutes === mins
                        ? 'bg-primary text-white shadow-sm'
                        : 'bg-gray-100 text-foreground hover:bg-gray-200'
                    }`}
                  >
                    {mins} min
                  </button>
                ))}
              </div>
            </div>

            {/* Info */}
            <div className="bg-blue-50 border border-blue-200 rounded-xl p-4 text-sm text-blue-800">
              <p className="font-semibold mb-1">Comment ça marche ?</p>
              <ul className="space-y-1 text-blue-700">
                <li>• Les questions sont mélangées de tous les chapitres</li>
                <li>• Tu peux naviguer entre les questions librement</li>
                <li>• Marque les questions pour y revenir plus tard</li>
                <li>• Le chronomètre t&apos;alerte quand le temps est presque écoulé</li>
              </ul>
            </div>

            {/* Start button */}
            <button
              onClick={startExam}
              className="w-full rounded-xl py-4 text-lg font-bold text-white transition-colors hover:opacity-90 cursor-pointer"
              style={{ backgroundColor: color }}
            >
              Commencer l&apos;examen
            </button>
          </div>
        </div>
      </div>
    )
  }

  // EXAM PHASE
  if (phase === 'exam') {
    const currentQuestion = examQuestions[currentIndex]
    const answeredCount = Object.keys(answers).length
    const isTimeLow = timeLeft <= 60
    const progress = ((answeredCount) / totalQuestions) * 100

    return (
      <div className="py-6">
        {/* Top bar: timer + progress */}
        <div className="flex items-center justify-between mb-4">
          <div className={`flex items-center gap-2 text-lg font-bold ${isTimeLow ? 'text-red-600 animate-pulse' : 'text-foreground'}`}>
            <Clock className="h-5 w-5" />
            {formatTime(timeLeft)}
          </div>
          <div className="text-sm text-muted">
            {answeredCount}/{totalQuestions} répondu{answeredCount > 1 ? 'es' : 'e'}
          </div>
        </div>

        {/* Progress bar */}
        <div className="h-2 w-full rounded-full bg-gray-200 overflow-hidden mb-6">
          <div
            className="h-full rounded-full transition-all duration-300"
            style={{ width: `${progress}%`, backgroundColor: color }}
          />
        </div>

        <div className="flex gap-6">
          {/* Main content area */}
          <div className="flex-1 min-w-0">
            {/* Question card */}
            <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-8 mb-6">
              <div className="flex items-start justify-between mb-6">
                <div>
                  <span className="text-xs text-muted uppercase tracking-wide">
                    Question {currentIndex + 1} sur {totalQuestions}
                  </span>
                  <span className="mx-2 text-gray-300">•</span>
                  <span className="text-xs text-muted">
                    Ch. {currentQuestion.chapterNumber}: {currentQuestion.chapterTitle}
                  </span>
                </div>
                <button
                  onClick={() => toggleFlag(currentIndex)}
                  className={`p-2 rounded-lg transition-colors cursor-pointer ${
                    flagged.has(currentIndex)
                      ? 'bg-amber-100 text-amber-600'
                      : 'bg-gray-100 text-gray-400 hover:text-amber-500 hover:bg-amber-50'
                  }`}
                  title={flagged.has(currentIndex) ? 'Retirer le drapeau' : 'Marquer pour revenir'}
                >
                  <Flag className="h-4 w-4" />
                </button>
              </div>

              <p className="text-foreground text-lg font-semibold leading-relaxed mb-8">
                <FormulaText text={currentQuestion.question} />
              </p>

              {/* Options */}
              <div className="flex flex-col gap-3">
                {currentQuestion.options.map((option, i) => {
                  const isSelected = answers[currentIndex] === i
                  return (
                    <button
                      key={i}
                      onClick={() => selectAnswer(currentIndex, i)}
                      className={`w-full text-left px-5 py-4 rounded-xl border-2 font-medium transition-all cursor-pointer ${
                        isSelected
                          ? 'border-primary bg-primary/5 text-foreground'
                          : 'border-gray-200 bg-white hover:border-gray-300 hover:bg-gray-50 text-foreground'
                      }`}
                    >
                      <span className="flex items-center gap-3">
                        <span className={`flex-shrink-0 w-8 h-8 rounded-full border-2 flex items-center justify-center text-sm font-bold ${
                          isSelected ? 'border-primary bg-primary text-white' : 'border-gray-300 opacity-60'
                        }`}>
                          {String.fromCharCode(65 + i)}
                        </span>
                        <span className="flex-1"><FormulaText text={option} /></span>
                      </span>
                    </button>
                  )
                })}
              </div>
            </div>

            {/* Navigation */}
            <div className="flex items-center justify-between">
              <button
                onClick={() => setCurrentIndex((prev) => Math.max(0, prev - 1))}
                disabled={currentIndex === 0}
                className="flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-medium transition-colors cursor-pointer disabled:opacity-40 disabled:cursor-not-allowed bg-gray-100 text-foreground hover:bg-gray-200"
              >
                <ChevronLeft className="h-4 w-4" />
                Précédent
              </button>

              {currentIndex < totalQuestions - 1 ? (
                <button
                  onClick={() => setCurrentIndex((prev) => Math.min(totalQuestions - 1, prev + 1))}
                  className="flex items-center gap-2 px-4 py-2.5 rounded-xl text-sm font-medium transition-colors cursor-pointer bg-primary text-white hover:bg-primary-light"
                >
                  Suivant
                  <ChevronRight className="h-4 w-4" />
                </button>
              ) : (
                <button
                  onClick={finishExam}
                  className="flex items-center gap-2 px-6 py-2.5 rounded-xl text-sm font-bold transition-colors cursor-pointer text-white hover:opacity-90"
                  style={{ backgroundColor: color }}
                >
                  <CheckCircle2 className="h-4 w-4" />
                  Terminer
                </button>
              )}
            </div>
          </div>

          {/* Question navigator (desktop) */}
          <div className="hidden lg:block w-56 flex-shrink-0">
            <div className="sticky top-20 bg-white rounded-xl border border-gray-200 shadow-sm p-4">
              <p className="text-xs font-semibold text-muted uppercase tracking-wide mb-3">
                Navigation
              </p>
              <div className="grid grid-cols-5 gap-1.5">
                {examQuestions.map((_, i) => {
                  const isAnswered = answers[i] !== undefined
                  const isFlagged = flagged.has(i)
                  const isCurrent = i === currentIndex

                  return (
                    <button
                      key={i}
                      onClick={() => setCurrentIndex(i)}
                      className={`relative w-full aspect-square rounded-lg text-xs font-bold transition-all cursor-pointer flex items-center justify-center ${
                        isCurrent
                          ? 'ring-2 ring-primary ring-offset-1'
                          : ''
                      } ${
                        isAnswered
                          ? 'bg-primary/10 text-primary'
                          : 'bg-gray-100 text-gray-500 hover:bg-gray-200'
                      }`}
                    >
                      {i + 1}
                      {isFlagged && (
                        <Flag className="absolute -top-1 -right-1 h-3 w-3 text-amber-500" />
                      )}
                    </button>
                  )
                })}
              </div>

              <div className="mt-4 pt-3 border-t border-gray-200 space-y-1.5 text-xs text-muted">
                <div className="flex items-center gap-2">
                  <span className="w-3 h-3 rounded bg-primary/10" />
                  <span>Répondu</span>
                </div>
                <div className="flex items-center gap-2">
                  <span className="w-3 h-3 rounded bg-gray-100" />
                  <span>Non répondu</span>
                </div>
                <div className="flex items-center gap-2">
                  <Flag className="h-3 w-3 text-amber-500" />
                  <span>Marqué</span>
                </div>
              </div>

              {answeredCount === totalQuestions && (
                <button
                  onClick={finishExam}
                  className="mt-4 w-full rounded-lg py-2.5 text-sm font-bold text-white transition-colors cursor-pointer hover:opacity-90"
                  style={{ backgroundColor: color }}
                >
                  Terminer
                </button>
              )}
            </div>
          </div>
        </div>
      </div>
    )
  }

  // RESULTS PHASE
  if (phase === 'results' && results) {
    const { correct, incorrect, unanswered, percentage, details, byChapter } = results

    function getScoreColor(pct: number): string {
      if (pct >= 80) return 'text-green-600'
      if (pct >= 60) return 'text-blue-600'
      if (pct >= 40) return 'text-orange-500'
      return 'text-red-500'
    }

    function getScoreMessage(pct: number): string {
      if (pct === 100) return 'Parfait ! Tu es prêt(e) pour le Bac !'
      if (pct >= 80) return 'Excellent ! Continue comme ça !'
      if (pct >= 60) return 'Bon travail ! Quelques révisions et ce sera parfait.'
      if (pct >= 40) return 'Tu progresses ! Revois les chapitres faibles.'
      return 'Continue à réviser, tu vas y arriver !'
    }

    return (
      <div className="py-8">
        {/* Score header */}
        <div className="max-w-xl mx-auto text-center mb-8">
          <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-10">
            <Trophy className="mx-auto h-12 w-12 text-secondary mb-4" />
            <p className="text-muted text-sm font-medium mb-2 uppercase tracking-wide">
              Résultat de l&apos;examen - {subjectName}
            </p>
            <p className={`text-7xl font-bold mb-3 ${getScoreColor(percentage)}`}>
              {percentage}%
            </p>
            <p className="text-foreground text-xl font-semibold mb-2">
              {getScoreMessage(percentage)}
            </p>
            <p className="text-muted mb-2">
              {correct} bonne{correct > 1 ? 's' : ''} réponse{correct > 1 ? 's' : ''} sur {totalQuestions}
            </p>
            <div className="flex items-center justify-center gap-4 text-sm">
              <span className="flex items-center gap-1 text-green-600">
                <CheckCircle2 className="h-4 w-4" /> {correct} correcte{correct > 1 ? 's' : ''}
              </span>
              <span className="flex items-center gap-1 text-red-500">
                <XCircle className="h-4 w-4" /> {incorrect} incorrecte{incorrect > 1 ? 's' : ''}
              </span>
              {unanswered > 0 && (
                <span className="flex items-center gap-1 text-gray-400">
                  <AlertTriangle className="h-4 w-4" /> {unanswered} sans réponse
                </span>
              )}
            </div>
          </div>
        </div>

        {/* Performance by chapter */}
        <div className="max-w-2xl mx-auto mb-8">
          <h2 className="font-serif text-xl font-bold text-foreground mb-4">
            Performance par chapitre
          </h2>
          <div className="space-y-3">
            {byChapter.map((ch) => {
              const pct = ch.total > 0 ? Math.round((ch.correct / ch.total) * 100) : 0
              return (
                <div key={ch.title} className="bg-white rounded-xl border border-gray-200 p-4">
                  <div className="flex items-center justify-between mb-2">
                    <span className="text-sm font-semibold text-foreground">
                      Ch. {ch.number}: {ch.title}
                    </span>
                    <span className={`text-sm font-bold ${getScoreColor(pct)}`}>
                      {pct}% ({ch.correct}/{ch.total})
                    </span>
                  </div>
                  <div className="h-2 w-full rounded-full bg-gray-200 overflow-hidden">
                    <div
                      className="h-full rounded-full transition-all"
                      style={{
                        width: `${pct}%`,
                        backgroundColor: pct >= 60 ? '#059669' : pct >= 40 ? '#EA580C' : '#DC2626',
                      }}
                    />
                  </div>
                </div>
              )
            })}
          </div>
        </div>

        {/* Detailed review */}
        <div className="max-w-2xl mx-auto mb-8">
          <h2 className="font-serif text-xl font-bold text-foreground mb-4">
            Détail des réponses
          </h2>
          <div className="space-y-4">
            {details.map((d, i) => (
              <div
                key={i}
                className={`bg-white rounded-xl border p-5 ${
                  d.isCorrect ? 'border-green-200' : 'border-red-200'
                }`}
              >
                <div className="flex items-start gap-3 mb-3">
                  {d.isCorrect ? (
                    <CheckCircle2 className="h-5 w-5 text-green-600 mt-0.5 flex-shrink-0" />
                  ) : (
                    <XCircle className="h-5 w-5 text-red-500 mt-0.5 flex-shrink-0" />
                  )}
                  <div className="flex-1 min-w-0">
                    <p className="text-xs text-muted mb-1">
                      Ch. {d.chapterNumber} • Question {i + 1}
                    </p>
                    <p className="font-semibold text-foreground">
                      <FormulaText text={d.question.question} />
                    </p>
                  </div>
                </div>

                {d.selectedAnswer !== undefined && !d.isCorrect && (
                  <p className="text-sm text-red-600 ml-8 mb-1">
                    Ta réponse : <FormulaText text={d.question.options[d.selectedAnswer]} />
                  </p>
                )}
                {d.selectedAnswer === undefined && (
                  <p className="text-sm text-gray-400 ml-8 mb-1 italic">
                    Pas de réponse
                  </p>
                )}
                <p className="text-sm text-green-700 ml-8 mb-2">
                  Bonne réponse : <FormulaText text={d.question.options[d.question.correct]} />
                </p>
                <div className="ml-8 bg-blue-50 border border-blue-200 rounded-lg p-3 text-sm text-blue-800">
                  <FormulaText text={d.question.explanation} />
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Actions */}
        <div className="max-w-xl mx-auto flex flex-col items-center gap-3 pb-12">
          <button
            onClick={() => {
              setPhase('setup')
              setExamQuestions([])
              setAnswers({})
              setFlagged(new Set())
            }}
            className="inline-flex items-center gap-2 px-8 py-3 rounded-xl bg-primary text-white font-semibold hover:bg-primary-light transition-colors cursor-pointer"
          >
            <RotateCcw className="h-5 w-5" />
            Refaire un examen
          </button>
          <Link
            href={backHref}
            className="inline-flex items-center gap-2 px-6 py-2.5 rounded-xl border border-gray-200 bg-white text-foreground font-medium hover:bg-gray-50 transition-colors"
          >
            <ArrowLeft className="h-4 w-4" />
            Retour aux chapitres
          </Link>
        </div>
      </div>
    )
  }

  return null
}
