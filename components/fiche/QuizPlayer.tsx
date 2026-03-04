'use client'

import { useState, useCallback, useRef } from 'react'
import { usePathname } from 'next/navigation'
import { Lightbulb, HelpCircle, MessageCircle, Layers } from 'lucide-react'
import type { QuizQuestion } from '@/lib/supabase/types'
import FormulaText from '@/components/ui/FormulaText'
import { updateQuizScore } from '@/lib/progress'
import { trackEvent } from '@/lib/analytics'

interface QuizPlayerProps {
  questions: QuizQuestion[]
  ficheTitle?: string
  ficheId?: string
}

function getScoreMessage(percentage: number): string {
  if (percentage === 100) return 'Parfait ! Tu maîtrises ce chapitre !'
  if (percentage >= 80) return 'Excellent, continue comme ça !'
  if (percentage >= 60) return 'Bon travail ! Revois quelques notions.'
  if (percentage >= 40) return 'Tu progresses, continue à réviser !'
  if (percentage >= 20) return 'Pas de panique, révise les flashcards et réessaie !'
  return "C'est le début ! Commence par lire les flashcards, tu vas y arriver !"
}

function getScoreColor(percentage: number): string {
  if (percentage === 100) return 'text-green-600'
  if (percentage >= 70) return 'text-blue-600'
  if (percentage >= 50) return 'text-orange-500'
  return 'text-red-500'
}

/** Fisher-Yates shuffle for questions and their options */
function shuffleQuestions(questions: QuizQuestion[]): QuizQuestion[] {
  const arr = [...questions]
  for (let i = arr.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [arr[i], arr[j]] = [arr[j], arr[i]]
  }
  return arr.map((q) => {
    const indices = q.options.map((_, i) => i)
    for (let i = indices.length - 1; i > 0; i--) {
      const j = Math.floor(Math.random() * (i + 1));
      [indices[i], indices[j]] = [indices[j], indices[i]]
    }
    return {
      ...q,
      options: indices.map((i) => q.options[i]),
      correct: indices.indexOf(q.correct),
    }
  })
}

