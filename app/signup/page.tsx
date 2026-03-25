'use client'

import { Suspense, useState } from 'react'
import { useSearchParams } from 'next/navigation'
import Link from 'next/link'
import { Mail, Lock, Eye, EyeOff } from 'lucide-react'
import { createClient } from '@/lib/supabase/client'
import AuthLayout from '@/components/auth/AuthLayout'

function SignupForm() {
  const searchParams = useSearchParams()
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

    const redirect = searchParams.get('redirect')
    const safeRedirect = redirect && redirect.startsWith('/') ? redirect : '/'
    const confirmUrl = `${window.location.origin}/auth/confirm?next=${encodeURIComponent(safeRedirect)}`

    const supabase = createClient()
    const { error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        emailRedirectTo: confirmUrl,
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
            <Link href="/login" className="font-semibold text-primary dark:text-emerald-400 hover:underline">
              Retour à la connexion
            </Link>
          </p>
        </div>
      </div>
    )
  }

  return (
    <AuthLayout
      title="Crée ton compte gratuitement"
      subtitle="Commence à réviser en quelques secondes"
    >
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
            className="w-full rounded-xl bg-primary py-3 font-semibold text-white transition-colors hover:bg-primary-dark disabled:opacity-50 cursor-pointer"
          >
            {loading ? 'Inscription...' : 'Créer mon compte'}
          </button>
        </form>
      </div>

      {/* Login link */}
      <p className="mt-6 text-center text-sm text-muted">
        Déjà un compte ?{' '}
        <Link href="/login" className="font-semibold text-primary dark:text-emerald-400 hover:underline">
          Se connecter
        </Link>
      </p>
    </AuthLayout>
  )
}

export default function SignupPage() {
  return (
    <Suspense>
      <SignupForm />
    </Suspense>
  )
}
