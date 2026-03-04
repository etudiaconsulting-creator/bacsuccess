import { redirect } from 'next/navigation'
import Link from 'next/link'
import type { Metadata } from 'next'
import { Lock, Unlock, BookOpen } from 'lucide-react'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { resolveFullPath } from '@/lib/data/resolvers'

interface PageProps {
  params: Promise<{ country: string; series: string; subject: string; chapter: string }>
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { country: countrySlug, series: seriesSlug, subject: subjectSlug, chapter: chapterSlug } = await params
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

  const { data: chapter } = await supabase
    .from('chapters')
    .select('title, number')
    .eq('slug', chapterSlug)
    .single()

  if (!country || !series || !subject || !chapter) {
    return { title: 'Non trouvé - BacSuccess' }
  }

  return {
    title: `Chapitre ${chapter.number}: ${chapter.title} - ${subject.name} | BacSuccess`,
    description: `Fiches de révision du chapitre ${chapter.number}: ${chapter.title} en ${subject.name} pour la série ${series.short_name}. BacSuccess ${country.name}.`,
  }
}

export default async function ChapterPage({ params }: PageProps) {
  const { country: countrySlug, series: seriesSlug, subject: subjectSlug, chapter: chapterSlug } = await params

  const { country, series, subject, chapter, supabase } = await resolveFullPath({ country: countrySlug, series: seriesSlug, subject: subjectSlug, chapter: chapterSlug })
  const { data: fiches } = await supabase
    .from('fiches')
    .select('*')
    .eq('chapter_id', chapter.id)
    .eq('is_published', true)
    .order('display_order')

  const ficheList = fiches ?? []

  if (ficheList.length === 1) {
    redirect(`/${countrySlug}/${seriesSlug}/${subjectSlug}/${chapterSlug}/${ficheList[0].slug}`)
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
              { label: chapter.title },
            ]}
          />

          <div className="py-8">
            <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
              Chapitre {chapter.number}: {chapter.title}
            </h1>
            {chapter.description && (
              <p className="mt-2 text-muted">{chapter.description}</p>
            )}
          </div>

          {ficheList.length === 0 ? (
            <div className="flex flex-col items-center justify-center rounded-xl border border-dashed border-gray-300 bg-white px-6 py-16 text-center">
              <BookOpen className="mb-4 h-12 w-12 text-muted" />
              <h2 className="text-lg font-semibold text-foreground">
                Fiches en cours de création
              </h2>
              <p className="mt-2 max-w-sm text-sm text-muted">
                Les fiches de révision pour ce chapitre seront bientôt disponibles. Reviens vite !
              </p>
            </div>
          ) : (
            <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
              {ficheList.map((fiche) => (
                <Link
                  key={fiche.id}
                  href={`/${countrySlug}/${seriesSlug}/${subjectSlug}/${chapterSlug}/${fiche.slug}`}
                  className="group flex flex-col rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-all hover:border-primary hover:shadow-md"
                >
                  <div className="flex items-start justify-between gap-2">
                    <h2 className="font-semibold text-foreground group-hover:text-primary">
                      {fiche.title}
                    </h2>
                    {fiche.is_free ? (
                      <span className="flex items-center gap-1 rounded-full bg-green-100 px-2.5 py-0.5 text-xs font-medium text-green-800">
                        <Unlock className="h-3 w-3" />
                        Gratuit
                      </span>
                    ) : (
                      <span className="flex items-center gap-1 rounded-full bg-secondary/20 px-2.5 py-0.5 text-xs font-medium text-secondary">
                        <Lock className="h-3 w-3" />
                        Premium
                      </span>
                    )}
                  </div>
                  {fiche.subtitle && (
                    <p className="mt-2 text-sm text-muted line-clamp-2">
                      {fiche.subtitle}
                    </p>
                  )}
                </Link>
              ))}
            </div>
          )}
        </div>
      </main>

      <Footer />
    </div>
  )
}
