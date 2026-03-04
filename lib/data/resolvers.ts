import { notFound } from 'next/navigation'
import { createServerSupabaseClient } from '@/lib/supabase/server'

export async function resolveCountry(slug: string) {
  const supabase = await createServerSupabaseClient()
  const { data } = await supabase
    .from('countries')
    .select('*')
    .eq('slug', slug)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveSeries(countryId: string, slug: string) {
  const supabase = await createServerSupabaseClient()
  const { data } = await supabase
    .from('series')
    .select('*')
    .eq('slug', slug)
    .eq('country_id', countryId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveSubject(seriesId: string, slug: string) {
  const supabase = await createServerSupabaseClient()
  const { data } = await supabase
    .from('subjects')
    .select('*')
    .eq('slug', slug)
    .eq('series_id', seriesId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveChapter(subjectId: string, slug: string) {
  const supabase = await createServerSupabaseClient()
  const { data } = await supabase
    .from('chapters')
    .select('*')
    .eq('slug', slug)
    .eq('subject_id', subjectId)
    .single()

  if (!data) notFound()
  return data
}

export async function resolveFiche(chapterId: string, slug: string) {
  const supabase = await createServerSupabaseClient()
  const { data } = await supabase
    .from('fiches')
    .select('*')
    .eq('slug', slug)
    .eq('chapter_id', chapterId)
    .eq('is_published', true)
    .single()

  if (!data) notFound()
  return data
}