export default function QuizPlayer({ questions, ficheTitle, ficheId }: QuizPlayerProps) {
  const pathname = usePathname()
  const [shuffledQuestions, setShuffledQuestions] = useState(() => shuffleQuestions(questions))
  const [currentIndex, setCurrentIndex] = useState(0)
  const [selectedAnswer, setSelectedAnswer] = useState<number | null>(null)
  const [showResult, setShowResult] = useState(false)
  const [score, setScore] = useState(0)
  const [isFinished, setIsFinished] = useState(false)
  const scoreSavedRef = useRef(false)

  const totalQuestions = shuffledQuestions.length
  const currentQuestion = shuffledQuestions[currentIndex]
  const progress = ((currentIndex + (isFinished ? 1 : 0)) / totalQuestions) * 100
  const percentage = totalQuestions > 0 ? Math.round((score / totalQuestions) * 100) : 0

  function handleSelect(optionIndex: number) {
    if (showResult) return

    setSelectedAnswer(optionIndex)
    setShowResult(true)

    if (optionIndex === currentQuestion.correct) {
      setScore((prev) => prev + 1)
    }
  }

  function handleNext() {
    if (currentIndex < totalQuestions - 1) {
      setCurrentIndex((prev) => prev + 1)
      setSelectedAnswer(null)
      setShowResult(false)
    } else {
      setIsFinished(true)
      // Save quiz score — score is already updated by handleSelect
      const pct = Math.round((score / totalQuestions) * 100)
      trackEvent('quiz_completed', {
        score: pct,
        title: ficheTitle ?? '',
        total_questions: totalQuestions,
      })
      if (ficheId && !scoreSavedRef.current) {
        scoreSavedRef.current = true
        updateQuizScore(ficheId, pct)
      }
    }
  }

  const handleRestart = useCallback(() => {
    setShuffledQuestions(shuffleQuestions(questions))
    setCurrentIndex(0)
    setSelectedAnswer(null)
    setShowResult(false)
    setScore(0)
    setIsFinished(false)
    scoreSavedRef.current = false
  }, [questions])

  function getButtonStyle(optionIndex: number): string {
    const base =
      'w-full text-left px-5 py-4 rounded-xl border-2 font-medium transition-all duration-200'

    if (!showResult) {
      return `${base} border-gray-200 bg-white hover:border-primary hover:bg-primary/5 text-foreground cursor-pointer`
    }

    if (optionIndex === currentQuestion.correct) {
      return `${base} border-green-500 bg-green-50 text-green-800`
    }

    if (optionIndex === selectedAnswer && optionIndex !== currentQuestion.correct) {
      return `${base} border-red-500 bg-red-50 text-red-800`
    }

    return `${base} border-gray-200 bg-gray-50 text-muted`
  }

  if (totalQuestions === 0) {
    return (
      <div className="flex flex-col items-center justify-center rounded-xl border border-dashed border-gray-300 bg-white px-6 py-16 text-center">
        <HelpCircle className="mb-4 h-12 w-12 text-muted" />
        <h2 className="text-lg font-semibold text-foreground">Le quiz est en cours de préparation !</h2>
      </div>
    )
  }

  // Score screen
  if (isFinished) {
    return (
      <div className="max-w-xl mx-auto text-center py-12">
        <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-10">
          <p className="text-muted text-sm font-medium mb-2 uppercase tracking-wide">
            Résultat du quiz
          </p>
          <p className={`text-7xl font-bold mb-3 ${getScoreColor(percentage)}`}>
            {percentage}%
          </p>
          <p className="text-foreground text-xl font-semibold mb-2">
            {getScoreMessage(percentage)}
          </p>
          <p className="text-muted mb-8">
            {score} bonne{score > 1 ? 's' : ''} réponse{score > 1 ? 's' : ''} sur{' '}
            {totalQuestions}
          </p>
          <div className="flex flex-col items-center gap-3">
            <button
              onClick={handleRestart}
              className="inline-flex items-center gap-2 px-8 py-3 rounded-xl bg-primary text-white font-semibold hover:bg-primary-light transition-colors cursor-pointer"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                className="h-5 w-5"
                viewBox="0 0 20 20"
                fill="currentColor"
              >
                <path
                  fillRule="evenodd"
                  d="M4 2a1 1 0 011 1v2.101a7.002 7.002 0 0111.601 2.566 1 1 0 11-1.885.666A5.002 5.002 0 005.999 7H9a1 1 0 010 2H4a1 1 0 01-1-1V3a1 1 0 011-1zm.008 9.057a1 1 0 011.276.61A5.002 5.002 0 0014.001 13H11a1 1 0 110-2h5a1 1 0 011 1v5a1 1 0 11-2 0v-2.101a7.002 7.002 0 01-11.601-2.566 1 1 0 01.61-1.276z"
                  clipRule="evenodd"
                />
              </svg>
              Recommencer
            </button>
            {percentage < 60 && (
              <a
                href="?tab=flashcards"
                className="inline-flex items-center gap-2 px-6 py-2.5 rounded-xl border border-gray-200 bg-white text-foreground font-medium hover:bg-gray-50 transition-colors"
              >
                <Layers className="h-4 w-4" />
                Revoir les flashcards
              </a>
            )}
            {ficheTitle && (
              <a
                href={`https://wa.me/?text=${encodeURIComponent(`J'ai obtenu ${percentage}% au quiz "${ficheTitle}" sur BacSuccess ! Teste-toi aussi : https://bacsuccess.vercel.app${pathname}`)}`}
                target="_blank"
                rel="noopener noreferrer"
                className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-sm font-semibold text-white transition-colors hover:opacity-90"
                style={{ backgroundColor: '#25D366' }}
              >
                <MessageCircle className="h-4 w-4" />
                Partager mon score
              </a>
            )}
          </div>
        </div>
      </div>
    )
  }

  // Quiz question screen
  return (
    <div className="max-w-xl mx-auto">
      {/* Progress bar */}
      <div className="mb-6">
        <div className="flex justify-between text-sm text-muted mb-2">
          <span>
            Question {currentIndex + 1} sur {totalQuestions}
          </span>
          <span>{Math.round(progress)}%</span>
        </div>
        <div className="w-full h-2.5 bg-gray-200 rounded-full overflow-hidden">
          <div
            className="h-full bg-primary rounded-full transition-all duration-500 ease-out"
            style={{ width: `${progress}%` }}
          />
        </div>
      </div>

      {/* Question card */}
      <div className="bg-white rounded-2xl shadow-lg border border-gray-200 p-8 mb-6">
        <p className="text-foreground text-lg font-semibold leading-relaxed mb-8">
          <FormulaText text={currentQuestion.question} />
        </p>

        {/* Options */}
        <div className="flex flex-col gap-3">
          {currentQuestion.options.map((option, i) => (
            <button
              key={i}
              onClick={() => handleSelect(i)}
              disabled={showResult}
              className={getButtonStyle(i)}
            >
              <span className="flex items-center gap-3">
                <span className="flex-shrink-0 w-8 h-8 rounded-full border-2 border-current flex items-center justify-center text-sm font-bold opacity-60">
                  {String.fromCharCode(65 + i)}
                </span>
                <span className="flex-1"><FormulaText text={option} /></span>
                {showResult && i === currentQuestion.correct && (
                  <svg
                    xmlns="http://www.w3.org/2000/svg"
                    className="h-6 w-6 text-green-600 flex-shrink-0"
                    viewBox="0 0 20 20"
                    fill="currentColor"
                  >
                    <path
                      fillRule="evenodd"
                      d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z"
                      clipRule="evenodd"
                    />
                  </svg>
                )}
                {showResult &&
                  i === selectedAnswer &&
                  i !== currentQuestion.correct && (
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      className="h-6 w-6 text-red-600 flex-shrink-0"
                      viewBox="0 0 20 20"
                      fill="currentColor"
                    >
                      <path
                        fillRule="evenodd"
                        d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z"
                        clipRule="evenodd"
                      />
                    </svg>
                  )}
              </span>
            </button>
          ))}
        </div>
      </div>

      {/* Explanation + Next button */}
      {showResult && (
        <div className="space-y-4">
          <div className="bg-blue-50 border border-blue-200 rounded-xl p-5">
            <p className="text-sm font-semibold text-blue-800 mb-1 flex items-center gap-1.5">
              <Lightbulb className="w-4 h-4" />
              Explication
            </p>
            <p className="text-blue-900 text-sm leading-relaxed">
              <FormulaText text={currentQuestion.explanation} />
            </p>
          </div>
          <button
            onClick={handleNext}
            className="w-full py-3.5 rounded-xl bg-primary text-white font-semibold hover:bg-primary-light transition-colors cursor-pointer"
          >
            {currentIndex < totalQuestions - 1 ? 'Suivant' : 'Voir le résultat'}
          </button>
        </div>
      )}
    </div>
  )
}
