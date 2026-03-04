import { createServerSupabaseClient } from '@/lib/supabase/server'
import FichesClient from './FichesClient'

export default async function AdminFichesPage() {
  const supabase = await createServerSupabaseClient()

  const [{ data: fiches }, { data: chapters }] = await Promise.all([
    supabase.from('fiches').select('*, chapters(title, number, subjects(name))').order('display_order'),
    supabase.from('chapters').select('id, title, number, subjects(name)').order('number'),
  ])

  // Cast the joined data to the expected shape
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  return <FichesClient fiches={(fiches ?? []) as any[]} chapters={(chapters ?? []) as any[]} />
}
