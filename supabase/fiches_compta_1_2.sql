-- ============================================================
-- Fiches for TSECO Comptabilité: Chapters 1 & 2
-- Les effets de commerce + Le rapprochement bancaire
-- ============================================================

DO $$
DECLARE
  v_chapter_id UUID;
BEGIN

  -- ============================================================
  -- FICHE 1: Les effets de commerce: lettre de change et billet a ordre
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'effets-de-commerce';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: effets-de-commerce';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'effets-de-commerce-lettre-change-billet',
    'Les effets de commerce: lettre de change et billet a ordre',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce qu''un effet de commerce ?",
          "answer": "Titre négociable représentant une créance à terme. Il permet le paiement différé et peut circuler par endossement. Les principaux sont la lettre de change et le billet a ordre.",
          "category": "Définition"
        },
        {
          "question": "Quelle est la différence entre une lettre de change et un billet a ordre ?",
          "answer": "Lettre de change: émise par le créancier (tireur) qui donne l''ordre au débiteur (tire) de payer. Billet a ordre: émis par le débiteur qui s''engage a payer son créancier. La lettre implique 3 parties, le billet 2 parties.",
          "category": "Distinction"
        },
        {
          "question": "Quelles sont les 3 parties d''une lettre de change ?",
          "answer": "1. Le tireur: celui qui crée la lettre (créancier). 2. Le tire: celui qui doit payer (débiteur). 3. Le bénéficiaire: celui qui recevra le paiement (souvent le tireur lui-même ou un tiers).",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que l''endossement d''un effet de commerce ?",
          "answer": "Transfert de la propriété de l''effet à un tiers par signature au dos. L''endosseur transmet ses droits à l''endossataire. Cela permet la circulation de l''effet comme moyen de paiement.",
          "category": "Définition"
        },
        {
          "question": "Qu''est-ce que l''escompte bancaire d''un effet ?",
          "answer": "Operation par laquelle la banque avance au porteur le montant de l''effet avant l''échéance, diminue des agios (intérêts + commissions). Le porteur obtient de la trésorerie immédiate.",
          "category": "Définition"
        },
        {
          "question": "Quelles écritures comptables pour la création d''un effet a recevoir ?",
          "answer": "Chez le tireur: Debit 412 Effets a recevoir / Credit 411 Clients. Chez le tire: Debit 401 Fournisseurs / Credit 402 Effets a payer. Le montant est le nominal de l''effet.",
          "category": "Méthode"
        },
        {
          "question": "Quelles écritures pour l''encaissement d''un effet à l''échéance ?",
          "answer": "Chez le bénéficiaire: Debit 512 Banque / Credit 412 Effets a recevoir (pour le nominal). Chez le tire: Debit 402 Effets a payer / Credit 512 Banque.",
          "category": "Méthode"
        },
        {
          "question": "Comment traiter un effet impayé en comptabilité ?",
          "answer": "Chez le tireur: Debit 411 Clients / Credit 412 Effets a recevoir (rétablissement de la créance). On peut aussi debiter les frais de protet au client. Chez le tire: Debit 402 Effets a payer / Credit 401 Fournisseurs.",
          "category": "Méthode"
        }
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
          {"from": "n9", "to": "n10", "label": "si probleme"}
        ]
      },
      "quiz": [
        {
          "question": "Qui est le tireur d''une lettre de change ?",
          "options": ["Le débiteur qui doit payer", "Le créancier qui crée la lettre", "La banque qui escompte", "Le bénéficiaire final"],
          "correct": 1,
          "explanation": "Le tireur est le créancier. Il tire (cree) la lettre de change et donne l''ordre au tire (débiteur) de payer."
        },
        {
          "question": "Lors de la création d''un effet a recevoir, le tireur enregistre:",
          "options": ["Debit 411 / Credit 412", "Debit 412 / Credit 411", "Debit 512 / Credit 411", "Debit 402 / Credit 401"],
          "correct": 1,
          "explanation": "Le tireur debite le compte 412 Effets a recevoir et credite le compte 411 Clients pour constater la transformation de la créance en effet."
        },
        {
          "question": "Le billet a ordre est émis par:",
          "options": ["Le créancier", "La banque", "Le débiteur", "Le bénéficiaire"],
          "correct": 2,
          "explanation": "Le billet a ordre est émis par le débiteur (souscripteur) qui s''engage a payer le bénéficiaire à l''échéance."
        },
        {
          "question": "L''escompte d''un effet de 500 000 FCFA avec des agios de 12 000 FCFA donne un net en banque de:",
          "options": ["512 000 FCFA", "500 000 FCFA", "488 000 FCFA", "462 000 FCFA"],
          "correct": 2,
          "explanation": "Net en banque = Nominal - Agios = 500 000 - 12 000 = 488 000 FCFA. Les agios sont la rémunération de la banque pour l''avance de trésorerie."
        },
        {
          "question": "En cas d''effet impayé, le tireur passe l''écriture:",
          "options": ["Debit 512 / Credit 412", "Debit 411 / Credit 412", "Debit 412 / Credit 411", "Debit 402 / Credit 512"],
          "correct": 1,
          "explanation": "On retablit la créance client: Debit 411 Clients / Credit 412 Effets a recevoir. L''effet ne pouvant plus être encaisse, on revient à la créance initiale."
        },
        {
          "question": "L''endossement d''un effet de commerce permet de:",
          "options": ["Annuler la dette", "Transferer l''effet à un tiers", "Prolonger l''échéance", "Reduire le montant"],
          "correct": 1,
          "explanation": "L''endossement transmet la propriété de l''effet à un nouveau bénéficiaire (endossataire) par signature au dos du titre."
        }
      ]
    }'::jsonb
  );

  -- ============================================================
  -- FICHE 2: Le rapprochement bancaire: méthode et état
  -- ============================================================
  SELECT id INTO v_chapter_id FROM chapters WHERE slug = 'rapprochement-bancaire';

  IF v_chapter_id IS NULL THEN
    RAISE EXCEPTION 'Chapter not found: rapprochement-bancaire';
  END IF;

  INSERT INTO fiches (chapter_id, slug, title, is_free, is_published, display_order, content)
  VALUES (
    v_chapter_id,
    'rapprochement-bancaire-etat',
    'Le rapprochement bancaire: méthode et état',
    true,
    true,
    1,
    '{
      "flashcards": [
        {
          "question": "Qu''est-ce que le rapprochement bancaire ?",
          "answer": "Technique comptable consistant a comparer le solde du compte 512 Banque (tenu par l''entreprise) avec le solde de l''extrait bancaire (rélevé de la banque) pour expliquer les écarts et regulariser les comptes.",
          "category": "Définition"
        },
        {
          "question": "Quelles sont les principales causes d''écart entre le compte 512 et l''extrait bancaire ?",
          "answer": "1. Cheques émis non encore encaisses par le bénéficiaire. 2. Virements recus non encore comptabilises. 3. Frais et commissions bancaires. 4. Prelevements automatiques. 5. Erreurs d''enregistrement.",
          "category": "Méthode"
        },
        {
          "question": "En quoi consiste la méthode de pointage ?",
          "answer": "Comparer ligne par ligne le compte 512 et l''extrait bancaire. Cocher les opérations identiques. Les opérations non pointees expliquent la différence de solde entre les deux documents.",
          "category": "Méthode"
        },
        {
          "question": "Qu''est-ce que l''état de rapprochement ?",
          "answer": "Tableau a deux colonnes presentant: a gauche le compte 512 et a droite l''extrait bancaire. On part des soldes respectifs, on ajoute/retranche les opérations non pointees. Les soldes rectifies doivent être égaux.",
          "category": "Définition"
        },
        {
          "question": "Quelles écritures de régularisation passer après le rapprochement ?",
          "answer": "On passe uniquement les écritures correspondant aux opérations figurant sur l''extrait bancaire mais pas dans le compte 512: frais bancaires (Debit 627 / Credit 512), virements recus (Debit 512 / Credit 411 ou 7xx).",
          "category": "Méthode"
        },
        {
          "question": "Qu''est-ce que le solde réel de la banque ?",
          "answer": "C''est le solde rectifie obtenu après le rapprochement bancaire. Il correspond au montant réellement disponible sur le compte en banque. Les deux colonnes de l''état de rapprochement doivent aboutir au même solde réel.",
          "category": "Définition"
        },
        {
          "question": "Comment les frais bancaires apparaissent-ils dans le rapprochement ?",
          "answer": "Les frais sont debites par la banque sur l''extrait (donc déjà pris en compte cote banque) mais pas encore enregistrès dans le compte 512. Écriture: Debit 627 Services bancaires + 4456 TVA / Credit 512 Banque.",
          "category": "Méthode"
        },
        {
          "question": "Un virement en cours apparait sur l''extrait mais pas au compte 512. Que faire ?",
          "answer": "Il faut regulariser dans la comptabilité de l''entreprise. Écriture: Debit 512 Banque / Credit 411 Clients (si c''est un règlement client) ou Credit du compte concerne. Ce virement est ajoute cote compte 512 dans l''état de rapprochement.",
          "category": "Méthode"
        }
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
        {
          "question": "Le rapprochement bancaire compare:",
          "options": ["Deux comptes clients", "Le compte 512 et l''extrait bancaire", "Le journal et le grand livre", "Le bilan et le compte de résultat"],
          "correct": 1,
          "explanation": "Le rapprochement bancaire confronte le compte 512 Banque tenu par l''entreprise avec l''extrait de compte envoye par la banque."
        },
        {
          "question": "Un cheque de 150 000 FCFA émis par l''entreprise n''est pas encore encaisse. Dans l''état de rapprochement, ce montant figure:",
          "options": ["Au debit du compte 512", "Au credit du compte 512", "En déduction de l''extrait bancaire", "Il n''apparait pas"],
          "correct": 2,
          "explanation": "Le cheque est déjà enregistre au compte 512 (credit) mais la banque ne l''a pas encore debite. On le retranche du solde de l''extrait bancaire pour obtenir le solde réel."
        },
        {
          "question": "Des frais bancaires de 5 000 FCFA figurent sur l''extrait mais pas au compte 512. L''écriture de régularisation est:",
          "options": ["Debit 512 / Credit 627", "Debit 627 / Credit 512", "Debit 411 / Credit 512", "Debit 512 / Credit 411"],
          "correct": 1,
          "explanation": "Les frais bancaires: Debit 627 Services bancaires / Credit 512 Banque. Cela diminue le solde du compte 512."
        },
        {
          "question": "Apres rapprochement, les soldes rectifies des deux colonnes doivent être:",
          "options": ["Differents", "Egaux", "Nuls", "Positifs obligatoirement"],
          "correct": 1,
          "explanation": "Le principe du rapprochement bancaire est d''aboutir à des soldes rectifies égaux. S''ils différent, il reste des écarts non identifies."
        },
        {
          "question": "Le solde du compte 512 est de 800 000 FCFA. L''extrait bancaire indique 950 000 FCFA. Un cheque émis de 200 000 FCFA n''est pas encore encaisse et des frais bancaires de 50 000 FCFA ne sont pas enregistres. Le solde réel est de:",
          "options": ["800 000 FCFA", "750 000 FCFA", "950 000 FCFA", "700 000 FCFA"],
          "correct": 1,
          "explanation": "Solde 512 rectifie: 800 000 - 50 000 (frais) = 750 000. Extrait rectifie: 950 000 - 200 000 (cheque non encaisse) = 750 000. Le solde réel est 750 000 FCFA."
        },
        {
          "question": "Les écritures de régularisation se passent:",
          "options": ["Uniquement dans les livres de la banque", "Uniquement dans la comptabilité de l''entreprise", "Dans les deux comptabilités", "Nulle part, c''est juste un état"],
          "correct": 1,
          "explanation": "L''entreprise ne regularise que les opérations de l''extrait bancaire absentes du compte 512. Elle ne peut pas modifier les livres de la banque."
        }
      ]
    }'::jsonb
  );

END $$;
