import { createServerSupabaseClient } from '@/lib/supabase/server'
import SubjectsClient from './SubjectsClient'

export default async function AdminSubjectsPage() {
  const supabase = await createServerSupabaseClient()

  const [{ data: subjects }, { data: series }] = await Promise.all([
    supabase.from('subjects').select('*, series(short_name, countries(name))').order('name'),
    supabase.from('series').select('id, short_name, countries(name)').order('short_name'),
  ])

  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return <SubjectsClient subjects={(subjects ?? []) as any[]} series={(series ?? []) as any[]} />
}
