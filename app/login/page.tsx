'use client'

import { useState } from 'react'
import { useRouter } from 'next/navigation'
import Link from 'next/link'
import { GraduationCap, Mail, Lock, Eye, EyeOff, BookOpen, Brain, Target, CheckCircle, Layers } from 'lucide-react'
import { createClient } from '@/lib/supabase/client'

const benefits = [
  {
    icon: BookOpen,
    title: 'Flashcards interactives',
    description: 'Mémorise les notions clés avec des cartes recto-verso',
  },
  {
    icon: Brain,
    title: 'Schémas de synthèse',
    description: 'Visualise et comprends les concepts en un coup d\'oeil',
  },
  {
    icon: Target,
    title: 'Quiz d\'entraînement',
    description: 'Teste tes connaissances et identifie tes lacunes',
  },
  {
    icon: Layers,
    title: '8 matières couvertes',
    description: 'Éco, Compta, Philo, Droit, Maths, Français, Histoire-Géo, Anglais',
  },
  {
    icon: CheckCircle,
    title: 'Programme officiel du Bac',
    description: 'Contenu aligné sur le programme TSECO du Bac malien',
  },
]

export default function LoginPage() {
  const router = useRouter()
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)

  async function handleEmailLogin(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)

    const supabase = createClient()
    const { error } = await supabase.auth.signInWithPassword({ email, password })

    if (error) {
      setError(
        error.message === 'Invalid login credentials'
          ? 'Email ou mot de passe incorrect.'
          : error.message
      )
      setLoading(false)
      return
    }

    router.push('/')
    router.refresh()
  }

  return (
    <div className="flex min-h-screen bg-background">
      {/* Left — Benefits */}
      <div className="hidden lg:flex lg:w-1/2 flex-col justify-center bg-primary px-12 xl:px-20">
        <div className="max-w-lg">
          <div className="inline-flex items-center gap-2 mb-6">
            <GraduationCap className="h-10 w-10 text-secondary" />
            <span className="font-serif text-3xl font-bold text-white">
              BacSuccess
            </span>
          </div>
          <h1 className="font-serif text-3xl xl:text-4xl font-bold text-white leading-tight mb-4">
            Réussis ton Bac avec des fiches de révision interactives
          </h1>
          <p className="text-white/70 text-lg mb-10">
            La plateforme gratuite pour les élèves de Terminale au Mali.
          </p>

          <div className="space-y-5">
            {benefits.map((b) => (
              <div key={b.title} className="flex items-start gap-4">
                <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-white/10">
                  <b.icon className="h-5 w-5 text-secondary" />
                </div>
                <div>
                  <p className="font-semibold text-white">{b.title}</p>
                  <p className="text-sm text-white/60">{b.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>
      </div>

      {/* Right — Login form */}
      <div className="flex w-full lg:w-1/2 flex-col items-center justify-center px-4 py-12">
        <div className="w-full max-w-md">
          {/* Mobile logo */}
          <div className="mb-8 text-center lg:hidden">
            <div className="inline-flex items-center gap-2">
              <GraduationCap className="h-8 w-8 text-secondary" />
              <span className="font-serif text-2xl font-bold text-primary">
                BacSuccess
              </span>
            </div>
            <p className="mt-2 text-muted">Connecte-toi pour réviser</p>
          </div>

          {/* Desktop heading */}
          <div className="mb-8 hidden lg:block">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              Content de te revoir !
            </h2>
            <p className="mt-1 text-muted">Connecte-toi pour accéder à tes fiches</p>
          </div>

          {/* Card */}
          <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm">
            <form onSubmit={handleEmailLogin} className="space-y-4">
              {error && (
                <div className="rounded-lg border border-red-200 bg-red-50 p-3 text-sm text-red-700">
                  {error}
                </div>
              )}

              <div>
                <label htmlFor="email" className="mb-1 block text-sm font-medium text-foreground">
                  Email
                </label>
                <div className="relative">
                  <Mail className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted" />
                  <input
                    id="email"
                    type="email"
                    value={email}
                    onChange={(e) => setEmail(e.target.value)}
                    required
                    className="w-full rounded-xl border border-gray-200 bg-white py-3 pl-10 pr-4 text-foreground placeholder:text-muted focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                    placeholder="ton@email.com"
                  />
                </div>
              </div>

              <div>
                <label htmlFor="password" className="mb-1 block text-sm font-medium text-foreground">
                  Mot de passe
                </label>
                <div className="relative">
                  <Lock className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-muted" />
                  <input
                    id="password"
                    type={showPassword ? 'text' : 'password'}
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    required
                    minLength={6}
                    className="w-full rounded-xl border border-gray-200 bg-white py-3 pl-10 pr-12 text-foreground placeholder:text-muted focus:border-primary focus:outline-none focus:ring-1 focus:ring-primary"
                    placeholder="Ton mot de passe"
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-muted hover:text-foreground cursor-pointer"
                  >
                    {showPassword ? <EyeOff className="h-4 w-4" /> : <Eye className="h-4 w-4" />}
                  </button>
                </div>
              </div>

              <button
                type="submit"
                disabled={loading}
                className="w-full rounded-xl bg-primary py-3 font-semibold text-white transition-colors hover:bg-primary-light disabled:opacity-50 cursor-pointer"
              >
                {loading ? 'Connexion...' : 'Se connecter'}
              </button>
            </form>
          </div>

          {/* Signup link */}
          <p className="mt-6 text-center text-sm text-muted">
            Pas encore de compte ?{' '}
            <Link href="/signup" className="font-semibold text-primary hover:underline">
              Créer un compte
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}
