
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
        {"id": "fc2", "question": "Qu''est-ce que l''éthique du juste milieu chez Aristote ?", "answer": "La vertu est un juste milieu entre deux excès (vices). Le courage est le milieu entre la lÃ¢chetÃ© (défaut) et la tÃ©mÃ©ritÃ© (excès). La générosité est le milieu entre l''avarice et la prodigalité. Il ne s''agit pas d''une médiocrité mais d''un équilibre raisonnable déterminé par la prudence (phronesis).", "category": "Définition"},
        {"id": "fc3", "question": "Pourquoi Aristote dit-il que l''homme est un animal politique ?", "answer": "Pour Aristote, l''homme est par nature un être social (zoon politikon). Il ne peut s''accomplir pleinement qu''au sein de la cite (polis). Seul un dieu ou une bete peut vivre hors de la société. La cite existe par nature et est antérieure à l''individu, car le tout précède les parties.", "category": "Définition"},
        {"id": "fc4", "question": "Qu''est-ce que le contrat social selon Rousseau ?", "answer": "Pacte par lequel les individus rénoncént a leur liberté naturelle pour obtenir la liberté civile et la protection de la communauté. Chacun s''unit a tous et n''obeit pourtant qu''a lui-même en obeissant à la volonté générale. Le souverain est le peuple tout entier.", "category": "Définition"},
        {"id": "fc5", "question": "Quelle est la différence entre l''état de nature et la société civile chez Rousseau ?", "answer": "État de nature: l''homme est libre, egal, bon et solitaire. Il vit selon ses besoins naturels. Société civile: nait avec la propriété privée qui créé les inégalités, la dépendance et la corruption morale. Rousseau ne propose pas un retour à l''état de nature mais un contrat social juste.", "category": "Distinction"},
        {"id": "fc6", "question": "Qu''est-ce que la volonté générale chez Rousseau ?", "answer": "La volonté générale vise l''intérêt commun de tous les citoyens. Elle se distingue de la volonté de tous (somme des intérêts particuliers). Elle est toujours droite et ne peut errer. La loi est l''expression de la volonté générale. Chaque citoyen participe à la souveraineté en contribuant à la volonté générale.", "category": "Distinction"},
        {"id": "fc7", "question": "Qu''est-ce que la philosophie africaine et le mouvement de la négritude ?", "answer": "La philosophie africaine affirme l''existence d''une pensée proprement africaine, fondée sur les traditions, l''oralité et la communauté. La négritude (Senghor, Césaire) valorise l''identité noire et la culture africaine face à la domination coloniale. Elle revendique la dignité et la contribution de l''Afrique à la civilisation universelle.", "category": "Définition"},
        {"id": "fc8", "question": "Quelle est la contribution de Youssouph Tata Guisse à la pensée africaine ?", "answer": "Guisse s''inscrit dans le courant de la philosophie africaine qui defend le dialogue des civilisations. Il soutient que l''Afrique possède une rationalité propre et que les cultures africaines doivent participer au dialogue universel sur un pied d''égalité. Il critique l''eurocentrisme en philosophie et valorise l''heritage intellectuel africain.", "category": "Définition"}
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
          {"from": "n1", "to": "n2", "label": "antiquité"},
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
        {"id": "q2", "question": "L''éthique du juste milieu d''Aristote signifie que la vertu est:", "options": ["L''absence de passion", "Un équilibre entre deux excès", "La soumission à la loi", "Le rejet de tout plaisir"], "correct": 1, "explanation": "Pour Aristote, la vertu (arete) est un juste milieu entre deux vices: l''un par excès et l''autre par défaut. Le courage est entre la lÃ¢chetÃ© et la tÃ©mÃ©ritÃ©."},
        {"id": "q3", "question": "Selon Rousseau, qu''est-ce qui marque le passage de l''état de nature à la société civile ?", "options": ["La guerre", "La propriété privée", "La religion", "Le commerce"], "correct": 1, "explanation": "Rousseau écrit dans le Discours sur l''inégalité que le premier qui dit ''ceci est a moi'' et fonda la propriété privée est le vrai fondateur de la société civile et de ses inégalités."},
        {"id": "q4", "question": "La volonté générale chez Rousseau vise:", "options": ["L''intérêt du plus fort", "L''intérêt particulier du prince", "L''intérêt commun de tous", "L''intérêt de la majorité seulement"], "correct": 2, "explanation": "La volonté générale vise toujours l''intérêt commun. Elle se distingue de la volonté de tous qui est la simple somme des volontés particulières."},
        {"id": "q5", "question": "Qu''est-ce que la négritude ?", "options": ["Un mouvement économique africain", "Un courant valorisant l''identité et la culture noire", "Une théorie scientifique", "Un parti politique"], "correct": 1, "explanation": "La négritude est un mouvement littéraire et philosophique (Senghor, Césaire, Damas) qui affirme et valorise l''identité culturelle noire face à l''assimilation coloniale."},
        {"id": "q6", "question": "Pour Aristote, l''homme est un ''animal politique'' car:", "options": ["Il aime le pouvoir", "Il ne peut s''accomplir que dans la cite", "Il est violent par nature", "Il obeit à un chef"], "correct": 1, "explanation": "Aristote affirme que l''homme est un zoon politikon: il est fait pour vivre en communauté dans la cite (polis). Seul un dieu ou une bete peut vivre isole."}
      ]
    }'::jsonb
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

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
        {"id": "q4", "question": "L''alienation du travail chez Marx désigne:", "options": ["Le plaisir que procure le travail", "Le fait que le travailleur est depossède du produit et du sens de son travail", "La fatigue physique au travail", "Le chômage volontaire"], "correct": 1, "explanation": "Pour Marx, le travailleur aliene ne se reconnait pas dans le produit de son travail. Il est réduit à une marchandise et perd son humanité dans un procèssus qu''il ne contrôle pas."},
        {"id": "q5", "question": "Dans l''allégorie de la caverne de Platon, les ombres sur le mur représentent:", "options": ["La vérité absolue", "Les opinions et les apparences trompeuses", "Les idées pures", "La connaissance scientifique"], "correct": 1, "explanation": "Les ombres représentent le monde des apparences, les opinions (doxa) que les hommes prennent pour la réalité. La sortie de la caverne symbolise l''accès à la connaissance vraie (épistémè) par la philosophie."},
        {"id": "q6", "question": "La différence entre droit naturel et droit positif est que:", "options": ["Le droit naturel est écrit et le droit positif est oral", "Le droit naturel est universel et le droit positif est propre à chaque société", "Le droit positif est supérieur au droit naturel", "Il n''y a aucune différence"], "correct": 1, "explanation": "Le droit naturel repose sur des principes universels (vie, liberté, égalité) inscrits dans la nature humaine. Le droit positif est l''ensemble des lois adoptées par une société, variables selon les epoques et les pays."}
      ]
    }'::jsonb
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

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
        {"id": "fc4", "question": "Qu''est-ce que la lutte des classes selon Marx ?", "answer": "Conflit fondamental entre les classes sociales aux intérêts opposes. Dans le capitalisme: la bourgeoisie (proprietaire des moyens de production) exploité le prôletariat (qui vend sa force de travail). Cette contradiction mene à la révolution prôletarienne et à l''avenement d''une société sans classes (communisme).", "category": "Définition"},
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
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

END $$;
-- ============================================================
-- Fiches for TSECO Droit commercial: All 3 chapters
-- 1. La règle de droit
-- 2. Preuves et entreprise commerciale
