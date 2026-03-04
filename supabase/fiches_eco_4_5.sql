-- ============================================================
-- Fiches for TSECO Économie: Chapters 4 & 5
-- Croissance démographique + Pays industrialisés capitalistes
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 4: La croissance démographique et ses conséquences
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'croissance-demographique';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: croissance-demographique';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'transition-demographique-politiques',
    'La transition démographique et les politiques de population',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce que la croissance démographique ?",
          "answer": "Augmentation de la population. Taux d''accroissement naturel = Taux natalité - Taux mortalité",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la transition démographique ?",
          "answer": "Passage d''un régime de forte natalité/mortalité à un régime de faible natalité/mortalité. 4 phases",
          "category": "Définition"
        },
        {
          "question": "Les 4 phases de la transition démographique ?",
          "answer": "Phase 1: forte natalité + forte mortalité. Phase 2: mortalité baisse. Phase 3: natalité baisse. Phase 4: faible natalité + faible mortalité",
          "category": "Méthode"
        },
        {
          "question": "Qu''est-ce que l''espérance de vie ?",
          "answer": "Nombre moyen d''années qu''un individu peut espérer vivre à la naissance. Indicateur de santé",
          "category": "Définition"
        },
        {
          "question": "Taux d''accroissement naturel ?",
          "answer": "TAN = Taux de natalité - Taux de mortalité. En pour mille. Si TAN > 0: population augmente",
          "category": "Formule"
        },
        {
          "question": "Qu''est-ce que la politique nataliste ?",
          "answer": "Politique qui encourage les naissances: allocations familiales, conges maternite, avantages fiscaux",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la politique antinataliste ?",
          "answer": "Politique qui limite les naissances: planning familial, contraception, éducation des femmes",
          "category": "Définition"
        },
        {
          "question": "Conséquences positives vs négatives de la croissance démographique ?",
          "answer": "Positives: main d''œuvre, marche intérieur. Negatives: pression sur ressources, chômage, pauvreté",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "La transition démographique",
        "nodes": [
          {"id": "n1", "label": "Transition\ndémographique", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Phase 1-2\nPre-transition", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Phase 3-4\nPost-transition", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Forte natalité\nForte mortalité", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Mortalite\nbaisse", "x": 250, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Natalite\nbaisse", "x": 500, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Faibles taux\nStabilisation", "x": 750, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Politiques\nde population", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "Natalistes\n(encourager)", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Antinatalistes\n(limiter)", "x": 550, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4", "label": "phase 1"},
          {"from": "n2", "to": "n5", "label": "phase 2"},
          {"from": "n3", "to": "n6", "label": "phase 3"},
          {"from": "n3", "to": "n7", "label": "phase 4"},
          {"from": "n1", "to": "n8", "label": "réponses"},
          {"from": "n8", "to": "n9"},
          {"from": "n8", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "Le TAN se calcule:",
          "options": ["Natalite x mortalité", "Natalite - mortalité", "Natalite + mortalité", "Natalite / mortalité"],
          "correct": 1,
          "explanation": "TAN = Taux natalité - Taux mortalité"
        },
        {
          "question": "En phase 2 de la transition:",
          "options": ["Natalite baisse", "Mortalite baisse", "Population baisse", "Rien ne change"],
          "correct": 1,
          "explanation": "La mortalité baisse grace aux progrès medicaux, la natalité reste forte"
        },
        {
          "question": "Le Mali est principalement en phase:",
          "options": ["1", "2", "3", "4"],
          "correct": 1,
          "explanation": "Mortalite en baisse mais natalité encore élevée = forte croissance démographique"
        },
        {
          "question": "Politique antinataliste =",
          "options": ["Encourager les naissances", "Limiter les naissances", "Augmenter la mortalité", "Immigration"],
          "correct": 1,
          "explanation": "Planning familial, éducation, contraception"
        },
        {
          "question": "Consequence positive de la croissance démographique:",
          "options": ["Chomage", "Main d''œuvre abondante", "Épuisement des ressources", "Pollution"],
          "correct": 1,
          "explanation": "Plus de travailleurs = potentiel économique"
        },
        {
          "question": "L''espérance de vie mesure:",
          "options": ["La richesse", "Le nombre d''années moyen de vie", "Le taux de natalité", "Le PIB"],
          "correct": 1,
          "explanation": "Indicateur de santé et de développement"
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 5: Les pays industrialisés capitalistes (PIC)
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'les-pic';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: les-pic';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'capitalisme-secteurs-politiques-economiques',
    'Le capitalisme, les secteurs économiques et les politiques économiques',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce que le capitalisme ?",
          "answer": "Systeme économique base sur: propriété privée des moyens de production, recherche du profit, économie de marche",
          "category": "Définition"
        },
        {
          "question": "Les 3 secteurs économiques ?",
          "answer": "Primaire (agriculture, peche), Secondaire (industrie, transformation), Tertiaire (services, commerce)",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la politique budgétaire ?",
          "answer": "Politique de l''État utilisant le budget (dépenses publiques et impots) pour reguler l''économie",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la politique monétaire ?",
          "answer": "Politique de la banque centrale controlant la masse monétaire et les taux d''intérêt",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la DIT ?",
          "answer": "Division Internationale du Travail: spécialisation des pays dans certaines productions selon leurs avantages comparatifs",
          "category": "Définition"
        },
        {
          "question": "Politique de relance vs d''austerite ?",
          "answer": "Relance: augmenter les dépenses pour stimuler l''activité. Austerite: réduire les dépenses pour équilibrer le budget",
          "category": "Distinction"
        },
        {
          "question": "Le marché du travail ?",
          "answer": "Lieu de rencontre entre offre de travail (salaries) et demande de travail (entreprises). Équilibre = salaire",
          "category": "Définition"
        },
        {
          "question": "Les causes du chômage ?",
          "answer": "Conjoncturelles (crise, recession) et structurelles (qualification, rigidites du marche, progrès technique)",
          "category": "Méthode"
        }
      ],
      "schema": {
        "title": "Les PIC: capitalisme et politiques économiques",
        "nodes": [
          {"id": "n1", "label": "Pays\nindustrialisés", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Capitalisme", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Politiques\néconomiques", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Propriété\nprivée", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Économie\nde marche", "x": 250, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Budgetaire", "x": 550, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Monetaire", "x": 750, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Marché du\ntravail", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "Offre/Demande\nd''emploi", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Chomage\nPolitiques", "x": 550, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n3", "to": "n6"},
          {"from": "n3", "to": "n7"},
          {"from": "n1", "to": "n8", "label": "emploi"},
          {"from": "n8", "to": "n9"},
          {"from": "n8", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "Le capitalisme repose sur:",
          "options": ["Propriété collective", "Propriété privée et profit", "Économie planifiée", "Troc"],
          "correct": 1,
          "explanation": "Propriété privée + recherche du profit + marche"
        },
        {
          "question": "Le secteur tertiaire =",
          "options": ["Agriculture", "Industrie", "Services", "Mines"],
          "correct": 2,
          "explanation": "Commerce, banques, transports, santé, éducation"
        },
        {
          "question": "La politique budgétaire utilise:",
          "options": ["Les taux d''intérêt", "Les dépenses publiques et impots", "La monnaie", "Le commerce"],
          "correct": 1,
          "explanation": "L''État agit via son budget (recettes/dépenses)"
        },
        {
          "question": "La DIT signifie:",
          "options": ["Dette Internationale Totale", "Division Internationale du Travail", "Deficit Interieur Total", "Duree Investissement Technique"],
          "correct": 1,
          "explanation": "Spécialisation des pays dans la production"
        },
        {
          "question": "Politique de relance =",
          "options": ["Reduire les dépenses", "Augmenter les dépenses pour stimuler l''économie", "Baisser les salaires", "Fermer les entreprises"],
          "correct": 1,
          "explanation": "Plus de dépenses publiques = plus de demande = plus d''emplois"
        },
        {
          "question": "Le chômage structurel est du a:",
          "options": ["Une crise temporaire", "Des changements profonds du marché du travail", "La meteo", "L''inflation"],
          "correct": 1,
          "explanation": "Inadaptation des qualifications, rigidites, progrès technique"
        }
      ]
    }'::jsonb
  );

END $$;
