-- ============================================================
-- Fiches for TSECO Comptabilité: Chapters 5 & 6
-- Valorisation des stocks + Résultat analytique
-- Programme SYSCOA/OHADA - Baccalauréat malien
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 5: Valorisation des stocks - CMUP et PEPS
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'valorisation-stocks';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: valorisation-stocks';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'valorisation-stocks-cmup-peps',
    'Valorisation des stocks: CMUP et PEPS',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "question": "Qu''est-ce qu''un stock en comptabilité ?",
          "answer": "Ensemble des biens intervenant dans le cycle d''exploitation: marchandises (achat-revente), matières premières (transformation), produits finis (fabriques). Comptes 31 a 38 du SYSCOA/OHADA",
          "category": "Définition"
        },
        {
          "id": "fc2",
          "question": "Quelle est la formule du CMUP après chaque entrée ?",
          "answer": "CMUP = (Stock initial en valeur + Entrees en valeur) / (Stock initial en quantite + Entrees en quantite). Recalculé à chaque nouvelle entrée en stock",
          "category": "Formule"
        },
        {
          "id": "fc3",
          "question": "Quel est le principe de la méthode PEPS (FIFO) ?",
          "answer": "Premier Entre, Premier Sorti: les sorties sont evaluees au cout des lots les plus anciens. On epuise d''abord le lot le plus ancien avant de passer au suivant",
          "category": "Méthode"
        },
        {
          "id": "fc4",
          "question": "Quelles sont les colonnes d''une fiche de stock ?",
          "answer": "Date | Libelle | Entrees (Q, PU, Montant) | Sorties (Q, PU, Montant) | Stock (Q, PU, Montant). Elle retrace tous les mouvements d''un article",
          "category": "Méthode"
        },
        {
          "id": "fc5",
          "question": "Inventaire permanent vs inventaire intermittent ?",
          "answer": "Permanent: suivi continu des stocks à chaque mouvement (fiche de stock). Intermittent: stocks evalues uniquement en fin de période par comptage physique. Le SYSCOA recommande l''inventaire permanent",
          "category": "Distinction"
        },
        {
          "id": "fc6",
          "question": "Comment comptabilise-t-on la variation de stock de marchandises ?",
          "answer": "Variation = Stock initial - Stock final. Si SI > SF: debit 6031 / credit 31 (destockage, charge). Si SF > SI: debit 31 / credit 6031 (stockage, réduction de charge)",
          "category": "Méthode"
        },
        {
          "id": "fc7",
          "question": "Quelle est la formule du stock final ?",
          "answer": "Stock final = Stock initial + Entrees - Sorties. Cette égalité fondamentale est vérifiée sur la fiche de stock à chaque mouvement",
          "category": "Formule"
        },
        {
          "id": "fc8",
          "question": "CMUP vs PEPS: quelles différences ?",
          "answer": "CMUP: un seul prix moyen, lisse les variations, plus simple. PEPS: plusieurs prix en stock, suit les prix réels, stock final valorise aux prix les plus récents. En période de hausse, PEPS donne un SF plus élevé",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "Valorisation des stocks: méthodes et écritures",
        "nodes": [
          {"id": "n1", "label": "Gestion\ndes stocks", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Méthode\nCMUP", "x": 180, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Méthode\nPEPS/FIFO", "x": 620, "y": 140, "type": "branch"},
          {"id": "n4", "label": "CMUP =\n(SI val + E val)\n/ (SI qte + E qte)", "x": 100, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Prix moyen\nunique", "x": 280, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Sorties au\ncout ancien", "x": 540, "y": 270, "type": "leaf"},
          {"id": "n7", "label": "SF aux prix\nrécents", "x": 720, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Fiche de stock\nDate|Lib|E|S|Stock", "x": 400, "y": 380, "type": "branch"},
          {"id": "n9", "label": "SF = SI\n+ E - S", "x": 220, "y": 480, "type": "leaf"},
          {"id": "n10", "label": "Écritures\n6031/31\n7135/35", "x": 580, "y": 480, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "cout moyen"},
          {"from": "n1", "to": "n3", "label": "lot par lot"},
          {"from": "n2", "to": "n4"},
          {"from": "n2", "to": "n5"},
          {"from": "n3", "to": "n6"},
          {"from": "n3", "to": "n7"},
          {"from": "n1", "to": "n8", "label": "outil de suivi"},
          {"from": "n8", "to": "n9", "label": "equation"},
          {"from": "n8", "to": "n10", "label": "comptabilisation"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Une entreprise à un stock initial de 100 unités a 200 F et recoit 200 unités a 250 F. Quel est le CMUP ?",
          "options": ["200 F", "225 F", "233,33 F", "250 F"],
          "correct": 2,
          "explanation": "CMUP = (100 x 200 + 200 x 250) / (100 + 200) = (20 000 + 50 000) / 300 = 70 000 / 300 = 233,33 F"
        },
        {
          "id": "q2",
          "question": "En méthode PEPS, si le stock contient le lot A (50 unités a 300 F) puis le lot B (80 unités a 350 F), une sortie de 70 unités coute:",
          "options": ["21 000 F", "22 000 F", "24 500 F", "24 000 F"],
          "correct": 1,
          "explanation": "PEPS: on prend d''abord le lot A (50 x 300 = 15 000) puis 20 du lot B (20 x 350 = 7 000). Total = 15 000 + 7 000 = 22 000 F"
        },
        {
          "id": "q3",
          "question": "La formule du stock final est:",
          "options": ["SF = SI - Entrees + Sorties", "SF = SI + Entrees - Sorties", "SF = Entrees - Sorties", "SF = SI + Sorties - Entrees"],
          "correct": 1,
          "explanation": "Stock final = Stock initial + Entrees - Sorties. C''est l''equation fondamentale de la gestion des stocks"
        },
        {
          "id": "q4",
          "question": "L''inventaire permanent permet de:",
          "options": ["Compter les stocks une fois par an", "Suivre les stocks en continu à chaque mouvement", "Evaluer les stocks au prix du marche", "Supprimer les fiches de stock"],
          "correct": 1,
          "explanation": "L''inventaire permanent enregistre chaque entrée et sortie sur la fiche de stock pour un suivi continu"
        },
        {
          "id": "q5",
          "question": "La variation de stock de marchandises se comptabilise avec les comptes:",
          "options": ["601 et 31", "6031 et 31", "701 et 31", "61 et 31"],
          "correct": 1,
          "explanation": "Compte 6031 (Variation de stocks de marchandises) et compte 31 (Stocks de marchandises) selon le plan SYSCOA"
        },
        {
          "id": "q6",
          "question": "En période de hausse des prix, quelle méthode donne le stock final le plus élevé ?",
          "options": ["CMUP", "PEPS", "Les deux donnent le même résultat", "Aucune méthode"],
          "correct": 1,
          "explanation": "En PEPS, les sorties sont aux anciens prix (plus bas) et le stock restant est aux prix récents (plus hauts), donc le SF est plus élevé qu''en CMUP"
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 6: Le résultat analytique - charges et produits
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'resultat-analytique';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: resultat-analytique';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'resultat-analytique-charges-produits',
    'Le résultat analytique: charges et produits',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "question": "Qu''est-ce que la comptabilité analytique ?",
          "answer": "Systeme de calcul des couts et des résultats par produit, activité ou fonction. Contrairement à la comptabilité générale (obligatoire, globale), elle est facultative et détaillée. Outil de gestion interne",
          "category": "Définition"
        },
        {
          "id": "fc2",
          "question": "Charges directes vs charges indirectes ?",
          "answer": "Directes: affectees sans ambiguite à un cout (matière première d''un produit). Indirectes: concernent plusieurs couts, nécessitént une répartition via les centrès d''analyse (loyer, électricité)",
          "category": "Distinction"
        },
        {
          "id": "fc3",
          "question": "Qu''est-ce qu''une charge incorporable et non incorporable ?",
          "answer": "Incorporable: charge de la comptabilité générale retenue dans les couts (achats, salaires). Non incorporable: charge exclue car non liée à l''exploitation normale (charges exceptionnelles, provisions règlementees)",
          "category": "Définition"
        },
        {
          "id": "fc4",
          "question": "Quels sont les centrès d''analyse principaux ?",
          "answer": "Centrès principaux: Approvisionnement, Production, Distribution (fournissent des prestations aux produits). Centre auxiliaire: Administration (reparti sur les autrès centres). Chacun à une unité d''œuvre",
          "category": "Méthode"
        },
        {
          "id": "fc5",
          "question": "Quelle est la formule du cout d''achat ?",
          "answer": "Cout d''achat = Prix d''achat HT + Charges directes d''achat (transport, douane) + Charges indirectes d''approvisionnement (quote-part du centre Approvisionnement)",
          "category": "Formule"
        },
        {
          "id": "fc6",
          "question": "Quelle est la formule du cout de production ?",
          "answer": "Cout de production = Cout d''achat des matières consommees + Charges directes de production (MOD) + Charges indirectes de production (quote-part du centre Production)",
          "category": "Formule"
        },
        {
          "id": "fc7",
          "question": "Quelle est la formule du cout de revient ?",
          "answer": "Cout de revient = Cout de production des produits vendus + Charges directes de distribution + Charges indirectes de distribution (quote-part du centre Distribution)",
          "category": "Formule"
        },
        {
          "id": "fc8",
          "question": "Quelle est la formule du résultat analytique ?",
          "answer": "Résultat analytique = Chiffre d''affaires HT - Cout de revient. Si positif = bénéfice. Si négatif = perte. Il se calculé par produit pour connaître la rentabilité de chaque produit",
          "category": "Formule"
        }
      ],
      "schema": {
        "title": "Détermination du résultat analytique",
        "nodes": [
          {"id": "n1", "label": "Comptabilité\nanalytique", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Charges\ndirectes", "x": 170, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Charges\nindirectes", "x": 630, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Matières\nMOD", "x": 80, "y": 240, "type": "leaf"},
          {"id": "n5", "label": "Centrès d''analyse\nAppro|Prod|Distrib", "x": 630, "y": 240, "type": "leaf"},
          {"id": "n6", "label": "Cout d''achat\nPrix achat +\ncharges appro", "x": 130, "y": 350, "type": "branch"},
          {"id": "n7", "label": "Cout de\nproduction\nCA mat + MOD\n+ ch. prod", "x": 370, "y": 350, "type": "branch"},
          {"id": "n8", "label": "Cout de\nrevient\nCP + ch. distrib", "x": 600, "y": 350, "type": "branch"},
          {"id": "n9", "label": "Chiffre\nd''affaires HT", "x": 250, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Résultat\nanalytique\nCA - CR", "x": 530, "y": 470, "type": "main"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "affectation"},
          {"from": "n1", "to": "n3", "label": "répartition"},
          {"from": "n2", "to": "n4"},
          {"from": "n3", "to": "n5", "label": "cles de répartition"},
          {"from": "n4", "to": "n6"},
          {"from": "n5", "to": "n6"},
          {"from": "n6", "to": "n7", "label": "matières consommees"},
          {"from": "n7", "to": "n8", "label": "produits vendus"},
          {"from": "n9", "to": "n10"},
          {"from": "n8", "to": "n10", "label": "soustraction"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Le cout d''achat de matières premières comprend:",
          "options": ["Uniquement le prix d''achat", "Prix d''achat + charges directes + charges indirectes d''approvisionnement", "Prix d''achat + MOD", "Prix de vente - marge"],
          "correct": 1,
          "explanation": "Cout d''achat = Prix d''achat HT + charges directes d''achat (transport, douane) + quote-part des charges indirectes du centre Approvisionnement"
        },
        {
          "id": "q2",
          "question": "Une entreprise achete 500 kg de matières a 1 000 F/kg, transport 50 000 F, charges indirectes d''approvisionnement 100 000 F. Le cout d''achat total est:",
          "options": ["500 000 F", "550 000 F", "600 000 F", "650 000 F"],
          "correct": 3,
          "explanation": "Cout d''achat = (500 x 1 000) + 50 000 + 100 000 = 500 000 + 50 000 + 100 000 = 650 000 F"
        },
        {
          "id": "q3",
          "question": "Les charges indirectes sont reparties grace a:",
          "options": ["L''affectation directe", "Le tableau de répartition et les cles de répartition", "Le bilan comptable", "Le compte de résultat"],
          "correct": 1,
          "explanation": "Les charges indirectes passent par le tableau de répartition des charges indirectes, avec des cles de répartition pour les ventiler dans les centrès d''analyse"
        },
        {
          "id": "q4",
          "question": "Le cout de production comprend:",
          "options": ["Cout d''achat + charges de distribution", "Cout d''achat des matières consommees + MOD + charges indirectes de production", "Chiffre d''affaires - résultat", "Prix de vente - marge"],
          "correct": 1,
          "explanation": "Cout de production = Cout d''achat des matières consommees + charges directes de production (MOD) + charges indirectes de production"
        },
        {
          "id": "q5",
          "question": "Le résultat analytique d''un produit vendu 5 000 000 F avec un cout de revient de 4 200 000 F est:",
          "options": ["- 800 000 F (perte)", "800 000 F (bénéfice)", "4 200 000 F", "5 000 000 F"],
          "correct": 1,
          "explanation": "Résultat analytique = CA - Cout de revient = 5 000 000 - 4 200 000 = 800 000 F (bénéfice car positif)"
        },
        {
          "id": "q6",
          "question": "Une charge suppletive est:",
          "options": ["Une charge non incorporable", "Une charge fictive ajoutee en analytique mais absente en comptabilité générale", "Une charge exceptionnelle", "Une charge directe"],
          "correct": 1,
          "explanation": "Les charges suppletives (ex: rémunération du travail de l''exploitant, rémunération des capitaux propres) sont intégrées en analytique pour un calcul économique complet, même si elles n''existent pas en comptabilité générale"
        }
      ]
    }'::jsonb
  );

END $$;
