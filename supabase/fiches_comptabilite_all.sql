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
