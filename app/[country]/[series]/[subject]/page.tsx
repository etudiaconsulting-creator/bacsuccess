import Link from 'next/link'
import type { Metadata } from 'next'
import { FileText, ArrowRight, CheckCircle2, ClipboardList } from 'lucide-react'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import ProgressBar from '@/components/progress/ProgressBar'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { resolveFullPath } from '@/lib/data/resolvers'
import { getChapterProgress } from '@/lib/progress'

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

  const { data: series } = await supabase
    .from('series')
    .select('short_name')
    .eq('slug', seriesSlug)
    .single()

  const { data: subject } = await supabase
    .from('subjects')
    .select('name')
    .eq('slug', subjectSlug)
    .single()

  if (!country || !series || !subject) {
    return { title: 'Non trouvé - BacSuccess' }
  }

  return {
    title: `${subject.name} - ${series.short_name} | BacSuccess ${country.name}`,
    description: `Chapitres de ${subject.name} pour la série ${series.short_name}. Fiches de révision, quiz et schémas pour le baccalauréat ${country.name}.`,
  }
}

export default async function SubjectPage({ params }: PageProps) {
  const { country: countrySlug, series: seriesSlug, subject: subjectSlug } = await params

  const { country, series, subject, supabase } = await resolveFullPath({ country: countrySlug, series: seriesSlug, subject: subjectSlug })
  const { data: { session } } = await supabase.auth.getSession()

  const { data: chaptersRaw } = await supabase
    .rpc('get_chapters_with_counts', { p_subject_id: subject.id })

  // Fetch user progress if logged in
  const progress = session?.user
    ? await getChapterProgress(session.user.id, subject.id, supabase)
    : {}

  const chapterList = ((chaptersRaw ?? []) as Array<{
    id: string; subject_id: string; slug: string; number: number;
    title: string; description: string | null; display_order: number;
    created_at: string; fiche_count: number;
  }>).map((c) => ({
    ...c,
    ficheCount: Number(c.fiche_count),
  }))

  const subjectColor = subject.color ? getSubjectColor(subject.color) : '#6B7280'

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <Breadcrumb
            items={[
              { label: country.name, href: `/${countrySlug}` },
              { label: series.short_name, href: `/${countrySlug}/${seriesSlug}` },
              { label: subject.name },
            ]}
          />

          <div className="py-8">
            <div className="flex items-center gap-3">
              <div
                className="h-8 w-1.5 rounded-full"
                style={{ backgroundColor: subjectColor }}
              />
              <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
                {subject.name}
              </h1>
            </div>
            <p className="mt-2 text-muted">
              {chapterList.length} chapitre{chapterList.length !== 1 ? 's' : ''} disponible{chapterList.length !== 1 ? 's' : ''}
            </p>
            <Link
              href={`/${countrySlug}/${seriesSlug}/${subjectSlug}/exam`}
              className="mt-4 inline-flex items-center gap-2 rounded-xl px-5 py-2.5 text-sm font-semibold text-white transition-colors hover:opacity-90"
              style={{ backgroundColor: subjectColor }}
            >
              <ClipboardList className="h-4 w-4" />
              Mode Examen
            </Link>
          </div>

          <div className="flex flex-col gap-4 pb-12">
            {chapterList.map((chapter) => (
              <Link
                key={chapter.id}
                href={`/${countrySlug}/${seriesSlug}/${subjectSlug}/${chapter.slug}`}
                className="group flex items-start gap-4 rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-all hover:border-primary hover:shadow-md"
              >
                <div
                  className="flex h-10 w-10 flex-shrink-0 items-center justify-center rounded-lg font-bold text-white"
                  style={{ backgroundColor: subjectColor }}
                >
                  {chapter.number}
                </div>
                <div className="flex-1 min-w-0">
                  <h2 className="font-semibold text-foreground group-hover:text-primary">
                    {chapter.title}
                  </h2>
                  {chapter.description && (
                    <p className="mt-1 text-sm text-muted line-clamp-2">
                      {chapter.description}
                    </p>
                  )}
                  <div className="mt-2 flex items-center gap-1 text-xs text-muted">
                    <FileText className="h-3.5 w-3.5" />
                    <span>{chapter.ficheCount} fiche{chapter.ficheCount !== 1 ? 's' : ''}</span>
                    {progress[chapter.id] && progress[chapter.id].viewedFiches === progress[chapter.id].totalFiches && progress[chapter.id].totalFiches > 0 && (
                      <span className="ml-2 inline-flex items-center gap-1 text-green-600">
                        <CheckCircle2 className="h-3.5 w-3.5" />
                        <span>Terminé</span>
                      </span>
                    )}
                  </div>
                  {progress[chapter.id] && progress[chapter.id].viewedFiches > 0 && (
                    <ProgressBar
                      viewed={progress[chapter.id].viewedFiches}
                      total={progress[chapter.id].totalFiches}
                      color={subjectColor}
                      avgScore={progress[chapter.id].avgQuizScore}
                    />
                  )}
                </div>
                <ArrowRight className="h-5 w-5 flex-shrink-0 text-muted transition-transform group-hover:translate-x-1 group-hover:text-primary" />
              </Link>
            ))}
          </div>
        </div>
      </main>

      <Footer />
    </div>
  )
}

function getSubjectColor(colorKey: string): string {
  const colors: Record<string, string> = {
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
    dessin: '#6B7280',
    linguistique: '#EC4899',
    anglaisLv2: '#6366F1',
  }
  return colors[colorKey] ?? '#6B7280'
}
