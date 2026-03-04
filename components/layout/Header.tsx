import Link from 'next/link'
import { GraduationCap } from 'lucide-react'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import UserMenu from '@/components/layout/UserMenu'
import ThemeToggle from '@/components/ui/ThemeToggle'

export default async function Header() {
  const supabase = await createServerSupabaseClient()
  const { data: { session } } = await supabase.auth.getSession()

  return (
    <header className="sticky top-0 z-50 bg-primary shadow-md dark:bg-gray-900 dark:shadow-lg">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-4 py-3 sm:px-6 lg:px-8">
        <Link href="/" className="flex items-center gap-2">
          <GraduationCap className="h-7 w-7 text-secondary" />
          <span className="font-serif text-xl font-bold text-white sm:text-2xl">
            BacSuccess
          </span>
          <span className="rounded-full bg-secondary px-2 py-0.5 text-xs font-semibold text-primary dark:text-gray-900">
            Beta
          </span>
        </Link>

        <div className="flex items-center gap-2">
          <ThemeToggle />
          {session?.user && <UserMenu email={session.user.email ?? ''} />}
        </div>
      </div>
    </header>
  )
}
