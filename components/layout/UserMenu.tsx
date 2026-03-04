'use client'

import { useRouter } from 'next/navigation'
import { LogOut, User } from 'lucide-react'
import { createClient } from '@/lib/supabase/client'

interface UserMenuProps {
  email: string
}

export default function UserMenu({ email }: UserMenuProps) {
  const router = useRouter()

  async function handleLogout() {
    const supabase = createClient()
    await supabase.auth.signOut()
    router.push('/login')
    router.refresh()
  }

  return (
    <div className="flex items-center gap-3">
      <div className="flex items-center gap-2 text-sm text-gray-300">
        <User className="h-4 w-4" />
        <span className="hidden sm:inline max-w-[180px] truncate">{email}</span>
      </div>
      <button
        onClick={handleLogout}
        className="rounded-lg bg-white/10 px-3 py-1.5 text-sm font-medium text-white transition-colors hover:bg-white/20 cursor-pointer"
        title="Se déconnecter"
      >
        <LogOut className="h-4 w-4" />
      </button>
    </div>
  )
}
