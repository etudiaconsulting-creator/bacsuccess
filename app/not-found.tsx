import Link from 'next/link'
import { BookOpen, Home } from 'lucide-react'

export default function NotFound() {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background px-4">
      <div className="text-center">
        <BookOpen className="mx-auto h-16 w-16 text-secondary" />
        <h1 className="mt-6 font-serif text-4xl font-bold text-foreground">
          Oups ! Cette page n&apos;existe pas
        </h1>
        <p className="mt-4 max-w-md text-muted">
          La page que tu cherches a peut-être été déplacée ou n&apos;existe plus.
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
