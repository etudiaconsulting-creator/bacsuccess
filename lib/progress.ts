import { createClient } from '@/lib/supabase/client'

/**
 * Track that the current user has viewed a fiche.
 * Call this once when the fiche page loads.
 */
export async function trackFicheView(ficheId: string): Promise<void> {
  const supabase = createClient()
  const { data: { session } } = await supabase.auth.getSession()
  if (!session) return // Not logged in — skip

  await supabase.rpc('track_fiche_view', { p_fiche_id: ficheId })
}

/**
 * Update the user's quiz score for a fiche (keeps best score).
 */
export async function updateQuizScore(ficheId: string, score: number): Promise<void> {
  const supabase = createClient()
  const { data: { session } } = await supabase.auth.getSession()
  if (!session) return

  await supabase.rpc('update_quiz_score', {
    p_fiche_id: ficheId,
    p_score: score,
  })
}

/**
 * Get progress for all subjects in a series (server-side).
 */
export async function getSubjectProgress(
  userId: string,
  seriesId: string,
  supabase: ReturnType<typeof createClient>
): Promise<Record<string, { totalFiches: number; viewedFiches: number; avgQuizScore: number | null }>> {
  const { data } = await supabase.rpc('get_subject_progress', {
    p_user_id: userId,
    p_series_id: seriesId,
  })

  const result: Record<string, { totalFiches: number; viewedFiches: number; avgQuizScore: number | null }> = {}
  if (data) {
    for (const row of data as Array<{ subject_id: string; total_fiches: number; viewed_fiches: number; avg_quiz_score: number | null }>) {
      result[row.subject_id] = {
        totalFiches: Number(row.total_fiches),
        viewedFiches: Number(row.viewed_fiches),
        avgQuizScore: row.avg_quiz_score != null ? Number(row.avg_quiz_score) : null,
      }
    }
  }
  return result
}

/**
 * Get progress for all chapters in a subject (server-side).
 */
export async function getChapterProgress(
  userId: string,
  subjectId: string,
  supabase: ReturnType<typeof createClient>
): Promise<Record<string, { totalFiches: number; viewedFiches: number; avgQuizScore: number | null }>> {
  const { data } = await supabase.rpc('get_chapter_progress', {
    p_user_id: userId,
    p_subject_id: subjectId,
  })

  const result: Record<string, { totalFiches: number; viewedFiches: number; avgQuizScore: number | null }> = {}
  if (data) {
    for (const row of data as Array<{ chapter_id: string; total_fiches: number; viewed_fiches: number; avg_quiz_score: number | null }>) {
      result[row.chapter_id] = {
        totalFiches: Number(row.total_fiches),
        viewedFiches: Number(row.viewed_fiches),
        avgQuizScore: row.avg_quiz_score != null ? Number(row.avg_quiz_score) : null,
      }
    }
  }
  return result
}
