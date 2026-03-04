-- ============================================================================
-- BacSuccess - Fiches Économie (Chapitres 2 a 7)
-- Execute this in Supabase SQL Editor
-- ============================================================================

-- ============================================================
-- Fiches for TSECO Économie: Chapters 2 & 3
-- Croissance économique et développement + Dissertation économique
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 2: Croissance économique, développement et IDH
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'croissance-economique-developpement';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: croissance-economique-developpement';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'croissance-economique-et-idh',
    'La croissance économique, le développement et l''IDH',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce que la croissance économique ?",
          "answer": "Augmentation soutenue et durable de la production de biens et services, mesurée par le PIB ou PNB",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que le développement ?",
          "answer": "Transformation des structures économiques, sociales et culturelles. Plus large que la croissance",
          "category": "Définition"
        },
        {
          "question": "Croissance vs Développement ?",
          "answer": "Croissance = quantitatif (PIB). Développement = qualitatif (santé, éducation, liberté). La croissance est nécessaire mais pas suffisante",
          "category": "Distinction"
        },
        {
          "question": "Qu''est-ce que l''IDH ?",
          "answer": "Indice de Développement Humain (PNUD). Combine: santé (espérance de vie), éducation (scolarisation), revenu (RNB/hab). Valeur entre 0 et 1",
          "category": "Définition"
        },
        {
          "question": "Comment interpréter l''IDH ?",
          "answer": "IDH proche de 1 = très développé. IDH > 0,8 = élevé. 0,5-0,8 = moyen. < 0,5 = faible",
          "category": "Formule"
        },
        {
          "question": "Qu''est-ce que le développement durable ?",
          "answer": "Développement qui répond aux besoins du présent sans compromettre ceux des générations futures. 3 piliers: économique, social, environnemental",
          "category": "Définition"
        },
        {
          "question": "Les limites du PIB comme indicateur ?",
          "answer": "Ignore: économie informelle, inégalités, bien-être, environnement, travail domestique",
          "category": "Méthode"
        },
        {
          "question": "Les 3 piliers du développement durable ?",
          "answer": "Économique (croissance viable), Social (équité, lutte contre pauvreté), Environnemental (préservation ressources naturelles)",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "Croissance, développement et IDH",
        "nodes": [
          {"id": "n1", "label": "Croissance\néconomique", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "PIB/PNB", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Développement", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "PIB nominal", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "PIB réel", "x": 250, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "IDH", "x": 500, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Dev. durable", "x": 750, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Composantes\nIDH", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "Santé\nÉducation", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Revenu\n(RNB/hab)", "x": 550, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3", "label": "plus large"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n3", "to": "n6", "label": "mesure"},
          {"from": "n3", "to": "n7", "label": "objectif"},
          {"from": "n6", "to": "n8"},
          {"from": "n8", "to": "n9"},
          {"from": "n8", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "Le PIB mesure:",
          "options": ["Le bien-être", "La production de richesses", "Les inégalités", "L''environnement"],
          "correct": 1,
          "explanation": "PIB = valeur totale de la production de biens et services"
        },
        {
          "question": "L''IDH combine:",
          "options": ["PIB + inflation", "Santé + éducation + revenu", "Croissance + emploi", "Import + export"],
          "correct": 1,
          "explanation": "IDH = espérance de vie + scolarisation + RNB/habitant"
        },
        {
          "question": "IDH = 0,42 signifie:",
          "options": ["Pays développé", "Développement élevé", "Développement moyen", "Développement faible"],
          "correct": 3,
          "explanation": "IDH < 0,5 = développement faible"
        },
        {
          "question": "Le développement durable a combien de piliers ?",
          "options": ["2", "3", "4", "5"],
          "correct": 1,
          "explanation": "Économique, social, environnemental"
        },
        {
          "question": "Croissance sans développement signifie:",
          "options": ["PIB baisse", "Richesse augmente mais pas le bien-être", "IDH augmente", "Impossible"],
          "correct": 1,
          "explanation": "Possible si inégalités fortes et pas d''amelioration sociale"
        },
        {
          "question": "Limite du PIB:",
          "options": ["Trop précis", "Ignore l''économie informelle", "Mesure le bonheur", "Inclut tout"],
          "correct": 1,
          "explanation": "Le PIB ne comptabilise pas le travail domestique ni l''informel"
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 3: Méthodologie de la dissertation économique
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'technique-dissertation-economique';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: technique-dissertation-economique';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'méthodologie-dissertation-économique',
    'Méthodologie de la dissertation économique',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Les étapes de la dissertation économique ?",
          "answer": "1. Analyser le sujet 2. Mobiliser les connaissances 3. Construire le plan 4. Rediger intro/dev/conclusion",
          "category": "Méthode"
        },
        {
          "question": "Comment analyser un sujet ?",
          "answer": "Identifier: mots-cles, cadre spatio-temporel, type de sujet (analyse, discussion, comparaison), problématique",
          "category": "Méthode"
        },
        {
          "question": "Qu''est-ce qu''une problématique ?",
          "answer": "Question centrale posée par le sujet. Elle guide toute la réflexion et le plan",
          "category": "Définition"
        },
        {
          "question": "Structure de l''introduction ?",
          "answer": "1. Accroche (fait d''actualite) 2. Définition des termes 3. Problématique 4. Annonce du plan",
          "category": "Méthode"
        },
        {
          "question": "Les types de plans ?",
          "answer": "Plan analytique (causes/conséquences/solutions), plan dialectique (thèse/antithèse/synthèse), plan thématique",
          "category": "Méthode"
        },
        {
          "question": "Structure d''une partie ?",
          "answer": "Idée principale + argument + exemple chiffre + transition vers partie suivante",
          "category": "Méthode"
        },
        {
          "question": "Structure de la conclusion ?",
          "answer": "1. Bilan (réponse à la problématique) 2. Ouverture (nouvelle question)",
          "category": "Méthode"
        },
        {
          "question": "Plan analytique vs dialectique ?",
          "answer": "Analytique: sujet d''analyse (expliquer). Dialectique: sujet de discussion (débattre pour/contre)",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "Structure de la dissertation économique",
        "nodes": [
          {"id": "n1", "label": "Dissertation\néconomique", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Introduction", "x": 100, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Développement", "x": 400, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Conclusion", "x": 700, "y": 150, "type": "branch"},
          {"id": "n5", "label": "Accroche\nDéfinitions", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Problématique\nPlan", "x": 200, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Partie 1", "x": 300, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Partie 2", "x": 450, "y": 270, "type": "leaf"},
          {"id": "n9", "label": "Partie 3", "x": 550, "y": 270, "type": "leaf"},
          {"id": "n10", "label": "Bilan\nOuverture", "x": 700, "y": 270, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n1", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n2", "to": "n6"},
          {"from": "n3", "to": "n7"},
          {"from": "n3", "to": "n8"},
          {"from": "n3", "to": "n9", "label": "optionnel"},
          {"from": "n4", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "L''introduction contient:",
          "options": ["Seulement le plan", "Accroche + définitions + problématique + plan", "La réponse au sujet", "Les exemples"],
          "correct": 1,
          "explanation": "4 elements: accroche, définitions, problématique, annonce du plan"
        },
        {
          "question": "Le plan dialectique convient pour:",
          "options": ["Un sujet d''analyse", "Un sujet de discussion", "Une comparaison", "Une définition"],
          "correct": 1,
          "explanation": "These/antithèse/synthèse pour les sujets de débat"
        },
        {
          "question": "La problématique est:",
          "options": ["Le titre du sujet", "La question centrale du sujet", "La conclusion", "Un exemple"],
          "correct": 1,
          "explanation": "Elle oriente toute la réflexion"
        },
        {
          "question": "Chaque partie doit contenir:",
          "options": ["Seulement des définitions", "Idée + argument + exemple", "Que des chiffres", "Une conclusion"],
          "correct": 1,
          "explanation": "Structure: idée, argumentation, illustration chiffree"
        },
        {
          "question": "La conclusion comprend:",
          "options": ["Nouveaux arguments", "Bilan + ouverture", "Repetition de l''intro", "Rien de special"],
          "correct": 1,
          "explanation": "Bilan (réponse) et ouverture (nouvelle perspective)"
        },
        {
          "question": "Sujet: ''Analysez les causes du sous-développement''. Type de plan ?",
          "options": ["Dialectique", "Analytique", "Chronologique", "Aucun"],
          "correct": 1,
          "explanation": "''Analysez'' = plan analytique (causes/conséquences/solutions)"
        }
      ]
    }'::jsonb
  );

END $$;

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

-- ============================================================
-- Fiches for TSECO Économie: Chapters 6 & 7
-- Les pays en développement + La mondialisation
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 6: Les stratégies de développement et le financement
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'les-pays-en-developpement';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: les-pays-en-developpement';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'stratégies-développement-financement',
    'Les stratégies de développement et le financement',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce qu''un PED (pays en développement) ?",
          "answer": "Pays a faible revenu, économie peu diversifiée, dépendance aux matières premières, IDH faible",
          "category": "Définition"
        },
        {
          "question": "Stratégie agricole vs industrielle ?",
          "answer": "Agricole: moderniser l''agriculture, autosuffisance alimentaire. Industrielle: industrialisation par substitution d''importation (ISI) ou promotion des exportations",
          "category": "Distinction"
        },
        {
          "question": "Qu''est-ce que l''ISI ?",
          "answer": "Industrialisation par Substitution d''Importation: produire localement les biens importes. Protectionnisme pour protéger l''industrie naissante",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la stratégie de promotion des exportations ?",
          "answer": "Produire pour le marché mondial. Avantages comparatifs, zones franches, attraire les IDE",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que l''APD ?",
          "answer": "Aide Publique au Développement: aide financière et technique des pays riches vers les PED. Bilaterale ou multilaterale",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que la dette extérieure ?",
          "answer": "Ensemble des emprunts contractes aupres de l''étranger. Le service de la dette (remboursement + intérêts) pese sur les PED",
          "category": "Définition"
        },
        {
          "question": "Sources de financement du développement ?",
          "answer": "Internes: épargne, impots. Externes: APD, IDE, emprunts, transferts de migrants",
          "category": "Méthode"
        },
        {
          "question": "IDE vs APD ?",
          "answer": "IDE (Investissement Direct Etranger): entreprises privées investissent. APD: aide gouvernementale. IDE plus stable mais concentrès dans quelques pays",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "Stratégies et financement du développement",
        "nodes": [
          {"id": "n1", "label": "Pays en\ndéveloppement", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Stratégies\nagricoles", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Stratégies\nindustrielles", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Modernisation\nAutosuffisance", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Révolution\nverte", "x": 250, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "ISI\n(substitution)", "x": 550, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Promotion\nexportations", "x": 750, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Financement", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "Interne\n(épargne, impots)", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Externe\n(APD, IDE, dette)", "x": 550, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n3", "to": "n6"},
          {"from": "n3", "to": "n7"},
          {"from": "n1", "to": "n8", "label": "financement"},
          {"from": "n8", "to": "n9"},
          {"from": "n8", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "L''ISI signifie:",
          "options": ["Indice de Satisfaction Interieure", "Industrialisation par Substitution d''Importation", "Investissement Social International", "Impot Sur les Industries"],
          "correct": 1,
          "explanation": "Produire localement les biens qu''on importait"
        },
        {
          "question": "L''APD est:",
          "options": ["Un investissement prive", "Une aide gouvernementale aux PED", "Un impot", "Une monnaie"],
          "correct": 1,
          "explanation": "Aide Publique au Développement: aide des pays riches"
        },
        {
          "question": "Le service de la dette =",
          "options": ["Le montant emprunte", "Remboursement + intérêts annuels", "Le PIB", "L''épargne"],
          "correct": 1,
          "explanation": "Ce que le pays doit payer chaque année"
        },
        {
          "question": "IDE signifie:",
          "options": ["Indice de Développement Économique", "Investissement Direct Etranger", "Importation Directe Exterieure", "Impot Direct aux Entreprises"],
          "correct": 1,
          "explanation": "Entreprises étrangères investissent dans le pays"
        },
        {
          "question": "Stratégie de promotion des exportations:",
          "options": ["Produire pour le marche local", "Produire pour le marché mondial", "Arreter les importations", "Augmenter les impots"],
          "correct": 1,
          "explanation": "S''ouvrir au commerce mondial, zones franches"
        },
        {
          "question": "Source de financement interne:",
          "options": ["APD", "IDE", "Épargne nationale", "Emprunts internationaux"],
          "correct": 2,
          "explanation": "L''épargne et les impots sont des sources internes"
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 7: La mondialisation: définition, étapes et effets
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'la-mondialisation';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: la-mondialisation';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'mondialisation-définition-étapes-effets',
    'La mondialisation: définition, étapes et effets',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce que la mondialisation ?",
          "answer": "Processus d''intégration des économies mondiales par les échanges commerciaux, financiers, culturels et technologiques",
          "category": "Définition"
        },
        {
          "question": "Les étapes historiques de la mondialisation ?",
          "answer": "1. Grandes découvertes (XV-XVIe). 2. Révolution industrielle (XIXe). 3. Après 1945 (GATT/OMC). 4. Mondialisation contemporaine (1990+, internet, FMN)",
          "category": "Méthode"
        },
        {
          "question": "Qu''est-ce que le libre-échange ?",
          "answer": "Suppression des barrières douanieres (droits de douane, quotas). Favorise les échanges internationaux",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que le protectionnisme ?",
          "answer": "Protection de l''économie nationale par des barrières: droits de douane, quotas, normes. Contraire du libre-échange",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que l''OMC ?",
          "answer": "Organisation Mondiale du Commerce (1995). Objectif: libéraliser le commerce mondial, regler les differends commerciaux",
          "category": "Définition"
        },
        {
          "question": "Avantages de la mondialisation ?",
          "answer": "Croissance, baisse des prix, transfert de technologie, diversité des produits, accès aux marches mondiaux",
          "category": "Distinction"
        },
        {
          "question": "Inconvenients de la mondialisation ?",
          "answer": "Inégalités accrues, dépendance, perte de souveraineté, délocalisations, dégradation environnementale",
          "category": "Distinction"
        },
        {
          "question": "Qu''est-ce qu''une FMN ?",
          "answer": "Firme Multinationale: entreprise implantee dans plusieurs pays. Acteur cle de la mondialisation (ex: Apple, Total)",
          "category": "Définition"
        }
      ],
      "schema": {
        "title": "La mondialisation: dimensions et effets",
        "nodes": [
          {"id": "n1", "label": "Mondialisation", "x": 400, "y": 40, "type": "main"},
          {"id": "n2", "label": "Dimensions", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Effets", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Commerciale\n(échanges)", "x": 50, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Financière\n(capitaux)", "x": 200, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Culturelle\n(valeurs)", "x": 350, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "Avantages\n(croissance)", "x": 550, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Inconvenients\n(inégalités)", "x": 750, "y": 270, "type": "leaf"},
          {"id": "n9", "label": "Acteurs", "x": 400, "y": 380, "type": "branch"},
          {"id": "n10", "label": "OMC, FMN\nÉtats", "x": 400, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n2", "to": "n6"},
          {"from": "n3", "to": "n7"},
          {"from": "n3", "to": "n8"},
          {"from": "n1", "to": "n9", "label": "qui?"},
          {"from": "n9", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "question": "La mondialisation est:",
          "options": ["Un phénomène récent (2000)", "L''intégration des économies mondiales", "La fermeture des frontières", "Un accord commercial"],
          "correct": 1,
          "explanation": "Processus d''intégration par les échanges"
        },
        {
          "question": "L''OMC a été créée en:",
          "options": ["1945", "1975", "1995", "2005"],
          "correct": 2,
          "explanation": "Organisation Mondiale du Commerce, succèsseur du GATT en 1995"
        },
        {
          "question": "Le protectionnisme utilise:",
          "options": ["Le libre-échange", "Droits de douane et quotas", "Les IDE", "L''APD"],
          "correct": 1,
          "explanation": "Barrieres tarifaires et non-tarifaires"
        },
        {
          "question": "FMN signifie:",
          "options": ["Fonds Monetaire National", "Firme Multinationale", "Fédération Mondiale des Nations", "Financement Mondial Net"],
          "correct": 1,
          "explanation": "Entreprise implantee dans plusieurs pays"
        },
        {
          "question": "Avantage de la mondialisation:",
          "options": ["Inégalités", "Transfert de technologie", "Perte de souveraineté", "Delocalisations"],
          "correct": 1,
          "explanation": "Les pays bénéficiént des innovations technologiques"
        },
        {
          "question": "Inconvenient pour les PED:",
          "options": ["Acces aux marches", "Dependance et inégalités accrues", "Baisse des prix", "Plus de choix"],
          "correct": 1,
          "explanation": "Les PED sont souvent perdants face aux économies puissantes"
        }
      ]
    }'::jsonb
  );

END $$;
