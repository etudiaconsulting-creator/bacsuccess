-- RPC functions to avoid N+1 queries on dashboard and subject pages

-- Returns all subjects for a series with chapter_count and fiche_count
CREATE OR REPLACE FUNCTION get_subjects_with_counts(p_series_id UUID)
RETURNS TABLE (
  id UUID,
  series_id UUID,
  slug TEXT,
  name TEXT,
  coefficient INTEGER,
  hours_per_week NUMERIC(3,1),
  color TEXT,
  icon TEXT,
  display_order INTEGER,
  created_at TIMESTAMPTZ,
  chapter_count BIGINT,
  fiche_count BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    s.id,
    s.series_id,
    s.slug,
    s.name,
    s.coefficient,
    s.hours_per_week,
    s.color,
    s.icon,
    s.display_order,
    s.created_at,
    COUNT(DISTINCT c.id) AS chapter_count,
    COUNT(DISTINCT f.id) AS fiche_count
  FROM subjects s
  LEFT JOIN chapters c ON c.subject_id = s.id
  LEFT JOIN fiches f ON f.chapter_id = c.id AND f.is_published = true
  WHERE s.series_id = p_series_id
  GROUP BY s.id
  ORDER BY s.display_order;
END;
$$ LANGUAGE plpgsql STABLE;

-- Returns all chapters for a subject with fiche_count
CREATE OR REPLACE FUNCTION get_chapters_with_counts(p_subject_id UUID)
RETURNS TABLE (
  id UUID,
  subject_id UUID,
  slug TEXT,
  number INTEGER,
  title TEXT,
  description TEXT,
  display_order INTEGER,
  created_at TIMESTAMPTZ,
  fiche_count BIGINT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    c.id,
    c.subject_id,
    c.slug,
    c.number,
    c.title,
    c.description,
    c.display_order,
    c.created_at,
    COUNT(f.id) AS fiche_count
  FROM chapters c
  LEFT JOIN fiches f ON f.chapter_id = c.id AND f.is_published = true
  WHERE c.subject_id = p_subject_id
  GROUP BY c.id
  ORDER BY c.number;
END;
$$ LANGUAGE plpgsql STABLE;
