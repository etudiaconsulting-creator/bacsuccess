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
