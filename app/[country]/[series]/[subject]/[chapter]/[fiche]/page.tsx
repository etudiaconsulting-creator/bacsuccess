import type { Metadata } from 'next'
import { notFound } from 'next/navigation'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import FicheTabs from '@/components/fiche/FicheTabs'
import { createServerSupabaseClient } from '@/lib/supabase/server'

interface PageProps {
  params: Promise<{
    country: string
    series: string
    subject: string
    chapter: string
    fiche: string
  }>
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const {
    country: countrySlug,
    series: seriesSlug,
    subject: subjectSlug,
    chapter: chapterSlug,
    fiche: ficheSlug,
  } = await params
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

  // To find the fiche, we need to resolve the chapter first
  const { data: chapter } = await supabase
    .from('chapters')
    .select('*')
    .eq('slug', chapterSlug)
    .single()

  let ficheTitle = ''
  if (chapter) {
    const { data: fiche } = await supabase
      .from('fiches')
      .select('*')
      .eq('slug', ficheSlug)
      .eq('chapter_id', chapter.id)
      .single()

    ficheTitle = fiche?.title ?? ''
  }

  if (!country || !subject || !ficheTitle) {
    return { title: 'Non trouvé - BacSuccess' }
  }

  return {
    title: `${ficheTitle} - ${subject.name} | BacSuccess`,
    description: `Fiche de révision: ${ficheTitle}. Flashcards, schéma et quiz pour réviser ${subject.name}. BacSuccess ${country.name}.`,
  }
}

export default async function FichePage({ params }: PageProps) {
  const {
    country: countrySlug,
    series: seriesSlug,
    subject: subjectSlug,
    chapter: chapterSlug,
    fiche: ficheSlug,
  } = await params
  const supabase = await createServerSupabaseClient()

  const { data: country } = await supabase
    .from('countries')
    .select('*')
    .eq('slug', countrySlug)
    .single()

  if (!country) {
    notFound()
  }

  const { data: series } = await supabase
    .from('series')
    .select('*')
    .eq('slug', seriesSlug)
    .eq('country_id', country.id)
    .single()

  if (!series) {
    notFound()
  }

  const { data: subject } = await supabase
    .from('subjects')
    .select('*')
    .eq('slug', subjectSlug)
    .eq('series_id', series.id)
    .single()

  if (!subject) {
    notFound()
  }

  const { data: chapter } = await supabase
    .from('chapters')
    .select('*')
    .eq('slug', chapterSlug)
    .eq('subject_id', subject.id)
    .single()

  if (!chapter) {
    notFound()
  }

  const { data: fiche } = await supabase
    .from('fiches')
    .select('*')
    .eq('slug', ficheSlug)
    .eq('chapter_id', chapter.id)
    .eq('is_published', true)
    .single()

  if (!fiche) {
    notFound()
  }

  const { flashcards, schema, quiz } = fiche.content

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
              { label: chapter.title, href: `/${countrySlug}/${seriesSlug}/${subjectSlug}/${chapterSlug}` },
              { label: fiche.title },
            ]}
          />

          <div className="py-8">
            <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
              {fiche.title}
            </h1>
            {fiche.subtitle && (
              <p className="mt-2 text-muted">{fiche.subtitle}</p>
            )}
          </div>

          <div className="pb-12">
            <FicheTabs
              flashcards={flashcards}
              schema={schema}
              questions={quiz}
            />
          </div>
        </div>
      </main>

      <Footer />
    </div>
  )
}
