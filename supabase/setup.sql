-- BacSuccess Initial Schema
-- Multi-country architecture for African baccalauréate révision platform

CREATE TABLE countries (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name TEXT NOT NULL,
  flag_emoji TEXT,
  is_active BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE series (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  country_id UUID REFERENCES countries(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  name TEXT NOT NULL,
  short_name TEXT NOT NULL,
  description TEXT,
  is_active BOOLEAN DEFAULT false,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(country_id, slug)
);

CREATE TABLE subjects (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  series_id UUID REFERENCES series(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  name TEXT NOT NULL,
  coefficient INTEGER NOT NULL,
  hours_per_week NUMERIC(3,1),
  color TEXT,
  icon TEXT,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(series_id, slug)
);

CREATE TABLE chapters (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  subject_id UUID REFERENCES subjects(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  number INTEGER NOT NULL,
  title TEXT NOT NULL,
  description TEXT,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(subject_id, slug)
);

CREATE TABLE fiches (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  chapter_id UUID REFERENCES chapters(id) ON DELETE CASCADE,
  slug TEXT NOT NULL,
  title TEXT NOT NULL,
  subtitle TEXT,
  content JSONB NOT NULL,
  is_free BOOLEAN DEFAULT false,
  is_published BOOLEAN DEFAULT false,
  display_order INTEGER DEFAULT 0,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(chapter_id, slug)
);

-- Indexes
CREATE INDEX idx_series_country ON series(country_id);
CREATE INDEX idx_subjects_series ON subjects(series_id);
CREATE INDEX idx_chapters_subject ON chapters(subject_id);
CREATE INDEX idx_fiches_chapter ON fiches(chapter_id);
CREATE INDEX idx_fiches_published ON fiches(is_published) WHERE is_published = true;

-- RLS: public read for MVP
ALTER TABLE countries ENABLE ROW LEVEL SECURITY;
ALTER TABLE series ENABLE ROW LEVEL SECURITY;
ALTER TABLE subjects ENABLE ROW LEVEL SECURITY;
ALTER TABLE chapters ENABLE ROW LEVEL SECURITY;
ALTER TABLE fiches ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read countries" ON countries FOR SELECT USING (true);
CREATE POLICY "Public read series" ON series FOR SELECT USING (true);
CREATE POLICY "Public read subjects" ON subjects FOR SELECT USING (true);
CREATE POLICY "Public read chapters" ON chapters FOR SELECT USING (true);
CREATE POLICY "Public read fiches" ON fiches FOR SELECT USING (true);

-- ============================================================================
-- SEED DATA
-- ============================================================================

-- ============================================================================
-- BacSuccess Seed Data
-- Mali TSECO Baccalauréat Revision Platform
-- ============================================================================

-- ============================================================================
-- Use a DO block with variables to manage UUID références across inserts
-- ============================================================================
DO $$
DECLARE
  -- Country IDs
  v_mali_id UUID;
  v_senegal_id UUID;
  v_cote_ivoire_id UUID;
  v_cameroun_id UUID;
  v_burkina_id UUID;

  -- Series IDs
  v_tseco_id UUID;
  v_tsexp_id UUID;
  v_tse_id UUID;
  v_tss_id UUID;
  v_tll_id UUID;
  v_tal_id UUID;

  -- Subject IDs
  v_economie_id UUID;
  v_comptabilite_id UUID;
  v_philosophie_id UUID;
  v_droit_id UUID;
  v_mathematiques_id UUID;
  v_francais_id UUID;
  v_histoire_geo_id UUID;
  v_anglais_id UUID;

  -- Chapter IDs (Économie)
  v_ch_instruments_id UUID;
  v_ch_croissance_eco_id UUID;
  v_ch_dissertation_id UUID;
  v_ch_croissance_demo_id UUID;
  v_ch_pic_id UUID;
  v_ch_ped_id UUID;
  v_ch_mondialisation_id UUID;

  -- Chapter IDs (Comptabilité)
  v_ch_effets_id UUID;
  v_ch_rapprochement_id UUID;
  v_ch_acquisitions_id UUID;
  v_ch_operations_id UUID;
  v_ch_valorisation_id UUID;
  v_ch_resultat_id UUID;

  -- Chapter IDs (Philosophie)
  v_ch_histoire_philo_id UUID;
  v_ch_homme_monde_id UUID;
  v_ch_etude_oeuvres_id UUID;

  -- Chapter IDs (Droit)
  v_ch_regle_droit_id UUID;
  v_ch_preuves_id UUID;
  v_ch_fonds_commerce_id UUID;

  -- Fiche ID
  v_fiche_id UUID;

BEGIN
  -- ==========================================================================
  -- 1. COUNTRIES
  -- ==========================================================================
  v_mali_id := gen_random_uuid();
  v_senegal_id := gen_random_uuid();
  v_cote_ivoire_id := gen_random_uuid();
  v_cameroun_id := gen_random_uuid();
  v_burkina_id := gen_random_uuid();

  INSERT INTO countries (id, slug, name, flag_emoji, is_active) VALUES
    (v_mali_id, 'mali', 'Mali', '🇲🇱', true),
    (v_senegal_id, 'senegal', 'Sénégal', '🇸🇳', false),
    (v_cote_ivoire_id, 'cote-divoire', 'Côte d''Ivoire', '🇨🇮', false),
    (v_cameroun_id, 'cameroun', 'Cameroun', '🇨🇲', false),
    (v_burkina_id, 'burkina-faso', 'Burkina Faso', '🇧🇫', false);

  -- ==========================================================================
  -- 2. SERIES (for Mali)
  -- ==========================================================================
  v_tseco_id := gen_random_uuid();
  v_tsexp_id := gen_random_uuid();
  v_tse_id := gen_random_uuid();
  v_tss_id := gen_random_uuid();
  v_tll_id := gen_random_uuid();
  v_tal_id := gen_random_uuid();

  INSERT INTO series (id, country_id, slug, name, short_name, is_active) VALUES
    (v_tseco_id, v_mali_id, 'tseco', 'Terminale Sciences Économiques', 'TSECO', true),
    (v_tsexp_id, v_mali_id, 'tsexp', 'Terminale Sciences Expérimentales', 'TSEXP', false),
    (v_tse_id, v_mali_id, 'tse', 'Terminale Sciences Exactes', 'TSE', false),
    (v_tss_id, v_mali_id, 'tss', 'Terminale Sciences Sociales', 'TSS', false),
    (v_tll_id, v_mali_id, 'tll', 'Terminale Langues et Littérature', 'TLL', false),
    (v_tal_id, v_mali_id, 'tal', 'Terminale Arts et Lettres', 'TAL', false);

  -- ==========================================================================
  -- 3. SUBJECTS (for TSECO)
  -- ==========================================================================
  v_economie_id := gen_random_uuid();
  v_comptabilite_id := gen_random_uuid();
  v_philosophie_id := gen_random_uuid();
  v_droit_id := gen_random_uuid();
  v_mathematiques_id := gen_random_uuid();
  v_francais_id := gen_random_uuid();
  v_histoire_geo_id := gen_random_uuid();
  v_anglais_id := gen_random_uuid();

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order) VALUES
    (v_economie_id, v_tseco_id, 'economie', 'Économie', 5, 5, '#2563EB', 'TrendingUp', 1),
    (v_comptabilite_id, v_tseco_id, 'comptabilite', 'Comptabilité et Commerce', 3, 4, '#059669', 'Calculator', 2),
    (v_philosophie_id, v_tseco_id, 'philosophie', 'Philosophie', 2, 2, '#7C3AED', 'Brain', 3),
    (v_droit_id, v_tseco_id, 'droit', 'Droit', 2, 2, '#DC2626', 'Scale', 4),
    (v_mathematiques_id, v_tseco_id, 'mathematiques', 'Maths Financières', 2, 3, '#EA580C', 'Sigma', 5),
    (v_francais_id, v_tseco_id, 'francais', 'Français', 2, 3, '#0891B2', 'BookOpen', 6),
    (v_histoire_geo_id, v_tseco_id, 'histoire-geo', 'Histoire-Géo', 2, 3, '#CA8A04', 'Globe', 7),
    (v_anglais_id, v_tseco_id, 'anglais', 'Anglais', 2, 2, '#4F46E5', 'Languages', 8);

  -- ==========================================================================
  -- 4. CHAPTERS - Économie (7 chapters)
  -- ==========================================================================
  v_ch_instruments_id := gen_random_uuid();
  v_ch_croissance_eco_id := gen_random_uuid();
  v_ch_dissertation_id := gen_random_uuid();
  v_ch_croissance_demo_id := gen_random_uuid();
  v_ch_pic_id := gen_random_uuid();
  v_ch_ped_id := gen_random_uuid();
  v_ch_mondialisation_id := gen_random_uuid();

  INSERT INTO chapters (id, subject_id, slug, number, title, description, display_order) VALUES
    (v_ch_instruments_id, v_economie_id, 'les-instruments-analyse-statistiques', 1, 'Les instruments d''analyse statistiques', 'Coefficient multiplicateur, TAG, TAAM, indices, parts', 1),
    (v_ch_croissance_eco_id, v_economie_id, 'croissance-economique-développément', 2, 'Croissance économique et développement', 'Définition, IDH, développement durable', 2),
    (v_ch_dissertation_id, v_economie_id, 'technique-dissertation-economique', 3, 'Technique de la dissertation économique', NULL, 3),
    (v_ch_croissance_demo_id, v_economie_id, 'croissance-demographique', 4, 'La croissance démographique et ses conséquences', 'Transition démographique, politiques de population', 4),
    (v_ch_pic_id, v_economie_id, 'les-pic', 5, 'Les pays industrialisés capitalistes', 'Capitalisme, secteurs, politiques économiques, marché du travail, DIT', 5),
    (v_ch_ped_id, v_economie_id, 'les-pays-en-développément', 6, 'Les pays en développement', 'Stratégies agricoles et industrielles, financement du développement', 6),
    (v_ch_mondialisation_id, v_economie_id, 'la-mondialisation', 7, 'La mondialisation', 'Définition, étapes, avantages et inconvénients', 7);

  -- ==========================================================================
  -- 5. CHAPTERS - Comptabilité (6 chapters)
  -- ==========================================================================
  v_ch_effets_id := gen_random_uuid();
  v_ch_rapprochement_id := gen_random_uuid();
  v_ch_acquisitions_id := gen_random_uuid();
  v_ch_operations_id := gen_random_uuid();
  v_ch_valorisation_id := gen_random_uuid();
  v_ch_resultat_id := gen_random_uuid();

  INSERT INTO chapters (id, subject_id, slug, number, title, description, display_order) VALUES
    (v_ch_effets_id, v_comptabilite_id, 'effets-de-commerce', 1, 'Les effets de commerce', 'Création, circulation, impayés', 1),
    (v_ch_rapprochement_id, v_comptabilite_id, 'rapprochement-bancaire', 2, 'Le rapprochement bancaire', NULL, 2),
    (v_ch_acquisitions_id, v_comptabilite_id, 'acquisitions-immobilisations', 3, 'Les acquisitions d''immobilisations', NULL, 3),
    (v_ch_operations_id, v_comptabilite_id, 'operations-fin-exercice', 4, 'Les opérations de fin d''exercice', 'Amortissements', 4),
    (v_ch_valorisation_id, v_comptabilite_id, 'valorisation-stocks', 5, 'Valorisation des stocks', 'CMUP, PEPS', 5),
    (v_ch_resultat_id, v_comptabilite_id, 'resultat-analytique', 6, 'Détermination du résultat analytique', NULL, 6);

  -- ==========================================================================
  -- 6. CHAPTERS - Philosophie (3 chapters)
  -- ==========================================================================
  v_ch_histoire_philo_id := gen_random_uuid();
  v_ch_homme_monde_id := gen_random_uuid();
  v_ch_etude_oeuvres_id := gen_random_uuid();

  INSERT INTO chapters (id, subject_id, slug, number, title, description, display_order) VALUES
    (v_ch_histoire_philo_id, v_philosophie_id, 'histoire-philosophie', 1, 'Histoire de la philosophie', 'Aristote, Rousseau, Guisse', 1),
    (v_ch_homme_monde_id, v_philosophie_id, 'homme-et-monde', 2, 'Étude thématique: L''homme et le monde', NULL, 2),
    (v_ch_etude_oeuvres_id, v_philosophie_id, 'etude-oeuvres', 3, 'Étude d''œuvres', 'Montesquieu, Marx, Nkrumah', 3);

  -- ==========================================================================
  -- 7. CHAPTERS - Droit (3 chapters)
  -- ==========================================================================
  v_ch_regle_droit_id := gen_random_uuid();
  v_ch_preuves_id := gen_random_uuid();
  v_ch_fonds_commerce_id := gen_random_uuid();

  INSERT INTO chapters (id, subject_id, slug, number, title, description, display_order) VALUES
    (v_ch_regle_droit_id, v_droit_id, 'regle-de-droit', 1, 'La règle de droit', NULL, 1),
    (v_ch_preuves_id, v_droit_id, 'preuves-entreprise', 2, 'Preuves et entreprise commerciale', NULL, 2),
    (v_ch_fonds_commerce_id, v_droit_id, 'fonds-commerce-societes', 3, 'Fonds de commerce et sociétés', NULL, 3);

  -- ==========================================================================
  -- 8. EXAMPLE FICHE (for first Économie chapter)
  -- ==========================================================================
  v_fiche_id := gen_random_uuid();

  INSERT INTO fiches (id, chapter_id, slug, title, is_free, is_published, content) VALUES
    (v_fiche_id, v_ch_instruments_id, 'coefficient-multiplicateur-tag-taam', 'Le coefficient multiplicateur, le TAG et le TAAM', true, true, '{
      "flashcards": [
        {"id": "fc1", "category": "Définition", "question": "Qu''est-ce que le coefficient multiplicateur ?", "answer": "Rapport V1/V0. Si CM>1: hausse, CM<1: baisse, CM=1: stable"},
        {"id": "fc2", "category": "Formule", "question": "Comment calculer le TAG ?", "answer": "TAG = (V1-V0)/V0 x 100 ou TAG = (CM-1) x 100"},
        {"id": "fc3", "category": "Formule", "question": "Comment calculer le TAAM ?", "answer": "TAAM = (CM^(1/n) - 1) x 100, n = nb années"},
        {"id": "fc4", "category": "Définition", "question": "Qu''est-ce qu''un indice simple ?", "answer": "I(t/0) = (Vt/V0) x 100. Base = toujours 100"},
        {"id": "fc5", "category": "Méthode", "question": "Indice vers taux de variation ?", "answer": "Taux = Indice - 100. Ex: indice 115 = +15%"},
        {"id": "fc6", "category": "Définition", "question": "Qu''est-ce qu''une part ?", "answer": "Part = (Element/Total) x 100. Somme = 100%"},
        {"id": "fc7", "category": "Distinction", "question": "Valeur absolue vs relative ?", "answer": "Absolue: brute avec unité. Relative: en % ou indice"},
        {"id": "fc8", "category": "Méthode", "question": "Interprêtér CM = 1,35 ?", "answer": "Multiplie par 1,35 = hausse de 35%"}
      ],
      "schema": {
        "title": "Les outils d''analyse statistique",
        "nodes": [
          {"id": "n1", "label": "Instruments\nstatistiques", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Valeurs\nabsolues", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Valeurs\nrelatives", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Effectifs\nMontants", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Moyennes\nMedianes", "x": 250, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "CM/TAG\nTAAM", "x": 500, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Indices\nParts", "x": 700, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Analyse\ndémographique", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "Taux natalité\nmortalité", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Espérance\nde vie", "x": 550, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n3", "to": "n6", "label": "variations"},
          {"from": "n3", "to": "n7", "label": "comparaisons"},
          {"from": "n1", "to": "n8", "label": "application"},
          {"from": "n8", "to": "n9"},
          {"from": "n8", "to": "n10"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Prix 200 -> 250 FCFA. CM = ?", "options": ["0,25", "1,20", "1,25", "50"], "correct": 2, "explanation": "CM=250/200=1,25"},
        {"id": "q2", "question": "PIB 8000 -> 12000 en 5 ans. TAG = ?", "options": ["25%", "40%", "50%", "60%"], "correct": 2, "explanation": "TAG=(12000-8000)/8000x100=50%"},
        {"id": "q3", "question": "Indice 125 (base 100) signifie:", "options": ["Baisse 25%", "Hausse 25%", "Prix=125", "x125"], "correct": 1, "explanation": "Hausse de 25% vs base"},
        {"id": "q4", "question": "3M/8M actifs agriculture. Part=?", "options": ["26,7%", "37,5%", "40%", "62,5%"], "correct": 1, "explanation": "3/8x100=37,5%"},
        {"id": "q5", "question": "CM=0,85 signifie:", "options": ["Hausse 85%", "Baisse 85%", "Baisse 15%", "Hausse 15%"], "correct": 2, "explanation": "(0,85-1)x100=-15%"},
        {"id": "q6", "question": "TAG vs TAAM ?", "options": ["TAG>TAAM", "TAG=total TAAM=annuel", "TAAM=PIB only", "Pareil"], "correct": 1, "explanation": "TAG=global, TAAM=moyen/an"}
      ]
    }'::jsonb);

END $$;
