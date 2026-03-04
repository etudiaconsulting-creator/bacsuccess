-- ============================================
-- Migration 004: User Progress Tracking
-- ============================================
-- Tracks which fiches a user has viewed and their quiz scores.

-- 1. Create user_progress table
CREATE TABLE IF NOT EXISTS user_progress (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id uuid NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  fiche_id uuid NOT NULL REFERENCES fiches(id) ON DELETE CASCADE,
  viewed boolean DEFAULT false,
  viewed_at timestamptz,
  quiz_score integer CHECK (quiz_score >= 0 AND quiz_score <= 100),
  quiz_taken_at timestamptz,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now(),
  UNIQUE(user_id, fiche_id)
);

-- 2. Indexes
CREATE INDEX IF NOT EXISTS idx_user_progress_user_id ON user_progress(user_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_fiche_id ON user_progress(fiche_id);
CREATE INDEX IF NOT EXISTS idx_user_progress_user_fiche ON user_progress(user_id, fiche_id);

-- 3. RLS
ALTER TABLE user_progress ENABLE ROW LEVEL SECURITY;

-- Users can only read their own progress
CREATE POLICY "Users can read own progress"
  ON user_progress
  FOR SELECT
  USING (auth.uid() = user_id);

-- Users can insert their own progress
CREATE POLICY "Users can insert own progress"
  ON user_progress
  FOR INSERT
  WITH CHECK (auth.uid() = user_id);

-- Users can update their own progress
CREATE POLICY "Users can update own progress"
  ON user_progress
  FOR UPDATE
  USING (auth.uid() = user_id)
  WITH CHECK (auth.uid() = user_id);

-- 4. RPC: Upsert fiche view
CREATE OR REPLACE FUNCTION track_fiche_view(p_fiche_id uuid)
RETURNS void AS $$
BEGIN
  INSERT INTO user_progress (user_id, fiche_id, viewed, viewed_at)
  VALUES (auth.uid(), p_fiche_id, true, now())
  ON CONFLICT (user_id, fiche_id)
  DO UPDATE SET
    viewed = true,
    viewed_at = COALESCE(user_progress.viewed_at, now()),
    updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 5. RPC: Update quiz score (keeps best score)
CREATE OR REPLACE FUNCTION update_quiz_score(p_fiche_id uuid, p_score integer)
RETURNS void AS $$
BEGIN
  INSERT INTO user_progress (user_id, fiche_id, viewed, viewed_at, quiz_score, quiz_taken_at)
  VALUES (auth.uid(), p_fiche_id, true, now(), p_score, now())
  ON CONFLICT (user_id, fiche_id)
  DO UPDATE SET
    viewed = true,
    viewed_at = COALESCE(user_progress.viewed_at, now()),
    quiz_score = GREATEST(user_progress.quiz_score, p_score),
    quiz_taken_at = now(),
    updated_at = now();
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 6. RPC: Get progress per subject for a series
CREATE OR REPLACE FUNCTION get_subject_progress(p_user_id uuid, p_series_id uuid)
RETURNS TABLE (
  subject_id uuid,
  total_fiches bigint,
  viewed_fiches bigint,
  avg_quiz_score numeric
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id AS subject_id,
    COUNT(DISTINCT f.id) AS total_fiches,
    COUNT(DISTINCT up.fiche_id) FILTER (WHERE up.viewed = true) AS viewed_fiches,
    ROUND(AVG(up.quiz_score) FILTER (WHERE up.quiz_score IS NOT NULL), 0) AS avg_quiz_score
  FROM subjects s
  JOIN chapters c ON c.subject_id = s.id
  JOIN fiches f ON f.chapter_id = c.id AND f.is_published = true
  LEFT JOIN user_progress up ON up.fiche_id = f.id AND up.user_id = p_user_id
  WHERE s.series_id = p_series_id
  GROUP BY s.id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 7. RPC: Get progress per chapter for a subject
CREATE OR REPLACE FUNCTION get_chapter_progress(p_user_id uuid, p_subject_id uuid)
RETURNS TABLE (
  chapter_id uuid,
  total_fiches bigint,
  viewed_fiches bigint,
  avg_quiz_score numeric
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id AS chapter_id,
    COUNT(DISTINCT f.id) AS total_fiches,
    COUNT(DISTINCT up.fiche_id) FILTER (WHERE up.viewed = true) AS viewed_fiches,
    ROUND(AVG(up.quiz_score) FILTER (WHERE up.quiz_score IS NOT NULL), 0) AS avg_quiz_score
  FROM chapters c
  JOIN fiches f ON f.chapter_id = c.id AND f.is_published = true
  LEFT JOIN user_progress up ON up.fiche_id = f.id AND up.user_id = p_user_id
  WHERE c.subject_id = p_subject_id
  GROUP BY c.id;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- 8. Updated_at trigger
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON user_progress
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();
