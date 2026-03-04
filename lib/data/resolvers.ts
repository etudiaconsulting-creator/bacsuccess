import { notFound } from 'next/navigation'
import { SupabaseClient } from '@supabase/supabase-js'
import { createServerSupabaseClient } from '@/lib/supabase/server'

async function getClient(supabase?: SupabaseClient) {
  return supabase ?? await createServerSupabaseClient()
}

export async function resolveCountry(slug: string, supabase?: SupabaseClient) {
  const sb = await getClient(supabase)
  const { data } = await sb
    .from('countries')
    .select('*')
    .eq('slug', slug)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveSeries(countryId: string, slug: string, supabase?: SupabaseClient) {
  const sb = await getClient(supabase)
  const { data } = await sb
    .from('series')
    .select('*')
    .eq('slug', slug)
    .eq('country_id', countryId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveSubject(seriesId: string, slug: string, supabase?: SupabaseClient) {
  const sb = await getClient(supabase)
  const { data } = await sb
    .from('subjects')
    .select('*')
    .eq('slug', slug)
    .eq('series_id', seriesId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveChapter(subjectId: string, slug: string, supabase?: SupabaseClient) {
  const sb = await getClient(supabase)
  const { data } = await sb
    .from('chapters')
    .select('*')
    .eq('slug', slug)
    .eq('subject_id', subjectId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveFiche(chapterId: string, slug: string, supabase?: SupabaseClient) {
  const sb = await getClient(supabase)
  const { data } = await sb
    .from('fiches')
    .select('*')
    .eq('slug', slug)
    .eq('chapter_id', chapterId)
    .eq('is_published', true)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveFullPath(params: {
  country: string
  series?: string
  subject?: string
  chapter?: string
  fiche?: string
}) {
  const supabase = await createServerSupabaseClient()

  const country = await resolveCountry(params.country, supabase)
  if (!params.series) return { country, supabase }

  const series = await resolveSeries(country.id, params.series, supabase)
  if (!params.subject) return { country, series, supabase }

  const subject = await resolveSubject(series.id, params.subject, supabase)
  if (!params.chapter) return { country, series, subject, supabase }

  const chapter = await resolveChapter(subject.id, params.chapter, supabase)
  if (!params.fiche) return { country, series, subject, chapter, supabase }

  const fiche = await resolveFiche(chapter.id, params.fiche, supabase)
  return { country, series, subject, chapter, fiche, supabase }
}
