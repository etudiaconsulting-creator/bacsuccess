import type { Metadata } from 'next'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import ExamPlayer from '@/components/exam/ExamPlayer'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { resolveFullPath } from '@/lib/data/resolvers'
import type { QuizQuestion } from '@/lib/supabase/types'

interface PageProps {
  params: Promise<{ country: string; series: string; subject: string }>
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { country: countrySlug, series: seriesSlug, subject: subjectSlug } = await params
  const supabase = await createServerSupabaseClient()

  const { data: country } = await supabase
    .from('countries')
    .select('name')
    .eq('slug', countrySlug)
    .single()

  const { data: subject } = await supabase
    .from('subjects')
    .select('name')
    .eq('slug', subjectSlug)
    .single()

  if (!country || !subject) {
    return { title: 'Examen - BacSuccess' }
  }

  return {
    title: `Examen - ${subject.name} | BacSuccess`,
    description: `Mode examen en ${subject.name}. Quiz chronométré multi-chapitres pour te préparer au baccalauréat. BacSuccess ${country.name}.`,
  }
}

export default async function ExamPage({ params }: PageProps) {
  const { country: countrySlug, series: seriesSlug, subject: subjectSlug } = await params

  const { country, series, subject, supabase } = await resolveFullPath({
    country: countrySlug,
    series: seriesSlug,
    subject: subjectSlug,
  })

  // Get all chapters for this subject
  const { data: chapters } = await supabase
    .from('chapters')
    .select('id, title, number, slug')
    .eq('subject_id', subject.id)
    .order('display_order')

  const chapterList = chapters ?? []

  // Get all published fiches with quiz questions for this subject
  const { data: fiches } = await supabase
    .from('fiches')
    .select('id, title, chapter_id, content')
    .in('chapter_id', chapterList.map((c) => c.id))
    .eq('is_published', true)
    .order('display_order')

  const ficheList = fiches ?? []

  // Extract all quiz questions, tagged with chapter info
  const allQuestions: (QuizQuestion & { chapterTitle: string; chapterNumber: number; ficheTitle: string })[] = []

  for (const fiche of ficheList) {
    const chapter = chapterList.find((c) => c.id === fiche.chapter_id)
    if (!chapter) continue

    const content = fiche.content as { quiz?: QuizQuestion[] }
    const quiz = content?.quiz ?? []

    for (const q of quiz) {
      allQuestions.push({
        ...q,
        chapterTitle: chapter.title,
        chapterNumber: chapter.number,
        ficheTitle: fiche.title,
      })
    }
  }

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <Breadcrumb
            items={[
              { label: country.name, href: `/${countrySlug}` },
              { label: series.short_name, href: `/${countrySlug}/${seriesSlug}` },
              { label: subject.name, href: `/${countrySlug}/${seriesSlug}/${subjectSlug}` },
              { label: 'Examen' },
            ]}
          />

          <ExamPlayer
            questions={allQuestions}
            subjectName={subject.name}
            subjectColor={subject.color ?? undefined}
          />
        </div>
      </main>

      <Footer />
    </div>
  )
}
