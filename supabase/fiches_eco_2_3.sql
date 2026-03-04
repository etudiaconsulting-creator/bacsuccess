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
