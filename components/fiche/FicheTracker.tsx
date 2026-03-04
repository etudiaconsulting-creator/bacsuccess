'use client'

import { useEffect } from 'react'
import { trackFicheView } from '@/lib/progress'
import { trackEvent } from '@/lib/analytics'

interface FicheTrackerProps {
  ficheId: string
  ficheTitle?: string
}

/**
 * Invisible component that tracks when a user views a fiche.
 * Renders nothing — fires progress tracking + analytics on mount.
 */
export default function FicheTracker({ ficheId, ficheTitle }: FicheTrackerProps) {
  useEffect(() => {
    trackFicheView(ficheId)
    trackEvent('fiche_viewed', { fiche_id: ficheId, title: ficheTitle ?? '' })
  }, [ficheId, ficheTitle])

  return null
}
