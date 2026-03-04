import { Globe, Layers, BookOpen, Folder, FileText, Users } from 'lucide-react'
import { createServerSupabaseClient } from '@/lib/supabase/server'

export default async function AdminDashboard() {
  const supabase = await createServerSupabaseClient()

  // Fetch counts in parallel
  const [countries, series, subjects, chapters, fiches] = await Promise.all([
    supabase.from('countries').select('id', { count: 'exact', head: true }),
    supabase.from('series').select('id', { count: 'exact', head: true }),
    supabase.from('subjects').select('id', { count: 'exact', head: true }),
    supabase.from('chapters').select('id', { count: 'exact', head: true }),
    supabase.from('fiches').select('id', { count: 'exact', head: true }),
  ])

  const stats = [
    { label: 'Pays', count: countries.count ?? 0, icon: Globe, color: '#2563EB', href: '/admin/countries' },
    { label: 'Séries', count: series.count ?? 0, icon: Layers, color: '#7C3AED', href: '/admin/series' },
    { label: 'Matières', count: subjects.count ?? 0, icon: BookOpen, color: '#059669', href: '/admin/subjects' },
    { label: 'Chapitres', count: chapters.count ?? 0, icon: Folder, color: '#EA580C', href: '/admin/chapters' },
    { label: 'Fiches', count: fiches.count ?? 0, icon: FileText, color: '#DC2626', href: '/admin/fiches' },
  ]

  return (
    <div>
      <h1 className="font-serif text-2xl font-bold text-foreground">
        Tableau de bord
      </h1>
      <p className="mt-1 text-muted">
        Vue d&apos;ensemble de la plateforme BacSuccess
      </p>

      <div className="mt-8 grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {stats.map((stat) => {
          const Icon = stat.icon
          return (
            <a
              key={stat.label}
              href={stat.href}
              className="flex items-center gap-4 rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-all hover:shadow-md dark:bg-gray-800 dark:border-gray-700"
            >
              <div
                className="flex h-12 w-12 items-center justify-center rounded-xl"
                style={{ backgroundColor: `${stat.color}15` }}
              >
                <Icon className="h-6 w-6" style={{ color: stat.color }} />
              </div>
              <div>
                <p className="text-2xl font-bold text-foreground">{stat.count}</p>
                <p className="text-sm text-muted">{stat.label}</p>
              </div>
            </a>
          )
        })}
      </div>
    </div>
  )
}
