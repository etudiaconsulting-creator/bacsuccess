import { createServerSupabaseClient } from '@/lib/supabase/server'
import Header from './Header'

export default async function AuthHeader() {
  const supabase = await createServerSupabaseClient()
  const { data: { session } } = await supabase.auth.getSession()
  return <Header userEmail={session?.user?.email ?? undefined} />
}
