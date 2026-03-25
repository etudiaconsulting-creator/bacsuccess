import Link from 'next/link'
import type { Metadata } from 'next'
import { ArrowRight } from 'lucide-react'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import Breadcrumb from '@/components/layout/Breadcrumb'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import { resolveCountry } from '@/lib/data/resolvers'

interface PageProps {
  params: Promise<{ country: string }>
}

export async function generateMetadata({ params }: PageProps): Promise<Metadata> {
  const { country: countrySlug } = await params
  const supabase = await createServerSupabaseClient()

  const { data: country } = await supabase
    .from('countries')
    .select('name, flag_emoji')
    .eq('slug', countrySlug)
    .single()

  if (!country) {
    return { title: 'Pays non trouvé - BacSuccess' }
  }

  return {
    title: `${country.flag_emoji ?? ''} ${country.name} - Choisis ta série | BacSuccess`,
    description: `Choisis ta série pour le baccalauréat ${country.name}. Fiches de révision, quiz et schémas gratuits sur BacSuccess.`,
  }
}

export default async function CountryPage({ params }: PageProps) {
  const { country: countrySlug } = await params

  const country = await resolveCountry(countrySlug)

  const supabase = await createServerSupabaseClient()
  const { data: seriesList } = await supabase
    .from('series')
    .select('*')
    .eq('country_id', country.id)
    .order('name')

  const series = seriesList ?? []

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      <main className="flex-1">
        <div className="mx-auto max-w-6xl px-4 sm:px-6 lg:px-8">
          <Breadcrumb
            items={[
              { label: country.name },
            ]}
          />

          <div className="py-8">
            <h1 className="font-serif text-2xl font-bold text-foreground sm:text-3xl">
              <span className="mr-2">{country.flag_emoji}</span>
              Choisis ta série - {country.name}
            </h1>
            <p className="mt-2 text-muted">
              Sélectionne ta série pour accéder aux fiches de révision.
            </p>
          </div>

          <div className="grid grid-cols-1 gap-4 pb-12 sm:grid-cols-2 lg:grid-cols-3">
            {series.map((s) => (
              <div key={s.id} className="relative">
                {s.is_active ? (
                  <Link
                    href={`/${countrySlug}/${s.slug}`}
                    className="group flex flex-col rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-all hover:border-primary hover:shadow-md"
                  >
                    <div className="flex items-center justify-between">
                      <h2 className="text-xl font-bold text-primary dark:text-emerald-400">
                        {s.short_name}
                      </h2>
                      <ArrowRight className="h-5 w-5 text-muted transition-transform group-hover:translate-x-1 group-hover:text-primary" />
                    </div>
                    <p className="mt-2 text-sm text-foreground">{s.name}</p>
                    {s.description && (
                      <p className="mt-1 text-xs text-muted">{s.description}</p>
                    )}
                  </Link>
                ) : (
                  <div className="relative flex flex-col rounded-xl border border-gray-200 bg-white p-6 opacity-60">
                    <div className="flex items-center justify-between">
                      <h2 className="text-xl font-bold text-gray-400">
                        {s.short_name}
                      </h2>
                      <span className="rounded-full bg-gray-100 px-3 py-1 text-xs font-medium text-muted">
                        Bientôt
                      </span>
                    </div>
                    <p className="mt-2 text-sm text-foreground">{s.name}</p>
                    {s.description && (
                      <p className="mt-1 text-xs text-muted">{s.description}</p>
                    )}
                  </div>
                )}
              </div>
            ))}
          </div>
        </div>
      </main>

      <Footer />
    </div>
  )
}
