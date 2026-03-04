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
-- ============================================================
-- BacSuccess - Fiches Mathématiques Financières (4 chapitres)
-- Programme Maths Financières - Baccalauréat malien TSECO
-- ============================================================
-- 1. Les intérêts simples
-- 2. Les intérêts composes
-- 3. Les annuités
-- 4. Les emprunts indivis
-- ============================================================

DO $$
DECLARE
  v_subject_id UUID;
  v_chapter_id UUID;
BEGIN

  -- Look up the subject
  SELECT id INTO v_subject_id FROM subjects WHERE slug = 'mathematiques';
  IF v_subject_id IS NULL THEN RAISE EXCEPTION 'Subject not found: mathématiques'; END IF;

  -- ============================================================
  -- CHAPTER 1: Les intérêts simples
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'interets-simples', 1, 'Les intérêts simples', 'Calcul des intérêts, taux, durée, capital', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'interets-simples-calculs',
    'Les intérêts simples: formules et calculs',
    true, true, 1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce que l''intérêt simple ?",
          "answer": "L''intérêt simple est la rémunération d''un capital prêté ou placé, calculée uniquement sur le capital initial. Il est proportionnel au capital, au taux et à la durée. L''intérêt simple est utilisé pour les opérations financières à court terme (moins d''un an)."
        },
        {
          "id": "fc2",
          "category": "Formule",
          "question": "Quelle est la formule de l''intérêt simple selon l''unité de temps ?",
          "answer": "I = C x t x n / 100 (n en années). I = C x t x n / 1200 (n en mois). I = C x t x n / 36000 (n en jours, année commerciale de 360 jours). C = capital, t = taux annuel en %, n = durée."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Qu''est-ce que la valeur acquise et comment la calculer ?",
          "answer": "La valeur acquise (VA) est la somme du capital initial et des intérêts produits. VA = C + I = C + (C x t x n / 36000) = C(1 + t x n / 36000). Exemple: C = 500 000 FCFA, t = 6%, n = 90 jours. I = 500 000 x 6 x 90 / 36000 = 7 500 FCFA. VA = 507 500 FCFA."
        },
        {
          "id": "fc4",
          "category": "Définition",
          "question": "Qu''est-ce que l''escompte commercial ?",
          "answer": "L''escompte commercial est l''intérêt retenu par la banque lors de la négociation d''un effet de commerce avant son échéance. Formule: Ec = VN x t x n / 36000, ou VN = valeur nominale de l''effet, t = taux d''escompte, n = nombre de jours restant jusqu''à l''échéance. La valeur actuelle commerciale: Vac = VN - Ec."
        },
        {
          "id": "fc5",
          "category": "Distinction",
          "question": "Quelle est la différence entre l''escompte commercial et l''escompte rationnel ?",
          "answer": "Escompte commercial (Ec): calculé sur la valeur nominale. Ec = VN x t x n / 36000. Escompte rationnel (Er): calculé sur la valeur actuelle rationnelle. Er = VN x t x n / (36000 + t x n). L''escompte commercial est toujours supérieur à l''escompte rationnel. La banque utilise l''escompte commercial car il lui est plus favorable."
        },
        {
          "id": "fc6",
          "category": "Formule",
          "question": "Comment calculer le taux effectif de placement ?",
          "answer": "Le taux effectif de placement est le taux réellement supporté par l''emprunteur ou perçu par le prêtéur, tenant compte des agios et jours de banque. Taux effectif = (Agios / Valeur nette) x (36000 / n). Les agios comprennent l''escompte, les commissions et les taxes. Le taux effectif est toujours supérieur au taux nominal."
        },
        {
          "id": "fc7",
          "category": "Méthode",
          "question": "Qu''est-ce que l''equivalence d''effets de commerce ?",
          "answer": "Deux effets sont equivalents à une date donnée si, escomptes au même taux, ils ont la même valeur actuelle. Pour trouver l''échéance d''un effet equivalent: VN1 x (1 - t x n1/36000) = VN2 x (1 - t x n2/36000). L''échéance commune est l''échéance d''un effet unique remplaçant plusieurs effets. L''échéance moyenne est le cas particulier ou la VN de l''effet unique = somme des VN."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Que sont les jours de banque et les agios ?",
          "answer": "Les jours de banque sont des jours supplémentaires ajoutes par la banque à la durée réelle de l''escompte (généralement 1 ou 2 jours). Les agios regroupent l''ensemble des frais prélevés: escompte + commissions fixes + commissions proportionnelles + TVA sur commissions. Agio TTC = escompte + commissions + TVA. Le net a recevoir = VN - Agio TTC."
        }
      ],
      "schema": {
        "title": "Les intérêts simples: concepts et formules",
        "nodes": [
          {"id": "n1", "label": "INTERETS\nSIMPLES", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Formule de base\nI = C x t x n", "x": 130, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Valeur acquise\nVA = C + I", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Escompte\ncommercial", "x": 670, "y": 140, "type": "branch"},
          {"id": "n5", "label": "/100 (années)\n/1200 (mois)\n/36000 (jours)", "x": 60, "y": 290, "type": "leaf"},
          {"id": "n6", "label": "Capital\nTaux\nDuree", "x": 220, "y": 290, "type": "leaf"},
          {"id": "n7", "label": "Escompte rationnel\nEr = VN.t.n\n/(36000+t.n)", "x": 400, "y": 290, "type": "leaf"},
          {"id": "n8", "label": "Taux effectif\nde placement", "x": 580, "y": 290, "type": "leaf"},
          {"id": "n9", "label": "Equivalence\nd''effets", "x": 720, "y": 290, "type": "leaf"},
          {"id": "n10", "label": "Jours de banque\nAgios = Esc +\nCommissions + TVA", "x": 400, "y": 440, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "calcul"},
          {"from": "n1", "to": "n3", "label": "résultat"},
          {"from": "n1", "to": "n4", "label": "application"},
          {"from": "n2", "to": "n5", "label": "diviseurs"},
          {"from": "n2", "to": "n6", "label": "variables"},
          {"from": "n3", "to": "n7", "label": "comparaison"},
          {"from": "n4", "to": "n8", "label": "taux réel"},
          {"from": "n4", "to": "n9", "label": "remplacement"},
          {"from": "n4", "to": "n10", "label": "frais bancaires"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Un capital de 600 000 FCFA est place a 5% pendant 90 jours. Quel est l''intérêt simple ?",
          "options": ["7 500 FCFA", "8 000 FCFA", "9 000 FCFA", "7 000 FCFA"],
          "correct": 0,
          "explanation": "I = C x t x n / 36000 = 600 000 x 5 x 90 / 36000 = 7 500 FCFA."
        },
        {
          "id": "q2",
          "question": "La valeur acquise d''un capital de 1 000 000 FCFA place a 6% pendant 120 jours est:",
          "options": ["1 060 000 FCFA", "1 020 000 FCFA", "1 024 000 FCFA", "1 018 000 FCFA"],
          "correct": 1,
          "explanation": "I = 1 000 000 x 6 x 120 / 36000 = 20 000 FCFA. VA = 1 000 000 + 20 000 = 1 020 000 FCFA."
        },
        {
          "id": "q3",
          "question": "L''escompte commercial d''un effet de 500 000 FCFA, taux 9%, échéance dans 60 jours est:",
          "options": ["5 000 FCFA", "7 500 FCFA", "8 000 FCFA", "9 000 FCFA"],
          "correct": 1,
          "explanation": "Ec = VN x t x n / 36000 = 500 000 x 9 x 60 / 36000 = 7 500 FCFA."
        },
        {
          "id": "q4",
          "question": "L''escompte commercial est toujours:",
          "options": ["Égal à l''escompte rationnel", "Inférieur à l''escompte rationnel", "Supérieur à l''escompte rationnel", "Calcule sur la valeur actuelle"],
          "correct": 2,
          "explanation": "L''escompte commercial est calculé sur la valeur nominale (plus grande) alors que l''escompte rationnel est calculé sur la valeur actuelle (plus petite). Donc Ec > Er."
        },
        {
          "id": "q5",
          "question": "Quel capital faut-il placer a 8% pendant 6 mois pour obtenir 24 000 FCFA d''intérêts ?",
          "options": ["400 000 FCFA", "500 000 FCFA", "600 000 FCFA", "800 000 FCFA"],
          "correct": 2,
          "explanation": "I = C x t x n / 1200 donc C = I x 1200 / (t x n) = 24 000 x 1200 / (8 x 6) = 28 800 000 / 48 = 600 000 FCFA."
        },
        {
          "id": "q6",
          "question": "Les jours de banque sont:",
          "options": ["Les jours fériés ou la banque est fermée", "Des jours supplémentaires ajoutes à la durée réelle de l''escompte", "Les jours ouvrables uniquement", "Les jours de validite d''un cheque"],
          "correct": 1,
          "explanation": "Les jours de banque sont des jours supplémentaires (1 ou 2) ajoutes par la banque à la durée réelle de l''escompte, ce qui augmente le montant de l''escompte prélevé."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPTER 2: Les intérêts composes
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'interets-composes', 2, 'Les intérêts composes', 'Capitalisation, actualisation, taux equivalent', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'interets-composes-capitalisation',
    'Les intérêts composes: capitalisation et actualisation',
    true, true, 1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce que l''intérêt composé ?",
          "answer": "L''intérêt composé est un intérêt qui, à la fin de chaque période de capitalisation, s''ajoute au capital pour produire lui-même des intérêts à la période suivante. On dit que les intérêts sont capitalises. Ce mode de calcul est utilisé pour les opérations financières à moyen et long terme (plus d''un an)."
        },
        {
          "id": "fc2",
          "category": "Formule",
          "question": "Quelle est la formule de la valeur acquise en intérêts composes ?",
          "answer": "Cn = C0 x (1 + t)^n. Cn = valeur acquise après n périodes. C0 = capital initial. t = taux d''intérêt par période (en décimale). n = nombre de périodes. Exemple: C0 = 1 000 000 FCFA, t = 8%, n = 3 ans. Cn = 1 000 000 x (1,08)^3 = 1 259 712 FCFA."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Quelle est la formule de la valeur actuelle en intérêts composes ?",
          "answer": "C0 = Cn x (1 + t)^(-n). C''est l''opération inverse de la capitalisation: on cherche le capital initial à partir d''une valeur future. On dit qu''on actualise la valeur future. Exemple: Cn = 1 500 000 FCFA dans 4 ans, t = 10%. C0 = 1 500 000 x (1,10)^(-4) = 1 024 520 FCFA."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quelle est la différence entre taux proportionnel et taux equivalent ?",
          "answer": "Taux proportionnel: tp = t / k (simple division du taux annuel par le nombre k de périodes par an). Taux equivalent: te = (1 + t)^(1/k) - 1 (donne le même résultat en capitalisation). Le taux proportionnel est utilisé en intérêts simples, le taux equivalent en intérêts composes. Le taux equivalent est toujours inférieur au taux proportionnel."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Comment trouver la durée de placement n en intérêts composes ?",
          "answer": "A partir de Cn = C0(1+t)^n, on isole n par les logarithmes: n = log(Cn/C0) / log(1+t). Si n n''est pas entier, on utilise l''interpolation linéaire ou la méthode rationnelle: pour la partie entière on applique les intérêts composes, pour la fraction on applique les intérêts simples."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Comment trouver le taux t en intérêts composes ?",
          "answer": "A partir de Cn = C0(1+t)^n: (1+t)^n = Cn/C0 donc 1+t = (Cn/C0)^(1/n) et t = (Cn/C0)^(1/n) - 1. Si le résultat ne correspond pas à une valeur exacte dans les tables financières, on utilise l''interpolation linéaire entre deux taux encadrants."
        },
        {
          "id": "fc7",
          "category": "Distinction",
          "question": "Quelle est la différence entre intérêts simples et intérêts composes ?",
          "answer": "Interets simples: I calculé toujours sur le capital initial, la croissance est linéaire. Interets composes: I calculé sur le capital + intérêts antérieurs, la croissance est exponentielle. Pour une même durée > 1 an et un même taux, les intérêts composes donnent un montant supérieur. Pour une durée < 1 an, les intérêts simples sont plus avantageux pour le prêtéur."
        },
        {
          "id": "fc8",
          "category": "Formule",
          "question": "Comment utiliser les tables financières pour les intérêts composes ?",
          "answer": "Table 1: (1+t)^n = facteur de capitalisation. Permet de calculer Cn à partir de C0. Table 2: (1+t)^(-n) = facteur d''actualisation. Permet de calculer C0 à partir de Cn. Lecture: en ligne le nombre de périodes n, en colonne le taux t. Exemple: (1,08)^5 = 1,469328 (table 1, ligne 5, colonne 8%)."
        }
      ],
      "schema": {
        "title": "Les intérêts composes: capitalisation et actualisation",
        "nodes": [
          {"id": "n1", "label": "INTERETS\nCOMPOSES", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Capitalisation\nCn = C0(1+t)^n", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Actualisation\nC0 = Cn(1+t)^-n", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Taux\nequivalent vs\nproportionnel", "x": 400, "y": 150, "type": "branch"},
          {"id": "n5", "label": "Capital initial\nC0", "x": 70, "y": 300, "type": "leaf"},
          {"id": "n6", "label": "Valeur acquise\nCn", "x": 230, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "te = (1+t)^(1/k)-1\ntp = t/k", "x": 400, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Valeur actuelle\nC0", "x": 570, "y": 300, "type": "leaf"},
          {"id": "n9", "label": "Duree n\nlog(Cn/C0)\n/log(1+t)", "x": 730, "y": 300, "type": "leaf"},
          {"id": "n10", "label": "Tables financières\nTable 1 et Table 2\nInterpolation", "x": 400, "y": 450, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "futur"},
          {"from": "n1", "to": "n3", "label": "present"},
          {"from": "n1", "to": "n4", "label": "taux"},
          {"from": "n2", "to": "n5", "label": "depart"},
          {"from": "n2", "to": "n6", "label": "arrivée"},
          {"from": "n4", "to": "n7", "label": "formules"},
          {"from": "n3", "to": "n8", "label": "résultat"},
          {"from": "n3", "to": "n9", "label": "recherche"},
          {"from": "n1", "to": "n10", "label": "outils"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Un capital de 2 000 000 FCFA est place a intérêts composes au taux de 10% pendant 3 ans. Quelle est la valeur acquise ?",
          "options": ["2 600 000 FCFA", "2 662 000 FCFA", "2 200 000 FCFA", "2 500 000 FCFA"],
          "correct": 1,
          "explanation": "Cn = C0(1+t)^n = 2 000 000 x (1,10)^3 = 2 000 000 x 1,331 = 2 662 000 FCFA."
        },
        {
          "id": "q2",
          "question": "On souhaite disposer de 5 000 000 FCFA dans 4 ans. Au taux de 8%, quel capital faut-il placer aujourd''hui ?",
          "options": ["3 675 149 FCFA", "3 500 000 FCFA", "4 000 000 FCFA", "3 800 000 FCFA"],
          "correct": 0,
          "explanation": "C0 = Cn(1+t)^(-n) = 5 000 000 x (1,08)^(-4) = 5 000 000 x 0,735030 = 3 675 149 FCFA."
        },
        {
          "id": "q3",
          "question": "Le taux equivalent trimestriel d''un taux annuel de 12% est:",
          "options": ["3%", "2,874%", "4%", "2,5%"],
          "correct": 1,
          "explanation": "te = (1+t)^(1/k) - 1 = (1,12)^(1/4) - 1 = 1,02874 - 1 = 0,02874 soit 2,874%. Le taux proportionnel serait 12/4 = 3%."
        },
        {
          "id": "q4",
          "question": "Le taux proportionnel est toujours:",
          "options": ["Égal au taux equivalent", "Inférieur au taux equivalent", "Supérieur au taux equivalent", "Le double du taux equivalent"],
          "correct": 2,
          "explanation": "Le taux proportionnel (t/k) est toujours supérieur au taux equivalent ((1+t)^(1/k)-1) car la capitalisation des intérêts dans le taux equivalent compense une valeur plus faible du taux par période."
        },
        {
          "id": "q5",
          "question": "Pour une durée supérieure a 1 an, quel mode de calcul donne le plus d''intérêts ?",
          "options": ["Interets simples", "Interets composes", "Les deux donnent le même résultat", "Cela depend du taux"],
          "correct": 1,
          "explanation": "Pour n > 1 an, les intérêts composes produisent davantage car les intérêts acquis sont eux-mêmes capitalises et produisent a leur tour des intérêts (croissance exponentielle vs linéaire)."
        },
        {
          "id": "q6",
          "question": "Un capital double en combien d''années au taux de 10% en intérêts composes ?",
          "options": ["7 ans", "10 ans", "8 ans", "Environ 7,27 ans"],
          "correct": 3,
          "explanation": "Cn = 2C0, donc (1,10)^n = 2. n = log(2)/log(1,10) = 0,3010/0,04139 = 7,27 ans environ."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPTER 3: Les annuités
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'annuités', 3, 'Les annuités', 'Annuités constantes, valeur acquise, valeur actuelle', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'annuites-constantes',
    'Les annuités constantes: valeur acquise et valeur actuelle',
    true, true, 1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce qu''une annuité ?",
          "answer": "Une annuité est un versement périodique constant effectue a intervalles de temps réguliers. Si la périodicité est annuelle, on parle d''annuités. Si elle est mensuelle: mensualités. Trimestrielle: trimestrialités. Les annuités constantes ont toutes le même montant. Elles servent a constituer un capital (épargne) ou a rembourser un emprunt."
        },
        {
          "id": "fc2",
          "category": "Formule",
          "question": "Quelle est la formule de la valeur acquise d''une suite d''annuités constantes ?",
          "answer": "VA = a x [(1+t)^n - 1] / t. VA = valeur acquise (somme accumulée après le dernier versement). a = montant de l''annuité constante. t = taux d''intérêt par période. n = nombre de versements. Exemple: a = 200 000 FCFA, t = 8%, n = 5. VA = 200 000 x [(1,08)^5 - 1] / 0,08 = 200 000 x 5,8666 = 1 173 320 FCFA."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Quelle est la formule de la valeur actuelle d''une suite d''annuités constantes ?",
          "answer": "VA0 = a x [1 - (1+t)^(-n)] / t. VA0 = valeur actuelle (valeur de tous les versements ramenes a aujourd''hui). a = montant de l''annuité. t = taux d''intérêt par période. n = nombre de versements. La relation entre VA et VA0: VA0 = VA x (1+t)^(-n)."
        },
        {
          "id": "fc4",
          "category": "Méthode",
          "question": "Comment calculer l''annuité de constitution d''un capital ?",
          "answer": "L''annuité de constitution permet de constituer un capital objectif K après n versements. On isole a dans la formule de la valeur acquise: a = K x t / [(1+t)^n - 1]. Exemple: constituer 5 000 000 FCFA en 4 ans, taux 10%. a = 5 000 000 x 0,10 / [(1,10)^4 - 1] = 500 000 / 0,4641 = 1 077 354 FCFA par an."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Comment calculer l''annuité d''amortissement d''un emprunt ?",
          "answer": "L''annuité d''amortissement permet de rembourser un emprunt C0 en n versements. On isole a dans la formule de la valeur actuelle: a = C0 x t / [1 - (1+t)^(-n)]. Exemple: emprunt 3 000 000 FCFA, taux 12%, 5 ans. a = 3 000 000 x 0,12 / [1 - (1,12)^(-5)] = 360 000 / 0,432573 = 832 117 FCFA par an."
        },
        {
          "id": "fc6",
          "category": "Formule",
          "question": "Comment utiliser les tables financières pour les annuités ?",
          "answer": "Table 3: [(1+t)^n - 1] / t = facteur de capitalisation d''annuités. Multiplie par a pour obtenir VA. Table 4: [1-(1+t)^(-n)] / t = facteur d''actualisation d''annuités. Multiplie par a pour obtenir VA0. Lecture: en ligne n (nombre de périodes), en colonne t (taux)."
        },
        {
          "id": "fc7",
          "category": "Distinction",
          "question": "Quelle est la différence entre annuités de fin de période et annuités de debut de période ?",
          "answer": "Annuités de fin de période (terme echu): le versement a lieu à la fin de chaque période. C''est le cas standard. Annuités de debut de période (terme a echoir): le versement a lieu au debut de chaque période. Pour passer de l''une à l''autre: VA(debut) = VA(fin) x (1+t) et VA0(debut) = VA0(fin) x (1+t)."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Comment trouver le nombre de versements n ?",
          "answer": "A partir de VA = a x [(1+t)^n - 1]/t, on isole n: (1+t)^n = 1 + VA x t / a, puis n = log(1 + VA x t / a) / log(1+t). Si n n''est pas entier, on ajuste: soit on arrondit n au-dessus et on recalculé a, soit le dernier versement est différent des autrès (annuité de régularisation)."
        }
      ],
      "schema": {
        "title": "Les annuités constantes: constitution et amortissement",
        "nodes": [
          {"id": "n1", "label": "ANNUITES\nCONSTANTES", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Valeur acquise\nVA = a[(1+t)^n-1]/t", "x": 150, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Valeur actuelle\nVA0 = a[1-(1+t)^-n]/t", "x": 650, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Constitution\nde capital", "x": 100, "y": 300, "type": "leaf"},
          {"id": "n5", "label": "Épargne\nréguliere", "x": 250, "y": 300, "type": "leaf"},
          {"id": "n6", "label": "Amortissement\nd''emprunt", "x": 550, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "Remboursement\nrégulier", "x": 750, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Terme echu\n(fin de période)", "x": 250, "y": 440, "type": "leaf"},
          {"id": "n9", "label": "Terme a echoir\n(debut de période)", "x": 550, "y": 440, "type": "leaf"},
          {"id": "n10", "label": "Tables financières\nTable 3 et Table 4", "x": 400, "y": 440, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "capitalisation"},
          {"from": "n1", "to": "n3", "label": "actualisation"},
          {"from": "n2", "to": "n4", "label": "objectif"},
          {"from": "n2", "to": "n5", "label": "versements"},
          {"from": "n3", "to": "n6", "label": "dette"},
          {"from": "n3", "to": "n7", "label": "versements"},
          {"from": "n1", "to": "n8"},
          {"from": "n1", "to": "n9"},
          {"from": "n1", "to": "n10", "label": "outils"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "On verse 300 000 FCFA par an pendant 4 ans au taux de 10%. Quelle est la valeur acquise ?",
          "options": ["1 200 000 FCFA", "1 392 300 FCFA", "1 300 000 FCFA", "1 450 000 FCFA"],
          "correct": 1,
          "explanation": "VA = 300 000 x [(1,10)^4 - 1] / 0,10 = 300 000 x [1,4641-1]/0,10 = 300 000 x 4,641 = 1 392 300 FCFA."
        },
        {
          "id": "q2",
          "question": "Un emprunt de 4 000 000 FCFA au taux de 10% est remboursé en 5 annuités constantes. Quelle est l''annuité ?",
          "options": ["1 055 696 FCFA", "800 000 FCFA", "1 000 000 FCFA", "920 000 FCFA"],
          "correct": 0,
          "explanation": "a = C0 x t / [1-(1+t)^(-n)] = 4 000 000 x 0,10 / [1-(1,10)^(-5)] = 400 000 / 0,379079 = 1 055 696 FCFA."
        },
        {
          "id": "q3",
          "question": "La valeur actuelle d''une suite d''annuités est:",
          "options": ["La somme arithmétique des versements", "La somme des versements actualises à la date 0", "Le dernier versement actualise", "Le capital initial plus les intérêts"],
          "correct": 1,
          "explanation": "La valeur actuelle VA0 est la somme de tous les versements futurs ramenes (actualises) à la date 0 en tenant compte du taux d''intérêt."
        },
        {
          "id": "q4",
          "question": "Pour constituer 10 000 000 FCFA en 5 ans au taux de 8%, l''annuité de constitution est:",
          "options": ["2 000 000 FCFA", "1 704 565 FCFA", "1 500 000 FCFA", "1 850 000 FCFA"],
          "correct": 1,
          "explanation": "a = K x t / [(1+t)^n - 1] = 10 000 000 x 0,08 / [(1,08)^5 - 1] = 800 000 / 0,469328 = 1 704 565 FCFA."
        },
        {
          "id": "q5",
          "question": "Si les annuités sont versees en debut de période au lieu de fin de période, la valeur acquise est:",
          "options": ["Identique", "Multipliée par (1+t)", "Divisée par (1+t)", "Multipliée par n"],
          "correct": 1,
          "explanation": "VA(debut) = VA(fin) x (1+t). Chaque versement bénéficié d''une période supplémentaire de capitalisation, donc la valeur acquise est multipliée par (1+t)."
        },
        {
          "id": "q6",
          "question": "Quelle table financière utilise-t-on pour calculer la valeur actuelle d''une suite d''annuités ?",
          "options": ["Table 1: (1+t)^n", "Table 2: (1+t)^(-n)", "Table 3: [(1+t)^n - 1]/t", "Table 4: [1-(1+t)^(-n)]/t"],
          "correct": 3,
          "explanation": "La table 4 donne le facteur [1-(1+t)^(-n)]/t qu''on multiplie par l''annuité a pour obtenir la valeur actuelle VA0."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPTER 4: Les emprunts indivis
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'emprunts-indivis', 4, 'Les emprunts indivis', 'Tableau d''amortissement, annuités constantes', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'emprunts-indivis-amortissement',
    'Les emprunts indivis: tableau d''amortissement',
    true, true, 1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce qu''un emprunt indivis ?",
          "answer": "Un emprunt indivis est un emprunt contracte aupres d''un seul prêtéur (banque, établissement financier). Il s''oppose à l''emprunt obligataire qui fait appel a de nombreux prêtéurs. Le remboursement se fait par versements périodiques comprenant une part d''intérêt et une part d''amortissement du capital."
        },
        {
          "id": "fc2",
          "category": "Formule",
          "question": "Quelle est la formule de l''annuité constante de remboursement ?",
          "answer": "a = C0 x t / [1 - (1+t)^(-n)]. a = annuité constante. C0 = montant de l''emprunt. t = taux d''intérêt par période. n = nombre de périodes. Chaque annuité comprend: a = Interet + Amortissement = Ip + Mp. L''intérêt diminue et l''amortissement augmente au fil du temps."
        },
        {
          "id": "fc3",
          "category": "Méthode",
          "question": "Comment construire un tableau d''amortissement par annuités constantes ?",
          "answer": "Colonnes: Periode | Capital restant du (CRD) | Interet (Ip = CRD x t) | Amortissement (Mp = a - Ip) | Annuité (a = constante). Debut: CRD1 = C0. A chaque ligne: Ip = CRDp x t, Mp = a - Ip, CRDp+1 = CRDp - Mp. Vérification: somme des amortissements = C0 et somme des annuités = n x a."
        },
        {
          "id": "fc4",
          "category": "Formule",
          "question": "Comment evolue l''amortissement dans un emprunt a annuités constantes ?",
          "answer": "Les amortissements forment une suite géométrique de raison (1+t). M1 = a - C0 x t (premier amortissement). Mp = M1 x (1+t)^(p-1) (amortissement de la période p). Ou encore: Mp+1 = Mp x (1+t). L''amortissement croit de manière exponentielle tandis que l''intérêt decroit."
        },
        {
          "id": "fc5",
          "category": "Formule",
          "question": "Comment calculer le capital restant du après p échéances ?",
          "answer": "CRDp = C0 x (1+t)^p - a x [(1+t)^p - 1] / t. Ou de façon equivalente: CRDp = a x [1-(1+t)^-(n-p)] / t. Le capital restant du correspond à la valeur actuelle des annuités restantes. A la dernière échéance: CRDn = 0."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Comment fonctionne le remboursement par amortissements constants ?",
          "answer": "L''amortissement est le même à chaque période: M = C0 / n. L''intérêt diminue car il est calculé sur un CRD décroissant: Ip = CRDp x t. L''annuité diminue au fil du temps: ap = M + Ip. La première annuité est la plus élevée, la dernière la plus faible. Ce système est plus couteux au debut mais moins cher au total."
        },
        {
          "id": "fc7",
          "category": "Distinction",
          "question": "Quelle est la différence entre annuités constantes et amortissements constants ?",
          "answer": "Annuités constantes: a = fixe, M croissant, I décroissant. L''emprunteur verse toujours le même montant. Amortissements constants: M = fixe, a décroissante, I décroissant. L''emprunteur verse plus au debut. Le cout total (somme des intérêts) est plus faible en amortissements constants car le capital est remboursé plus vite."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Comment vérifiér un tableau d''amortissement ?",
          "answer": "Vérifications indispensables: 1. Somme des amortissements = montant emprunte C0. 2. Dernier CRD = 0 (ou dernier amortissement = CRD précédent). 3. A chaque ligne: a = I + M. 4. En annuités constantes: Mp+1 = Mp x (1+t). 5. CRDp+1 = CRDp - Mp. Ces vérifications permettent de détecter les erreurs de calcul."
        }
      ],
      "schema": {
        "title": "Les emprunts indivis: remboursement et amortissement",
        "nodes": [
          {"id": "n1", "label": "EMPRUNTS\nINDIVIS", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Annuités\nconstantes", "x": 180, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Amortissements\nconstants", "x": 620, "y": 150, "type": "branch"},
          {"id": "n4", "label": "a = C0.t /\n[1-(1+t)^-n]", "x": 80, "y": 300, "type": "leaf"},
          {"id": "n5", "label": "Mp = M1(1+t)^(p-1)\nM croissant\nI décroissant", "x": 270, "y": 300, "type": "leaf"},
          {"id": "n6", "label": "M = C0/n\nconstant\na décroissante", "x": 520, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "Ip = CRDp x t\nI décroissant", "x": 720, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Tableau d''amortissement", "x": 400, "y": 300, "type": "branch"},
          {"id": "n9", "label": "Periode | CRD\nInteret | Amort.\nAnnuité", "x": 300, "y": 440, "type": "leaf"},
          {"id": "n10", "label": "Vérification:\nSomme M = C0\nDernier CRD = 0", "x": 520, "y": 440, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "méthode 1"},
          {"from": "n1", "to": "n3", "label": "méthode 2"},
          {"from": "n2", "to": "n4", "label": "formule"},
          {"from": "n2", "to": "n5", "label": "évolution"},
          {"from": "n3", "to": "n6", "label": "formule"},
          {"from": "n3", "to": "n7", "label": "intérêts"},
          {"from": "n1", "to": "n8", "label": "outil"},
          {"from": "n8", "to": "n9", "label": "colonnes"},
          {"from": "n8", "to": "n10", "label": "contrôle"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Un emprunt de 5 000 000 FCFA au taux de 10% est remboursé en 4 annuités constantes. Quelle est l''annuité ?",
          "options": ["1 577 354 FCFA", "1 250 000 FCFA", "1 500 000 FCFA", "1 400 000 FCFA"],
          "correct": 0,
          "explanation": "a = C0 x t / [1-(1+t)^(-n)] = 5 000 000 x 0,10 / [1-(1,10)^(-4)] = 500 000 / 0,316987 = 1 577 354 FCFA."
        },
        {
          "id": "q2",
          "question": "Dans un emprunt a annuités constantes, comment evoluent les amortissements ?",
          "options": ["Ils restent constants", "Ils diminuent", "Ils forment une suite géométrique croissante de raison (1+t)", "Ils sont toujours égaux aux intérêts"],
          "correct": 2,
          "explanation": "Les amortissements forment une suite géométrique de raison (1+t). Mp+1 = Mp x (1+t). Ils augmentent car la part d''intérêt diminue tandis que l''annuité reste constante."
        },
        {
          "id": "q3",
          "question": "Pour un emprunt de 3 000 000 FCFA remboursé en 3 amortissements constants, l''amortissement annuel est:",
          "options": ["750 000 FCFA", "1 000 000 FCFA", "1 200 000 FCFA", "900 000 FCFA"],
          "correct": 1,
          "explanation": "M = C0/n = 3 000 000 / 3 = 1 000 000 FCFA. L''amortissement est le même chaque année."
        },
        {
          "id": "q4",
          "question": "Emprunt 2 000 000 FCFA, taux 12%, annuités constantes. L''intérêt de la 1ere année est:",
          "options": ["200 000 FCFA", "240 000 FCFA", "120 000 FCFA", "260 000 FCFA"],
          "correct": 1,
          "explanation": "I1 = C0 x t = 2 000 000 x 0,12 = 240 000 FCFA. La première année, l''intérêt est calculé sur le capital initial total."
        },
        {
          "id": "q5",
          "question": "A la fin du tableau d''amortissement, le capital restant du doit être egal a:",
          "options": ["C0", "Le montant de la dernière annuité", "0", "Le dernier intérêt"],
          "correct": 2,
          "explanation": "Le capital restant du à la fin du dernier exercice doit être egal a 0, ce qui signifie que l''emprunt est intégralement rembourse."
        },
        {
          "id": "q6",
          "question": "Un emprunt indivis se distingue d''un emprunt obligataire car:",
          "options": ["Il à un taux plus élevé", "Il est contracte aupres d''un seul prêtéur", "Il n''a pas d''intérêts", "Il est toujours à court terme"],
          "correct": 1,
          "explanation": "L''emprunt indivis (non divise) est contracte aupres d''un seul prêtéur (banque). L''emprunt obligataire est divisé en obligations et fait appel a de nombreux prêtéurs sur le marché financier."
        }
      ]
    }'::jsonb
  );

END $$;
-- ============================================================
-- BacSuccess - Fiches Français (4 chapitres, 4 fiches)
-- Programme Français - Baccalauréat malien TSECO
-- 1. La dissertation
-- 2. Le commentaire compose
-- 3. Le résumé et la contraction de texte
-- 4. Les genres et mouvements littéraires
-- ============================================================

DO $$
DECLARE
  v_subject_id UUID;
  v_chapter_id UUID;
BEGIN

  SELECT id INTO v_subject_id FROM subjects WHERE slug = 'francais';
  IF v_subject_id IS NULL THEN RAISE EXCEPTION 'Subject not found: francais'; END IF;

  -- ============================================================
  -- CHAPITRE 1: La dissertation
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'dissertation', 1, 'La dissertation', 'Méthodologie, plan, argumentation', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'dissertation-methodologie',
    'La dissertation: méthodologie et plan',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce qu''une dissertation ?",
          "answer": "La dissertation est un exercice écrit qui consiste a développer une réflexion argumentée et organisée autour d''un sujet donne. Elle exige une analyse rigoureuse du sujet, la construction d''un plan structure et l''utilisation d''arguments appuyes par des exemples précis."
        },
        {
          "id": "fc2",
          "category": "Méthode",
          "question": "Comment analyser un sujet de dissertation ?",
          "answer": "L''analyse du sujet comporte 3 étapes: 1. Reperer les mots-cles et les définir précisément. 2. Identifier la consigne (discutez, commentez, expliquez). 3. Formuler la problématique, c''est-à-dire la question centrale que pose le sujet et a laquelle le devoir répondra."
        },
        {
          "id": "fc3",
          "category": "Distinction",
          "question": "Quels sont les trois types de plans de dissertation ?",
          "answer": "1. Plan dialectique: thèse (arguments pour), antithèse (arguments contre), synthèse (dépassement). Utilise quand le sujet invite a discuter. 2. Plan analytique: causes, conséquences, solutions. Utilise pour expliquer un phénomène. 3. Plan thématique: organisation par thèmes ou aspects du sujet. Utilise quand le sujet invite a explorer une notion."
        },
        {
          "id": "fc4",
          "category": "Méthode",
          "question": "Comment rédiger l''introduction d''une dissertation ?",
          "answer": "L''introduction comporte 3 étapes: 1. L''amorce (ou accroche): une phrase générale qui situe le sujet dans un contexte plus large. 2. La problématique: reformulation du sujet sous formé de question. 3. L''annonce du plan: présentation des grandes parties du devoir en une ou deux phrases."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Comment construire un paragraphe argumente dans le développement ?",
          "answer": "Chaque paragraphe argumente suit la structure I.A.E: 1. Idée directrice: l''affirmation que l''on veut démontrer. 2. Argument: le raisonnement logique qui soutient l''idée. 3. Exemple: un fait précis, une citation ou une référence qui illustre l''argument. Chaque partie comprend 2 a 3 paragraphes argues."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Comment rédiger la conclusion d''une dissertation ?",
          "answer": "La conclusion comporte 2 étapes: 1. Le bilan: synthèse des réponses apportées à la problématique dans chaque partie. Il reprend les points essentiels sans répéter le développement. 2. L''ouverture: élargissement du sujet vers une nouvelle perspective, une question connexe ou un prolongement de la réflexion."
        },
        {
          "id": "fc7",
          "category": "Formule",
          "question": "Quels sont les principaux connecteurs logiques a utiliser dans une dissertation ?",
          "answer": "Addition: de plus, en outre, par ailleurs. Opposition: cependant, néanmoins, toutefois, en revanche. Cause: car, en effet, parce que, puisque. Consequence: donc, ainsi, par conséquent, c''est pourquoi. Illustration: par exemple, notamment, ainsi. Conclusion: en somme, en définitive, pour conclure."
        },
        {
          "id": "fc8",
          "category": "Distinction",
          "question": "Quelle est la différence entre le plan dialectique et le plan analytique ?",
          "answer": "Le plan dialectique (thèse/antithèse/synthèse) s''utilise quand le sujet est une affirmation a discuter: on présenté d''abord les arguments pour, puis les arguments contre, puis on dépassé l''opposition. Le plan analytique (causes/conséquences/solutions) s''utilise quand le sujet demande d''expliquer un problème: on en analyse les origines, les effets et les remèdes."
        }
      ],
      "schema": {
        "title": "La dissertation: méthodologie et plan",
        "nodes": [
          {"id": "n1", "label": "LA\nDISSERTATION", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Analyse\ndu sujet", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Types\nde plans", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Structure\ndu devoir", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Mots-cles\nConsigne\nProblématique", "x": 120, "y": 290, "type": "leaf"},
          {"id": "n6", "label": "Dialectique\nThese/Antithèse\nSynthèse", "x": 270, "y": 290, "type": "leaf"},
          {"id": "n7", "label": "Analytique\nCauses/Conséquences\nSolutions", "x": 400, "y": 290, "type": "leaf"},
          {"id": "n8", "label": "Thématique\nPar aspects\ndu sujet", "x": 530, "y": 290, "type": "leaf"},
          {"id": "n9", "label": "Introduction\nAmorce, Problématique\nAnnonce du plan", "x": 620, "y": 420, "type": "leaf"},
          {"id": "n10", "label": "Développement\nIdee/Argument/Exemple\nConclusion: Bilan + Ouverture", "x": 400, "y": 470, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "étape 1"},
          {"from": "n1", "to": "n3", "label": "étape 2"},
          {"from": "n1", "to": "n4", "label": "étape 3"},
          {"from": "n2", "to": "n5", "label": "repérer"},
          {"from": "n3", "to": "n6", "label": "discuter"},
          {"from": "n3", "to": "n7", "label": "expliquer"},
          {"from": "n3", "to": "n8", "label": "explorer"},
          {"from": "n4", "to": "n9", "label": "ouvrir"},
          {"from": "n4", "to": "n10", "label": "argumenter"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quel type de plan utilise-t-on quand le sujet invite a discuter une affirmation ?",
          "options": ["Le plan analytique", "Le plan dialectique", "Le plan thématique", "Le plan chronologique"],
          "correct": 1,
          "explanation": "Le plan dialectique (thèse/antithèse/synthèse) s''utilise lorsque le sujet propose une affirmation a discuter. On présenté d''abord les arguments favorables, puis les objections, et enfin un dépassement."
        },
        {
          "id": "q2",
          "question": "Quels sont les trois elements d''un paragraphe argumente ?",
          "options": ["Introduction, développement, conclusion", "Idée, argument, exemple", "Cause, conséquence, solution", "These, antithèse, synthèse"],
          "correct": 1,
          "explanation": "Chaque paragraphe argumente suit la structure I.A.E: une idée directrice, un argument logique qui la soutient, et un exemple précis qui l''illustre."
        },
        {
          "id": "q3",
          "question": "Que contient l''introduction d''une dissertation ?",
          "options": ["Le bilan et l''ouverture", "L''amorce, la problématique et l''annonce du plan", "Les arguments pour et contre", "Les exemples et les citations"],
          "correct": 1,
          "explanation": "L''introduction comprend trois elements: une amorce (accroche générale), la problématique (question centrale du sujet) et l''annonce du plan (présentation des parties)."
        },
        {
          "id": "q4",
          "question": "Le plan analytique est organise selon:",
          "options": ["These, antithèse, synthèse", "Causes, conséquences, solutions", "Chronologie des événements", "Arguments pour, arguments contre"],
          "correct": 1,
          "explanation": "Le plan analytique décomposé un problème en trois temps: les causes (origines du phénomène), les conséquences (effets) et les solutions (remèdes possibles)."
        },
        {
          "id": "q5",
          "question": "Quel connecteur logique exprime l''opposition ?",
          "options": ["En effet", "Par conséquent", "Cependant", "De plus"],
          "correct": 2,
          "explanation": "''Cependant'' est un connecteur d''opposition, comme ''néanmoins'', ''toutefois'' et ''en revanche''. Il permet d''introduire une idée contraire a celle qui précède."
        },
        {
          "id": "q6",
          "question": "La conclusion d''une dissertation doit contenir:",
          "options": ["De nouveaux arguments", "Un bilan et une ouverture", "La répétition de l''introduction", "Une citation obligatoire"],
          "correct": 1,
          "explanation": "La conclusion comprend un bilan (synthèse des réponses apportées à la problématique) et une ouverture (élargissement vers une nouvelle perspective ou question connexe)."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 2: Le commentaire compose
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'commentaire-compose', 2, 'Le commentaire compose', 'Analyse de texte, axes de lecture, procédés littéraires', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'commentaire-compose-methode',
    'Le commentaire compose: méthode d''analyse',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce qu''un commentaire composé ?",
          "answer": "Le commentaire composé est un exercice d''analyse ordonnée d''un texte littéraire. Il consiste a dégager les centrès d''intérêt (axes de lecture) du texte et a les étudier de manière organisée en s''appuyant sur les procédés d''écriture. Il ne s''agit pas de paraphraser mais d''interpréter le texte."
        },
        {
          "id": "fc2",
          "category": "Méthode",
          "question": "Comment effectuer la lecture analytique d''un texte ?",
          "answer": "La lecture analytique comprend: 1. Première lecture: comprendre le sens général du texte. 2. Identifier le genre (roman, poésie, theatre), le type de texte (narratif, descriptif, argumentatif) et le registre. 3. Reperer les procédés littéraires (figures de style, champs lexicaux, rythme). 4. Degager les axes de lecture à partir des observations."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Quelles sont les principales figures de style a connaître ?",
          "answer": "1. Metaphore: comparaison sans outil (''la vie est un combat''). 2. Comparaison: rapprochement avec outil (comme, tel que). 3. Personnification: attribuer des traits humains à un objet. 4. Hyperbole: exagération (''mourir de faim''). 5. Antithèse: opposition de deux idées. 6. Anaphore: répétition d''un mot en debut de phrase."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quels sont les principaux registrès littéraires ?",
          "answer": "1. Lyrique: expression des sentiments personnels (amour, nostalgie). 2. Épique: récit d''actions héroïques et extraordinaires. 3. Comique: provoquer le rire (comique de situation, de caractère, de mots). 4. Tragique: sentiment de fatalité et d''impuissance face au destin. 5. Satirique: critique moqueuse des défauts de la société."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Qu''est-ce qu''un champ lexical et comment l''identifier ?",
          "answer": "Un champ lexical est un ensemble de mots se rapportant à un même thème ou une même notion. Par exemple, le champ lexical de la guerre: combat, armes, victoire, défaite, soldat, bataille. Reperer les champs lexicaux permet de dégager les thèmes dominants du texte et de construire les axes de lecture."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Comment construire les axes de lecture d''un commentaire composé ?",
          "answer": "Les axes de lecture sont les grandes idées directrices de l''analyse. Pour les construire: 1. Regrouper les observations (procédés, champs lexicaux) par thème. 2. Formuler 2 ou 3 axes complémentaires (pas de répétition). 3. Chaque axe doit être une interprétation, pas une simple description. Exemple: ''L''expression du désespoir amoureux'' plutot que ''Les sentiments''."
        },
        {
          "id": "fc7",
          "category": "Méthode",
          "question": "Comment rédiger l''introduction du commentaire composé ?",
          "answer": "L''introduction comprend 4 elements: 1. Présentation de l''auteur et de l''œuvre (nom, date, courant littéraire). 2. Situation de l''extrait dans l''œuvre (contexte). 3. Énoncé de la problématique (question que pose le texte). 4. Annonce des axes de lecture (plan du commentaire)."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Comment rédiger le développement et la conclusion du commentaire composé ?",
          "answer": "Développement: chaque axe formé une grande partie. A l''intérieur, chaque sous-partie analyse un procédé précis avec une citation du texte entre guillemets, suivie de son interprétation. Utiliser des transitions entre les axes. Conclusion: bilan des axes (réponse à la problématique) + ouverture (rapprochement avec un autre texte ou un thème plus large)."
        }
      ],
      "schema": {
        "title": "Le commentaire compose: méthode d''analyse",
        "nodes": [
          {"id": "n1", "label": "COMMENTAIRE\nCOMPOSE", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Lecture\nanalytique", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Procedes\nlittéraires", "x": 350, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Axes de\nlecture", "x": 560, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Structure\ndu devoir", "x": 750, "y": 140, "type": "branch"},
          {"id": "n6", "label": "Genre, type\nde texte, registre", "x": 60, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "Figures de style\nMetaphore, Comparaison\nAnaphore, Hyperbole", "x": 220, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Champs lexicaux\nRegistres: lyrique\népique, tragique", "x": 400, "y": 300, "type": "leaf"},
          {"id": "n9", "label": "Regrouper\nobservations\n2-3 axes", "x": 570, "y": 300, "type": "leaf"},
          {"id": "n10", "label": "Introduction\nDéveloppement\n(citations)\nConclusion", "x": 730, "y": 300, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "lire"},
          {"from": "n1", "to": "n3", "label": "repérer"},
          {"from": "n1", "to": "n4", "label": "interpréter"},
          {"from": "n1", "to": "n5", "label": "rédiger"},
          {"from": "n2", "to": "n6", "label": "identifier"},
          {"from": "n3", "to": "n7", "label": "style"},
          {"from": "n3", "to": "n8", "label": "lexique"},
          {"from": "n4", "to": "n9", "label": "organiser"},
          {"from": "n5", "to": "n10", "label": "structurer"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Qu''est-ce qu''un commentaire composé ?",
          "options": ["Un résumé du texte", "Une analyse ordonnée d''un texte par axes de lecture", "Une récriture du texte en prose", "Une critique négative du texte"],
          "correct": 1,
          "explanation": "Le commentaire composé est une analyse ordonnée d''un texte littéraire organisée autour d''axes de lecture (centrès d''intérêt) et appuyée sur l''étude des procédés d''écriture."
        },
        {
          "id": "q2",
          "question": "La metaphore est une figure de style qui consiste a:",
          "options": ["Repeter un mot en debut de phrase", "Comparer deux elements sans outil de comparaison", "Exagérer une idée", "Opposer deux idées contraires"],
          "correct": 1,
          "explanation": "La metaphore etablit une comparaison implicite, sans outil de comparaison (comme, tel). Exemple: ''la vie est un combat'' assimile directement la vie à un combat."
        },
        {
          "id": "q3",
          "question": "Le registre lyrique se caracterise par:",
          "options": ["Le récit d''actions héroïques", "L''expression des sentiments personnels", "La critique moqueuse de la société", "Le sentiment de fatalité"],
          "correct": 1,
          "explanation": "Le registre lyrique est lie à l''expression des sentiments personnels: amour, nostalgie, mélancolie, joie. Il est souvent présent en poésie et utilisé la première personne."
        },
        {
          "id": "q4",
          "question": "Un champ lexical est:",
          "options": ["Une figure de style", "Un ensemble de mots se rapportant à un même thème", "Un type de plan", "Une technique de versification"],
          "correct": 1,
          "explanation": "Le champ lexical regroupe tous les mots d''un texte se rapportant à un même thème ou à une même idée. Son repérage permet d''identifier les thèmes dominants du texte."
        },
        {
          "id": "q5",
          "question": "L''introduction du commentaire composé doit contenir:",
          "options": ["Le bilan des axes", "L''auteur, l''œuvre, l''extrait et les axes de lecture", "Uniquement la problématique", "Les citations du texte"],
          "correct": 1,
          "explanation": "L''introduction présenté l''auteur et l''œuvre, situe l''extrait, formule la problématique et annonce les axes de lecture qui structureront le commentaire."
        },
        {
          "id": "q6",
          "question": "Quelle figure de style consiste a répéter un mot en debut de phrase ou de vers ?",
          "options": ["L''hyperbole", "La personnification", "L''anaphore", "L''antithèse"],
          "correct": 2,
          "explanation": "L''anaphore est la répétition d''un même mot ou groupe de mots au debut de phrases ou de vers successifs. Elle crée un effet d''insistance et de rythme."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 3: Le résumé et la contraction de texte
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'resume-contraction', 3, 'Le résumé et la contraction de texte', 'Techniques de reformulation et de synthèse', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'resume-contraction-technique',
    'Resume et contraction: techniques de synthèse',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Qu''est-ce qu''un résumé de texte ?",
          "answer": "Le résumé est un exercice qui consiste a reformuler un texte en le réduisant au quart (1/4) de sa longueur originale, tout en conservant l''essentiel des idées. Il exige fidélité au texte, reformulation en ses propres mots et respect de l''enchaînement logique des idées de l''auteur."
        },
        {
          "id": "fc2",
          "category": "Méthode",
          "question": "Quelles sont les étapes pour réaliser un résumé de texte ?",
          "answer": "1. Lecture globale: comprendre le sens général et le thème du texte. 2. Reperage de la structure: identifier les paragraphes et les articulations logiques. 3. Identification des idées principales de chaque partie (éliminer les exemples et les details). 4. Reformulation: réécrire les idées essentielles en ses propres mots, dans l''ordre du texte."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Quelles sont les règles fondamentales du résumé ?",
          "answer": "1. Fidélité au texte: ne pas trahir la pensée de l''auteur. 2. Pas d''ajout personnel: ne pas introduire d''idées, d''opinions ou de commentaires. 3. Reformulation en propres mots: ne pas recopier les phrases du texte. 4. Respect de l''ordre du texte: suivre la progression de l''auteur. 5. Respect du nombre de mots: le résumé doit représenter 1/4 du texte, avec une tolérance de +/- 10%."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quelle est la différence entre le résumé et la contraction de texte ?",
          "answer": "Le résumé réduit le texte au 1/4 de sa longueur (25%). La contraction de texte est une réduction plus importante, généralement au 1/10e du texte original (10%). La contraction exige une capacité de synthèse encore plus poussée: seules les idées absolument essentielles sont conservées, avec une reformulation très concise."
        },
        {
          "id": "fc5",
          "category": "Méthode",
          "question": "Comment identifier les idées principales d''un texte ?",
          "answer": "Pour identifier les idées principales: 1. Lire chaque paragraphe et en dégager l''idée centrale. 2. Distinguer les idées principales des idées secondaires (exemples, anecdotes, répétitions). 3. Reperer les mots de liaison qui indiquent l''articulation logique. 4. Formuler en une phrase la thèse globale de l''auteur."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Quelles sont les techniques de reformulation ?",
          "answer": "1. Utiliser des synonymes pour remplacer les termes de l''auteur. 2. Modifier la structure des phrases (transformer une phrase complexe en phrase simple). 3. Nominaliser (transformer un verbe en nom: ''il a decide'' devient ''sa décision''). 4. Generaliser (remplacer une énumération par un terme générique). 5. Fusionner plusieurs phrases en une seule quand elles expriment la même idée."
        },
        {
          "id": "fc7",
          "category": "Formule",
          "question": "Quels mots de liaison utiliser dans un résumé pour assurer la coherence ?",
          "answer": "Pour enchaîner les idées: d''abord, ensuite, enfin, puis. Pour marquer la cause: car, en effet, puisque. Pour exprimer la conséquence: donc, ainsi, par conséquent. Pour opposer: mais, cependant, néanmoins, toutefois. Pour ajouter: de plus, en outre, par ailleurs. Ces connecteurs assurent la fluidite et la logique du resume."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Quelles erreurs faut-il eviter dans un résumé ?",
          "answer": "1. La paraphrase: recopier des phrases du texte original. 2. L''ajout: introduire des idées absentes du texte. 3. La déformation: trahir la pensée de l''auteur ou changer le sens. 4. Le commentaire: donner son avis ou juger le texte. 5. Le non-respect du nombre de mots: dépasser la tolérance de +/- 10%. 6. Le désordre: ne pas suivre l''ordre du texte."
        }
      ],
      "schema": {
        "title": "Resume et contraction: techniques de synthèse",
        "nodes": [
          {"id": "n1", "label": "RESUME ET\nCONTRACTION", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Resume\n(1/4 du texte)", "x": 180, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Contraction\n(1/10e du texte)", "x": 620, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Étapes", "x": 80, "y": 280, "type": "branch"},
          {"id": "n5", "label": "Règles", "x": 300, "y": 280, "type": "branch"},
          {"id": "n6", "label": "1. Lecture globale\n2. Reperer structure\n3. Idées principales\n4. Reformuler", "x": 80, "y": 430, "type": "leaf"},
          {"id": "n7", "label": "Fidélité\nPas d''ajout\nReformulation\nOrdre du texte\n+/- 10% mots", "x": 300, "y": 430, "type": "leaf"},
          {"id": "n8", "label": "Techniques de\nreformulation", "x": 520, "y": 280, "type": "branch"},
          {"id": "n9", "label": "Synonymes\nNominalisation\nGeneralisation\nFusion de phrases", "x": 520, "y": 430, "type": "leaf"},
          {"id": "n10", "label": "Synthèse\nmaximale\nIdees essentielles\nuniquement", "x": 720, "y": 280, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "25%"},
          {"from": "n1", "to": "n3", "label": "10%"},
          {"from": "n2", "to": "n4", "label": "méthode"},
          {"from": "n2", "to": "n5", "label": "contraintes"},
          {"from": "n4", "to": "n6", "label": "suivre"},
          {"from": "n5", "to": "n7", "label": "respecter"},
          {"from": "n2", "to": "n8", "label": "outils"},
          {"from": "n8", "to": "n9", "label": "appliquer"},
          {"from": "n3", "to": "n10", "label": "condenser"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "A quelle proportion doit-on réduire un texte dans un résumé ?",
          "options": ["A la moitie (1/2)", "Au tiers (1/3)", "Au quart (1/4)", "Au dixieme (1/10)"],
          "correct": 2,
          "explanation": "Le résumé réduit le texte au quart (1/4) de sa longueur originale, avec une tolérance de +/- 10% sur le nombre de mots."
        },
        {
          "id": "q2",
          "question": "Quelle est la différence entre résumé et contraction de texte ?",
          "options": ["Le résumé est plus court que la contraction", "La contraction réduit davantage (1/10e) que le résumé (1/4)", "Il n''y a aucune différence", "La contraction conserve les exemples, pas le resume"],
          "correct": 1,
          "explanation": "Le résumé réduit le texte au 1/4 (25%) tandis que la contraction le réduit au 1/10e (10%). La contraction exige donc une capacité de synthèse encore plus grande."
        },
        {
          "id": "q3",
          "question": "Quelle est la première règle du résumé ?",
          "options": ["Ajouter ses propres commentaires", "Être fidèle à la pensée de l''auteur", "Recopier les phrases importantes", "Changer l''ordre des idées"],
          "correct": 1,
          "explanation": "La fidélité au texte est la règle fondamentale: il ne faut jamais trahir la pensée de l''auteur ni déformer le sens de son propos."
        },
        {
          "id": "q4",
          "question": "Quelle technique de reformulation consiste a remplacer un verbe par un nom ?",
          "options": ["La généralisation", "La synonymie", "La nominalisation", "La fusion"],
          "correct": 2,
          "explanation": "La nominalisation transformé un verbe en nom: ''il a decide'' devient ''sa décision'', ''les ouvriers protestent'' devient ''la protestation des ouvriers''. Elle permet de condenser le texte."
        },
        {
          "id": "q5",
          "question": "Que faut-il éliminer en priorité pour réduire un texte ?",
          "options": ["Les idées principales", "Les mots de liaison", "Les exemples, anecdotes et details secondaires", "Les verbes et les adjectifs"],
          "correct": 2,
          "explanation": "Pour réduire un texte, on elimine d''abord les exemples, les anecdotes, les répétitions et les details secondaires qui illustrent les idées mais ne sont pas indispensables à la comprehension."
        },
        {
          "id": "q6",
          "question": "Quelle erreur doit-on absolument eviter dans un résumé ?",
          "options": ["Utiliser des synonymes", "Ajouter des idées personnelles absentes du texte", "Suivre l''ordre du texte", "Reformuler les phrases de l''auteur"],
          "correct": 1,
          "explanation": "Il est interdit d''ajouter des idées, opinions ou commentaires absents du texte original. Le résumé doit se limiter strictement aux idées de l''auteur, sans aucun apport personnel."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 4: Les genres et mouvements littéraires
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'genres-mouvements-litteraires', 4, 'Les genres et mouvements littéraires', 'Roman, poésie, theatre, négritude, réalisme', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'genres-mouvements-litteraires-vue-ensemble',
    'Genres et mouvements littéraires: vue d''ensemble',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Quels sont les principaux genres littéraires ?",
          "answer": "1. Le roman: récit fictif en prose, long, avec des personnages evolues (ex: roman d''aventure, psychologique, social). 2. La poésie: expression artistique par le rythme, les images et la musicalite du langage. 3. Le theatre: texte destiné a être joue sur scene (comedie, tragédie, drame). 4. L''essai: réflexion personnelle et argumentée sur un sujet. 5. Le conte et la nouvelle: récits courts, fictifs."
        },
        {
          "id": "fc2",
          "category": "Distinction",
          "question": "Quelles sont les caractéristiques du classicisme ?",
          "answer": "Le classicisme (XVIIe siècle) valorise l''ordre, la raison et l''équilibre. Règles: unité de temps, de lieu et d''action au theatre. Ideal de clarte, de mesure et de bienséance. Imitation des modèles antiques (grecs et romains). Auteurs cles: Moliere (comedie), Racine (tragédie), La Fontaine (fables), Corneille (tragédie)."
        },
        {
          "id": "fc3",
          "category": "Distinction",
          "question": "Quelles sont les caractéristiques du romantisme ?",
          "answer": "Le romantisme (XIXe siècle) privilégie l''emotion, la sensibilité et la nature. Il s''oppose aux règles rigides du classicisme. Themes: la nature comme refuge, la mélancolie, la passion amoureuse, la révolte contre la société, l''exaltation du moi. Auteurs cles: Victor Hugo, Lamartine, Musset, Chateaubriand."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quelles sont les différences entre réalisme et naturalisme ?",
          "answer": "Le réalisme cherche a représenter fidèlement le réel, la société et les moeurs sans idealisation. Auteurs: Balzac, Flaubert, Stendhal. Le naturalisme prolonge le réalisme en y ajoutant une dimension scientifique: l''ecrivain observe la société comme un scientifique étudie la nature, analyse l''influence de l''hérédité et du milieu. Auteur principal: Émile Zola."
        },
        {
          "id": "fc5",
          "category": "Définition",
          "question": "Qu''est-ce que la négritude ?",
          "answer": "La négritude est un mouvement littéraire et culturel ne dans les années 1930, fondé par Léopold Sédar Senghor (Sénégal), Aimé Césaire (Martinique) et Leon-Gontran Damas (Guyane). Il affirme et valorise l''identité culturelle noire face à l''assimilation coloniale. Il revendique la dignité des peuples noirs et la richesse de la civilisation africaine."
        },
        {
          "id": "fc6",
          "category": "Distinction",
          "question": "Qu''est-ce que la littérature africaine contemporaine ?",
          "answer": "Apres les indépendances, la littérature africaine evolue au-dela de la négritude. Les auteurs abordent les réalités postcoloniales: corruption, désillusion politique, conflits de générations, condition feminine, exil et immigration. Ils utilisent des formés variees (roman, theatre, poésie) et mêlent souvent tradition orale africaine et formés littéraires modernes."
        },
        {
          "id": "fc7",
          "category": "Formule",
          "question": "Quelles sont les œuvres cles de la littérature francophone africaine ?",
          "answer": "1. L''Aventure ambigue de Cheikh Hamidou Kane (1961): conflit entre éducation traditionnelle et modernité occidentale au Sénégal. 2. Les Soleils des indépendances d''Ahmadou Kourouma (1968): désillusion après les indépendances en Afrique de l''Ouest. 3. Une si longue lettre de Mariama Ba (1979): condition feminine au Sénégal, polygamie et émancipation de la femme."
        },
        {
          "id": "fc8",
          "category": "Distinction",
          "question": "Quelle est la différence entre le conte et la nouvelle ?",
          "answer": "Le conte est un récit court, souvent merveilleux ou fantastique, transmis oralement à l''origine. Il à une visée morale ou didactique (ex: contes africains, contes de Perrault). La nouvelle est un récit court en prose, ancré dans le réel, avec peu de personnages et une chute (fin inattendue). Elle vise l''intensite narrative et la concision."
        }
      ],
      "schema": {
        "title": "Genres et mouvements littéraires: vue d''ensemble",
        "nodes": [
          {"id": "n1", "label": "GENRES ET\nMOUVEMENTS", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Genres\nlittéraires", "x": 160, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Mouvements\nlittéraires", "x": 640, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Roman\nPoesie\nTheatre", "x": 60, "y": 290, "type": "leaf"},
          {"id": "n5", "label": "Essai\nConte\nNouvelle", "x": 220, "y": 290, "type": "leaf"},
          {"id": "n6", "label": "Classicisme\nOrdre et raison\nXVIIe siècle", "x": 420, "y": 290, "type": "leaf"},
          {"id": "n7", "label": "Romantisme\nEmotion et nature\nXIXe siècle", "x": 570, "y": 290, "type": "leaf"},
          {"id": "n8", "label": "Réalisme\nNaturalisme\nBalzac, Zola", "x": 720, "y": 290, "type": "leaf"},
          {"id": "n9", "label": "Négritude\nSenghor, Césaire\nIdentite africaine", "x": 480, "y": 430, "type": "leaf"},
          {"id": "n10", "label": "Litt. africaine\nKane, Kourouma\nMariama Ba", "x": 680, "y": 430, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "formes"},
          {"from": "n1", "to": "n3", "label": "courants"},
          {"from": "n2", "to": "n4", "label": "majeurs"},
          {"from": "n2", "to": "n5", "label": "autres"},
          {"from": "n3", "to": "n6", "label": "XVIIe"},
          {"from": "n3", "to": "n7", "label": "XIXe"},
          {"from": "n3", "to": "n8", "label": "XIXe"},
          {"from": "n3", "to": "n9", "label": "XXe"},
          {"from": "n9", "to": "n10", "label": "apres indépendances"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quels sont les fondateurs du mouvement de la négritude ?",
          "options": ["Balzac, Flaubert et Zola", "Senghor, Césaire et Damas", "Hugo, Lamartine et Musset", "Kourouma, Kane et Ba"],
          "correct": 1,
          "explanation": "La négritude a été fondée dans les années 1930 par Léopold Sédar Senghor (Sénégal), Aimé Césaire (Martinique) et Leon-Gontran Damas (Guyane) pour affirmer l''identité culturelle noire."
        },
        {
          "id": "q2",
          "question": "Le classicisme se caracterise par:",
          "options": ["L''exaltation des emotions et de la nature", "L''ordre, la raison et le respect des règles", "La représentation scientifique du réel", "La valorisation de la culture africaine"],
          "correct": 1,
          "explanation": "Le classicisme (XVIIe siècle) valorise l''ordre, la raison, la mesure et l''équilibre. Au theatre, il impose les règles des trois unités (temps, lieu, action) et la bienséance."
        },
        {
          "id": "q3",
          "question": "Quelle œuvre traité du conflit entre éducation traditionnelle et modernité au Sénégal ?",
          "options": ["Les Soleils des indépendances", "Une si longue lettre", "L''Aventure ambigue", "Cahier d''un retour au pays natal"],
          "correct": 2,
          "explanation": "L''Aventure ambigue de Cheikh Hamidou Kane (1961) raconte le déchirement d''un jeune Sénégalais entre l''ecole coranique traditionnelle et l''ecole occidentale, symbole du conflit entre deux civilisations."
        },
        {
          "id": "q4",
          "question": "Le naturalisme se distingue du réalisme par:",
          "options": ["Le refus de représenter la réalité", "L''ajout d''une dimension scientifique et l''étude de l''hérédité", "La préférence pour les sujets fantastiques", "L''utilisation exclusive de la poésie"],
          "correct": 1,
          "explanation": "Le naturalisme prolonge le réalisme en y ajoutant une approche scientifique: l''ecrivain, comme Zola, observe et analyse l''influence de l''hérédité et du milieu social sur les individus."
        },
        {
          "id": "q5",
          "question": "Quel genre littéraire est un récit court destiné à l''origine à la transmission orale et porteur d''une morale ?",
          "options": ["Le roman", "La nouvelle", "Le conte", "L''essai"],
          "correct": 2,
          "explanation": "Le conte est un récit court, souvent merveilleux, transmis oralement à l''origine. Il comporte généralement une visée morale ou didactique, comme les contes traditionnels africains."
        },
        {
          "id": "q6",
          "question": "''Une si longue lettre'' de Mariama Ba traité principalement de:",
          "options": ["La guerre d''indépendance", "La condition feminine et la polygamie au Sénégal", "La philosophie africaine", "Le voyage en Europe"],
          "correct": 1,
          "explanation": "Une si longue lettre (1979) de Mariama Ba aborde la condition feminine au Sénégal, notamment la polygamie et l''émancipation des femmes, à travers le témoignage épistolaire d''une femme confrontee au second mariage de son mari."
        }
      ]
    }'::jsonb
  );

END $$;
-- ============================================================
-- BacSuccess - Fiches Histoire-Géo (4 chapitres, 4 fiches)
-- Programme Histoire-Géographie - Baccalauréat malien TSECO
-- ============================================================

DO $$
DECLARE
  v_subject_id UUID;
  v_chapter_id UUID;
BEGIN
  SELECT id INTO v_subject_id FROM subjects WHERE slug = 'histoire-geo';
  IF v_subject_id IS NULL THEN RAISE EXCEPTION 'Subject not found: histoire-geo'; END IF;

  -- ============================================================
  -- CHAPITRE 1: La décolonisation en Afrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'decolonisation-afrique', 1, 'La décolonisation en Afrique', 'Causes, étapes et conséquences de la décolonisation', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'decolonisation-afrique-etapes',
    'La décolonisation en Afrique: causes, étapes et conséquences',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "category": "Définition", "question": "Qu''est-ce que la décolonisation ?", "answer": "La décolonisation est le procèssus par lequel les peuples colonisés accèdent à l''indépendance et à la souveraineté nationale. Ce mouvement s''est accéléré après 1945, suite à l''affaiblissement des puissances coloniales européennes par les deux guerres mondiales et à la montée des mouvements nationalistes dans les colonies."},
        {"id": "fc2", "category": "Définition", "question": "Quelles sont les causes internes de la décolonisation en Afrique ?", "answer": "1. Le nationalisme africain: prise de conscience identitaire et revendication de la dignité. 2. Les mouvements indépendantistes: création de partis politiques et syndicats. 3. Le rôle des elites formées: intellectuels africains formés en Europe (Senghor, Nkrumah, Keita) qui revendiquent l''égalité et l''autodétermination. 4. La mobilisation populaire: grèves, manifestations et boycotts."},
        {"id": "fc3", "category": "Définition", "question": "Quelles sont les causes externes de la décolonisation ?", "answer": "1. L''affaiblissement des puissances coloniales après 1945: la France et le Royaume-Uni sont ruinés. 2. La pression de l''ONU: la Charte des Nations Unies (1945) affirme le droit des peuples a disposer d''eux-mêmes. 3. La guerre froide: USA et URSS soutiennent les mouvements de libération pour etendre leur influence. 4. La conférence de Bandung (1955): solidarité des peuples afro-asiatiques contre le colonialisme."},
        {"id": "fc4", "category": "Distinction", "question": "Quelle est la différence entre décolonisation pacifique et décolonisation violente ?", "answer": "Décolonisation pacifique: transition négociée vers l''indépendance, sans conflit arme majeur. Exemple: la plupart des colonies françaises d''Afrique noire en 1960 (Mali, Sénégal, Côte d''Ivoire). Décolonisation violente: guerre de libération contre la puissance coloniale. Exemples: Algerie (1954-1962), Kenya (révolte des Mau-Mau 1952-1960), guerres de libération dans les colonies portugaises (Angola, Mozambique, Guinée-Bissau)."},
        {"id": "fc5", "category": "Définition", "question": "Qu''est-ce que le panafricanisme et l''OUA ?", "answer": "Le panafricanisme est un mouvement intellectuel et politique visant l''unité et la solidarité des peuples africains. Il a inspire la création de l''Organisation de l''Unité Africaine (OUA) le 25 mai 1963 a Addis-Abeba. L''OUA avait pour objectifs: promouvoir l''unité africaine, defendre la souveraineté des États, éliminer le colonialisme. Elle est devenue l''Union Africaine (UA) en 2002."},
        {"id": "fc6", "category": "Méthode", "question": "Comment s''est deroulee l''indépendance du Mali ?", "answer": "Le Mali a accede à l''indépendance le 22 septembre 1960. Étapes: 1. Fédération du Mali (1959): union du Soudan français et du Sénégal. 2. Eclatement de la fédération (aout 1960). 3. Proclamation de la République du Mali le 22 septembre 1960, avec Modibo Keita comme premier président. Le parti Union Soudanaise-RDA a mene la lutte pour l''indépendance."},
        {"id": "fc7", "category": "Définition", "question": "Qu''est-ce que le néocolonialisme ?", "answer": "Le néocolonialisme désigne la domination économique, politique et culturelle exercée par les anciennes puissances coloniales sur les États nouvellement indépendants. Formes: accords de coopération deséquilibres, maintien de bases militaires, contrôle monétaire (franc CFA), dépendance économique aux anciennes metropoles, interventions politiques. Kwame Nkrumah a dénoncé ce phénomène dans son livre ''Le néocolonialisme, dernier stade de l''impérialisme'' (1965)."},
        {"id": "fc8", "category": "Distinction", "question": "Quelles sont les conséquences positives et négatives de la décolonisation ?", "answer": "Conséquences positives: accèssion à la souveraineté nationale, création d''États indépendants, valorisation de l''identité culturelle africaine, adhésion aux organisations internationales (ONU). Conséquences négatives: instabilité politique (coups d''État), conflits ethniques hérités des frontières coloniales, néocolonialisme, faiblesse des structures étatiques, sous-développement économique persistant."}
      ],
      "schema": {
        "title": "La décolonisation en Afrique",
        "nodes": [
          {"id": "n1", "label": "Décolonisation\nen Afrique", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Causes\ninternes", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Causes\nexternes", "x": 320, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Étapes", "x": 520, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Conséquences", "x": 700, "y": 140, "type": "branch"},
          {"id": "n6", "label": "Nationalisme\nElites formées\nPartis politiques", "x": 120, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "ONU, Bandung 1955\nGuerre froide\nAffaiblissement colonial", "x": 320, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Pacifiques: 1960\nAfrique francophone", "x": 460, "y": 300, "type": "leaf"},
          {"id": "n9", "label": "Violentes: Algerie\nKenya, Portugal", "x": 600, "y": 300, "type": "leaf"},
          {"id": "n10", "label": "États-nations\nInstabilité\nNéocolonialisme", "x": 740, "y": 300, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "internes"},
          {"from": "n1", "to": "n3", "label": "externes"},
          {"from": "n1", "to": "n4", "label": "procèssus"},
          {"from": "n1", "to": "n5", "label": "résultats"},
          {"from": "n2", "to": "n6", "label": "mouvements"},
          {"from": "n3", "to": "n7", "label": "contexte mondial"},
          {"from": "n4", "to": "n8", "label": "négociées"},
          {"from": "n4", "to": "n9", "label": "armées"},
          {"from": "n5", "to": "n10", "label": "bilan"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "En quelle année la conférence de Bandung a-t-elle eu lieu ?", "options": ["1945", "1955", "1960", "1963"], "correct": 1, "explanation": "La conférence de Bandung s''est tenue en avril 1955 en Indonésie. Elle a reuni 29 pays afro-asiatiques et a affirme la solidarité des peuples colonisés contre le colonialisme et l''impérialisme."},
        {"id": "q2", "question": "Quelle a été la formé de décolonisation en Algerie ?", "options": ["Negociation pacifique", "Referendum populaire", "Guerre de libération (1954-1962)", "Coup d''État militaire"], "correct": 2, "explanation": "L''Algerie a mene une guerre de libération sanglante contre la France de 1954 a 1962. Le Front de Liberation Nationale (FLN) a conduit cette lutte qui s''est achevee par les accords d''Evian et l''indépendance."},
        {"id": "q3", "question": "Quand le Mali a-t-il accede à l''indépendance ?", "options": ["4 avril 1960", "1er janvier 1960", "22 septembre 1960", "7 aout 1960"], "correct": 2, "explanation": "Le Mali a proclame son indépendance le 22 septembre 1960, après l''eclatement de la Fédération du Mali. Modibo Keita en est devenu le premier président."},
        {"id": "q4", "question": "Qu''est-ce que l''OUA ?", "options": ["Organisation de l''Unité Americaine", "Organisation de l''Unité Africaine fondée en 1963", "Organisation Universitaire Africaine", "Office de l''Urbanisme Africain"], "correct": 1, "explanation": "L''Organisation de l''Unité Africaine (OUA) a été créée le 25 mai 1963 a Addis-Abeba pour promouvoir l''unité africaine et éliminer le colonialisme. Elle est devenue l''Union Africaine (UA) en 2002."},
        {"id": "q5", "question": "Le néocolonialisme désigne:", "options": ["La recolonisation des pays africains", "La domination économique et politique des ex-puissances coloniales sur les États indépendants", "La colonisation de l''Amerique", "La coopération entre pays africains"], "correct": 1, "explanation": "Le néocolonialisme est la domination indirecte exercée par les anciennes metropoles coloniales sur les pays indépendants, à travers des mecanismes économiques, monétaires et politiques."},
        {"id": "q6", "question": "Qui était le premier président du Mali indépendant ?", "options": ["Moussa Traore", "Alpha Oumar Konare", "Modibo Keita", "Amadou Toumani Toure"], "correct": 2, "explanation": "Modibo Keita a été le premier président de la République du Mali de 1960 a 1968. Chef de l''Union Soudanaise-RDA, il a mene la lutte pour l''indépendance et a instaure un régime socialiste."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 2: La Guerre froide et ses conséquences en Afrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'guerre-froide-afrique', 2, 'La Guerre froide et ses conséquences en Afrique', 'Bipolarisation, crises, impact sur l''Afrique', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'guerre-froide-impact-afrique',
    'La Guerre froide et son impact sur l''Afrique',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "category": "Définition", "question": "Qu''est-ce que la Guerre froide ?", "answer": "La Guerre froide (1947-1991) est un affrontement indirect entre les États-Unis et l''URSS, les deux superpuissances issues de la Seconde Guerre mondiale. Cet affrontement est idéologique (capitalisme vs communisme), politique, économique et militaire, mais sans conflit arme direct entre les deux puissances. Le terme a été popularise par le journaliste Walter Lippmann en 1947."},
        {"id": "fc2", "category": "Distinction", "question": "Quels sont les deux blocs de la Guerre froide ?", "answer": "Bloc Ouest (capitaliste): dirige par les USA. Alliance militaire: OTAN (1949). Plan Marshall pour la reconstruction de l''Europe. Économie de marche et démocratie libérale. Bloc Est (communiste): dirige par l''URSS. Alliance militaire: Pacte de Varsovie (1955). COMECON pour la coopération économique. Économie planifiée et parti unique. L''Europe est coupee en deux par le rideau de fer."},
        {"id": "fc3", "category": "Définition", "question": "Quelles sont les grandes crises de la Guerre froide ?", "answer": "1. Blocus de Berlin (1948-1949): l''URSS bloque les accès terrestrès a Berlin-Ouest, les USA organisent un pont aerien. 2. Guerre de Corée (1950-1953): conflit entre le Nord communiste et le Sud capitaliste. 3. Crise de Cuba (1962): l''URSS installe des missiles nucléaires a Cuba, menace de guerre nucléaire. 4. Guerre du Vietnam (1955-1975): intervention americaine contre le communisme au Vietnam."},
        {"id": "fc4", "category": "Définition", "question": "Qu''est-ce que le mouvement des non-alignés ?", "answer": "Le mouvement des non-alignés est né de la conférence de Bandung (1955) et formellement créé lors de la conférence de Belgrade (1961). Il regroupe les pays refusant de s''aligner sur l''un ou l''autre des deux blocs. Ses fondateurs: Nehru (Inde), Nasser (Égypte), Tito (Yougoslavie), Sukarno (Indonésie). Principes: souveraineté, non-ingérence, coopération, paix. Ce mouvement a donné naissance au concept de Tiers-monde."},
        {"id": "fc5", "category": "Méthode", "question": "Comment la Guerre froide a-t-elle impacte l''Afrique ?", "answer": "L''Afrique est devenue un terrain d''affrontement indirect entre les deux blocs: 1. Soutien aux régimes allies: USA et URSS soutiennent financièrement et militairement des régimes africains selon leur alignement idéologique. 2. Guerres par procuration: Angola (MPLA soutenu par l''URSS vs UNITA soutenu par les USA), Mozambique (FRELIMO vs RENAMO), Ethiopie (régime du Derg soutenu par l''URSS), Congo (assassinat de Lumumba). 3. Coups d''État soutenus par les superpuissances."},
        {"id": "fc6", "category": "Formule", "question": "Quelles sont les dates cles de la Guerre froide ?", "answer": "1947: Doctrine Truman / Plan Marshall / debut de la Guerre froide. 1948-49: Blocus de Berlin. 1949: Création de l''OTAN / bombe atomique sovietique. 1950-53: Guerre de Corée. 1955: Pacte de Varsovie / Conference de Bandung. 1961: Mur de Berlin. 1962: Crise de Cuba. 1975: Fin de la guerre du Vietnam. 1989: Chute du mur de Berlin. 1991: Dissolution de l''URSS."},
        {"id": "fc7", "category": "Définition", "question": "Comment la Guerre froide a-t-elle pris fin ?", "answer": "La fin de la Guerre froide est marquée par: 1. Les reformés de Gorbatchev en URSS: la Glasnost (transparence) et la Perestroika (restructuration) à partir de 1985. 2. La chute du mur de Berlin le 9 novembre 1989, symbole de la fin de la division de l''Europe. 3. La reunification allemande (1990). 4. La dissolution de l''URSS le 25 décembre 1991. Les USA deviennent la seule superpuissance mondiale."},
        {"id": "fc8", "category": "Distinction", "question": "Quelles sont les conséquences de la fin de la Guerre froide pour l''Afrique ?", "answer": "Conséquences positives: vague de démocratisation (conférences nationales, multipartisme), fin de certains conflits par procuration, ouverture politique. Conséquences négatives: perte du soutien financier et militaire des superpuissances, abandon des dictatures alliées devenues inutiles, emergence de nouvelles guerres civiles (Somalie, Rwanda, Sierra Leone), imposition de programmes d''ajustement structurel par le FMI et la Banque mondiale."}
      ],
      "schema": {
        "title": "La Guerre froide et l''Afrique",
        "nodes": [
          {"id": "n1", "label": "Guerre froide\n1947-1991", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Bloc Ouest\nUSA / OTAN", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Bloc Est\nURSS / Varsovie", "x": 320, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Non-alignés\nTiers-monde", "x": 520, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Impact\nsur l''Afrique", "x": 700, "y": 140, "type": "branch"},
          {"id": "n6", "label": "Plan Marshall\nCapitalisme\nDemocratie libérale", "x": 80, "y": 300, "type": "leaf"},
          {"id": "n7", "label": "Crises: Berlin\nCuba, Vietnam\nCorée", "x": 240, "y": 300, "type": "leaf"},
          {"id": "n8", "label": "Bandung 1955\nBelgrade 1961\nNehru, Nasser, Tito", "x": 430, "y": 300, "type": "leaf"},
          {"id": "n9", "label": "Guerres: Angola\nMozambique\nEthiopie, Congo", "x": 620, "y": 300, "type": "leaf"},
          {"id": "n10", "label": "Fin: 1989-1991\nDemocratisation\nNouvelles crises", "x": 760, "y": 300, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "capitaliste"},
          {"from": "n1", "to": "n3", "label": "communiste"},
          {"from": "n1", "to": "n4", "label": "refus alignement"},
          {"from": "n1", "to": "n5", "label": "terrain d''affrontement"},
          {"from": "n2", "to": "n6", "label": "politique"},
          {"from": "n3", "to": "n7", "label": "crises"},
          {"from": "n4", "to": "n8", "label": "conférences"},
          {"from": "n5", "to": "n9", "label": "guerres par procuration"},
          {"from": "n5", "to": "n10", "label": "apres 1991"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "La Guerre froide oppose principalement:", "options": ["La France et l''Allemagne", "Les États-Unis et l''URSS", "La Chine et le Japon", "L''Angleterre et la Russie"], "correct": 1, "explanation": "La Guerre froide (1947-1991) est un affrontement indirect entre les États-Unis (bloc capitaliste) et l''URSS (bloc communiste), sans conflit arme direct entre eux."},
        {"id": "q2", "question": "La crise de Cuba a eu lieu en:", "options": ["1948", "1955", "1962", "1975"], "correct": 2, "explanation": "La crise des missiles de Cuba a eu lieu en octobre 1962. L''URSS a installe des missiles nucléaires a Cuba, provoquant une confrontation avec les USA. C''est le moment ou le monde a été le plus pres d''une guerre nucléaire."},
        {"id": "q3", "question": "Qu''est-ce que le mouvement des non-alignés ?", "options": ["Une alliance militaire africaine", "Un mouvement de pays refusant de s''aligner sur un des deux blocs", "Un programme économique americain", "Un parti politique européen"], "correct": 1, "explanation": "Le mouvement des non-alignés regroupe les pays qui refusent de s''aligner sur le bloc Ouest ou le bloc Est. Ne a Bandung (1955) et formalise a Belgrade (1961), il defend la souveraineté et la non-ingérence."},
        {"id": "q4", "question": "La Guerre froide a impacte l''Afrique notamment par:", "options": ["La colonisation de nouveaux territoires", "Des guerres par procuration (Angola, Mozambique, Ethiopie)", "La création de l''Union Européenne", "L''unification du continent africain"], "correct": 1, "explanation": "L''Afrique est devenue un terrain d''affrontement indirect. Les deux blocs ont soutenu des factions opposées dans des guerres civiles: Angola (MPLA vs UNITA), Mozambique (FRELIMO vs RENAMO), Ethiopie (régime du Derg soutenu par l''URSS)."},
        {"id": "q5", "question": "Quel événement marque symboliquement la fin de la Guerre froide ?", "options": ["La conférence de Bandung", "La crise de Cuba", "La chute du mur de Berlin en 1989", "La création de l''ONU"], "correct": 2, "explanation": "La chute du mur de Berlin le 9 novembre 1989 est le symbole de la fin de la Guerre froide. Elle marque la fin de la division de l''Europe et précède la dissolution de l''URSS en 1991."},
        {"id": "q6", "question": "Quelle conséquence la fin de la Guerre froide a-t-elle eue pour l''Afrique ?", "options": ["Renforcement des dictatures", "Vague de démocratisation et conférences nationales", "Recolonisation du continent", "Isolement total de l''Afrique"], "correct": 1, "explanation": "La fin de la Guerre froide a entraîne une vague de démocratisation en Afrique dans les années 1990, avec des conférences nationales, l''instauration du multipartisme et la fin du soutien aux régimes dictatoriaux par les superpuissances."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 3: Les defis du développement en Afrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'defis-développement-afrique', 3, 'Les defis du développement en Afrique', 'Population, urbanisation, agriculture, industrialisation', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'defis-développement-afrique-enjeux',
    'Les defis du développement en Afrique',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "category": "Définition", "question": "Qu''est-ce que la transition démographique et ou en est l''Afrique ?", "answer": "La transition démographique est le passage d''un régime démographique traditionnel (forte natalité, forte mortalité) à un régime moderne (faible natalité, faible mortalité). L''Afrique est en debut de transition: la mortalité a baisse grace aux progrès sanitaires, mais la natalité reste élevée (taux de fécondité de 4,5 enfants/femme en moyenne). Cela entraîne une croissance démographique rapide (2,5%/an), la plus forte au monde."},
        {"id": "fc2", "category": "Définition", "question": "Qu''est-ce que l''urbanisation accélérée en Afrique ?", "answer": "L''Afrique connait la plus rapide urbanisation au monde. Causes: exode rural (recherche d''emploi, services), croissance naturelle urbaine. Conséquences: emergence de megapoles (Lagos 21M, Kinshasa 17M, Le Caire 21M), proliferation des bidonvilles (habitat precaire, absence de services de base), problemes d''eau potable, d''assainissement et de transport. D''ici 2050, 60% des Africains vivront en ville contre 43% aujourd''hui."},
        {"id": "fc3", "category": "Distinction", "question": "Quelle est la différence entre agriculture de subsistance et agriculture d''exportation ?", "answer": "Agriculture de subsistance: production destinée à la consommation familiale, techniques traditionnelles, faible mecanisation, cultures vivrieres (mil, sorgho, manioc, riz). Occupe 60% de la population active africaine. Agriculture d''exportation: production destinée au marché international, cultures de rente (cacao, cafe, coton, arachide), souvent héritée de la colonisation. Probleme: les terres sont consacrées à l''exportation au detriment de la sécurité alimentaire."},
        {"id": "fc4", "category": "Définition", "question": "Qu''est-ce que la desertification au Sahel ?", "answer": "La desertification est la dégradation des terres dans les zones arides et semi-arides. Au Sahel (bande entre le Sahara et les zones tropicales), elle est causée par: le changement climatique (baisse des precipitations), le surpaturage, la deforestation, les pratiques agricoles inadaptees. Conséquences: perte de terres cultivables, famine, deplacements de populations, conflits entre agriculteurs et eleveurs. La Grande Muraille Verte est un projet de reboisement pour lutter contre ce phénomène."},
        {"id": "fc5", "category": "Distinction", "question": "Pourquoi l''industrialisation est-elle limitée en Afrique ?", "answer": "L''Afrique ne représenté que 3% de la production manufacturiere mondiale. Causes: dépendance aux matières premières exportees brutes (petrôle, minerais, produits agricoles), faible transformation locale, manque d''infrastructures (energie, transport), faiblesse du capital humain et technologique, concurrence des produits importes. Consequence: détérioration des termes de l''échange (exportation de matières premières a bas prix, importation de produits finis chers)."},
        {"id": "fc6", "category": "Formule", "question": "Qu''est-ce que l''IDH et comment se situe l''Afrique ?", "answer": "L''Indice de Développement Humain (IDH) mesure le niveau de développement d''un pays selon 3 critères: 1. L''espérance de vie (santé). 2. Le niveau d''éducation (durée de scolarisation). 3. Le revenu national brut par habitant (niveau de vie). L''IDH va de 0 a 1. La majorité des pays africains ont un IDH faible (< 0,55). Les 10 derniers pays du classement mondial sont africains (Niger, Tchad, Centrafrique, Soudan du Sud)."},
        {"id": "fc7", "category": "Définition", "question": "Qu''est-ce que la dette extérieure africaine et ses conséquences ?", "answer": "La dette extérieure est l''ensemble des emprunts contractes par les États africains aupres de créanciers étrangers (FMI, Banque mondiale, pays développés). Causes: emprunts massifs dans les années 1970-80 pour financer le développement. Conséquences: les remboursements absorbent une part importante des budgets nationaux, plans d''ajustement structurel (PAS) imposes par le FMI (réduction des dépenses publiques, privatisations), aggravation de la pauvreté."},
        {"id": "fc8", "category": "Méthode", "question": "Quelles sont les organisations d''intégration régionale en Afrique ?", "answer": "1. CEDEAO (Communaute Économique des États de l''Afrique de l''Ouest): 15 pays, créée en 1975, vise l''intégration économique et la libre circulation. 2. UEMOA (Union Économique et Monetaire Ouest-Africaine): 8 pays francophones, monnaie commune (franc CFA), créée en 1994. 3. UA (Union Africaine): 55 États, créée en 2002, remplace l''OUA. Objectif: intégration politique et économique du continent. 4. ZLECAF: Zone de libre-échange continentale africaine (2018)."}
      ],
      "schema": {
        "title": "Les defis du développement en Afrique",
        "nodes": [
          {"id": "n1", "label": "Defis du\ndéveloppement", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Demographie", "x": 80, "y": 150, "type": "branch"},
          {"id": "n3", "label": "Urbanisation", "x": 240, "y": 150, "type": "branch"},
          {"id": "n4", "label": "Agriculture", "x": 400, "y": 150, "type": "branch"},
          {"id": "n5", "label": "Industrie\net économie", "x": 560, "y": 150, "type": "branch"},
          {"id": "n6", "label": "Integration\nrégionale", "x": 720, "y": 150, "type": "branch"},
          {"id": "n7", "label": "Croissance rapide\nTransition incomplete\nTaux fécondité élevé", "x": 80, "y": 320, "type": "leaf"},
          {"id": "n8", "label": "Exode rural\nMegapoles\nBidonvilles", "x": 240, "y": 320, "type": "leaf"},
          {"id": "n9", "label": "Subsistance vs export\nSécurité alimentaire\nDesertification Sahel", "x": 400, "y": 320, "type": "leaf"},
          {"id": "n10", "label": "Matières premières\nFaible transformation\nIDH, dette, PAS", "x": 620, "y": 320, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "population"},
          {"from": "n1", "to": "n3", "label": "villes"},
          {"from": "n1", "to": "n4", "label": "alimentation"},
          {"from": "n1", "to": "n5", "label": "économie"},
          {"from": "n1", "to": "n6", "label": "coopération"},
          {"from": "n2", "to": "n7", "label": "indicateurs"},
          {"from": "n3", "to": "n8", "label": "phénomènes"},
          {"from": "n4", "to": "n9", "label": "enjeux"},
          {"from": "n5", "to": "n10", "label": "contraintes"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "La transition démographique en Afrique est caractérisée par:", "options": ["Une forte baisse de la natalité", "Une mortalité en baisse mais une natalité encore élevée", "Une croissance démographique nulle", "Un vieillissement rapide de la population"], "correct": 1, "explanation": "L''Afrique est en debut de transition démographique: la mortalité a baisse grace aux progrès sanitaires, mais la natalité reste élevée, entrainant une croissance démographique rapide (environ 2,5% par an)."},
        {"id": "q2", "question": "L''exode rural en Afrique entraîne principalement:", "options": ["La disparition des villes", "La croissance des megapoles et des bidonvilles", "L''augmentation de la production agricole", "La baisse de la population"], "correct": 1, "explanation": "L''exode rural provoque une urbanisation accélérée avec la croissance de megapoles (Lagos, Kinshasa) et la proliferation des bidonvilles, ou les conditions de vie sont precaires."},
        {"id": "q3", "question": "L''IDH mesure:", "options": ["Uniquement le revenu par habitant", "L''espérance de vie, l''éducation et le revenu", "La production industrielle", "Le taux de croissance économique"], "correct": 1, "explanation": "L''Indice de Développement Humain (IDH) combine trois dimensions: la santé (espérance de vie), l''éducation (durée de scolarisation) et le niveau de vie (revenu national brut par habitant)."},
        {"id": "q4", "question": "La desertification au Sahel est causée par:", "options": ["Uniquement le changement climatique", "Le changement climatique, le surpaturage et la deforestation", "L''urbanisation des zones desertiques", "La montée des eaux"], "correct": 1, "explanation": "La desertification au Sahel resulte de facteurs combines: changement climatique (baisse des pluies), surpaturage, deforestation et pratiques agricoles inadaptees. C''est un problème multifactoriel."},
        {"id": "q5", "question": "Qu''est-ce que la CEDEAO ?", "options": ["Une organisation mondiale", "La Communaute Économique des États de l''Afrique de l''Ouest", "Un programme d''aide americain", "Une banque de développement"], "correct": 1, "explanation": "La CEDEAO (Communaute Économique des États de l''Afrique de l''Ouest) a été créée en 1975. Elle regroupe 15 pays ouest-africains et vise l''intégration économique et la libre circulation des personnes et des biens."},
        {"id": "q6", "question": "L''industrialisation limitée de l''Afrique s''explique principalement par:", "options": ["L''absence de matières premières", "La dépendance à l''exportation de matières premières brutes et la faible transformation locale", "Le surplus de main-d''œuvre qualifiée", "L''autosuffisance économique du continent"], "correct": 1, "explanation": "L''Afrique exporte ses matières premières brutes a bas prix et importe des produits manufactures chers. Cette faible transformation locale, combinee au manque d''infrastructures et de capital technologique, limite l''industrialisation."}
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPITRE 4: Le Mali: géographie et économie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'mali-géographie-économie', 4, 'Le Mali: géographie et économie', 'Relief, climat, population, activités économiques du Mali', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'mali-géographie-économie-générale',
    'Le Mali: géographie physique et économie',
    true, true, 1,
    '{
      "flashcards": [
        {"id": "fc1", "category": "Définition", "question": "Quelle est la situation géographique du Mali ?", "answer": "Le Mali est un pays d''Afrique de l''Ouest, enclave (sans accès à la mer). Superficie: 1 241 238 km2, ce qui en fait le 2e plus grand pays d''Afrique de l''Ouest. Il partage des frontières avec 7 pays: Algerie (nord), Niger (est), Burkina Faso (sud-est), Côte d''Ivoire (sud), Guinée (sud-ouest), Sénégal (ouest), Mauritanie (nord-ouest). Capitale: Bamako. L''enclavement est un defi majeur pour le commerce extérieur."},
        {"id": "fc2", "category": "Définition", "question": "Quel est le relief du Mali ?", "answer": "Le Mali est globalement plat avec un relief peu accidente. On distingue: 1. Les plateaux au sud (plateau mandingue, plateau de Bandiagara / falaise dogon). 2. Les vastes plaines alluviales du Niger et du Bani (delta intérieur du Niger). 3. Le massif de l''Adrar des Ifoghas au nord-est (zone montagneuse saharienne). 4. Les grandes etendues desertiques du Sahara au nord (plus de 60% du territoire). L''altitude moyenne est de 300 mêtres."},
        {"id": "fc3", "category": "Distinction", "question": "Quelles sont les trois zones climatiques du Mali ?", "answer": "1. Zone saharienne (nord): climat desertique, precipitations < 200 mm/an, temperatures extremes, vegétation rare, population nomade (Touareg). 2. Zone sahelienne (centre): climat semi-aride, precipitations 200-600 mm/an, savane arbustive, elevage pastoral. 3. Zone soudanienne (sud): climat tropical humide, precipitations 600-1400 mm/an, saison des pluies (juin-octobre), savane arboree, agriculture intensive. Le sud concentre la majorité de la population."},
        {"id": "fc4", "category": "Définition", "question": "Quelle est l''importance du fleuve Niger pour le Mali ?", "answer": "Le Niger est le 3e fleuve d''Afrique (4 200 km). Il traverse le Mali sur 1 700 km, d''ouest en est puis vers le sud-est. Le delta intérieur du Niger (30 000 km2 en crue) est une zone unique au monde: vaste plaine inondable essentielle pour l''agriculture (riz, cultures maraicheres), l''elevage (paturages de decrue) et la peche (1re activité de peche fluviale d''Afrique de l''Ouest). Le barrage de Selingue fournit de l''électricité et de l''eau d''irrigation."},
        {"id": "fc5", "category": "Formule", "question": "Quelle est la composition de la population malienne ?", "answer": "Population: environ 22 millions d''habitants. Taux de croissance: 3%/an. Principales ethnies: Bambara (34%, ethnie majoritaire), Peul/Fulani (15%, pasteurs nomades et sedentaires), Songhai (6%, vallee du Niger), Touareg (10%, Sahara), Senoufo (9%, sud), Soninke (9%), Dogon (5%, plateau de Bandiagara), Malinke, Bobo. Le Mali est un pays multiethnique et multilingue. Le bambara est la langue la plus parlée, le français est la langue officielle."},
        {"id": "fc6", "category": "Méthode", "question": "Quelles sont les principales activités agricoles du Mali ?", "answer": "L''agriculture emploie 80% de la population active. 1. Coton: le Mali est l''un des premiers producteurs africains, culture de rente concentrée au sud (CMDT). 2. Riz: cultive dans le delta intérieur du Niger et l''Office du Niger. 3. Mil et sorgho: céréales de base, agriculture pluviale. 4. Arachide et mais: cultures complémentaires. Defis: faible mecanisation, dépendance aux pluies, insécurité alimentaire, changement climatique."},
        {"id": "fc7", "category": "Définition", "question": "Quelle est l''importance de l''elevage et des mines au Mali ?", "answer": "Elevage: le Mali possède le 3e cheptel d''Afrique de l''Ouest (bovins, ovins, caprins, camelins). L''elevage est une activité économique majeure, pratiquée surtout par les Peul et les Touareg. Il contribue a environ 15% du PIB. Mines: le Mali est le 3e producteur d''or en Afrique (apres l''Afrique du Sud et le Ghana). L''or représenté plus de 70% des exportations du pays. Principales mines: Sadiola, Morila, Loulo, Syama."},
        {"id": "fc8", "category": "Distinction", "question": "Quels sont les principaux defis économiques du Mali ?", "answer": "1. Enclavement: absence d''accès à la mer, cout élevé du transport des marchandises, dépendance aux ports des pays voisins (Dakar, Abidjan). 2. Desertification: avancee du desert, perte de terres cultivables, insécurité alimentaire. 3. Insécurité: crise du nord du Mali depuis 2012, groupes armes, terrorisme, impact sur l''économie et le tourisme. 4. Dependance extérieure: aide internationale, dette, faible diversification économique. 5. Infrastructures insuffisantes: routes, électricité, eau potable."}
      ],
      "schema": {
        "title": "Le Mali: géographie et économie",
        "nodes": [
          {"id": "n1", "label": "Le Mali", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "Géographie\nphysique", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "Climat\n3 zones", "x": 290, "y": 140, "type": "branch"},
          {"id": "n4", "label": "Population\n~22 millions", "x": 460, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Économie", "x": 630, "y": 140, "type": "branch"},
          {"id": "n6", "label": "1 241 238 km2\nEnclave, 7 frontières\nPlateau, plaines\nSahara au nord", "x": 80, "y": 320, "type": "leaf"},
          {"id": "n7", "label": "Saharienne (nord)\nSahelienne (centre)\nSoudanienne (sud)\nFleuve Niger", "x": 250, "y": 320, "type": "leaf"},
          {"id": "n8", "label": "Bambara, Peul\nSonghai, Touareg\nSenoufo, Dogon", "x": 420, "y": 320, "type": "leaf"},
          {"id": "n9", "label": "Coton, riz, mil\nElevage 3e cheptel\nOr 3e producteur", "x": 580, "y": 320, "type": "leaf"},
          {"id": "n10", "label": "Defis: enclavement\nDesertification\nInsécurité", "x": 740, "y": 320, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "relief"},
          {"from": "n1", "to": "n3", "label": "climatologie"},
          {"from": "n1", "to": "n4", "label": "demographie"},
          {"from": "n1", "to": "n5", "label": "activités"},
          {"from": "n2", "to": "n6", "label": "caractéristiques"},
          {"from": "n3", "to": "n7", "label": "zonation"},
          {"from": "n4", "to": "n8", "label": "ethnies"},
          {"from": "n5", "to": "n9", "label": "secteurs"},
          {"from": "n5", "to": "n10", "label": "contraintes"}
        ]
      },
      "quiz": [
        {"id": "q1", "question": "Quelle est la superficie du Mali ?", "options": ["322 463 km2", "1 241 238 km2", "2 381 741 km2", "587 040 km2"], "correct": 1, "explanation": "Le Mali à une superficie de 1 241 238 km2, ce qui en fait l''un des plus grands pays d''Afrique de l''Ouest. Plus de 60% du territoire est desertique (Sahara)."},
        {"id": "q2", "question": "Combien de zones climatiques distingue-t-on au Mali ?", "options": ["2 zones", "3 zones: saharienne, sahelienne, soudanienne", "4 zones", "1 seule zone tropicale"], "correct": 1, "explanation": "Le Mali comporte 3 zones climatiques: la zone saharienne au nord (desertique), la zone sahelienne au centre (semi-aride) et la zone soudanienne au sud (tropicale humide), ou se concentre la majorité de la population."},
        {"id": "q3", "question": "Quel est le rang du Mali parmi les producteurs d''or en Afrique ?", "options": ["1er producteur", "2e producteur", "3e producteur", "5e producteur"], "correct": 2, "explanation": "Le Mali est le 3e producteur d''or en Afrique, après l''Afrique du Sud et le Ghana. L''or représenté plus de 70% des exportations du pays et constitue une ressource économique majeure."},
        {"id": "q4", "question": "Quelle est l''ethnie majoritaire au Mali ?", "options": ["Les Peul", "Les Touareg", "Les Bambara", "Les Songhai"], "correct": 2, "explanation": "Les Bambara représentent environ 34% de la population malienne, ce qui en fait l''ethnie la plus nombreuse. La langue bambara est également la plus parlée dans le pays."},
        {"id": "q5", "question": "Qu''est-ce que le delta intérieur du Niger ?", "options": ["Un delta maritime", "Une vaste plaine inondable essentielle pour l''agriculture, l''elevage et la peche", "Un desert au nord du Mali", "Une chaîne de montagnes"], "correct": 1, "explanation": "Le delta intérieur du Niger est une vaste plaine inondable (30 000 km2 en crue) unique au monde. C''est une zone essentielle pour la riziculture, l''elevage (paturages de decrue) et la peche, qui nourrit des millions de personnes."},
        {"id": "q6", "question": "Quel est le principal defi lie à la position géographique du Mali ?", "options": ["Le relief montagneux", "L''enclavement (absence d''accès à la mer)", "L''insularite", "Les inondations permanentes"], "correct": 1, "explanation": "L''enclavement du Mali (pays sans littoral) est un defi économique majeur. Les marchandises doivent transiter par les ports des pays voisins (Dakar, Abidjan, Lome), ce qui augmente les couts de transport et penalise le commerce extérieur."}
      ]
    }'::jsonb
  );

END $$;
-- ============================================================
-- BacSuccess - Fiches Anglais (3 chapitres)
-- Programme Anglais - Baccalauréat malien TSECO
-- 1. Grammar essentials
-- 2. Essay writing
-- 3. Reading comprehension and vocabulary
-- ============================================================

DO $$
DECLARE
  v_subject_id UUID;
  v_chapter_id UUID;
BEGIN

  SELECT id INTO v_subject_id FROM subjects WHERE slug = 'anglais';
  IF v_subject_id IS NULL THEN RAISE EXCEPTION 'Subject not found: anglais'; END IF;

  -- ============================================================
  -- CHAPTER 1: Grammar essentials
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'grammar-essentials', 1, 'Grammar essentials', 'Tenses, conditionals, passive voice, reported speech', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'grammar-tenses-conditionals',
    'Grammar essentials: tenses, conditionals and passive voice',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Définition",
          "question": "Quels sont les 5 temps principaux en anglais et quand les utilise-t-on ?",
          "answer": "1. Present simple: habitudes et vérités générales (I work every day). 2. Present continuous: action en cours au moment ou l''on parle (I am working now). 3. Past simple: action terminée dans le passe (I worked yesterday). 4. Present perfect: action passée ayant un lien avec le présent (I have worked here since 2020). 5. Future avec will/going to: prediction ou intention (I will work / I am going to work)."
        },
        {
          "id": "fc2",
          "category": "Formule",
          "question": "Comment forme-t-on le présent simple et le présent continuous ?",
          "answer": "Present simple: sujet + base verbale (+ s à la 3e personne du singulier). Exemple: He plays football every Saturday. Negatif: sujet + do/does + not + base verbale. Interrogatif: Do/Does + sujet + base verbale? Present continuous: sujet + be (am/is/are) + verbe-ing. Exemple: She is reading a book right now. Negatif: sujet + be + not + verbe-ing."
        },
        {
          "id": "fc3",
          "category": "Formule",
          "question": "Comment forme-t-on le past simple et le présent perfect ?",
          "answer": "Past simple: sujet + verbe-ed (régulier) ou 2e formé (irrégulier). Exemple: I visited Bamako (régulier). She went to school (irrégulier). Marqueurs de temps: yesterday, last week, ago. Present perfect: sujet + have/has + participe passe. Exemple: I have finished my homework. Marqueurs de temps: since, for, already, yet, just."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quels sont les 4 types de conditionnels en anglais ?",
          "answer": "Type 0 (vérité générale): If + présent simple, présent simple. Ex: If you heat water to 100°C, it boils. Type 1 (probable): If + présent simple, will + base verbale. Ex: If it rains, I will stay home. Type 2 (irréel present): If + past simple, would + base verbale. Ex: If I had money, I would travel. Type 3 (irréel passe): If + had + participe passe, would have + participe passe. Ex: If I had studied, I would have passed."
        },
        {
          "id": "fc5",
          "category": "Distinction",
          "question": "Quelle est la différence entre le conditionnel de type 2 et le type 3 ?",
          "answer": "Le type 2 exprime une situation irréelle ou improbable dans le présent ou le futur. Exemple: If I were rich, I would buy a car (je ne suis pas riche maintenant). Le type 3 exprime un regret ou une situation irréelle dans le passe. Exemple: If I had studied harder, I would have passed the exam (je n''ai pas assez étudie, c''est trop tard). Le type 2 utilisé le past simple, le type 3 utilisé le past perfect."
        },
        {
          "id": "fc6",
          "category": "Formule",
          "question": "Comment transforme-t-on une phrase active en phrase passive ?",
          "answer": "Formation de la voix passive: sujet + be (conjugue au même temps) + participe passe + (by + agent). Transformation: 1. Le complément d''objet direct devient le sujet. 2. Le verbe devient be + participe passe. 3. Le sujet actif devient complément d''agent (by...). Exemple: The teacher corrects the exams (actif) -> The exams are corrected by the teacher (passif). Au past simple: The teacher corrected -> The exams were corrected."
        },
        {
          "id": "fc7",
          "category": "Méthode",
          "question": "Quelles sont les règles du discours indirect (reported speech) ?",
          "answer": "Quand on rapporte les parôles de quelqu''un, on effectue des changements: 1. Temps: présent -> past, past -> past perfect, will -> would. 2. Pronoms: I -> he/she, we -> they. 3. Marqueurs de temps: today -> that day, tomorrow -> the next day, yesterday -> the day before, now -> then. Exemple: He said: ''I am tired today'' -> He said that he was tired that day."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Quels changements de temps s''appliquent dans le reported speech ?",
          "answer": "Les changements de temps (backshift): Present simple -> Past simple: ''I play'' -> He said he played. Present continuous -> Past continuous: ''I am playing'' -> He said he was playing. Past simple -> Past perfect: ''I played'' -> He said he had played. Present perfect -> Past perfect: ''I have played'' -> He said he had played. Will -> Would: ''I will play'' -> He said he would play. Can -> Could: ''I can play'' -> He said he could play."
        }
      ],
      "schema": {
        "title": "Grammaire anglaise: temps, conditionnels et voix passive",
        "nodes": [
          {"id": "n1", "label": "Grammaire\nanglaise", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "LES TEMPS\n(Tenses)", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "LES\nCONDITIONNELS", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "VOIX PASSIVE\nREPORTED SPEECH", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Present simple\nPresent continuous", "x": 50, "y": 280, "type": "leaf"},
          {"id": "n6", "label": "Past simple\nPresent perfect\nFuture", "x": 200, "y": 280, "type": "leaf"},
          {"id": "n7", "label": "Type 0: vérité\nType 1: probable", "x": 330, "y": 280, "type": "leaf"},
          {"id": "n8", "label": "Type 2: irréel present\nType 3: irréel passe", "x": 490, "y": 280, "type": "leaf"},
          {"id": "n9", "label": "be + participe passe\nactif -> passif", "x": 630, "y": 280, "type": "leaf"},
          {"id": "n10", "label": "Changement de temps\npronoms, marqueurs", "x": 750, "y": 280, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "conjugaison"},
          {"from": "n1", "to": "n3", "label": "if-clauses"},
          {"from": "n1", "to": "n4", "label": "transformations"},
          {"from": "n2", "to": "n5", "label": "present"},
          {"from": "n2", "to": "n6", "label": "passe/futur"},
          {"from": "n3", "to": "n7", "label": "réel"},
          {"from": "n3", "to": "n8", "label": "irréel"},
          {"from": "n4", "to": "n9", "label": "voix passive"},
          {"from": "n4", "to": "n10", "label": "reported speech"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quel temps utilise-t-on pour decrire une habitude en anglais ?",
          "options": ["Present continuous", "Present simple", "Present perfect", "Past simple"],
          "correct": 1,
          "explanation": "Le présent simple s''utilise pour les habitudes et les vérités générales. Exemple: I drink coffee every morning. Le présent continuous s''utilise pour une action en cours au moment ou l''on parle."
        },
        {
          "id": "q2",
          "question": "Quelle est la structure du conditionnel de type 2 ?",
          "options": ["If + présent simple, will + base verbale", "If + past simple, would + base verbale", "If + had + pp, would have + pp", "If + présent simple, présent simple"],
          "correct": 1,
          "explanation": "Le conditionnel de type 2 exprime une situation irréelle dans le present. Sa structure est: If + past simple, would + base verbale. Exemple: If I had more time, I would read more books."
        },
        {
          "id": "q3",
          "question": "Quelle est la formé passive de ''The students write the essays'' ?",
          "options": ["The essays are written by the students", "The essays is written by the students", "The essays were written by the students", "The essays written by the students"],
          "correct": 0,
          "explanation": "A la voix passive au présent simple: sujet + are + participe passe + by + agent. ''Write'' est au présent simple, donc ''are written''. The essays are written by the students."
        },
        {
          "id": "q4",
          "question": "Dans le reported speech, ''I am studying'' devient:",
          "options": ["He said he is studying", "He said he was studying", "He said he studied", "He said he has been studying"],
          "correct": 1,
          "explanation": "Dans le discours indirect, le présent continuous (am studying) devient past continuous (was studying). Donc ''I am studying'' devient ''He said he was studying''."
        },
        {
          "id": "q5",
          "question": "Quel conditionnel exprime un regret sur le passe ?",
          "options": ["Type 0", "Type 1", "Type 2", "Type 3"],
          "correct": 3,
          "explanation": "Le conditionnel de type 3 exprime une situation irréelle dans le passe, souvent un regret. Structure: If + had + participe passe, would have + participe passe. Exemple: If I had studied, I would have passed (je regrette de ne pas avoir etudie)."
        },
        {
          "id": "q6",
          "question": "Quel marqueur de temps accompagne typiquement le présent perfect ?",
          "options": ["Yesterday", "Last week", "Since / For", "Ago"],
          "correct": 2,
          "explanation": "Les marqueurs ''since'' (depuis un moment précis) et ''for'' (depuis une durée) accompagnent le présent perfect. Exemple: I have lived in Bamako since 2015 / for 10 years. ''Yesterday'', ''last week'' et ''ago'' accompagnent le past simple."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPTER 2: Essay writing
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'essay-writing', 2, 'Essay writing', 'Structure, argumentation, linking words', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'essay-writing-structure',
    'Essay writing: structure and argumentation',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Méthode",
          "question": "Quelle est la structure d''un essai en anglais ?",
          "answer": "Un essai en anglais comporte 3 parties: 1. Introduction: une accroche (hook) pour capter l''attention, la présentation du sujet, et la thèse (thesis statement) qui annonce votre position. 2. Body paragraphs (2 a 3 paragraphes): chaque paragraphe contient une topic sentence (idée principale), des details et des exemples. 3. Conclusion: reformulation de la thèse, synthèse des arguments et une pensée finale (final thought)."
        },
        {
          "id": "fc2",
          "category": "Méthode",
          "question": "Comment rédiger une bonne introduction d''essai ?",
          "answer": "Une bonne introduction suit 3 étapes: 1. Hook (accroche): une question rhétorique, une citation ou un fait surprenant pour capter l''attention du lecteur. Exemple: Have you ever wondered why éducation is considered the key to succèss? 2. Contexte: présenter brievement le sujet et son importance. 3. Thesis statement: énoncér clairement votre position ou l''idée principale de l''essai. Exemple: This essay will argue that éducation is the most powerful tool for economic development in Africa."
        },
        {
          "id": "fc3",
          "category": "Méthode",
          "question": "Comment structurer un body paragraph (paragraphe de développement) ?",
          "answer": "Chaque paragraphe de développement suit la structure PEEL: 1. Point (topic sentence): l''idée principale du paragraphe. Exemple: Firstly, éducation improves employment opportunities. 2. Evidence (preuve): données, faits, exemples concrets. 3. Explanation: expliquer comment la preuve soutient votre point. 4. Link (liaison): relier le paragraphe à la thèse ou au paragraphe suivant avec un mot de liaison."
        },
        {
          "id": "fc4",
          "category": "Distinction",
          "question": "Quels sont les principaux types d''essais ?",
          "answer": "1. Essai argumentatif (for/against): defendre une position avec des arguments pour et contre. On donne clairement son opinion. 2. Essai discursif (balanced view): présenter les deux cotes d''un débat de manière équilibree. 3. Essai descriptif: decrire un lieu, une personne, un événement avec des details sensoriels. 4. Essai narratif: raconter une histoire ou une experience personnelle avec une leçon ou morale à la fin."
        },
        {
          "id": "fc5",
          "category": "Formule",
          "question": "Quels sont les mots de liaison pour l''addition et le contraste ?",
          "answer": "Addition (pour ajouter une idée): Moreover (de plus), Furthermore (en outre), In addition (de plus), Besides (d''ailleurs), Also (également), What is more (qui plus est). Contraste (pour opposer): However (cependant), Nevertheless (néanmoins), On the other hand (d''autre part), Although/Even though (bien que), In contrast (par contraste), Despite / In spite of (malgre)."
        },
        {
          "id": "fc6",
          "category": "Formule",
          "question": "Quels sont les mots de liaison pour la cause, l''effet et la conclusion ?",
          "answer": "Cause/Effet: Therefore (par conséquent), Consequently (en conséquence), As a result (en résultat), Because of (a cause de), Due to (en raison de), This leads to (cela mene a). Conclusion: In conclusion (en conclusion), To sum up (pour résumer), All in all (tout compte fait), To conclude (pour conclure), In summary (en resume), On the whole (dans l''ensemble)."
        },
        {
          "id": "fc7",
          "category": "Formule",
          "question": "Quelles expressions utiles peut-on utiliser pour donner son opinion dans un essai ?",
          "answer": "Pour donner son opinion: In my opinion (a mon avis), I strongly believe that (je crois fermêment que), From my point of view (de mon point de vue), As far as I am concerned (en ce qui me concerne). Pour introduire un fait: It is widely known that (il est bien connu que), It is a fact that (c''est un fait que), Research shows that (les recherches montrent que). Pour comparer: On the one hand... on the other hand (d''un cote... de l''autre)."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Comment rédiger une bonne conclusion d''essai ?",
          "answer": "Une bonne conclusion comprend: 1. Un mot de liaison de conclusion: In conclusion, To sum up, All in all. 2. La reformulation de la thèse (en d''autrès termes, ne pas copier l''introduction). 3. Un résumé des arguments principaux (1 a 2 phrases). 4. Une pensée finale: une ouverture, une question rhétorique ou une recommandation. Exemple: In conclusion, éducation remains the cornerstone of development. Governments should invest more in schools to build a brighter future."
        }
      ],
      "schema": {
        "title": "Essay writing: structure et argumentation",
        "nodes": [
          {"id": "n1", "label": "Essay\nWriting", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "STRUCTURE\nde l''essai", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "TYPES\nd''essais", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "LINKING WORDS\nExpressions", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Introduction\nhook + thesis", "x": 50, "y": 280, "type": "leaf"},
          {"id": "n6", "label": "Body paragraphs\nPEEL method", "x": 170, "y": 280, "type": "leaf"},
          {"id": "n7", "label": "Conclusion\nrestate + final thought", "x": 170, "y": 400, "type": "leaf"},
          {"id": "n8", "label": "Argumentatif\nDiscursif", "x": 370, "y": 280, "type": "leaf"},
          {"id": "n9", "label": "Descriptif\nNarratif", "x": 470, "y": 400, "type": "leaf"},
          {"id": "n10", "label": "Addition: moreover\nContraste: however\nCause: therefore\nConclusion: to sum up", "x": 680, "y": 310, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "organisation"},
          {"from": "n1", "to": "n3", "label": "catégories"},
          {"from": "n1", "to": "n4", "label": "connecteurs"},
          {"from": "n2", "to": "n5", "label": "debut"},
          {"from": "n2", "to": "n6", "label": "développement"},
          {"from": "n2", "to": "n7", "label": "fin"},
          {"from": "n3", "to": "n8", "label": "opinion"},
          {"from": "n3", "to": "n9", "label": "description"},
          {"from": "n4", "to": "n10", "label": "exemples"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quel element de l''introduction annonce la position de l''auteur ?",
          "options": ["Le hook", "Le contexte", "La thesis statement", "Le linking word"],
          "correct": 2,
          "explanation": "La thesis statement (énoncé de thèse) est la phrase qui annonce clairement la position ou l''argument principal de l''auteur. C''est l''element central de l''introduction qui guide tout l''essai."
        },
        {
          "id": "q2",
          "question": "Dans la méthode PEEL, que signifie le ''E'' de Evidence ?",
          "options": ["L''explication de l''idée principale", "Les preuves, faits ou exemples concrets", "L''évaluation de l''argument", "L''énumération des idées"],
          "correct": 1,
          "explanation": "Dans la méthode PEEL (Point, Evidence, Explanation, Link), Evidence désigne les preuves: données, faits, statistiques ou exemples concrets qui soutiennent l''idée principale (Point) du paragraphe."
        },
        {
          "id": "q3",
          "question": "Quel mot de liaison exprime le contraste ?",
          "options": ["Moreover", "Therefore", "However", "In addition"],
          "correct": 2,
          "explanation": "''However'' (cependant) est un mot de liaison qui exprime le contraste ou l''opposition entre deux idées. ''Moreover'' et ''In addition'' expriment l''addition, et ''Therefore'' exprime la conséquence."
        },
        {
          "id": "q4",
          "question": "Quel type d''essai présenté les deux cotes d''un débat de manière équilibree ?",
          "options": ["Essai argumentatif", "Essai discursif", "Essai narratif", "Essai descriptif"],
          "correct": 1,
          "explanation": "L''essai discursif (balanced view) présenté les arguments pour et contre de manière équilibree, sans nécessairement prendre position. L''essai argumentatif, en revanche, defend clairement une position."
        },
        {
          "id": "q5",
          "question": "Quelle expression anglaise signifie ''a mon avis'' ?",
          "options": ["It is widely known that", "As a result", "In my opinion", "On the whole"],
          "correct": 2,
          "explanation": "''In my opinion'' signifie ''a mon avis'' et permet d''introduire son point de vue dans un essai. ''It is widely known that'' introduit un fait reconnu, ''As a result'' exprime une conséquence, et ''On the whole'' signifie ''dans l''ensemble''."
        },
        {
          "id": "q6",
          "question": "Que doit contenir une bonne conclusion d''essai ?",
          "options": ["De nouveaux arguments et exemples", "La reformulation de la thèse et une pensée finale", "Une copie exacte de l''introduction", "Uniquement un mot de liaison de conclusion"],
          "correct": 1,
          "explanation": "Une bonne conclusion reformulé la thèse en d''autrès termes, résumé brievement les arguments principaux et propose une pensée finale (ouverture, question ou recommandation). On n''introduit jamais de nouveaux arguments dans la conclusion."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- CHAPTER 3: Reading comprehension and vocabulary
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'reading-comprehension', 3, 'Reading comprehension and vocabulary', 'Techniques de comprehension, vocabulaire économique', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'reading-comprehension-techniques',
    'Reading comprehension: techniques and economic vocabulary',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "id": "fc1",
          "category": "Méthode",
          "question": "Quelles sont les 3 techniques principales de comprehension de lecture en anglais ?",
          "answer": "1. Skimming (lecture rapide): lire rapidement pour saisir l''idée générale du texte. On parcourt les titres, sous-titres, premiers et derniers mots de chaque paragraphe. 2. Scanning (balayage): rechercher une information spécifique (un nom, une date, un chiffre) sans lire tout le texte. 3. Intensive reading (lecture détaillée): lire attentivement pour comprendre chaque detail, analyser le vocabulaire et la structure des phrases."
        },
        {
          "id": "fc2",
          "category": "Méthode",
          "question": "Comment appliquer la technique du skimming efficacement ?",
          "answer": "Étapes du skimming: 1. Lire le titre et les sous-titrès pour identifier le thème. 2. Lire la première phrase de chaque paragraphe (topic sentence). 3. Reperer les mots en gras ou en italique. 4. Lire la dernière phrase du texte (souvent la conclusion). 5. Ne pas s''arrêtér sur les mots inconnus. Objectif: comprendre le sujet général et l''idée principale du texte en 2 a 3 minutes."
        },
        {
          "id": "fc3",
          "category": "Définition",
          "question": "Quel est le vocabulaire économique essentiel en anglais (commerce et marche) ?",
          "answer": "Trade: commerce. Goods: marchandises. Supply and demand: offre et demande. Market: marche. GDP (Gross Domestic Product): PIB (Produit Intérieur Brut). Inflation: hausse générale des prix. Economic growth: croissance économique. Export: exportation. Import: importation. Developing country: pays en développement. Developed country: pays développé."
        },
        {
          "id": "fc4",
          "category": "Définition",
          "question": "Quel est le vocabulaire économique essentiel en anglais (finance et budget) ?",
          "answer": "Investment: investissement. Profit: bénéfice. Loss: perte. Debt: dette. Budget: budget. Tax: impot. Income: revenu. Revenue: recettes. Expenditure: dépenses. Savings: épargne. Interest rate: taux d''intérêt. Exchange rate: taux de change. Unemployment: chômage. Poverty: pauvreté."
        },
        {
          "id": "fc5",
          "category": "Définition",
          "question": "Quel est le vocabulaire du monde du travail en anglais ?",
          "answer": "Employer: employeur. Employee: employe. Salary: salaire (mensuel). Wages: salaire (horaire/journalier). To hire: embaucher. To fire / to dismiss: licencier. Job interview: entretien d''embauche. CV / Resume: curriculum vitae. Skills: compétences. Qualifications: diplomes/qualifications. To apply for a job: postuler à un emploi. Work experience: experience professionnelle. Internship: stage."
        },
        {
          "id": "fc6",
          "category": "Méthode",
          "question": "Comment répondre aux questions de type wh-questions dans un exercice de comprehension ?",
          "answer": "Les wh-questions demandent une réponse précise: Who (qui): identifier la personne. What (quoi): identifier l''action ou la chose. Where (ou): identifier le lieu. When (quand): identifier le moment. Why (pourquoi): identifier la raison ou la cause. How (comment): identifier la manière ou le moyen. Méthode: 1. Identifier le mot interrogatif. 2. Localiser l''information dans le texte. 3. Répondre en reformulant avec ses propres mots, pas en copiant le texte."
        },
        {
          "id": "fc7",
          "category": "Méthode",
          "question": "Comment répondre aux questions True/False/Justify ?",
          "answer": "Étapes: 1. Lire attentivement l''affirmation proposée. 2. Chercher dans le texte le passage correspondant (scanning). 3. Comparer l''affirmation avec le texte original. 4. Répondre True (vrai) ou False (faux). 5. Justifier: citer ou reformuler le passage du texte qui prouve votre réponse. Attention: ne pas confondre ''not stated'' (non mentionne) avec ''false'' (contraire à ce que dit le texte)."
        },
        {
          "id": "fc8",
          "category": "Méthode",
          "question": "Quelles stratégies utiliser pour les questions a choix multiples (QCM) en comprehension ?",
          "answer": "Stratégies pour les QCM: 1. Lire la question avant de relire le texte. 2. Éliminer les réponses manifestement fausses. 3. Chercher dans le texte le passage qui correspond à la question. 4. Attention aux pieges: les réponses qui utilisent des mots du texte ne sont pas toujours correctes. 5. Vérifier que la réponse choisie répond bien à la question posée. 6. En cas de doute, relire le paragraphe concerne."
        }
      ],
      "schema": {
        "title": "Comprehension de lecture et vocabulaire économique",
        "nodes": [
          {"id": "n1", "label": "Reading\nComprehension", "x": 400, "y": 30, "type": "main"},
          {"id": "n2", "label": "TECHNIQUES\nde lecture", "x": 120, "y": 140, "type": "branch"},
          {"id": "n3", "label": "VOCABULAIRE\néconomique", "x": 400, "y": 140, "type": "branch"},
          {"id": "n4", "label": "REPONDRE AUX\nQUESTIONS", "x": 680, "y": 140, "type": "branch"},
          {"id": "n5", "label": "Skimming\nidée générale", "x": 50, "y": 280, "type": "leaf"},
          {"id": "n6", "label": "Scanning\ninfo spécifique", "x": 170, "y": 280, "type": "leaf"},
          {"id": "n7", "label": "Intensive reading\nlecture détaillée", "x": 120, "y": 420, "type": "leaf"},
          {"id": "n8", "label": "Trade, GDP\nSupply/demand\nInflation", "x": 340, "y": 280, "type": "leaf"},
          {"id": "n9", "label": "Employer/employee\nSalary, skills\nJob interview", "x": 480, "y": 280, "type": "leaf"},
          {"id": "n10", "label": "Wh-questions\nTrue/False/Justify\nQCM stratégies", "x": 680, "y": 300, "type": "leaf"}
        ],
        "edges": [
          {"from": "n1", "to": "n2", "label": "comment lire"},
          {"from": "n1", "to": "n3", "label": "mots cles"},
          {"from": "n1", "to": "n4", "label": "exercices"},
          {"from": "n2", "to": "n5", "label": "rapide"},
          {"from": "n2", "to": "n6", "label": "ciblée"},
          {"from": "n2", "to": "n7", "label": "approfondie"},
          {"from": "n3", "to": "n8", "label": "économie"},
          {"from": "n3", "to": "n9", "label": "travail"},
          {"from": "n4", "to": "n10", "label": "types"}
        ]
      },
      "quiz": [
        {
          "id": "q1",
          "question": "Quelle technique de lecture utilise-t-on pour trouver une date spécifique dans un texte ?",
          "options": ["Skimming", "Scanning", "Intensive reading", "Extensive reading"],
          "correct": 1,
          "explanation": "Le scanning (balayage) est la technique utilisée pour rechercher une information spécifique comme une date, un nom ou un chiffre, sans lire tout le texte. On parcourt rapidement le texte en cherchant uniquement l''element désire."
        },
        {
          "id": "q2",
          "question": "Comment dit-on ''offre et demande'' en anglais ?",
          "options": ["Trade and commerce", "Supply and demand", "Import and export", "Profit and loss"],
          "correct": 1,
          "explanation": "''Supply and demand'' est la traduction anglaise de ''offre et demande''. Supply (offre) désigne la quantité de biens disponibles sur le marche. Demand (demande) désigne la quantité de biens que les consommateurs souhaitent acheter."
        },
        {
          "id": "q3",
          "question": "Que signifie ''GDP'' en français ?",
          "options": ["Grand Depot de Production", "PIB (Produit Intérieur Brut)", "Programme de Développement General", "Gestion des Dépenses Publiques"],
          "correct": 1,
          "explanation": "GDP signifie Gross Domestic Product, soit PIB (Produit Intérieur Brut) en français. C''est la valeur totale des biens et services produits dans un pays au cours d''une année. C''est un indicateur majeur de la santé économique d''un pays."
        },
        {
          "id": "q4",
          "question": "Quelle est la différence entre ''salary'' et ''wages'' ?",
          "options": ["Salary est pour les cadres, wages pour les ouvriers", "Salary est mensuel et fixe, wages est horaire ou journalier", "Salary est en euros, wages en dollars", "Il n''y a aucune différence"],
          "correct": 1,
          "explanation": "Salary désigne un salaire fixe verse mensuellement ou annuellement, généralement pour les employes de bureau. Wages désigne un salaire calculé à l''heure ou à la journee, souvent pour les travailleurs manuels ou a temps partiel."
        },
        {
          "id": "q5",
          "question": "Lors d''un exercice True/False/Justify, que faut-il faire après avoir répondu True ou False ?",
          "options": ["Passer à la question suivante", "Justifier en citant ou reformulant un passage du texte", "Donner son opinion personnelle", "Traduire la phrase en français"],
          "correct": 1,
          "explanation": "Apres avoir répondu True ou False, il faut justifier sa réponse en citant ou en reformulant le passage du texte qui prouve que l''affirmation est vraie ou fausse. Sans justification, la réponse est généralement incomplete."
        },
        {
          "id": "q6",
          "question": "Comment dit-on ''embaucher'' et ''licencier'' en anglais ?",
          "options": ["To buy / to sell", "To hire / to fire", "To open / to close", "To start / to finish"],
          "correct": 1,
          "explanation": "''To hire'' signifie embaucher (recruter un employe) et ''to fire'' (ou ''to dismiss'') signifie licencier (renvoyer un employe). Ce sont des termes essentiels du vocabulaire du monde du travail en anglais."
        }
      ]
    }'::jsonb
  );

END $$;
