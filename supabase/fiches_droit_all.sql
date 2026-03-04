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
