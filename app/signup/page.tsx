'use client'

import { useState } from 'react'
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

export default function SignupPage() {
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')
  const [showPassword, setShowPassword] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [loading, setLoading] = useState(false)
  const [confirmationSent, setConfirmationSent] = useState(false)

  async function handleEmailSignup(e: React.FormEvent) {
    e.preventDefault()
    setLoading(true)
    setError(null)

    const supabase = createClient()
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: `${window.location.origin}/auth/confirm`,
      },
    })

    if (error) {
      setError(error.message)
      setLoading(false)
      return
    }

    setConfirmationSent(true)
    setLoading(false)
  }

  if (confirmationSent) {
    return (
      <div className="flex min-h-screen flex-col items-center justify-center bg-background px-4">
        <div className="w-full max-w-md text-center">
          <div className="rounded-2xl border border-gray-200 bg-white p-10 shadow-sm">
            <Mail className="mx-auto h-12 w-12 text-secondary" />
            <h2 className="mt-4 font-serif text-xl font-bold text-foreground">
              Vérifie ton email
            </h2>
            <p className="mt-3 text-muted">
              Un lien de confirmation a été envoyé à{' '}
              <strong className="text-foreground">{email}</strong>.
              Clique dessus pour activer ton compte.
            </p>
          </div>
          <p className="mt-6 text-sm text-muted">
            <Link href="/login" className="font-semibold text-primary hover:underline">
              Retour à la connexion
            </Link>
          </p>
        </div>
      </div>
    )
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

      {/* Right — Signup form */}
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
            <p className="mt-2 text-muted">Crée ton compte pour commencer</p>
          </div>

          {/* Desktop heading */}
          <div className="mb-8 hidden lg:block">
            <h2 className="font-serif text-2xl font-bold text-foreground">
              Crée ton compte gratuitement
            </h2>
            <p className="mt-1 text-muted">Commence à réviser en quelques secondes</p>
          </div>

          {/* Card */}
          <div className="rounded-2xl border border-gray-200 bg-white p-8 shadow-sm">
            <form onSubmit={handleEmailSignup} className="space-y-4">
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
                    placeholder="Minimum 6 caractères"
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
                {loading ? 'Inscription...' : 'Créer mon compte'}
              </button>
            </form>
          </div>

          {/* Login link */}
          <p className="mt-6 text-center text-sm text-muted">
            Déjà un compte ?{' '}
            <Link href="/login" className="font-semibold text-primary hover:underline">
              Se connecter
            </Link>
          </p>
        </div>
      </div>
    </div>
  )
}
