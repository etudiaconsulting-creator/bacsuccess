-- ============================================================
-- BacSuccess - Fiches Comptabilité et Commerce (6 chapitres)
-- Programme SYSCOA/OHADA - Baccalauréat malien TSECO
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 1: Les effets de commerce
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'effets-de-commerce';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: effets-de-commerce'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'effets-de-commerce-lettre-change-billet',
    'Les effets de commerce: lettre de change et billet a ordre',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce qu''un effet de commerce ?", "answer": "Titre négociable représentant une créance à terme. Il permet le paiement différé et peut circuler par endossement. Les principaux sont la lettre de change et le billet a ordre.", "category": "Définition"},
        {"id": "fc2", "question": "Quelle est la différence entre une lettre de change et un billet a ordre ?", "answer": "Lettre de change: émise par le créancier (tireur) qui donne l''ordre au débiteur (tire) de payer. Billet a ordre: émis par le débiteur qui s''engage a payer son créancier. La lettre implique 3 parties, le billet 2 parties.", "category": "Distinction"},
        {"id": "fc3", "question": "Quelles sont les 3 parties d''une lettre de change ?", "answer": "1. Le tireur: celui qui crée la lettre (créancier). 2. Le tire: celui qui doit payer (débiteur). 3. Le bénéficiaire: celui qui recevra le paiement (souvent le tireur lui-même ou un tiers).", "category": "Définition"},
        {"id": "fc4", "question": "Qu''est-ce que l''endossement d''un effet de commerce ?", "answer": "Transfert de la propriété de l''effet à un tiers par signature au dos. L''endosseur transmet ses droits à l''endossataire. Cela permet la circulation de l''effet comme moyen de paiement.", "category": "Définition"},
        {"id": "fc5", "question": "Qu''est-ce que l''escompte bancaire d''un effet ?", "answer": "Operation par laquelle la banque avance au porteur le montant de l''effet avant l''échéance, diminue des agios (intérêts + commissions). Le porteur obtient de la trésorerie immédiate.", "category": "Définition"},
        {"id": "fc6", "question": "Quelles écritures comptables pour la création d''un effet a recevoir ?", "answer": "Chez le tireur: Debit 412 Effets a recevoir / Credit 411 Clients. Chez le tire: Debit 401 Fournisseurs / Credit 402 Effets a payer. Le montant est le nominal de l''effet.", "category": "Méthode"},
        {"id": "fc7", "question": "Quelles écritures pour l''encaissement d''un effet à l''échéance ?", "answer": "Chez le bénéficiaire: Debit 512 Banque / Credit 412 Effets a recevoir (pour le nominal). Chez le tire: Debit 402 Effets a payer / Credit 512 Banque.", "category": "Méthode"},
        {"id": "fc8", "question": "Comment traiter un effet impayé en comptabilité ?", "answer": "Chez le tireur: Debit 411 Clients / Credit 412 Effets a recevoir (rétablissement de la créance). On peut aussi debiter les frais de protet au client. Chez le tire: Debit 402 Effets a payer / Credit 401 Fournisseurs.", "category": "Méthode"}
      ],
      "schema": {
        "title": "Les effets de commerce: types, opérations et comptabilisation",
        "nodes": [
          {"id": "n1", "label": "Effets de\ncommerce", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Lettre de\nchange", "x": 180, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Billet\na ordre", "x": 620, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Tireur\nTire\nBeneficiaire", "x": 60, "y": 250, "type": "leaf"},
          {"id": "n5", "label": "Souscripteur\nBeneficiaire", "x": 700, "y": 250, "type": "leaf"},
          {"id": "n6", "label": "Operations", "x": 400, "y": 260, "type": "branch"},
          {"id": "n7", "label": "Création\n412 / 402", "x": 180, "y": 370, "type": "leaf"},
          {"id": "n8", "label": "Circulation\nEndossement", "x": 400, "y": 370, "type": "leaf"},
          {"id": "n9", "label": "Échéance\nEncaissement", "x": 620, "y": 370, "type": "leaf"},
          {"id": "n10", "label": "Escompte\nAgios bancaires\nImpaye / Protet", "x": 400, "y": 480, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "émise par créancier"},
          {"from": "n1", "to": "n3", "label": "émis par débiteur"},
          {"from": "n2", "to": "n4", "label": "3 parties"},
          {"from": "n3", "to": "n5", "label": "2 parties"},
          {"from": "n1", "to": "n6", "label": "cycle de vie"},
          {"from": "n6", "to": "n7"},
          {"from": "n6", "to": "n8"},
          {"from": "n6", "to": "n9"},
          {"from": "n8", "to": "n10", "label": "ou"},
          {"from": "n9", "to": "n10", "label": "si problème"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Qui est le tireur d''une lettre de change ?", "options": ["Le débiteur qui doit payer", "Le créancier qui crée la lettre", "La banque qui escompte", "Le bénéficiaire final"], "correct": 1, "explanation": "Le tireur est le créancier. Il tire (cree) la lettre de change et donne l''ordre au tire (débiteur) de payer."},
        {"id": "q2", "question": "Lors de la création d''un effet a recevoir, le tireur enregistre:", "options": ["Debit 411 / Credit 412", "Debit 412 / Credit 411", "Debit 512 / Credit 411", "Debit 402 / Credit 401"], "correct": 1, "explanation": "Le tireur débité le compte 412 Effets a recevoir et crédité le compte 411 Clients pour constater la transformation de la créance en effet."},
        {"id": "q3", "question": "Le billet a ordre est émis par:", "options": ["Le créancier", "La banque", "Le débiteur", "Le bénéficiaire"], "correct": 2, "explanation": "Le billet a ordre est émis par le débiteur (souscripteur) qui s''engage a payer le bénéficiaire à l''échéance."},
        {"id": "q4", "question": "L''escompte d''un effet de 500 000 FCFA avec des agios de 12 000 FCFA donne un net en banque de:", "options": ["512 000 FCFA", "500 000 FCFA", "488 000 FCFA", "462 000 FCFA"], "correct": 2, "explanation": "Net en banque = Nominal - Agios = 500 000 - 12 000 = 488 000 FCFA."},
        {"id": "q5", "question": "En cas d''effet impayé, le tireur passe l''écriture:", "options": ["Debit 512 / Credit 412", "Debit 411 / Credit 412", "Debit 412 / Credit 411", "Debit 402 / Credit 512"], "correct": 1, "explanation": "On retablit la créance client: Debit 411 Clients / Credit 412 Effets a recevoir."},
        {"id": "q6", "question": "L''endossement d''un effet de commerce permet de:", "options": ["Annuler la dette", "Transferer l''effet à un tiers", "Prolonger l''échéance", "Reduire le montant"], "correct": 1, "explanation": "L''endossement transmet la propriété de l''effet à un nouveau bénéficiaire (endossataire) par signature au dos du titre."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 2: Le rapprochement bancaire
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'rapprochement-bancaire';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: rapprochement-bancaire'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'rapprochement-bancaire-etat',
    'Le rapprochement bancaire: méthode et état',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce que le rapprochement bancaire ?", "answer": "Technique comptable consistant a comparer le solde du compte 512 Banque (tenu par l''entreprise) avec le solde de l''extrait bancaire (rélevé de la banque) pour expliquer les écarts et regulariser les comptes.", "category": "Définition"},
        {"id": "fc2", "question": "Quelles sont les principales causes d''écart entre le compte 512 et l''extrait bancaire ?", "answer": "1. Cheques émis non encore encaisses par le bénéficiaire. 2. Virements recus non encore comptabilises. 3. Frais et commissions bancaires. 4. Prelevements automatiques. 5. Erreurs d''enregistrement.", "category": "Méthode"},
        {"id": "fc3", "question": "En quoi consiste la méthode de pointage ?", "answer": "Comparer ligne par ligne le compte 512 et l''extrait bancaire. Cocher les opérations identiques. Les opérations non pointees expliquent la différence de solde entre les deux documents.", "category": "Méthode"},
        {"id": "fc4", "question": "Qu''est-ce que l''état de rapprochement ?", "answer": "Tableau a deux colonnes presentant: a gauche le compte 512 et a droite l''extrait bancaire. On part des soldes respectifs, on ajoute/retranche les opérations non pointees. Les soldes rectifies doivent être égaux.", "category": "Définition"},
        {"id": "fc5", "question": "Quelles écritures de régularisation passer après le rapprochement ?", "answer": "On passe uniquement les écritures correspondant aux opérations figurant sur l''extrait bancaire mais pas dans le compte 512: frais bancaires (Debit 627 / Credit 512), virements recus (Debit 512 / Credit 411 ou 7xx).", "category": "Méthode"},
        {"id": "fc6", "question": "Qu''est-ce que le solde réel de la banque ?", "answer": "C''est le solde rectifie obtenu après le rapprochement bancaire. Il correspond au montant réellement disponible sur le compte en banque. Les deux colonnes de l''état de rapprochement doivent aboutir au même solde réel.", "category": "Définition"},
        {"id": "fc7", "question": "Comment les frais bancaires apparaissent-ils dans le rapprochement ?", "answer": "Les frais sont debites par la banque sur l''extrait (donc déjà pris en compte cote banque) mais pas encore enregistrès dans le compte 512. Écriture: Debit 627 Services bancaires + 4456 TVA / Credit 512 Banque.", "category": "Méthode"},
        {"id": "fc8", "question": "Un virement en cours apparait sur l''extrait mais pas au compte 512. Que faire ?", "answer": "Il faut regulariser dans la comptabilité de l''entreprise. Écriture: Debit 512 Banque / Credit 411 Clients (si c''est un règlement client) ou Credit du compte concerne.", "category": "Méthode"}
      ],
      "schema": {
        "title": "Le rapprochement bancaire: méthode et régularisation",
        "nodes": [
          {"id": "n1", "label": "Rapprochement\nbancaire", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Compte 512\n(entreprise)", "x": 160, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Extrait bancaire\n(banque)", "x": 640, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Pointage\nligne par ligne", "x": 400, "y": 220, "type": "branch"},
          {"id": "n5", "label": "Operations\npointees (=)", "x": 180, "y": 320, "type": "leaf"},
          {"id": "n6", "label": "Operations\nnon pointees", "x": 620, "y": 320, "type": "leaf"},
          {"id": "n7", "label": "Écarts\nidentifies", "x": 400, "y": 330, "type": "branch"},
          {"id": "n8", "label": "Cheques non\nencaisses", "x": 100, "y": 430, "type": "leaf"},
          {"id": "n9", "label": "Frais bancaires\nPrelevements", "x": 400, "y": 430, "type": "leaf"},
          {"id": "n10", "label": "État de\nrapprochement\n+ Regularisation", "x": 700, "y": 430, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4", "label": "comparer"},
          {"from": "n3", "to": "n4", "label": "comparer"},
          {"from": "n4", "to": "n5", "label": "concordent"},
          {"from": "n4", "to": "n6", "label": "écarts"},
          {"from": "n6", "to": "n7"},
          {"from": "n7", "to": "n8"},
          {"from": "n7", "to": "n9"},
          {"from": "n7", "to": "n10", "label": "aboutit a"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Le rapprochement bancaire compare:", "options": ["Deux comptes clients", "Le compte 512 et l''extrait bancaire", "Le journal et le grand livre", "Le bilan et le compte de résultat"], "correct": 1, "explanation": "Le rapprochement bancaire confronte le compte 512 Banque tenu par l''entreprise avec l''extrait de compte envoye par la banque."},
        {"id": "q2", "question": "Un cheque de 150 000 FCFA émis par l''entreprise n''est pas encore encaisse. Dans l''état de rapprochement, ce montant figure:", "options": ["Au debit du compte 512", "Au credit du compte 512", "En déduction de l''extrait bancaire", "Il n''apparait pas"], "correct": 2, "explanation": "Le cheque est déjà enregistre au compte 512 (credit) mais la banque ne l''a pas encore débité. On le retranche du solde de l''extrait bancaire."},
        {"id": "q3", "question": "Des frais bancaires de 5 000 FCFA figurent sur l''extrait mais pas au compte 512. L''écriture de régularisation est:", "options": ["Debit 512 / Credit 627", "Debit 627 / Credit 512", "Debit 411 / Credit 512", "Debit 512 / Credit 411"], "correct": 1, "explanation": "Les frais bancaires: Debit 627 Services bancaires / Credit 512 Banque. Cela diminue le solde du compte 512."},
        {"id": "q4", "question": "Apres rapprochement, les soldes rectifies des deux colonnes doivent être:", "options": ["Differents", "Egaux", "Nuls", "Positifs obligatoirement"], "correct": 1, "explanation": "Le principe du rapprochement bancaire est d''aboutir à des soldes rectifies égaux."},
        {"id": "q5", "question": "Le solde du compte 512 est de 800 000 FCFA. L''extrait indique 950 000 FCFA. Cheque émis non encaisse: 200 000. Frais bancaires non enregistres: 50 000. Le solde réel est:", "options": ["800 000 FCFA", "750 000 FCFA", "950 000 FCFA", "700 000 FCFA"], "correct": 1, "explanation": "Solde 512 rectifie: 800 000 - 50 000 = 750 000. Extrait rectifie: 950 000 - 200 000 = 750 000. Le solde réel est 750 000 FCFA."},
        {"id": "q6", "question": "Les écritures de régularisation se passent:", "options": ["Uniquement dans les livres de la banque", "Uniquement dans la comptabilité de l''entreprise", "Dans les deux comptabilités", "Nulle part, c''est juste un état"], "correct": 1, "explanation": "L''entreprise ne regularise que les opérations de l''extrait bancaire absentes du compte 512."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 3: Les acquisitions d'immobilisations corporelles
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'acquisitions-immobilisations';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: acquisitions-immobilisations'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'acquisitions-immobilisations-corporelles',
    'Les acquisitions d''immobilisations corporelles',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce qu''une immobilisation ?", "answer": "Un bien durable destiné a servir de façon permanente à l''activité de l''entreprise (durée d''utilisation > 1 an). Exemples: terrain, batiment, matériel, vehicule.", "category": "Définition"},
        {"id": "fc2", "question": "Quels sont les 3 types d''immobilisations selon le SYSCOA ?", "answer": "1. Corporelles (biens physiques: terrains, batiments, matériel). 2. Incorporelles (brevets, fonds commercial, logiciels). 3. Financières (titrès de participation, prets, dépôts et cautionnements).", "category": "Distinction"},
        {"id": "fc3", "question": "Quelle est la formule du cout d''acquisition ?", "answer": "Cout d''acquisition = Prix d''achat HT + Frais accessoires (transport, installation, montage, droits de douane) + TVA non recuperable. La TVA recuperable n''entre PAS dans le cout.", "category": "Formule"},
        {"id": "fc4", "question": "Quel est le rôle du compte 21 dans le SYSCOA ?", "answer": "Le compte 21 enregistre les immobilisations corporelles: 22 Terrains, 23 Batiments, 24 Materiel et outillage, 244 Materiel de transport, 245 Materiel de bureau.", "category": "Définition"},
        {"id": "fc5", "question": "Comment fonctionne la TVA deductible sur immobilisations ?", "answer": "Compte 4451 - TVA recuperable sur immobilisations. Debit au moment de l''acquisition. Elle vient en déduction de la TVA collectee lors de la declaration de TVA.", "category": "Méthode"},
        {"id": "fc6", "question": "Comment distinguer une charge d''une immobilisation ?", "answer": "Immobilisation: bien durable (> 1 an), augmente le patrimoine, montant significatif. Charge: consommation immédiate ou courante, montant faible, ne modifié pas le patrimoine durablement.", "category": "Distinction"},
        {"id": "fc7", "question": "Que sont les frais accessoires d''acquisition ?", "answer": "Frais lies à l''acquisition: transport, frais d''installation et de montage, droits de douane, commissions, honoraires, frais d''acte. Ils sont intégrés au cout d''acquisition de l''immobilisation.", "category": "Définition"},
        {"id": "fc8", "question": "Quelle est l''écriture comptable d''acquisition d''un matériel ?", "answer": "Debit: 24 Materiel (cout d''acquisition HT) + 4451 TVA recuperable sur immobilisations. Credit: 481 Fournisseurs d''investissement (montant TTC). Ou credit 521 Banque si paiement comptant.", "category": "Méthode"}
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
          {"id": "n7", "label": "Prix d''achat HT\n+ Frais accessoires\n+ TVA non recup.", "x": 180, "y": 390, "type": "leaf"},
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
        {"id": "q1", "question": "Une entreprise achete un vehicule a 8 000 000 FCFA HT, frais de carte grise 150 000 FCFA, TVA 18%. Quel est le cout d''acquisition ?", "options": ["8 000 000 FCFA", "8 150 000 FCFA", "9 440 000 FCFA", "9 617 000 FCFA"], "correct": 1, "explanation": "Cout d''acquisition = Prix d''achat HT + frais accessoires = 8 000 000 + 150 000 = 8 150 000 FCFA. La TVA recuperable n''entre pas dans le cout."},
        {"id": "q2", "question": "Quel compte est débité lors de l''acquisition d''un matériel de bureau ?", "options": ["6054 Fournitures de bureau", "245 Materiel de bureau", "481 Fournisseurs d''investissement", "4451 TVA recuperable sur immo"], "correct": 1, "explanation": "Le compte 245 Materiel de bureau et mobilier est débité car c''est une immobilisation corporelle (bien durable > 1 an)."},
        {"id": "q3", "question": "La TVA recuperable sur immobilisations est enregistrée au:", "options": ["Credit du compte 4431", "Debit du compte 4451", "Debit du compte 6454", "Credit du compte 4451"], "correct": 1, "explanation": "Le compte 4451 TVA recuperable sur immobilisations est débité lors de l''acquisition."},
        {"id": "q4", "question": "Un ordinateur achete 350 000 FCFA HT est:", "options": ["Toujours une charge", "Toujours une immobilisation", "Une immobilisation s''il sert durablement à l''activité", "Un stock"], "correct": 2, "explanation": "Un ordinateur est un bien durable (> 1 an) servant à l''activité de l''entreprise, donc c''est une immobilisation (compte 245)."},
        {"id": "q5", "question": "Achat d''une machine 5 000 000 HT, transport 200 000, montage 300 000, TVA 18%. Le montant crédité au compte 481 est:", "options": ["5 000 000 FCFA", "5 500 000 FCFA", "6 490 000 FCFA", "5 900 000 FCFA"], "correct": 2, "explanation": "Cout acquisition = 5 000 000 + 200 000 + 300 000 = 5 500 000. TVA = 5 500 000 x 18% = 990 000. Montant TTC crédité au 481 = 6 490 000 FCFA."},
        {"id": "q6", "question": "Quelle est la différence entre le compte 481 et le compte 401 ?", "options": ["Aucune différence", "481 = fournisseurs d''immobilisations, 401 = fournisseurs d''exploitation", "481 = clients, 401 = fournisseurs", "401 = fournisseurs d''immobilisations"], "correct": 1, "explanation": "Le compte 481 Fournisseurs d''investissement est utilisé pour les achats d''immobilisations. Le compte 401 est réserve aux achats d''exploitation."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 4: Les amortissements: linéaire et dégressif
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'operations-fin-exercice';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: operations-fin-exercice'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'amortissements-linéaire-dégressif',
    'Les amortissements: linéaire et dégressif',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce que l''amortissement ?", "answer": "Constatation comptable de la perte de valeur subie par une immobilisation du fait de l''usage, du temps ou du progrès technique. C''est une charge non décaissable enregistrée à la fin de chaque exercice.", "category": "Définition"},
        {"id": "fc2", "question": "Quelle est la formule de l''amortissement linéaire ?", "answer": "Taux linéaire = 100 / n (n = durée de vie en années). Annuité = Valeur d''origine (VO) / n = VO x taux. L''annuité est constante chaque année.", "category": "Formule"},
        {"id": "fc3", "question": "Quelle est la formule de l''amortissement dégressif ?", "answer": "Taux dégressif = Taux linéaire x coefficient (1,5 pour 3-4 ans; 2 pour 5-6 ans; 2,5 pour > 6 ans). Annuité = VNC debut x taux dégressif. L''annuité est dégressive (décroissante).", "category": "Formule"},
        {"id": "fc4", "question": "Qu''est-ce que la VNC (Valeur Nette Comptable) ?", "answer": "VNC = Valeur d''origine - Cumul des amortissements. Elle représenté la valeur residuelle du bien à une date donnée. En fin d''amortissement, VNC = 0 (sauf valeur residuelle prévue).", "category": "Définition"},
        {"id": "fc5", "question": "Que contient un tableau d''amortissement ?", "answer": "Colonnes: Annee, Base amortissable (VO ou VNC), Taux, Annuité (dotation annuelle), Cumul des amortissements, VNC en fin de période. Le tableau couvre toute la durée de vie du bien.", "category": "Méthode"},
        {"id": "fc6", "question": "Qu''est-ce que le prorata temporis ?", "answer": "Calcul proportionnel au temps pour l''année d''acquisition. Annuité 1ere année = Annuité complété x nombre de jours / 360 (ou mois/12). L''amortissement debute à la date de mise en service.", "category": "Méthode"},
        {"id": "fc7", "question": "Quelle est l''écriture de la dotation aux amortissements ?", "answer": "Debit: 681 Dotations aux amortissements d''exploitation. Credit: 28x Amortissements des immobilisations (ex: 284 Amort. matériel). C''est une écriture de fin d''exercice (31 décembre).", "category": "Méthode"},
        {"id": "fc8", "question": "Lineaire vs Degressif: quelles différences ?", "answer": "Lineaire: annuités constantes, base = VO, tout bien amortissable. Degressif: annuités décroissantes, base = VNC, coefficient multiplicateur, uniquement biens neufs d''une durée >= 3 ans.", "category": "Distinction"}
      ],
      "schema": {
        "title": "Les amortissements: linéaire et dégressif",
        "nodes": [
          {"id": "n1", "label": "Amortissement", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Lineaire\n(constant)", "x": 180, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Degressif\n(décroissant)", "x": 620, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Taux = 100/n\nAnnuité = VO/n", "x": 80, "y": 260, "type": "leaf"},
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
        {"id": "q1", "question": "Un matériel acquis a 6 000 000 FCFA est amorti en linéaire sur 5 ans. Quelle est l''annuité ?", "options": ["1 000 000 FCFA", "1 200 000 FCFA", "1 500 000 FCFA", "2 000 000 FCFA"], "correct": 1, "explanation": "Annuité = VO / n = 6 000 000 / 5 = 1 200 000 FCFA. Taux = 100/5 = 20%."},
        {"id": "q2", "question": "Quel est le taux dégressif pour un bien amorti sur 5 ans ?", "options": ["20%", "30%", "40%", "50%"], "correct": 2, "explanation": "Taux linéaire = 100/5 = 20%. Coefficient pour 5-6 ans = 2. Taux dégressif = 20% x 2 = 40%."},
        {"id": "q3", "question": "Un vehicule de 10 000 000 FCFA amorti en linéaire sur 5 ans. VNC après 3 ans ?", "options": ["4 000 000 FCFA", "6 000 000 FCFA", "2 000 000 FCFA", "8 000 000 FCFA"], "correct": 0, "explanation": "Annuité = 10 000 000 / 5 = 2 000 000. Cumul 3 ans = 6 000 000. VNC = 10 000 000 - 6 000 000 = 4 000 000 FCFA."},
        {"id": "q4", "question": "Un bien acquis le 1er avril est amorti en linéaire (annuité complété = 2 400 000). Dotation 1ere année ?", "options": ["2 400 000 FCFA", "1 800 000 FCFA", "600 000 FCFA", "2 000 000 FCFA"], "correct": 1, "explanation": "Prorata temporis: du 1er avril au 31 décembre = 9 mois. Dotation = 2 400 000 x 9/12 = 1 800 000 FCFA."},
        {"id": "q5", "question": "L''écriture de dotation aux amortissements est:", "options": ["Debit 28x / Credit 681", "Debit 681 / Credit 28x", "Debit 2x / Credit 681", "Debit 681 / Credit 2x"], "correct": 1, "explanation": "Debit 681 Dotations aux amortissements (charge) / Credit 28x Amortissements des immobilisations."},
        {"id": "q6", "question": "En amortissement dégressif, la 1ere annuité d''un matériel de 5 000 000 FCFA sur 4 ans est:", "options": ["1 250 000 FCFA", "1 500 000 FCFA", "1 875 000 FCFA", "2 500 000 FCFA"], "correct": 2, "explanation": "Taux linéaire = 25%. Coefficient (3-4 ans) = 1,5. Taux dégressif = 37,5%. 1ere annuité = 5 000 000 x 37,5% = 1 875 000 FCFA."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 5: Valorisation des stocks: CMUP et PEPS
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'valorisation-stocks';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: valorisation-stocks'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'valorisation-stocks-cmup-peps',
    'Valorisation des stocks: CMUP et PEPS',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce qu''un stock en comptabilité ?", "answer": "Ensemble des biens intervenant dans le cycle d''exploitation: marchandises (achat-revente), matières premières (transformation), produits finis (fabriques). Comptes 31 a 38 du SYSCOA/OHADA", "category": "Définition"},
        {"id": "fc2", "question": "Quelle est la formule du CMUP après chaque entrée ?", "answer": "CMUP = (Stock initial en valeur + Entrees en valeur) / (Stock initial en quantité + Entrees en quantité). Recalculé à chaque nouvelle entrée en stock", "category": "Formule"},
        {"id": "fc3", "question": "Quel est le principe de la méthode PEPS (FIFO) ?", "answer": "Premier Entre, Premier Sorti: les sorties sont evaluees au cout des lots les plus anciens. On epuise d''abord le lot le plus ancien avant de passer au suivant", "category": "Méthode"},
        {"id": "fc4", "question": "Quelles sont les colonnes d''une fiche de stock ?", "answer": "Date | Libelle | Entrees (Q, PU, Montant) | Sorties (Q, PU, Montant) | Stock (Q, PU, Montant). Elle retrace tous les mouvements d''un article", "category": "Méthode"},
        {"id": "fc5", "question": "Inventaire permanent vs inventaire intermittent ?", "answer": "Permanent: suivi continu des stocks à chaque mouvement (fiche de stock). Intermittent: stocks evalues uniquement en fin de période par comptage physique. Le SYSCOA recommande l''inventaire permanent", "category": "Distinction"},
        {"id": "fc6", "question": "Comment comptabilise-t-on la variation de stock de marchandises ?", "answer": "Variation = Stock initial - Stock final. Si SI > SF: debit 6031 / credit 31 (destockage, charge). Si SF > SI: debit 31 / credit 6031 (stockage, réduction de charge)", "category": "Méthode"},
        {"id": "fc7", "question": "Quelle est la formule du stock final ?", "answer": "Stock final = Stock initial + Entrees - Sorties. Cette égalité fondamentale est vérifiée sur la fiche de stock à chaque mouvement", "category": "Formule"},
        {"id": "fc8", "question": "CMUP vs PEPS: quelles différences ?", "answer": "CMUP: un seul prix moyen, lisse les variations, plus simple. PEPS: plusieurs prix en stock, suit les prix réels, stock final valorise aux prix les plus récents. En période de hausse, PEPS donne un SF plus élevé", "category": "Distinction"}
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
        {"id": "q1", "question": "Stock initial de 100 unités a 200 F, entrée de 200 unités a 250 F. Quel est le CMUP ?", "options": ["200 F", "225 F", "233,33 F", "250 F"], "correct": 2, "explanation": "CMUP = (100 x 200 + 200 x 250) / (100 + 200) = 70 000 / 300 = 233,33 F"},
        {"id": "q2", "question": "En PEPS, stock = lot A (50 a 300 F) + lot B (80 a 350 F). Sortie de 70 unités coute:", "options": ["21 000 F", "22 000 F", "24 500 F", "24 000 F"], "correct": 1, "explanation": "PEPS: 50 x 300 = 15 000 (lot A) + 20 x 350 = 7 000 (lot B). Total = 22 000 F"},
        {"id": "q3", "question": "La formule du stock final est:", "options": ["SF = SI - Entrees + Sorties", "SF = SI + Entrees - Sorties", "SF = Entrees - Sorties", "SF = SI + Sorties - Entrees"], "correct": 1, "explanation": "Stock final = Stock initial + Entrees - Sorties. Equation fondamentale de la gestion des stocks."},
        {"id": "q4", "question": "L''inventaire permanent permet de:", "options": ["Compter les stocks une fois par an", "Suivre les stocks en continu à chaque mouvement", "Evaluer les stocks au prix du marche", "Supprimer les fiches de stock"], "correct": 1, "explanation": "L''inventaire permanent enregistre chaque entrée et sortie sur la fiche de stock pour un suivi continu."},
        {"id": "q5", "question": "La variation de stock de marchandises se comptabilise avec les comptes:", "options": ["601 et 31", "6031 et 31", "701 et 31", "61 et 31"], "correct": 1, "explanation": "Compte 6031 (Variation de stocks de marchandises) et compte 31 (Stocks de marchandises) selon le plan SYSCOA."},
        {"id": "q6", "question": "En période de hausse des prix, quelle méthode donne le stock final le plus élevé ?", "options": ["CMUP", "PEPS", "Les deux donnent le même résultat", "Aucune méthode"], "correct": 1, "explanation": "En PEPS, les sorties sont aux anciens prix (plus bas) et le stock restant est aux prix récents (plus hauts)."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 6: Le résultat analytique: charges et produits
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'resultat-analytique';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: resultat-analytique'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'resultat-analytique-charges-produits',
    'Le résultat analytique: charges et produits',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce que la comptabilité analytique ?", "answer": "Systeme de calcul des couts et des résultats par produit, activité ou fonction. Contrairement à la comptabilité générale (obligatoire, globale), elle est facultative et détaillée. Outil de gestion interne", "category": "Définition"},
        {"id": "fc2", "question": "Charges directes vs charges indirectes ?", "answer": "Directes: affectees sans ambiguite à un cout (matière première d''un produit). Indirectes: concernent plusieurs couts, nécessitént une répartition via les centrès d''analyse (loyer, électricité)", "category": "Distinction"},
        {"id": "fc3", "question": "Qu''est-ce qu''une charge incorporable et non incorporable ?", "answer": "Incorporable: charge de la comptabilité générale retenue dans les couts (achats, salaires). Non incorporable: charge exclue car non liée à l''exploitation normale (charges exceptionnelles, provisions règlementees)", "category": "Définition"},
        {"id": "fc4", "question": "Quels sont les centrès d''analyse principaux ?", "answer": "Centrès principaux: Approvisionnement, Production, Distribution (fournissent des prestations aux produits). Centre auxiliaire: Administration (reparti sur les autrès centres). Chacun à une unité d''œuvre", "category": "Méthode"},
        {"id": "fc5", "question": "Quelle est la formule du cout d''achat ?", "answer": "Cout d''achat = Prix d''achat HT + Charges directes d''achat (transport, douane) + Charges indirectes d''approvisionnement (quote-part du centre Approvisionnement)", "category": "Formule"},
        {"id": "fc6", "question": "Quelle est la formule du cout de production ?", "answer": "Cout de production = Cout d''achat des matières consommees + Charges directes de production (MOD) + Charges indirectes de production (quote-part du centre Production)", "category": "Formule"},
        {"id": "fc7", "question": "Quelle est la formule du cout de revient ?", "answer": "Cout de revient = Cout de production des produits vendus + Charges directes de distribution + Charges indirectes de distribution (quote-part du centre Distribution)", "category": "Formule"},
        {"id": "fc8", "question": "Quelle est la formule du résultat analytique ?", "answer": "Résultat analytique = Chiffre d''affaires HT - Cout de revient. Si positif = bénéfice. Si négatif = perte. Il se calculé par produit pour connaître la rentabilité de chaque produit", "category": "Formule"}
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
        {"id": "q1", "question": "Le cout d''achat de matières premières comprend:", "options": ["Uniquement le prix d''achat", "Prix d''achat + charges directes + charges indirectes d''approvisionnement", "Prix d''achat + MOD", "Prix de vente - marge"], "correct": 1, "explanation": "Cout d''achat = Prix d''achat HT + charges directes d''achat + quote-part des charges indirectes du centre Approvisionnement."},
        {"id": "q2", "question": "500 kg de matières a 1 000 F/kg, transport 50 000 F, charges indirectes d''approvisionnement 100 000 F. Cout d''achat total:", "options": ["500 000 F", "550 000 F", "600 000 F", "650 000 F"], "correct": 3, "explanation": "Cout d''achat = (500 x 1 000) + 50 000 + 100 000 = 650 000 F"},
        {"id": "q3", "question": "Les charges indirectes sont reparties grace a:", "options": ["L''affectation directe", "Le tableau de répartition et les cles de répartition", "Le bilan comptable", "Le compte de résultat"], "correct": 1, "explanation": "Les charges indirectes passent par le tableau de répartition avec des cles de répartition pour les ventiler dans les centrès d''analyse."},
        {"id": "q4", "question": "Le cout de production comprend:", "options": ["Cout d''achat + charges de distribution", "Cout d''achat des matières consommees + MOD + charges indirectes de production", "Chiffre d''affaires - résultat", "Prix de vente - marge"], "correct": 1, "explanation": "Cout de production = Cout d''achat des matières consommees + charges directes de production (MOD) + charges indirectes de production."},
        {"id": "q5", "question": "Résultat analytique d''un produit vendu 5 000 000 F avec un cout de revient de 4 200 000 F:", "options": ["- 800 000 F (perte)", "800 000 F (bénéfice)", "4 200 000 F", "5 000 000 F"], "correct": 1, "explanation": "Résultat analytique = CA - Cout de revient = 5 000 000 - 4 200 000 = 800 000 F (bénéfice)."},
        {"id": "q6", "question": "Une charge supplétive est:", "options": ["Une charge non incorporable", "Une charge fictive ajoutée en analytique mais absente en comptabilité générale", "Une charge exceptionnelle", "Une charge directe"], "correct": 1, "explanation": "Les charges supplétives sont intégrées en analytique pour un calcul économique complet, même si elles n''existent pas en comptabilité générale."}
      ]
    }'::jsonb
  );

END $$;
-- ============================================================
-- BacSuccess - Fiches Philosophie (3 chapitres)
-- Programme Philosophie - Baccalauréat malien TSECO
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 1: Histoire de la philosophie
  -- Aristote, Rousseau et Guisse
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'histoire-philosophie';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: histoire-philosophie'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'histoire-philosophie-aristote-rousseau',
    'Histoire de la philosophie: Aristote, Rousseau et Guisse',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Quelles sont les 4 causes selon Aristote ?", "answer": "1. Cause matérielle: la matière dont une chose est faite. 2. Cause formelle: la formé ou l''essence de la chose. 3. Cause efficiente: l''agent qui produit la chose. 4. Cause finale: le but ou la fin pour laquelle la chose existe. Exemple: une statue - le marbre (matérielle), la formé de la statue (formelle), le sculpteur (efficiente), la beauté (finale).", "category": "Définition"},
        {"id": "fc2", "question": "Qu''est-ce que l''éthique du juste milieu chez Aristote ?", "answer": "La vertu est un juste milieu entre deux excès (vices). Le courage est le milieu entre la lâcheté (défaut) et la témérité (excès). La générosité est le milieu entre l''avarice et la prodigalité. Il ne s''agit pas d''une médiocrité mais d''un équilibre raisonnable déterminé par la prudence (phronesis).", "category": "Définition"},
        {"id": "fc3", "question": "Pourquoi Aristote dit-il que l''homme est un animal politique ?", "answer": "Pour Aristote, l''homme est par nature un être social (zoon politikon). Il ne peut s''accomplir pleinement qu''au sein de la cite (polis). Seul un dieu ou une bete peut vivre hors de la société. La cite existe par nature et est antérieure à l''individu, car le tout précède les parties.", "category": "Définition"},
        {"id": "fc4", "question": "Qu''est-ce que le contrat social selon Rousseau ?", "answer": "Pacte par lequel les individus rénoncént a leur liberté naturelle pour obtenir la liberté civile et la protection de la communauté. Chacun s''unit a tous et n''obeit pourtant qu''a lui-même en obeissant à la volonté générale. Le souverain est le peuple tout entier.", "category": "Définition"},
        {"id": "fc5", "question": "Quelle est la différence entre l''état de nature et la société civile chez Rousseau ?", "answer": "État de nature: l''homme est libre, egal, bon et solitaire. Il vit selon ses besoins naturels. Société civile: nait avec la propriété privée qui créé les inégalités, la dépendance et la corruption morale. Rousseau ne propose pas un retour à l''état de nature mais un contrat social juste.", "category": "Distinction"},
        {"id": "fc6", "question": "Qu''est-ce que la volonté générale chez Rousseau ?", "answer": "La volonté générale vise l''intérêt commun de tous les citoyens. Elle se distingue de la volonté de tous (somme des intérêts particuliers). Elle est toujours droite et ne peut errer. La loi est l''expression de la volonté générale. Chaque citoyen participe à la souveraineté en contribuant à la volonté générale.", "category": "Distinction"},
        {"id": "fc7", "question": "Qu''est-ce que la philosophie africaine et le mouvement de la négritude ?", "answer": "La philosophie africaine affirme l''existence d''une pensée proprement africaine, fondée sur les traditions, l''oralite et la communauté. La négritude (Senghor, Césaire) valorise l''identité noire et la culture africaine face à la domination coloniale. Elle revendique la dignité et la contribution de l''Afrique à la civilisation universelle.", "category": "Définition"},
        {"id": "fc8", "question": "Quelle est la contribution de Youssouph Tata Guisse à la pensée africaine ?", "answer": "Guisse s''inscrit dans le courant de la philosophie africaine qui defend le dialogue des civilisations. Il soutient que l''Afrique possède une rationalite propre et que les cultures africaines doivent participer au dialogue universel sur un pied d''égalité. Il critique l''eurocentrisme en philosophie et valorise l''heritage intellectuel africain.", "category": "Définition"}
      ],
      "schema": {
        "title": "Histoire de la philosophie: Aristote, Rousseau et Guisse",
        "nodes": [
          {"id": "n1", "label": "Histoire de\nla philosophie", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "ARISTOTE\n(Grece antique)", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "ROUSSEAU\n(Lumières)", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "GUISSE\n(Afrique)", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "4 causes\nJuste milieu\nSyllogisme", "x": 50, "y": 280, "type": "leaf"},
          {"id": "n6", "label": "Animal politique\nClassification\ndes sciences", "x": 220, "y": 280, "type": "leaf"},
          {"id": "n7", "label": "Contrat social\nVolonté générale", "x": 340, "y": 280, "type": "leaf"},
          {"id": "n8", "label": "État de nature\nEmile\nInégalité", "x": 490, "y": 280, "type": "leaf"},
          {"id": "n9", "label": "Négritude\nIdentite africaine", "x": 630, "y": 280, "type": "leaf"},
          {"id": "n10", "label": "Dialogue des\ncivilisations", "x": 750, "y": 280, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "antiquite"},
          {"from": "n1", "to": "n3", "label": "XVIIIe siècle"},
          {"from": "n1", "to": "n4", "label": "contemporain"},
          {"from": "n2", "to": "n5", "label": "logique/éthique"},
          {"from": "n2", "to": "n6", "label": "politique"},
          {"from": "n3", "to": "n7", "label": "théorie politique"},
          {"from": "n3", "to": "n8", "label": "éducation/critique"},
          {"from": "n4", "to": "n9", "label": "identité"},
          {"from": "n4", "to": "n10", "label": "universalisme"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Quelle cause aristotélicienne désigne le but pour lequel une chose existe ?", "options": ["La cause matérielle", "La cause formelle", "La cause efficiente", "La cause finale"], "correct": 3, "explanation": "La cause finale est le but, la finalité pour laquelle une chose est produite. Par exemple, la santé est la cause finale de la médecine."},
        {"id": "q2", "question": "L''éthique du juste milieu d''Aristote signifie que la vertu est:", "options": ["L''absence de passion", "Un équilibre entre deux excès", "La soumission à la loi", "Le rejet de tout plaisir"], "correct": 1, "explanation": "Pour Aristote, la vertu (arete) est un juste milieu entre deux vices: l''un par excès et l''autre par défaut. Le courage est entre la lâcheté et la témérité."},
        {"id": "q3", "question": "Selon Rousseau, qu''est-ce qui marque le passage de l''état de nature à la société civile ?", "options": ["La guerre", "La propriété privée", "La religion", "Le commerce"], "correct": 1, "explanation": "Rousseau écrit dans le Discours sur l''inégalité que le premier qui dit ''ceci est a moi'' et fonda la propriété privée est le vrai fondateur de la société civile et de ses inégalités."},
        {"id": "q4", "question": "La volonté générale chez Rousseau vise:", "options": ["L''intérêt du plus fort", "L''intérêt particulier du prince", "L''intérêt commun de tous", "L''intérêt de la majorité seulement"], "correct": 2, "explanation": "La volonté générale vise toujours l''intérêt commun. Elle se distingue de la volonté de tous qui est la simple somme des volontés particulières."},
        {"id": "q5", "question": "Qu''est-ce que la négritude ?", "options": ["Un mouvement économique africain", "Un courant valorisant l''identité et la culture noire", "Une théorie scientifique", "Un parti politique"], "correct": 1, "explanation": "La négritude est un mouvement littéraire et philosophique (Senghor, Césaire, Damas) qui affirme et valorise l''identité culturelle noire face à l''assimilation coloniale."},
        {"id": "q6", "question": "Pour Aristote, l''homme est un ''animal politique'' car:", "options": ["Il aime le pouvoir", "Il ne peut s''accomplir que dans la cite", "Il est violent par nature", "Il obeit à un chef"], "correct": 1, "explanation": "Aristote affirme que l''homme est un zoon politikon: il est fait pour vivre en communauté dans la cite (polis). Seul un dieu ou une bete peut vivre isole."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 2: L'homme et le monde - Étude thématique
  -- Conscience, liberté, travail, justice, vérité
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'homme-et-monde';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: homme-et-monde'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'homme-et-monde-themes',
    'L''homme et le monde: étude thématique',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce que la conscience selon Descartes (le cogito) ?", "answer": "Le cogito (''je pense, donc je suis'') est la première certitude indubitable. La conscience est la capacité de l''esprit a se connaître lui-même et a connaître le monde. Pour Descartes, la pensée (conscience) est l''essence même du sujet. Le doute méthodique conduit à cette evidence première.", "category": "Définition"},
        {"id": "fc2", "question": "Qu''est-ce que l''inconscient selon Freud ?", "answer": "L''inconscient est la partie de la vie psychique qui échappe à la conscience. Il contient des désirs refoulés, des pulsions et des souvenirs oubliés. Freud distingue 3 instances: le Ca (pulsions), le Moi (médiateur) et le Surmoi (morale intériorisée). L''inconscient se manifeste dans les rêves, les lapsus et les actes manqués.", "category": "Définition"},
        {"id": "fc3", "question": "Qu''est-ce que le libre arbitre ?", "answer": "Capacite de la volonté a se déterminer elle-même, a choisir librement entre plusieurs possibilités. Le libre arbitre suppose que l''homme n''est pas entièrement déterminé par des causes extérieures. Il est le fondement de la responsabilité morale: on ne peut être juge coupable que si l''on pouvait agir autrement.", "category": "Définition"},
        {"id": "fc4", "question": "Qu''est-ce que le déterminisme et comment s''oppose-t-il à la liberté ?", "answer": "Le déterminisme est la doctrine selon laquelle tout événement est la conséquence nécessaire de causes antérieures. En sciences, tout phénomène à une cause. Applique à l''homme, cela signifie que nos choix seraient predéterminés par l''hérédité, le milieu social, l''éducation. L''existentialisme de Sartre s''y oppose: l''homme est condamne a être libre.", "category": "Distinction"},
        {"id": "fc5", "question": "Qu''est-ce que l''alienation du travail selon Marx ?", "answer": "Pour Marx, le travailleur salarie est aliene (rendu étranger a lui-même) car: 1. Il ne possède pas le produit de son travail. 2. Il ne contrôle pas le procèssus de production. 3. Son travail est repetitif et déshumanisant. 4. Il est separe des autrès travailleurs par la competition. Le travail devrait être une réalisation de soi mais le capitalisme le transformé en exploitation.", "category": "Définition"},
        {"id": "fc6", "question": "Quelle est la différence entre droit naturel et droit positif ?", "answer": "Droit naturel: ensemble de principes universels et immuables inscrits dans la nature humaine (droit à la vie, à la liberté). Il précède toute législation. Droit positif: ensemble des lois ecrites et en vigueur dans une société donnée, à un moment donne. Le droit positif devrait idealement s''inspirer du droit naturel.", "category": "Distinction"},
        {"id": "fc7", "question": "Qu''est-ce que la vérité et en quoi differe-t-elle de l''opinion ?", "answer": "La vérité est un jugement conformé à la réalité, fondé sur la raison et la démonstration. L''opinion (doxa) est une croyance subjective, non fondée rationnellement, souvent issue des apparences ou des préjugés. Platon oppose la doxa (monde sensible, illusion) à l''épistémè (connaissance vraie, monde intelligible).", "category": "Distinction"},
        {"id": "fc8", "question": "Qu''est-ce que l''allégorie de la caverne de Platon ?", "answer": "Dans la République, Platon décrit des prisonniers enchaînés dans une caverne, ne voyant que des ombres projetées sur un mur. Ils prennent ces ombres pour la réalité. Un prisonnier libéré découvre le monde extérieur (la vérité). L''allégorie illustre le passage de l''ignorance (opinion/doxa) à la connaissance (épistémè) par l''éducation philosophique.", "category": "Méthode"}
      ],
      "schema": {
        "title": "L''homme et le monde: grands thèmes philosophiques",
        "nodes": [
          {"id": "n1", "label": "L''homme et\nle monde", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Conscience /\nInconscient", "x": 100, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Liberté /\nDeterminisme", "x": 280, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Travail /\nTechnique", "x": 460, "y": 150, "type": "branch"},
          {"id": "n5", "label": "Justice /\nDroit", "x": 620, "y": 150, "type": "branch"},
          {"id": "n6", "label": "Vérité /\nOpinion", "x": 760, "y": 150, "type": "branch"},
          {"id": "n7", "label": "Descartes: cogito\nFreud: Ca/Moi/Surmoi", "x": 100, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Libre arbitre\nSartre: existence\nprécède essence", "x": 280, "y": 300, "type": "leaf"},
          {"id": "n9", "label": "Marx: alienation\nProgres technique", "x": 460, "y": 300, "type": "leaf"},
          {"id": "n10", "label": "Droit naturel vs positif\nPlaton: doxa vs épistémè\nAllegorie caverne", "x": 680, "y": 300, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n1", "to": "n4"},
          {"from": "n1", "to": "n5"},
          {"from": "n1", "to": "n6"},
          {"from": "n2", "to": "n7", "label": "penseurs"},
          {"from": "n3", "to": "n8", "label": "débat"},
          {"from": "n4", "to": "n9", "label": "critique"},
          {"from": "n5", "to": "n10", "label": "distinctions"},
          {"from": "n6", "to": "n10", "label": "connaissance"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Le cogito de Descartes (''je pense, donc je suis'') etablit:", "options": ["L''existence de Dieu", "La certitude de la conscience comme première vérité", "La primaute du corps sur l''esprit", "L''impossibilité de connaître"], "correct": 1, "explanation": "Le cogito est la première certitude indubitable: même si je doute de tout, je ne peux douter que je pense, donc j''existe en tant que sujet pensant."},
        {"id": "q2", "question": "Les trois instances de l''appareil psychique selon Freud sont:", "options": ["Corps, ame, esprit", "Raison, volonté, désir", "Ca, Moi, Surmoi", "Conscient, préconscient, souvenir"], "correct": 2, "explanation": "Freud distingue le Ca (pulsions inconscientes), le Moi (instance médiatrice avec la réalité) et le Surmoi (morale intériorisée, interdits parentaux et sociaux)."},
        {"id": "q3", "question": "Selon Sartre, ''l''existence précède l''essence'' signifie que:", "options": ["L''homme à une nature fixe des la naissance", "L''homme se definit par ses choix et ses actes", "La liberté est une illusion", "Dieu déterminé notre destin"], "correct": 1, "explanation": "Pour Sartre, l''homme n''a pas de nature predéterminée. Il existe d''abord, puis se definit par ses choix. Il est ''condamne a être libre'' et pleinement responsable de ce qu''il devient."},
        {"id": "q4", "question": "L''alienation du travail chez Marx désigne:", "options": ["Le plaisir que procure le travail", "Le fait que le travailleur est depossède du produit et du sens de son travail", "La fatigue physique au travail", "Le chômage volontaire"], "correct": 1, "explanation": "Pour Marx, le travailleur aliene ne se reconnait pas dans le produit de son travail. Il est réduit à une marchandise et perd son humanite dans un procèssus qu''il ne contrôle pas."},
        {"id": "q5", "question": "Dans l''allégorie de la caverne de Platon, les ombres sur le mur représentent:", "options": ["La vérité absolue", "Les opinions et les apparences trompeuses", "Les idées pures", "La connaissance scientifique"], "correct": 1, "explanation": "Les ombres représentent le monde des apparences, les opinions (doxa) que les hommes prennent pour la réalité. La sortie de la caverne symbolise l''accès à la connaissance vraie (épistémè) par la philosophie."},
        {"id": "q6", "question": "La différence entre droit naturel et droit positif est que:", "options": ["Le droit naturel est écrit et le droit positif est oral", "Le droit naturel est universel et le droit positif est propre à chaque société", "Le droit positif est supérieur au droit naturel", "Il n''y a aucune différence"], "correct": 1, "explanation": "Le droit naturel repose sur des principes universels (vie, liberté, égalité) inscrits dans la nature humaine. Le droit positif est l''ensemble des lois adoptées par une société, variables selon les epoques et les pays."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 3: Étude d'œuvres
  -- Montesquieu, Marx et Nkrumah
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'etude-oeuvres';
  IF v_chapter_id IS NULL THEN RAISE EXCEPTION 'Chapter not found: etude-oeuvres'; END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'etude-oeuvres-montesquieu-marx-nkrumah',
    'Étude d''œuvres: Montesquieu, Marx et Nkrumah',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "question": "Qu''est-ce que la separation des pouvoirs selon Montesquieu ?", "answer": "Dans L''Esprit des lois (1748), Montesquieu theorise la separation des trois pouvoirs: legislatif (faire les lois), exécutif (les appliquer) et judiciaire (juger les litiges). Chaque pouvoir doit être exercé par un organe différent pour eviter la tyrannie. ''Pour qu''on ne puisse abuser du pouvoir, il faut que le pouvoir arrêté le pouvoir.''", "category": "Définition"},
        {"id": "fc2", "question": "Quels sont les trois types de gouvernement selon Montesquieu ?", "answer": "1. République: le peuple ou une partie du peuple gouverne. Son principe est la vertu (amour des lois et de la patrie). 2. Monarchie: un seul gouverne selon des lois fixes. Son principe est l''honneur. 3. Despotisme: un seul gouverne sans loi, selon sa volonté. Son principe est la crainte.", "category": "Distinction"},
        {"id": "fc3", "question": "Qu''est-ce que le materialisme historique de Marx ?", "answer": "Theorie selon laquelle l''histoire des sociétés est déterminée par les conditions matérielles de production (infrastructure économique). Les rapports de production (qui possède les moyens de production) determinent la superstructure (institutions politiques, droit, ideologie, religion, culture). Le moteur de l''histoire est la lutte des classes.", "category": "Définition"},
        {"id": "fc4", "question": "Qu''est-ce que la lutte des classes selon Marx ?", "answer": "Conflit fondamental entre les classes sociales aux intérêts opposes. Dans le capitalisme: la bourgeoisie (proprietaire des moyens de production) exploite le prôletariat (qui vend sa force de travail). Cette contradiction mene à la révolution prôletarienne et à l''avenement d''une société sans classes (communisme).", "category": "Définition"},
        {"id": "fc5", "question": "Qu''est-ce que la plus-value chez Marx ?", "answer": "Difference entre la valeur produite par le travailleur et le salaire qu''il recoit. Le capitaliste s''approprie cette plus-value qui constitue son profit. Exemple: un ouvrier produit 10 000 FCFA de valeur par jour mais n''est paye que 3 000 FCFA. La plus-value est de 7 000 FCFA. C''est le mecanisme fondamental de l''exploitation capitaliste.", "category": "Formule"},
        {"id": "fc6", "question": "Qu''est-ce que le consciencisme de Nkrumah ?", "answer": "Philosophie développée par Kwame Nkrumah dans Le Consciencisme (1964). C''est une synthèse des trois heritages culturels de l''Afrique: la tradition africaine, l''influence islamique et l''influence européenne/chretienne. Le consciencisme vise a decolonisér la pensée africaine et a fonder une société socialiste africaine authentique.", "category": "Définition"},
        {"id": "fc7", "question": "Qu''est-ce que le panafricanisme de Nkrumah ?", "answer": "Mouvement politique et philosophique visant l''unité de tous les peuples africains. Nkrumah defendait la création des États-Unis d''Afrique pour resister au néocolonialisme. Il a été un acteur cle de l''indépendance du Ghana (1957) et de la création de l''Organisation de l''Unité Africaine (OUA) en 1963.", "category": "Définition"},
        {"id": "fc8", "question": "Qu''est-ce que le néocolonialisme selon Nkrumah ?", "answer": "Forme de domination indirecte exercée par les anciennes puissances coloniales sur les pays indépendants. Dans Le Néocolonialisme, dernier stade de l''impérialisme (1965), Nkrumah montre que les anciens colonisateurs maintiennent leur contrôle économique, politique et culturel malgre l''indépendance formelle des pays africains.", "category": "Définition"}
      ],
      "schema": {
        "title": "Étude d''œuvres: Montesquieu, Marx et Nkrumah",
        "nodes": [
          {"id": "n1", "label": "Étude\nd''œuvres", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "MONTESQUIEU\nL''Esprit des lois\n(1748)", "x": 120, "y": 150, "type": "branch"},
          {"id": "n3", "label": "MARX\nLe Capital /\nManifeste", "x": 400, "y": 150, "type": "branch"},
          {"id": "n4", "label": "NKRUMAH\nLe Consciencisme\n(1964)", "x": 680, "y": 150, "type": "branch"},
          {"id": "n5", "label": "Separation des\npouvoirs:\nlegislatif, exécutif\njudiciaire", "x": 50, "y": 320, "type": "leaf"},
          {"id": "n6", "label": "3 gouvernements:\nrépublique\nmonarchie\ndespotisme", "x": 210, "y": 320, "type": "leaf"},
          {"id": "n7", "label": "Materialisme\nhistorique\nLutte des classes", "x": 340, "y": 320, "type": "leaf"},
          {"id": "n8", "label": "Plus-value\nAlienation\nInfra/Superstructure", "x": 480, "y": 320, "type": "leaf"},
          {"id": "n9", "label": "Panafricanisme\nUnité africaine", "x": 620, "y": 320, "type": "leaf"},
          {"id": "n10", "label": "Néocolonialisme\nDécolonisation\nphilosophique", "x": 760, "y": 320, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n1", "to": "n4"},
          {"from": "n2", "to": "n5", "label": "théorie politique"},
          {"from": "n2", "to": "n6", "label": "typologie"},
          {"from": "n3", "to": "n7", "label": "théorie économique"},
          {"from": "n3", "to": "n8", "label": "concepts cles"},
          {"from": "n4", "to": "n9", "label": "projet politique"},
          {"from": "n4", "to": "n10", "label": "critique"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Selon Montesquieu, la separation des pouvoirs comprend:", "options": ["Executif et legislatif seulement", "Legislatif, exécutif et judiciaire", "Militaire, religieux et civil", "Federal, régional et local"], "correct": 1, "explanation": "Montesquieu distingue trois pouvoirs: le legislatif (faire les lois), l''exécutif (les appliquer) et le judiciaire (juger). Leur separation empeche la concentration du pouvoir et protégé la liberté."},
        {"id": "q2", "question": "Quel est le principe de la monarchie selon Montesquieu ?", "options": ["La crainte", "La vertu", "L''honneur", "La liberté"], "correct": 2, "explanation": "Pour Montesquieu, chaque gouvernement à un principe moteur: la vertu pour la république, l''honneur pour la monarchie, et la crainte pour le despotisme."},
        {"id": "q3", "question": "Le materialisme historique de Marx affirme que:", "options": ["Les idées determinent l''économie", "Les conditions matérielles de production determinent la société", "La religion est le fondement de l''histoire", "L''histoire est cyclique"], "correct": 1, "explanation": "Pour Marx, l''infrastructure économique (rapports de production) déterminé la superstructure (droit, politique, religion, culture). Les transformations matérielles entrainent les changements sociaux."},
        {"id": "q4", "question": "La plus-value chez Marx est:", "options": ["Le salaire du travailleur", "Le bénéfice redistribue aux ouvriers", "La différence entre la valeur produite et le salaire verse", "L''impot paye par le capitaliste"], "correct": 2, "explanation": "La plus-value est la valeur créée par le travailleur au-dela de ce qui lui est paye en salaire. Le capitaliste s''en empare: c''est le fondement de l''exploitation selon Marx."},
        {"id": "q5", "question": "Le consciencisme de Nkrumah vise a:", "options": ["Copier le modèle européen", "Synthetiser les heritages africain, islamique et européen pour fonder une pensée africaine", "Rejeter toute influence extérieure", "Restaurer les empires africains anciens"], "correct": 1, "explanation": "Le consciencisme est une philosophie de synthèse: Nkrumah propose d''intégrér les trois courants qui traversent l''Afrique (tradition africaine, islam, apport européen) pour créer une pensée originale au service du socialisme africain."},
        {"id": "q6", "question": "Le néocolonialisme selon Nkrumah désigne:", "options": ["La colonisation militaire directe", "La domination indirecte des anciennes puissances coloniales après l''indépendance", "Le commerce entre pays africains", "L''aide humanitaire internationale"], "correct": 1, "explanation": "Pour Nkrumah, le néocolonialisme est le maintien de la domination économique, politique et culturelle des anciennes puissances coloniales malgre l''indépendance formelle. C''est le ''dernier stade de l''impérialisme''."}
      ]
    }'::jsonb
  );

END $$;
-- ============================================================
-- Fiches for TSECO Droit commercial: All 3 chapters
-- 1. La règle de droit
-- 2. Preuves et entreprise commerciale
-- 3. Fonds de commerce et sociétés commerciales
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 1: La règle de droit: caractéristiques et sources
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'regle-de-droit';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: regle-de-droit';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'regle-de-droit-caracteristiques-sources',
    'La règle de droit: caractéristiques et sources',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce que la règle de droit ?",
          "answer": "La règle de droit est une norme juridique obligatoire qui régit la vie en société. Elle organise les rapports entre les personnes et est sanctionnée par la puissance publique (l''État). Elle constitue le fondement de l''ordre juridique."
        },
        {
          "id": "fc2",
          "category": "Distinction",
          "question": "Quels sont les 4 caractères de la règle de droit ?",
          "answer": "1. Générale et abstraite: elle s''applique a tous sans viser une personne particulière. 2. Obligatoire: elle peut être impérative (on ne peut y déroger) ou supplétive (applicable sauf volonté contraire). 3. Permanente: elle s''applique de façon continue tant qu''elle n''est pas abrogée. 4. Coercitive: son non-respect entraîne une sanction de l''État."
        },
        {
          "id": "fc3",
          "category": "Distinction",
          "question": "Quelles sont les sources directes du droit ?",
          "answer": "Les sources directes sont: 1. La Constitution (loi fondamentale, norme suprême). 2. Les traites internationaux (accords entre États, ex: traité OHADA). 3. La loi (votée par le Parlement). 4. Les règlements et decrets (émis par le pouvoir exécutif). Ces sources créent directement des règles de droit."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quelles sont les sources indirectes du droit ?",
          "answer": "Les sources indirectes sont: 1. La coutume: usage repete et considéré comme obligatoire par la collectivite. 2. La jurisprudence: ensemble des décisions rendues par les tribunaux, qui interprétént la loi. 3. La doctrine: opinions et travaux des juristes et professeurs de droit. Elles influencent le droit sans le créer directement."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Quelle est la hierarchie des normes selon Kelsen ?",
          "answer": "La pyramide de Kelsen classe les normes par ordre de supériorité: 1. Constitution (sommet). 2. Traites internationaux. 3. Lois (votées par le Parlement). 4. Règlements et decrets. 5. Coutume (base). Chaque norme inférieure doit être conformé à la norme supérieure."
        },
        {
          "id": "fc6",
          "category": "Distinction",
          "question": "Quelle est la différence entre droit objectif et droits subjectifs ?",
          "answer": "Le droit objectif désigne l''ensemble des règles juridiques qui gouvernent la vie en société (ex: le Code civil). Les droits subjectifs sont les prerogatives reconnues à un individu par le droit objectif (ex: droit de propriété, droit de vote). Le droit objectif créé les droits subjectifs."
        },
        {
          "id": "fc7",
          "category": "Distinction",
          "question": "Quelle est la différence entre droit public et droit privé ?",
          "answer": "Le droit public régit les rapports entre l''État et les particuliers ou entre institutions publiques. Il comprend le droit constitutionnel, administratif et international public. Le droit privé régit les rapports entre particuliers. Il comprend le droit civil, commercial et du travail."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Qu''est-ce que le principe de non-retroactivité de la loi ?",
          "answer": "Le principe de non-retroactivité signifie qu''une loi nouvelle ne s''applique pas aux situations juridiques nees avant son entrée en vigueur. Elle s''applique immédiatement aux situations en cours (application immédiate). Exception: une loi penale plus douce peut retroagir en faveur du prevenu."
        }
      ],
      "schema": {
        "title": "La règle de droit: caractères, sources et branches",
        "nodes": [
          {"id": "n1", "label": "Règle\nde droit", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Caracteres", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Sources", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Branches", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Générale\nObligatoire\nPermanente\nCoercitive", "x": 120, "y": 280, "type": "leaf"},
          {"id": "n6", "label": "Directes\nConstitution\nTraites, Lois\nRèglements", "x": 280, "y": 280, "type": "leaf"},
          {"id": "n7", "label": "Indirectes\nCoutume\nJurisprudence\nDoctrine", "x": 520, "y": 280, "type": "leaf"},
          {"id": "n8", "label": "Droit public\nConstitutionnel\nAdministratif", "x": 680, "y": 280, "type": "leaf"},
          {"id": "n9", "label": "Droit prive\nCivil, Commercial\nDu travail", "x": 680, "y": 420, "type": "leaf"},
          {"id": "n10", "label": "Hierarchie\nKelsen\nConstitution >\nTraites > Lois", "x": 400, "y": 440, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n1", "to": "n4"},
          {"from": "n2", "to": "n5", "label": "4 caractères"},
          {"from": "n3", "to": "n6", "label": "créent le droit"},
          {"from": "n3", "to": "n7", "label": "influencent"},
          {"from": "n4", "to": "n8", "label": "État/particuliers"},
          {"from": "n4", "to": "n9", "label": "entre particuliers"},
          {"from": "n6", "to": "n10", "label": "classees par"},
          {"from": "n7", "to": "n10"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quel caractère de la règle de droit signifie qu''elle s''applique a tous sans distinction ?",
          "options": ["Obligatoire", "Générale et abstraite", "Permanente", "Coercitive"],
          "correct": 1,
          "explanation": "Le caractère général et abstrait signifie que la règle de droit vise toutes les personnes se trouvant dans une situation donnée, sans désigner nommêment un individu."
        },
        {
          "id": "q2",
          "question": "Dans la hierarchie des normes de Kelsen, quelle norme est au sommet ?",
          "options": ["La loi", "Le règlement", "La Constitution", "Le traité international"],
          "correct": 2,
          "explanation": "La Constitution est la norme suprême dans la hierarchie de Kelsen. Toutes les autrès normes doivent lui être conformes. Elle est suivie des traites, puis des lois, puis des règlements."
        },
        {
          "id": "q3",
          "question": "La jurisprudence est une source:",
          "options": ["Directe du droit", "Indirecte du droit", "Principale du droit", "Constitutionnelle"],
          "correct": 1,
          "explanation": "La jurisprudence est une source indirecte du droit. Elle désigne l''ensemble des décisions des tribunaux qui interprétént et précisent la loi, sans créer directement des règles de droit."
        },
        {
          "id": "q4",
          "question": "Le droit commercial appartient a quelle branche du droit ?",
          "options": ["Droit public", "Droit prive", "Droit constitutionnel", "Droit administratif"],
          "correct": 1,
          "explanation": "Le droit commercial est une branche du droit prive. Il régit les rapports entre commerçants et les actes de commerce, donc les relations entre particuliers dans le cadre des activités commerciales."
        },
        {
          "id": "q5",
          "question": "Une loi supplétive est une loi qui:",
          "options": ["S''impose a tous sans exception", "Ne s''applique que si les parties n''ont pas prévu de dispositions contraires", "Est supérieure à la Constitution", "Ne concerne que l''État"],
          "correct": 1,
          "explanation": "Une loi supplétive s''applique par défaut mais les parties peuvent y déroger par une convention contraire. A l''inverse, une loi impérative s''impose a tous sans possibilité de dérogation."
        },
        {
          "id": "q6",
          "question": "Le principe de non-retroactivité de la loi signifie que:",
          "options": ["La loi s''applique toujours retroactivement", "La loi nouvelle ne s''applique pas aux situations nees avant son entrée en vigueur", "La loi ancienne continue toujours a s''appliquer", "Seul le juge decide de l''application dans le temps"],
          "correct": 1,
          "explanation": "Le principe de non-retroactivité garantit la sécurité juridique: une loi nouvelle ne remet pas en cause les situations juridiques valablement constituees sous l''empire de la loi ancienne. Elle s''applique immédiatement aux situations en cours."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 2: Les preuves et l''entreprise commerciale
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'preuves-entreprise';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: preuves-entreprise';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'preuves-entreprise-commerciale',
    'Les preuves et l''entreprise commerciale',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Quel est le principe de la preuve en droit commercial ?",
          "answer": "En droit commercial, la preuve est libre (principe de liberté de la preuve). Contrairement au droit civil ou la preuve par écrit est exigée au-dela d''un certain montant, le commerçant peut prouver par tous moyens: écrit, témoignage, aveu, présomptions, factures, livres de commerce, correspondance."
        },
        {
          "id": "fc2",
          "category": "Distinction",
          "question": "Quels sont les différents moyens de preuve en matière commerciale ?",
          "answer": "Les moyens de preuve sont: 1. L''écrit (contrats, factures, bons de commande). 2. Le témoignage (declarations de tiers). 3. L''aveu (reconnaissance par une partie). 4. Le serment. 5. Les présomptions (indices graves et concordants). 6. Les livres de commerce. 7. La correspondance commerciale (lettres, courriels)."
        },
        {
          "id": "fc3",
          "category": "Méthode",
          "question": "Sur qui repose la charge de la preuve ?",
          "answer": "Selon l''article 1315 du Code civil, applicable en droit commercial: celui qui réclame l''exécution d''une obligation doit la prouver (le demandeur). Réciproquement, celui qui se prétend libere doit prouver le paiement ou le fait qui a éteint son obligation (le défendeur)."
        },
        {
          "id": "fc4",
          "category": "Définition",
          "question": "Qui est considéré comme commerçant ?",
          "answer": "Est commerçant toute personne physique ou morale qui accomplit des actes de commerce a titre de profession habituelle. Selon le droit OHADA, il faut: exercer des actes de commerce, de manière habituelle et professionnelle, avoir la capacité juridique, et être immatriculé au RCCM."
        },
        {
          "id": "fc5",
          "category": "Distinction",
          "question": "Quels sont les 3 types d''actes de commerce ?",
          "answer": "1. Actes de commerce par nature: achat pour revente, opérations de banque et de change, opérations de transport, activités de manufacture. 2. Actes de commerce par la forme: lettre de change, sociétés commerciales (SA, SARL, SNC). 3. Actes de commerce par accessoire: actes civils accomplis par un commerçant pour les besoins de son commerce."
        },
        {
          "id": "fc6",
          "category": "Définition",
          "question": "Qu''est-ce que le RCCM ?",
          "answer": "Le RCCM (Registre du Commerce et du Credit Mobilier) est un registre public ou tout commerçant, personne physique ou morale, doit s''immatriculer dans l''espace OHADA. L''immatriculation confère la qualité officielle de commerçant et permet de rendre opposables aux tiers les informations relatives à l''entreprise."
        },
        {
          "id": "fc7",
          "category": "Méthode",
          "question": "Quelles sont les obligations du commerçant ?",
          "answer": "Le commerçant a les obligations suivantes: 1. S''immatriculer au RCCM. 2. Tenir des livres comptables obligatoires (livre-journal, grand livre, livre d''inventaire). 3. Établir des états financiers annuels. 4. Effectuer ses declarations fiscales. 5. Respecter les règles de concurrence loyale. 6. Émettre des factures pour ses transactions."
        },
        {
          "id": "fc8",
          "category": "Distinction",
          "question": "Quels sont les livres comptables obligatoires du commerçant ?",
          "answer": "Les 3 livres obligatoires sont: 1. Le livre-journal: enregistre chronologiquement toutes les opérations quotidiennes de l''entreprise. 2. Le grand livre: regroupe les opérations par compte comptable. 3. Le livre d''inventaire: contient l''inventaire annuel des actifs et passifs. Ces livres doivent être cotes et paraphes par le tribunal."
        }
      ],
      "schema": {
        "title": "Les preuves en droit commercial et l''entreprise commerciale",
        "nodes": [
          {"id": "n1", "label": "Droit\ncommercial", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Preuves", "x": 180, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Entreprise\ncommerciale", "x": 620, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Liberté\nde la preuve", "x": 60, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Moyens\nEcrit, Temoignage\nAveu, Serment\nLivres, Factures", "x": 220, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Charge\nDemandeur prouve\nsa prétention", "x": 60, "y": 420, "type": "leaf"},
          {"id": "n7", "label": "Conditions\nActes de commerce\nHabituelle, RCCM\nCapacite juridique", "x": 500, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Actes de\ncommerce\nNature, Forme\nAccessoire", "x": 740, "y": 270, "type": "leaf"},
          {"id": "n9", "label": "Obligations\nRCCM\nLivres comptables\nDeclarations fiscales", "x": 500, "y": 420, "type": "leaf"},
          {"id": "n10", "label": "Livres obligatoires\nLivre-journal\nGrand livre\nLivre d''inventaire", "x": 740, "y": 420, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4", "label": "principe"},
          {"from": "n2", "to": "n5", "label": "tous moyens"},
          {"from": "n2", "to": "n6", "label": "qui prouve?"},
          {"from": "n3", "to": "n7", "label": "devenir commerçant"},
          {"from": "n3", "to": "n8", "label": "classification"},
          {"from": "n3", "to": "n9", "label": "devoirs"},
          {"from": "n9", "to": "n10", "label": "comptabilité"},
          {"from": "n7", "to": "n8"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "En droit commercial, la preuve est:",
          "options": ["Uniquement par écrit", "Libre, par tous moyens", "Uniquement par témoignage", "Interdite sans notaire"],
          "correct": 1,
          "explanation": "En droit commercial, le principe est la liberté de la preuve. Le commerçant peut prouver ses prétentions par tous moyens (écrit, témoignage, aveu, livres de commerce, factures, correspondance), contrairement au droit civil qui exige un écrit au-dela d''un certain seuil."
        },
        {
          "id": "q2",
          "question": "Qui supporté la charge de la preuve ?",
          "options": ["Toujours le vendeur", "Toujours l''acheteur", "Celui qui réclame l''exécution d''une obligation", "Le juge"],
          "correct": 2,
          "explanation": "Selon le principe général, c''est le demandeur (celui qui réclame l''exécution d''une obligation) qui doit prouver sa prétention. Le défendeur qui se prétend libere doit à son tour prouver le fait extinctif de l''obligation."
        },
        {
          "id": "q3",
          "question": "L''achat de marchandises pour les revendre est un acte de commerce:",
          "options": ["Par la forme", "Par accessoire", "Par nature", "Par convention"],
          "correct": 2,
          "explanation": "L''achat pour revendre est l''acte de commerce par nature le plus classique. Il constitue l''activité fondamentale du commerce: acheter des biens pour les revendre avec une marge bénéficiaire."
        },
        {
          "id": "q4",
          "question": "Le RCCM est:",
          "options": ["Un tribunal de commerce", "Le Registre du Commerce et du Credit Mobilier", "Un impot commercial", "Une société de garantie"],
          "correct": 1,
          "explanation": "Le RCCM (Registre du Commerce et du Credit Mobilier) est le registre public ou tout commerçant doit s''inscrire dans l''espace OHADA. L''immatriculation confère officiellement la qualité de commerçant."
        },
        {
          "id": "q5",
          "question": "Parmi ces livres, lequel n''est PAS un livre comptable obligatoire ?",
          "options": ["Le livre-journal", "Le grand livre", "Le livre de caisse", "Le livre d''inventaire"],
          "correct": 2,
          "explanation": "Les 3 livres comptables obligatoires sont: le livre-journal, le grand livre et le livre d''inventaire. Le livre de caisse est un document de gestion interne utile mais non obligatoire au sens de la loi."
        },
        {
          "id": "q6",
          "question": "Un artisan qui achete des matières premières pour fabriquer et vendre des meubles est:",
          "options": ["Toujours un commerçant", "Jamais un commerçant", "Un commerçant s''il est immatriculé au RCCM et exercé habituellement", "Un fonctionnaire"],
          "correct": 2,
          "explanation": "Pour être commerçant, il faut accomplir des actes de commerce de manière habituelle et professionnelle, avoir la capacité juridique et être immatriculé au RCCM. L''activité habituelle d''achat pour transformation et revente avec immatriculation confère la qualité de commerçant."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 3: Le fonds de commerce et les sociétés commerciales
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'fonds-commerce-societes';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: fonds-commerce-societes';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'fonds-commerce-societes-commerciales',
    'Le fonds de commerce et les sociétés commerciales',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce que le fonds de commerce ?",
          "answer": "Le fonds de commerce est un ensemble de biens meubles corporels et incorporels qu''un commerçant affecte à l''exploitation de son activité commerciale. Il constitue une universalité de fait regroupant tous les elements nécessaires à l''activité. Les immeubles n''en font pas partie."
        },
        {
          "id": "fc2",
          "category": "Distinction",
          "question": "Quels sont les elements corporels et incorporels du fonds de commerce ?",
          "answer": "Elements corporels: matériel et outillage, marchandises (stock), mobilier commercial. Elements incorporels: clientele (element essentiel), nom commercial, enseigne, droit au bail (droit au renouvellement du bail commercial), brevets, licences, marques. La clientele est l''element le plus important car sans elle, il n''y a pas de fonds."
        },
        {
          "id": "fc3",
          "category": "Méthode",
          "question": "Pourquoi la clientele est-elle l''element essentiel du fonds de commerce ?",
          "answer": "La clientele est l''element essentiel car sans clientele, il n''y a pas d''activité commerciale et donc pas de fonds de commerce. C''est elle qui donne sa valeur économique au fonds. Un fonds sans clientele n''est qu''un ensemble de biens sans unité commerciale. La jurisprudence considéré que la clientele doit être réelle et personnelle."
        },
        {
          "id": "fc4",
          "category": "Définition",
          "question": "Qu''est-ce que le nantissement du fonds de commerce ?",
          "answer": "Le nantissement est une sûreté mobilière qui permet au commerçant de donner son fonds de commerce en garantie d''une dette sans en perdre la possession. Le créancier nanti à un droit de préférence sur le prix de vente du fonds en cas de non-paiement. Il doit être inscrit au RCCM pour être opposable aux tiers."
        },
        {
          "id": "fc5",
          "category": "Définition",
          "question": "Qu''est-ce qu''une société commerciale ?",
          "answer": "Selon le droit OHADA, une société commerciale est un contrat par lequel deux ou plusieurs personnes conviennent d''affecter des biens à une activité commune en vue de partager les bénéfices ou de profiter de l''économie qui pourra en resulter, tout en s''engageant a contribuer aux pertes."
        },
        {
          "id": "fc6",
          "category": "Distinction",
          "question": "Quels sont les 3 elements constitutifs d''une société ?",
          "answer": "1. Les apports: ce que chaque associe met en commun (apports en numeraire/argent, en nature/biens, ou en industrie/savoir-faire). 2. La vocation aux bénéfices et aux pertes: chaque associe a droit aux profits et supporté les pertes. 3. L''affectio sociétatis: volonté commune de collaborer ensemble sur un pied d''égalité."
        },
        {
          "id": "fc7",
          "category": "Distinction",
          "question": "Quelles sont les principales différences entre SARL et SA ?",
          "answer": "SARL: capital minimum 1 000 000 FCFA (OHADA), parts sociales non librement cessibles (agrement des associes), 1 a 100 associes, dirigée par un ou plusieurs gerants. SA: capital minimum 10 000 000 FCFA, actions librement cessibles, minimum 1 actionnaire (SA unipersonnelle possible), dirigée par un conseil d''administration ou un administrateur général."
        },
        {
          "id": "fc8",
          "category": "Définition",
          "question": "Qu''est-ce que la personnalité morale d''une société ?",
          "answer": "La personnalité morale est l''aptitude d''une société a être titulaire de droits et d''obligations, distincte de ses associes. Elle confère à la société: un patrimoine propre, un nom (dénomination sociale), un siege social, une nationalité, et la capacité d''ester en justice. Elle est acquise par l''immatriculation au RCCM."
        }
      ],
      "schema": {
        "title": "Le fonds de commerce et les sociétés commerciales (OHADA)",
        "nodes": [
          {"id": "n1", "label": "Droit\ncommercial", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Fonds de\ncommerce", "x": 180, "y": 130, "type": "branch"},
          {"id": "n3", "label": "Sociétés\ncommerciales", "x": 620, "y": 130, "type": "branch"},
          {"id": "n4", "label": "Corporels\nMateriel\nMarchandises\nMobilier", "x": 60, "y": 270, "type": "leaf"},
          {"id": "n5", "label": "Incorporels\nClientele*\nNom commercial\nDroit au bail\nBrevets", "x": 200, "y": 270, "type": "leaf"},
          {"id": "n6", "label": "Operations\nVente (cession)\nNantissement\nLocation-gerance", "x": 130, "y": 430, "type": "leaf"},
          {"id": "n7", "label": "Elements\nconstitutifs\nApports\nBenefices/Pertes\nAffectio sociétatis", "x": 500, "y": 270, "type": "leaf"},
          {"id": "n8", "label": "Types (OHADA)\nSNC, SCS\nSARL, SA", "x": 740, "y": 270, "type": "leaf"},
          {"id": "n9", "label": "SARL\nCapital 1M FCFA\nParts sociales\nGerant(s)\nResp. limitée", "x": 570, "y": 430, "type": "leaf"},
          {"id": "n10", "label": "SA\nCapital 10M FCFA\nActions cessibles\nConseil admin.\nResp. limitée", "x": 740, "y": 430, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2"},
          {"from": "n1", "to": "n3"},
          {"from": "n2", "to": "n4", "label": "elements"},
          {"from": "n2", "to": "n5", "label": "elements"},
          {"from": "n2", "to": "n6", "label": "exploitation"},
          {"from": "n3", "to": "n7", "label": "contrat"},
          {"from": "n3", "to": "n8", "label": "formes"},
          {"from": "n8", "to": "n9", "label": "responsabilité limitée"},
          {"from": "n8", "to": "n10", "label": "responsabilité limitée"},
          {"from": "n4", "to": "n5"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quel est l''element essentiel du fonds de commerce ?",
          "options": ["Le matériel", "Les marchandises", "La clientele", "Le nom commercial"],
          "correct": 2,
          "explanation": "La clientele est l''element essentiel du fonds de commerce. Sans clientele, il n''y a pas de fonds de commerce. C''est elle qui donne au fonds sa valeur économique et son caractère commercial."
        },
        {
          "id": "q2",
          "question": "Le nantissement du fonds de commerce permet au commerçant de:",
          "options": ["Vendre son fonds", "Donner son fonds en garantie sans en perdre la possession", "Louer son fonds à un tiers", "Transformer son fonds en société"],
          "correct": 1,
          "explanation": "Le nantissement est une sûreté sans dépossession: le commerçant conserve l''exploitation de son fonds tout en le donnant en garantie à un créancier. Ce dernier à un droit de préférence en cas de non-paiement."
        },
        {
          "id": "q3",
          "question": "Les immeubles font-ils partie du fonds de commerce ?",
          "options": ["Oui, toujours", "Oui, s''ils sont utilises pour le commerce", "Non, le fonds ne comprend que des meubles", "Oui, mais seulement les murs commerciaux"],
          "correct": 2,
          "explanation": "Le fonds de commerce est exclusivement composé de biens meubles (corporels et incorporels). Les immeubles ne font pas partie du fonds de commerce, même s''ils sont utilises pour l''activité. Le droit au bail est un element incorporel, mais pas l''immeuble lui-même."
        },
        {
          "id": "q4",
          "question": "L''affectio sociétatis désigne:",
          "options": ["Le montant des apports", "La volonté commune de collaborer sur un pied d''égalité", "Le partage des bénéfices", "Le siege social de la société"],
          "correct": 1,
          "explanation": "L''affectio sociétatis est la volonté delibérée et égalitaire des associes de collaborer ensemble à l''entreprise commune. C''est un element psychologique essentiel à la formation de toute société, avec les apports et la vocation aux bénéfices et aux pertes."
        },
        {
          "id": "q5",
          "question": "Dans une SARL en droit OHADA, les parts sociales sont:",
          "options": ["Librement cessibles a tous", "Non cessibles sous aucune condition", "Cessibles avec l''agrement des associes", "Cotees en bourse"],
          "correct": 2,
          "explanation": "Dans une SARL, les parts sociales ne sont pas librement cessibles. Leur cession à des tiers étrangers à la société est soumise à l''agrement (accord) des autrès associes. C''est une différence majeure avec la SA ou les actions sont librement cessibles."
        },
        {
          "id": "q6",
          "question": "La personnalité morale d''une société est acquise par:",
          "options": ["La signature des statuts", "L''immatriculation au RCCM", "Le versement du capital", "La première vente"],
          "correct": 1,
          "explanation": "La personnalité morale est acquise des l''immatriculation de la société au Registre du Commerce et du Credit Mobilier (RCCM). Avant cette immatriculation, la société existe en tant que contrat mais n''a pas de personnalité juridique distincte de ses associes."
        }
      ]
    }'::jsonb
  );

END $$;
