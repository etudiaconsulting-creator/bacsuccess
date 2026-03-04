import Link from 'next/link'
import { GraduationCap, LayoutDashboard, Globe, Layers, BookOpen, FileText, Folder } from 'lucide-react'

const NAV_ITEMS = [
  { label: 'Dashboard', href: '/admin', icon: LayoutDashboard },
  { label: 'Pays', href: '/admin/countries', icon: Globe },
  { label: 'Séries', href: '/admin/series', icon: Layers },
  { label: 'Matières', href: '/admin/subjects', icon: BookOpen },
  { label: 'Chapitres', href: '/admin/chapters', icon: Folder },
  { label: 'Fiches', href: '/admin/fiches', icon: FileText },
]

export default function AdminLayout({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex min-h-screen bg-gray-50 dark:bg-gray-900">
      {/* Sidebar */}
      <aside className="fixed inset-y-0 left-0 z-40 w-64 border-r border-gray-200 bg-white dark:bg-gray-800 dark:border-gray-700">
        <div className="flex h-16 items-center gap-2 border-b border-gray-200 px-6 dark:border-gray-700">
          <GraduationCap className="h-6 w-6 text-secondary" />
          <span className="font-serif text-lg font-bold text-foreground">
            Admin
          </span>
        </div>

        <nav className="mt-4 space-y-1 px-3">
          {NAV_ITEMS.map((item) => {
            const Icon = item.icon
            return (
              <Link
                key={item.href}
                href={item.href}
                className="flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm font-medium text-muted transition-colors hover:bg-gray-100 hover:text-foreground dark:hover:bg-gray-700"
              >
                <Icon className="h-4 w-4" />
                {item.label}
              </Link>
            )
          })}
        </nav>

        <div className="absolute bottom-4 left-0 right-0 px-6">
          <Link
            href="/"
            className="flex items-center gap-2 text-sm text-muted hover:text-foreground transition-colors"
          >
            ← Retour au site
          </Link>
        </div>
      </aside>

      {/* Main content */}
      <main className="ml-64 flex-1 p-8">
        {children}
      </main>
    </div>
  )
}
