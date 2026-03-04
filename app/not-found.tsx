import Link from 'next/link'
import { GraduationCap, Home } from 'lucide-react'

export default function NotFound() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background px-4">
      <div className="text-center">
        <GraduationCap className="mx-auto h-16 w-16 text-secondary" />
        <h1 className="mt-6 font-serif text-4xl font-bold text-foreground">
          Page introuvable
        </h1>
        <p className="mt-4 max-w-md text-muted">
          Oups, cette page n&apos;existe pas ou a été déplacée.
          Retourne à l&apos;accueil pour continuer tes révisions.
        </p>
        <Link
          href="/"
          className="mt-8 inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 font-semibold text-white transition-colors hover:bg-primary-light"
        >
          <Home className="h-4 w-4" />
          Retour à l&apos;accueil
        </Link>
      </div>
    </div>
  )
}
