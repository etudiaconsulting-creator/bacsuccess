import Link from 'next/link'
import type { Metadata } from 'next'
import { GraduationCap, ArrowRight } from 'lucide-react'
import Header from '@/components/layout/Header'
import Footer from '@/components/layout/Footer'
import { createServerSupabaseClient } from '@/lib/supabase/server'
import type { Country } from '@/lib/supabase/types'

export const metadata: Metadata = {
  title: 'BacSuccess - Réussis ton Bac. Point final.',
  description:
    'Plateforme gratuite de révision pour le baccalauréat africain. Fiches de révision, quiz interactifs et schémas pour réussir ton Bac au Mali, Sénégal et plus.',
}

export default async function HomePage() {
  const supabase = await createServerSupabaseClient()

  const { data: countries } = await supabase
    .from('countries')
    .select('*')
    .order('is_active', { ascending: false })
    .order('name')

  const countryList: Country[] = countries ?? []

  return (
    <div className="flex min-h-screen flex-col bg-background">
      <Header />

      <main className="flex-1">
        {/* Hero Section */}
        <section className="relative overflow-hidden bg-primary px-4 py-16 sm:px-6 sm:py-24 lg:px-8">
          <div className="mx-auto max-w-4xl text-center">
            <div className="mb-6 inline-flex items-center gap-2 rounded-full bg-secondary px-4 py-1.5 text-sm font-semibold text-primary">
              <GraduationCap className="h-4 w-4" />
              Gratuit pendant la bêta
            </div>
            <h1 className="font-serif text-4xl font-bold tracking-tight text-white sm:text-5xl lg:text-6xl">
              BacSuccess
            </h1>
            <p className="mx-auto mt-4 max-w-2xl text-lg text-gray-300 sm:text-xl">
              Réussis ton Bac. Point final.
            </p>
          </div>
        </section>

        {/* Stats Section */}
        <section className="border-b border-gray-200 bg-white px-4 py-12 sm:px-6 lg:px-8">
          <div className="mx-auto max-w-4xl text-center">
            <div className="grid grid-cols-1 gap-8 sm:grid-cols-2">
              <div className="rounded-xl border border-red-200 bg-red-50 p-6">
                <p className="text-3xl font-bold text-red-600 sm:text-4xl">27%</p>
                <p className="mt-2 text-sm text-red-700">
                  de réussite au bac Mali 2024
                </p>
              </div>
              <div className="rounded-xl border border-green-200 bg-green-50 p-6">
                <p className="text-3xl font-bold text-green-600 sm:text-4xl">80%+</p>
                <p className="mt-2 text-sm text-green-700">
                  Notre objectif avec BacSuccess
                </p>
              </div>
            </div>
          </div>
        </section>

        {/* Country Cards */}
        <section className="px-4 py-12 sm:px-6 sm:py-16 lg:px-8">
          <div className="mx-auto max-w-6xl">
            <h2 className="mb-8 text-center font-serif text-2xl font-bold text-foreground sm:text-3xl">
              Choisis ton pays
            </h2>
            <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 lg:grid-cols-3">
              {countryList.map((country) => (
                <div key={country.id} className="relative">
                  {country.is_active ? (
                    <Link
                      href={`/${country.slug}`}
                      className="group flex items-center gap-4 rounded-xl border border-gray-200 bg-white p-6 shadow-sm transition-all hover:border-primary hover:shadow-md"
                    >
                      <span className="text-4xl">{country.flag_emoji}</span>
                      <div className="flex-1">
                        <h3 className="font-semibold text-foreground group-hover:text-primary">
                          {country.name}
                        </h3>
                        <p className="mt-1 text-sm text-muted">
                          Commencer les révisions
                        </p>
                      </div>
                      <ArrowRight className="h-5 w-5 text-muted transition-transform group-hover:translate-x-1 group-hover:text-primary" />
                    </Link>
                  ) : (
                    <div className="relative flex items-center gap-4 rounded-xl border border-gray-200 bg-white p-6 opacity-60">
                      <span className="text-4xl">{country.flag_emoji}</span>
                      <div className="flex-1">
                        <h3 className="font-semibold text-foreground">
                          {country.name}
                        </h3>
                      </div>
                      <span className="rounded-full bg-gray-100 px-3 py-1 text-xs font-medium text-muted">
                        Bientôt
                      </span>
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </section>
      </main>

      <Footer />
    </div>
  )
}
