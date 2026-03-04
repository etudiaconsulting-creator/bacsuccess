import { createServerSupabaseClient } from '@/lib/supabase/server'
import SeriesClient from './SeriesClient'

export default async function AdminSeriesPage() {
  const supabase = await createServerSupabaseClient()

  const [{ data: series }, { data: countries }] = await Promise.all([
    supabase.from('series').select('*, countries(name)').order('name'),
    supabase.from('countries').select('id, name').order('name'),
  ])

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return <SeriesClient series={(series ?? []) as any[]} countries={(countries ?? []) as any[]} />
}
