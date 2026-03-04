-- ============================================================
-- Fiches for TSECO Comptabilité: Chapters 3 & 4
-- Acquisitions d'immobilisations + Amortissements (linéaire et dégressif)
-- Programme SYSCOA/OHADA - Baccalauréat malien TSECO
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 3: Les acquisitions d'immobilisations corporelles
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'acquisitions-immobilisations';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: acquisitions-immobilisations';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'acquisitions-immobilisations-corporelles',
    'Les acquisitions d''immobilisations corporelles',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "question": "Qu''est-ce qu''une immobilisation ?",
          "answer": "Un bien durable destiné a servir de façon permanente à l''activité de l''entreprise (durée d''utilisation > 1 an). Exemples: terrain, batiment, matériel, vehicule.",
          "category": "Définition"
        },
        {
          "id": "fc2",
          "question": "Quels sont les 3 types d''immobilisations selon le SYSCOA ?",
          "answer": "1. Corporelles (biens physiques: terrains, batiments, matériel). 2. Incorporelles (brevets, fonds commercial, logiciels). 3. Financières (titrès de participation, prets, dépôts et cautionnements).",
          "category": "Distinction"
        },
        {
          "id": "fc3",
          "question": "Quelle est la formule du cout d''acquisition ?",
          "answer": "Cout d''acquisition = Prix d''achat HT + Frais accèssoires (transport, installation, montage, droits de douane) + TVA non recuperable. La TVA recuperable n''entre PAS dans le cout.",
          "category": "Formule"
        },
        {
          "id": "fc4",
          "question": "Quel est le rôle du compte 21 dans le SYSCOA ?",
          "answer": "Le compte 21 enregistre les immobilisations corporelles: 22 Terrains, 23 Batiments, 24 Materiel et outillage, 244 Materiel de transport, 245 Materiel de bureau.",
          "category": "Définition"
        },
        {
          "id": "fc5",
          "question": "Comment fonctionne la TVA deductible sur immobilisations ?",
          "answer": "Compte 4451 - TVA recuperable sur immobilisations. Debit au moment de l''acquisition. Elle vient en déduction de la TVA collectee lors de la declaration de TVA.",
          "category": "Méthode"
        },
        {
          "id": "fc6",
          "question": "Comment distinguer une charge d''une immobilisation ?",
          "answer": "Immobilisation: bien durable (> 1 an), augmente le patrimoine, montant significatif. Charge: consommation immédiate ou courante, montant faible, ne modifié pas le patrimoine durablement.",
          "category": "Distinction"
        },
        {
          "id": "fc7",
          "question": "Que sont les frais accèssoires d''acquisition ?",
          "answer": "Frais lies à l''acquisition: transport, frais d''installation et de montage, droits de douane, commissions, honoraires, frais d''acte. Ils sont intégrés au cout d''acquisition de l''immobilisation.",
          "category": "Définition"
        },
        {
          "id": "fc8",
          "question": "Quelle est l''écriture comptable d''acquisition d''un matériel ?",
          "answer": "Debit: 24 Materiel (cout d''acquisition HT) + 4451 TVA recuperable sur immobilisations. Credit: 481 Fournisseurs d''investissement (montant TTC). Ou credit 521 Banque si paiement comptant.",
          "category": "Méthode"
        }
      ],
      "schema": {
        "title": "Les acquisitions d''immobilisations corporelles",
        "nodes": [
          {"id": "n1", "label": "Immobilisations", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Corporelles\n(classe 2)", "x": 130, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Incorporelles", "x": 400, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Financières", "x": 670, "y": 130, "type": "branch"},
          {"id": "n5", "label": "22 Terrains\n23 Batiments\n24 Materiel", "x": 130, "y": 250, "type": "leaf"},
          {"id": "n6", "label": "Cout\nd''acquisition", "x": 350, "y": 280, "type": "branch"},
          {"id": "n7", "label": "Prix d''achat HT\n+ Frais accèssoires\n+ TVA non recup.", "x": 180, "y": 390, "type": "leaf"},
          {"id": "n8", "label": "Écritures\ncomptables", "x": 520, "y": 280, "type": "branch"},
          {"id": "n9", "label": "Debit: 2x Immo\n+ 4451 TVA", "x": 420, "y": 410, "type": "leaf"},
          {"id": "n10", "label": "Credit: 481\nFrs investissement\nou 521 Banque", "x": 650, "y": 410, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n1", "to": "n4"},
          {"from": "n2", "to": "n5", "label": "comptes"},
          {"from": "n2", "to": "n6", "label": "évaluation"},
          {"from": "n2", "to": "n8", "label": "enregistrement"},
          {"from": "n6", "to": "n7"},
          {"from": "n8", "to": "n9", "label": "debit"},
          {"from": "n8", "to": "n10", "label": "credit"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Une entreprise achete un vehicule a 8 000 000 FCFA HT, frais de carte grise 150 000 FCFA, TVA 18%. Quel est le cout d''acquisition ?",
          "options": ["8 000 000 FCFA", "8 150 000 FCFA", "9 440 000 FCFA", "9 617 000 FCFA"],
          "correct": 1,
          "explanation": "Cout d''acquisition = Prix d''achat HT + frais accèssoires = 8 000 000 + 150 000 = 8 150 000 FCFA. La TVA recuperable n''entre pas dans le cout."
        },
        {
          "id": "q2",
          "question": "Quel compte est debite lors de l''acquisition d''un matériel de bureau ?",
          "options": ["6054 Fournitures de bureau", "245 Materiel de bureau", "481 Fournisseurs d''investissement", "4451 TVA recuperable sur immo"],
          "correct": 1,
          "explanation": "Le compte 245 Materiel de bureau et mobilier est debite car c''est une immobilisation corporelle (bien durable > 1 an)."
        },
        {
          "id": "q3",
          "question": "La TVA recuperable sur immobilisations est enregistrée au:",
          "options": ["Credit du compte 4431", "Debit du compte 4451", "Debit du compte 6454", "Credit du compte 4451"],
          "correct": 1,
          "explanation": "Le compte 4451 TVA recuperable sur immobilisations est debite lors de l''acquisition. C''est un droit de créance sur l''État."
        },
        {
          "id": "q4",
          "question": "Un ordinateur achete 350 000 FCFA HT est:",
          "options": ["Toujours une charge", "Toujours une immobilisation", "Une immobilisation s''il sert durablement à l''activité", "Un stock"],
          "correct": 2,
          "explanation": "Un ordinateur est un bien durable (> 1 an) servant à l''activité de l''entreprise, donc c''est une immobilisation (compte 245)."
        },
        {
          "id": "q5",
          "question": "Achat d''une machine 5 000 000 HT, transport 200 000, montage 300 000, TVA 18%. Le montant credite au compte 481 est:",
          "options": ["5 000 000 FCFA", "5 500 000 FCFA", "6 490 000 FCFA", "5 900 000 FCFA"],
          "correct": 2,
          "explanation": "Cout acquisition = 5 000 000 + 200 000 + 300 000 = 5 500 000. TVA = 5 500 000 x 18% = 990 000. Montant TTC credite au 481 = 5 500 000 + 990 000 = 6 490 000 FCFA."
        },
        {
          "id": "q6",
          "question": "Quelle est la différence entre le compte 481 et le compte 401 ?",
          "options": ["Aucune différence", "481 = fournisseurs d''immobilisations, 401 = fournisseurs d''exploitation", "481 = clients, 401 = fournisseurs", "401 = fournisseurs d''immobilisations"],
          "correct": 1,
          "explanation": "Le compte 481 Fournisseurs d''investissement est utilisé pour les achats d''immobilisations. Le compte 401 Fournisseurs est réserve aux achats d''exploitation (marchandises, matières)."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 4: Les amortissements: linéaire et dégressif
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'operations-fin-exercice';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: operations-fin-exercice';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'amortissements-linéaire-dégressif',
    'Les amortissements: linéaire et dégressif',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "question": "Qu''est-ce que l''amortissement ?",
          "answer": "Constatation comptable de la perte de valeur subie par une immobilisation du fait de l''usage, du temps ou du progrès technique. C''est une charge non décaissable enregistrée à la fin de chaque exercice.",
          "category": "Définition"
        },
        {
          "id": "fc2",
          "question": "Quelle est la formule de l''amortissement linéaire ?",
          "answer": "Taux linéaire = 100 / n (n = durée de vie en années). Annuite = Valeur d''origine (VO) / n = VO x taux. L''annuité est constante chaque année.",
          "category": "Formule"
        },
        {
          "id": "fc3",
          "question": "Quelle est la formule de l''amortissement dégressif ?",
          "answer": "Taux dégressif = Taux linéaire x coefficient (1,5 pour 3-4 ans; 2 pour 5-6 ans; 2,5 pour > 6 ans). Annuite = VNC debut x taux dégressif. L''annuité est dégressive (décroissante).",
          "category": "Formule"
        },
        {
          "id": "fc4",
          "question": "Qu''est-ce que la VNC (Valeur Nette Comptable) ?",
          "answer": "VNC = Valeur d''origine - Cumul des amortissements. Elle représenté la valeur residuelle du bien à une date donnée. En fin d''amortissement, VNC = 0 (sauf valeur residuelle prévue).",
          "category": "Définition"
        },
        {
          "id": "fc5",
          "question": "Que contient un tableau d''amortissement ?",
          "answer": "Colonnes: Annee, Base amortissable (VO ou VNC), Taux, Annuite (dotation annuelle), Cumul des amortissements, VNC en fin de période. Le tableau couvre toute la durée de vie du bien.",
          "category": "Méthode"
        },
        {
          "id": "fc6",
          "question": "Qu''est-ce que le prorata temporis ?",
          "answer": "Calcul proportionnel au temps pour l''année d''acquisition. Annuite 1ere année = Annuite complété x nombre de jours / 360 (ou mois/12). L''amortissement debute à la date de mise en service.",
          "category": "Méthode"
        },
        {
          "id": "fc7",
          "question": "Quelle est l''écriture de la dotation aux amortissements ?",
          "answer": "Debit: 681 Dotations aux amortissements d''exploitation. Credit: 28x Amortissements des immobilisations (ex: 284 Amort. matériel). C''est une écriture de fin d''exercice (31 décembre).",
          "category": "Méthode"
        },
        {
          "id": "fc8",
          "question": "Lineaire vs Degressif: quelles différences ?",
          "answer": "Lineaire: annuités constantes, base = VO, tout bien amortissable. Degressif: annuités décroissantes, base = VNC, coefficient multiplicateur, uniquement biens neufs d''une durée >= 3 ans (matériel industriel).",
          "category": "Distinction"
        }
      ],
      "schema": {
        "title": "Les amortissements: linéaire et dégressif",
        "nodes": [
          {"id": "n1", "label": "Amortissement", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Lineaire\n(constant)", "x": 180, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Degressif\n(décroissant)", "x": 620, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Taux = 100/n\nAnnuite = VO/n", "x": 80, "y": 260, "type": "leaf"},
          {"id": "n5", "label": "Base = VO\n(constante)", "x": 270, "y": 260, "type": "leaf"},
          {"id": "n6", "label": "Taux = taux lin.\nx coefficient", "x": 520, "y": 260, "type": "leaf"},
          {"id": "n7", "label": "Base = VNC\n(décroissante)", "x": 720, "y": 260, "type": "leaf"},
          {"id": "n8", "label": "Tableau\nd''amortissement", "x": 400, "y": 360, "type": "branch"},
          {"id": "n9", "label": "Écriture:\n681 (D) / 28x (C)", "x": 220, "y": 470, "type": "leaf"},
          {"id": "n10", "label": "Prorata temporis\n1ere année", "x": 580, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4", "label": "calcul"},
          {"from": "n2", "to": "n5", "label": "base"},
          {"from": "n3", "to": "n6", "label": "calcul"},
          {"from": "n3", "to": "n7", "label": "base"},
          {"from": "n1", "to": "n8", "label": "outil"},
          {"from": "n8", "to": "n9", "label": "comptabilisation"},
          {"from": "n8", "to": "n10", "label": "ajustement"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Un matériel acquis a 6 000 000 FCFA est amorti en linéaire sur 5 ans. Quelle est l''annuité ?",
          "options": ["1 000 000 FCFA", "1 200 000 FCFA", "1 500 000 FCFA", "2 000 000 FCFA"],
          "correct": 1,
          "explanation": "Annuite = VO / n = 6 000 000 / 5 = 1 200 000 FCFA. Taux = 100/5 = 20%."
        },
        {
          "id": "q2",
          "question": "Quel est le taux dégressif pour un bien amorti sur 5 ans ?",
          "options": ["20%", "30%", "40%", "50%"],
          "correct": 2,
          "explanation": "Taux linéaire = 100/5 = 20%. Coefficient pour 5-6 ans = 2. Taux dégressif = 20% x 2 = 40%."
        },
        {
          "id": "q3",
          "question": "Un vehicule de 10 000 000 FCFA amorti en linéaire sur 5 ans. Quelle est la VNC après 3 ans ?",
          "options": ["4 000 000 FCFA", "6 000 000 FCFA", "2 000 000 FCFA", "8 000 000 FCFA"],
          "correct": 0,
          "explanation": "Annuite = 10 000 000 / 5 = 2 000 000. Cumul 3 ans = 2 000 000 x 3 = 6 000 000. VNC = 10 000 000 - 6 000 000 = 4 000 000 FCFA."
        },
        {
          "id": "q4",
          "question": "Un bien acquis le 1er avril est amorti en linéaire (annuité complété = 2 400 000). Quelle dotation pour la 1ere année ?",
          "options": ["2 400 000 FCFA", "1 800 000 FCFA", "600 000 FCFA", "2 000 000 FCFA"],
          "correct": 1,
          "explanation": "Prorata temporis: du 1er avril au 31 décembre = 9 mois. Dotation = 2 400 000 x 9/12 = 1 800 000 FCFA."
        },
        {
          "id": "q5",
          "question": "L''écriture de dotation aux amortissements est:",
          "options": ["Debit 28x / Credit 681", "Debit 681 / Credit 28x", "Debit 2x / Credit 681", "Debit 681 / Credit 2x"],
          "correct": 1,
          "explanation": "Debit 681 Dotations aux amortissements (charge) / Credit 28x Amortissements des immobilisations (diminution de valeur de l''actif)."
        },
        {
          "id": "q6",
          "question": "En amortissement dégressif, la 1ere annuité d''un matériel de 5 000 000 FCFA sur 4 ans est:",
          "options": ["1 250 000 FCFA", "1 500 000 FCFA", "1 875 000 FCFA", "2 500 000 FCFA"],
          "correct": 2,
          "explanation": "Taux linéaire = 100/4 = 25%. Coefficient (3-4 ans) = 1,5. Taux dégressif = 25% x 1,5 = 37,5%. 1ere annuité = 5 000 000 x 37,5% = 1 875 000 FCFA."
        }
      ]
    }'::jsonb
  );

END $$;
