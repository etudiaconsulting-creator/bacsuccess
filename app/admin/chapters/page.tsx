import { createServerSupabaseClient } from '@/lib/supabase/server'
import ChaptersClient from './ChaptersClient'

export default async function AdminChaptersPage() {
  const supabase = await createServerSupabaseClient()

  const [{ data: chapters }, { data: subjects }] = await Promise.all([
    supabase.from('chapters').select('*, subjects(name)').order('display_order'),
    supabase.from('subjects').select('id, name').order('name'),
  ])

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return <ChaptersClient chapters={(chapters ?? []) as any[]} subjects={(subjects ?? []) as any[]} />
}
