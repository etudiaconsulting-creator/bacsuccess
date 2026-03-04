import Link from 'next/link'
import type { Metadata } from 'next'
import {
  TrendingUp,
  Calculator,
  Brain,
  Scale,
  Sigma,
  BookOpen,
  Globe,
  Languages,
  BookMarked,
  Dna,
  Zap,
  FlaskConical,
  Landmark,
  Dumbbell,
  PenLine,
  Compass,
  Users,
  ScrollText,
  Globe2,
  Ruler,
  MessageCircle,
} from 'lucide-react'
import type { LucideIcon } from 'lucide-react'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import ProgressBar from '@/components/progress/ProgressBar'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { resolveFullPath } from '@/lib/data/resolvers'
import { getSubjectProgress } from '@/lib/progress'

const ICON_MAP: Record<string, LucideIcon> = {
  TrendingUp,
  Calculator,
  Brain,
  Scale,
  Sigma,
  BookOpen,
  Globe,
  Languages,
  Dna,
  Zap,
  FlaskConical,
  Landmark,
  Dumbbell,
  PenLine,
  Compass,
  Users,
  ScrollText,
  Globe2,
  Ruler,
  MessageCircle,
}

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
  dessin: '#6B7280',
  linguistique: '#EC4899',
  anglaisLv2: '#6366F1',
}

interface PageProps {
  params: Promise<{ country: string; series: string }>
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { country: countrySlug, series: seriesSlug } = await params
  const supabase = await createServerSupabaseClient()

  const { data: country } = await supabase
    .from('countries')
    .select('name, flag_emoji')
    .eq('slug', countrySlug)
    .single()

  const { data: series } = await supabase
    .from('series')
    .select('short_name, name')
    .eq('slug', seriesSlug)
    .single()

  if (!country || !series) {
    return { title: 'Non trouvé - BacSuccess' }
  }

  return {
    title: `${series.short_name} - Matières | BacSuccess ${country.name}`,
    description: `Toutes les matières de la série ${series.short_name} (${series.name}) pour le baccalauréat ${country.name}. Révise avec des fiches, quiz et schémas.`,
  }
}

export default async function DashboardPage({ params }: PageProps) {
  const { country: countrySlug, series: seriesSlug } = await params

  const { country, series, supabase } = await resolveFullPath({ country: countrySlug, series: seriesSlug })
  const { data: { session } } = await supabase.auth.getSession()

  const { data: subjectsRaw } = await supabase
    .rpc('get_subjects_with_counts', { p_series_id: series.id })

  // Fetch user progress if logged in
  const progress = session?.user
    ? await getSubjectProgress(session.user.id, series.id, supabase)
    : {}

  const subjectList = ((subjectsRaw ?? []) as Array<{
    id: string; series_id: string; slug: string; name: string;
    coefficient: number; hours_per_week: number | null; color: string | null;
    icon: string | null; display_order: number; created_at: string;
    chapter_count: number; fiche_count: number;
  }>).map((s) => ({
    ...s,
    chapterCount: Number(s.chapter_count),
    ficheCount: Number(s.fiche_count),
  }))

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <Breadcrumb
            items={[
              { label: country.name, href: `/${countrySlug}` },
              { label: series.short_name },
            ]}
          />

          <div className="py-8">
            <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
              Tes matières - {series.short_name}
            </h1>
            <p className="mt-2 text-muted">
              {series.name}
            </p>
          </div>

          <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
            {subjectList.map((subject) => {
              const colorKey = subject.color ?? ''
              const subjectColor = SUBJECT_COLORS[colorKey] ?? '#6B7280'
              const IconComponent = ICON_MAP[subject.icon ?? ''] ?? BookMarked

              return (
                <Link
                  key={subject.id}
                  href={`/${countrySlug}/${seriesSlug}/${subject.slug}`}
                  className="group flex flex-col rounded-xl border border-gray-200 bg-white shadow-sm transition-all hover:shadow-md"
                  style={{ borderLeftWidth: '4px', borderLeftColor: subjectColor }}
                >
                  <div className="p-6">
                    <div className="flex items-start justify-between">
                      <div
                        className="flex h-10 w-10 items-center justify-center rounded-lg"
                        style={{ backgroundColor: `${subjectColor}15` }}
                      >
                        <IconComponent
                          className="h-5 w-5"
                          style={{ color: subjectColor }}
                        />
                      </div>
                      <span
                        className="rounded-full px-2.5 py-0.5 text-xs font-bold text-white"
                        style={{ backgroundColor: subjectColor }}
                      >
                        Coef. {subject.coefficient}
                      </span>
                    </div>
                    <h2 className="mt-4 font-semibold text-foreground group-hover:text-primary">
                      {subject.name}
                    </h2>
                    <div className="mt-3 flex items-center gap-4 text-xs text-muted">
                      <span>{subject.chapterCount} chapitre{subject.chapterCount !== 1 ? 's' : ''}</span>
                      <span>{subject.ficheCount} fiche{subject.ficheCount !== 1 ? 's' : ''}</span>
                    </div>
                    {progress[subject.id] && progress[subject.id].viewedFiches > 0 && (
                      <ProgressBar
                        viewed={progress[subject.id].viewedFiches}
                        total={progress[subject.id].totalFiches}
                        color={subjectColor}
                        avgScore={progress[subject.id].avgQuizScore}
                      />
                    )}
                  </div>
                </Link>
              )
            })}
          </div>
        </div>
      </main>

      <Footer />
    </div>
  )
}
