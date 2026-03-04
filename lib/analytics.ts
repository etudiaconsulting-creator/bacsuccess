/**
 * Umami Analytics helper.
 *
 * Usage:
 *   trackEvent('quiz_completed', { score: 85, subject: 'Économie' })
 *   trackEvent('fiche_viewed', { fiche: 'les-agents-economiques' })
 *
 * Set NEXT_PUBLIC_UMAMI_WEBSITE_ID in .env.local to enable.
 */

declare global {
  interface Window {
    umami?: {
      track: (eventName: string, eventData?: Record<string, string | number | boolean>) => void
    }
  }
}

/**
 * Track a custom event with Umami.
 * Silently does nothing if Umami is not loaded.
 */
export function trackEvent(
  eventName: string,
  eventData?: Record<string, string | number | boolean>
): void {
  if (typeof window !== 'undefined' && window.umami) {
    window.umami.track(eventName, eventData)
  }
}
