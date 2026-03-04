'use client'

import { GraduationCap, RefreshCw } from 'lucide-react'

export default function Error({
  reset,
}: {
  error: Error & { digest?: string }
  reset: () => void
}) {
  return (
    <div className="flex min-h-screen flex-col items-center justify-center bg-background px-4">
      <div className="text-center">
        <GraduationCap className="mx-auto h-16 w-16 text-secondary" />
        <h1 className="mt-6 font-serif text-3xl font-bold text-foreground">
          Une erreur est survenue
        </h1>
        <p className="mt-4 max-w-md text-muted">
          Quelque chose s&apos;est mal passé. Réessaie dans quelques instants.
        </p>
        <button
          onClick={reset}
          className="mt-8 inline-flex items-center gap-2 rounded-xl bg-primary px-6 py-3 font-semibold text-white transition-colors hover:bg-primary-light cursor-pointer"
        >
          <RefreshCw className="h-4 w-4" />
          Réessayer
        </button>
      </div>
    </div>
  )
}
