import { createServerSupabaseClient } from '@/lib/supabase/server'
import CountriesClient from './CountriesClient'

export default async function AdminCountriesPage() {
  const supabase = await createServerSupabaseClient()
  const { data: countries } = await supabase
    .from('countries')
    .select('*')
    .order('name')

  return <CountriesClient countries={countries ?? []} />
}
