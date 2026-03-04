'use client'

import { Suspense } from 'react'
import { useSearchParams, useRouter } from 'next/navigation'
import { Layers, GitBranch, HelpCircle } from 'lucide-react'
import FlashcardGrid from '@/components/fiche/FlashcardGrid'
import SchemaView from '@/components/fiche/SchemaView'
import QuizPlayer from '@/components/fiche/QuizPlayer'
import type { Flashcard, SchemaContent, QuizQuestion } from '@/lib/supabase/types'

interface FicheTabsProps {
  flashcards: Flashcard[]
  schema: SchemaContent
  questions: QuizQuestion[]
  ficheTitle?: string
}

type TabKey = 'flashcards' | 'schema' | 'quiz'

const TABS: { key: TabKey; label: string; icon: typeof Layers }[] = [
  { key: 'flashcards', label: 'Flashcards', icon: Layers },
  { key: 'schema', label: 'Schema', icon: GitBranch },
  { key: 'quiz', label: 'Quiz', icon: HelpCircle },
]

const VALID_TABS = new Set<string>(['flashcards', 'schema', 'quiz'])

function FicheTabsInner({ flashcards, schema, questions, ficheTitle }: FicheTabsProps) {
  const searchParams = useSearchParams()
  const router = useRouter()

  const tabParam = searchParams.get('tab')
  const activeTab: TabKey = tabParam && VALID_TABS.has(tabParam) ? (tabParam as TabKey) : 'flashcards'

  function setActiveTab(tab: TabKey) {
    const params = new URLSearchParams(searchParams.toString())
    params.set('tab', tab)
    router.replace(`?${params.toString()}`, { scroll: false })
  }

  return (
    <div>
      {/* Tab buttons */}
      <div className="flex gap-1 rounded-xl bg-gray-100 p-1">
        {TABS.map((tab) => {
          const Icon = tab.icon
          const isActive = activeTab === tab.key

          return (
            <button
              key={tab.key}
              onClick={() => setActiveTab(tab.key)}
              className={`flex flex-1 items-center justify-center gap-2 rounded-lg px-4 py-2.5 text-sm font-medium transition-all cursor-pointer ${
                isActive
                  ? 'bg-primary text-white shadow-sm'
                  : 'text-muted hover:bg-gray-200 hover:text-foreground'
              }`}
            >
              <Icon className="h-4 w-4" />
              <span className="hidden sm:inline">{tab.label}</span>
            </button>
          )
        })}
      </div>

      {/* Tab content */}
      <div className="mt-6">
        {activeTab === 'flashcards' && <FlashcardGrid flashcards={flashcards} />}
        {activeTab === 'schema' && <SchemaView schema={schema} />}
        {activeTab === 'quiz' && <QuizPlayer questions={questions} ficheTitle={ficheTitle} />}
      </div>
    </div>
  )
}

export default function FicheTabs(props: FicheTabsProps) {
  return (
    <Suspense>
      <FicheTabsInner {...props} />
    </Suspense>
  )
}
