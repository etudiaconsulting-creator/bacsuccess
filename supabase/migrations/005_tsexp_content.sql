-- ============================================================
-- BacSuccess - Migration 005: TSEXP Content
-- Série Terminale Sciences Expérimentales
-- 9 matières, 42 chapitres, 42 fiches
-- ============================================================

DO $$
DECLARE
  tsexp_id UUID;
  svt_id UUID;
  physique_id UUID;
  chimie_id UUID;
  maths_id UUID;
  philo_id UUID;
  anglais_id UUID;
  francais_id UUID;
  ecm_id UUID;
  eps_id UUID;
  v_chapter_id UUID;
BEGIN

  -- Get the TSEXP series ID
  SELECT id INTO tsexp_id FROM series WHERE slug = 'tsexp';
  IF tsexp_id IS NULL THEN RAISE EXCEPTION 'Series not found: tsexp'; END IF;

  -- Activate TSEXP series
  UPDATE series SET is_active = true, description = 'Terminale Sciences Expérimentales' WHERE id = tsexp_id;

  -- ============================================================
  -- SUBJECTS
  -- ============================================================

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'svt', 'Sciences de la Vie et de la Terre', 5, 7, 'svt', 'Dna', 1)
  RETURNING id INTO svt_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'physique', 'Physique', 2, 3, 'physique', 'Zap', 2)
  RETURNING id INTO physique_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'chimie', 'Chimie', 2, 3, 'chimie', 'FlaskConical', 3)
  RETURNING id INTO chimie_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'maths-tsexp', 'Mathématiques', 2, 3, 'maths', 'Compass', 4)
  RETURNING id INTO maths_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'philo-tsexp', 'Philosophie', 2, 2, 'philo', 'Brain', 5)
  RETURNING id INTO philo_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'anglais-tsexp', 'Anglais', 2, 2, 'anglais', 'Languages', 6)
  RETURNING id INTO anglais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'francais-tsexp', 'Français', 2, 2, 'francais', 'PenLine', 7)
  RETURNING id INTO francais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'ecm', 'Éducation Civique et Morale', 1, 1, 'ecm', 'Landmark', 8)
  RETURNING id INTO ecm_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tsexp_id, 'eps', 'Éducation Physique et Sportive', 1, 2, 'eps', 'Dumbbell', 9)
  RETURNING id INTO eps_id;

  -- ============================================================
  -- SVT - CHAPTER 1: La vie cellulaire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'vie-cellulaire', 1, 'La vie cellulaire', 'Structure cellulaire, organites, métabolisme', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'vie-cellulaire-fiche', 'La vie cellulaire', 'Structure, organites et métabolisme cellulaire', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une cellule ?","answer":"La cellule est l''unité structurale et fonctionnelle de tout être vivant. Elle est la plus petite entité capable de manifester les propriétés du vivant : nutrition, croissance, reproduction. On distingue les cellules procaryotes (sans noyau, ex : bactéries) et les cellules eucaryotes (avec noyau, ex : cellules animales et végétales)."},
      {"id":"fc2","category":"Définition","question":"Quelle est la différence entre une cellule animale et une cellule végétale ?","answer":"La cellule végétale possède une paroi cellulosique rigide, des chloroplastes (pour la photosynthèse), et une grande vacuole centrale. La cellule animale n''a pas de paroi cellulosique, pas de chloroplastes et possède des vacuoles plus petites. Les deux possèdent un noyau, des mitochondries, un réticulum endoplasmique et un appareil de Golgi."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que le métabolisme cellulaire ?","answer":"Le métabolisme est l''ensemble des réactions chimiques qui se déroulent dans la cellule. Il comprend l''anabolisme (synthèse de molécules complexes à partir de molécules simples, consomme de l''énergie) et le catabolisme (dégradation de molécules complexes en molécules simples, libère de l''énergie). L''ATP est la molécule énergétique universelle."},
      {"id":"fc4","category":"Concept","question":"Quel est le rôle des mitochondries ?","answer":"Les mitochondries sont les centrales énergétiques de la cellule. Elles réalisent la respiration cellulaire : C6H12O6 + 6O2 -> 6CO2 + 6H2O + 38 ATP. Elles possèdent une double membrane et leur propre ADN. L''énergie libérée par l''oxydation du glucose est stockée sous forme d''ATP utilisable par la cellule."},
      {"id":"fc5","category":"Concept","question":"Quel est le rôle des chloroplastes ?","answer":"Les chloroplastes sont les organites de la photosynthèse, présents uniquement dans les cellules végétales. Ils contiennent la chlorophylle qui capte l''énergie lumineuse. Équation bilan : 6CO2 + 6H2O + lumière -> C6H12O6 + 6O2. La photosynthèse comprend une phase claire (thylakoïdes) et une phase sombre (stroma, cycle de Calvin)."},
      {"id":"fc6","category":"Formule","question":"Quelle est l''équation bilan de la respiration cellulaire ?","answer":"C6H12O6 + 6O2 -> 6CO2 + 6H2O + énergie (38 ATP). La respiration comprend 3 étapes : 1) La glycolyse (cytoplasme) : glucose -> 2 pyruvates + 2 ATP. 2) Le cycle de Krebs (matrice mitochondriale) : pyruvate -> CO2 + coenzymes réduits. 3) La chaîne respiratoire (membrane interne) : coenzymes réduits + O2 -> H2O + 34 ATP."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre respiration et fermentation ?","answer":"La respiration est aérobie (nécessite O2) et produit 38 ATP par molécule de glucose. La fermentation est anaérobie (sans O2) et ne produit que 2 ATP. La fermentation alcoolique : glucose -> éthanol + CO2. La fermentation lactique : glucose -> acide lactique. La respiration est beaucoup plus rentable énergétiquement."},
      {"id":"fc8","category":"Méthode","question":"Comment observer des cellules au microscope optique ?","answer":"1) Préparer une lame mince : découper un fin fragment de tissu. 2) Placer sur la lame avec une goutte d''eau. 3) Recouvrir d''une lamelle en évitant les bulles d''air. 4) Colorer si nécessaire (bleu de méthylène pour le noyau, eau iodée pour l''amidon). 5) Observer d''abord au faible grossissement puis au fort grossissement. Le grossissement total = grossissement oculaire x grossissement objectif."},
      {"id":"fc9","category":"Concept","question":"Qu''est-ce que la membrane plasmique ?","answer":"La membrane plasmique est une bicouche de phospholipides qui délimite la cellule. Elle est semi-perméable : elle contrôle les échanges entre la cellule et son milieu. Elle contient des protéines membranaires (transport, réception de signaux). Les échanges se font par diffusion simple, diffusion facilitée, transport actif (nécessite de l''ATP) ou endocytose/exocytose."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre osmose et diffusion ?","answer":"La diffusion est le déplacement de solutés du milieu le plus concentré vers le moins concentré, sans dépense d''énergie. L''osmose est le déplacement de l''eau (solvant) du milieu le moins concentré (hypotonique) vers le plus concentré (hypertonique) à travers une membrane semi-perméable. En milieu hypertonique, la cellule perd de l''eau (plasmolyse). En milieu hypotonique, elle gonfle (turgescence)."},
      {"id":"fc11","category":"Exemple","question":"Qu''est-ce que la turgescence et la plasmolyse ?","answer":"La turgescence : en milieu hypotonique, l''eau entre dans la cellule par osmose, la cellule gonfle. Pour les cellules végétales, la paroi empêche l''éclatement. La plasmolyse : en milieu hypertonique, l''eau sort de la cellule, le cytoplasme se rétracte. Exemple : quand on sale une salade, les cellules perdent leur eau par plasmolyse et la salade ramollit."},
      {"id":"fc12","category":"Concept","question":"Quel est le rôle du réticulum endoplasmique et de l''appareil de Golgi ?","answer":"Le réticulum endoplasmique rugueux (RER) porte des ribosomes et synthétise les protéines. Le réticulum endoplasmique lisse (REL) synthétise les lipides et détoxifie. L''appareil de Golgi modifie, trie et emballe les protéines dans des vésicules pour les envoyer vers leur destination (sécrétion, membrane, lysosomes). C''est la voie de sécrétion cellulaire."}
    ],
    "schema": {
      "title": "Organisation de la vie cellulaire",
      "nodes": [
        {"id":"n1","label":"La cellule","type":"main"},
        {"id":"n2","label":"Structure","type":"branch"},
        {"id":"n3","label":"Métabolisme","type":"branch"},
        {"id":"n4","label":"Échanges","type":"branch"},
        {"id":"n5","label":"Membrane\nNoyau\nOrganites","type":"leaf"},
        {"id":"n6","label":"Cellule animale\nvs végétale","type":"leaf"},
        {"id":"n7","label":"Respiration\ncellulaire","type":"leaf"},
        {"id":"n8","label":"Photosynthèse\nFermentation","type":"leaf"},
        {"id":"n9","label":"Diffusion\nOsmose","type":"leaf"},
        {"id":"n10","label":"Transport actif\nEndocytose","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"organisation"},
        {"from":"n1","to":"n3","label":"réactions"},
        {"from":"n1","to":"n4","label":"membranaires"},
        {"from":"n2","to":"n5","label":"composants"},
        {"from":"n2","to":"n6","label":"types"},
        {"from":"n3","to":"n7","label":"catabolisme"},
        {"from":"n3","to":"n8","label":"anabolisme"},
        {"from":"n4","to":"n9","label":"passif"},
        {"from":"n4","to":"n10","label":"actif"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel organite est responsable de la respiration cellulaire ?","options":["Chloroplaste","Mitochondrie","Ribosome","Appareil de Golgi"],"correct":1,"explanation":"La mitochondrie est la centrale énergétique de la cellule. Elle réalise la respiration cellulaire qui produit 38 ATP à partir d''une molécule de glucose en présence d''oxygène."},
      {"id":"q2","question":"Combien de molécules d''ATP sont produites par la respiration cellulaire complète d''une molécule de glucose ?","options":["2 ATP","4 ATP","36 ATP","38 ATP"],"correct":3,"explanation":"La respiration cellulaire complète produit 38 ATP : 2 par la glycolyse, 2 par le cycle de Krebs et 34 par la chaîne respiratoire dans la membrane interne des mitochondries."},
      {"id":"q3","question":"Quelle structure est présente dans la cellule végétale mais absente de la cellule animale ?","options":["Mitochondrie","Noyau","Chloroplaste","Ribosome"],"correct":2,"explanation":"Le chloroplaste est spécifique aux cellules végétales. Il contient la chlorophylle et réalise la photosynthèse. Les mitochondries, le noyau et les ribosomes sont présents dans les deux types de cellules."},
      {"id":"q4","question":"Quelle est l''équation bilan de la photosynthèse ?","options":["C6H12O6 + 6O2 -> 6CO2 + 6H2O","6CO2 + 6H2O -> C6H12O6 + 6O2","C6H12O6 -> 2C2H5OH + 2CO2","6O2 + 6H2O -> 6CO2 + C6H12O6"],"correct":1,"explanation":"La photosynthèse utilise le CO2 et l''eau en présence de lumière pour produire du glucose et libérer de l''oxygène : 6CO2 + 6H2O + lumière -> C6H12O6 + 6O2."},
      {"id":"q5","question":"Qu''est-ce que la plasmolyse ?","options":["Le gonflement de la cellule en milieu hypotonique","La rétraction du cytoplasme en milieu hypertonique","La division cellulaire","La synthèse de protéines"],"correct":1,"explanation":"La plasmolyse est la rétraction du cytoplasme quand la cellule est placée en milieu hypertonique. L''eau sort de la cellule par osmose, ce qui provoque le décollement de la membrane plasmique de la paroi."},
      {"id":"q6","question":"Où se déroule la glycolyse ?","options":["Dans la mitochondrie","Dans le noyau","Dans le cytoplasme","Dans le chloroplaste"],"correct":2,"explanation":"La glycolyse se déroule dans le cytoplasme (hyaloplasme). Elle transforme une molécule de glucose en 2 molécules de pyruvate avec production de 2 ATP. C''est la première étape de la respiration cellulaire."},
      {"id":"q7","question":"Quel type de transport nécessite de l''énergie (ATP) ?","options":["La diffusion simple","L''osmose","Le transport actif","La diffusion facilitée"],"correct":2,"explanation":"Le transport actif nécessite de l''ATP car il déplace les substances contre leur gradient de concentration, du milieu le moins concentré vers le plus concentré. La diffusion et l''osmose sont des transports passifs."},
      {"id":"q8","question":"Combien d''ATP produit la fermentation alcoolique par molécule de glucose ?","options":["2 ATP","4 ATP","36 ATP","38 ATP"],"correct":0,"explanation":"La fermentation (alcoolique ou lactique) ne produit que 2 ATP par molécule de glucose, contre 38 ATP pour la respiration. La fermentation est anaérobie et beaucoup moins efficace énergétiquement."},
      {"id":"q9","question":"Quel organite synthétise les protéines ?","options":["Appareil de Golgi","Lysosome","Ribosome","Vacuole"],"correct":2,"explanation":"Les ribosomes sont les organites qui synthétisent les protéines en traduisant l''ARN messager. Ils peuvent être libres dans le cytoplasme ou fixés sur le réticulum endoplasmique rugueux (RER)."},
      {"id":"q10","question":"Quelle est la fonction principale de l''appareil de Golgi ?","options":["Produire de l''énergie","Modifier, trier et emballer les protéines","Synthétiser l''ADN","Réaliser la photosynthèse"],"correct":1,"explanation":"L''appareil de Golgi reçoit les protéines du RER, les modifie (glycosylation), les trie et les emballe dans des vésicules de sécrétion pour les envoyer vers leur destination finale."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 2: L''information génétique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'information-genetique', 2, 'L''information génétique', 'ADN, gènes, réplication, expression génétique', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'information-genetique-fiche', 'L''information génétique', 'ADN, réplication et expression des gènes', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''ADN ?","answer":"L''ADN (Acide DésoxyriboNucléique) est une macromolécule qui porte l''information génétique. C''est une double hélice formée de deux brins complémentaires de nucléotides. Chaque nucléotide est composé d''un sucre (désoxyribose), d''un groupement phosphate et d''une base azotée (A, T, C ou G). Les bases s''apparient : A-T et C-G."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les règles de Chargaff ?","answer":"Les règles de Chargaff établissent que dans l''ADN : le pourcentage d''adénine (A) est égal à celui de thymine (T), et le pourcentage de cytosine (C) est égal à celui de guanine (G). Donc A = T et C = G, et (A+T) + (C+G) = 100%. Ces règles découlent de la complémentarité des bases dans la double hélice."},
      {"id":"fc3","category":"Concept","question":"Comment se déroule la réplication de l''ADN ?","answer":"La réplication est semi-conservative : chaque brin sert de matrice. 1) L''hélicase ouvre la double hélice en séparant les deux brins. 2) L''ADN polymérase synthétise un nouveau brin complémentaire dans le sens 5''->3''. 3) Chaque molécule fille contient un brin ancien et un brin nouveau. La réplication a lieu en phase S du cycle cellulaire, avant la mitose."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un gène ?","answer":"Un gène est un segment d''ADN qui code pour la synthèse d''une protéine (ou d''un ARN fonctionnel). Il est constitué d''une séquence de nucléotides. L''ensemble des gènes d''un organisme constitue son génome. Chez l''homme, on estime environ 20 000 à 25 000 gènes. Un gène peut exister sous différentes versions appelées allèles."},
      {"id":"fc5","category":"Méthode","question":"Comment se déroule la transcription ?","answer":"La transcription est la synthèse d''ARN messager (ARNm) à partir d''un brin d''ADN. 1) L''ARN polymérase se fixe sur le promoteur du gène. 2) Elle lit le brin matrice d''ADN dans le sens 3''->5''. 3) Elle synthétise l''ARNm complémentaire dans le sens 5''->3''. 4) L''uracile (U) remplace la thymine (T) dans l''ARN. La transcription a lieu dans le noyau."},
      {"id":"fc6","category":"Méthode","question":"Comment se déroule la traduction ?","answer":"La traduction est la synthèse de protéines à partir de l''ARNm par les ribosomes. 1) L''ARNm s''attache au ribosome. 2) Les ARN de transfert (ARNt) apportent les acides aminés correspondant à chaque codon (triplet de bases). 3) Le codon AUG (méthionine) est le codon d''initiation. 4) Les codons UAA, UAG, UGA sont les codons stop. La traduction a lieu dans le cytoplasme."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre ADN et ARN ?","answer":"L''ADN est bicaténaire (double brin), contient du désoxyribose et la base thymine (T). L''ARN est monocaténaire (simple brin), contient du ribose et la base uracile (U) à la place de la thymine. L''ADN reste dans le noyau, l''ARN peut sortir dans le cytoplasme. Il existe plusieurs types d''ARN : ARNm (messager), ARNt (transfert), ARNr (ribosomique)."},
      {"id":"fc8","category":"Concept","question":"Qu''est-ce que le code génétique ?","answer":"Le code génétique est la correspondance entre les codons (triplets de nucléotides de l''ARNm) et les acides aminés. Il est universel (le même chez tous les êtres vivants), dégénéré (plusieurs codons pour un même acide aminé, car 64 codons pour 20 acides aminés), non chevauchant et sans ponctuation. Le codon AUG code pour la méthionine et sert de codon d''initiation."},
      {"id":"fc9","category":"Exemple","question":"Comment lit-on un codon dans le tableau du code génétique ?","answer":"Pour lire un codon, on utilise le tableau du code génétique. Exemple : le codon GCU. 1) Première lettre G : on cherche la ligne G. 2) Deuxième lettre C : on cherche la colonne C. 3) Troisième lettre U : on trouve Alanine (Ala). Autre exemple : AUG code pour la Méthionine et c''est aussi le codon d''initiation de la traduction."},
      {"id":"fc10","category":"Définition","question":"Qu''est-ce qu''une mutation ?","answer":"Une mutation est une modification de la séquence de l''ADN. Types de mutations ponctuelles : substitution (remplacement d''une base par une autre), insertion (ajout d''une base), délétion (perte d''une base). Les insertions et délétions décalent le cadre de lecture. Les mutations peuvent être silencieuses, faux-sens ou non-sens selon leur effet sur la protéine."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre mutation silencieuse, faux-sens et non-sens ?","answer":"Mutation silencieuse : le codon modifié code toujours pour le même acide aminé (grâce à la dégénérescence du code). Mutation faux-sens : le codon modifié code pour un acide aminé différent, ce qui peut altérer la protéine. Mutation non-sens : le codon modifié devient un codon stop (UAA, UAG, UGA), ce qui produit une protéine tronquée, souvent non fonctionnelle."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que le dogme central de la biologie moléculaire ?","answer":"Le dogme central décrit le flux de l''information génétique : ADN -> (transcription) -> ARNm -> (traduction) -> Protéine. L''ADN est répliqué avant la division cellulaire. L''information va de l''ADN vers les protéines, jamais en sens inverse (sauf chez certains virus à ARN avec la transcriptase inverse). Ce dogme a été énoncé par Francis Crick en 1958."}
    ],
    "schema": {
      "title": "L''information génétique",
      "nodes": [
        {"id":"n1","label":"Information\ngénétique","type":"main"},
        {"id":"n2","label":"Support :\nADN","type":"branch"},
        {"id":"n3","label":"Expression\ndes gènes","type":"branch"},
        {"id":"n4","label":"Mutations","type":"branch"},
        {"id":"n5","label":"Double hélice\nBases A-T C-G","type":"leaf"},
        {"id":"n6","label":"Réplication\nsemi-conservative","type":"leaf"},
        {"id":"n7","label":"Transcription\nADN -> ARNm","type":"leaf"},
        {"id":"n8","label":"Traduction\nARNm -> Protéine","type":"leaf"},
        {"id":"n9","label":"Substitution\nInsertion\nDélétion","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"support"},
        {"from":"n1","to":"n3","label":"expression"},
        {"from":"n1","to":"n4","label":"modifications"},
        {"from":"n2","to":"n5","label":"structure"},
        {"from":"n2","to":"n6","label":"copie"},
        {"from":"n3","to":"n7","label":"noyau"},
        {"from":"n3","to":"n8","label":"cytoplasme"},
        {"from":"n4","to":"n9","label":"types"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelles bases azotées s''apparient dans l''ADN ?","options":["A-C et T-G","A-G et T-C","A-T et C-G","A-U et C-G"],"correct":2,"explanation":"Dans l''ADN, l''adénine (A) s''apparie avec la thymine (T) par 2 liaisons hydrogène, et la cytosine (C) s''apparie avec la guanine (G) par 3 liaisons hydrogène. Dans l''ARN, l''uracile remplace la thymine."},
      {"id":"q2","question":"La réplication de l''ADN est dite semi-conservative car :","options":["Seule la moitié de l''ADN est copiée","Chaque molécule fille contient un brin ancien et un brin nouveau","Un seul brin est répliqué","La réplication n''est pas fidèle"],"correct":1,"explanation":"La réplication semi-conservative signifie que chaque molécule d''ADN fille est constituée d''un brin parental (ancien) et d''un brin néosynthétisé (nouveau). Cela a été démontré par l''expérience de Meselson et Stahl en 1958."},
      {"id":"q3","question":"Quel est le codon d''initiation de la traduction ?","options":["UAA","UAG","UGA","AUG"],"correct":3,"explanation":"Le codon AUG est le codon d''initiation. Il code pour la méthionine, qui est le premier acide aminé de toute protéine. Les codons UAA, UAG et UGA sont les codons stop qui terminent la traduction."},
      {"id":"q4","question":"Quelle enzyme réalise la transcription ?","options":["ADN polymérase","ARN polymérase","Hélicase","Ligase"],"correct":1,"explanation":"L''ARN polymérase est l''enzyme qui synthétise l''ARNm à partir du brin matrice d''ADN. L''ADN polymérase réalise la réplication. L''hélicase sépare les deux brins d''ADN."},
      {"id":"q5","question":"Si un brin d''ADN a la séquence ATCGTA, quelle est la séquence du brin complémentaire ?","options":["TAGCAT","UAGCAU","ATCGTA","GCTABC"],"correct":0,"explanation":"Par complémentarité des bases (A-T et C-G) : A donne T, T donne A, C donne G, G donne C, T donne A, A donne T. Le brin complémentaire est donc TAGCAT."},
      {"id":"q6","question":"Où a lieu la traduction ?","options":["Dans le noyau","Sur les ribosomes dans le cytoplasme","Dans la mitochondrie","Dans l''appareil de Golgi"],"correct":1,"explanation":"La traduction a lieu sur les ribosomes, dans le cytoplasme. L''ARNm sort du noyau par les pores nucléaires et se fixe sur les ribosomes. Les ARNt apportent les acides aminés correspondant à chaque codon."},
      {"id":"q7","question":"Le code génétique est dit dégénéré car :","options":["Il contient des erreurs","Plusieurs codons peuvent coder pour le même acide aminé","Chaque codon code pour plusieurs acides aminés","Il est différent selon les espèces"],"correct":1,"explanation":"Le code génétique est dégénéré (ou redondant) car il y a 64 codons possibles pour seulement 20 acides aminés. Ainsi, plusieurs codons peuvent coder pour le même acide aminé. Par exemple, GCU, GCC, GCA et GCG codent tous pour l''alanine."},
      {"id":"q8","question":"Quelle mutation provoque l''apparition d''un codon stop prématuré ?","options":["Mutation silencieuse","Mutation faux-sens","Mutation non-sens","Mutation neutre"],"correct":2,"explanation":"La mutation non-sens transforme un codon codant en codon stop (UAA, UAG ou UGA), ce qui provoque l''arrêt prématuré de la traduction et produit une protéine tronquée, généralement non fonctionnelle."},
      {"id":"q9","question":"Quelle base azotée est présente dans l''ARN mais pas dans l''ADN ?","options":["Adénine","Thymine","Uracile","Cytosine"],"correct":2,"explanation":"L''uracile (U) remplace la thymine (T) dans l''ARN. L''uracile s''apparie avec l''adénine (A) comme la thymine. Les autres bases (A, C, G) sont communes à l''ADN et à l''ARN."},
      {"id":"q10","question":"Combien d''acides aminés sont codés par le code génétique ?","options":["4","20","64","61"],"correct":1,"explanation":"Le code génétique code pour 20 acides aminés différents. Il existe 64 codons possibles (4^3), dont 61 codent pour des acides aminés et 3 sont des codons stop (UAA, UAG, UGA)."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 3: L'unicité des individus et la diversité génétique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'unicite-diversite-genetique', 3, 'L''unicité des individus et la diversité génétique', 'Méiose, brassage génétique, crossing-over', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'unicite-diversite-genetique-fiche', 'L''unicité des individus et la diversité génétique', 'Méiose, brassage génétique et diversité', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la méiose ?","answer":"La méiose est une division cellulaire qui produit 4 cellules haploïdes (n) à partir d''une cellule diploïde (2n). Elle comprend deux divisions successives : la division réductionnelle (séparation des chromosomes homologues) et la division équationnelle (séparation des chromatides). La méiose intervient dans la formation des gamètes (spermatozoïdes et ovules)."},
      {"id":"fc2","category":"Distinction","question":"Quelle différence entre mitose et méiose ?","answer":"La mitose produit 2 cellules diploïdes (2n) identiques à la cellule mère. Elle intervient dans la croissance et la réparation. La méiose produit 4 cellules haploïdes (n) génétiquement différentes. Elle intervient dans la formation des gamètes. La mitose comporte 1 division, la méiose en comporte 2. La méiose inclut des brassages génétiques (inter et intrachromosomique)."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que le brassage intrachromosomique ?","answer":"Le brassage intrachromosomique (crossing-over) se produit en prophase I de méiose. Les chromosomes homologues échangent des segments de chromatides au niveau des chiasmas. Cela crée de nouvelles combinaisons d''allèles sur un même chromosome. Le crossing-over augmente la diversité génétique des gamètes produits."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que le brassage interchromosomique ?","answer":"Le brassage interchromosomique se produit en métaphase I. Les paires de chromosomes homologues se placent aléatoirement de part et d''autre du plan équatorial. Chaque gamète reçoit une combinaison aléatoire de chromosomes paternels et maternels. Pour n paires de chromosomes, il y a 2^n combinaisons possibles. Chez l''homme (n=23) : 2^23 = 8 388 608 combinaisons."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce qu''un caryotype ?","answer":"Le caryotype est l''ensemble des chromosomes d''une cellule, classés par paires et par taille. Chez l''homme : 46 chromosomes = 22 paires d''autosomes + 1 paire de gonosomes (XX chez la femme, XY chez l''homme). Le caryotype permet de détecter des anomalies chromosomiques comme la trisomie 21 (3 chromosomes 21 au lieu de 2)."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre homozygote et hétérozygote ?","answer":"Un individu homozygote possède deux allèles identiques pour un gène donné (ex : AA ou aa). Un individu hétérozygote possède deux allèles différents (ex : Aa). Le phénotype d''un hétérozygote dépend de la dominance : si A est dominant sur a, l''hétérozygote Aa a le même phénotype que l''homozygote AA. L''allèle récessif ne s''exprime qu''à l''état homozygote (aa)."},
      {"id":"fc7","category":"Formule","question":"Comment utiliser un échiquier de Punnett ?","answer":"L''échiquier de Punnett permet de prévoir les résultats d''un croisement. On place les gamètes d''un parent en ligne et ceux de l''autre en colonne. Exemple : Aa x Aa. Gamètes : A et a pour chaque parent. Résultats : 1/4 AA, 2/4 Aa, 1/4 aa. Proportions phénotypiques (si A dominant) : 3/4 phénotype dominant, 1/4 phénotype récessif. C''est le ratio 3:1 de Mendel."},
      {"id":"fc8","category":"Méthode","question":"Comment déterminer si un gène est dominant ou récessif ?","answer":"1) Croiser deux parents de phénotypes différents (P1 x P2). 2) Si tous les individus F1 ont le même phénotype, le caractère exprimé est dominant. 3) Croiser les F1 entre eux. 4) Si on obtient un ratio 3:1 en F2, le caractère est monohybride avec dominance complète. 5) Un test-cross (croisement avec un homozygote récessif) permet de déterminer le génotype d''un individu de phénotype dominant."},
      {"id":"fc9","category":"Exemple","question":"Qu''est-ce que la trisomie 21 ?","answer":"La trisomie 21 (syndrome de Down) est une anomalie chromosomique causée par la présence de 3 chromosomes 21 au lieu de 2. Elle résulte d''une non-disjonction des chromosomes en méiose, produisant un gamète avec 2 chromosomes 21. L''individu possède alors 47 chromosomes au lieu de 46. Elle provoque un retard mental, des traits physiques caractéristiques et parfois des malformations cardiaques."},
      {"id":"fc10","category":"Concept","question":"Qu''est-ce que la fécondation et quel est son rôle dans la diversité ?","answer":"La fécondation est la fusion d''un gamète mâle (n) et d''un gamète femelle (n) pour former un zygote diploïde (2n). Elle rétablit la diploïdie. La rencontre aléatoire des gamètes ajoute un niveau supplémentaire de diversité génétique. Avec les brassages de la méiose, la fécondation assure l''unicité de chaque individu (sauf les vrais jumeaux)."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre génotype et phénotype ?","answer":"Le génotype est l''ensemble des allèles d''un individu pour un ou plusieurs gènes. Le phénotype est l''ensemble des caractères observables d''un individu (morphologiques, physiologiques, moléculaires). Le phénotype dépend du génotype mais aussi de l''environnement. Exemple : deux vrais jumeaux ont le même génotype mais peuvent avoir des phénotypes légèrement différents."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que la transmission liée au sexe ?","answer":"Certains gènes sont portés par les chromosomes sexuels (gonosomes), notamment le chromosome X. Un caractère récessif lié à l''X s''exprime plus souvent chez les hommes (XY) car ils n''ont qu''un seul X. Exemple : le daltonisme et l''hémophilie. Un homme daltonien (X^d Y) a reçu l''allèle de sa mère porteuse (X^D X^d). Une femme n''est daltonienne que si elle est homozygote (X^d X^d)."}
    ],
    "schema": {
      "title": "Unicité et diversité génétique",
      "nodes": [
        {"id":"n1","label":"Diversité\ngénétique","type":"main"},
        {"id":"n2","label":"Méiose","type":"branch"},
        {"id":"n3","label":"Brassages","type":"branch"},
        {"id":"n4","label":"Fécondation","type":"branch"},
        {"id":"n5","label":"Division\nréductionnelle","type":"leaf"},
        {"id":"n6","label":"Division\néquationnelle","type":"leaf"},
        {"id":"n7","label":"Crossing-over\n(intra)","type":"leaf"},
        {"id":"n8","label":"Répartition\naléatoire (inter)","type":"leaf"},
        {"id":"n9","label":"Rencontre\naléatoire","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"division"},
        {"from":"n1","to":"n3","label":"recombinaison"},
        {"from":"n1","to":"n4","label":"union"},
        {"from":"n2","to":"n5","label":"1re division"},
        {"from":"n2","to":"n6","label":"2e division"},
        {"from":"n3","to":"n7","label":"prophase I"},
        {"from":"n3","to":"n8","label":"métaphase I"},
        {"from":"n4","to":"n9","label":"gamètes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Combien de cellules sont produites à la fin de la méiose ?","options":["2 cellules diploïdes","2 cellules haploïdes","4 cellules diploïdes","4 cellules haploïdes"],"correct":3,"explanation":"La méiose produit 4 cellules haploïdes (n chromosomes) à partir d''une cellule diploïde (2n chromosomes). La première division sépare les chromosomes homologues, la seconde sépare les chromatides."},
      {"id":"q2","question":"Le brassage intrachromosomique se produit lors de :","options":["La prophase I","La métaphase I","L''anaphase II","La télophase II"],"correct":0,"explanation":"Le crossing-over (brassage intrachromosomique) se produit en prophase I de méiose, quand les chromosomes homologues s''apparient et échangent des segments au niveau des chiasmas."},
      {"id":"q3","question":"Chez l''homme (2n = 46), combien de combinaisons chromosomiques différentes la méiose peut-elle produire par brassage interchromosomique ?","options":["23","46","2^23 soit environ 8 millions","2^46"],"correct":2,"explanation":"Le brassage interchromosomique produit 2^n combinaisons possibles. Chez l''homme avec n = 23 paires : 2^23 = 8 388 608 combinaisons différentes de chromosomes dans les gamètes."},
      {"id":"q4","question":"Le croisement Aa x Aa donne en F2 les proportions génotypiques :","options":["100% Aa","1/4 AA, 2/4 Aa, 1/4 aa","1/2 AA, 1/2 aa","3/4 AA, 1/4 aa"],"correct":1,"explanation":"Le croisement Aa x Aa donne : 1/4 AA + 2/4 Aa + 1/4 aa. Si A est dominant, le ratio phénotypique est 3/4 dominant : 1/4 récessif (loi de Mendel)."},
      {"id":"q5","question":"La trisomie 21 est due à :","options":["Une mutation ponctuelle","Une non-disjonction chromosomique en méiose","Un crossing-over anormal","Une délétion chromosomique"],"correct":1,"explanation":"La trisomie 21 résulte d''une non-disjonction des chromosomes 21 pendant la méiose (en anaphase I ou II). Un gamète reçoit 2 chromosomes 21 au lieu de 1, donnant un individu à 47 chromosomes."},
      {"id":"q6","question":"Qu''est-ce qu''un test-cross ?","options":["Un croisement entre deux hétérozygotes","Un croisement avec un homozygote récessif","Un croisement entre deux lignées pures","Un croisement entre deux espèces différentes"],"correct":1,"explanation":"Le test-cross est le croisement d''un individu de phénotype dominant (génotype inconnu) avec un homozygote récessif. Il permet de déterminer si l''individu testé est homozygote (AA) ou hétérozygote (Aa) en analysant les proportions de la descendance."},
      {"id":"q7","question":"Le daltonisme est une maladie récessive liée au chromosome X. Un père daltonien et une mère porteuse saine auront :","options":["Tous les enfants daltoniens","1/2 des garçons daltoniens, 1/2 des filles daltoniennes","1/2 des garçons daltoniens, 1/2 des filles porteuses","Aucun enfant daltonien"],"correct":2,"explanation":"Père X^d Y, Mère X^D X^d. Filles : 1/2 X^D X^d (porteuses) et 1/2 X^d X^d (daltoniennes). Garçons : 1/2 X^D Y (normaux) et 1/2 X^d Y (daltoniens). Donc 1/2 des garçons et 1/2 des filles sont atteints."},
      {"id":"q8","question":"La fécondation permet de :","options":["Réduire le nombre de chromosomes","Rétablir la diploïdie","Provoquer des mutations","Réaliser le crossing-over"],"correct":1,"explanation":"La fécondation rétablit la diploïdie (2n) en fusionnant un gamète mâle haploïde (n) et un gamète femelle haploïde (n). Elle ajoute aussi de la diversité par la rencontre aléatoire des gamètes."},
      {"id":"q9","question":"Le phénotype d''un individu dépend :","options":["Uniquement du génotype","Uniquement de l''environnement","Du génotype et de l''environnement","Uniquement des gènes dominants"],"correct":2,"explanation":"Le phénotype résulte de l''interaction entre le génotype (ensemble des allèles) et l''environnement. Par exemple, la taille dépend des gènes mais aussi de l''alimentation. Deux vrais jumeaux (même génotype) peuvent avoir des phénotypes différents."},
      {"id":"q10","question":"Qu''est-ce qu''un allèle ?","options":["Un chromosome sexuel","Une version d''un gène","Un type de mutation","Un segment d''ARN"],"correct":1,"explanation":"Un allèle est une version d''un gène. Par exemple, le gène de la couleur des yeux peut avoir l''allèle \"marron\" ou l''allèle \"bleu\". Un individu diploïde possède deux allèles pour chaque gène, un hérité de chaque parent."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 4: Les mécanismes de l'immunité
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'mecanismes-immunite', 4, 'Les mécanismes de l''immunité', 'Immunité innée, adaptative, anticorps, vaccins', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'mecanismes-immunite-fiche', 'Les mécanismes de l''immunité', 'Défenses de l''organisme contre les agents pathogènes', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''immunité innée ?","answer":"L''immunité innée (non spécifique) est la première ligne de défense de l''organisme. Elle est présente dès la naissance et agit immédiatement. Elle comprend : les barrières naturelles (peau, muqueuses), la réaction inflammatoire (rougeur, chaleur, gonflement, douleur) et la phagocytose par les macrophages et les polynucléaires neutrophiles."},
      {"id":"fc2","category":"Méthode","question":"Comment se déroule la phagocytose ?","answer":"La phagocytose se déroule en 4 étapes : 1) Adhésion : le phagocyte se fixe sur l''agent pathogène. 2) Ingestion : le phagocyte englobe le pathogène par des pseudopodes formant un phagosome. 3) Digestion : fusion du phagosome avec les lysosomes qui contiennent des enzymes digestives. 4) Rejet : les déchets sont expulsés par exocytose."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que l''immunité adaptative ?","answer":"L''immunité adaptative (spécifique) est la deuxième ligne de défense. Elle est acquise après contact avec un antigène et possède une mémoire. Elle comprend : l''immunité humorale (production d''anticorps par les lymphocytes B) et l''immunité cellulaire (destruction des cellules infectées par les lymphocytes T cytotoxiques). Elle est plus lente mais plus efficace et spécifique."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce qu''un anticorps ?","answer":"Un anticorps (immunoglobuline) est une protéine en forme de Y produite par les plasmocytes (lymphocytes B activés). Il possède 2 sites de fixation spécifiques à un antigène donné. Les anticorps neutralisent les antigènes en formant des complexes immuns, facilitent la phagocytose (opsonisation) et activent le complément. Il existe 5 classes : IgG, IgM, IgA, IgE, IgD."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre lymphocytes B et lymphocytes T ?","answer":"Les lymphocytes B mûrissent dans la moelle osseuse et sont responsables de l''immunité humorale. Ils se différencient en plasmocytes qui sécrètent des anticorps. Les lymphocytes T mûrissent dans le thymus. Les LT4 (auxiliaires) coordonnent la réponse immunitaire en sécrétant des interleukines. Les LT8 (cytotoxiques) détruisent directement les cellules infectées par contact."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que la mémoire immunitaire ?","answer":"Lors du premier contact avec un antigène (réponse primaire), la production d''anticorps est lente et faible. Certains lymphocytes B et T deviennent des cellules mémoire à longue durée de vie. Lors d''un second contact avec le même antigène (réponse secondaire), la réponse est plus rapide, plus intense et plus durable grâce à ces cellules mémoire. C''est le principe de la vaccination."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce qu''un antigène ?","answer":"Un antigène est toute molécule capable de déclencher une réponse immunitaire. Il peut être porté par des bactéries, virus, cellules étrangères ou substances chimiques. L''épitope (déterminant antigénique) est la partie de l''antigène reconnue spécifiquement par les récepteurs des lymphocytes ou les anticorps. Un même antigène peut porter plusieurs épitopes différents."},
      {"id":"fc8","category":"Méthode","question":"Comment fonctionne la vaccination ?","answer":"La vaccination consiste à introduire un antigène atténué ou inactivé dans l''organisme pour provoquer une réponse immunitaire primaire sans maladie. L''organisme produit des cellules mémoire. Lors d''un contact ultérieur avec le vrai pathogène, la réponse secondaire est rapide et efficace. Les rappels renforcent la mémoire immunitaire. Types de vaccins : vivants atténués, inactivés, sous-unitaires."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre sérothérapie et vaccination ?","answer":"La vaccination est une immunisation active : l''organisme produit lui-même ses anticorps et cellules mémoire. Protection durable mais lente à se mettre en place. La sérothérapie est une immunisation passive : on injecte des anticorps préformés (sérum). Protection immédiate mais temporaire (quelques semaines). La sérothérapie est utilisée en urgence (morsure de serpent, tétanos)."},
      {"id":"fc10","category":"Concept","question":"Qu''est-ce que le VIH et le SIDA ?","answer":"Le VIH (Virus de l''Immunodéficience Humaine) infecte les lymphocytes T4 (auxiliaires). Il se multiplie dans ces cellules et les détruit progressivement. Quand le nombre de LT4 chute en dessous de 200/mm3 (normal : 800-1200), l''immunité est gravement affaiblie : c''est le SIDA. L''organisme devient vulnérable aux infections opportunistes. Transmission : sexuelle, sanguine, mère-enfant."},
      {"id":"fc11","category":"Exemple","question":"Qu''est-ce que la réaction inflammatoire ?","answer":"La réaction inflammatoire est une réponse locale de l''immunité innée. Signes : rougeur, chaleur, gonflement, douleur. Mécanisme : 1) Lésion tissulaire. 2) Libération de médiateurs chimiques (histamine). 3) Vasodilatation et augmentation de la perméabilité vasculaire. 4) Afflux de leucocytes (diapédèse). 5) Phagocytose des pathogènes. C''est un processus bénéfique de défense."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que le système du complément ?","answer":"Le système du complément est un ensemble de protéines plasmatiques de l''immunité innée. Il peut être activé directement par les pathogènes ou par les complexes anticorps-antigènes. Ses fonctions : lyse des pathogènes (formation du complexe d''attaque membranaire), opsonisation (facilite la phagocytose), chimiotactisme (attire les phagocytes) et activation de la réaction inflammatoire."}
    ],
    "schema": {
      "title": "Les mécanismes de l''immunité",
      "nodes": [
        {"id":"n1","label":"Immunité","type":"main"},
        {"id":"n2","label":"Innée\n(non spécifique)","type":"branch"},
        {"id":"n3","label":"Adaptative\n(spécifique)","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"Barrières\nInflammation\nPhagocytose","type":"leaf"},
        {"id":"n6","label":"Humorale\n(anticorps, LB)","type":"leaf"},
        {"id":"n7","label":"Cellulaire\n(LT cytotoxiques)","type":"leaf"},
        {"id":"n8","label":"Vaccination\nSérothérapie","type":"leaf"},
        {"id":"n9","label":"VIH / SIDA","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"immédiate"},
        {"from":"n1","to":"n3","label":"acquise"},
        {"from":"n1","to":"n4","label":"médecine"},
        {"from":"n2","to":"n5","label":"mécanismes"},
        {"from":"n3","to":"n6","label":"anticorps"},
        {"from":"n3","to":"n7","label":"destruction"},
        {"from":"n4","to":"n8","label":"prévention"},
        {"from":"n4","to":"n9","label":"pathologie"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle cellule est la cible principale du VIH ?","options":["Lymphocyte B","Lymphocyte T8","Lymphocyte T4","Macrophage"],"correct":2,"explanation":"Le VIH infecte principalement les lymphocytes T4 (auxiliaires) qui portent le récepteur CD4. La destruction progressive des LT4 entraîne un effondrement du système immunitaire adaptatif."},
      {"id":"q2","question":"Les anticorps sont produits par :","options":["Les lymphocytes T cytotoxiques","Les macrophages","Les plasmocytes (LB activés)","Les polynucléaires"],"correct":2,"explanation":"Les anticorps sont produits par les plasmocytes, qui sont des lymphocytes B activés et différenciés. Chaque plasmocyte sécrète un seul type d''anticorps spécifique d''un antigène."},
      {"id":"q3","question":"Quels sont les 4 signes de la réaction inflammatoire ?","options":["Fièvre, toux, fatigue, douleur","Rougeur, chaleur, gonflement, douleur","Rougeur, froid, gonflement, fièvre","Pâleur, chaleur, démangeaison, douleur"],"correct":1,"explanation":"Les 4 signes cardinaux de l''inflammation sont : rougeur et chaleur (vasodilatation), gonflement (oedème dû à l''augmentation de la perméabilité vasculaire) et douleur (stimulation des terminaisons nerveuses)."},
      {"id":"q4","question":"La vaccination est une immunisation :","options":["Passive et temporaire","Active et durable","Passive et durable","Active et temporaire"],"correct":1,"explanation":"La vaccination est une immunisation active car l''organisme produit lui-même ses anticorps et ses cellules mémoire. Elle est durable grâce à la mémoire immunitaire. La sérothérapie est passive (anticorps injectés) et temporaire."},
      {"id":"q5","question":"Les étapes de la phagocytose dans l''ordre sont :","options":["Ingestion, adhésion, digestion, rejet","Adhésion, ingestion, digestion, rejet","Digestion, adhésion, ingestion, rejet","Adhésion, digestion, ingestion, rejet"],"correct":1,"explanation":"L''ordre correct est : 1) Adhésion du phagocyte au pathogène, 2) Ingestion par des pseudopodes (formation du phagosome), 3) Digestion par les enzymes des lysosomes, 4) Rejet des déchets par exocytose."},
      {"id":"q6","question":"Quelle est la différence principale entre réponse primaire et secondaire ?","options":["La primaire est plus rapide","La secondaire est plus lente","La secondaire est plus rapide et plus intense","Elles sont identiques"],"correct":2,"explanation":"La réponse secondaire est plus rapide, plus intense et plus durable que la primaire grâce aux cellules mémoire produites lors du premier contact. C''est le fondement de la vaccination."},
      {"id":"q7","question":"Les lymphocytes T cytotoxiques (LT8) détruisent les cellules infectées par :","options":["Sécrétion d''anticorps","Contact direct et libération de perforine","Phagocytose","Sécrétion d''histamine"],"correct":1,"explanation":"Les LT8 cytotoxiques reconnaissent les cellules infectées et les détruisent par contact direct. Ils libèrent de la perforine (qui perfore la membrane) et des granzymes (qui déclenchent l''apoptose)."},
      {"id":"q8","question":"Le SIDA se déclare quand le taux de LT4 descend en dessous de :","options":["1000/mm3","500/mm3","200/mm3","50/mm3"],"correct":2,"explanation":"Le SIDA se déclare quand le taux de LT4 chute en dessous de 200/mm3 (normal : 800-1200/mm3). À ce stade, le système immunitaire est trop affaibli pour combattre les infections opportunistes."},
      {"id":"q9","question":"L''immunité innée est dite non spécifique car :","options":["Elle ne fonctionne pas toujours","Elle agit de la même manière contre tous les pathogènes","Elle ne produit pas d''anticorps","Elle est présente uniquement chez les enfants"],"correct":1,"explanation":"L''immunité innée est non spécifique car elle agit de la même manière quel que soit le pathogène rencontré. La phagocytose et la réaction inflammatoire ne distinguent pas les types de pathogènes, contrairement à l''immunité adaptative."},
      {"id":"q10","question":"Quel mode de transmission N''est PAS associé au VIH ?","options":["Transmission sexuelle","Transmission par la salive","Transmission sanguine","Transmission mère-enfant"],"correct":1,"explanation":"Le VIH ne se transmet PAS par la salive, la sueur, les piqûres de moustiques ou le contact social. Les modes de transmission sont : sexuelle (rapports non protégés), sanguine (seringues, transfusion) et mère-enfant (grossesse, accouchement, allaitement)."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 5: Relations avec le milieu extérieur
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'relations-milieu-exterieur', 5, 'Relations avec le milieu extérieur', 'Récepteurs sensoriels, communication nerveuse', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'relations-milieu-exterieur-fiche', 'Relations avec le milieu extérieur', 'Récepteurs sensoriels et communication nerveuse', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un récepteur sensoriel ?","answer":"Un récepteur sensoriel est une structure spécialisée capable de capter un stimulus (lumière, son, pression, chaleur, substance chimique) et de le transformer en message nerveux (potentiel d''action). Exemples : les cônes et bâtonnets de la rétine (vision), les cellules ciliées de l''oreille interne (audition), les corpuscules de Pacini (toucher)."},
      {"id":"fc2","category":"Concept","question":"Comment fonctionne la vision ?","answer":"La lumière traverse la cornée, l''humeur aqueuse, le cristallin (qui fait la mise au point) et le corps vitré pour atteindre la rétine. Les photorécepteurs (cônes pour les couleurs et la lumière vive, bâtonnets pour la lumière faible) convertissent la lumière en influx nerveux. Le nerf optique transmet l''information au cortex visuel occipital du cerveau."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''un potentiel d''action ?","answer":"Le potentiel d''action est un signal électrique qui se propage le long de l''axone d''un neurone. Au repos, la membrane du neurone est polarisée (intérieur négatif : -70 mV). Lors d''un stimulus suffisant, la membrane se dépolarise brutalement (+30 mV) par entrée de Na+, puis se repolarise par sortie de K+. Le potentiel d''action obéit à la loi du tout ou rien."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce qu''une synapse ?","answer":"Une synapse est la zone de jonction entre deux neurones ou entre un neurone et un effecteur (muscle, glande). Elle comprend : l''élément présynaptique (bouton synaptique avec vésicules de neurotransmetteurs), la fente synaptique et l''élément postsynaptique. Le message nerveux électrique est converti en message chimique (neurotransmetteurs) pour traverser la fente."},
      {"id":"fc5","category":"Méthode","question":"Comment se transmet le message nerveux au niveau d''une synapse ?","answer":"1) Le potentiel d''action arrive au bouton synaptique. 2) L''entrée de Ca2+ provoque la fusion des vésicules avec la membrane. 3) Les neurotransmetteurs (acétylcholine, dopamine, etc.) sont libérés dans la fente synaptique. 4) Ils se fixent sur les récepteurs postsynaptiques. 5) Un nouveau potentiel d''action est généré (synapse excitatrice) ou inhibé (synapse inhibitrice)."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre système nerveux central et périphérique ?","answer":"Le système nerveux central (SNC) comprend l''encéphale (cerveau, cervelet, tronc cérébral) et la moelle épinière. Il traite les informations et élabore les réponses. Le système nerveux périphérique (SNP) comprend les nerfs crâniens et rachidiens. Il transmet les messages entre le SNC et les organes (nerfs sensitifs et nerfs moteurs)."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce qu''un arc réflexe ?","answer":"Un arc réflexe est le trajet du message nerveux lors d''un réflexe. Il comprend : 1) Un récepteur sensoriel (capte le stimulus). 2) Un neurone sensitif (afférent, transmet vers le SNC). 3) Un centre nerveux (moelle épinière pour les réflexes médullaires). 4) Un neurone moteur (efférent, transmet vers l''effecteur). 5) Un effecteur (muscle ou glande). Le réflexe est rapide, involontaire et stéréotypé."},
      {"id":"fc8","category":"Exemple","question":"Décrivez le réflexe myotatique (réflexe rotulien).","answer":"Le réflexe rotulien est un réflexe myotatique monosynaptique. Stimulus : percussion du tendon rotulien. 1) Le fuseau neuromusculaire (récepteur) détecte l''étirement. 2) Le neurone sensitif transmet le message à la moelle épinière. 3) Une seule synapse relie le neurone sensitif au neurone moteur. 4) Le neurone moteur stimule le quadriceps. 5) La jambe se tend. Ce réflexe est utilisé en diagnostic neurologique."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre mouvement volontaire et réflexe ?","answer":"Le réflexe est involontaire, rapide, stéréotypé et inné. Son centre nerveux est la moelle épinière (réflexes médullaires). Le mouvement volontaire est conscient, plus lent, modulable et acquis. Il est contrôlé par le cortex moteur du cerveau. Le message descend par les voies pyramidales. Le cerveau peut moduler les réflexes par des voies descendantes."},
      {"id":"fc10","category":"Formule","question":"Comment calcule-t-on la vitesse de conduction nerveuse ?","answer":"Vitesse = Distance / Temps. La vitesse de conduction nerveuse dépend du diamètre de l''axone et de la myélinisation. Fibres myélinisées : 10 à 120 m/s (conduction saltatoire). Fibres non myélinisées : 0,5 à 2 m/s. Exemple : si un nerf de 0,5 m transmet un message en 5 ms, la vitesse = 0,5 / 0,005 = 100 m/s."},
      {"id":"fc11","category":"Concept","question":"Qu''est-ce que la myéline et quel est son rôle ?","answer":"La myéline est une gaine lipidique qui entoure les axones de certains neurones. Elle est formée par les cellules de Schwann (SNP) ou les oligodendrocytes (SNC). La myéline isole électriquement l''axone et permet la conduction saltatoire : le potentiel d''action saute d''un noeud de Ranvier à l''autre, ce qui accélère considérablement la transmission nerveuse (jusqu''à 120 m/s)."},
      {"id":"fc12","category":"Définition","question":"Qu''est-ce qu''un neurotransmetteur ?","answer":"Un neurotransmetteur est une molécule chimique libérée par l''élément présynaptique dans la fente synaptique. Il transmet le message nerveux d''un neurone à l''autre. Principaux neurotransmetteurs : acétylcholine (jonction neuromusculaire), dopamine (plaisir, motivation), sérotonine (humeur), GABA (inhibition), noradrénaline (stress). Après fixation, il est dégradé ou recapturé."}
    ],
    "schema": {
      "title": "Relations avec le milieu extérieur",
      "nodes": [
        {"id":"n1","label":"Communication\nnerveuse","type":"main"},
        {"id":"n2","label":"Réception","type":"branch"},
        {"id":"n3","label":"Transmission","type":"branch"},
        {"id":"n4","label":"Réponse","type":"branch"},
        {"id":"n5","label":"Récepteurs\nsensoriels","type":"leaf"},
        {"id":"n6","label":"Potentiel\nd''action","type":"leaf"},
        {"id":"n7","label":"Synapse\nNeurotransmetteurs","type":"leaf"},
        {"id":"n8","label":"Réflexes\n(moelle épinière)","type":"leaf"},
        {"id":"n9","label":"Mouvements\nvolontaires (cerveau)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"stimulus"},
        {"from":"n1","to":"n3","label":"influx"},
        {"from":"n1","to":"n4","label":"effecteur"},
        {"from":"n2","to":"n5","label":"capteurs"},
        {"from":"n3","to":"n6","label":"électrique"},
        {"from":"n3","to":"n7","label":"chimique"},
        {"from":"n4","to":"n8","label":"involontaire"},
        {"from":"n4","to":"n9","label":"volontaire"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le potentiel de repos d''un neurone est d''environ :","options":["+30 mV","-70 mV","0 mV","-90 mV"],"correct":1,"explanation":"Au repos, l''intérieur du neurone est négatif par rapport à l''extérieur, avec un potentiel de membrane d''environ -70 mV. Cette polarisation est maintenue par la pompe Na+/K+-ATPase."},
      {"id":"q2","question":"Quel est l''ordre correct des éléments d''un arc réflexe ?","options":["Effecteur -> Neurone moteur -> Centre nerveux -> Neurone sensitif -> Récepteur","Récepteur -> Neurone sensitif -> Centre nerveux -> Neurone moteur -> Effecteur","Centre nerveux -> Récepteur -> Neurone sensitif -> Effecteur -> Neurone moteur","Récepteur -> Neurone moteur -> Centre nerveux -> Neurone sensitif -> Effecteur"],"correct":1,"explanation":"L''arc réflexe suit cet ordre : le récepteur capte le stimulus, le neurone sensitif (afférent) transmet au centre nerveux (moelle épinière), le neurone moteur (efférent) transmet la réponse à l''effecteur (muscle)."},
      {"id":"q3","question":"Quel ion entre dans le bouton synaptique pour déclencher la libération des neurotransmetteurs ?","options":["Na+","K+","Ca2+","Cl-"],"correct":2,"explanation":"L''arrivée du potentiel d''action au bouton synaptique provoque l''ouverture des canaux calciques. L''entrée de Ca2+ déclenche la fusion des vésicules synaptiques avec la membrane et la libération des neurotransmetteurs."},
      {"id":"q4","question":"La conduction saltatoire est caractéristique des fibres :","options":["Non myélinisées","Myélinisées","Musculaires","Sensorielles uniquement"],"correct":1,"explanation":"La conduction saltatoire se produit dans les fibres myélinisées. Le potentiel d''action saute d''un noeud de Ranvier au suivant, ce qui augmente considérablement la vitesse de conduction (jusqu''à 120 m/s contre 2 m/s pour les fibres non myélinisées)."},
      {"id":"q5","question":"Les cônes de la rétine sont responsables de :","options":["La vision nocturne","La vision des couleurs en lumière vive","La perception des sons","La détection de la douleur"],"correct":1,"explanation":"Les cônes sont les photorécepteurs responsables de la vision des couleurs et de la vision diurne (lumière vive). Les bâtonnets sont responsables de la vision en faible luminosité (vision nocturne) mais ne perçoivent pas les couleurs."},
      {"id":"q6","question":"Un nerf de 0,8 m transmet un message en 8 ms. Quelle est la vitesse de conduction ?","options":["10 m/s","100 m/s","80 m/s","800 m/s"],"correct":1,"explanation":"Vitesse = Distance / Temps = 0,8 m / 0,008 s = 100 m/s. Cette vitesse élevée correspond à une fibre myélinisée de gros diamètre."},
      {"id":"q7","question":"Quel neurotransmetteur agit à la jonction neuromusculaire ?","options":["Dopamine","Sérotonine","Acétylcholine","GABA"],"correct":2,"explanation":"L''acétylcholine est le neurotransmetteur de la jonction neuromusculaire (plaque motrice). Sa fixation sur les récepteurs nicotiniques du muscle provoque la contraction musculaire."},
      {"id":"q8","question":"Le réflexe myotatique est dit monosynaptique car :","options":["Il n''implique qu''un seul neurone","Il ne comporte qu''une seule synapse entre neurone sensitif et neurone moteur","Il n''est déclenché qu''une seule fois","Il n''implique qu''un seul muscle"],"correct":1,"explanation":"Le réflexe myotatique est monosynaptique car il ne comporte qu''une seule synapse, directement entre le neurone sensitif (afférent) et le neurone moteur (efférent) dans la moelle épinière. C''est le réflexe le plus simple."},
      {"id":"q9","question":"Le potentiel d''action obéit à la loi du tout ou rien. Cela signifie :","options":["Il augmente avec l''intensité du stimulus","Il existe ou n''existe pas, sans valeur intermédiaire","Il ne se produit qu''une seule fois","Il ne concerne que les neurones moteurs"],"correct":1,"explanation":"La loi du tout ou rien signifie que le potentiel d''action a toujours la même amplitude (+30 mV), quelle que soit l''intensité du stimulus (à condition qu''il dépasse le seuil). L''intensité du stimulus est codée par la fréquence des potentiels d''action."},
      {"id":"q10","question":"Quel élément N''appartient PAS au système nerveux central ?","options":["Cerveau","Moelle épinière","Nerf sciatique","Cervelet"],"correct":2,"explanation":"Le nerf sciatique fait partie du système nerveux périphérique (SNP). Le SNC comprend l''encéphale (cerveau, cervelet, tronc cérébral) et la moelle épinière. Les nerfs crâniens et rachidiens font partie du SNP."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 6: Régulation hormonale et nerveuse
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'regulation-hormonale-nerveuse', 6, 'Régulation hormonale et nerveuse', 'Hormones, glycémie, reproduction', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'regulation-hormonale-nerveuse-fiche', 'Régulation hormonale et nerveuse', 'Hormones, régulation de la glycémie et reproduction', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une hormone ?","answer":"Une hormone est une substance chimique produite par une glande endocrine, libérée dans le sang et qui agit sur des cellules cibles possédant des récepteurs spécifiques. Les hormones régulent de nombreuses fonctions : croissance, métabolisme, reproduction. Exemples : insuline (pancréas), hormone de croissance (hypophyse), oestrogènes (ovaires), testostérone (testicules)."},
      {"id":"fc2","category":"Concept","question":"Comment est régulée la glycémie ?","answer":"La glycémie normale est d''environ 1 g/L (5,5 mmol/L). Après un repas, la glycémie augmente : le pancréas sécrète de l''insuline (hormone hypoglycémiante) qui stimule l''entrée du glucose dans les cellules et la synthèse de glycogène (glycogénogenèse). En période de jeûne, la glycémie baisse : le pancréas sécrète du glucagon (hormone hyperglycémiante) qui stimule la glycogénolyse."},
      {"id":"fc3","category":"Distinction","question":"Quelle différence entre insuline et glucagon ?","answer":"L''insuline est produite par les cellules bêta des îlots de Langerhans du pancréas. Elle est hypoglycémiante : elle fait baisser la glycémie en favorisant l''entrée du glucose dans les cellules et le stockage sous forme de glycogène. Le glucagon est produit par les cellules alpha. Il est hyperglycémiant : il fait monter la glycémie en stimulant la dégradation du glycogène hépatique en glucose."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que le diabète ?","answer":"Le diabète est une maladie caractérisée par une hyperglycémie chronique (glycémie > 1,26 g/L à jeun). Diabète de type 1 : destruction auto-immune des cellules bêta du pancréas, pas de production d''insuline, traitement par injections d''insuline. Diabète de type 2 : insulinorésistance des cellules cibles, plus fréquent, lié à l''obésité et à la sédentarité, traitement par régime et médicaments."},
      {"id":"fc5","category":"Méthode","question":"Comment fonctionne le rétrocontrôle (feedback) hormonal ?","answer":"Le rétrocontrôle est un mécanisme de régulation où le produit d''une glande contrôle sa propre sécrétion. Rétrocontrôle négatif (le plus fréquent) : l''augmentation du taux d''hormone inhibe sa propre production. Exemple : une forte concentration de thyroxine inhibe la sécrétion de TSH par l''hypophyse. Rétrocontrôle positif (rare) : l''hormone stimule sa propre sécrétion. Exemple : pic d''oestrogènes avant l''ovulation."},
      {"id":"fc6","category":"Concept","question":"Comment fonctionne l''axe hypothalamo-hypophysaire ?","answer":"L''hypothalamus produit des hormones de libération (releasing hormones) qui stimulent l''hypophyse. L''hypophyse antérieure sécrète des stimulines qui agissent sur les glandes cibles. Exemple de l''axe reproducteur : hypothalamus (GnRH) -> hypophyse (FSH et LH) -> gonades (oestrogènes/testostérone). Les hormones des glandes cibles exercent un rétrocontrôle sur l''hypothalamus et l''hypophyse."},
      {"id":"fc7","category":"Concept","question":"Comment est régulé le cycle menstruel ?","answer":"Le cycle menstruel dure environ 28 jours. Phase folliculaire (J1-J14) : FSH stimule la croissance des follicules ovariens qui produisent des oestrogènes. L''endomètre s''épaissit. Ovulation (J14) : pic de LH provoqué par le rétrocontrôle positif des oestrogènes. Phase lutéale (J14-J28) : le corps jaune produit de la progestérone qui maintient l''endomètre. Sans fécondation, le corps jaune dégénère et les règles surviennent."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre glande endocrine et glande exocrine ?","answer":"Une glande endocrine sécrète ses hormones directement dans le sang (pas de canal excréteur). Exemples : thyroïde, surrénales, hypophyse, pancréas endocrine. Une glande exocrine sécrète ses produits dans un canal excréteur qui débouche à la surface du corps ou dans une cavité. Exemples : glandes sudoripares (sueur), glandes salivaires (salive), pancréas exocrine (suc pancréatique)."},
      {"id":"fc9","category":"Formule","question":"Quelle est la valeur normale de la glycémie ?","answer":"Glycémie normale à jeun : 0,7 à 1,1 g/L (3,9 à 6,1 mmol/L). Valeur de référence : 1 g/L (5,5 mmol/L). Hypoglycémie : < 0,7 g/L (malaise, sueurs, tremblements). Hyperglycémie : > 1,1 g/L à jeun. Diabète : glycémie à jeun > 1,26 g/L confirmée à deux reprises. Conversion : glycémie (mmol/L) = glycémie (g/L) x 5,5."},
      {"id":"fc10","category":"Exemple","question":"Quels sont les rôles de la testostérone ?","answer":"La testostérone est l''hormone sexuelle mâle produite par les cellules de Leydig des testicules, sous le contrôle de LH. Rôles : 1) Développement des caractères sexuels primaires (organes génitaux). 2) Développement des caractères sexuels secondaires à la puberté (voix grave, pilosité, musculature). 3) Stimulation de la spermatogenèse (avec FSH). 4) Maintien de la libido."},
      {"id":"fc11","category":"Concept","question":"Qu''est-ce que la spermatogenèse ?","answer":"La spermatogenèse est la formation des spermatozoïdes dans les tubes séminifères des testicules. Elle dure environ 74 jours. Étapes : spermatogonie (2n) -> spermatocyte I (2n) -> méiose I -> spermatocyte II (n) -> méiose II -> spermatide (n) -> spermatozoïde (n). Elle est continue de la puberté à la mort. Elle nécessite FSH (maturation) et testostérone (Leydig, sous contrôle de LH)."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que l''ovogenèse ?","answer":"L''ovogenèse est la formation des ovocytes dans les ovaires. Elle débute durant la vie foetale et s''arrête à la ménopause. Les ovogonies (2n) se multiplient et débutent la méiose I qui se bloque en prophase I. À chaque cycle, un follicule mûr libère un ovocyte II bloqué en métaphase II (ovulation). La méiose II ne se termine qu''en cas de fécondation. Contrairement à la spermatogenèse, l''ovogenèse est cyclique et produit un seul ovule par cycle."}
    ],
    "schema": {
      "title": "Régulation hormonale et nerveuse",
      "nodes": [
        {"id":"n1","label":"Régulation\nhormonale","type":"main"},
        {"id":"n2","label":"Glycémie","type":"branch"},
        {"id":"n3","label":"Reproduction","type":"branch"},
        {"id":"n4","label":"Axe hypothalamo-\nhypophysaire","type":"branch"},
        {"id":"n5","label":"Insuline\nGlucagon","type":"leaf"},
        {"id":"n6","label":"Diabète\ntypes 1 et 2","type":"leaf"},
        {"id":"n7","label":"Cycle menstruel\nOvulation","type":"leaf"},
        {"id":"n8","label":"Spermatogenèse\nTestostérone","type":"leaf"},
        {"id":"n9","label":"Rétrocontrôle\nnégatif / positif","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"métabolisme"},
        {"from":"n1","to":"n3","label":"sexuelles"},
        {"from":"n1","to":"n4","label":"commande"},
        {"from":"n2","to":"n5","label":"pancréas"},
        {"from":"n2","to":"n6","label":"pathologie"},
        {"from":"n3","to":"n7","label":"femme"},
        {"from":"n3","to":"n8","label":"homme"},
        {"from":"n4","to":"n9","label":"régulation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle hormone fait baisser la glycémie ?","options":["Glucagon","Adrénaline","Insuline","Cortisol"],"correct":2,"explanation":"L''insuline est la seule hormone hypoglycémiante. Produite par les cellules bêta des îlots de Langerhans du pancréas, elle favorise l''entrée du glucose dans les cellules et le stockage sous forme de glycogène."},
      {"id":"q2","question":"Le pic de LH déclenche :","options":["Les règles","L''ovulation","La spermatogenèse","La fécondation"],"correct":1,"explanation":"Le pic de LH (hormone lutéinisante) au 14e jour du cycle déclenche l''ovulation : la rupture du follicule mûr et la libération de l''ovocyte. Ce pic est provoqué par le rétrocontrôle positif des oestrogènes."},
      {"id":"q3","question":"Le diabète de type 1 est dû à :","options":["L''insulinorésistance","La destruction des cellules bêta du pancréas","L''excès de glucagon","L''obésité"],"correct":1,"explanation":"Le diabète de type 1 est une maladie auto-immune où le système immunitaire détruit les cellules bêta productrices d''insuline. Le patient ne produit plus d''insuline et doit recevoir des injections quotidiennes."},
      {"id":"q4","question":"Quelle est la glycémie normale à jeun ?","options":["0,5 g/L","1 g/L","1,5 g/L","2 g/L"],"correct":1,"explanation":"La glycémie normale à jeun est d''environ 1 g/L (entre 0,7 et 1,1 g/L). Au-dessus de 1,26 g/L à jeun, on parle de diabète. En dessous de 0,7 g/L, c''est une hypoglycémie."},
      {"id":"q5","question":"Le rétrocontrôle négatif signifie que :","options":["L''hormone stimule sa propre sécrétion","L''hormone inhibe sa propre sécrétion","L''hormone n''a aucun effet","L''hormone détruit sa glande"],"correct":1,"explanation":"Le rétrocontrôle négatif est le mécanisme le plus fréquent : quand le taux d''une hormone augmente, cette augmentation inhibe la sécrétion de l''hormone en amont, ce qui maintient l''homéostasie."},
      {"id":"q6","question":"Les cellules de Leydig produisent :","options":["Les spermatozoïdes","La testostérone","La FSH","Les oestrogènes"],"correct":1,"explanation":"Les cellules de Leydig, situées dans le tissu interstitiel des testicules, produisent la testostérone sous le contrôle de la LH hypophysaire. La testostérone est nécessaire au développement des caractères sexuels et à la spermatogenèse."},
      {"id":"q7","question":"Pendant la phase lutéale du cycle menstruel, la principale hormone sécrétée est :","options":["L''oestrogène","La FSH","La progestérone","La LH"],"correct":2,"explanation":"Après l''ovulation, le follicule rompu se transforme en corps jaune qui sécrète principalement de la progestérone. Cette hormone maintient l''endomètre en vue d''une éventuelle nidation. Si pas de fécondation, le corps jaune dégénère et les règles surviennent."},
      {"id":"q8","question":"Le glycogène est stocké principalement dans :","options":["Le cerveau et les reins","Le foie et les muscles","Le coeur et les poumons","Le sang et la lymphe"],"correct":1,"explanation":"Le glycogène est stocké principalement dans le foie (glycogène hépatique, libérable dans le sang sous forme de glucose) et dans les muscles (glycogène musculaire, utilisé localement pour la contraction). Le foie joue un rôle central dans la régulation de la glycémie."},
      {"id":"q9","question":"L''axe hypothalamo-hypophysaire contrôle les gonades par :","options":["GnRH -> FSH et LH -> hormones sexuelles","TSH -> T3 et T4 -> hormones sexuelles","ACTH -> cortisol -> hormones sexuelles","ADH -> aldostérone -> hormones sexuelles"],"correct":0,"explanation":"L''axe gonadotrope : l''hypothalamus sécrète la GnRH qui stimule l''hypophyse à produire FSH et LH. La FSH stimule la maturation des follicules (femme) ou la spermatogenèse (homme). La LH déclenche l''ovulation et stimule la production de testostérone."},
      {"id":"q10","question":"Combien de temps dure la spermatogenèse ?","options":["28 jours","45 jours","74 jours","120 jours"],"correct":2,"explanation":"La spermatogenèse dure environ 74 jours (environ 2,5 mois). Elle est continue de la puberté jusqu''à la fin de la vie. Elle se déroule dans les tubes séminifères des testicules et nécessite une température inférieure de 2-3°C à la température corporelle."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 7: Évolution de la terre et du monde vivant
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'evolution-terre-monde-vivant', 7, 'Évolution de la terre et du monde vivant', 'Fossiles, sélection naturelle, ères géologiques', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'evolution-terre-monde-vivant-fiche', 'Évolution de la terre et du monde vivant', 'Fossiles, sélection naturelle et histoire de la vie', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''évolution biologique ?","answer":"L''évolution biologique est la transformation des espèces au cours du temps. Elle se manifeste par l''apparition de nouvelles espèces et la disparition d''autres. Les preuves de l''évolution sont : les fossiles (archives géologiques), l''anatomie comparée (organes homologues), l''embryologie comparée et la biologie moléculaire (similarités d''ADN entre espèces proches)."},
      {"id":"fc2","category":"Concept","question":"Qu''est-ce que la sélection naturelle de Darwin ?","answer":"La sélection naturelle est le mécanisme principal de l''évolution, proposé par Charles Darwin en 1859. Principes : 1) Il existe une variabilité naturelle entre individus d''une même espèce. 2) Cette variabilité est en partie héréditaire. 3) Les individus les mieux adaptés à leur environnement survivent et se reproduisent davantage. 4) Les caractères avantageux se transmettent et se répandent dans la population."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''un fossile ?","answer":"Un fossile est un reste ou une trace d''organisme conservé dans les roches sédimentaires. La fossilisation nécessite des conditions particulières : enfouissement rapide, absence d''oxygène. Types de fossiles : corps entiers (ambre, glace), parties dures (os, coquilles), empreintes, moulages. Les fossiles stratigraphiques permettent de dater les couches géologiques (principe de superposition)."},
      {"id":"fc4","category":"Distinction","question":"Quelles sont les grandes ères géologiques ?","answer":"1) Précambrien (4,6 Ga - 541 Ma) : premières cellules, cyanobactéries. 2) Paléozoïque (541 - 252 Ma) : explosion cambrienne, poissons, végétaux terrestres, amphibiens, reptiles. 3) Mésozoïque (252 - 66 Ma) : âge des dinosaures, premiers mammifères et oiseaux. 4) Cénozoïque (66 Ma - aujourd''hui) : diversification des mammifères, apparition de l''homme. Chaque transition est marquée par des extinctions massives."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce qu''une extinction massive ?","answer":"Une extinction massive est la disparition d''un grand nombre d''espèces en un temps géologiquement court. Les 5 grandes extinctions : 1) Ordovicien (-445 Ma). 2) Dévonien (-375 Ma). 3) Permien (-252 Ma, la plus grave : 95% des espèces). 4) Trias (-200 Ma). 5) Crétacé (-66 Ma, disparition des dinosaures). Causes : volcanisme, impacts de météorites, changements climatiques."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que la spéciation ?","answer":"La spéciation est le processus de formation d''une nouvelle espèce. Spéciation allopatrique : une population est divisée par une barrière géographique (montagne, fleuve). Les deux groupes isolés évoluent indépendamment jusqu''à devenir des espèces distinctes (isolement reproductif). Spéciation sympatrique : formation d''une nouvelle espèce au sein d''une même zone géographique, par polyploïdisation ou sélection divergente."},
      {"id":"fc7","category":"Méthode","question":"Comment dater les fossiles ?","answer":"Datation relative : utilise le principe de superposition (les couches les plus profondes sont les plus anciennes) et les fossiles stratigraphiques (espèces à répartition géographique large mais durée de vie courte). Datation absolue : utilise la radioactivité. Le carbone 14 date jusqu''à 50 000 ans (demi-vie : 5 730 ans). Le potassium-argon date les roches de millions d''années. L''uranium-plomb date les roches très anciennes."},
      {"id":"fc8","category":"Exemple","question":"Quelles sont les preuves de l''évolution de l''homme ?","answer":"Les fossiles d''hominidés montrent l''évolution vers l''homme moderne : Australopithecus (bipédie, petit cerveau, 4 Ma), Homo habilis (premiers outils, 2,5 Ma), Homo erectus (maîtrise du feu, migration, 1,8 Ma), Homo sapiens (art, langage complexe, 300 000 ans). Les preuves incluent aussi la comparaison des ADN (98,7% de similarité avec le chimpanzé) et l''anatomie comparée."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre organes homologues et organes analogues ?","answer":"Les organes homologues ont la même origine embryologique et la même structure de base mais des fonctions différentes. Exemple : le bras humain, l''aile de la chauve-souris et la nageoire de la baleine (même squelette de base). Ils témoignent d''un ancêtre commun. Les organes analogues ont des fonctions similaires mais des origines différentes. Exemple : l''aile d''un oiseau et l''aile d''un insecte. C''est une convergence évolutive."},
      {"id":"fc10","category":"Concept","question":"Qu''est-ce que la dérive génétique ?","answer":"La dérive génétique est la variation aléatoire des fréquences alléliques dans une population au cours des générations. Elle est due au hasard de la reproduction (échantillonnage). Son effet est plus fort dans les petites populations. Elle peut conduire à la fixation (fréquence = 100%) ou à la perte (fréquence = 0%) d''un allèle, indépendamment de sa valeur sélective. Avec la sélection naturelle, c''est un moteur de l''évolution."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que l''adaptation ?","answer":"L''adaptation est un processus par lequel une population devient mieux ajustée à son environnement au fil des générations. C''est le résultat de la sélection naturelle agissant sur la variabilité génétique. Exemples : le camouflage du caméléon, la résistance des bactéries aux antibiotiques, le bec des pinsons de Darwin adapté au type de nourriture disponible sur chaque île des Galápagos."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que l''arbre phylogénétique ?","answer":"Un arbre phylogénétique est une représentation graphique des relations de parenté entre espèces. Il est construit à partir de caractères partagés (morphologiques ou moléculaires). Les noeuds représentent les ancêtres communs hypothétiques. Les branches représentent les lignées évolutives. Plus deux espèces partagent de caractères dérivés, plus elles sont proches. La comparaison d''ADN permet de construire des arbres moléculaires."}
    ],
    "schema": {
      "title": "Évolution de la terre et du monde vivant",
      "nodes": [
        {"id":"n1","label":"Évolution","type":"main"},
        {"id":"n2","label":"Preuves","type":"branch"},
        {"id":"n3","label":"Mécanismes","type":"branch"},
        {"id":"n4","label":"Histoire\nde la vie","type":"branch"},
        {"id":"n5","label":"Fossiles\nAnatomie comparée","type":"leaf"},
        {"id":"n6","label":"Sélection\nnaturelle","type":"leaf"},
        {"id":"n7","label":"Dérive\ngénétique","type":"leaf"},
        {"id":"n8","label":"Ères\ngéologiques","type":"leaf"},
        {"id":"n9","label":"Extinctions\nmassives","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"arguments"},
        {"from":"n1","to":"n3","label":"moteurs"},
        {"from":"n1","to":"n4","label":"chronologie"},
        {"from":"n2","to":"n5","label":"données"},
        {"from":"n3","to":"n6","label":"adaptation"},
        {"from":"n3","to":"n7","label":"hasard"},
        {"from":"n4","to":"n8","label":"temps"},
        {"from":"n4","to":"n9","label":"crises"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Qui a proposé la théorie de la sélection naturelle ?","options":["Lamarck","Mendel","Darwin","Pasteur"],"correct":2,"explanation":"Charles Darwin a proposé la théorie de la sélection naturelle dans son ouvrage ''De l''origine des espèces'' publié en 1859. Les individus les mieux adaptés à leur environnement ont plus de chances de survivre et de se reproduire."},
      {"id":"q2","question":"Quelle extinction massive a causé la disparition des dinosaures ?","options":["Extinction du Permien","Extinction de l''Ordovicien","Extinction du Crétacé","Extinction du Dévonien"],"correct":2,"explanation":"L''extinction du Crétacé, il y a 66 Ma, a causé la disparition des dinosaures non aviens. Elle est attribuée à l''impact d''un astéroïde au Mexique (cratère de Chicxulub) combiné à un volcanisme intense (trapps du Deccan)."},
      {"id":"q3","question":"Quelle méthode de datation utilise le carbone 14 ?","options":["Datation relative","Datation absolue","Datation stratigraphique","Datation paléontologique"],"correct":1,"explanation":"Le carbone 14 est utilisé en datation absolue (ou radiométrique). Sa demi-vie est de 5 730 ans, ce qui permet de dater des échantillons organiques jusqu''à environ 50 000 ans. Au-delà, on utilise d''autres isotopes comme le potassium-argon."},
      {"id":"q4","question":"Les organes homologues prouvent :","options":["La convergence évolutive","L''existence d''un ancêtre commun","L''absence d''évolution","La sélection artificielle"],"correct":1,"explanation":"Les organes homologues (même structure de base, fonctions différentes) prouvent l''existence d''un ancêtre commun. Par exemple, le bras humain et l''aile de la chauve-souris ont le même plan d''organisation squelettique."},
      {"id":"q5","question":"La spéciation allopatrique nécessite :","options":["Une mutation spécifique","Un isolement géographique","Une polyploïdisation","Une extinction massive"],"correct":1,"explanation":"La spéciation allopatrique se produit quand une population est divisée par une barrière géographique. Les deux groupes isolés évoluent indépendamment jusqu''à devenir des espèces distinctes incapables de se reproduire entre elles."},
      {"id":"q6","question":"Quelle est la demi-vie du carbone 14 ?","options":["1 000 ans","5 730 ans","1 million d''années","4,5 milliards d''années"],"correct":1,"explanation":"La demi-vie du carbone 14 est de 5 730 ans. Cela signifie qu''après 5 730 ans, la moitié du C14 initial s''est désintégrée. Après 11 460 ans, il n''en reste plus qu''un quart, et ainsi de suite."},
      {"id":"q7","question":"L''ère Mésozoïque est aussi appelée :","options":["L''âge des poissons","L''âge des reptiles","L''âge des mammifères","L''âge des invertébrés"],"correct":1,"explanation":"Le Mésozoïque (252-66 Ma) est l''âge des reptiles, dominé par les dinosaures. Il comprend le Trias, le Jurassique et le Crétacé. Les premiers mammifères et oiseaux apparaissent aussi durant cette ère."},
      {"id":"q8","question":"La dérive génétique a un effet plus fort dans :","options":["Les grandes populations","Les petites populations","Les populations stables","Les populations anciennes"],"correct":1,"explanation":"La dérive génétique est plus forte dans les petites populations car l''effet du hasard y est plus important. Un allèle peut se fixer ou disparaître par hasard en quelques générations, indépendamment de sa valeur sélective."},
      {"id":"q9","question":"Quel pourcentage d''ADN l''homme partage-t-il avec le chimpanzé ?","options":["50%","75%","98,7%","100%"],"correct":2,"explanation":"L''homme et le chimpanzé partagent environ 98,7% de leur ADN, ce qui témoigne de leur parenté étroite. Leur dernier ancêtre commun aurait vécu il y a environ 6 à 7 millions d''années."},
      {"id":"q10","question":"Le premier hominidé bipède connu est :","options":["Homo habilis","Homo erectus","Australopithecus","Homo sapiens"],"correct":2,"explanation":"Australopithecus est le premier hominidé connu ayant acquis la bipédie, il y a environ 4 millions d''années. Il avait un petit cerveau (400-500 cm3) mais marchait debout, comme le montre le squelette de Lucy (A. afarensis, 3,2 Ma)."}
    ]
  }');

  -- ============================================================
  -- SVT - CHAPTER 8: Biotechnologie et amélioration des espèces
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (svt_id, 'biotechnologie-amelioration', 8, 'Biotechnologie et amélioration des espèces', 'Génie génétique, OGM, sélection, clonage', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'biotechnologie-amelioration-fiche', 'Biotechnologie et amélioration des espèces', 'Génie génétique, OGM et applications', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la biotechnologie ?","answer":"La biotechnologie est l''utilisation d''organismes vivants ou de leurs composants pour fabriquer des produits ou améliorer des processus. Exemples traditionnels : fermentation (pain, yaourt, bière). Biotechnologies modernes : génie génétique, thérapie génique, clonage, culture in vitro. Elle s''applique à la santé, l''agriculture, l''industrie et l''environnement."},
      {"id":"fc2","category":"Concept","question":"Qu''est-ce que le génie génétique ?","answer":"Le génie génétique est l''ensemble des techniques permettant de modifier le matériel génétique d''un organisme. Étapes : 1) Identification et isolement du gène d''intérêt. 2) Coupure de l''ADN par des enzymes de restriction. 3) Insertion du gène dans un vecteur (plasmide). 4) Introduction du vecteur dans une cellule hôte. 5) Expression du gène et production de la protéine d''intérêt."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''un OGM ?","answer":"Un OGM (Organisme Génétiquement Modifié) est un organisme dont le matériel génétique a été modifié par génie génétique. Exemples : maïs Bt résistant aux insectes (gène de Bacillus thuringiensis), riz doré enrichi en vitamine A, soja résistant aux herbicides. Les OGM soulèvent des questions éthiques et environnementales : risques pour la biodiversité, brevets sur le vivant, dépendance des agriculteurs."},
      {"id":"fc4","category":"Méthode","question":"Comment fonctionne la PCR (réaction en chaîne par polymérase) ?","answer":"La PCR permet d''amplifier un fragment d''ADN en millions de copies. Étapes (cycle) : 1) Dénaturation (95°C) : séparation des deux brins d''ADN. 2) Hybridation (50-60°C) : fixation des amorces complémentaires. 3) Élongation (72°C) : la Taq polymérase synthétise les nouveaux brins. Chaque cycle double la quantité d''ADN. Après 30 cycles : 2^30 = environ 1 milliard de copies."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre sélection naturelle et sélection artificielle ?","answer":"La sélection naturelle est un processus naturel où l''environnement favorise les individus les mieux adaptés. La sélection artificielle est réalisée par l''homme qui choisit les reproducteurs selon des critères souhaités (rendement, résistance, qualité). Exemples de sélection artificielle : races de chiens, variétés de blé, vaches laitières à haute production. La sélection artificielle est plus rapide mais réduit la diversité génétique."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que le clonage ?","answer":"Le clonage est la production d''organismes génétiquement identiques. Clonage naturel : vrais jumeaux, bouturage, stolons. Clonage artificiel : transfert de noyau (Dolly, 1996). On prélève le noyau d''une cellule somatique et on le transfère dans un ovocyte énucléé. L''embryon est implanté dans une mère porteuse. Le clone est génétiquement identique au donneur de noyau (mais pas identique épigénétiquement)."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la thérapie génique ?","answer":"La thérapie génique consiste à introduire un gène fonctionnel dans les cellules d''un patient pour corriger une maladie génétique. Vecteurs utilisés : virus modifiés (rétrovirus, adénovirus). Exemple : traitement de la mucoviscidose, des déficits immunitaires (enfants-bulles). Difficultés : ciblage des cellules, durée d''expression du gène, risques de mutagenèse insertionnelle."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce que la culture in vitro en agriculture ?","answer":"La culture in vitro permet de multiplier des plantes à partir de fragments végétaux (explants) sur un milieu nutritif stérile. Avantages : multiplication rapide et identique (clonage), production de plantes saines (indemnes de virus), conservation de variétés rares. Au Mali, cette technique est utilisée pour la multiplication des palmiers dattiers, des bananiers et de certaines variétés de riz améliorées."},
      {"id":"fc9","category":"Méthode","question":"Comment réalise-t-on une hybridation en agriculture ?","answer":"L''hybridation consiste à croiser deux variétés ou espèces différentes pour obtenir un hybride combinant les qualités des deux parents. Étapes : 1) Choix des parents complémentaires. 2) Castration de la fleur femelle. 3) Pollinisation contrôlée avec le pollen du parent mâle. 4) Récolte et sélection des graines. L''hybride F1 présente souvent une vigueur hybride (hétérosis) supérieure aux parents."},
      {"id":"fc10","category":"Distinction","question":"Quels sont les enjeux éthiques des biotechnologies ?","answer":"Arguments en faveur : amélioration des rendements agricoles, lutte contre les maladies génétiques, production de médicaments. Arguments contre : risques pour l''environnement et la biodiversité, brevetage du vivant, dépendance des pays du Sud envers les multinationales, questions éthiques du clonage humain. Le principe de précaution demande d''évaluer les risques avant toute mise sur le marché."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce qu''une enzyme de restriction ?","answer":"Une enzyme de restriction est une protéine bactérienne qui coupe l''ADN au niveau de séquences spécifiques (sites de restriction). Exemple : EcoRI coupe la séquence GAATTC. Les coupures peuvent produire des bouts francs ou des bouts cohésifs (extrémités complémentaires). Les enzymes de restriction sont des outils essentiels du génie génétique pour isoler et recombiner des fragments d''ADN."},
      {"id":"fc12","category":"Concept","question":"Qu''est-ce que l''électrophorèse ?","answer":"L''électrophorèse est une technique de séparation des molécules (ADN, protéines) selon leur taille et leur charge dans un gel soumis à un champ électrique. L''ADN, chargé négativement, migre vers l''anode (+). Les petits fragments migrent plus vite. Applications : analyse des résultats de PCR, empreinte génétique (identification judiciaire), diagnostic de maladies génétiques (drépanocytose)."}
    ],
    "schema": {
      "title": "Biotechnologie et amélioration des espèces",
      "nodes": [
        {"id":"n1","label":"Biotechnologies","type":"main"},
        {"id":"n2","label":"Génie\ngénétique","type":"branch"},
        {"id":"n3","label":"Amélioration\ndes espèces","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"Enzymes de restriction\nPCR, Vecteurs","type":"leaf"},
        {"id":"n6","label":"OGM","type":"leaf"},
        {"id":"n7","label":"Sélection\nHybridation","type":"leaf"},
        {"id":"n8","label":"Culture in vitro\nClonage","type":"leaf"},
        {"id":"n9","label":"Thérapie génique\nMédicaments","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"manipulation ADN"},
        {"from":"n1","to":"n3","label":"agriculture"},
        {"from":"n1","to":"n4","label":"santé"},
        {"from":"n2","to":"n5","label":"outils"},
        {"from":"n2","to":"n6","label":"produits"},
        {"from":"n3","to":"n7","label":"classique"},
        {"from":"n3","to":"n8","label":"moderne"},
        {"from":"n4","to":"n9","label":"médecine"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel est le rôle des enzymes de restriction ?","options":["Synthétiser l''ADN","Couper l''ADN à des sites spécifiques","Traduire l''ARNm en protéine","Répliquer l''ADN"],"correct":1,"explanation":"Les enzymes de restriction coupent l''ADN au niveau de séquences de reconnaissance spécifiques. Elles sont essentielles en génie génétique pour isoler des fragments d''ADN et les recombiner."},
      {"id":"q2","question":"Que signifie OGM ?","options":["Organisme Génétiquement Modifié","Organisme Géographiquement Mobile","Organisme Globalement Mutant","Opération Génétique Médicale"],"correct":0,"explanation":"OGM signifie Organisme Génétiquement Modifié. C''est un organisme dont le matériel génétique a été modifié par les techniques de génie génétique pour lui conférer de nouvelles propriétés."},
      {"id":"q3","question":"Combien de copies d''ADN obtient-on après 30 cycles de PCR ?","options":["30","60","2^30 (environ 1 milliard)","3^30"],"correct":2,"explanation":"La PCR double la quantité d''ADN à chaque cycle. Après n cycles, on obtient 2^n copies. Après 30 cycles : 2^30 = 1 073 741 824, soit environ un milliard de copies du fragment ciblé."},
      {"id":"q4","question":"Le premier mammifère cloné par transfert de noyau est :","options":["Un chien","Une souris","La brebis Dolly","Un chat"],"correct":2,"explanation":"La brebis Dolly, née en 1996 à l''Institut Roslin en Écosse, est le premier mammifère cloné par transfert de noyau somatique. Le noyau d''une cellule de glande mammaire a été transféré dans un ovocyte énucléé."},
      {"id":"q5","question":"La thérapie génique consiste à :","options":["Supprimer tous les gènes malades","Introduire un gène fonctionnel pour corriger une maladie","Cloner un patient sain","Modifier l''alimentation du patient"],"correct":1,"explanation":"La thérapie génique vise à introduire un gène fonctionnel dans les cellules d''un patient atteint d''une maladie génétique, afin de produire la protéine manquante ou déficiente."},
      {"id":"q6","question":"Quel est l''avantage principal de la culture in vitro ?","options":["Elle produit des plantes plus grandes","Elle permet une multiplication rapide et identique","Elle élimine le besoin d''eau","Elle produit des OGM"],"correct":1,"explanation":"La culture in vitro permet de multiplier rapidement et de manière identique (clonage) des plantes à partir de petits fragments végétaux, sur un milieu nutritif stérile. C''est utile pour propager des variétés améliorées."},
      {"id":"q7","question":"L''hétérosis (vigueur hybride) se manifeste chez :","options":["Les plantes clonées","Les hybrides F1","Les organismes consanguins","Les OGM uniquement"],"correct":1,"explanation":"L''hétérosis est la supériorité de l''hybride F1 par rapport à ses deux parents pour des caractères comme le rendement, la croissance et la résistance. C''est un phénomène largement exploité en agriculture."},
      {"id":"q8","question":"Quel vecteur est couramment utilisé en génie génétique pour insérer un gène ?","options":["Un chromosome entier","Un plasmide bactérien","Une mitochondrie","Un ribosome"],"correct":1,"explanation":"Les plasmides bactériens sont des petits ADN circulaires utilisés comme vecteurs en génie génétique. On y insère le gène d''intérêt grâce aux enzymes de restriction et à la ligase, puis on l''introduit dans une bactérie hôte."},
      {"id":"q9","question":"L''électrophorèse sépare les fragments d''ADN selon :","options":["Leur couleur","Leur taille","Leur température de fusion","Leur origine"],"correct":1,"explanation":"L''électrophorèse sépare les fragments d''ADN selon leur taille dans un gel soumis à un champ électrique. L''ADN est chargé négativement et migre vers l''anode (+). Les petits fragments migrent plus vite et plus loin que les grands."},
      {"id":"q10","question":"Quelle est la température de dénaturation de l''ADN lors de la PCR ?","options":["37°C","55°C","72°C","95°C"],"correct":3,"explanation":"La dénaturation de l''ADN lors de la PCR se fait à 95°C pour séparer les deux brins de la double hélice. L''hybridation des amorces se fait à 50-60°C et l''élongation par la Taq polymérase à 72°C."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 1: Applications du PFD
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'applications-pfd', 1, 'Applications du principe fondamental de la dynamique', 'Lois de Newton, chute libre, mouvement sur plan incliné', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'applications-pfd-fiche', 'Applications du principe fondamental de la dynamique', 'Lois de Newton et applications', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quel est l''énoncé du principe fondamental de la dynamique (2e loi de Newton) ?","answer":"La somme vectorielle des forces extérieures appliquées à un solide est égale au produit de sa masse par son accélération : somme(F) = m.a. En projection sur un axe : somme(Fx) = m.ax. Unités : F en Newtons (N), m en kg, a en m/s2. Cette loi permet de relier les forces au mouvement."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les 3 lois de Newton ?","answer":"1re loi (Inertie) : un corps soumis à des forces qui se compensent reste au repos ou en MRU. 2e loi (PFD) : somme(F) = m.a, la résultante des forces donne l''accélération. 3e loi (Action-réaction) : si A exerce une force sur B, alors B exerce sur A une force de même intensité, même direction, mais de sens opposé : F(A/B) = -F(B/A)."},
      {"id":"fc3","category":"Méthode","question":"Comment étudier la chute libre d''un corps ?","answer":"Chute libre : seul le poids agit (on néglige les frottements). PFD : P = m.a, donc m.g = m.a, d''où a = g = 9,8 m/s2. Équations horaires : v(t) = g.t + v0 (si lâché sans vitesse initiale : v0 = 0). y(t) = (1/2).g.t2 + v0.t + y0. La vitesse à l''arrivée : v = racine(2.g.h). Le temps de chute : t = racine(2.h/g)."},
      {"id":"fc4","category":"Méthode","question":"Comment étudier le mouvement sur un plan incliné sans frottement ?","answer":"Sur un plan incliné d''angle alpha : les forces sont le poids P (vertical, vers le bas) et la réaction normale N (perpendiculaire au plan). Projection sur l''axe du plan : m.a = m.g.sin(alpha), donc a = g.sin(alpha). Projection perpendiculaire : N = m.g.cos(alpha). Le mouvement est uniformément accéléré avec a = g.sin(alpha). Plus l''angle est grand, plus l''accélération est forte."},
      {"id":"fc5","category":"Formule","question":"Comment traiter le mouvement sur un plan incliné avec frottement ?","answer":"Avec frottement, une force f s''oppose au mouvement, parallèle au plan et dirigée vers le haut. Projection sur l''axe du plan : m.a = m.g.sin(alpha) - f. La force de frottement est souvent f = mu.N = mu.m.g.cos(alpha), où mu est le coefficient de frottement. Donc a = g(sin(alpha) - mu.cos(alpha)). Le mouvement est uniformément accéléré si a > 0."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que le mouvement circulaire uniforme ?","answer":"Dans un MCU, le mobile parcourt un cercle à vitesse constante v. Bien que la norme de la vitesse soit constante, sa direction change, donc il y a une accélération centripète : a = v2/R dirigée vers le centre du cercle. La force centripète nécessaire est F = m.v2/R. Période T = 2.pi.R/v. Fréquence f = 1/T. Vitesse angulaire omega = 2.pi/T = v/R."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre MRU et MRUA ?","answer":"MRU (Mouvement Rectiligne Uniforme) : vitesse constante, accélération nulle, forces qui se compensent. x(t) = v.t + x0. MRUA (Mouvement Rectiligne Uniformément Accéléré) : accélération constante, vitesse varie linéairement. v(t) = a.t + v0 et x(t) = (1/2).a.t2 + v0.t + x0. MRUA si résultante des forces constante et non nulle."},
      {"id":"fc8","category":"Exemple","question":"Comment s''applique le PFD à un système de poulies ?","answer":"Pour un système avec poulie idéale (sans masse ni frottement) et deux masses m1 et m2 (m1 > m2) reliées par un fil inextensible : PFD pour m1 : m1.g - T = m1.a. PFD pour m2 : T - m2.g = m2.a. En additionnant : a = (m1 - m2).g / (m1 + m2). La tension T = 2.m1.m2.g / (m1 + m2). C''est la machine d''Atwood."}
    ],
    "schema": {
      "title": "Principe fondamental de la dynamique",
      "nodes": [
        {"id":"n1","label":"PFD\nsomme(F)=m.a","type":"main"},
        {"id":"n2","label":"Lois de\nNewton","type":"branch"},
        {"id":"n3","label":"Applications","type":"branch"},
        {"id":"n4","label":"1re: Inertie\n2e: PFD\n3e: Action-réaction","type":"leaf"},
        {"id":"n5","label":"Chute libre\na = g","type":"leaf"},
        {"id":"n6","label":"Plan incliné\na = g.sin(alpha)","type":"leaf"},
        {"id":"n7","label":"MCU\na = v2/R","type":"leaf"},
        {"id":"n8","label":"Poulies\nMachine d''Atwood","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"fondement"},
        {"from":"n1","to":"n3","label":"exercices"},
        {"from":"n2","to":"n4","label":"3 lois"},
        {"from":"n3","to":"n5","label":"verticale"},
        {"from":"n3","to":"n6","label":"incliné"},
        {"from":"n3","to":"n7","label":"circulaire"},
        {"from":"n3","to":"n8","label":"systèmes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un corps de masse 2 kg est en chute libre. Quelle est son accélération ? (g = 9,8 m/s2)","options":["2 m/s2","4,9 m/s2","9,8 m/s2","19,6 m/s2"],"correct":2,"explanation":"En chute libre, l''accélération est indépendante de la masse. D''après le PFD : P = m.a -> m.g = m.a -> a = g = 9,8 m/s2."},
      {"id":"q2","question":"Sur un plan incliné à 30° sans frottement, l''accélération d''un corps est :","options":["g","g.cos(30°)","g.sin(30°)","g.tan(30°)"],"correct":2,"explanation":"La projection du PFD sur l''axe du plan donne : m.a = m.g.sin(alpha). Donc a = g.sin(30°) = 9,8 x 0,5 = 4,9 m/s2."},
      {"id":"q3","question":"Quelle est la 3e loi de Newton ?","options":["F = m.a","Le principe d''inertie","Le principe d''action-réaction","La conservation de l''énergie"],"correct":2,"explanation":"La 3e loi de Newton (action-réaction) stipule que si un corps A exerce une force sur un corps B, alors B exerce sur A une force de même intensité, même direction mais de sens opposé."},
      {"id":"q4","question":"Un objet tombe de 20 m de hauteur. Quelle est sa vitesse à l''arrivée ? (g = 10 m/s2)","options":["10 m/s","14,1 m/s","20 m/s","200 m/s"],"correct":2,"explanation":"v = racine(2.g.h) = racine(2 x 10 x 20) = racine(400) = 20 m/s."},
      {"id":"q5","question":"Dans un MCU, l''accélération est dirigée vers :","options":["L''avant du mouvement","L''arrière du mouvement","Le centre du cercle","L''extérieur du cercle"],"correct":2,"explanation":"Dans un MCU, l''accélération centripète est toujours dirigée vers le centre du cercle. Sa valeur est a = v2/R. Elle change la direction de la vitesse sans modifier sa norme."},
      {"id":"q6","question":"Quelle est l''accélération de la machine d''Atwood si m1 = 3 kg et m2 = 1 kg ? (g = 10 m/s2)","options":["2,5 m/s2","5 m/s2","7,5 m/s2","10 m/s2"],"correct":1,"explanation":"a = (m1 - m2).g / (m1 + m2) = (3 - 1) x 10 / (3 + 1) = 20/4 = 5 m/s2."},
      {"id":"q7","question":"Un corps en MRU a une accélération :","options":["Constante et positive","Constante et négative","Variable","Nulle"],"correct":3,"explanation":"En MRU, la vitesse est constante, donc l''accélération est nulle (a = 0). D''après le PFD, cela signifie que la somme des forces est nulle : les forces se compensent."},
      {"id":"q8","question":"Un mobile de 500 g est soumis à une force résultante de 2 N. Quelle est son accélération ?","options":["1 m/s2","2 m/s2","4 m/s2","10 m/s2"],"correct":2,"explanation":"PFD : F = m.a -> a = F/m = 2 / 0,5 = 4 m/s2. Attention : la masse doit être en kg (500 g = 0,5 kg)."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 2: Induction électromagnétique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'induction-electromagnetique', 2, 'Induction électromagnétique et auto-induction', 'Flux magnétique, loi de Faraday, loi de Lenz', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'induction-electromagnetique-fiche', 'Induction électromagnétique et auto-induction', 'Flux magnétique, lois de Faraday et Lenz', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le flux magnétique ?","answer":"Le flux magnétique phi à travers une surface S placée dans un champ magnétique B est : phi = B.S.cos(theta), où theta est l''angle entre le vecteur B et la normale à la surface. Unité : le Weber (Wb). 1 Wb = 1 T.m2. Le flux est maximal quand la surface est perpendiculaire au champ (theta = 0) et nul quand elle est parallèle (theta = 90°)."},
      {"id":"fc2","category":"Formule","question":"Quelle est la loi de Faraday ?","answer":"La loi de Faraday stipule que la f.é.m. induite e dans un circuit est égale à l''opposé de la variation du flux magnétique : e = -dphi/dt. Pour une bobine de N spires : e = -N.dphi/dt. La f.é.m. induite est d''autant plus grande que la variation du flux est rapide. C''est le principe de fonctionnement des générateurs électriques et des transformateurs."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la loi de Lenz ?","answer":"La loi de Lenz stipule que le courant induit circule dans un sens tel qu''il s''oppose à la cause qui lui a donné naissance. Si le flux augmente, le courant induit crée un champ qui s''oppose à cette augmentation. Si le flux diminue, le courant induit crée un champ qui maintient le flux. Le signe moins dans la loi de Faraday traduit cette opposition."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que l''auto-induction ?","answer":"L''auto-induction est le phénomène par lequel un circuit crée une f.é.m. induite en lui-même lorsque le courant qui le traverse varie. La f.é.m. d''auto-induction est : e = -L.di/dt, où L est l''inductance propre (en Henry, H). Une bobine d''inductance L s''oppose aux variations de courant. L''énergie stockée dans une bobine est E = (1/2).L.i2."},
      {"id":"fc5","category":"Méthode","question":"Comment calcule-t-on la f.é.m. induite dans une bobine en rotation ?","answer":"Pour une bobine de N spires, d''aire S, tournant à la vitesse angulaire omega dans un champ B uniforme : phi(t) = N.B.S.cos(omega.t). La f.é.m. induite est e = -dphi/dt = N.B.S.omega.sin(omega.t). C''est une f.é.m. alternative sinusoïdale d''amplitude E0 = N.B.S.omega. C''est le principe de l''alternateur."},
      {"id":"fc6","category":"Exemple","question":"Comment fonctionne un transformateur ?","answer":"Un transformateur comprend deux bobines (primaire N1 spires, secondaire N2 spires) enroulées sur un même noyau ferromagnétique. Le rapport de transformation est k = N2/N1 = U2/U1. Si N2 > N1 : transformateur élévateur (augmente la tension). Si N2 < N1 : transformateur abaisseur. En régime idéal : U1.I1 = U2.I2 (conservation de la puissance)."},
      {"id":"fc7","category":"Formule","question":"Quelle est l''inductance d''un solénoïde ?","answer":"L''inductance d''un solénoïde de N spires, de longueur l, de section S est : L = mu0.N2.S/l, où mu0 = 4.pi.10^(-7) H/m est la perméabilité du vide. L est en Henry (H). Plus N est grand ou S est grande, plus L est élevée. L''inductance caractérise la capacité d''une bobine à stocker de l''énergie magnétique."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre courant continu et courant alternatif ?","answer":"Le courant continu (DC) a une intensité constante dans le temps : i = I0. Il circule dans un seul sens. Exemple : pile, batterie. Le courant alternatif (AC) varie sinusoïdalement : i(t) = Im.sin(omega.t + phi). Il change de sens périodiquement. Période T = 2.pi/omega. Fréquence f = 1/T = 50 Hz (réseau français et malien). Valeur efficace : Ieff = Im/racine(2)."}
    ],
    "schema": {
      "title": "Induction électromagnétique",
      "nodes": [
        {"id":"n1","label":"Induction\nélectromagnétique","type":"main"},
        {"id":"n2","label":"Flux\nmagnétique","type":"branch"},
        {"id":"n3","label":"Lois","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"phi = B.S.cos(theta)","type":"leaf"},
        {"id":"n6","label":"Faraday\ne = -dphi/dt","type":"leaf"},
        {"id":"n7","label":"Lenz\nopposition","type":"leaf"},
        {"id":"n8","label":"Auto-induction\ne = -L.di/dt","type":"leaf"},
        {"id":"n9","label":"Alternateur\nTransformateur","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"grandeur"},
        {"from":"n1","to":"n3","label":"principes"},
        {"from":"n1","to":"n4","label":"technologie"},
        {"from":"n2","to":"n5","label":"formule"},
        {"from":"n3","to":"n6","label":"f.é.m."},
        {"from":"n3","to":"n7","label":"sens"},
        {"from":"n3","to":"n8","label":"bobine"},
        {"from":"n4","to":"n9","label":"machines"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le flux magnétique à travers une surface de 0,5 m2 dans un champ de 0,2 T perpendiculaire est :","options":["0,1 Wb","0,4 Wb","0,7 Wb","1 Wb"],"correct":0,"explanation":"phi = B.S.cos(theta) = 0,2 x 0,5 x cos(0°) = 0,1 Wb. Le champ est perpendiculaire à la surface donc theta = 0° et cos(0°) = 1."},
      {"id":"q2","question":"D''après la loi de Lenz, le courant induit :","options":["Renforce toujours la cause qui l''a créé","S''oppose à la cause qui l''a créé","Est toujours nul","Circule toujours dans le même sens"],"correct":1,"explanation":"La loi de Lenz stipule que le courant induit s''oppose à la variation de flux qui l''a créé. C''est un principe de conservation d''énergie."},
      {"id":"q3","question":"L''unité de l''inductance est :","options":["Le Weber","Le Tesla","Le Henry","Le Farad"],"correct":2,"explanation":"L''inductance L s''exprime en Henry (H). 1 H = 1 Wb/A = 1 V.s/A. Le Weber est l''unité du flux magnétique, le Tesla l''unité du champ magnétique."},
      {"id":"q4","question":"Un transformateur a N1 = 100 et N2 = 500 spires. Si U1 = 220 V, quelle est U2 ?","options":["44 V","220 V","1100 V","110 000 V"],"correct":2,"explanation":"U2/U1 = N2/N1, donc U2 = U1 x N2/N1 = 220 x 500/100 = 1100 V. C''est un transformateur élévateur de tension."},
      {"id":"q5","question":"L''énergie stockée dans une bobine d''inductance 2 H parcourue par un courant de 3 A est :","options":["3 J","6 J","9 J","18 J"],"correct":2,"explanation":"E = (1/2).L.i2 = (1/2) x 2 x 32 = (1/2) x 2 x 9 = 9 J."},
      {"id":"q6","question":"La f.é.m. induite e = -dphi/dt est donnée par :","options":["La loi de Coulomb","La loi de Faraday","La loi d''Ohm","La loi de Joule"],"correct":1,"explanation":"La loi de Faraday relie la f.é.m. induite à la variation du flux magnétique : e = -dphi/dt. Le signe moins traduit la loi de Lenz."},
      {"id":"q7","question":"La valeur efficace d''une tension alternative d''amplitude 311 V est environ :","options":["155 V","220 V","311 V","440 V"],"correct":1,"explanation":"Ueff = Umax/racine(2) = 311/1,414 = 220 V. C''est la tension efficace du réseau électrique (220 V efficaces, 311 V en valeur crête)."},
      {"id":"q8","question":"Le principe de l''alternateur repose sur :","options":["L''effet Joule","L''induction électromagnétique","L''effet photoélectrique","La réfraction"],"correct":1,"explanation":"L''alternateur produit du courant alternatif grâce à l''induction électromagnétique : une bobine tournant dans un champ magnétique subit une variation de flux qui crée une f.é.m. sinusoïdale."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 3: Optique physique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'optique-physique', 3, 'Optique physique — Interférences lumineuses', 'Diffraction, interférences, fentes de Young', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'optique-physique-fiche', 'Optique physique — Interférences lumineuses', 'Diffraction et interférences de la lumière', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la diffraction ?","answer":"La diffraction est le phénomène de déviation de la lumière lorsqu''elle passe par une ouverture ou rencontre un obstacle dont les dimensions sont de l''ordre de grandeur de la longueur d''onde. L''angle de diffraction theta est donné par : sin(theta) = lambda/a, où lambda est la longueur d''onde et a la largeur de la fente. La diffraction prouve la nature ondulatoire de la lumière."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les conditions d''interférence constructive et destructive ?","answer":"Pour les fentes de Young, la différence de marche delta = d.sin(theta) détermine le type d''interférence. Interférence constructive (frange brillante) : delta = k.lambda (k entier). Interférence destructive (frange sombre) : delta = (k + 1/2).lambda. L''interfrange est i = lambda.D/d, où D est la distance fentes-écran et d la distance entre les fentes."},
      {"id":"fc3","category":"Concept","question":"Comment fonctionnent les fentes de Young ?","answer":"Les fentes de Young démontrent les interférences lumineuses. Une source monochromatique éclaire deux fentes fines parallèles séparées de d. Chaque fente devient une source secondaire cohérente. Les ondes issues des deux fentes se superposent sur un écran placé à la distance D, créant des franges alternativement brillantes et sombres. L''interfrange i = lambda.D/d permet de mesurer la longueur d''onde."},
      {"id":"fc4","category":"Méthode","question":"Comment calculer l''interfrange ?","answer":"L''interfrange i est la distance entre deux franges brillantes (ou sombres) consécutives : i = lambda.D/d. Pour déterminer lambda : lambda = i.d/D. Exemple : si i = 1,5 mm, D = 2 m, d = 0,8 mm, alors lambda = (1,5 x 10^(-3) x 0,8 x 10^(-3)) / 2 = 6 x 10^(-7) m = 600 nm (lumière orange)."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre lumière monochromatique et polychromatique ?","answer":"Lumière monochromatique : une seule longueur d''onde (une seule couleur). Exemples : laser, lampe à vapeur de sodium. Lumière polychromatique (blanche) : mélange de toutes les longueurs d''onde du spectre visible (400-800 nm). Un prisme ou un réseau de diffraction peut décomposer la lumière blanche en ses composantes : violet (400 nm) au rouge (800 nm)."},
      {"id":"fc6","category":"Formule","question":"Comment fonctionne un réseau de diffraction ?","answer":"Un réseau de diffraction est constitué de nombreuses fentes parallèles régulièrement espacées d''un pas a. La condition de maximum principal est : a.sin(theta) = k.lambda (k = ordre de diffraction). Le réseau disperse la lumière : chaque longueur d''onde est déviée d''un angle différent. Pouvoir de résolution plus élevé que les fentes de Young grâce au grand nombre de fentes."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la cohérence de deux sources lumineuses ?","answer":"Deux sources sont cohérentes si elles émettent des ondes de même fréquence avec un déphasage constant dans le temps. C''est une condition nécessaire pour observer des interférences stables. Les fentes de Young créent deux sources cohérentes à partir d''une seule source. Deux lampes indépendantes ne sont jamais cohérentes car leurs émissions sont aléatoires."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que la longueur d''onde ?","answer":"La longueur d''onde lambda est la distance parcourue par l''onde pendant une période T. lambda = v.T = v/f, où v est la vitesse de l''onde et f sa fréquence. Pour la lumière dans le vide : lambda = c/f avec c = 3 x 10^8 m/s. Le spectre visible s''étend de 400 nm (violet) à 800 nm (rouge). 1 nm = 10^(-9) m."}
    ],
    "schema": {
      "title": "Optique physique",
      "nodes": [
        {"id":"n1","label":"Optique\nphysique","type":"main"},
        {"id":"n2","label":"Diffraction","type":"branch"},
        {"id":"n3","label":"Interférences","type":"branch"},
        {"id":"n4","label":"sin(theta)=lambda/a","type":"leaf"},
        {"id":"n5","label":"Fentes de Young\ni = lambda.D/d","type":"leaf"},
        {"id":"n6","label":"Réseau\na.sin(theta)=k.lambda","type":"leaf"},
        {"id":"n7","label":"Constructive\ndestructive","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"une fente"},
        {"from":"n1","to":"n3","label":"deux sources"},
        {"from":"n2","to":"n4","label":"formule"},
        {"from":"n3","to":"n5","label":"dispositif"},
        {"from":"n3","to":"n6","label":"multiple"},
        {"from":"n3","to":"n7","label":"conditions"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''interfrange dans l''expérience de Young est donné par :","options":["i = d.D/lambda","i = lambda.D/d","i = lambda.d/D","i = D/(lambda.d)"],"correct":1,"explanation":"L''interfrange i = lambda.D/d, où lambda est la longueur d''onde, D la distance fentes-écran et d la distance entre les deux fentes."},
      {"id":"q2","question":"La diffraction prouve que la lumière a une nature :","options":["Corpusculaire","Ondulatoire","Thermique","Magnétique"],"correct":1,"explanation":"La diffraction est un phénomène typiquement ondulatoire. Le fait que la lumière puisse être diffractée prouve sa nature ondulatoire, contrairement au modèle corpusculaire de Newton."},
      {"id":"q3","question":"Pour des fentes de Young avec d = 0,5 mm, D = 1 m et lambda = 500 nm, l''interfrange vaut :","options":["0,5 mm","1 mm","2 mm","5 mm"],"correct":1,"explanation":"i = lambda.D/d = (500 x 10^(-9) x 1) / (0,5 x 10^(-3)) = 10^(-3) m = 1 mm."},
      {"id":"q4","question":"Une interférence constructive se produit quand la différence de marche est :","options":["delta = (k+1/2).lambda","delta = k.lambda","delta = lambda/4","delta = 0,75.lambda"],"correct":1,"explanation":"L''interférence est constructive quand delta = k.lambda (k entier), car les deux ondes arrivent en phase et leurs amplitudes s''additionnent."},
      {"id":"q5","question":"Le spectre visible s''étend de :","options":["100 nm à 400 nm","400 nm à 800 nm","800 nm à 1200 nm","200 nm à 600 nm"],"correct":1,"explanation":"Le spectre visible va du violet (environ 400 nm) au rouge (environ 800 nm). En dessous de 400 nm se trouvent les ultraviolets, au-dessus de 800 nm les infrarouges."},
      {"id":"q6","question":"Deux sources sont cohérentes si :","options":["Elles ont la même intensité","Elles ont la même fréquence et un déphasage constant","Elles sont proches l''une de l''autre","Elles émettent de la lumière blanche"],"correct":1,"explanation":"La cohérence exige que les deux sources aient la même fréquence et un déphasage constant dans le temps. C''est la condition pour observer des interférences stables."},
      {"id":"q7","question":"La longueur d''onde d''une lumière de fréquence 6 x 10^14 Hz est :","options":["200 nm","500 nm","600 nm","800 nm"],"correct":1,"explanation":"lambda = c/f = (3 x 10^8) / (6 x 10^14) = 5 x 10^(-7) m = 500 nm. C''est une lumière verte."},
      {"id":"q8","question":"Un réseau de diffraction donne un maximum principal quand :","options":["a.sin(theta) = k.lambda","a.cos(theta) = k.lambda","a.tan(theta) = k.lambda","a/sin(theta) = k.lambda"],"correct":0,"explanation":"La condition de maximum principal pour un réseau de pas a est : a.sin(theta) = k.lambda, où k est l''ordre de diffraction (entier)."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 4: Oscillations libres
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'oscillations-libres', 4, 'Oscillations libres', 'Pendule simple, oscillateur masse-ressort, circuits RLC', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oscillations-libres-fiche', 'Oscillations libres', 'Pendule, ressort et circuit LC', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quelle est la période du pendule simple ?","answer":"La période du pendule simple est T = 2.pi.racine(l/g), où l est la longueur du fil et g l''accélération de la pesanteur. La période ne dépend PAS de la masse ni de l''amplitude (pour de petites oscillations, theta < 15°). C''est l''isochronisme des petites oscillations découvert par Galilée. L''équation du mouvement est : theta(t) = theta_max.cos(omega.t + phi)."},
      {"id":"fc2","category":"Formule","question":"Quelle est la période de l''oscillateur masse-ressort ?","answer":"La période est T = 2.pi.racine(m/k), où m est la masse et k la constante de raideur du ressort. Équation différentielle : m.x'''' + k.x = 0, soit x'''' + omega0^2.x = 0 avec omega0 = racine(k/m). La solution est x(t) = Xm.cos(omega0.t + phi). L''énergie mécanique Em = (1/2).k.x2 + (1/2).m.v2 est constante (conservation)."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce qu''un circuit LC et comment oscille-t-il ?","answer":"Un circuit LC est constitué d''une bobine (inductance L) et d''un condensateur (capacité C) en série. L''énergie oscille entre le condensateur (énergie électrique Ec = q2/(2C)) et la bobine (énergie magnétique EL = (1/2).L.i2). La période propre est T0 = 2.pi.racine(L.C). L''équation : q'''' + omega0^2.q = 0 avec omega0 = 1/racine(L.C)."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre oscillations libres amorties et non amorties ?","answer":"Oscillations non amorties : pas de frottement, l''amplitude reste constante, l''énergie mécanique se conserve. Oscillations amorties : présence de frottement (ou résistance R dans un circuit RLC), l''amplitude diminue exponentiellement. Régime pseudo-périodique : les oscillations s''atténuent progressivement. Régime apériodique : pas d''oscillation, retour lent à l''équilibre. Régime critique : retour le plus rapide sans oscillation."},
      {"id":"fc5","category":"Méthode","question":"Comment déterminer la constante de raideur d''un ressort ?","answer":"Méthode statique : accrocher une masse m au ressort, mesurer l''allongement x à l''équilibre. À l''équilibre : k.x = m.g, donc k = m.g/x. Méthode dynamique : mesurer la période T des oscillations. T = 2.pi.racine(m/k), donc k = 4.pi2.m/T2. La méthode dynamique est souvent plus précise car on peut mesurer plusieurs périodes."},
      {"id":"fc6","category":"Formule","question":"Comment s''exprime l''énergie mécanique d''un oscillateur harmonique ?","answer":"Pour un oscillateur masse-ressort : Em = Ec + Ep = (1/2).m.v2 + (1/2).k.x2 = (1/2).k.Xm2 = constante. L''énergie cinétique Ec est maximale quand x = 0 (position d''équilibre). L''énergie potentielle Ep est maximale quand x = Xm (amplitude maximale). Il y a échange permanent entre Ec et Ep, mais Em reste constante (sans frottement)."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que le facteur de qualité Q ?","answer":"Le facteur de qualité Q caractérise l''amortissement d''un oscillateur. Q = omega0/delta_omega où delta_omega est la largeur de bande. Pour un circuit RLC : Q = L.omega0/R = 1/(R.C.omega0) = (1/R).racine(L/C). Grand Q : faible amortissement, oscillations persistantes. Petit Q : fort amortissement, oscillations rapides disparition. Q > 1/2 : régime pseudo-périodique."},
      {"id":"fc8","category":"Exemple","question":"Comment fonctionne un circuit RLC série en régime libre ?","answer":"Un circuit RLC série avec condensateur chargé initialement : l''énergie oscille entre C et L, mais R dissipe de l''énergie par effet Joule. Équation : L.q'''' + R.q'' + q/C = 0. Si R < 2.racine(L/C) : régime pseudo-périodique (oscillations amorties). Si R = 2.racine(L/C) : régime critique. Si R > 2.racine(L/C) : régime apériodique."}
    ],
    "schema": {
      "title": "Oscillations libres",
      "nodes": [
        {"id":"n1","label":"Oscillations\nlibres","type":"main"},
        {"id":"n2","label":"Mécaniques","type":"branch"},
        {"id":"n3","label":"Électriques","type":"branch"},
        {"id":"n4","label":"Pendule\nT=2pi.racine(l/g)","type":"leaf"},
        {"id":"n5","label":"Masse-ressort\nT=2pi.racine(m/k)","type":"leaf"},
        {"id":"n6","label":"Circuit LC\nT=2pi.racine(LC)","type":"leaf"},
        {"id":"n7","label":"RLC amorti\nQ = facteur qualité","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"solides"},
        {"from":"n1","to":"n3","label":"circuits"},
        {"from":"n2","to":"n4","label":"fil + masse"},
        {"from":"n2","to":"n5","label":"ressort"},
        {"from":"n3","to":"n6","label":"sans résistance"},
        {"from":"n3","to":"n7","label":"avec résistance"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La période d''un pendule simple de longueur 1 m est environ (g = 10 m/s2) :","options":["1 s","2 s","3,14 s","6,28 s"],"correct":1,"explanation":"T = 2.pi.racine(l/g) = 2.pi.racine(1/10) = 2.pi x 0,316 = 1,99 s, soit environ 2 s."},
      {"id":"q2","question":"La période du pendule simple dépend de :","options":["La masse et la longueur","La masse et l''amplitude","La longueur et g","L''amplitude et g"],"correct":2,"explanation":"T = 2.pi.racine(l/g). La période ne dépend que de la longueur l du fil et de g. Elle est indépendante de la masse et de l''amplitude (pour de petites oscillations)."},
      {"id":"q3","question":"Pour un oscillateur masse-ressort, si on double la masse, la période :","options":["Double","Est multipliée par racine(2)","Reste la même","Est divisée par 2"],"correct":1,"explanation":"T = 2.pi.racine(m/k). Si m'' = 2m, T'' = 2.pi.racine(2m/k) = T.racine(2). La période est multipliée par racine(2), soit environ 1,414."},
      {"id":"q4","question":"L''énergie mécanique d''un oscillateur harmonique non amorti :","options":["Augmente avec le temps","Diminue avec le temps","Reste constante","Oscille entre deux valeurs"],"correct":2,"explanation":"Sans frottement, l''énergie mécanique Em = Ec + Ep est constante. Il y a échange permanent entre énergie cinétique et énergie potentielle, mais leur somme reste constante."},
      {"id":"q5","question":"La pulsation propre d''un circuit LC avec L = 1 mH et C = 1 microF est :","options":["1000 rad/s","10 000 rad/s","31 623 rad/s","100 000 rad/s"],"correct":2,"explanation":"omega0 = 1/racine(LC) = 1/racine(10^(-3) x 10^(-6)) = 1/racine(10^(-9)) = 1/(3,16 x 10^(-5)) = 31 623 rad/s."},
      {"id":"q6","question":"En régime pseudo-périodique, l''amplitude :","options":["Reste constante","Augmente avec le temps","Diminue exponentiellement","Augmente puis diminue"],"correct":2,"explanation":"En régime pseudo-périodique, la résistance R dissipe de l''énergie par effet Joule. L''amplitude des oscillations diminue exponentiellement au cours du temps jusqu''à s''annuler."},
      {"id":"q7","question":"La constante de raideur k d''un ressort a pour unité :","options":["N","N/m","N.m","kg/s"],"correct":1,"explanation":"La constante de raideur k s''exprime en N/m (Newton par mètre). D''après la loi de Hooke : F = k.x, donc k = F/x, soit des Newtons divisés par des mètres."},
      {"id":"q8","question":"Le régime critique d''un circuit RLC se produit quand :","options":["R = 0","R = 2.racine(L/C)","R < 2.racine(L/C)","R = L/C"],"correct":1,"explanation":"Le régime critique correspond à R = 2.racine(L/C). C''est le cas limite entre le régime pseudo-périodique (R plus petit) et le régime apériodique (R plus grand). Le retour à l''équilibre est le plus rapide possible sans oscillation."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 5: Oscillations forcées
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'oscillations-forcees', 5, 'Oscillations forcées', 'Résonance, circuit RLC forcé, bande passante', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oscillations-forcees-fiche', 'Oscillations forcées', 'Résonance et circuits RLC en régime forcé', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une oscillation forcée ?","answer":"Une oscillation forcée se produit quand un oscillateur est soumis à une excitation extérieure périodique de pulsation omega. Après un régime transitoire, l''oscillateur oscille à la fréquence de l''excitateur (régime permanent). L''amplitude dépend du rapport omega/omega0 et de l''amortissement. Le phénomène de résonance se produit quand omega est proche de omega0."},
      {"id":"fc2","category":"Concept","question":"Qu''est-ce que la résonance ?","answer":"La résonance est le phénomène où l''amplitude des oscillations forcées est maximale. Elle se produit quand la fréquence d''excitation est proche de la fréquence propre de l''oscillateur. Pour un oscillateur mécanique faiblement amorti, la résonance se produit à omega_r proche de omega0. Pour un circuit RLC série en tension, la résonance d''intensité se produit à omega0 = 1/racine(LC) exactement."},
      {"id":"fc3","category":"Formule","question":"Comment se comporte un circuit RLC série en régime sinusoïdal forcé ?","answer":"En régime sinusoïdal forcé, l''impédance du circuit est Z = racine(R2 + (L.omega - 1/(C.omega))2). Le courant est I = U/Z. À la résonance (omega = omega0 = 1/racine(LC)), l''impédance est minimale (Z = R) et le courant est maximal (I = U/R). Le déphasage entre courant et tension est phi = arctan((L.omega - 1/(C.omega))/R)."},
      {"id":"fc4","category":"Formule","question":"Comment définit-on la bande passante ?","answer":"La bande passante est l''intervalle de fréquences pour lequel l''amplitude du courant est supérieure à Imax/racine(2). La largeur de bande est delta_omega = R/L ou delta_f = R/(2.pi.L). Le facteur de qualité Q = omega0/delta_omega = L.omega0/R. Plus Q est grand, plus la résonance est aiguë (sélective) et plus la bande passante est étroite."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre résonance en intensité et résonance en tension ?","answer":"Résonance en intensité (circuit RLC série) : l''intensité est maximale quand omega = omega0 = 1/racine(LC). L''impédance est minimale (Z = R). Résonance en tension aux bornes du condensateur : la tension Uc est maximale pour omega_r = omega0.racine(1 - 1/(2Q2)). Si Q est grand, omega_r est proche de omega0. La résonance en tension n''existe que si Q > 1/racine(2)."},
      {"id":"fc6","category":"Méthode","question":"Comment déterminer les éléments d''un circuit RLC à partir de la courbe de résonance ?","answer":"1) Fréquence de résonance f0 : abscisse du maximum. omega0 = 2.pi.f0. 2) Imax = U/R, donc R = U/Imax. 3) Bande passante delta_f : largeur à Imax/racine(2). 4) Q = f0/delta_f. 5) L = R/(2.pi.delta_f) = Q.R/omega0. 6) C = 1/(L.omega0^2). On peut aussi utiliser les fréquences de coupure f1 et f2 : delta_f = f2 - f1."},
      {"id":"fc7","category":"Exemple","question":"Donnez un exemple de résonance dans la vie quotidienne.","answer":"Exemples de résonance : 1) La radio : le circuit LC du récepteur est accordé sur la fréquence de la station (résonance électrique). 2) La balançoire : on pousse à la fréquence propre pour obtenir l''amplitude maximale. 3) Le pont de Tacoma (1940) : le vent a excité le pont à sa fréquence propre, causant sa destruction. 4) L''IRM médicale utilise la résonance magnétique nucléaire."},
      {"id":"fc8","category":"Concept","question":"Qu''est-ce que le déphasage en régime sinusoïdal ?","answer":"Le déphasage phi est le décalage temporel entre le courant et la tension, exprimé en radians. Si phi > 0 : le courant est en avance sur la tension (circuit capacitif). Si phi < 0 : le courant est en retard (circuit inductif). Si phi = 0 : courant et tension sont en phase (résonance ou circuit purement résistif). On lit le déphasage sur l''oscilloscope : phi = 2.pi.delta_t/T."}
    ],
    "schema": {
      "title": "Oscillations forcées et résonance",
      "nodes": [
        {"id":"n1","label":"Oscillations\nforcées","type":"main"},
        {"id":"n2","label":"Résonance","type":"branch"},
        {"id":"n3","label":"Circuit RLC\nforcé","type":"branch"},
        {"id":"n4","label":"Amplitude max\nomega = omega0","type":"leaf"},
        {"id":"n5","label":"Bande passante\nFacteur Q","type":"leaf"},
        {"id":"n6","label":"Impédance\nZ = racine(R2+...)","type":"leaf"},
        {"id":"n7","label":"Déphasage\nphi","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"phénomène"},
        {"from":"n1","to":"n3","label":"application"},
        {"from":"n2","to":"n4","label":"condition"},
        {"from":"n2","to":"n5","label":"sélectivité"},
        {"from":"n3","to":"n6","label":"amplitude"},
        {"from":"n3","to":"n7","label":"phase"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"À la résonance d''intensité d''un circuit RLC série, l''impédance vaut :","options":["Z = L.omega","Z = 1/(C.omega)","Z = R","Z = 0"],"correct":2,"explanation":"À la résonance, L.omega = 1/(C.omega), donc l''impédance Z = racine(R2 + 0) = R. L''impédance est minimale et le courant maximal I = U/R."},
      {"id":"q2","question":"La résonance se produit quand la fréquence d''excitation est :","options":["Nulle","Très grande","Égale à la fréquence propre","Égale à la moitié de la fréquence propre"],"correct":2,"explanation":"La résonance d''intensité se produit quand la pulsation d''excitation omega est égale à la pulsation propre omega0 = 1/racine(LC)."},
      {"id":"q3","question":"Le facteur de qualité Q est d''autant plus grand que :","options":["R est grand","L''amortissement est grand","La résonance est aiguë","La bande passante est large"],"correct":2,"explanation":"Un grand facteur de qualité Q signifie une résonance aiguë et sélective, un faible amortissement et une bande passante étroite. Q = f0/delta_f = L.omega0/R."},
      {"id":"q4","question":"En régime sinusoïdal, si le courant est en retard sur la tension, le circuit est :","options":["Résistif","Capacitif","Inductif","En résonance"],"correct":2,"explanation":"Quand le courant est en retard sur la tension (phi < 0), le circuit est à caractère inductif. La bobine s''oppose aux variations de courant et crée ce retard."},
      {"id":"q5","question":"La bande passante d''un circuit RLC série est :","options":["delta_omega = L/R","delta_omega = R/L","delta_omega = R.C","delta_omega = 1/(R.C)"],"correct":1,"explanation":"La bande passante en pulsation est delta_omega = R/L. Plus R est grand ou L est petit, plus la bande est large (résonance moins sélective)."},
      {"id":"q6","question":"À la résonance d''un circuit RLC série, le déphasage entre i et u est :","options":["pi/2","pi","-pi/2","0"],"correct":3,"explanation":"À la résonance, le courant et la tension sont en phase (phi = 0). Les effets de la bobine et du condensateur se compensent exactement."},
      {"id":"q7","question":"Si Q = 50 et f0 = 1000 Hz, la bande passante est :","options":["20 Hz","50 Hz","200 Hz","500 Hz"],"correct":0,"explanation":"delta_f = f0/Q = 1000/50 = 20 Hz. La bande passante s''étend de f0 - delta_f/2 à f0 + delta_f/2, soit de 990 Hz à 1010 Hz."},
      {"id":"q8","question":"En oscillations forcées, en régime permanent, l''oscillateur oscille à :","options":["Sa fréquence propre","La fréquence de l''excitateur","La moyenne des deux fréquences","Une fréquence aléatoire"],"correct":1,"explanation":"En régime permanent (après le transitoire), l''oscillateur adopte la fréquence de l''excitateur, quelle que soit sa fréquence propre. L''amplitude dépend cependant du rapport omega/omega0."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 6: Effet photoélectrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'effet-photoelectrique', 6, 'Effet photoélectrique', 'Photon, seuil, énergie cinétique des électrons', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'effet-photoelectrique-fiche', 'Effet photoélectrique', 'Dualité onde-corpuscule et photons', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''effet photoélectrique ?","answer":"L''effet photoélectrique est l''émission d''électrons par une surface métallique éclairée par un rayonnement de fréquence suffisante. Il a été expliqué par Einstein en 1905 : la lumière est constituée de photons d''énergie E = h.f. Un photon arrache un électron si son énergie est supérieure au travail d''extraction W0 : h.f >= W0. L''énergie cinétique de l''électron est Ec = h.f - W0."},
      {"id":"fc2","category":"Formule","question":"Quelle est la relation d''Einstein pour l''effet photoélectrique ?","answer":"h.f = W0 + (1/2).m.v2, où h = 6,63 x 10^(-34) J.s (constante de Planck), f la fréquence de la lumière, W0 le travail d''extraction (ou seuil) du métal, m la masse de l''électron (9,1 x 10^(-31) kg), v la vitesse de l''électron émis. Le seuil : f0 = W0/h ou lambda0 = h.c/W0. Si f < f0, pas d''émission, quelle que soit l''intensité."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce qu''un photon ?","answer":"Un photon est un quantum d''énergie lumineuse. C''est une particule sans masse qui se déplace à la vitesse de la lumière c = 3 x 10^8 m/s. Son énergie est E = h.f = h.c/lambda. En électronvolts : E(eV) = E(J) / (1,6 x 10^(-19)). Les photons visibles ont des énergies de 1,6 à 3,1 eV. Plus la fréquence est élevée, plus le photon est énergétique."},
      {"id":"fc4","category":"Distinction","question":"Pourquoi l''effet photoélectrique contredit-il la théorie ondulatoire classique ?","answer":"La théorie ondulatoire prédit : 1) L''émission devrait se produire pour toute fréquence si l''intensité est suffisante. 2) Il devrait y avoir un délai. Observations : 1) Il existe un seuil de fréquence f0, en dessous duquel aucune émission n''a lieu, même avec une forte intensité. 2) L''émission est instantanée. 3) L''énergie des électrons dépend de la fréquence, pas de l''intensité. Seul le modèle corpusculaire (photons) explique ces observations."},
      {"id":"fc5","category":"Formule","question":"Comment convertir les énergies entre joules et électronvolts ?","answer":"1 eV = 1,6 x 10^(-19) J. Pour convertir : E(eV) = E(J) / (1,6 x 10^(-19)). E(J) = E(eV) x 1,6 x 10^(-19). Exemple : W0 = 4,5 eV = 4,5 x 1,6 x 10^(-19) = 7,2 x 10^(-19) J. L''eV est l''unité courante en physique atomique car les énergies en joules sont très petites."},
      {"id":"fc6","category":"Méthode","question":"Comment déterminer le travail d''extraction d''un métal ?","answer":"Méthode expérimentale : on éclaire le métal avec des lumières de différentes fréquences et on mesure l''énergie cinétique maximale des électrons. On trace Ec_max en fonction de f : c''est une droite de pente h. L''ordonnée à l''origine donne -W0. L''abscisse à l''origine donne la fréquence seuil f0 = W0/h. Exemples de W0 : césium 2,1 eV, sodium 2,3 eV, zinc 4,3 eV."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la dualité onde-corpuscule ?","answer":"La dualité onde-corpuscule est le fait que la lumière et la matière présentent à la fois des propriétés ondulatoires et corpusculaires. La lumière : ondulatoire (diffraction, interférences) et corpusculaire (effet photoélectrique, Compton). La matière : corpusculaire (trajectoires) et ondulatoire (diffraction d''électrons). La longueur d''onde de De Broglie : lambda = h/(m.v)."},
      {"id":"fc8","category":"Exemple","question":"Quelles sont les applications de l''effet photoélectrique ?","answer":"1) Cellules photovoltaïques (panneaux solaires) : conversion lumière -> électricité. 2) Capteurs CCD des appareils photo numériques. 3) Photomultiplicateurs (détection de lumière faible). 4) Portes automatiques (cellule photoélectrique). 5) Spectroscopie photoélectronique (analyse de surface). Einstein a reçu le prix Nobel 1921 pour son explication de l''effet photoélectrique."}
    ],
    "schema": {
      "title": "Effet photoélectrique",
      "nodes": [
        {"id":"n1","label":"Effet\nphotoélectrique","type":"main"},
        {"id":"n2","label":"Photon\nE = h.f","type":"branch"},
        {"id":"n3","label":"Loi d''Einstein","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"Seuil f0\nlambda0","type":"leaf"},
        {"id":"n6","label":"Ec = h.f - W0","type":"leaf"},
        {"id":"n7","label":"Cellules solaires\nCapteurs","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"quantum"},
        {"from":"n1","to":"n3","label":"bilan énergie"},
        {"from":"n1","to":"n4","label":"technologie"},
        {"from":"n2","to":"n5","label":"condition"},
        {"from":"n3","to":"n6","label":"formule"},
        {"from":"n4","to":"n7","label":"exemples"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''énergie d''un photon de fréquence 5 x 10^14 Hz est (h = 6,63 x 10^(-34) J.s) :","options":["3,3 x 10^(-19) J","6,6 x 10^(-19) J","3,3 x 10^(-20) J","6,6 x 10^(-20) J"],"correct":0,"explanation":"E = h.f = 6,63 x 10^(-34) x 5 x 10^14 = 3,315 x 10^(-19) J, soit environ 3,3 x 10^(-19) J ou 2,07 eV."},
      {"id":"q2","question":"L''effet photoélectrique ne se produit pas si :","options":["L''intensité lumineuse est trop faible","La fréquence de la lumière est inférieure au seuil","Le métal est trop épais","La lumière est polarisée"],"correct":1,"explanation":"L''effet photoélectrique nécessite que la fréquence f soit supérieure à la fréquence seuil f0 = W0/h. Si f < f0, aucun électron n''est émis, quelle que soit l''intensité de la lumière."},
      {"id":"q3","question":"Le travail d''extraction d''un métal est W0 = 3,2 eV. La longueur d''onde seuil est :","options":["198 nm","388 nm","625 nm","960 nm"],"correct":1,"explanation":"lambda0 = h.c/W0 = (6,63 x 10^(-34) x 3 x 10^8) / (3,2 x 1,6 x 10^(-19)) = 1,989 x 10^(-25) / (5,12 x 10^(-19)) = 3,88 x 10^(-7) m = 388 nm."},
      {"id":"q4","question":"Un photon de 4 eV frappe un métal de W0 = 2,5 eV. L''énergie cinétique de l''électron émis est :","options":["0,5 eV","1,5 eV","2,5 eV","4 eV"],"correct":1,"explanation":"Ec = h.f - W0 = 4 - 2,5 = 1,5 eV. L''excès d''énergie du photon par rapport au travail d''extraction est converti en énergie cinétique de l''électron."},
      {"id":"q5","question":"La constante de Planck h vaut :","options":["6,63 x 10^(-34) J.s","1,6 x 10^(-19) C","3 x 10^8 m/s","9,1 x 10^(-31) kg"],"correct":0,"explanation":"h = 6,63 x 10^(-34) J.s est la constante de Planck. C''est une constante fondamentale de la physique quantique qui relie l''énergie d''un photon à sa fréquence."},
      {"id":"q6","question":"En augmentant l''intensité lumineuse (à fréquence constante au-dessus du seuil) :","options":["L''énergie des électrons augmente","Le nombre d''électrons émis augmente","La vitesse des électrons augmente","Rien ne change"],"correct":1,"explanation":"L''intensité lumineuse correspond au nombre de photons par seconde. Plus d''intensité signifie plus de photons, donc plus d''électrons émis. Mais l''énergie de chaque électron ne change pas (elle dépend de la fréquence)."},
      {"id":"q7","question":"Qui a expliqué l''effet photoélectrique ?","options":["Newton","Maxwell","Einstein","Planck"],"correct":2,"explanation":"Albert Einstein a expliqué l''effet photoélectrique en 1905 en utilisant le concept de quantum de lumière (photon) de Planck. Il a reçu le prix Nobel de physique en 1921 pour cette découverte."},
      {"id":"q8","question":"1 eV est égal à :","options":["1,6 x 10^(-19) J","9,1 x 10^(-31) J","6,63 x 10^(-34) J","3 x 10^8 J"],"correct":0,"explanation":"1 électronvolt (eV) = 1,6 x 10^(-19) joules. C''est l''énergie acquise par un électron accéléré sous une différence de potentiel de 1 volt."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 7: Physique atomique et nucléaire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'physique-atomique-nucleaire', 7, 'Physique atomique et nucléaire', 'Modèle atomique, radioactivité, fission, fusion', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'physique-atomique-nucleaire-fiche', 'Physique atomique et nucléaire', 'Atome, radioactivité et énergie nucléaire', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Comment est constitué un atome ?","answer":"Un atome est constitué d''un noyau (protons + neutrons) et d''un nuage d''électrons. Notation : Z (numéro atomique = nombre de protons), A (nombre de masse = protons + neutrons), N = A - Z (nombre de neutrons). L''atome est électriquement neutre : nombre d''électrons = Z. Taille du noyau : 10^(-15) m (femtomètre). Taille de l''atome : 10^(-10) m (angström)."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les types de radioactivité ?","answer":"Radioactivité alpha : émission d''un noyau d''hélium He-4 (2 protons + 2 neutrons). Z diminue de 2, A diminue de 4. Radioactivité bêta moins : un neutron se transforme en proton + électron. Z augmente de 1, A ne change pas. Radioactivité bêta plus : un proton se transforme en neutron + positron. Z diminue de 1. Radioactivité gamma : émission de photons, pas de changement de Z ni A."},
      {"id":"fc3","category":"Formule","question":"Quelle est la loi de décroissance radioactive ?","answer":"N(t) = N0.e^(-lambda.t), où N0 est le nombre initial de noyaux, lambda la constante radioactive. La demi-vie t1/2 est le temps pour que la moitié des noyaux se désintègre : t1/2 = ln(2)/lambda = 0,693/lambda. L''activité A = lambda.N = A0.e^(-lambda.t) s''exprime en Becquerels (Bq). 1 Bq = 1 désintégration par seconde."},
      {"id":"fc4","category":"Formule","question":"Qu''est-ce que le défaut de masse et l''énergie de liaison ?","answer":"Le défaut de masse est la différence entre la masse des nucléons séparés et la masse du noyau : delta_m = Z.mp + N.mn - m_noyau. L''énergie de liaison est El = delta_m.c2 (relation d''Einstein E = mc2). L''énergie de liaison par nucléon El/A indique la stabilité du noyau. Le fer-56 a le maximum d''El/A (8,8 MeV/nucléon) : c''est le noyau le plus stable."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre fission et fusion nucléaire ?","answer":"La fission : un noyau lourd (uranium-235, plutonium-239) se casse en deux noyaux plus légers sous l''impact d''un neutron, libérant de l''énergie et des neutrons (réaction en chaîne). Applications : centrales nucléaires, bombe A. La fusion : deux noyaux légers (deutérium, tritium) fusionnent en un noyau plus lourd (hélium), libérant énormément d''énergie. C''est la réaction du Soleil. Applications : bombe H, ITER (en développement)."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que la relation E = mc2 ?","answer":"La relation d''Einstein E = mc2 établit l''équivalence masse-énergie. c = 3 x 10^8 m/s. Une masse m peut être convertie en énergie E et inversement. 1 u (unité de masse atomique = 1,66 x 10^(-27) kg) correspond à 931,5 MeV. Cette relation explique l''énergie libérée dans les réactions nucléaires : la masse des produits est inférieure à celle des réactifs."},
      {"id":"fc7","category":"Méthode","question":"Comment écrire une équation de réaction nucléaire ?","answer":"Règles : conservation du nombre de masse A (en haut) et du numéro atomique Z (en bas). Exemple de désintégration alpha du radium-226 : Ra(226,88) -> Rn(222,86) + He(4,2). Vérification : 226 = 222 + 4 (A conservé) et 88 = 86 + 2 (Z conservé). Exemple bêta moins du carbone-14 : C(14,6) -> N(14,7) + e(0,-1)."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce que la datation au carbone 14 ?","answer":"Le carbone 14 est radioactif (bêta moins, t1/2 = 5 730 ans). Les organismes vivants absorbent du C14 atmosphérique. À la mort, l''absorption cesse et le C14 décroît. En mesurant le rapport C14/C12 restant, on calcule l''âge : t = -(1/lambda).ln(N/N0). Cette méthode est utilisable jusqu''à environ 50 000 ans. Elle est utilisée en archéologie et paléontologie."}
    ],
    "schema": {
      "title": "Physique atomique et nucléaire",
      "nodes": [
        {"id":"n1","label":"Physique\nnucléaire","type":"main"},
        {"id":"n2","label":"Structure\nde l''atome","type":"branch"},
        {"id":"n3","label":"Radioactivité","type":"branch"},
        {"id":"n4","label":"Énergie\nnucléaire","type":"branch"},
        {"id":"n5","label":"Noyau : Z, A, N\nÉlectrons","type":"leaf"},
        {"id":"n6","label":"Alpha, Bêta\nGamma","type":"leaf"},
        {"id":"n7","label":"Décroissance\nt1/2, lambda","type":"leaf"},
        {"id":"n8","label":"Fission\nFusion","type":"leaf"},
        {"id":"n9","label":"E = mc2\nDéfaut de masse","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"composition"},
        {"from":"n1","to":"n3","label":"instabilité"},
        {"from":"n1","to":"n4","label":"applications"},
        {"from":"n2","to":"n5","label":"constituants"},
        {"from":"n3","to":"n6","label":"types"},
        {"from":"n3","to":"n7","label":"loi"},
        {"from":"n4","to":"n8","label":"réactions"},
        {"from":"n4","to":"n9","label":"énergie"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un atome de carbone-14 a pour notation C(14,6). Combien de neutrons possède-t-il ?","options":["6","8","14","20"],"correct":1,"explanation":"N = A - Z = 14 - 6 = 8 neutrons. Le carbone-14 a 6 protons (Z = 6) et 8 neutrons, pour un nombre de masse A = 14."},
      {"id":"q2","question":"La demi-vie du carbone 14 est 5 730 ans. Après 11 460 ans, quelle fraction reste ?","options":["1/2","1/4","1/8","1/16"],"correct":1,"explanation":"11 460 ans = 2 demi-vies. Après 1 demi-vie : 1/2. Après 2 demi-vies : (1/2)^2 = 1/4. Il reste 25% du C14 initial."},
      {"id":"q3","question":"La radioactivité alpha émet :","options":["Un électron","Un positron","Un noyau d''hélium","Un photon gamma"],"correct":2,"explanation":"La radioactivité alpha consiste en l''émission d''un noyau d''hélium-4 (2 protons + 2 neutrons). Le noyau père perd 4 unités de masse et 2 unités de charge."},
      {"id":"q4","question":"Quelle est l''énergie correspondant à une masse de 1 u ? (1 u = 1,66 x 10^(-27) kg)","options":["1 MeV","100 MeV","931,5 MeV","1000 MeV"],"correct":2,"explanation":"E = mc2 = 1,66 x 10^(-27) x (3 x 10^8)^2 = 1,494 x 10^(-10) J = 931,5 MeV."},
      {"id":"q5","question":"La fission nucléaire est utilisée dans :","options":["Les panneaux solaires","Les centrales nucléaires","Le Soleil","Les batteries"],"correct":1,"explanation":"La fission de l''uranium-235 est utilisée dans les centrales nucléaires pour produire de l''électricité. Un neutron frappe un noyau d''U-235 qui se scinde en deux noyaux plus légers en libérant de l''énergie."},
      {"id":"q6","question":"Quel noyau a la plus grande énergie de liaison par nucléon ?","options":["Hydrogène-1","Hélium-4","Fer-56","Uranium-235"],"correct":2,"explanation":"Le fer-56 a la plus grande énergie de liaison par nucléon (environ 8,8 MeV/nucléon). C''est le noyau le plus stable. La fusion des noyaux légers et la fission des noyaux lourds produisent des noyaux plus proches du fer."},
      {"id":"q7","question":"Dans une désintégration bêta moins :","options":["Un proton se transforme en neutron","Un neutron se transforme en proton","Le noyau émet un photon","Le noyau se casse en deux"],"correct":1,"explanation":"Dans la radioactivité bêta moins, un neutron se transforme en proton avec émission d''un électron et d''un antineutrino : n -> p + e- + antineutrino. Z augmente de 1, A ne change pas."},
      {"id":"q8","question":"L''unité d''activité radioactive est :","options":["Le Gray","Le Sievert","Le Becquerel","Le Curie seulement"],"correct":2,"explanation":"L''activité radioactive s''exprime en Becquerel (Bq). 1 Bq = 1 désintégration par seconde. L''ancienne unité était le Curie (1 Ci = 3,7 x 10^10 Bq)."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 1: Chimie organique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'chimie-organique', 1, 'Chimie organique', 'Hydrocarbures, fonctions organiques, nomenclature', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'chimie-organique-fiche', 'Chimie organique', 'Hydrocarbures, groupes fonctionnels et nomenclature', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la chimie organique ?","answer":"La chimie organique est la chimie des composés du carbone (sauf CO, CO2 et carbonates). Le carbone est tétravalent (4 liaisons). Il peut former des chaînes linéaires, ramifiées ou cycliques. Les principaux éléments : C, H, O, N, S, halogènes. Les hydrocarbures ne contiennent que C et H. La chimie organique est essentielle en biologie, pharmacie et industrie."},
      {"id":"fc2","category":"Méthode","question":"Comment nommer un alcane en nomenclature IUPAC ?","answer":"1) Trouver la chaîne carbonée la plus longue : méth- (1C), éth- (2C), prop- (3C), but- (4C), pent- (5C), hex- (6C). 2) Numéroter les carbones pour que les substituants aient les plus petits numéros. 3) Nommer les substituants (méthyl, éthyl...) avec leur numéro de position. 4) Ajouter le suffixe -ane pour les alcanes. Formule générale des alcanes : CnH(2n+2)."},
      {"id":"fc3","category":"Distinction","question":"Quels sont les principaux groupes fonctionnels ?","answer":"Alcool (-OH) : suffixe -ol. Aldéhyde (-CHO) : suffixe -al. Cétone (C=O entre 2 C) : suffixe -one. Acide carboxylique (-COOH) : acide...-oïque. Ester (-COO-) : -oate de ...-yle. Amine (-NH2) : suffixe -amine. Amide (-CONH2) : suffixe -amide. Chaque groupe fonctionnel confère des propriétés chimiques spécifiques à la molécule."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre alcane, alcène et alcyne ?","answer":"Alcane : liaisons simples C-C uniquement, saturé. Formule CnH(2n+2). Ex : éthane C2H6. Alcène : une double liaison C=C, insaturé. Formule CnH(2n). Ex : éthène (éthylène) C2H4. Alcyne : une triple liaison C≡C, insaturé. Formule CnH(2n-2). Ex : éthyne (acétylène) C2H2. Les insaturés sont plus réactifs (réactions d''addition)."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce que l''isomérie ?","answer":"Des isomères sont des molécules ayant la même formule brute mais des formules développées différentes. Isomérie de chaîne : arrangement différent de la chaîne carbonée (butane vs isobutane). Isomérie de position : même groupe fonctionnel à des positions différentes (propan-1-ol vs propan-2-ol). Isomérie de fonction : groupes fonctionnels différents (éthanol C2H5OH vs diméthyléther CH3OCH3)."},
      {"id":"fc6","category":"Méthode","question":"Comment identifier un groupe fonctionnel par des tests chimiques ?","answer":"Alcool : test de Lucas (formation de trouble avec ZnCl2/HCl). Aldéhyde : test de Tollens (miroir d''argent) ou liqueur de Fehling (précipité rouge brique de Cu2O). Cétone : DNPH (précipité jaune-orange) mais pas de réaction avec Tollens. Alcène : décoloration du brome (Br2) ou du permanganate (KMnO4). Acide carboxylique : fait virer le bleu de bromothymol au jaune."},
      {"id":"fc7","category":"Formule","question":"Comment écrire les réactions d''oxydation des alcools ?","answer":"Alcool primaire R-CH2OH : oxydation ménagée -> aldéhyde R-CHO, puis acide carboxylique R-COOH. Alcool secondaire R-CHOH-R'' : oxydation ménagée -> cétone R-CO-R''. Alcool tertiaire R3C-OH : pas d''oxydation ménagée. Oxydants courants : KMnO4 (permanganate), K2Cr2O7 (dichromate). L''oxydation ménagée est contrôlée, l''oxydation complète donne CO2 + H2O."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce qu''une réaction d''addition sur un alcène ?","answer":"L''addition est la fixation d''atomes sur la double liaison C=C, qui devient une liaison simple C-C. Hydrogénation : CH2=CH2 + H2 -> CH3-CH3 (catalyseur : Ni ou Pt). Halogénation : CH2=CH2 + Br2 -> CH2Br-CH2Br (décoloration du brome, test des alcènes). Hydrohalogénation : CH2=CH2 + HBr -> CH3-CH2Br (règle de Markovnikov : H se fixe sur le C le plus hydrogéné)."}
    ],
    "schema": {
      "title": "Chimie organique",
      "nodes": [
        {"id":"n1","label":"Chimie\norganique","type":"main"},
        {"id":"n2","label":"Hydrocarbures","type":"branch"},
        {"id":"n3","label":"Groupes\nfonctionnels","type":"branch"},
        {"id":"n4","label":"Réactions","type":"branch"},
        {"id":"n5","label":"Alcanes\nAlcènes, Alcynes","type":"leaf"},
        {"id":"n6","label":"Alcools\nAldéhydes, Cétones","type":"leaf"},
        {"id":"n7","label":"Acides\nEsters, Amines","type":"leaf"},
        {"id":"n8","label":"Addition\nSubstitution\nOxydation","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"C et H"},
        {"from":"n1","to":"n3","label":"fonctions"},
        {"from":"n1","to":"n4","label":"transformations"},
        {"from":"n2","to":"n5","label":"saturation"},
        {"from":"n3","to":"n6","label":"oxygénés"},
        {"from":"n3","to":"n7","label":"autres"},
        {"from":"n4","to":"n8","label":"types"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La formule générale des alcanes est :","options":["CnH(2n)","CnH(2n+2)","CnH(2n-2)","CnHn"],"correct":1,"explanation":"Les alcanes ont pour formule générale CnH(2n+2). Ils sont saturés (que des liaisons simples). Exemple : C3H8 (propane, n=3 : 2x3+2=8)."},
      {"id":"q2","question":"Quel groupe fonctionnel caractérise un aldéhyde ?","options":["-OH","-COOH","-CHO","-CO-"],"correct":2,"explanation":"L''aldéhyde possède le groupe fonctionnel -CHO (groupe carbonyle en bout de chaîne). Il est nommé avec le suffixe -al (méthanal, éthanal, propanal)."},
      {"id":"q3","question":"L''oxydation ménagée d''un alcool primaire donne d''abord :","options":["Un acide carboxylique","Une cétone","Un aldéhyde","Un alcène"],"correct":2,"explanation":"L''oxydation ménagée d''un alcool primaire donne d''abord un aldéhyde. Si l''oxydation se poursuit, on obtient un acide carboxylique. Un alcool secondaire donne une cétone."},
      {"id":"q4","question":"La décoloration du brome (Br2) est un test caractéristique des :","options":["Alcanes","Alcènes","Alcools","Acides"],"correct":1,"explanation":"Les alcènes décolorent le brome par réaction d''addition sur la double liaison C=C. C''est un test caractéristique de l''insaturation."},
      {"id":"q5","question":"Comment s''appelle C2H5OH en nomenclature IUPAC ?","options":["Méthanol","Éthanol","Propanol","Éthanal"],"correct":1,"explanation":"C2H5OH : chaîne de 2 carbones (éth-) avec un groupe -OH (alcool, -ol) = éthanol. Le méthanol est CH3OH (1C), le propanol est C3H7OH (3C)."},
      {"id":"q6","question":"Le propan-1-ol et le propan-2-ol sont des isomères de :","options":["Chaîne","Position","Fonction","Stéréoisomérie"],"correct":1,"explanation":"Le propan-1-ol (OH sur C1) et le propan-2-ol (OH sur C2) ont la même formule brute C3H8O et le même groupe fonctionnel (-OH) mais à des positions différentes : c''est une isomérie de position."},
      {"id":"q7","question":"Le test à la liqueur de Fehling permet de détecter :","options":["Les alcools","Les aldéhydes","Les cétones","Les alcènes"],"correct":1,"explanation":"La liqueur de Fehling (solution de Cu2+ en milieu basique) donne un précipité rouge brique de Cu2O en présence d''un aldéhyde. Les cétones ne réagissent pas avec ce test."},
      {"id":"q8","question":"Quelle est la valence du carbone ?","options":["2","3","4","6"],"correct":2,"explanation":"Le carbone est tétravalent : il forme 4 liaisons covalentes. Cette propriété lui permet de former des chaînes longues et variées, ce qui explique l''immense diversité des composés organiques."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 2: Cinétique chimique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'cinetique-chimique', 2, 'Cinétique chimique', 'Vitesse de réaction, facteurs cinétiques, catalyse', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'cinetique-chimique-fiche', 'Cinétique chimique', 'Vitesse de réaction et facteurs cinétiques', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la cinétique chimique ?","answer":"La cinétique chimique étudie la vitesse des réactions chimiques et les facteurs qui l''influencent. La vitesse de réaction v mesure la rapidité de transformation des réactifs en produits. Elle dépend de la température, de la concentration des réactifs, de la surface de contact et de la présence éventuelle d''un catalyseur."},
      {"id":"fc2","category":"Formule","question":"Comment définit-on la vitesse de réaction ?","answer":"La vitesse volumique de réaction est v = (1/V).(dn/dt) où n est l''avancement et V le volume. Pour un réactif A : v = -(1/a).(d[A]/dt), où a est le coefficient stoechiométrique. Pour un produit P : v = (1/p).(d[P]/dt). La vitesse est toujours positive. Elle s''exprime en mol/(L.s) ou mol.L^(-1).s^(-1)."},
      {"id":"fc3","category":"Concept","question":"Quels sont les facteurs cinétiques ?","answer":"1) Température : une augmentation de 10°C double environ la vitesse (règle de Van''t Hoff). 2) Concentration : plus les réactifs sont concentrés, plus les chocs moléculaires sont fréquents. 3) Surface de contact : un solide en poudre réagit plus vite qu''un solide en bloc. 4) Catalyseur : accélère la réaction sans être consommé. 5) Nature des réactifs : liaisons fortes = réaction lente."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un catalyseur ?","answer":"Un catalyseur est une substance qui augmente la vitesse d''une réaction sans être consommée. Il abaisse l''énergie d''activation Ea en offrant un chemin réactionnel alternatif. Catalyse homogène : le catalyseur est dans la même phase que les réactifs. Catalyse hétérogène : le catalyseur est dans une phase différente (ex : Pt solide pour réactions gazeuses). Catalyse enzymatique : enzymes biologiques."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que l''énergie d''activation ?","answer":"L''énergie d''activation Ea est l''énergie minimale que doivent posséder les réactifs pour que la réaction ait lieu. La loi d''Arrhenius : k = A.e^(-Ea/(R.T)), où k est la constante de vitesse, A le facteur pré-exponentiel, R = 8,314 J/(mol.K) la constante des gaz parfaits et T la température en Kelvin. Plus Ea est faible, plus la réaction est rapide."},
      {"id":"fc6","category":"Méthode","question":"Comment suivre la cinétique d''une réaction ?","answer":"Méthodes de suivi : 1) Spectrophotométrie : mesure de l''absorbance (loi de Beer-Lambert A = epsilon.l.c). 2) Conductimétrie : mesure de la conductivité si des ions sont impliqués. 3) Manométrie : mesure de la pression si des gaz sont produits. 4) Titrage : prélèvements et dosage à différents instants. 5) pH-métrie : si des acides ou bases sont impliqués. On trace [réactif] ou [produit] en fonction du temps."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que le temps de demi-réaction ?","answer":"Le temps de demi-réaction t1/2 est le temps nécessaire pour que l''avancement atteigne la moitié de sa valeur finale. Pour une réaction d''ordre 1 : t1/2 = ln(2)/k = 0,693/k (indépendant de la concentration initiale). Pour une réaction d''ordre 2 : t1/2 = 1/(k.[A]0). Le t1/2 permet de comparer la rapidité des réactions."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre réaction rapide et réaction lente ?","answer":"Réaction rapide (quasi-instantanée) : se termine en moins d''une seconde. Exemples : réactions acide-base, précipitation. Réaction lente : dure de quelques minutes à plusieurs heures. Exemples : estérification, corrosion. Réaction infiniment lente : ne semble pas évoluer à température ambiante mais possible à haute température. Exemple : combustion du bois (nécessite une allumette)."}
    ],
    "schema": {
      "title": "Cinétique chimique",
      "nodes": [
        {"id":"n1","label":"Cinétique\nchimique","type":"main"},
        {"id":"n2","label":"Vitesse\nde réaction","type":"branch"},
        {"id":"n3","label":"Facteurs\ncinétiques","type":"branch"},
        {"id":"n4","label":"v = (1/V).dn/dt","type":"leaf"},
        {"id":"n5","label":"Température\nConcentration","type":"leaf"},
        {"id":"n6","label":"Catalyse\nEa abaissée","type":"leaf"},
        {"id":"n7","label":"Suivi cinétique\nt1/2","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mesure"},
        {"from":"n1","to":"n3","label":"influence"},
        {"from":"n2","to":"n4","label":"définition"},
        {"from":"n3","to":"n5","label":"physiques"},
        {"from":"n3","to":"n6","label":"chimiques"},
        {"from":"n2","to":"n7","label":"expérimental"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel facteur n''influence PAS la vitesse de réaction ?","options":["La température","La concentration","La couleur des réactifs","Le catalyseur"],"correct":2,"explanation":"La couleur des réactifs n''est pas un facteur cinétique. Les facteurs qui influencent la vitesse sont : température, concentration, surface de contact, catalyseur et nature des réactifs."},
      {"id":"q2","question":"Un catalyseur agit en :","options":["Augmentant l''énergie d''activation","Abaissant l''énergie d''activation","Augmentant la température","Augmentant la concentration"],"correct":1,"explanation":"Un catalyseur abaisse l''énergie d''activation en offrant un chemin réactionnel alternatif avec une barrière énergétique plus basse. Il n''est pas consommé par la réaction."},
      {"id":"q3","question":"La vitesse de réaction s''exprime en :","options":["mol/L","mol.L^(-1).s^(-1)","L/mol","J/mol"],"correct":1,"explanation":"La vitesse volumique de réaction s''exprime en mol.L^(-1).s^(-1) (moles par litre par seconde). C''est la variation de concentration par unité de temps."},
      {"id":"q4","question":"Quand on augmente la température de 10°C, la vitesse est approximativement :","options":["Inchangée","Doublée","Triplée","Divisée par 2"],"correct":1,"explanation":"Selon la règle empirique de Van''t Hoff, une augmentation de température de 10°C double approximativement la vitesse de réaction. Cela s''explique par la loi d''Arrhenius."},
      {"id":"q5","question":"Pour une réaction d''ordre 1, le temps de demi-réaction :","options":["Dépend de la concentration initiale","Est indépendant de la concentration initiale","Est toujours de 1 seconde","Augmente avec le temps"],"correct":1,"explanation":"Pour une réaction d''ordre 1, t1/2 = ln(2)/k. Il ne dépend pas de la concentration initiale, seulement de la constante de vitesse k."},
      {"id":"q6","question":"La réaction de précipitation est un exemple de réaction :","options":["Lente","Rapide (quasi-instantanée)","Infiniment lente","Équilibrée"],"correct":1,"explanation":"La précipitation est une réaction rapide (quasi-instantanée) qui se produit en moins d''une seconde. Les réactions ioniques en solution sont généralement très rapides."},
      {"id":"q7","question":"Dans la catalyse homogène, le catalyseur est :","options":["Dans une phase différente des réactifs","Dans la même phase que les réactifs","Toujours un métal","Toujours un enzyme"],"correct":1,"explanation":"En catalyse homogène, le catalyseur est dans la même phase que les réactifs (tous en solution par exemple). En catalyse hétérogène, le catalyseur est dans une phase différente (solide dans un milieu liquide ou gazeux)."},
      {"id":"q8","question":"La loi d''Arrhenius montre que la constante de vitesse k :","options":["Diminue quand T augmente","Augmente quand T augmente","Ne dépend pas de T","Est toujours constante"],"correct":1,"explanation":"D''après la loi d''Arrhenius k = A.e^(-Ea/(R.T)), k augmente exponentiellement avec la température T. Plus T est élevée, plus les molécules ont assez d''énergie pour franchir la barrière d''activation."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 3: Estérification et hydrolyse
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'esterification-hydrolyse', 3, 'Estérification et hydrolyse', 'Réaction d''estérification, équilibre, rendement', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'esterification-hydrolyse-fiche', 'Estérification et hydrolyse', 'Synthèse et hydrolyse des esters', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Qu''est-ce que la réaction d''estérification ?","answer":"L''estérification est la réaction entre un acide carboxylique (R-COOH) et un alcool (R''-OH) pour former un ester (R-COO-R'') et de l''eau : R-COOH + R''-OH <=> R-COO-R'' + H2O. C''est une réaction lente, limitée (équilibre) et athermique. Le rendement dépend des classes d''alcool : primaire (67%), secondaire (60%), tertiaire (5%)."},
      {"id":"fc2","category":"Concept","question":"Qu''est-ce que l''hydrolyse d''un ester ?","answer":"L''hydrolyse est la réaction inverse de l''estérification : un ester réagit avec l''eau pour donner un acide carboxylique et un alcool : R-COO-R'' + H2O <=> R-COOH + R''-OH. Comme l''estérification, c''est une réaction lente et limitée. Le même état d''équilibre est atteint par les deux réactions. Un catalyseur acide (H2SO4, H+) accélère les deux réactions."},
      {"id":"fc3","category":"Méthode","question":"Comment augmenter le rendement de l''estérification ?","answer":"Pour déplacer l''équilibre vers la formation de l''ester : 1) Utiliser un excès de l''un des réactifs (acide ou alcool). 2) Éliminer un produit au fur et à mesure (distiller l''eau avec un desséchant, ou distiller l''ester). 3) Utiliser un catalyseur acide (H2SO4, H+) pour atteindre l''équilibre plus rapidement (mais ne change pas le rendement). 4) Utiliser un chlorure d''acyle ou un anhydride d''acide (réaction totale et rapide)."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre estérification et saponification ?","answer":"L''estérification : acide + alcool -> ester + eau (réversible, limitée). La saponification : ester + soude (NaOH) -> savon (carboxylate de sodium) + alcool. La saponification est une réaction totale et irréversible, contrairement à l''hydrolyse en milieu acide qui est limitée. C''est la base de la fabrication du savon à partir de corps gras (triglycérides)."},
      {"id":"fc5","category":"Exemple","question":"Comment nomme-t-on un ester ?","answer":"Le nom d''un ester comprend deux parties : le nom de l''acide dont dérive la partie acyle (terminaison -oate) + le nom du groupe alkyle de l''alcool (terminaison -yle). Exemple : acide éthanoïque + méthanol -> éthanoate de méthyle (acétate de méthyle). Éthanoate = partie acide (acide éthanoïque). De méthyle = partie alcool (méthanol). Les esters sont souvent responsables des odeurs fruitées."},
      {"id":"fc6","category":"Formule","question":"Comment calculer la constante d''équilibre K de l''estérification ?","answer":"K = [ester].[H2O] / ([acide].[alcool]) à l''équilibre. Pour un acide et un alcool primaire en proportions équimolaires : K = (2/3)^2 / (1/3)^2 = 4. Le rendement est alors de 67%. K ne dépend PAS de la concentration initiale ni du catalyseur. K dépend de la température mais l''estérification étant athermique, K varie très peu avec T."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce qu''un anhydride d''acide et pourquoi est-il plus réactif ?","answer":"Un anhydride d''acide a pour formule R-CO-O-CO-R''. C''est un dérivé d''acide plus réactif car le groupe partant (carboxylate) est meilleur que -OH. La réaction avec un alcool est rapide et totale : R-CO-O-CO-R + R''-OH -> R-CO-O-R'' + R-COOH. Exemple : anhydride éthanoïque + éthanol -> éthanoate d''éthyle + acide éthanoïque. Pas d''équilibre, rendement quasi-total."},
      {"id":"fc8","category":"Exemple","question":"Quels sont les esters courants et leurs odeurs ?","answer":"Éthanoate d''éthyle : solvant, odeur fruitée. Butanoate d''éthyle : odeur d''ananas. Éthanoate d''isoamyle : odeur de banane. Méthanoate d''éthyle : odeur de rhum. Benzoate de méthyle : odeur fleurie. Les esters sont très utilisés en parfumerie et dans l''industrie alimentaire comme arômes artificiels. Les graisses et huiles sont des triesters du glycérol (triglycérides)."}
    ],
    "schema": {
      "title": "Estérification et hydrolyse",
      "nodes": [
        {"id":"n1","label":"Esters","type":"main"},
        {"id":"n2","label":"Estérification","type":"branch"},
        {"id":"n3","label":"Hydrolyse","type":"branch"},
        {"id":"n4","label":"Acide + Alcool\n-> Ester + H2O","type":"leaf"},
        {"id":"n5","label":"Lente, limitée\nK = 4","type":"leaf"},
        {"id":"n6","label":"Ester + H2O\n-> Acide + Alcool","type":"leaf"},
        {"id":"n7","label":"Saponification\n(totale, NaOH)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"synthèse"},
        {"from":"n1","to":"n3","label":"dégradation"},
        {"from":"n2","to":"n4","label":"équation"},
        {"from":"n2","to":"n5","label":"caractéristiques"},
        {"from":"n3","to":"n6","label":"milieu acide"},
        {"from":"n3","to":"n7","label":"milieu basique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''estérification est une réaction :","options":["Rapide et totale","Lente et limitée","Rapide et limitée","Lente et totale"],"correct":1,"explanation":"L''estérification est lente (il faut des heures pour atteindre l''équilibre) et limitée (elle n''est pas totale, il reste des réactifs à l''équilibre). Un catalyseur accélère la réaction mais ne change pas le rendement."},
      {"id":"q2","question":"Le rendement de l''estérification d''un acide et d''un alcool primaire en proportions équimolaires est :","options":["33%","50%","67%","100%"],"correct":2,"explanation":"Pour un acide et un alcool primaire en proportions équimolaires, le rendement à l''équilibre est de 67% (2/3). La constante d''équilibre K = 4."},
      {"id":"q3","question":"Pour augmenter le rendement de l''estérification, on peut :","options":["Ajouter un catalyseur","Utiliser un excès de réactif","Diminuer la température","Ajouter de l''eau"],"correct":1,"explanation":"Utiliser un excès de l''un des réactifs déplace l''équilibre vers la formation de l''ester (principe de Le Chatelier). Le catalyseur accélère la réaction mais ne modifie pas le rendement final."},
      {"id":"q4","question":"La saponification est :","options":["Réversible et lente","Irréversible et totale","Réversible et rapide","Irréversible et lente"],"correct":1,"explanation":"La saponification (ester + NaOH -> savon + alcool) est totale et irréversible, contrairement à l''hydrolyse en milieu acide qui est limitée."},
      {"id":"q5","question":"L''éthanoate de méthyle est formé à partir de :","options":["Acide éthanoïque + méthanol","Acide méthanoïque + éthanol","Acide propanoïque + méthanol","Acide éthanoïque + éthanol"],"correct":0,"explanation":"Éthanoate (partie acide = acide éthanoïque) de méthyle (partie alcool = méthanol). Acide éthanoïque + méthanol -> éthanoate de méthyle + eau."},
      {"id":"q6","question":"Le catalyseur de l''estérification est généralement :","options":["NaOH","H2SO4 (acide sulfurique)","KMnO4","Un enzyme"],"correct":1,"explanation":"L''acide sulfurique concentré (H2SO4) est le catalyseur classique de l''estérification. Il fournit des ions H+ qui accélèrent la réaction sans modifier l''équilibre."},
      {"id":"q7","question":"La constante d''équilibre K de l''estérification :","options":["Dépend du catalyseur","Dépend des concentrations initiales","Ne dépend que de la température","Vaut toujours 1"],"correct":2,"explanation":"K ne dépend que de la température (et de la nature des réactifs). Elle ne dépend ni du catalyseur ni des concentrations initiales. Pour l''estérification athermique, K varie très peu avec T."},
      {"id":"q8","question":"Les triglycérides sont des :","options":["Acides aminés","Sucres","Triesters du glycérol","Protéines"],"correct":2,"explanation":"Les triglycérides (graisses et huiles) sont des triesters formés par l''estérification du glycérol (triol) avec trois acides gras. Leur saponification produit du glycérol et des savons."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 4: Acides et bases en solution aqueuse
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'acides-bases', 4, 'Acides et bases en solution aqueuse', 'pH, couples acide-base, titrages', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'acides-bases-fiche', 'Acides et bases en solution aqueuse', 'pH, couples acide-base et titrages', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un acide et une base selon Brønsted ?","answer":"Selon Brønsted-Lowry, un acide est une espèce qui cède un proton H+. Une base est une espèce qui capte un proton H+. Un couple acide/base est noté AH/A- : AH <=> A- + H+. Exemples : HCl/Cl- (acide chlorhydrique/ion chlorure), CH3COOH/CH3COO- (acide acétique/ion acétate), NH4+/NH3 (ion ammonium/ammoniac). L''eau est amphotère : H2O/OH- et H3O+/H2O."},
      {"id":"fc2","category":"Formule","question":"Comment calcule-t-on le pH ?","answer":"pH = -log([H3O+]) ou [H3O+] = 10^(-pH). À 25°C, le produit ionique de l''eau est Ke = [H3O+].[OH-] = 10^(-14). Solution acide : pH < 7, [H3O+] > 10^(-7) mol/L. Solution neutre : pH = 7. Solution basique : pH > 7, [H3O+] < 10^(-7) mol/L. Le pH est une grandeur sans unité."},
      {"id":"fc3","category":"Distinction","question":"Quelle différence entre acide fort et acide faible ?","answer":"Un acide fort se dissocie totalement dans l''eau : HCl -> H3O+ + Cl- (réaction totale, alpha = 1). Le pH d''un acide fort de concentration c est pH = -log(c). Un acide faible se dissocie partiellement : CH3COOH + H2O <=> CH3COO- + H3O+ (équilibre). Son pH > -log(c). Le Ka (constante d''acidité) mesure la force : pKa = -log(Ka). Plus pKa est petit, plus l''acide est fort."},
      {"id":"fc4","category":"Formule","question":"Comment calcule-t-on le pH d''un acide faible ?","answer":"Pour un acide faible AH de concentration c et de pKa donné, si c >> Ka : pH = (1/2).(pKa - log(c)). Démonstration : Ka = [A-].[H3O+]/[AH]. À l''équilibre, [A-] = [H3O+] et [AH] = c - [H3O+] ≈ c. Donc Ka = [H3O+]^2/c, d''où [H3O+] = racine(Ka.c) et pH = (1/2).(pKa - log(c))."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce qu''une solution tampon ?","answer":"Une solution tampon est une solution dont le pH varie peu par ajout modéré d''acide, de base ou par dilution. Elle contient un acide faible et sa base conjuguée en proportions comparables. Le pH d''un tampon est donné par la formule de Henderson-Hasselbalch : pH = pKa + log([A-]/[AH]). Quand [A-] = [AH] : pH = pKa. Exemples : tampon acétique (CH3COOH/CH3COO-), tampon phosphate."},
      {"id":"fc6","category":"Méthode","question":"Comment réaliser un titrage acide-base ?","answer":"1) Verser la solution titrante (de concentration connue) progressivement dans la solution titrée (de concentration inconnue). 2) Mesurer le pH après chaque ajout. 3) Tracer la courbe pH = f(V). 4) Déterminer le point d''équivalence : point d''inflexion de la courbe (méthode des tangentes ou de la dérivée). 5) À l''équivalence : n(acide) = n(base), donc Ca.Va = Cb.Vb."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que le point d''équivalence ?","answer":"Le point d''équivalence est atteint quand la quantité de réactif titrant ajouté est exactement stoechiométrique avec le réactif titré. Pour le titrage d''un acide par une base : n(H3O+) = n(OH-). Le pH à l''équivalence dépend de la nature de la réaction : titrage acide fort/base forte : pH = 7. Titrage acide faible/base forte : pH > 7. Titrage acide fort/base faible : pH < 7."},
      {"id":"fc8","category":"Exemple","question":"Quels indicateurs colorés utilise-t-on pour les titrages ?","answer":"Un indicateur coloré change de couleur dans un intervalle de pH appelé zone de virage. On choisit un indicateur dont la zone de virage contient le pH d''équivalence. Exemples : hélianthine (zone 3,1-4,4, rouge/jaune) pour les acides. Bleu de bromothymol (zone 6,0-7,6, jaune/bleu) pour les titrages acide fort/base forte. Phénolphtaléine (zone 8,2-10,0, incolore/rose) pour les bases."}
    ],
    "schema": {
      "title": "Acides et bases en solution aqueuse",
      "nodes": [
        {"id":"n1","label":"Acides\net bases","type":"main"},
        {"id":"n2","label":"Théorie de\nBrønsted","type":"branch"},
        {"id":"n3","label":"pH","type":"branch"},
        {"id":"n4","label":"Titrages","type":"branch"},
        {"id":"n5","label":"Couples AH/A-\nForce : Ka, pKa","type":"leaf"},
        {"id":"n6","label":"pH = -log[H3O+]\nKe = 10^(-14)","type":"leaf"},
        {"id":"n7","label":"Point d''équivalence\nCa.Va = Cb.Vb","type":"leaf"},
        {"id":"n8","label":"Solutions\ntampons","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"définitions"},
        {"from":"n1","to":"n3","label":"mesure"},
        {"from":"n1","to":"n4","label":"dosage"},
        {"from":"n2","to":"n5","label":"couples"},
        {"from":"n3","to":"n6","label":"formules"},
        {"from":"n4","to":"n7","label":"analyse"},
        {"from":"n3","to":"n8","label":"stabilité"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le pH d''une solution de HCl à 0,01 mol/L est :","options":["1","2","7","12"],"correct":1,"explanation":"HCl est un acide fort : dissociation totale. [H3O+] = c = 0,01 = 10^(-2) mol/L. pH = -log(10^(-2)) = 2."},
      {"id":"q2","question":"Une solution de pH = 9 est :","options":["Acide","Neutre","Basique","Impossible à déterminer"],"correct":2,"explanation":"pH > 7 indique une solution basique. [H3O+] = 10^(-9) mol/L < 10^(-7) mol/L. [OH-] = 10^(-14)/10^(-9) = 10^(-5) mol/L."},
      {"id":"q3","question":"Le pKa du couple CH3COOH/CH3COO- est 4,8. Le pH d''une solution de CH3COOH à 0,1 mol/L est environ :","options":["2,4","2,9","4,8","7"],"correct":1,"explanation":"pH = (1/2)(pKa - log(c)) = (1/2)(4,8 - log(0,1)) = (1/2)(4,8 + 1) = (1/2)(5,8) = 2,9."},
      {"id":"q4","question":"À l''équivalence du titrage d''un acide fort par une base forte, le pH est :","options":["< 7","= 7","> 7","= pKa"],"correct":1,"explanation":"À l''équivalence d''un titrage acide fort/base forte, la solution ne contient que de l''eau et du sel neutre (NaCl par exemple). Le pH est donc égal à 7."},
      {"id":"q5","question":"Le produit ionique de l''eau à 25°C est :","options":["10^(-7)","10^(-14)","10^(-1)","1"],"correct":1,"explanation":"Ke = [H3O+].[OH-] = 10^(-14) à 25°C. Dans l''eau pure : [H3O+] = [OH-] = 10^(-7) mol/L et pH = 7."},
      {"id":"q6","question":"Pour une solution tampon, pH = pKa quand :","options":["[AH] >> [A-]","[A-] >> [AH]","[AH] = [A-]","[AH] = 0"],"correct":2,"explanation":"D''après Henderson-Hasselbalch : pH = pKa + log([A-]/[AH]). Quand [AH] = [A-], log(1) = 0, donc pH = pKa."},
      {"id":"q7","question":"On titre 20 mL d''acide à 0,1 mol/L par de la soude à 0,1 mol/L. Le volume à l''équivalence est :","options":["10 mL","20 mL","40 mL","100 mL"],"correct":1,"explanation":"À l''équivalence : Ca.Va = Cb.Vb. 0,1 x 20 = 0,1 x Vb, donc Vb = 20 mL."},
      {"id":"q8","question":"La phénolphtaléine est adaptée pour le titrage de :","options":["Un acide fort par une base forte","Un acide faible par une base forte","Les deux réponses sont correctes","Aucun des deux"],"correct":2,"explanation":"La phénolphtaléine (zone de virage 8,2-10) convient pour les titrages dont le pH à l''équivalence est dans cette zone : acide fort/base forte (pH=7, mais le saut est large) et surtout acide faible/base forte (pH > 7 à l''équivalence)."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 1: Suites numériques
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'suites-numeriques', 1, 'Suites numériques', 'Suites arithmétiques, géométriques, convergence', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'suites-numeriques-fiche', 'Suites numériques', 'Suites arithmétiques et géométriques', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une suite arithmétique ?","answer":"Une suite arithmétique est une suite (Un) telle que Un+1 = Un + r, où r est la raison. Terme général : Un = U0 + n.r ou Un = Up + (n-p).r. Somme des n+1 premiers termes : S = (n+1)(U0 + Un)/2 = (nombre de termes)(premier + dernier)/2. Si r > 0, la suite est croissante. Si r < 0, elle est décroissante."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce qu''une suite géométrique ?","answer":"Une suite géométrique est une suite (Un) telle que Un+1 = Un x q, où q est la raison. Terme général : Un = U0 x q^n. Somme des n+1 premiers termes : S = U0 x (1 - q^(n+1))/(1 - q) si q ≠ 1. Si |q| < 1, la suite converge vers 0. Si q > 1, la suite diverge vers +infini (si U0 > 0). Si q = 1, tous les termes sont égaux."},
      {"id":"fc3","category":"Méthode","question":"Comment montrer qu''une suite est arithmétique ou géométrique ?","answer":"Suite arithmétique : calculer Un+1 - Un. Si c''est une constante r, la suite est arithmétique de raison r. Suite géométrique : calculer Un+1/Un. Si c''est une constante q (et Un ≠ 0), la suite est géométrique de raison q. Si aucune des deux, on peut essayer de se ramener à une suite auxiliaire arithmétique ou géométrique."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que la convergence d''une suite ?","answer":"Une suite (Un) converge vers un réel L si Un se rapproche de L quand n tend vers l''infini : lim(n->+infini) Un = L. On dit que L est la limite. Une suite croissante majorée converge. Une suite décroissante minorée converge. Une suite qui ne converge pas diverge (elle peut tendre vers +infini, -infini, ou osciller)."},
      {"id":"fc5","category":"Formule","question":"Comment calculer la somme 1 + 2 + 3 + ... + n ?","answer":"C''est la somme des n premiers entiers naturels non nuls, qui forment une suite arithmétique de raison 1. S = n(n+1)/2. Exemple : 1+2+3+...+100 = 100 x 101/2 = 5050. Somme des carrés : 1^2 + 2^2 + ... + n^2 = n(n+1)(2n+1)/6. Somme des cubes : 1^3 + 2^3 + ... + n^3 = [n(n+1)/2]^2."},
      {"id":"fc6","category":"Méthode","question":"Comment étudier une suite définie par récurrence Un+1 = f(Un) ?","answer":"1) Calculer les premiers termes. 2) Conjecturer le sens de variation (Un+1 - Un) et la convergence. 3) Si la suite converge vers L, alors L = f(L) (résoudre l''équation point fixe). 4) Montrer par récurrence que la suite est monotone et bornée. 5) Conclure que la suite converge vers L."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre suite explicite et suite définie par récurrence ?","answer":"Suite explicite : Un est donné directement en fonction de n. Exemple : Un = 3n + 2. On peut calculer n''importe quel terme directement. Suite par récurrence : Un+1 est donné en fonction de Un (et du premier terme U0). Exemple : Un+1 = 2Un + 1, U0 = 0. Il faut calculer tous les termes précédents pour obtenir un terme donné."},
      {"id":"fc8","category":"Exemple","question":"Donnez un exemple de problème concret avec une suite géométrique.","answer":"Un capital de 1 000 000 FCFA est placé à un taux annuel de 5%. Le capital après n années est Cn = 1 000 000 x (1,05)^n. C''est une suite géométrique de raison q = 1,05. Après 10 ans : C10 = 1 000 000 x (1,05)^10 = 1 628 895 FCFA. Le temps de doublement : 1 000 000 x (1,05)^n = 2 000 000, donc n = ln(2)/ln(1,05) = 14,2 ans."}
    ],
    "schema": {
      "title": "Suites numériques",
      "nodes": [
        {"id":"n1","label":"Suites\nnumériques","type":"main"},
        {"id":"n2","label":"Arithmétique","type":"branch"},
        {"id":"n3","label":"Géométrique","type":"branch"},
        {"id":"n4","label":"Convergence","type":"branch"},
        {"id":"n5","label":"Un = U0 + n.r\nS = n(U0+Un)/2","type":"leaf"},
        {"id":"n6","label":"Un = U0.q^n\nS = U0(1-q^n)/(1-q)","type":"leaf"},
        {"id":"n7","label":"Limite\nMajorée/Minorée","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"raison r"},
        {"from":"n1","to":"n3","label":"raison q"},
        {"from":"n1","to":"n4","label":"comportement"},
        {"from":"n2","to":"n5","label":"formules"},
        {"from":"n3","to":"n6","label":"formules"},
        {"from":"n4","to":"n7","label":"critères"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le 10e terme d''une suite arithmétique de premier terme U0 = 3 et de raison r = 2 est :","options":["21","23","25","20"],"correct":1,"explanation":"U10 = U0 + 10.r = 3 + 10 x 2 = 23. On utilise la formule Un = U0 + n.r."},
      {"id":"q2","question":"La somme 1 + 2 + 3 + ... + 50 est égale à :","options":["1225","1250","1275","1300"],"correct":2,"explanation":"S = n(n+1)/2 = 50 x 51/2 = 1275."},
      {"id":"q3","question":"Une suite géométrique de raison q = 0,5 et de premier terme U0 = 8 converge vers :","options":["4","2","1","0"],"correct":3,"explanation":"|q| = 0,5 < 1, donc la suite converge vers 0. Les termes sont 8, 4, 2, 1, 0.5, ... et tendent vers 0."},
      {"id":"q4","question":"La somme des 5 premiers termes d''une suite géométrique de U0 = 1 et q = 2 est :","options":["15","16","31","32"],"correct":2,"explanation":"S = U0.(1-q^5)/(1-q) = 1.(1-32)/(1-2) = (-31)/(-1) = 31. Les termes sont 1+2+4+8+16 = 31."},
      {"id":"q5","question":"Si Un+1 = Un + 5 et U0 = 2, alors U3 = :","options":["12","15","17","20"],"correct":2,"explanation":"Suite arithmétique de raison 5. U3 = U0 + 3r = 2 + 3 x 5 = 17. Ou : U1 = 7, U2 = 12, U3 = 17."},
      {"id":"q6","question":"Une suite croissante et majorée :","options":["Diverge","Converge","Oscille","N''existe pas"],"correct":1,"explanation":"C''est un théorème fondamental : toute suite croissante et majorée converge. Sa limite est le plus petit de ses majorants (borne supérieure)."},
      {"id":"q7","question":"Un capital de 500 000 FCFA placé à 8% par an vaut après 3 ans :","options":["620 000 FCFA","629 856 FCFA","640 000 FCFA","665 000 FCFA"],"correct":1,"explanation":"C3 = 500 000 x (1,08)^3 = 500 000 x 1,259712 = 629 856 FCFA."},
      {"id":"q8","question":"Comment montrer qu''une suite est arithmétique ?","options":["Calculer Un+1/Un = constante","Calculer Un+1 - Un = constante","Calculer Un^2 = constante","Calculer Un x Un+1 = constante"],"correct":1,"explanation":"Si Un+1 - Un = r (constante) pour tout n, alors la suite est arithmétique de raison r."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 2: Limites et continuité
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'limites-continuite', 2, 'Limites et continuité', 'Limites de fonctions, formes indéterminées, continuité', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'limites-continuite-fiche', 'Limites et continuité', 'Calcul de limites et théorème des valeurs intermédiaires', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quelles sont les limites de référence ?","answer":"lim(x->+inf) x^n = +inf (n > 0). lim(x->+inf) 1/x^n = 0. lim(x->0) 1/x = +inf ou -inf selon le signe. lim(x->+inf) e^x = +inf. lim(x->-inf) e^x = 0. lim(x->+inf) ln(x) = +inf. lim(x->0+) ln(x) = -inf. Croissances comparées : lim(x->+inf) e^x/x^n = +inf et lim(x->+inf) ln(x)/x = 0."},
      {"id":"fc2","category":"Méthode","question":"Comment lever une forme indéterminée ?","answer":"Formes indéterminées : 0/0, inf/inf, inf - inf, 0 x inf. Techniques : 1) Factoriser par le terme dominant (polynômes). 2) Multiplier par l''expression conjuguée (racines). 3) Mettre en facteur et simplifier. 4) Utiliser les limites de référence. 5) Utiliser le taux de variation pour 0/0 en un point. Exemple : lim(x->inf)(3x2+x)/(2x2-1) = lim 3/2 = 3/2 (factoriser par x2)."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''une asymptote ?","answer":"Asymptote horizontale : si lim(x->+inf) f(x) = L, alors y = L est asymptote horizontale. Asymptote verticale : si lim(x->a) f(x) = +inf ou -inf, alors x = a est asymptote verticale. Asymptote oblique : si lim(x->+inf) [f(x) - (ax+b)] = 0, alors y = ax + b est asymptote oblique. a = lim f(x)/x, b = lim [f(x) - ax]."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que la continuité d''une fonction ?","answer":"Une fonction f est continue en a si lim(x->a) f(x) = f(a). Cela signifie que le graphe de f ne présente pas de saut en a. Les fonctions polynômes, rationnelles (sur leur domaine), trigonométriques, exponentielles et logarithmes sont continues sur leur domaine. La somme, le produit, le quotient et la composée de fonctions continues sont continus."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce que le théorème des valeurs intermédiaires (TVI) ?","answer":"Si f est continue sur [a,b] et si f(a) et f(b) sont de signes contraires, alors il existe c dans ]a,b[ tel que f(c) = 0. Plus généralement, si f est continue sur [a,b], alors pour tout k entre f(a) et f(b), il existe c dans [a,b] tel que f(c) = k. Si de plus f est strictement monotone, alors c est unique. Le TVI est utilisé pour prouver l''existence de solutions."},
      {"id":"fc6","category":"Méthode","question":"Comment utiliser le TVI pour montrer qu''une équation a une solution ?","answer":"Pour montrer que f(x) = 0 a une solution dans [a,b] : 1) Vérifier que f est continue sur [a,b]. 2) Calculer f(a) et f(b). 3) Si f(a) et f(b) sont de signes contraires, alors par le TVI, il existe c dans ]a,b[ tel que f(c) = 0. 4) Si f est strictement monotone sur [a,b], la solution c est unique. Exemple : f(x) = x3 - x - 1, f(1) = -1 < 0, f(2) = 5 > 0, donc il existe c dans ]1,2[."},
      {"id":"fc7","category":"Formule","question":"Quelles sont les règles de calcul des limites ?","answer":"Si lim f = L et lim g = L'' (L et L'' finis) : lim(f+g) = L+L'', lim(f.g) = L.L'', lim(f/g) = L/L'' si L'' ≠ 0. Si lim f = +inf : lim(f+g) = +inf si lim g ≠ -inf, lim(f.g) = +inf si lim g > 0. Théorème des gendarmes : si g(x) <= f(x) <= h(x) et lim g = lim h = L, alors lim f = L."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre limite finie et limite infinie ?","answer":"Limite finie : lim f(x) = L (un nombre réel). La courbe se rapproche de la droite y = L (asymptote horizontale). Limite infinie : lim f(x) = +inf ou -inf. La fonction croît ou décroît sans borne. Si lim(x->a) f(x) = inf, alors x = a est une asymptote verticale. Absence de limite : la fonction oscille sans se stabiliser (ex : sin(x) quand x -> +inf)."}
    ],
    "schema": {
      "title": "Limites et continuité",
      "nodes": [
        {"id":"n1","label":"Limites et\ncontinuité","type":"main"},
        {"id":"n2","label":"Limites","type":"branch"},
        {"id":"n3","label":"Continuité","type":"branch"},
        {"id":"n4","label":"Règles de calcul\nFormes indéterminées","type":"leaf"},
        {"id":"n5","label":"Asymptotes\nH, V, O","type":"leaf"},
        {"id":"n6","label":"TVI\nExistence de solutions","type":"leaf"},
        {"id":"n7","label":"Théorème des\ngendarmes","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"comportement"},
        {"from":"n1","to":"n3","label":"régularité"},
        {"from":"n2","to":"n4","label":"calcul"},
        {"from":"n2","to":"n5","label":"graphique"},
        {"from":"n3","to":"n6","label":"application"},
        {"from":"n2","to":"n7","label":"encadrement"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"lim(x->+inf) (3x2 + x)/(x2 - 1) = ?","options":["0","1","3","+infini"],"correct":2,"explanation":"On factorise par x2 : (3 + 1/x)/(1 - 1/x2). Quand x->+inf, 1/x -> 0 et 1/x2 -> 0, donc la limite est 3/1 = 3."},
      {"id":"q2","question":"Si f(1) = -2 et f(3) = 5, et f est continue sur [1,3], alors :","options":["f a une racine dans ]1,3[","f n''a pas de racine","f(2) = 0","f est constante"],"correct":0,"explanation":"f(1) < 0 et f(3) > 0, et f est continue. Par le TVI, il existe c dans ]1,3[ tel que f(c) = 0. f admet au moins une racine dans cet intervalle."},
      {"id":"q3","question":"lim(x->0+) ln(x) = ?","options":["0","1","+infini","-infini"],"correct":3,"explanation":"Le logarithme népérien tend vers -infini quand x tend vers 0 par valeurs positives. La droite x = 0 est asymptote verticale pour y = ln(x)."},
      {"id":"q4","question":"lim(x->+inf) e^x / x^2 = ?","options":["0","1","+infini","e"],"correct":2,"explanation":"Par les croissances comparées, l''exponentielle l''emporte sur tout polynôme : lim(x->+inf) e^x/x^n = +inf pour tout n."},
      {"id":"q5","question":"La forme indéterminée de lim(x->+inf) (x2 - x) est :","options":["0/0","inf/inf","inf - inf","0 x inf"],"correct":2,"explanation":"x2 -> +inf et x -> +inf, donc x2 - x est de la forme inf - inf. On lève l''indétermination en factorisant : x(x-1) -> +inf."},
      {"id":"q6","question":"Si lim(x->+inf) f(x) = 3, alors y = 3 est :","options":["Une asymptote verticale","Une asymptote horizontale","Une asymptote oblique","Un point d''inflexion"],"correct":1,"explanation":"Si la limite de f(x) quand x tend vers l''infini est une constante L = 3, alors y = 3 est une asymptote horizontale."},
      {"id":"q7","question":"Le théorème des gendarmes dit que si g(x) <= f(x) <= h(x) et lim g = lim h = L :","options":["lim f = 0","lim f = L","lim f n''existe pas","lim f = L/2"],"correct":1,"explanation":"Si f est encadrée par g et h qui convergent vers la même limite L, alors f converge aussi vers L. C''est le théorème des gendarmes (ou théorème d''encadrement)."},
      {"id":"q8","question":"lim(x->2) (x2 - 4)/(x - 2) = ?","options":["0","2","4","Indéterminée"],"correct":2,"explanation":"Forme 0/0. On factorise : (x-2)(x+2)/(x-2) = x+2. lim(x->2) (x+2) = 4."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 3: Dérivation et applications
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'derivation-applications', 3, 'Dérivation et applications', 'Dérivées, tangentes, variations, extremums', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'derivation-applications-fiche', 'Dérivation et applications', 'Calcul de dérivées et étude de fonctions', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quelles sont les dérivées des fonctions usuelles ?","answer":"(x^n)'' = n.x^(n-1). (1/x)'' = -1/x2. (racine(x))'' = 1/(2.racine(x)). (e^x)'' = e^x. (ln(x))'' = 1/x. (sin(x))'' = cos(x). (cos(x))'' = -sin(x). (constante)'' = 0. (a.x + b)'' = a."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les règles de dérivation ?","answer":"(u + v)'' = u'' + v''. (k.u)'' = k.u'' (k constante). (u.v)'' = u''.v + u.v'' (produit). (u/v)'' = (u''.v - u.v'')/v2 (quotient). (u^n)'' = n.u''.u^(n-1) (composée). (e^u)'' = u''.e^u. (ln(u))'' = u''/u. (racine(u))'' = u''/(2.racine(u))."},
      {"id":"fc3","category":"Méthode","question":"Comment déterminer l''équation de la tangente en un point ?","answer":"L''équation de la tangente à la courbe de f au point d''abscisse a est : y = f''(a).(x - a) + f(a). La pente est f''(a). Le point de tangence est (a, f(a)). Exemple : f(x) = x2, f''(x) = 2x. En a = 1 : f(1) = 1, f''(1) = 2. Tangente : y = 2(x-1) + 1 = 2x - 1."},
      {"id":"fc4","category":"Concept","question":"Comment utiliser la dérivée pour étudier les variations ?","answer":"Si f''(x) > 0 sur un intervalle, f est strictement croissante. Si f''(x) < 0, f est strictement décroissante. Si f''(x) = 0 en un point et change de signe, c''est un extremum : f''(x) passe de + à - : maximum local. f''(x) passe de - à + : minimum local. On dresse un tableau de signes de f'' puis un tableau de variations de f."},
      {"id":"fc5","category":"Méthode","question":"Comment étudier complètement une fonction ?","answer":"1) Domaine de définition. 2) Limites aux bornes (asymptotes). 3) Dérivée f''(x). 4) Signe de f''(x) et tableau de variations. 5) Valeurs remarquables (extremums, points d''annulation). 6) Tangentes particulières. 7) Position par rapport aux asymptotes. 8) Tracé de la courbe. 9) Éventuellement f''''(x) pour les points d''inflexion."},
      {"id":"fc6","category":"Exemple","question":"Comment résoudre un problème d''optimisation avec la dérivée ?","answer":"Exemple : on veut construire une boîte sans couvercle de volume maximal en découpant des carrés de côté x aux coins d''une feuille de 20 cm x 20 cm. Volume : V(x) = x(20-2x)2. V''(x) = (20-2x)2 + x.2(20-2x)(-2) = (20-2x)(20-6x). V''(x) = 0 quand x = 10/3. V(10/3) = (10/3)(40/3)2 = 592,6 cm3. C''est le volume maximal."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre extremum local et global ?","answer":"Un extremum local (ou relatif) est un maximum ou minimum dans un voisinage du point : f''(a) = 0 et f'' change de signe. Un extremum global (ou absolu) est la plus grande ou plus petite valeur de f sur tout son domaine. Sur un intervalle fermé [a,b], le maximum global est atteint soit en a, soit en b, soit en un point critique intérieur."},
      {"id":"fc8","category":"Formule","question":"Comment dériver une fonction composée ?","answer":"Si f(x) = g(h(x)), alors f''(x) = h''(x) x g''(h(x)). Exemples : (e^(2x))'' = 2.e^(2x). (ln(3x+1))'' = 3/(3x+1). (sin(2x))'' = 2.cos(2x). ((2x+1)^5)'' = 5.2.(2x+1)^4 = 10(2x+1)^4. (racine(x2+1))'' = 2x/(2.racine(x2+1)) = x/racine(x2+1)."}
    ],
    "schema": {
      "title": "Dérivation et applications",
      "nodes": [
        {"id":"n1","label":"Dérivation","type":"main"},
        {"id":"n2","label":"Calcul","type":"branch"},
        {"id":"n3","label":"Applications","type":"branch"},
        {"id":"n4","label":"Formules\nRègles","type":"leaf"},
        {"id":"n5","label":"Tangente\ny=f''(a)(x-a)+f(a)","type":"leaf"},
        {"id":"n6","label":"Variations\nExtremums","type":"leaf"},
        {"id":"n7","label":"Optimisation","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"techniques"},
        {"from":"n1","to":"n3","label":"utilisation"},
        {"from":"n2","to":"n4","label":"dérivées"},
        {"from":"n3","to":"n5","label":"géométrie"},
        {"from":"n3","to":"n6","label":"étude"},
        {"from":"n3","to":"n7","label":"problèmes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La dérivée de f(x) = x3 - 3x + 1 est :","options":["3x2 - 3","3x2 + 1","x2 - 3","3x3 - 3x"],"correct":0,"explanation":"f''(x) = 3x2 - 3. On dérive terme à terme : (x3)'' = 3x2, (-3x)'' = -3, (1)'' = 0."},
      {"id":"q2","question":"La dérivée de e^(3x) est :","options":["3.e^(3x)","e^(3x)","3x.e^(3x-1)","e^3"],"correct":0,"explanation":"C''est une fonction composée : (e^u)'' = u''.e^u avec u = 3x et u'' = 3. Donc (e^(3x))'' = 3.e^(3x)."},
      {"id":"q3","question":"L''équation de la tangente à y = x2 au point x = 2 est :","options":["y = 2x","y = 4x - 4","y = 2x + 4","y = 4x + 4"],"correct":1,"explanation":"f(2) = 4, f''(x) = 2x, f''(2) = 4. Tangente : y = f''(2)(x-2) + f(2) = 4(x-2) + 4 = 4x - 4."},
      {"id":"q4","question":"Si f''(x) > 0 sur ]a,b[, alors f est :","options":["Décroissante sur ]a,b[","Croissante sur ]a,b[","Constante sur ]a,b[","Concave sur ]a,b["],"correct":1,"explanation":"Si la dérivée est positive sur un intervalle, la fonction est strictement croissante sur cet intervalle."},
      {"id":"q5","question":"La dérivée de ln(2x+1) est :","options":["1/(2x+1)","2/(2x+1)","2.ln(2x+1)","1/(2x)"],"correct":1,"explanation":"(ln(u))'' = u''/u. Ici u = 2x+1, u'' = 2. Donc (ln(2x+1))'' = 2/(2x+1)."},
      {"id":"q6","question":"f(x) = x3 - 3x a un maximum local en :","options":["x = 0","x = -1","x = 1","x = 3"],"correct":1,"explanation":"f''(x) = 3x2 - 3 = 3(x-1)(x+1). f''(x) = 0 pour x = -1 et x = 1. f'' passe de + à - en x = -1 : maximum local. f'' passe de - à + en x = 1 : minimum local."},
      {"id":"q7","question":"(u.v)'' = ?","options":["u''.v''","u''.v + u.v''","u''/v + u/v''","(u+v)''"],"correct":1,"explanation":"La dérivée d''un produit est : (u.v)'' = u''.v + u.v''. C''est la formule de Leibniz pour le produit."},
      {"id":"q8","question":"La dérivée de racine(x) est :","options":["1/racine(x)","1/(2.racine(x))","2.racine(x)","racine(x)/2"],"correct":1,"explanation":"(racine(x))'' = (x^(1/2))'' = (1/2).x^(-1/2) = 1/(2.racine(x))."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 4: Primitives et intégration
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'primitives-integration', 4, 'Primitives et intégration', 'Calcul intégral, aire sous la courbe', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'primitives-integration-fiche', 'Primitives et intégration', 'Calcul de primitives et intégrales', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une primitive ?","answer":"F est une primitive de f sur un intervalle I si F''(x) = f(x) pour tout x de I. Si F est une primitive de f, alors toutes les primitives de f sont de la forme F(x) + C, où C est une constante. Exemple : F(x) = x3/3 est une primitive de f(x) = x2. L''ensemble des primitives est x3/3 + C."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les primitives des fonctions usuelles ?","answer":"Primitive de x^n : x^(n+1)/(n+1) + C (n ≠ -1). Primitive de 1/x : ln|x| + C. Primitive de e^x : e^x + C. Primitive de cos(x) : sin(x) + C. Primitive de sin(x) : -cos(x) + C. Primitive de 1/x2 : -1/x + C. Primitive de 1/racine(x) : 2.racine(x) + C. Primitive de e^(ax) : e^(ax)/a + C."},
      {"id":"fc3","category":"Formule","question":"Comment calcule-t-on une intégrale définie ?","answer":"L''intégrale de a à b de f(x)dx = F(b) - F(a), où F est une primitive de f. Notation : [F(x)] de a à b. Exemple : intégrale de 0 à 2 de x2.dx = [x3/3] de 0 à 2 = 8/3 - 0 = 8/3. L''intégrale représente l''aire algébrique entre la courbe et l''axe des x."},
      {"id":"fc4","category":"Concept","question":"Quel est le lien entre intégrale et aire ?","answer":"Si f(x) >= 0 sur [a,b], l''intégrale de a à b de f(x)dx est l''aire entre la courbe, l''axe des x et les droites x=a et x=b. Si f(x) < 0, l''intégrale est négative. L''aire réelle est |intégrale|. Si f change de signe, on découpe l''intervalle et on somme les valeurs absolues. Unité d''aire (u.a.) = produit des unités des axes."},
      {"id":"fc5","category":"Formule","question":"Quelles sont les propriétés de l''intégrale ?","answer":"Linéarité : intégrale de (af + bg) = a.intégrale(f) + b.intégrale(g). Relation de Chasles : intégrale de a à b + intégrale de b à c = intégrale de a à c. Positivité : si f >= 0 sur [a,b], alors intégrale de a à b >= 0. Comparaison : si f <= g sur [a,b], alors intégrale(f) <= intégrale(g). Intégrale de a à a = 0."},
      {"id":"fc6","category":"Méthode","question":"Comment calculer une primitive de u''.f(u) ?","answer":"Si F est une primitive de f, alors une primitive de u''(x).f(u(x)) est F(u(x)) + C. Exemples : primitive de 2x.e^(x2) = e^(x2) + C (car u = x2, u'' = 2x). Primitive de cos(x)/(2.racine(sin(x))) = racine(sin(x)) + C. Primitive de (2x+1)/(x2+x) = ln|x2+x| + C."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la valeur moyenne d''une fonction ?","answer":"La valeur moyenne de f sur [a,b] est mu = (1/(b-a)) x intégrale de a à b de f(x)dx. C''est la hauteur du rectangle de même aire que celle sous la courbe. Exemple : la valeur moyenne de f(x) = x2 sur [0,3] est mu = (1/3) x [x3/3] de 0 à 3 = (1/3) x 9 = 3."},
      {"id":"fc8","category":"Méthode","question":"Comment calculer l''aire entre deux courbes ?","answer":"L''aire entre les courbes de f et g sur [a,b] est : A = intégrale de a à b de |f(x) - g(x)|.dx. Si f(x) >= g(x) sur [a,b] : A = intégrale de a à b de (f(x) - g(x)).dx. Si f et g se croisent, on découpe l''intervalle aux points d''intersection et on somme les aires partielles en valeur absolue."}
    ],
    "schema": {
      "title": "Primitives et intégration",
      "nodes": [
        {"id":"n1","label":"Intégration","type":"main"},
        {"id":"n2","label":"Primitives","type":"branch"},
        {"id":"n3","label":"Intégrales","type":"branch"},
        {"id":"n4","label":"F''=f\nF(x)+C","type":"leaf"},
        {"id":"n5","label":"Formules\nusuelles","type":"leaf"},
        {"id":"n6","label":"Aire sous\nla courbe","type":"leaf"},
        {"id":"n7","label":"Valeur moyenne\nmu=intégrale/(b-a)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"opération inverse"},
        {"from":"n1","to":"n3","label":"calcul d''aire"},
        {"from":"n2","to":"n4","label":"définition"},
        {"from":"n2","to":"n5","label":"tableau"},
        {"from":"n3","to":"n6","label":"géométrie"},
        {"from":"n3","to":"n7","label":"application"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Une primitive de f(x) = 3x2 est :","options":["x3","x3 + C","6x","x3/3"],"correct":1,"explanation":"F(x) = x3 est UNE primitive de 3x2 car (x3)'' = 3x2. Mais toutes les primitives sont de la forme x3 + C."},
      {"id":"q2","question":"L''intégrale de 0 à 1 de 2x.dx = ?","options":["0","1","2","4"],"correct":1,"explanation":"Primitive de 2x : x2. Intégrale = [x2] de 0 à 1 = 12 - 02 = 1."},
      {"id":"q3","question":"Une primitive de e^(2x) est :","options":["e^(2x)","2.e^(2x)","e^(2x)/2","e^(2x) + 2"],"correct":2,"explanation":"Primitive de e^(ax) = e^(ax)/a. Ici a = 2, donc la primitive est e^(2x)/2 + C."},
      {"id":"q4","question":"L''intégrale de 1 à e de (1/x).dx = ?","options":["0","1","e","ln(e) = 1"],"correct":3,"explanation":"Primitive de 1/x : ln(x). Intégrale = [ln(x)] de 1 à e = ln(e) - ln(1) = 1 - 0 = 1."},
      {"id":"q5","question":"Si f(x) >= 0 sur [a,b], l''intégrale de a à b de f(x)dx représente :","options":["La dérivée de f","L''aire sous la courbe","La tangente","Le maximum de f"],"correct":1,"explanation":"Quand f est positive, l''intégrale représente l''aire entre la courbe de f, l''axe des x et les droites verticales x = a et x = b."},
      {"id":"q6","question":"La valeur moyenne de f(x) = 6x sur [0,2] est :","options":["3","6","12","24"],"correct":1,"explanation":"mu = (1/(2-0)) x intégrale de 0 à 2 de 6x.dx = (1/2) x [3x2] de 0 à 2 = (1/2) x 12 = 6."},
      {"id":"q7","question":"Une primitive de cos(x) est :","options":["-sin(x)","sin(x)","cos(x)","1/cos(x)"],"correct":1,"explanation":"(sin(x))'' = cos(x), donc sin(x) est une primitive de cos(x). L''ensemble des primitives : sin(x) + C."},
      {"id":"q8","question":"Intégrale de a à a de f(x)dx = ?","options":["f(a)","1","0","Non défini"],"correct":2,"explanation":"L''intégrale sur un intervalle de longueur nulle est toujours 0 : intégrale de a à a = F(a) - F(a) = 0."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 5: Fonctions logarithme et exponentielle
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'log-exp', 5, 'Fonctions logarithme et exponentielle', 'Propriétés de ln et exp, équations', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'log-exp-fiche', 'Fonctions logarithme et exponentielle', 'Propriétés et applications de ln et exp', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quelles sont les propriétés de la fonction exponentielle ?","answer":"e^0 = 1. e^1 = e = 2,718... e^(a+b) = e^a.e^b. e^(a-b) = e^a/e^b. (e^a)^n = e^(n.a). e^x > 0 pour tout x. (e^x)'' = e^x. La fonction exp est strictement croissante sur R. lim(x->+inf) e^x = +inf. lim(x->-inf) e^x = 0."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les propriétés de la fonction ln ?","answer":"ln(1) = 0. ln(e) = 1. ln(a.b) = ln(a) + ln(b). ln(a/b) = ln(a) - ln(b). ln(a^n) = n.ln(a). ln(1/a) = -ln(a). (ln(x))'' = 1/x. La fonction ln est définie sur ]0,+inf[ et strictement croissante. lim(x->+inf) ln(x) = +inf. lim(x->0+) ln(x) = -inf."},
      {"id":"fc3","category":"Concept","question":"Quelle est la relation entre exp et ln ?","answer":"exp et ln sont des fonctions réciproques : ln(e^x) = x pour tout x réel. e^(ln(x)) = x pour tout x > 0. Si e^a = b, alors a = ln(b). Les courbes de exp et ln sont symétriques par rapport à la droite y = x. Pour résoudre e^x = k : x = ln(k) (si k > 0). Pour résoudre ln(x) = k : x = e^k."},
      {"id":"fc4","category":"Méthode","question":"Comment résoudre des équations avec exp et ln ?","answer":"Type 1 : e^(f(x)) = e^(g(x)) -> f(x) = g(x). Type 2 : e^(f(x)) = k (k>0) -> f(x) = ln(k). Type 3 : ln(f(x)) = ln(g(x)) -> f(x) = g(x) (avec f,g > 0). Type 4 : ln(f(x)) = k -> f(x) = e^k. Attention au domaine de définition de ln : l''argument doit être strictement positif."},
      {"id":"fc5","category":"Formule","question":"Quelles sont les croissances comparées ?","answer":"Quand x -> +inf : e^x domine tout polynôme. lim e^x/x^n = +inf. lim x^n/e^x = 0. ln(x) est dominé par tout polynôme. lim ln(x)/x = 0. lim x/ln(x) = +inf. Quand x -> 0+ : lim x.ln(x) = 0. Ces résultats sont essentiels pour lever les formes indéterminées."},
      {"id":"fc6","category":"Méthode","question":"Comment étudier la fonction f(x) = x.e^(-x) ?","answer":"Domaine : R. Limites : lim(x->+inf) x.e^(-x) = 0 (croissance comparée). lim(x->-inf) x.e^(-x) = -inf. Dérivée : f''(x) = e^(-x) + x.(-e^(-x)) = e^(-x)(1-x). f''(x) = 0 quand x = 1. f''(x) > 0 si x < 1, f''(x) < 0 si x > 1. Maximum en x = 1 : f(1) = 1/e. Asymptote horizontale y = 0 en +inf."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre log décimal et logarithme népérien ?","answer":"Le logarithme népérien ln est de base e : ln(e) = 1. Le logarithme décimal log est de base 10 : log(10) = 1. Relation : log(x) = ln(x)/ln(10) = ln(x)/2,303. En sciences, on utilise surtout ln (dérivée simple : 1/x). En pH, décibels et échelle de Richter, on utilise log. Le changement de base : log_b(x) = ln(x)/ln(b)."},
      {"id":"fc8","category":"Exemple","question":"Comment modélise-t-on une croissance exponentielle ?","answer":"Modèle : f(t) = f(0).e^(k.t). Si k > 0 : croissance exponentielle (population, intérêts composés). Si k < 0 : décroissance exponentielle (radioactivité, décharge d''un condensateur). Le temps de doublement (si k>0) : T = ln(2)/k. Exemple : une population croît de 3% par an. k = ln(1,03) = 0,0296. T = ln(2)/0,0296 = 23,4 ans pour doubler."}
    ],
    "schema": {
      "title": "Fonctions logarithme et exponentielle",
      "nodes": [
        {"id":"n1","label":"ln et exp","type":"main"},
        {"id":"n2","label":"Exponentielle\ne^x","type":"branch"},
        {"id":"n3","label":"Logarithme\nln(x)","type":"branch"},
        {"id":"n4","label":"e^(a+b)=e^a.e^b\n(e^x)''=e^x","type":"leaf"},
        {"id":"n5","label":"ln(ab)=ln(a)+ln(b)\n(ln(x))''=1/x","type":"leaf"},
        {"id":"n6","label":"Fonctions\nréciproques","type":"leaf"},
        {"id":"n7","label":"Croissances\ncomparées","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"R -> R+*"},
        {"from":"n1","to":"n3","label":"R+* -> R"},
        {"from":"n2","to":"n4","label":"propriétés"},
        {"from":"n3","to":"n5","label":"propriétés"},
        {"from":"n2","to":"n6","label":"ln(e^x)=x"},
        {"from":"n3","to":"n7","label":"limites"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"ln(e^3) = ?","options":["e^3","3","1/3","e"],"correct":1,"explanation":"ln et exp sont des fonctions réciproques : ln(e^x) = x. Donc ln(e^3) = 3."},
      {"id":"q2","question":"e^(ln(5)) = ?","options":["5","ln(5)","e^5","1"],"correct":0,"explanation":"e^(ln(x)) = x pour tout x > 0. Donc e^(ln(5)) = 5."},
      {"id":"q3","question":"ln(a.b) = ?","options":["ln(a).ln(b)","ln(a) + ln(b)","ln(a) - ln(b)","ln(a)/ln(b)"],"correct":1,"explanation":"La propriété fondamentale du logarithme : le logarithme d''un produit est la somme des logarithmes : ln(a.b) = ln(a) + ln(b)."},
      {"id":"q4","question":"La dérivée de e^(2x+1) est :","options":["e^(2x+1)","2.e^(2x+1)","(2x+1).e^(2x)","e^2"],"correct":1,"explanation":"(e^u)'' = u''.e^u. Avec u = 2x+1, u'' = 2. Donc (e^(2x+1))'' = 2.e^(2x+1)."},
      {"id":"q5","question":"lim(x->+inf) e^x / x^3 = ?","options":["0","1","3","+infini"],"correct":3,"explanation":"Par les croissances comparées, e^x l''emporte sur tout polynôme quand x -> +inf. Donc lim e^x/x^3 = +inf."},
      {"id":"q6","question":"La solution de e^(2x) = 7 est :","options":["x = 7/2","x = ln(7)/2","x = e^(7/2)","x = 2.ln(7)"],"correct":1,"explanation":"e^(2x) = 7. On prend le ln : 2x = ln(7). Donc x = ln(7)/2."},
      {"id":"q7","question":"lim(x->0+) x.ln(x) = ?","options":["-infini","0","+infini","1"],"correct":1,"explanation":"C''est une forme indéterminée 0 x (-inf). Par les croissances comparées, lim(x->0+) x.ln(x) = 0. Le x qui tend vers 0 l''emporte sur le ln(x) qui tend vers -inf."},
      {"id":"q8","question":"La fonction f(x) = ln(x) est définie sur :","options":["R","R+","R+* = ]0,+inf[","R-"],"correct":2,"explanation":"Le logarithme népérien n''est défini que pour x strictement positif : son domaine est ]0,+inf[ = R+*. ln(0) et ln(négatif) n''existent pas."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 6: Statistiques et probabilités
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'stats-proba', 6, 'Statistiques et probabilités', 'Dénombrement, probabilités, lois', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'stats-proba-fiche', 'Statistiques et probabilités', 'Dénombrement, probabilités et lois de probabilité', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"Quelles sont les formules de dénombrement ?","answer":"Arrangements : A(n,p) = n!/(n-p)! (ordre compte, sans répétition). Permutations : P(n) = n! (arrangement de n parmi n). Combinaisons : C(n,p) = n!/(p!(n-p)!) (ordre ne compte pas). n! = n x (n-1) x ... x 2 x 1. 0! = 1. Exemple : C(5,2) = 5!/(2!.3!) = 10."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce qu''une probabilité ?","answer":"La probabilité d''un événement A est un nombre P(A) entre 0 et 1. P(certain) = 1, P(impossible) = 0. P(A union B) = P(A) + P(B) - P(A inter B). Si A et B sont incompatibles : P(A union B) = P(A) + P(B). P(contraire de A) = 1 - P(A). Dans une situation d''équiprobabilité : P(A) = nombre de cas favorables / nombre de cas possibles."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la probabilité conditionnelle ?","answer":"P(A|B) = P(A inter B)/P(B) est la probabilité de A sachant que B est réalisé. Formule des probabilités totales : si B1, B2, ..., Bn forment une partition, alors P(A) = somme P(A|Bi).P(Bi). Formule de Bayes : P(Bi|A) = P(A|Bi).P(Bi) / P(A). Indépendance : A et B sont indépendants si P(A inter B) = P(A).P(B), soit P(A|B) = P(A)."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''une variable aléatoire et son espérance ?","answer":"Une variable aléatoire X associe un nombre réel à chaque issue de l''expérience. La loi de X est la donnée de toutes les valeurs xi et leurs probabilités P(X=xi). L''espérance : E(X) = somme xi.P(X=xi). La variance : V(X) = E(X2) - (E(X))2 = somme (xi-E(X))2.P(X=xi). L''écart-type : sigma = racine(V(X))."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que la loi binomiale ?","answer":"On répète n fois une épreuve de Bernoulli de paramètre p (probabilité de succès). X = nombre de succès suit la loi binomiale B(n,p). P(X=k) = C(n,k).p^k.(1-p)^(n-k). E(X) = n.p. V(X) = n.p.(1-p). Exemple : on lance 10 fois un dé, X = nombre de 6 obtenus. X suit B(10, 1/6)."},
      {"id":"fc6","category":"Méthode","question":"Comment construire un arbre de probabilité ?","answer":"1) Chaque branche représente une issue possible avec sa probabilité. 2) La somme des probabilités des branches partant d''un même noeud est 1. 3) La probabilité d''un chemin = produit des probabilités le long du chemin. 4) La probabilité d''un événement = somme des probabilités des chemins qui y mènent. L''arbre aide à visualiser les probabilités conditionnelles."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la loi des grands nombres ?","answer":"La loi des grands nombres dit que quand le nombre d''expériences n augmente, la fréquence observée d''un événement converge vers sa probabilité théorique. Plus n est grand, plus f(n) est proche de p. C''est le fondement de l''estimation statistique. Exemple : en lançant un dé un grand nombre de fois, la fréquence de chaque face tend vers 1/6."},
      {"id":"fc8","category":"Exemple","question":"Comment calculer la moyenne et l''écart-type d''une série statistique ?","answer":"Moyenne : x_barre = (somme xi.ni) / N, où ni est l''effectif et N l''effectif total. Variance : V = (somme ni.(xi - x_barre)2) / N. Écart-type : sigma = racine(V). Exemple : notes 8, 10, 12, 14, 16 avec effectifs 2, 5, 8, 4, 1. N = 20. Moyenne = (16+50+96+56+16)/20 = 234/20 = 11,7."}
    ],
    "schema": {
      "title": "Statistiques et probabilités",
      "nodes": [
        {"id":"n1","label":"Probabilités\net statistiques","type":"main"},
        {"id":"n2","label":"Dénombrement","type":"branch"},
        {"id":"n3","label":"Probabilités","type":"branch"},
        {"id":"n4","label":"Variables\naléatoires","type":"branch"},
        {"id":"n5","label":"Arrangements\nCombinaisons","type":"leaf"},
        {"id":"n6","label":"Conditionnelle\nBayes","type":"leaf"},
        {"id":"n7","label":"Loi binomiale\nE(X), V(X)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"compter"},
        {"from":"n1","to":"n3","label":"modéliser"},
        {"from":"n1","to":"n4","label":"quantifier"},
        {"from":"n2","to":"n5","label":"formules"},
        {"from":"n3","to":"n6","label":"conditionnement"},
        {"from":"n4","to":"n7","label":"lois"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"C(6,2) = ?","options":["12","15","30","720"],"correct":1,"explanation":"C(6,2) = 6!/(2!.4!) = (6x5)/(2x1) = 30/2 = 15. C''est le nombre de façons de choisir 2 éléments parmi 6 sans tenir compte de l''ordre."},
      {"id":"q2","question":"La probabilité d''obtenir un 6 en lançant un dé équilibré est :","options":["1/2","1/3","1/6","1/12"],"correct":2,"explanation":"Un dé a 6 faces équiprobables. P(6) = 1 cas favorable / 6 cas possibles = 1/6."},
      {"id":"q3","question":"Si X suit B(10, 0,3), E(X) = ?","options":["0,3","3","7","30"],"correct":1,"explanation":"Pour une loi binomiale B(n,p) : E(X) = n.p = 10 x 0,3 = 3."},
      {"id":"q4","question":"P(contraire de A) = ?","options":["P(A)","1 + P(A)","1 - P(A)","P(A)/2"],"correct":2,"explanation":"La probabilité de l''événement contraire est P(A barre) = 1 - P(A). C''est souvent utile quand il est plus simple de calculer P(contraire)."},
      {"id":"q5","question":"5! = ?","options":["5","25","60","120"],"correct":3,"explanation":"5! = 5 x 4 x 3 x 2 x 1 = 120. La factorielle de n est le produit de tous les entiers de 1 à n."},
      {"id":"q6","question":"A et B sont indépendants si :","options":["P(A inter B) = 0","P(A inter B) = P(A).P(B)","P(A union B) = 1","P(A) = P(B)"],"correct":1,"explanation":"Deux événements sont indépendants si la réalisation de l''un n''influence pas la probabilité de l''autre : P(A inter B) = P(A).P(B), ce qui équivaut à P(A|B) = P(A)."},
      {"id":"q7","question":"La variance d''une loi binomiale B(n,p) est :","options":["n.p","n.p2","n.p.(1-p)","(n.p)2"],"correct":2,"explanation":"Pour X suivant B(n,p) : V(X) = n.p.(1-p). L''écart-type est sigma = racine(n.p.(1-p))."},
      {"id":"q8","question":"La moyenne de la série 4, 6, 8, 10, 12 est :","options":["6","8","10","40"],"correct":1,"explanation":"Moyenne = (4+6+8+10+12)/5 = 40/5 = 8."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - CHAPTER 1: La conscience et la connaissance
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'conscience-connaissance', 1, 'La conscience et la connaissance', 'Conscience de soi, perception, connaissance', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'conscience-connaissance-fiche', 'La conscience et la connaissance', 'Conscience, perception et accès au savoir', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la conscience ?","answer":"La conscience est la faculté par laquelle l''homme se connaît lui-même et connaît le monde extérieur. Conscience spontanée : perception immédiate du monde. Conscience réfléchie : retour sur soi-même, capacité de se penser en train de penser. Descartes : ''Je pense, donc je suis'' (Cogito) - la conscience est la première certitude. La conscience fait de l''homme un sujet pensant."},
      {"id":"fc2","category":"Concept","question":"Qu''est-ce que l''inconscient selon Freud ?","answer":"L''inconscient est la partie de la vie psychique qui échappe à la conscience. Freud distingue trois instances : le Ça (pulsions, désirs refoulés), le Moi (médiateur avec la réalité) et le Surmoi (intériorisation des interdits sociaux). Les rêves, lapsus et actes manqués sont des manifestations de l''inconscient. L''inconscient remet en question la maîtrise totale du sujet sur lui-même."},
      {"id":"fc3","category":"Distinction","question":"Quelle différence entre connaissance sensible et connaissance rationnelle ?","answer":"La connaissance sensible (empirisme) vient des sens et de l''expérience. Elle est particulière et subjective. L''empirisme (Locke, Hume) affirme que toute connaissance vient de l''expérience. La connaissance rationnelle (rationalisme) vient de la raison. Elle est universelle et nécessaire. Le rationalisme (Platon, Descartes) affirme que la raison seule atteint la vérité. Kant propose une synthèse : la connaissance nécessite les sens ET la raison."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que le Cogito de Descartes ?","answer":"Le Cogito (''Je pense, donc je suis'') est le résultat du doute méthodique de Descartes. En doutant de tout (sens trompeurs, monde peut-être illusoire), Descartes découvre qu''il ne peut douter qu''il doute, donc qu''il pense, donc qu''il existe comme être pensant. Le Cogito est la première certitude indubitable, le fondement de toute connaissance. La conscience est ainsi la base du savoir."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre opinion et savoir ?","answer":"L''opinion (doxa) est une croyance subjective, non fondée rationnellement. Elle peut être vraie ou fausse par hasard. Le savoir (épistémè) est une connaissance justifiée, fondée sur des preuves ou des démonstrations. Platon distingue l''opinion du savoir par l''allégorie de la caverne : l''opinion est comme les ombres, le savoir est la lumière du soleil (les Idées). Le passage de l''opinion au savoir nécessite l''éducation philosophique."},
      {"id":"fc6","category":"Méthode","question":"Qu''est-ce que le doute méthodique ?","answer":"Le doute méthodique est la démarche de Descartes qui consiste à rejeter provisoirement comme faux tout ce qui peut être mis en doute. Il est différent du doute sceptique (qui doute pour douter) car il vise à trouver une certitude absolue. Étapes : 1) Douter des sens (illusions). 2) Douter du monde (hypothèse du rêve). 3) Douter des vérités mathématiques (hypothèse du malin génie). 4) Découverte du Cogito."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que l''allégorie de la caverne de Platon ?","answer":"Dans la République, Platon décrit des prisonniers enchaînés dans une caverne qui ne voient que des ombres projetées sur le mur. Ils prennent ces ombres pour la réalité. Un prisonnier libéré sort et découvre le monde réel, éclairé par le soleil (le Bien). Signification : les ombres = opinions, apparences. Le monde extérieur = monde des Idées, vérité. Le soleil = le Bien suprême. L''éducation = libération de l''ignorance."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que la perception ?","answer":"La perception est la saisie du monde extérieur par les sens (vue, ouïe, toucher, goût, odorat). Elle n''est pas passive : le sujet interprète et organise les données sensorielles. Merleau-Ponty : la perception est un acte corporel, le corps est notre moyen d''être au monde. Les illusions d''optique montrent que la perception peut être trompeuse. La perception est toujours une perspective partielle sur le réel."}
    ],
    "schema": {
      "title": "La conscience et la connaissance",
      "nodes": [
        {"id":"n1","label":"Conscience\net connaissance","type":"main"},
        {"id":"n2","label":"Conscience","type":"branch"},
        {"id":"n3","label":"Connaissance","type":"branch"},
        {"id":"n4","label":"Cogito\n(Descartes)","type":"leaf"},
        {"id":"n5","label":"Inconscient\n(Freud)","type":"leaf"},
        {"id":"n6","label":"Sensible\n(empirisme)","type":"leaf"},
        {"id":"n7","label":"Rationnelle\n(rationalisme)","type":"leaf"},
        {"id":"n8","label":"Caverne\n(Platon)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"sujet"},
        {"from":"n1","to":"n3","label":"objet"},
        {"from":"n2","to":"n4","label":"certitude"},
        {"from":"n2","to":"n5","label":"limites"},
        {"from":"n3","to":"n6","label":"expérience"},
        {"from":"n3","to":"n7","label":"raison"},
        {"from":"n3","to":"n8","label":"vérité"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Qui a formulé le ''Je pense, donc je suis'' ?","options":["Platon","Aristote","Descartes","Kant"],"correct":2,"explanation":"Le Cogito (''Je pense, donc je suis'', Cogito ergo sum) est de René Descartes, dans les Méditations métaphysiques (1641). C''est la première certitude obtenue après le doute méthodique."},
      {"id":"q2","question":"Selon Freud, le Ça représente :","options":["La conscience morale","Les pulsions et désirs inconscients","Le médiateur avec la réalité","La mémoire"],"correct":1,"explanation":"Le Ça est le réservoir des pulsions, désirs et instincts inconscients. Il fonctionne selon le principe de plaisir, sans tenir compte de la réalité ni de la morale."},
      {"id":"q3","question":"L''allégorie de la caverne illustre le passage de :","options":["La vie à la mort","L''opinion à la connaissance vraie","La science à la religion","La liberté à l''esclavage"],"correct":1,"explanation":"L''allégorie de la caverne de Platon illustre le passage de l''ignorance (les ombres = opinions) à la connaissance vraie (le monde réel = les Idées), grâce à l''éducation philosophique."},
      {"id":"q4","question":"L''empirisme soutient que la connaissance vient principalement :","options":["De la raison pure","De l''expérience sensorielle","De l''intuition","De la révélation divine"],"correct":1,"explanation":"L''empirisme (Locke, Hume) affirme que toute connaissance provient de l''expérience sensorielle. L''esprit est une ''table rase'' (tabula rasa) à la naissance, qui se remplit par l''expérience."},
      {"id":"q5","question":"Le doute méthodique de Descartes est :","options":["Un doute définitif","Un doute utilisé comme outil pour trouver la certitude","Un refus de toute connaissance","Un doute religieux"],"correct":1,"explanation":"Le doute méthodique est provisoire et constructif : Descartes doute pour trouver une certitude absolue. Il n''est pas sceptique (qui doute pour douter) mais cherche un fondement solide pour la connaissance."},
      {"id":"q6","question":"Le Surmoi selon Freud représente :","options":["Les pulsions inconscientes","L''intériorisation des interdits moraux et sociaux","Le principe de plaisir","La conscience perceptive"],"correct":1,"explanation":"Le Surmoi est l''instance psychique qui intériorise les interdits parentaux et sociaux. Il joue le rôle de censeur moral et génère la culpabilité quand les pulsions du Ça ne sont pas conformes aux normes."},
      {"id":"q7","question":"Selon Kant, la connaissance nécessite :","options":["Uniquement la raison","Uniquement l''expérience","La raison ET l''expérience","Ni la raison ni l''expérience"],"correct":2,"explanation":"Kant fait la synthèse entre rationalisme et empirisme : ''Les concepts sans intuitions sont vides, les intuitions sans concepts sont aveugles.'' La connaissance nécessite à la fois les données des sens et les catégories de l''entendement."},
      {"id":"q8","question":"La conscience réfléchie est :","options":["La perception immédiate du monde","La capacité de se penser soi-même en train de penser","Le réflexe nerveux","La mémoire à court terme"],"correct":1,"explanation":"La conscience réfléchie est le retour de la pensée sur elle-même : le sujet se prend lui-même comme objet de pensée. C''est ce qui distingue l''homme de l''animal selon de nombreux philosophes."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - CHAPTER 2: La science et la vérité
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'science-verite', 2, 'La science et la vérité', 'Méthode scientifique, critères de vérité', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'science-verite-fiche', 'La science et la vérité', 'Démarche scientifique et recherche de la vérité', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la vérité ?","answer":"La vérité est la conformité de la pensée ou du discours avec la réalité. Conceptions : 1) Vérité-correspondance (Aristote) : une proposition est vraie si elle correspond aux faits. 2) Vérité-cohérence : une proposition est vraie si elle est logiquement cohérente avec d''autres vérités. 3) Vérité-consensus (pragmatisme) : est vrai ce qui fait l''objet d''un accord rationnel. La vérité est universelle et nécessaire."},
      {"id":"fc2","category":"Méthode","question":"Quelles sont les étapes de la démarche scientifique ?","answer":"1) Observation d''un phénomène. 2) Formulation d''une hypothèse explicative. 3) Expérimentation pour tester l''hypothèse (variables contrôlées). 4) Analyse des résultats. 5) Conclusion : l''hypothèse est confirmée ou réfutée. 6) Publication et vérification par d''autres chercheurs (reproductibilité). Claude Bernard : ''L''expérience est le seul juge de la vérité scientifique.''"},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la falsifiabilité selon Popper ?","answer":"Karl Popper propose que le critère de scientificité est la falsifiabilité (réfutabilité) : une théorie est scientifique si elle peut être réfutée par l''expérience. Une théorie non falsifiable (ex : astrologie) n''est pas scientifique. La science progresse par conjectures et réfutations. Une théorie scientifique est provisoire : elle est acceptée tant qu''elle n''est pas réfutée."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre science et opinion ?","answer":"L''opinion est subjective, non vérifiable, variable selon les individus. La science est objective, vérifiable par l''expérience, universelle. Bachelard : ''L''opinion a, en droit, toujours tort.'' La science se construit contre l''opinion en surmontant les obstacles épistémologiques (expérience première, connaissance générale, animisme). Le savoir scientifique est critique et méthodique."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce qu''un paradigme selon Kuhn ?","answer":"Thomas Kuhn définit un paradigme comme un ensemble de théories, méthodes et valeurs partagées par une communauté scientifique à une époque donnée. La science normale fonctionne dans un paradigme. Quand les anomalies s''accumulent, une révolution scientifique change le paradigme. Exemple : passage de la physique de Newton à la relativité d''Einstein. Les paradigmes sont incommensurables."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre croire et savoir ?","answer":"Croire : adhérer à une proposition sans preuve suffisante (foi, opinion). Le croyant peut avoir tort. Savoir : adhérer à une proposition avec des justifications rationnelles ou empiriques. Le savoir exige des preuves. Platon : le savoir est une croyance vraie justifiée. Cependant, la certitude absolue est difficile à atteindre, et la frontière entre croire et savoir peut être floue."},
      {"id":"fc7","category":"Concept","question":"La science peut-elle tout expliquer ?","answer":"La science explique les phénomènes naturels par des lois et des causes. Mais elle a des limites : 1) Les questions métaphysiques (Dieu, le sens de la vie) dépassent la science. 2) Les questions éthiques (le bien et le mal) ne sont pas scientifiques. 3) La science est toujours provisoire (révisable). 4) Le réductionnisme scientifique ne saisit pas la totalité du réel. La philosophie complète la science en posant les questions de sens."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce qu''un obstacle épistémologique selon Bachelard ?","answer":"Un obstacle épistémologique est un blocage mental qui empêche le progrès de la connaissance. Bachelard en identifie plusieurs : 1) L''expérience première (croire ce qu''on voit). 2) La connaissance générale (généraliser trop vite). 3) L''obstacle verbal (le mot masque le concept). 4) L''animisme (attribuer une intention à la nature). La science progresse en surmontant ces obstacles par la rupture épistémologique."}
    ],
    "schema": {
      "title": "La science et la vérité",
      "nodes": [
        {"id":"n1","label":"Science\net vérité","type":"main"},
        {"id":"n2","label":"Vérité","type":"branch"},
        {"id":"n3","label":"Science","type":"branch"},
        {"id":"n4","label":"Correspondance\nCohérence","type":"leaf"},
        {"id":"n5","label":"Méthode\nexpérimentale","type":"leaf"},
        {"id":"n6","label":"Falsifiabilité\n(Popper)","type":"leaf"},
        {"id":"n7","label":"Paradigmes\n(Kuhn)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"qu''est-ce ?"},
        {"from":"n1","to":"n3","label":"comment ?"},
        {"from":"n2","to":"n4","label":"critères"},
        {"from":"n3","to":"n5","label":"démarche"},
        {"from":"n3","to":"n6","label":"critère"},
        {"from":"n3","to":"n7","label":"révolutions"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Selon Popper, une théorie scientifique doit être :","options":["Vérifiable","Falsifiable (réfutable)","Certaine","Irréfutable"],"correct":1,"explanation":"Popper affirme qu''une théorie est scientifique si et seulement si elle est falsifiable, c''est-à-dire qu''il existe une expérience qui pourrait la réfuter. Une théorie irréfutable n''est pas scientifique."},
      {"id":"q2","question":"Bachelard dit que ''l''opinion a, en droit, toujours tort'' car :","options":["L''opinion est toujours fausse","La science se construit contre l''opinion","L''opinion est plus fiable que la science","L''opinion et la science sont identiques"],"correct":1,"explanation":"Pour Bachelard, la science se construit contre l''opinion en surmontant les obstacles épistémologiques. L''opinion n''est pas un savoir car elle n''est pas fondée sur une méthode rigoureuse."},
      {"id":"q3","question":"La vérité-correspondance signifie :","options":["La vérité est relative","La vérité correspond à la réalité des faits","La vérité est une convention sociale","La vérité change avec le temps"],"correct":1,"explanation":"La théorie de la vérité-correspondance (Aristote) affirme qu''une proposition est vraie si et seulement si elle correspond aux faits, à la réalité."},
      {"id":"q4","question":"Un paradigme selon Kuhn est :","options":["Une erreur scientifique","Un ensemble de théories et méthodes partagées par une communauté scientifique","Une loi physique","Un instrument de mesure"],"correct":1,"explanation":"Un paradigme est le cadre théorique et méthodologique accepté par la communauté scientifique à une époque. La science normale fonctionne à l''intérieur d''un paradigme."},
      {"id":"q5","question":"La première étape de la démarche scientifique est :","options":["L''expérimentation","La publication","L''observation","La conclusion"],"correct":2,"explanation":"La démarche scientifique commence par l''observation d''un phénomène, suivie de la formulation d''une hypothèse, puis de l''expérimentation, de l''analyse et de la conclusion."},
      {"id":"q6","question":"Selon Claude Bernard, le juge de la vérité scientifique est :","options":["La raison pure","L''autorité","L''expérience","L''opinion publique"],"correct":2,"explanation":"Claude Bernard affirme que ''l''expérience est le seul juge de la vérité scientifique''. C''est l''expérimentation qui confirme ou réfute les hypothèses."},
      {"id":"q7","question":"Un obstacle épistémologique selon Bachelard est :","options":["Un problème technique","Un blocage mental qui empêche le progrès","Un manque de financement","Une erreur de calcul"],"correct":1,"explanation":"Un obstacle épistémologique est un blocage mental (préjugé, habitude de pensée) qui empêche la progression de la connaissance scientifique. Il faut le surmonter par une rupture épistémologique."},
      {"id":"q8","question":"La science peut-elle répondre à la question ''Dieu existe-t-il ?'' :","options":["Oui, par l''expérience","Non, c''est une question métaphysique","Oui, par les mathématiques","Oui, par la logique"],"correct":1,"explanation":"L''existence de Dieu est une question métaphysique qui dépasse le champ de la science. La science étudie les phénomènes naturels observables et mesurables, pas les questions métaphysiques."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - CHAPTER 3: La liberté et la responsabilité
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'liberte-responsabilite', 3, 'La liberté et la responsabilité', 'Libre arbitre, déterminisme, engagement', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'liberte-responsabilite-fiche', 'La liberté et la responsabilité', 'Libre arbitre, déterminisme et responsabilité morale', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la liberté ?","answer":"La liberté est la capacité d''agir selon sa propre volonté, sans contrainte extérieure. Liberté d''action : absence d''obstacles physiques. Liberté de pensée : capacité de penser par soi-même. Libre arbitre : capacité de choisir entre plusieurs possibilités. Liberté politique : droits et libertés garantis par la loi. Sartre : ''L''homme est condamné à être libre'' - la liberté est une condition de l''existence humaine."},
      {"id":"fc2","category":"Distinction","question":"Quelle différence entre liberté et déterminisme ?","answer":"Le déterminisme affirme que tout événement est causé par des événements antérieurs selon des lois nécessaires. Si tout est déterminé, le libre arbitre est une illusion. Le libertarisme philosophique affirme que l''homme a un véritable libre arbitre. Le compatibilisme (Spinoza, Hume) tente de concilier les deux : être libre, c''est agir selon sa nature propre sans contrainte extérieure, même si nos actions ont des causes."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la responsabilité morale ?","answer":"La responsabilité suppose la liberté : on ne peut être responsable que de ce qu''on a librement choisi. Si le déterminisme est total, personne n''est responsable. Sartre : nous sommes entièrement responsables de nos choix car nous sommes libres. La responsabilité implique d''assumer les conséquences de ses actes. Elle est le fondement de la morale et du droit (la sanction suppose la responsabilité)."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que l''existentialisme de Sartre ?","answer":"L''existentialisme affirme que ''l''existence précède l''essence'' : l''homme n''a pas de nature prédéfinie, il se définit par ses choix et ses actes. L''homme est ''condamné à être libre'' : il ne peut pas ne pas choisir (ne pas choisir est encore un choix). La mauvaise foi consiste à nier sa liberté en invoquant des excuses (la nature, la société, les circonstances). L''engagement est l''expression de la liberté."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre liberté naturelle et liberté civile ?","answer":"Liberté naturelle (Rousseau) : état de nature, liberté illimitée mais précaire. Chacun fait ce qu''il veut mais le plus fort domine. Liberté civile : liberté encadrée par les lois dans la société. On renonce à la liberté naturelle pour gagner la sécurité et les droits. Le contrat social (Rousseau) : les citoyens acceptent de limiter leur liberté pour le bien commun. La loi est l''expression de la volonté générale."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que l''autonomie selon Kant ?","answer":"L''autonomie est la capacité de se donner à soi-même sa propre loi morale. Être autonome, c''est agir selon la raison et non selon ses inclinations. L''impératif catégorique de Kant : ''Agis uniquement d''après la maxime qui fait que tu puisses vouloir en même temps qu''elle devienne une loi universelle.'' L''autonomie s''oppose à l''hétéronomie (être déterminé par des causes extérieures : passions, habitudes, autorité)."},
      {"id":"fc7","category":"Exemple","question":"La liberté d''expression a-t-elle des limites ?","answer":"La liberté d''expression est un droit fondamental mais elle a des limites : elle ne doit pas porter atteinte à la dignité, à l''honneur ou à la vie privée d''autrui. L''incitation à la haine, la diffamation et l''apologie du terrorisme sont interdites. Mill : la liberté de chacun s''arrête là où commence celle d''autrui. La censure est un abus, mais la responsabilité dans l''usage de la parole est nécessaire."},
      {"id":"fc8","category":"Concept","question":"Qu''est-ce que l''aliénation ?","answer":"L''aliénation est la perte de liberté d''un individu qui devient étranger à lui-même. Marx : l''aliénation du travailleur dans le capitalisme (le travailleur ne possède ni son travail ni son produit). Hegel : l''aliénation est un moment nécessaire de la conscience. Au Mali, la pauvreté, l''ignorance et les pesanteurs sociales peuvent être des formes d''aliénation qui limitent la liberté effective des individus."}
    ],
    "schema": {
      "title": "La liberté et la responsabilité",
      "nodes": [
        {"id":"n1","label":"Liberté et\nresponsabilité","type":"main"},
        {"id":"n2","label":"Liberté","type":"branch"},
        {"id":"n3","label":"Responsabilité","type":"branch"},
        {"id":"n4","label":"Libre arbitre\nvs Déterminisme","type":"leaf"},
        {"id":"n5","label":"Existentialisme\n(Sartre)","type":"leaf"},
        {"id":"n6","label":"Autonomie\n(Kant)","type":"leaf"},
        {"id":"n7","label":"Contrat social\n(Rousseau)","type":"leaf"},
        {"id":"n8","label":"Morale\nEngagement","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"condition"},
        {"from":"n1","to":"n3","label":"conséquence"},
        {"from":"n2","to":"n4","label":"débat"},
        {"from":"n2","to":"n5","label":"existence"},
        {"from":"n2","to":"n6","label":"morale"},
        {"from":"n2","to":"n7","label":"politique"},
        {"from":"n3","to":"n8","label":"engagement"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Sartre affirme que ''l''homme est condamné à être libre''. Cela signifie :","options":["L''homme peut refuser d''être libre","L''homme est toujours libre, il ne peut pas échapper à sa liberté","La liberté est une punition","L''homme n''est libre que parfois"],"correct":1,"explanation":"Pour Sartre, la liberté est constitutive de l''être humain. Même ne pas choisir est un choix. L''homme ne peut pas ne pas être libre, d''où le terme ''condamné''."},
      {"id":"q2","question":"Le contrat social de Rousseau implique :","options":["L''abandon de toute liberté","L''échange de la liberté naturelle contre la liberté civile","Le retour à l''état de nature","La domination du plus fort"],"correct":1,"explanation":"Le contrat social suppose que les individus renoncent à leur liberté naturelle (illimitée mais précaire) pour gagner la liberté civile (encadrée par les lois mais garantie)."},
      {"id":"q3","question":"L''autonomie selon Kant signifie :","options":["Faire ce qu''on veut","Obéir à l''autorité","Se donner à soi-même sa propre loi morale","Suivre ses passions"],"correct":2,"explanation":"L''autonomie kantienne est la capacité de se donner sa propre loi morale par la raison. Elle s''oppose à l''hétéronomie (être déterminé par des causes extérieures)."},
      {"id":"q4","question":"Le déterminisme affirme que :","options":["L''homme est totalement libre","Tout événement est causé par des événements antérieurs","La liberté est absolue","Le hasard gouverne tout"],"correct":1,"explanation":"Le déterminisme soutient que tout événement, y compris les actions humaines, est le résultat nécessaire de causes antérieures. Si le déterminisme est total, le libre arbitre serait une illusion."},
      {"id":"q5","question":"La mauvaise foi selon Sartre consiste à :","options":["Mentir aux autres","Nier sa propre liberté en invoquant des excuses","Être hypocrite","Avoir de mauvaises intentions"],"correct":1,"explanation":"La mauvaise foi est l''attitude qui consiste à nier sa liberté et sa responsabilité en se cachant derrière des excuses (''c''est ma nature'', ''je n''avais pas le choix'', ''c''est la société'')."},
      {"id":"q6","question":"La responsabilité suppose :","options":["L''obéissance aveugle","La liberté de choix","La contrainte extérieure","L''absence de conscience"],"correct":1,"explanation":"On ne peut être tenu responsable que de ce qu''on a librement choisi. Sans liberté, pas de responsabilité. C''est pourquoi le droit ne punit pas les personnes jugées irresponsables."},
      {"id":"q7","question":"''L''existence précède l''essence'' signifie :","options":["L''homme a une nature fixe","L''homme se définit par ses choix et ses actes","L''essence est plus importante que l''existence","L''homme est déterminé par sa nature"],"correct":1,"explanation":"Formule clé de l''existentialisme : l''homme n''a pas de nature prédéfinie. Il existe d''abord, puis se définit par ses choix, ses projets et ses actes. Il est ce qu''il se fait."},
      {"id":"q8","question":"L''aliénation du travailleur selon Marx est due à :","options":["La paresse","Le fait qu''il ne possède ni son travail ni son produit","Le manque de formation","La nature du travail"],"correct":1,"explanation":"Marx analyse l''aliénation du travailleur dans le capitalisme : le travailleur est séparé du produit de son travail, du processus de production, de sa propre humanité et des autres travailleurs."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - CHAPTER 4: Étude d'œuvres de penseurs
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'etude-oeuvres-penseurs', 4, 'Étude d''œuvres de penseurs', 'Platon, Descartes, Rousseau, Sartre', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'etude-oeuvres-penseurs-fiche', 'Étude d''œuvres de penseurs', 'Grandes œuvres philosophiques au programme', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Concept","question":"Quelles sont les idées principales du Discours de la méthode de Descartes ?","answer":"Publié en 1637, le Discours propose une méthode pour bien conduire sa raison. Les 4 règles : 1) Évidence : n''accepter que ce qui est clair et distinct. 2) Analyse : diviser les problèmes en parties simples. 3) Synthèse : reconstruire du simple au complexe. 4) Dénombrement : vérifier l''exhaustivité. Le doute méthodique mène au Cogito. Dualisme corps/esprit : l''âme (pensée) est distincte du corps (étendue)."},
      {"id":"fc2","category":"Concept","question":"Quelles sont les idées principales du Contrat social de Rousseau ?","answer":"Publié en 1762, le Contrat social propose un modèle de société juste. ''L''homme est né libre, et partout il est dans les fers.'' Solution : le contrat social où chacun aliène sa liberté naturelle à la communauté pour recevoir la liberté civile. La souveraineté appartient au peuple (volonté générale). La loi est l''expression de la volonté générale. Rousseau influence la Révolution française et la démocratie moderne."},
      {"id":"fc3","category":"Concept","question":"Quelles sont les idées principales de la République de Platon ?","answer":"La République (vers 380 av. J.-C.) propose un modèle de cité idéale. La justice est l''harmonie des trois parties de l''âme : raison (sagesse), courage (thymos), désirs (tempérance). La cité juste a trois classes : philosophes-rois (dirigent par la sagesse), gardiens (défendent par le courage), producteurs (fournissent avec tempérance). L''allégorie de la caverne illustre l''accès à la vérité par l''éducation philosophique."},
      {"id":"fc4","category":"Concept","question":"Quelles sont les idées principales de L''existentialisme est un humanisme de Sartre ?","answer":"Conférence de 1946 où Sartre défend l''existentialisme contre ses critiques. Thèses : l''existence précède l''essence (l''homme se définit par ses actes). L''homme est condamné à être libre. La mauvaise foi : nier sa liberté. L''engagement : choisir, c''est choisir pour tous les hommes. L''angoisse : la conscience de la responsabilité totale. Le désespoir : agir sans certitude. L''humanisme : l''homme est au centre, il n''y a pas de nature humaine prédéfinie."},
      {"id":"fc5","category":"Distinction","question":"Comparez les positions de Descartes et Sartre sur la liberté.","answer":"Descartes : la liberté est le libre arbitre, capacité de la volonté à choisir. Elle est un don de Dieu. La liberté est d''autant plus grande qu''on connaît le vrai et le bien (liberté éclairée). Sartre : la liberté est absolue et constitutive de l''homme. Elle ne vient pas de Dieu (l''existentialisme est athée). L''homme est totalement responsable. Il n''y a pas d''excuse. La liberté est un fardeau (condamnation à être libre)."},
      {"id":"fc6","category":"Méthode","question":"Comment analyser un texte philosophique au bac ?","answer":"1) Lire attentivement et identifier le thème, la thèse et les arguments. 2) Situer l''auteur et l''œuvre dans leur contexte. 3) Dégager la structure logique du texte (plan de l''argumentation). 4) Expliquer les concepts clés (définir les termes techniques). 5) Évaluer la portée de la thèse (forces et limites). 6) Confronter avec d''autres auteurs. 7) Rédiger de manière claire et argumentée."},
      {"id":"fc7","category":"Exemple","question":"Quel est l''apport de la philosophie africaine ?","answer":"La philosophie africaine enrichit la réflexion par ses propres traditions. L''Ubuntu (Afrique du Sud) : ''Je suis parce que nous sommes'' - la communauté définit l''individu. Amadou Hampâté Bâ : ''En Afrique, un vieillard qui meurt, c''est une bibliothèque qui brûle'' - l''importance de la tradition orale. La palabre africaine : dialogue communautaire pour résoudre les conflits. Ces apports questionnent l''individualisme occidental."},
      {"id":"fc8","category":"Concept","question":"Qu''est-ce que le mythe de l''anneau de Gygès (Platon) ?","answer":"Dans la République, Platon raconte l''histoire de Gygès, berger qui trouve un anneau rendant invisible. Il l''utilise pour séduire la reine et tuer le roi. Question : serions-nous justes si nous pouvions agir en toute impunité ? Glaucon : la justice n''est qu''une convention sociale, l''homme est naturellement injuste. Platon répond que l''homme juste est plus heureux car la justice est l''harmonie de l''âme."}
    ],
    "schema": {
      "title": "Étude d''œuvres de penseurs",
      "nodes": [
        {"id":"n1","label":"Œuvres\nphilosophiques","type":"main"},
        {"id":"n2","label":"Antiquité","type":"branch"},
        {"id":"n3","label":"Modernité","type":"branch"},
        {"id":"n4","label":"Contemporain","type":"branch"},
        {"id":"n5","label":"Platon\nRépublique","type":"leaf"},
        {"id":"n6","label":"Descartes\nDiscours","type":"leaf"},
        {"id":"n7","label":"Rousseau\nContrat social","type":"leaf"},
        {"id":"n8","label":"Sartre\nExistentialisme","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"fondements"},
        {"from":"n1","to":"n3","label":"raison"},
        {"from":"n1","to":"n4","label":"existence"},
        {"from":"n2","to":"n5","label":"justice"},
        {"from":"n3","to":"n6","label":"méthode"},
        {"from":"n3","to":"n7","label":"politique"},
        {"from":"n4","to":"n8","label":"liberté"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Les 4 règles de la méthode de Descartes sont :","options":["Observer, hypothèse, expérience, conclusion","Évidence, analyse, synthèse, dénombrement","Thèse, antithèse, synthèse, conclusion","Induction, déduction, analogie, abstraction"],"correct":1,"explanation":"Les 4 règles du Discours de la méthode : évidence (n''accepter que le clair), analyse (diviser), synthèse (reconstruire), dénombrement (vérifier l''exhaustivité)."},
      {"id":"q2","question":"Selon Rousseau, la souveraineté appartient :","options":["Au roi","Aux nobles","Au peuple","Aux philosophes"],"correct":2,"explanation":"Dans le Contrat social, Rousseau affirme que la souveraineté appartient au peuple et s''exprime par la volonté générale. C''est le fondement de la démocratie."},
      {"id":"q3","question":"Dans la République de Platon, qui doit gouverner la cité idéale ?","options":["Les guerriers","Les producteurs","Les philosophes-rois","Les prêtres"],"correct":2,"explanation":"Platon propose que les philosophes-rois gouvernent car ils sont guidés par la sagesse et la connaissance du Bien. Ils ont accédé à la vérité, comme le prisonnier sorti de la caverne."},
      {"id":"q4","question":"L''existentialisme de Sartre est :","options":["Théiste (croit en Dieu)","Athée","Agnostique","Indifférent à la question"],"correct":1,"explanation":"L''existentialisme de Sartre est athée : il n''y a pas de Dieu pour définir une nature humaine. L''homme est donc entièrement responsable de ce qu''il est, sans excuse divine."},
      {"id":"q5","question":"''L''homme est né libre, et partout il est dans les fers'' est de :","options":["Descartes","Voltaire","Rousseau","Montesquieu"],"correct":2,"explanation":"C''est la célèbre phrase d''ouverture du Contrat social de Rousseau (1762). Elle pose le problème de la perte de la liberté naturelle dans la société."},
      {"id":"q6","question":"Le mythe de l''anneau de Gygès pose la question :","options":["De l''immortalité","De la justice sans surveillance","De l''amour","De la création du monde"],"correct":1,"explanation":"Le mythe pose la question : serions-nous justes si nous pouvions agir en toute impunité (invisibles) ? Cela interroge la nature de la justice : convention sociale ou vertu intérieure ?"},
      {"id":"q7","question":"Amadou Hampâté Bâ a dit :","options":["''Je pense, donc je suis''","''En Afrique, un vieillard qui meurt, c''est une bibliothèque qui brûle''","''L''homme est un loup pour l''homme''","''L''enfer, c''est les autres''"],"correct":1,"explanation":"Cette citation célèbre souligne l''importance de la tradition orale en Afrique et le rôle des aînés dans la transmission du savoir culturel et historique."},
      {"id":"q8","question":"La ''mauvaise foi'' chez Sartre désigne :","options":["Le mensonge","Le fait de nier sa propre liberté","Le manque de religion","L''hypocrisie sociale"],"correct":1,"explanation":"La mauvaise foi est l''attitude par laquelle l''homme fuit sa liberté et sa responsabilité en se cachant derrière des excuses : ''je ne pouvais pas faire autrement'', ''c''est mon caractère'', etc."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - CHAPTER 5: Techniques d''exploitation des approches
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'techniques-approches', 5, 'Techniques d''exploitation des approches', 'Dissertation, commentaire, argumentation', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'techniques-approches-fiche', 'Techniques d''exploitation des approches', 'Méthodologie de la dissertation et du commentaire', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Quelles sont les étapes de la dissertation philosophique ?","answer":"1) Analyser le sujet : définir les termes clés, identifier le problème. 2) Problématiser : formuler la question centrale. 3) Élaborer un plan dialectique : thèse (oui), antithèse (non), synthèse (dépassement). 4) Rédiger l''introduction (amorce, problématique, annonce du plan). 5) Développer chaque partie avec arguments et exemples. 6) Rédiger la conclusion (bilan et ouverture)."},
      {"id":"fc2","category":"Méthode","question":"Comment rédiger une bonne introduction en philo ?","answer":"L''introduction comporte 3 étapes : 1) L''amorce : accrocher le lecteur avec un exemple, une citation ou une situation concrète liée au sujet. 2) La problématique : analyser les termes du sujet et formuler la question centrale. Montrer pourquoi la réponse n''est pas évidente. 3) L''annonce du plan : présenter les grandes parties de la dissertation sans les détailler."},
      {"id":"fc3","category":"Méthode","question":"Comment construire un plan dialectique ?","answer":"Thèse : développer la première réponse au sujet avec des arguments et des références philosophiques. Antithèse : montrer les limites de la thèse et développer une position contraire. Synthèse : dépasser l''opposition en proposant une réponse plus nuancée ou en reformulant le problème. Chaque partie doit contenir 2-3 arguments avec exemples et citations d''auteurs."},
      {"id":"fc4","category":"Méthode","question":"Comment commenter un texte philosophique ?","answer":"1) Lire attentivement et identifier l''auteur, le thème et la thèse. 2) Découper le texte en parties logiques. 3) Expliquer chaque partie : paraphraser, expliciter les concepts, montrer la logique de l''argumentation. 4) Évaluer : discuter la portée et les limites de la thèse. 5) Confronter avec d''autres auteurs ou positions."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce qu''une argumentation philosophique ?","answer":"Argumenter en philosophie, c''est justifier une thèse par des raisons. Un argument comprend : une prémisse (point de départ accepté), un raisonnement logique et une conclusion. Types d''arguments : par l''exemple (illustrer), par analogie (comparer), par l''absurde (montrer que le contraire mène à une contradiction), d''autorité (citer un auteur). L''argumentation doit être logique, claire et honnête."},
      {"id":"fc6","category":"Distinction","question":"Quels sont les types de raisonnement ?","answer":"Déduction : du général au particulier (si tous les hommes sont mortels et Socrate est un homme, alors Socrate est mortel). Induction : du particulier au général (j''ai vu 1000 cygnes blancs, donc tous les cygnes sont blancs - mais le cygne noir réfute !). Raisonnement par l''absurde : supposer le contraire et montrer que cela mène à une contradiction. Dialectique : confronter thèse et antithèse pour atteindre une synthèse."},
      {"id":"fc7","category":"Méthode","question":"Comment utiliser les citations philosophiques ?","answer":"Une citation doit être : 1) Exacte (entre guillemets avec le nom de l''auteur). 2) Pertinente (en rapport direct avec l''argument). 3) Expliquée (ne jamais laisser une citation sans commentaire). 4) Intégrée dans le raisonnement (pas un collage). Exemple : ''L''homme est condamné à être libre'' (Sartre) signifie que... Citations essentielles : Cogito (Descartes), caverne (Platon), impératif catégorique (Kant)."},
      {"id":"fc8","category":"Exemple","question":"Comment traiter le sujet : ''La liberté est-elle une illusion ?''","answer":"Introduction : définir liberté et illusion. Problématique : sommes-nous réellement libres ou notre sentiment de liberté est-il trompeur ? Thèse (oui, illusion) : Spinoza (déterminisme), Freud (inconscient), Marx (conditions sociales). Antithèse (non, réalité) : Descartes (libre arbitre), Sartre (existence précède essence), Kant (autonomie morale). Synthèse : la liberté n''est pas donnée mais conquise par la connaissance et l''effort."}
    ],
    "schema": {
      "title": "Techniques philosophiques",
      "nodes": [
        {"id":"n1","label":"Techniques\nphilosophiques","type":"main"},
        {"id":"n2","label":"Dissertation","type":"branch"},
        {"id":"n3","label":"Commentaire","type":"branch"},
        {"id":"n4","label":"Argumentation","type":"branch"},
        {"id":"n5","label":"Introduction\nDéveloppement\nConclusion","type":"leaf"},
        {"id":"n6","label":"Plan\ndialectique","type":"leaf"},
        {"id":"n7","label":"Explication\nde texte","type":"leaf"},
        {"id":"n8","label":"Déduction\nInduction\nAbsurde","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"épreuve écrite"},
        {"from":"n1","to":"n3","label":"épreuve écrite"},
        {"from":"n1","to":"n4","label":"fondement"},
        {"from":"n2","to":"n5","label":"structure"},
        {"from":"n2","to":"n6","label":"organisation"},
        {"from":"n3","to":"n7","label":"méthode"},
        {"from":"n4","to":"n8","label":"types"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le plan dialectique comprend :","options":["Introduction, développement, conclusion","Thèse, antithèse, synthèse","Observation, hypothèse, expérience","Question, réponse, commentaire"],"correct":1,"explanation":"Le plan dialectique organise la réflexion en 3 parties : thèse (première réponse), antithèse (objections et position contraire), synthèse (dépassement et réponse nuancée)."},
      {"id":"q2","question":"L''introduction d''une dissertation philosophique doit contenir :","options":["Uniquement la définition des termes","Amorce, problématique et annonce du plan","La conclusion anticipée","Tous les arguments"],"correct":1,"explanation":"L''introduction comporte l''amorce (accrocher), la problématique (formuler la question) et l''annonce du plan (présenter la structure). Elle ne doit pas contenir les arguments détaillés."},
      {"id":"q3","question":"Un raisonnement par l''absurde consiste à :","options":["Donner un exemple absurde","Supposer le contraire et montrer que cela mène à une contradiction","Rire du sujet","Réfuter tous les arguments"],"correct":1,"explanation":"Le raisonnement par l''absurde suppose que la thèse opposée est vraie et montre qu''elle conduit à une contradiction logique, ce qui prouve la validité de la thèse initiale."},
      {"id":"q4","question":"Le raisonnement déductif va :","options":["Du particulier au général","Du général au particulier","Du concret à l''abstrait","Du présent au passé"],"correct":1,"explanation":"La déduction part de prémisses générales pour arriver à une conclusion particulière. Exemple : tous les hommes sont mortels (général), Socrate est un homme, donc Socrate est mortel (particulier)."},
      {"id":"q5","question":"Pour commenter un texte philosophique, la première étape est :","options":["Critiquer l''auteur","Identifier le thème, la thèse et la structure","Donner son avis personnel","Comparer avec d''autres textes"],"correct":1,"explanation":"La première étape est la lecture attentive pour identifier le thème (de quoi parle le texte), la thèse (que soutient l''auteur) et la structure logique de l''argumentation."},
      {"id":"q6","question":"Une citation philosophique doit être :","options":["La plus longue possible","Exacte, pertinente et expliquée","Inventée si on ne s''en souvient pas","Placée sans commentaire"],"correct":1,"explanation":"Une citation doit être exacte (entre guillemets), pertinente (en rapport avec l''argument) et expliquée (commentée et intégrée dans le raisonnement). Ne jamais inventer une citation."},
      {"id":"q7","question":"La problématique d''une dissertation est :","options":["La réponse au sujet","La question centrale que le sujet pose","Le résumé du cours","La liste des auteurs"],"correct":1,"explanation":"La problématique est la question philosophique centrale que le sujet soulève. Elle montre pourquoi la réponse n''est pas évidente et oriente la réflexion du devoir."},
      {"id":"q8","question":"La synthèse dans un plan dialectique doit :","options":["Répéter la thèse","Répéter l''antithèse","Dépasser l''opposition thèse/antithèse","Donner un avis personnel sans argumentation"],"correct":2,"explanation":"La synthèse ne répète ni la thèse ni l''antithèse : elle dépasse l''opposition en proposant une réponse plus nuancée, en reformulant le problème ou en montrant les conditions sous lesquelles chaque position est valable."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - CHAPTER 1: Oral communication
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'oral-communication', 1, 'Oral communication', 'Speaking skills, pronunciation, dialogue', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oral-communication-fiche', 'Oral communication', 'Speaking skills and oral expression', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"How do you introduce yourself in English?","answer":"A good self-introduction includes: greeting (Hello, Good morning), name (My name is...), age (I am ... years old), origin (I am from ... / I come from Mali), education (I am a student in Terminale TSEXP at ...), hobbies (I enjoy reading, playing football...), future plans (I want to study medicine / become an engineer). Speak clearly, make eye contact, and be confident."},
      {"id":"fc2","category":"Formule","question":"What are common expressions for agreeing and disagreeing?","answer":"Agreeing: I agree with you. That''s right. Exactly. I think so too. You have a good point. Absolutely. Disagreeing politely: I''m afraid I disagree. I see your point, but... I don''t quite agree. I beg to differ. That''s not entirely true. I see it differently. Always give reasons for your opinion."},
      {"id":"fc3","category":"Méthode","question":"How do you express opinions in English?","answer":"Giving opinions: In my opinion... / I think that... / I believe that... / From my point of view... / As far as I''m concerned... / It seems to me that... Asking for opinions: What do you think about...? / What''s your opinion on...? / How do you feel about...? / Do you agree that...? Always support opinions with reasons and examples."},
      {"id":"fc4","category":"Distinction","question":"What is the difference between formal and informal English?","answer":"Formal: used in exams, official situations, with elders. Full forms (I would like), polite expressions (Could you please...?), complex vocabulary. Informal: used with friends, in casual conversation. Contractions (I''d like), slang, simpler vocabulary. In the bac exam, use semi-formal to formal register. Avoid slang and abbreviated forms in written work."},
      {"id":"fc5","category":"Formule","question":"What expressions are used for making suggestions?","answer":"Making suggestions: Why don''t we...? / How about...? / Let''s... / I suggest that we... / What about...? / We could... / Shall we...? Accepting: That''s a great idea! / Sounds good! / I''d love to. Rejecting politely: I''m sorry, but... / That sounds nice, but... / I''d rather... / Maybe another time."},
      {"id":"fc6","category":"Méthode","question":"How do you describe a picture or image in English?","answer":"Structure: 1) General description: This picture shows... / In this image, we can see... 2) Details: In the foreground / background / on the left / on the right... 3) People: There is a man/woman who is...-ing. They are wearing... 4) Actions: They seem to be... / It looks like they are... 5) Interpretation: This picture might represent... / It suggests that..."},
      {"id":"fc7","category":"Formule","question":"What phrases are used for giving advice?","answer":"Giving advice: You should... / You ought to... / If I were you, I would... / You had better... / I advise you to... / Why don''t you...? / Have you considered...? Strong advice: You must... / You really should... Warning: You shouldn''t... / You had better not... / I wouldn''t ... if I were you."},
      {"id":"fc8","category":"Exemple","question":"How do you talk about environmental issues in English?","answer":"Key vocabulary: climate change, global warming, deforestation, pollution, renewable energy, biodiversity, carbon footprint, recycling, sustainable development. Useful sentences: ''Deforestation is a major problem in Mali because...'' ''We should use renewable energy sources such as solar power.'' ''Everyone can help by reducing, reusing and recycling.'' ''Climate change affects agriculture in the Sahel region.''"}
    ],
    "schema": {
      "title": "Oral communication skills",
      "nodes": [
        {"id":"n1","label":"Oral\ncommunication","type":"main"},
        {"id":"n2","label":"Expressing\nopinions","type":"branch"},
        {"id":"n3","label":"Social\ninteraction","type":"branch"},
        {"id":"n4","label":"Agree / Disagree\nSuggest / Advise","type":"leaf"},
        {"id":"n5","label":"Formal vs\nInformal","type":"leaf"},
        {"id":"n6","label":"Describe\nNarrate","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"ideas"},
        {"from":"n1","to":"n3","label":"context"},
        {"from":"n2","to":"n4","label":"phrases"},
        {"from":"n3","to":"n5","label":"register"},
        {"from":"n3","to":"n6","label":"tasks"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Which phrase is used to politely disagree?","options":["You''re wrong!","I''m afraid I disagree","That''s stupid","No way"],"correct":1,"explanation":"''I''m afraid I disagree'' is a polite way to express disagreement. The other options are rude or too informal for academic contexts."},
      {"id":"q2","question":"Which expression is used to give an opinion?","options":["I order you to...","In my opinion...","You must believe that...","It is a fact that..."],"correct":1,"explanation":"''In my opinion...'' clearly introduces a personal viewpoint. Other options are either commands, demands, or state facts rather than opinions."},
      {"id":"q3","question":"In formal English, which form is preferred?","options":["I wanna go","I would like to go","I''d like going","Lemme go"],"correct":1,"explanation":"''I would like to go'' uses the full form and formal structure. Contractions and slang (wanna, lemme) are informal and inappropriate in formal contexts like the bac."},
      {"id":"q4","question":"Which phrase introduces a suggestion?","options":["You must do this","How about going to the library?","I demand that you...","Do it now"],"correct":1,"explanation":"''How about...?'' is a common way to make a suggestion. It is polite and invites the other person to consider the idea."},
      {"id":"q5","question":"To describe a picture, you start with:","options":["I don''t like this picture","This picture shows...","The photographer is bad","I can''t see anything"],"correct":1,"explanation":"''This picture shows...'' is the standard way to begin describing an image. Start with a general description, then move to specific details."},
      {"id":"q6","question":"''If I were you, I would study harder'' expresses:","options":["A command","A suggestion or advice","A question","A complaint"],"correct":1,"explanation":"''If I were you, I would...'' is a polite way to give advice using the conditional type 2. It suggests what you think the person should do without being directive."},
      {"id":"q7","question":"Which is an appropriate topic for the oral bac exam?","options":["Social media gossip","Environmental challenges in Mali","A friend''s personal problems","Video game strategies"],"correct":1,"explanation":"Environmental challenges in Mali is an appropriate academic topic for the bac exam. It demonstrates knowledge of current issues and relevant vocabulary."},
      {"id":"q8","question":"''Global warming'' means:","options":["Le réchauffement climatique","La guerre mondiale","Le commerce mondial","La mondialisation"],"correct":0,"explanation":"''Global warming'' = le réchauffement climatique. ''Global'' signifie mondial/planétaire et ''warming'' signifie réchauffement."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - CHAPTER 2: Reading comprehension
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'reading-comprehension', 2, 'Reading comprehension', 'Understanding texts, finding information, inference', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'reading-comprehension-fiche', 'Reading comprehension', 'Techniques for understanding English texts', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"What are the steps to answer reading comprehension questions?","answer":"1) Read the questions first to know what to look for. 2) Read the text quickly for general understanding (skimming). 3) Read again more carefully, underlining key information. 4) Answer questions using information from the text. 5) Use your own words when possible (do not copy entire sentences). 6) Always justify your answers with evidence from the text (line numbers)."},
      {"id":"fc2","category":"Distinction","question":"What is the difference between skimming and scanning?","answer":"Skimming: reading quickly to get the general idea or main topic. You read titles, first sentences of paragraphs, and key words. Scanning: reading quickly to find specific information (a date, a name, a number). You look for particular words or data without reading everything. Both techniques are essential for the bac reading comprehension."},
      {"id":"fc3","category":"Méthode","question":"How do you identify the main idea of a paragraph?","answer":"The main idea is usually in the first or last sentence of the paragraph (topic sentence). Ask: ''What is this paragraph mostly about?'' The other sentences give supporting details, examples or explanations. The main idea can also be implied (not directly stated) - you need to infer it from the details."},
      {"id":"fc4","category":"Formule","question":"What are common question types in reading comprehension?","answer":"1) Factual: Who? What? When? Where? (find specific information). 2) Vocabulary: What does the word ''X'' mean in line Y? (use context clues). 3) Inference: What can we infer from...? (read between the lines). 4) True/False/Not stated: justify with evidence. 5) Referencing: What does ''they/it/this'' refer to? 6) Opinion: What is the author''s attitude toward...?"},
      {"id":"fc5","category":"Méthode","question":"How do you guess the meaning of unknown words from context?","answer":"1) Read the sentence before and after the unknown word. 2) Look for synonyms or definitions in the text. 3) Look for antonyms (opposite meaning, often after ''but'' or ''however''). 4) Use word parts: prefix (un- = not), suffix (-tion = noun), root (bio = life). 5) Consider the general topic of the text. Example: ''The drought devastated crops'' - context suggests ''drought'' means a long period without rain."},
      {"id":"fc6","category":"Concept","question":"What is inference in reading comprehension?","answer":"Inference means understanding something that is not directly stated in the text. You use clues from the text plus your own knowledge. Example: ''She put on her coat and grabbed her umbrella.'' Inference: It is cold or raining outside. For the bac, inference questions use phrases like: ''What can we infer...?'' ''What does the author suggest...?'' ''What is implied by...?''"},
      {"id":"fc7","category":"Méthode","question":"How do you answer True/False/Not stated questions?","answer":"True: the information matches what the text says. False: the information contradicts what the text says. Not stated: the text does not give enough information to confirm or deny. Always justify by quoting or referring to specific lines. Common mistake: choosing ''false'' when the answer is ''not stated'' - if the text simply does not mention it, it is ''not stated''."},
      {"id":"fc8","category":"Formule","question":"What linking words help understand text structure?","answer":"Addition: and, also, moreover, furthermore, in addition. Contrast: but, however, although, nevertheless, on the other hand. Cause: because, since, as, due to, owing to. Effect: so, therefore, consequently, as a result. Time: first, then, next, finally, meanwhile. Example: however, for instance, such as. These words help you follow the logic and structure of a text."}
    ],
    "schema": {
      "title": "Reading comprehension",
      "nodes": [
        {"id":"n1","label":"Reading\ncomprehension","type":"main"},
        {"id":"n2","label":"Techniques","type":"branch"},
        {"id":"n3","label":"Question types","type":"branch"},
        {"id":"n4","label":"Skimming\nScanning","type":"leaf"},
        {"id":"n5","label":"Context clues\nInference","type":"leaf"},
        {"id":"n6","label":"Factual\nTrue/False","type":"leaf"},
        {"id":"n7","label":"Vocabulary\nReference","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"how to read"},
        {"from":"n1","to":"n3","label":"how to answer"},
        {"from":"n2","to":"n4","label":"reading speed"},
        {"from":"n2","to":"n5","label":"understanding"},
        {"from":"n3","to":"n6","label":"comprehension"},
        {"from":"n3","to":"n7","label":"language"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Skimming a text means:","options":["Reading every word carefully","Reading quickly for the general idea","Looking for specific information","Translating word by word"],"correct":1,"explanation":"Skimming is reading quickly to get the general idea. You focus on titles, headings, first sentences of paragraphs and key words."},
      {"id":"q2","question":"When a question asks ''What does the word X mean?'', you should:","options":["Use a dictionary","Guess from the context","Skip the question","Give the French translation"],"correct":1,"explanation":"In the exam, you should use context clues (surrounding sentences, word parts, topic) to determine the meaning. Dictionary use is not allowed."},
      {"id":"q3","question":"A ''Not stated'' answer means:","options":["The text says it is false","The text does not mention this information","The reader disagrees","The question is wrong"],"correct":1,"explanation":"''Not stated'' means the text does not provide enough information to confirm or deny the statement. It is different from ''false'', which means the text contradicts the statement."},
      {"id":"q4","question":"The topic sentence of a paragraph is usually:","options":["The last sentence only","The longest sentence","The first or last sentence","Any sentence with numbers"],"correct":2,"explanation":"The topic sentence, which states the main idea of the paragraph, is typically the first or last sentence. The other sentences provide supporting details."},
      {"id":"q5","question":"''However'' is a linking word that expresses:","options":["Addition","Contrast","Cause","Time"],"correct":1,"explanation":"''However'' introduces a contrast or contradiction with what was said before. Other contrast words: but, although, nevertheless, on the other hand."},
      {"id":"q6","question":"Inference in reading means:","options":["Copying from the text","Understanding what is not directly stated","Translating the text","Reading aloud"],"correct":1,"explanation":"Inference is reading between the lines - understanding ideas that are implied but not explicitly stated, using clues from the text and your own knowledge."},
      {"id":"q7","question":"To answer factual questions, you should:","options":["Give your personal opinion","Find the specific information in the text","Make up an answer","Use only general knowledge"],"correct":1,"explanation":"Factual questions (Who? What? When? Where?) require you to locate specific information in the text and provide it in your answer, with reference to the relevant lines."},
      {"id":"q8","question":"The prefix ''un-'' in ''unhappy'' means:","options":["Very","Again","Not","Before"],"correct":2,"explanation":"The prefix ''un-'' means ''not'' or ''opposite of''. Unhappy = not happy. Other examples: unable (not able), unfair (not fair), uncomfortable (not comfortable)."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - CHAPTER 3: Writing skills
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'writing-skills', 3, 'Writing skills', 'Essay writing, letters, paragraphs', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'writing-skills-fiche', 'Writing skills', 'Essay writing and composition techniques', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"How do you write an essay in English?","answer":"Structure: 1) Introduction: hook (question, quote, fact), background, thesis statement. 2) Body paragraphs (2-3): each with a topic sentence, supporting arguments, examples, concluding sentence. 3) Conclusion: restate thesis, summarize key points, final thought or call to action. Use linking words for coherence. Write at least 200 words for the bac."},
      {"id":"fc2","category":"Formule","question":"What are useful phrases for essay writing?","answer":"Introduction: It is widely known that... / This essay will discuss... / In recent years... Body: First of all... / Furthermore... / On the other hand... / For example... / According to... / In addition... / However... Conclusion: In conclusion... / To sum up... / All things considered... / Overall... / Taking everything into account..."},
      {"id":"fc3","category":"Méthode","question":"How do you write a formal letter?","answer":"Format: 1) Your address (top right). 2) Date. 3) Recipient''s address (left). 4) Greeting: Dear Sir/Madam (unknown), Dear Mr/Mrs X (known). 5) Introduction: state the purpose. 6) Body: develop your points. 7) Conclusion: summarize and express expectation. 8) Closing: Yours faithfully (Dear Sir), Yours sincerely (Dear Mr X). Sign your name."},
      {"id":"fc4","category":"Distinction","question":"What is the difference between formal and informal letters?","answer":"Formal letter: Dear Sir/Madam, full forms, polite language, no slang, Yours faithfully/sincerely. Used for: applications, complaints, official requests. Informal letter: Dear + first name, contractions allowed, casual language, Love/Best wishes. Used for: friends, family. For the bac, formal letters are more commonly tested."},
      {"id":"fc5","category":"Méthode","question":"How do you write a good paragraph?","answer":"A good paragraph has: 1) A topic sentence (main idea). 2) Supporting sentences (details, examples, explanations). 3) A concluding sentence (summary or transition). Use the PEEL method: Point (state your argument), Evidence (give proof), Explain (develop), Link (connect to next idea). Each paragraph should focus on ONE main idea."},
      {"id":"fc6","category":"Formule","question":"What are common linking words for essays?","answer":"Listing: firstly, secondly, finally, moreover, in addition. Contrasting: however, although, on the contrary, nevertheless, whereas. Giving reasons: because, since, due to, as a result of. Giving examples: for instance, such as, for example, namely. Concluding: in conclusion, to sum up, overall, in short, all in all."},
      {"id":"fc7","category":"Méthode","question":"How do you write an argumentative essay?","answer":"For/Against structure: Introduction: present the topic and state both sides exist. Body 1: arguments FOR (with examples). Body 2: arguments AGAINST (with examples). Conclusion: give your personal opinion with justification. OR Opinion essay: Introduction with your position. Body: 2-3 arguments supporting your opinion. Counter-argument and refutation. Conclusion: restate your position."},
      {"id":"fc8","category":"Exemple","question":"Give an example of an essay topic and thesis statement.","answer":"Topic: ''Should school uniforms be compulsory?'' Thesis statement: ''While school uniforms may limit individual expression, they promote equality and reduce peer pressure, making them beneficial for students.'' This thesis is clear, debatable, and announces the main arguments. A good thesis is specific, takes a position, and can be supported with evidence."}
    ],
    "schema": {
      "title": "Writing skills",
      "nodes": [
        {"id":"n1","label":"Writing\nskills","type":"main"},
        {"id":"n2","label":"Essays","type":"branch"},
        {"id":"n3","label":"Letters","type":"branch"},
        {"id":"n4","label":"Introduction\nBody, Conclusion","type":"leaf"},
        {"id":"n5","label":"Argumentative\nFor/Against","type":"leaf"},
        {"id":"n6","label":"Formal\nInformal","type":"leaf"},
        {"id":"n7","label":"Linking words\nPEEL method","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"composition"},
        {"from":"n1","to":"n3","label":"correspondence"},
        {"from":"n2","to":"n4","label":"structure"},
        {"from":"n2","to":"n5","label":"type"},
        {"from":"n3","to":"n6","label":"register"},
        {"from":"n1","to":"n7","label":"techniques"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"A thesis statement should be:","options":["Vague and general","Clear, debatable and specific","A question","Very long"],"correct":1,"explanation":"A thesis statement presents your main argument clearly and specifically. It should be debatable (someone could disagree) and guide the rest of the essay."},
      {"id":"q2","question":"The closing of a formal letter to an unknown person is:","options":["Love","Best wishes","Yours faithfully","See you soon"],"correct":2,"explanation":"''Yours faithfully'' is used when you begin with ''Dear Sir/Madam'' (unknown recipient). ''Yours sincerely'' is used with ''Dear Mr/Mrs + name'' (known recipient)."},
      {"id":"q3","question":"''Furthermore'' is a linking word that expresses:","options":["Contrast","Addition","Conclusion","Cause"],"correct":1,"explanation":"''Furthermore'' adds information to what has already been stated. It is similar to ''moreover'', ''in addition'' and ''also''."},
      {"id":"q4","question":"Each paragraph should focus on:","options":["Multiple ideas","One main idea","The conclusion only","Grammar rules"],"correct":1,"explanation":"A well-structured paragraph focuses on one main idea, stated in the topic sentence, and supported by details and examples."},
      {"id":"q5","question":"The PEEL method stands for:","options":["Plan, Execute, Evaluate, Learn","Point, Evidence, Explain, Link","Prepare, Edit, Expand, Limit","Practice, Engage, Elaborate, Listen"],"correct":1,"explanation":"PEEL: Point (state your argument), Evidence (give proof or examples), Explain (develop your point), Link (connect to the next idea or the essay question)."},
      {"id":"q6","question":"In a for/against essay, your opinion goes in:","options":["The introduction","The first body paragraph","The conclusion","Every paragraph"],"correct":2,"explanation":"In a for/against essay, you present both sides objectively in the body paragraphs, then give your personal opinion in the conclusion."},
      {"id":"q7","question":"''To sum up'' is used in:","options":["The introduction","The body paragraphs","The conclusion","The title"],"correct":2,"explanation":"''To sum up'', ''In conclusion'', ''Overall'' and ''All things considered'' are conclusion phrases used to summarize the main points of an essay."},
      {"id":"q8","question":"How many words minimum should a bac essay have?","options":["50 words","100 words","200 words","500 words"],"correct":2,"explanation":"For the baccalauréat, essays should be at least 200 words (approximately 20-25 lines). This allows you to develop your arguments properly with examples."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - CHAPTER 4: Grammar and vocabulary
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'grammar-vocabulary', 4, 'Grammar and vocabulary', 'Tenses, conditionals, reported speech, vocabulary', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'grammar-vocabulary-fiche', 'Grammar and vocabulary', 'Essential grammar and thematic vocabulary', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Formule","question":"What are the main English tenses and their uses?","answer":"Present simple: habits, facts (I study every day). Present continuous: action in progress (I am studying now). Past simple: completed past action (I studied yesterday). Present perfect: past with present relevance (I have studied this chapter). Future: will (prediction) / going to (plan). Past continuous: action in progress in the past (I was studying when he called)."},
      {"id":"fc2","category":"Formule","question":"What are the four types of conditionals?","answer":"Type 0: If + present, present (general truth: If you heat water, it boils). Type 1: If + present, will + verb (probable: If I study, I will pass). Type 2: If + past, would + verb (unreal present: If I had money, I would travel). Type 3: If + past perfect, would have + pp (unreal past: If I had studied, I would have passed)."},
      {"id":"fc3","category":"Formule","question":"How is the passive voice formed?","answer":"Active: Subject + verb + object. Passive: Object + be (conjugated) + past participle + (by agent). Present: The exam is written by students. Past: The exam was written. Present perfect: The exam has been written. Future: The exam will be written. Modal: The exam can be written. Use passive when the action is more important than the agent."},
      {"id":"fc4","category":"Méthode","question":"How does reported speech work?","answer":"When reporting what someone said, change: Tenses (backshift): present -> past, past -> past perfect, will -> would. Pronouns: I -> he/she, we -> they. Time: today -> that day, tomorrow -> the next day, yesterday -> the day before. Place: here -> there. Direct: He said ''I am tired.'' Reported: He said (that) he was tired."},
      {"id":"fc5","category":"Distinction","question":"What is the difference between ''since'' and ''for'' with present perfect?","answer":"''Since'' indicates a starting point in time: I have lived in Bamako since 2010. ''For'' indicates a duration: I have lived in Bamako for 14 years. Both are used with present perfect (and present perfect continuous). Common error: using past simple instead of present perfect with since/for when the action continues to the present."},
      {"id":"fc6","category":"Formule","question":"What are common phrasal verbs for the bac?","answer":"Look for: chercher. Look after: s''occuper de. Look forward to: attendre avec impatience. Give up: abandonner. Turn on/off: allumer/éteindre. Put off: reporter. Carry out: réaliser, effectuer. Find out: découvrir. Set up: établir, créer. Break down: tomber en panne. Come across: tomber sur. Make up: inventer, se réconcilier."},
      {"id":"fc7","category":"Exemple","question":"What thematic vocabulary is useful for the bac?","answer":"Environment: pollution, deforestation, climate change, renewable energy. Education: curriculum, scholarship, literacy, dropout rate. Health: disease, prevention, vaccination, malnutrition. Technology: internet, social media, digital divide, artificial intelligence. Mali: Sahel, agriculture, cotton, gold mining, cultural heritage, democracy, development."},
      {"id":"fc8","category":"Formule","question":"What are modal verbs and their uses?","answer":"Can: ability (I can swim), permission (Can I go?). Could: past ability, polite request. Must: obligation (You must study). Mustn''t: prohibition. Should: advice (You should rest). May: possibility (It may rain), formal permission. Might: weak possibility. Would: conditional, polite request. Have to: external obligation. Don''t have to: no obligation (different from mustn''t)."}
    ],
    "schema": {
      "title": "Grammar and vocabulary",
      "nodes": [
        {"id":"n1","label":"Grammar &\nvocabulary","type":"main"},
        {"id":"n2","label":"Tenses","type":"branch"},
        {"id":"n3","label":"Structures","type":"branch"},
        {"id":"n4","label":"Vocabulary","type":"branch"},
        {"id":"n5","label":"Present, Past\nFuture, Perfect","type":"leaf"},
        {"id":"n6","label":"Conditionals\nPassive, Reported","type":"leaf"},
        {"id":"n7","label":"Environment\nEducation, Health","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"conjugation"},
        {"from":"n1","to":"n3","label":"transformations"},
        {"from":"n1","to":"n4","label":"thematic"},
        {"from":"n2","to":"n5","label":"forms"},
        {"from":"n3","to":"n6","label":"rules"},
        {"from":"n4","to":"n7","label":"topics"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Complete: If I ___ rich, I would travel the world.","options":["am","was/were","will be","have been"],"correct":1,"explanation":"This is a type 2 conditional (unreal present). The structure is: If + past simple, would + base verb. ''Were'' is preferred in formal English for all persons."},
      {"id":"q2","question":"Change to passive: ''Students write exams.''","options":["Exams are written by students","Exams is written by students","Exams were written by students","Students are written by exams"],"correct":0,"explanation":"Present simple passive: object + are + past participle + by agent. ''Exams are written by students.''"},
      {"id":"q3","question":"He said: ''I will come tomorrow.'' In reported speech:","options":["He said he will come tomorrow","He said he would come the next day","He said he comes tomorrow","He said he had come yesterday"],"correct":1,"explanation":"Reported speech changes: will -> would, tomorrow -> the next day. ''He said (that) he would come the next day.''"},
      {"id":"q4","question":"I have lived here ___ 2015.","options":["for","since","during","ago"],"correct":1,"explanation":"''Since'' is used with a specific point in time (2015). ''For'' is used with a duration (for 9 years). Both require present perfect when the action continues."},
      {"id":"q5","question":"''You mustn''t smoke here'' means:","options":["You don''t have to smoke","It is forbidden to smoke here","You should smoke","You can smoke if you want"],"correct":1,"explanation":"''Mustn''t'' expresses prohibition (it is forbidden). It is different from ''don''t have to'' which means ''there is no obligation'' (you can choose)."},
      {"id":"q6","question":"''Look forward to'' means:","options":["Regarder devant","Attendre avec impatience","Chercher","Avancer"],"correct":1,"explanation":"''Look forward to'' means ''attendre avec impatience'' (to anticipate with pleasure). Example: I look forward to hearing from you."},
      {"id":"q7","question":"Which tense describes an action happening now?","options":["Present simple","Present continuous","Past simple","Present perfect"],"correct":1,"explanation":"The present continuous (am/is/are + verb-ing) describes an action happening right now. Example: I am reading this fiche."},
      {"id":"q8","question":"''Deforestation'' in French means:","options":["Reboisement","Désertification","Déforestation","Plantation"],"correct":2,"explanation":"''Deforestation'' = la déforestation, the cutting down of forests. It is a major environmental issue, particularly in tropical regions and the Sahel."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - CHAPTER 1: La dissertation littéraire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'dissertation-litteraire', 1, 'La dissertation littéraire', 'Méthodologie, argumentation, rédaction', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'dissertation-litteraire-fiche', 'La dissertation littéraire', 'Méthode et techniques de la dissertation', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Quelles sont les étapes de la dissertation littéraire ?","answer":"1) Lire et analyser le sujet : identifier le thème, la thèse, les mots clés. 2) Rechercher des idées et des exemples littéraires. 3) Élaborer un plan (dialectique, thématique ou analytique). 4) Rédiger l''introduction (amorce, problématique, annonce du plan). 5) Rédiger le développement (3 parties avec arguments et exemples). 6) Rédiger la conclusion (bilan et ouverture). 7) Relire et corriger."},
      {"id":"fc2","category":"Méthode","question":"Comment rédiger l''introduction d''une dissertation littéraire ?","answer":"L''introduction comprend : 1) L''amorce : phrase d''accroche en rapport avec le sujet (citation, fait littéraire, contexte). 2) La présentation du sujet : reformuler et expliquer la citation ou la question. 3) La problématique : formuler la question centrale. 4) L''annonce du plan : présenter brièvement les grandes parties. L''introduction fait environ 10-15 lignes. Ne jamais donner la réponse dans l''introduction."},
      {"id":"fc3","category":"Distinction","question":"Quels sont les types de plans pour la dissertation ?","answer":"Plan dialectique : thèse, antithèse, synthèse. Idéal pour les sujets qui invitent à discuter une affirmation. Plan thématique : 3 aspects différents du même thème. Pour les sujets qui demandent d''expliquer ou d''illustrer. Plan analytique : constat, causes, conséquences (ou solutions). Pour les sujets qui demandent d''analyser un phénomène. Le choix du plan dépend de la formulation du sujet."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce qu''un argument et un exemple en dissertation ?","answer":"L''argument est une idée abstraite qui soutient la thèse. L''exemple est un fait concret (œuvre, auteur, passage) qui illustre l''argument. Un argument sans exemple est vide. Un exemple sans argument est aveugle. Structure idéale d''un paragraphe : argument (idée), explication (développement), exemple (illustration), analyse de l''exemple, transition."},
      {"id":"fc5","category":"Méthode","question":"Comment rédiger la conclusion d''une dissertation ?","answer":"La conclusion comprend : 1) Le bilan : résumer les principales étapes du raisonnement et la réponse à la problématique. 2) L''ouverture : élargir le sujet en le reliant à un thème plus large, à une autre époque ou à un autre art. Ne jamais introduire un argument nouveau. La conclusion fait environ 8-10 lignes. Elle doit être aussi soignée que l''introduction."},
      {"id":"fc6","category":"Formule","question":"Quels connecteurs logiques utiliser dans une dissertation ?","answer":"Addition : de plus, en outre, par ailleurs. Opposition : cependant, néanmoins, toutefois, en revanche. Cause : car, en effet, parce que, puisque. Conséquence : donc, ainsi, par conséquent, c''est pourquoi. Illustration : par exemple, notamment, ainsi, c''est le cas de. Conclusion : en définitive, en somme, pour conclure."},
      {"id":"fc7","category":"Exemple","question":"Comment traiter un sujet comme ''La littérature doit-elle être engagée ?''","answer":"Plan dialectique. I. Oui, la littérature doit être engagée : elle dénonce les injustices (Hugo, Les Misérables), défend des causes (Zola, J''accuse), éveille les consciences (Sembène Ousmane, Les bouts de bois de Dieu). II. Non, la littérature n''est pas que l''engagement : l''art pour l''art (Flaubert, Baudelaire), la beauté formelle, l''imagination libre. III. Synthèse : la littérature peut être engagée sans sacrifier la qualité artistique (Césaire, Senghor conjuguent engagement et poésie)."},
      {"id":"fc8","category":"Méthode","question":"Quelles erreurs éviter dans une dissertation ?","answer":"1) Hors sujet : ne pas répondre à la question posée. 2) Absence de plan clair et d''organisation logique. 3) Paraphrase sans analyse personnelle. 4) Exemples sans rapport avec l''argument. 5) Absence de transitions entre les parties. 6) Introduction trop longue ou trop courte. 7) Conclusion avec un nouvel argument. 8) Fautes d''orthographe et de grammaire. 9) Oublier de citer des auteurs et des œuvres."}
    ],
    "schema": {
      "title": "La dissertation littéraire",
      "nodes": [
        {"id":"n1","label":"Dissertation\nlittéraire","type":"main"},
        {"id":"n2","label":"Structure","type":"branch"},
        {"id":"n3","label":"Contenu","type":"branch"},
        {"id":"n4","label":"Introduction\nDéveloppement\nConclusion","type":"leaf"},
        {"id":"n5","label":"Plans :\ndialectique\nthématique","type":"leaf"},
        {"id":"n6","label":"Arguments\nExemples","type":"leaf"},
        {"id":"n7","label":"Connecteurs\nTransitions","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"forme"},
        {"from":"n1","to":"n3","label":"fond"},
        {"from":"n2","to":"n4","label":"parties"},
        {"from":"n2","to":"n5","label":"organisation"},
        {"from":"n3","to":"n6","label":"preuves"},
        {"from":"n3","to":"n7","label":"cohérence"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le plan dialectique se compose de :","options":["Constat, causes, solutions","Thèse, antithèse, synthèse","Introduction, développement, conclusion","3 thèmes différents"],"correct":1,"explanation":"Le plan dialectique organise la réflexion en thèse (première position), antithèse (position contraire) et synthèse (dépassement ou nuance)."},
      {"id":"q2","question":"L''introduction d''une dissertation ne doit PAS contenir :","options":["Une amorce","La problématique","La réponse au sujet","L''annonce du plan"],"correct":2,"explanation":"L''introduction pose la question (problématique) mais ne donne pas la réponse. La réponse se construit progressivement dans le développement et se formule dans la conclusion."},
      {"id":"q3","question":"Un argument est :","options":["Un exemple tiré d''une œuvre","Une idée abstraite qui soutient la thèse","Une citation d''auteur","Un résumé du texte"],"correct":1,"explanation":"L''argument est une idée, un raisonnement qui soutient la thèse. L''exemple (concret) vient illustrer l''argument (abstrait). Les deux sont nécessaires."},
      {"id":"q4","question":"''Cependant'' est un connecteur qui exprime :","options":["L''addition","La cause","L''opposition","La conséquence"],"correct":2,"explanation":"''Cependant'' introduit une idée qui s''oppose à ce qui précède. C''est un connecteur d''opposition, comme ''néanmoins'', ''toutefois'' et ''en revanche''."},
      {"id":"q5","question":"La conclusion d''une dissertation comprend :","options":["Un nouvel argument","Un bilan et une ouverture","Uniquement une citation","La répétition de l''introduction"],"correct":1,"explanation":"La conclusion comprend un bilan (résumé du raisonnement et réponse à la problématique) et une ouverture (élargissement du sujet). Jamais de nouvel argument."},
      {"id":"q6","question":"Pour le sujet ''La littérature doit-elle être engagée ?'', quel plan est le plus adapté ?","options":["Plan analytique","Plan thématique","Plan dialectique","Plan chronologique"],"correct":2,"explanation":"Le sujet invite à discuter (''doit-elle''), ce qui appelle un plan dialectique : thèse (oui, elle doit), antithèse (non, pas nécessairement), synthèse (nuance et dépassement)."},
      {"id":"q7","question":"Quel auteur africain est souvent cité pour la littérature engagée ?","options":["Baudelaire","Sembène Ousmane","Flaubert","Maupassant"],"correct":1,"explanation":"Sembène Ousmane (Sénégal) est un auteur majeur de la littérature africaine engagée. Son roman ''Les bouts de bois de Dieu'' dénonce les injustices coloniales."},
      {"id":"q8","question":"Quelle erreur est la plus grave en dissertation ?","options":["Une faute d''orthographe","Le hors sujet","Un paragraphe trop court","L''absence de citation"],"correct":1,"explanation":"Le hors sujet est l''erreur la plus grave car le correcteur ne peut pas évaluer la capacité de l''élève à répondre à la question posée. Il faut toujours bien analyser le sujet avant de commencer."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - CHAPTER 2: Le commentaire composé
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'commentaire-compose', 2, 'Le commentaire composé', 'Analyse littéraire, plan, rédaction', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'commentaire-compose-fiche', 'Le commentaire composé', 'Méthodologie du commentaire de texte', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le commentaire composé ?","answer":"Le commentaire composé est un exercice d''analyse littéraire qui consiste à étudier un texte en montrant comment la forme (style, procédés) sert le fond (sens, thèmes). Il ne s''agit PAS de paraphraser (redire en d''autres mots) mais d''analyser les effets produits par les choix d''écriture de l''auteur. Le commentaire est organisé en un plan thématique (2-3 axes de lecture)."},
      {"id":"fc2","category":"Méthode","question":"Comment analyser un texte littéraire ?","answer":"1) Lire attentivement plusieurs fois. 2) Identifier le genre (roman, poésie, théâtre), le type (narratif, descriptif, argumentatif) et le registre (lyrique, tragique, comique, épique). 3) Repérer les procédés littéraires (figures de style, champs lexicaux, structure). 4) Analyser l''effet produit par chaque procédé. 5) Regrouper les observations en axes de lecture cohérents."},
      {"id":"fc3","category":"Formule","question":"Quelles sont les principales figures de style ?","answer":"Comparaison : rapprochement avec ''comme'' (fort comme un lion). Métaphore : comparaison sans outil (la vie est un voyage). Personnification : attribuer des qualités humaines à un objet. Hyperbole : exagération (mourir de faim). Litote : dire moins pour dire plus (ce n''est pas mal = c''est bien). Anaphore : répétition en début de phrase. Antithèse : opposition de deux idées. Oxymore : alliance de mots contradictoires (obscure clarté)."},
      {"id":"fc4","category":"Méthode","question":"Comment construire le plan d''un commentaire ?","answer":"Le plan est thématique (PAS linéaire). Chaque axe de lecture aborde un aspect du texte : Axe 1 : le thème principal (ex : la description du paysage). Axe 2 : les sentiments ou les procédés (ex : l''expression de la mélancolie). Axe 3 (optionnel) : la portée ou la dimension symbolique. Chaque axe contient 2-3 sous-parties avec citation + procédé + interprétation."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce qu''un champ lexical et comment l''analyser ?","answer":"Un champ lexical est un ensemble de mots se rapportant à un même thème. Exemple : champ lexical de la nature : arbre, fleur, soleil, rivière. Analyser un champ lexical permet de montrer les thèmes dominants du texte. L''association ou l''opposition de champs lexicaux crée des effets de sens. Exemple : champ lexical de la lumière opposé à celui de l''obscurité peut symboliser le bien contre le mal."},
      {"id":"fc6","category":"Distinction","question":"Quels sont les registres littéraires ?","answer":"Lyrique : expression des sentiments personnels (amour, nostalgie). Épique : récit d''exploits héroïques, exagération. Tragique : fatalité, souffrance, mort inévitable. Comique : humour, satire, situations amusantes. Pathétique : émotion, pitié, compassion. Fantastique : irruption du surnaturel dans le réel. Polémique : critique virulente, indignation. Chaque registre produit un effet spécifique sur le lecteur."},
      {"id":"fc7","category":"Formule","question":"Comment rédiger un paragraphe de commentaire ?","answer":"Méthode : 1) Idée directrice (ce que vous voulez montrer). 2) Citation du texte (entre guillemets, avec numéro de ligne). 3) Identification du procédé (figure de style, champ lexical, rythme). 4) Analyse de l''effet produit (sur le lecteur, sur le sens). Formule : ''L''auteur utilise [procédé] comme le montre [citation], ce qui produit un effet de [interprétation].''"},
      {"id":"fc8","category":"Exemple","question":"Comment analyser une métaphore dans un texte ?","answer":"Exemple : ''La vie est un long fleuve tranquille.'' 1) Identifier : c''est une métaphore (pas de mot de comparaison). 2) Comparé : la vie. Comparant : un fleuve tranquille. Point commun : le cours, la durée. 3) Effet : cette métaphore suggère que la vie s''écoule paisiblement, sans obstacles. 4) Nuance : le titre du film est ironique car la vie n''est justement pas toujours tranquille. L''analyse doit toujours dépasser la simple identification."}
    ],
    "schema": {
      "title": "Le commentaire composé",
      "nodes": [
        {"id":"n1","label":"Commentaire\ncomposé","type":"main"},
        {"id":"n2","label":"Analyse","type":"branch"},
        {"id":"n3","label":"Rédaction","type":"branch"},
        {"id":"n4","label":"Procédés\nFigures de style","type":"leaf"},
        {"id":"n5","label":"Champs lexicaux\nRegistres","type":"leaf"},
        {"id":"n6","label":"Plan thématique\n2-3 axes","type":"leaf"},
        {"id":"n7","label":"Citation\nProcédé, Effet","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"observer"},
        {"from":"n1","to":"n3","label":"organiser"},
        {"from":"n2","to":"n4","label":"style"},
        {"from":"n2","to":"n5","label":"thèmes"},
        {"from":"n3","to":"n6","label":"structure"},
        {"from":"n3","to":"n7","label":"méthode"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le commentaire composé est organisé selon un plan :","options":["Linéaire (suivre le texte ligne par ligne)","Thématique (axes de lecture)","Chronologique","Alphabétique"],"correct":1,"explanation":"Le commentaire composé suit un plan thématique organisé en axes de lecture (et non un plan linéaire qui suivrait l''ordre du texte). Chaque axe aborde un aspect du texte."},
      {"id":"q2","question":"''Fort comme un lion'' est :","options":["Une métaphore","Une comparaison","Une hyperbole","Une litote"],"correct":1,"explanation":"C''est une comparaison car elle utilise l''outil de comparaison ''comme''. Une métaphore ne comporte pas d''outil de comparaison (ex : ''ce lion de courage'')."},
      {"id":"q3","question":"La paraphrase dans un commentaire est :","options":["Recommandée","Interdite (erreur à éviter)","Obligatoire","Optionnelle"],"correct":1,"explanation":"La paraphrase (redire le texte avec d''autres mots sans analyser) est une erreur majeure. Le commentaire doit ANALYSER les procédés et leurs effets, pas simplement reformuler le contenu."},
      {"id":"q4","question":"Le registre lyrique exprime :","options":["L''humour et la satire","Les sentiments personnels","Les exploits héroïques","Le surnaturel"],"correct":1,"explanation":"Le registre lyrique exprime les sentiments personnels de l''auteur ou du personnage : amour, nostalgie, joie, mélancolie. Il est caractéristique de la poésie romantique."},
      {"id":"q5","question":"Une antithèse est :","options":["Une répétition","L''opposition de deux idées","Une exagération","Un sous-entendu"],"correct":1,"explanation":"L''antithèse est l''opposition de deux idées, deux mots ou deux expressions pour créer un contraste. Exemple : ''Certains veulent vivre pour manger, moi je mange pour vivre.''"},
      {"id":"q6","question":"Dans l''analyse d''un procédé, il faut toujours :","options":["Juste nommer le procédé","Nommer le procédé ET expliquer son effet","Donner sa traduction","Compter le nombre de mots"],"correct":1,"explanation":"Identifier un procédé ne suffit pas. Il faut toujours expliquer l''EFFET qu''il produit sur le lecteur et le SENS qu''il apporte au texte."},
      {"id":"q7","question":"Un oxymore est :","options":["Une comparaison entre deux éléments","L''alliance de deux mots contradictoires","Une exagération volontaire","La répétition d''un son"],"correct":1,"explanation":"L''oxymore associe deux termes de sens opposé : ''obscure clarté'' (Corneille), ''silence assourdissant''. Il crée un effet de surprise et de tension."},
      {"id":"q8","question":"Le champ lexical de la mort comprend :","options":["Soleil, fleur, rire","Tombeau, funèbre, trépas, deuil","Courir, sauter, danser","Chiffre, calcul, nombre"],"correct":1,"explanation":"Le champ lexical de la mort regroupe les mots liés à ce thème : tombeau, funèbre, trépas, deuil, agonie, sépulture. Repérer un champ lexical permet d''identifier les thèmes du texte."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - CHAPTER 3: Le résumé et la discussion
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'resume-discussion', 3, 'Le résumé et la discussion', 'Techniques de résumé, contraction de texte, discussion', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'resume-discussion-fiche', 'Le résumé et la discussion', 'Contraction de texte et discussion', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Comment résumer un texte ?","answer":"1) Lire le texte entièrement pour comprendre le sens global. 2) Identifier les idées principales de chaque paragraphe. 3) Éliminer les exemples, les détails secondaires et les répétitions. 4) Reformuler les idées avec vos propres mots (pas de copier-coller). 5) Respecter l''ordre du texte original. 6) Respecter la limite de mots imposée (généralement 1/4 ou 1/3 du texte original). 7) Relire pour vérifier la fidélité et la cohérence."},
      {"id":"fc2","category":"Distinction","question":"Quelles sont les règles du résumé ?","answer":"À FAIRE : reformuler avec ses propres mots, garder l''ordre du texte, être fidèle aux idées de l''auteur, utiliser des connecteurs logiques, compter les mots. À NE PAS FAIRE : copier des phrases du texte, ajouter des idées personnelles, donner son avis, modifier la pensée de l''auteur, dépasser la limite de mots, utiliser ''l''auteur dit que'' (écrire directement)."},
      {"id":"fc3","category":"Méthode","question":"Comment rédiger une discussion ?","answer":"La discussion suit le résumé et porte sur une idée ou un thème du texte. Structure : 1) Introduction : présenter le sujet et la problématique. 2) Thèse : développer les arguments en faveur de l''idée (avec exemples). 3) Antithèse : nuancer ou critiquer l''idée (avec exemples). 4) Synthèse : donner son avis personnel argumenté. La discussion doit être personnelle mais argumentée."},
      {"id":"fc4","category":"Formule","question":"Comment compter les mots dans un résumé ?","answer":"Un mot est un ensemble de lettres entre deux espaces. Les articles (le, la, les, un) comptent pour 1 mot. Les mots composés avec trait d''union : chaque partie compte (c''est-à-dire = 4 mots). Les nombres en chiffres comptent pour 1 mot. Les sigles (ONU, CEDEAO) comptent pour 1 mot. Indiquer le nombre total de mots à la fin du résumé. Une tolérance de +/- 10% est généralement acceptée."},
      {"id":"fc5","category":"Méthode","question":"Comment identifier les idées principales d''un texte ?","answer":"1) Lire le titre et les sous-titres (s''il y en a). 2) Lire la première et la dernière phrase de chaque paragraphe. 3) Repérer les mots clés et les connecteurs logiques. 4) Distinguer l''essentiel (thèses, arguments) du secondaire (exemples, anecdotes, citations). 5) Résumer chaque paragraphe en une phrase. 6) Vérifier que les idées s''enchaînent logiquement."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que la fidélité au texte dans un résumé ?","answer":"La fidélité au texte signifie respecter la pensée de l''auteur sans la déformer. On ne doit ni ajouter d''idées personnelles, ni supprimer des idées importantes, ni modifier le point de vue de l''auteur. Si l''auteur est pour, le résumé doit refléter cette position. Les nuances de la pensée doivent être conservées. La fidélité n''interdit pas la reformulation : il faut dire la même chose avec d''autres mots."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre résumé et discussion ?","answer":"Le résumé est objectif : il reprend les idées de l''auteur sans ajouter d''avis personnel. Il est plus court que le texte original. La discussion est subjective : on prend position par rapport à une idée du texte, on argumente, on donne son avis avec des exemples personnels. Le résumé montre qu''on a compris le texte. La discussion montre qu''on est capable de réfléchir et d''argumenter."},
      {"id":"fc8","category":"Exemple","question":"Comment reformuler une phrase pour le résumé ?","answer":"Texte original : ''De nombreux experts estiment aujourd''hui que la déforestation massive en Afrique de l''Ouest constitue l''une des menaces les plus graves pour l''équilibre écologique de la région.'' Résumé : ''La déforestation en Afrique de l''Ouest menace gravement l''écologie régionale.'' On a éliminé ''de nombreux experts estiment'' (secondaire), ''aujourd''hui'' et ''massive'' (détails), et reformulé de manière concise en gardant l''idée essentielle."}
    ],
    "schema": {
      "title": "Le résumé et la discussion",
      "nodes": [
        {"id":"n1","label":"Résumé et\ndiscussion","type":"main"},
        {"id":"n2","label":"Résumé","type":"branch"},
        {"id":"n3","label":"Discussion","type":"branch"},
        {"id":"n4","label":"Reformulation\nFidélité","type":"leaf"},
        {"id":"n5","label":"Idées principales\nMots comptés","type":"leaf"},
        {"id":"n6","label":"Thèse\nAntithèse","type":"leaf"},
        {"id":"n7","label":"Avis personnel\nargumenté","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"objectif"},
        {"from":"n1","to":"n3","label":"subjectif"},
        {"from":"n2","to":"n4","label":"méthode"},
        {"from":"n2","to":"n5","label":"technique"},
        {"from":"n3","to":"n6","label":"structure"},
        {"from":"n3","to":"n7","label":"conclusion"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Dans un résumé, on doit :","options":["Ajouter ses idées personnelles","Copier des phrases du texte","Reformuler avec ses propres mots","Critiquer l''auteur"],"correct":2,"explanation":"Le résumé exige de reformuler les idées de l''auteur avec ses propres mots, sans copier, sans ajouter d''idées personnelles et en respectant la pensée originale."},
      {"id":"q2","question":"La limite de mots d''un résumé est généralement :","options":["La moitié du texte","Le tiers ou le quart du texte","Le double du texte","Illimitée"],"correct":1,"explanation":"Le résumé fait généralement entre 1/4 et 1/3 de la longueur du texte original. La consigne précise toujours le nombre de mots attendu."},
      {"id":"q3","question":"Dans un résumé, ''l''auteur dit que'' :","options":["Est obligatoire à chaque phrase","Est interdit","Est recommandé","Est utilisé une seule fois"],"correct":1,"explanation":"On ne doit pas écrire ''l''auteur dit que'' dans un résumé. On écrit directement les idées comme si elles étaient les nôtres, en reformulant. Le résumé reprend le discours de l''auteur à la première personne."},
      {"id":"q4","question":"La discussion est un exercice :","options":["Purement objectif","Subjectif et argumenté","De copie du texte","De traduction"],"correct":1,"explanation":"La discussion est un exercice personnel où l''élève prend position sur une idée du texte. Il doit argumenter avec des exemples et donner son avis de manière structurée."},
      {"id":"q5","question":"''C''est-à-dire'' compte pour combien de mots ?","options":["1 mot","2 mots","3 mots","4 mots"],"correct":3,"explanation":"''C''est-à-dire'' compte pour 4 mots : c'' (1) + est (2) + à (3) + dire (4). Chaque élément séparé par un trait d''union ou une apostrophe est compté séparément."},
      {"id":"q6","question":"Dans un résumé, les exemples du texte original doivent être :","options":["Tous conservés","Généralement éliminés","Ajoutés en plus grand nombre","Traduits en anglais"],"correct":1,"explanation":"Les exemples, anecdotes et détails secondaires sont généralement éliminés dans le résumé. On ne garde que les idées principales et les arguments essentiels."},
      {"id":"q7","question":"La structure de la discussion comprend :","options":["Résumé, analyse, conclusion","Introduction, thèse, antithèse, synthèse","Titre, sous-titres, notes","Sujet, verbe, complément"],"correct":1,"explanation":"La discussion suit un plan argumentatif : introduction (problématique), thèse (arguments pour), antithèse (arguments contre ou nuances), synthèse (avis personnel argumenté)."},
      {"id":"q8","question":"Être fidèle au texte dans un résumé signifie :","options":["Copier le texte mot à mot","Respecter la pensée de l''auteur sans la déformer","Ajouter des précisions","Changer l''ordre des idées"],"correct":1,"explanation":"La fidélité consiste à respecter les idées et le point de vue de l''auteur, sans les déformer, les amplifier ou les minimiser. On reformule mais on ne trahit pas la pensée originale."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - CHAPTER 4: Les genres littéraires
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'genres-litteraires', 4, 'Les genres littéraires', 'Roman, poésie, théâtre, conte', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'genres-litteraires-fiche', 'Les genres littéraires', 'Roman, poésie, théâtre et littérature africaine', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quels sont les principaux genres littéraires ?","answer":"Le roman : récit fictif en prose, avec des personnages et une intrigue. La poésie : texte en vers (ou prose poétique) qui joue sur le rythme, les sons et les images. Le théâtre : texte écrit pour être joué, composé de dialogues et didascalies. Le conte : récit court, souvent merveilleux, avec une morale. L''essai : texte argumentatif qui expose des idées. La nouvelle : récit bref avec une chute."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les sous-genres du roman ?","answer":"Roman réaliste : représentation fidèle de la société (Balzac, Flaubert). Roman naturaliste : déterminisme social et biologique (Zola). Roman psychologique : analyse des sentiments (Mme de La Fayette). Roman d''aventures : actions et péripéties (Dumas). Roman autobiographique : l''auteur raconte sa propre vie. Roman engagé : dénonce des injustices (Sembène Ousmane). Roman épistolaire : composé de lettres."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la négritude ?","answer":"La négritude est un mouvement littéraire et culturel né dans les années 1930, fondé par Aimé Césaire (Martinique), Léopold Sédar Senghor (Sénégal) et Léon-Gontran Damas (Guyane). Il affirme la dignité des cultures noires face au colonialisme. La négritude revendique l''identité africaine, valorise les traditions et dénonce l''aliénation culturelle. Senghor : ''L''émotion est nègre, comme la raison est hellène'' (formule controversée)."},
      {"id":"fc4","category":"Exemple","question":"Quels sont les auteurs africains importants au programme ?","answer":"Sembène Ousmane (Sénégal) : Les bouts de bois de Dieu (grève du chemin de fer). Camara Laye (Guinée) : L''enfant noir (autobiographie). Amadou Hampâté Bâ (Mali) : Amkoullel, l''enfant peul. Ahmadou Kourouma (Côte d''Ivoire) : Les soleils des indépendances. Mongo Beti (Cameroun) : Le pauvre Christ de Bomba. Chinua Achebe (Nigeria) : Le monde s''effondre. Bernard Dadié (Côte d''Ivoire) : Le pagne noir."},
      {"id":"fc5","category":"Distinction","question":"Quels sont les genres théâtraux ?","answer":"La tragédie : personnages nobles, fatalité, issue funeste (Corneille, Racine). La comédie : situations amusantes, critique des mœurs, issue heureuse (Molière). Le drame : mélange du comique et du tragique (Hugo, Victor). La farce : comique grossier, gestes exagérés. Le théâtre de l''absurde : remise en question du sens (Beckett, Ionesco). Le théâtre africain : tradition orale, griot, mise en scène des conflits sociaux."},
      {"id":"fc6","category":"Formule","question":"Quelles sont les formes poétiques ?","answer":"Le sonnet : 14 vers (2 quatrains + 2 tercets), rimes ABBA ABBA CCD EDE. L''alexandrin : vers de 12 syllabes. L''octosyllabe : vers de 8 syllabes. Le vers libre : pas de contrainte de rythme ni de rime (poésie moderne). La prose poétique : texte en prose avec des effets poétiques (rythme, images). Les rimes : plates (AABB), croisées (ABAB), embrassées (ABBA)."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que le réalisme en littérature ?","answer":"Le réalisme (milieu XIXe siècle) vise à représenter la réalité quotidienne de manière fidèle et objective. Caractéristiques : description détaillée de la société, personnages ordinaires, étude des milieux sociaux, langage simple. Auteurs : Balzac (La Comédie humaine), Flaubert (Madame Bovary), Stendhal (Le Rouge et le Noir). Le naturalisme de Zola pousse le réalisme plus loin avec une approche scientifique (Germinal)."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que le conte africain et ses caractéristiques ?","answer":"Le conte africain est un récit oral traditionnel transmis de génération en génération par les griots. Caractéristiques : 1) Personnages symboliques (animaux rusés comme l''hyène et le lièvre). 2) Morale ou leçon de vie. 3) Dimension collective (raconté en soirée devant la communauté). 4) Formules d''ouverture et de clôture spécifiques. 5) Rôle éducatif et social. Les contes d''Amadou Hampâté Bâ et de Birago Diop sont des exemples majeurs."}
    ],
    "schema": {
      "title": "Les genres littéraires",
      "nodes": [
        {"id":"n1","label":"Genres\nlittéraires","type":"main"},
        {"id":"n2","label":"Prose","type":"branch"},
        {"id":"n3","label":"Poésie","type":"branch"},
        {"id":"n4","label":"Théâtre","type":"branch"},
        {"id":"n5","label":"Roman\nConte, Nouvelle","type":"leaf"},
        {"id":"n6","label":"Sonnet\nVers libre","type":"leaf"},
        {"id":"n7","label":"Tragédie\nComédie, Drame","type":"leaf"},
        {"id":"n8","label":"Négritude\nLittérature africaine","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"récits"},
        {"from":"n1","to":"n3","label":"vers"},
        {"from":"n1","to":"n4","label":"scène"},
        {"from":"n2","to":"n5","label":"formes"},
        {"from":"n3","to":"n6","label":"formes"},
        {"from":"n4","to":"n7","label":"genres"},
        {"from":"n1","to":"n8","label":"Afrique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La négritude a été fondée par :","options":["Victor Hugo et Zola","Césaire, Senghor et Damas","Molière et Racine","Flaubert et Balzac"],"correct":1,"explanation":"La négritude a été fondée dans les années 1930 par Aimé Césaire, Léopold Sédar Senghor et Léon-Gontran Damas. Ce mouvement affirme l''identité et la dignité des cultures noires."},
      {"id":"q2","question":"Un sonnet comprend :","options":["10 vers","12 vers","14 vers","16 vers"],"correct":2,"explanation":"Le sonnet est un poème de 14 vers : 2 quatrains (4 vers chacun) et 2 tercets (3 vers chacun), avec un schéma de rimes précis."},
      {"id":"q3","question":"Sembène Ousmane a écrit :","options":["L''enfant noir","Les bouts de bois de Dieu","Le monde s''effondre","Amkoullel, l''enfant peul"],"correct":1,"explanation":"Sembène Ousmane est l''auteur des ''Bouts de bois de Dieu'' (1960), roman qui raconte la grève des cheminots du Dakar-Niger en 1947-1948."},
      {"id":"q4","question":"Le réalisme en littérature vise à :","options":["Représenter un monde imaginaire","Représenter fidèlement la réalité","Écrire uniquement en vers","Raconter des mythes"],"correct":1,"explanation":"Le réalisme cherche à représenter la réalité quotidienne de manière fidèle, avec des descriptions détaillées de la société et des personnages ordinaires."},
      {"id":"q5","question":"Le vers de 12 syllabes s''appelle :","options":["L''octosyllabe","Le décasyllabe","L''alexandrin","Le pentamètre"],"correct":2,"explanation":"L''alexandrin est un vers de 12 syllabes, divisé en deux hémistiches de 6 syllabes par une césure. C''est le vers classique de la poésie française."},
      {"id":"q6","question":"La comédie se caractérise par :","options":["Une issue funeste","Des personnages nobles soumis au destin","Des situations amusantes et une issue heureuse","Le mélange des registres"],"correct":2,"explanation":"La comédie met en scène des situations amusantes, critique les mœurs et les défauts humains, et se termine généralement bien (mariage, réconciliation)."},
      {"id":"q7","question":"Le conte africain est traditionnellement transmis par :","options":["Les journaux","Les griots (tradition orale)","Les manuels scolaires","La télévision"],"correct":1,"explanation":"Le conte africain est un genre oral transmis par les griots de génération en génération. Il joue un rôle éducatif et social fondamental dans les sociétés africaines."},
      {"id":"q8","question":"Les rimes ABAB sont appelées :","options":["Rimes plates","Rimes croisées","Rimes embrassées","Rimes libres"],"correct":1,"explanation":"Rimes plates : AABB. Rimes croisées : ABAB. Rimes embrassées : ABBA. Les rimes croisées alternent deux sons différents."}
    ]
  }');

  -- ============================================================
  -- ECM - CHAPTER 1: Sécurité et civisme au Mali
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (ecm_id, 'securite-civisme', 1, 'Sécurité et civisme au Mali', 'Civisme, droits, devoirs, sécurité nationale', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'securite-civisme-fiche', 'Sécurité et civisme au Mali', 'Droits, devoirs et sécurité du citoyen malien', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le civisme ?","answer":"Le civisme est l''attitude du bon citoyen qui respecte les lois, accomplit ses devoirs envers la communauté et participe à la vie publique. Il comprend : le respect des lois et des institutions, le paiement des impôts, le vote, le respect du bien public, la participation à la défense nationale, le respect de l''environnement. Le civisme est essentiel pour le bon fonctionnement de la démocratie et la cohésion sociale au Mali."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les droits et devoirs du citoyen malien ?","answer":"Droits : droit à la vie, liberté d''expression, droit à l''éducation, droit de vote, liberté de mouvement, droit au travail, droit à la santé, égalité devant la loi. Devoirs : respecter les lois, payer les impôts, défendre la patrie, respecter les droits d''autrui, protéger l''environnement, contribuer au développement national. Les droits et devoirs sont inséparables : pas de droits sans devoirs."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la sécurité nationale ?","answer":"La sécurité nationale est l''ensemble des mesures prises par l''État pour protéger le territoire, les institutions et les citoyens contre les menaces internes et externes. Au Mali, les défis sécuritaires comprennent : le terrorisme au nord et au centre, les conflits intercommunautaires, la criminalité organisée, le trafic de drogue. Les forces de sécurité : armée (FAMa), gendarmerie, police, garde nationale. La sécurité est l''affaire de tous les citoyens."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que la citoyenneté responsable ?","answer":"La citoyenneté responsable va au-delà du simple respect des lois. Elle implique : participer activement à la vie de la communauté, s''informer sur les questions publiques, voter de manière éclairée, dénoncer les injustices, promouvoir la tolérance et le dialogue, protéger les biens publics, être solidaire des plus vulnérables. Au Mali, la citoyenneté responsable passe aussi par le respect des valeurs traditionnelles de solidarité et d''entraide."},
      {"id":"fc5","category":"Méthode","question":"Comment contribuer à la sécurité de sa communauté ?","answer":"1) Signaler les comportements suspects aux autorités. 2) Respecter les règles de sécurité routière. 3) Refuser de participer à des activités illégales. 4) Promouvoir le dialogue intercommunautaire. 5) Participer aux initiatives locales de sécurité. 6) Éduquer les jeunes sur les dangers de l''extrémisme. 7) Soutenir les forces de sécurité dans leur mission. 8) Préserver la cohésion sociale et le vivre-ensemble."},
      {"id":"fc6","category":"Exemple","question":"Qu''est-ce que la protection civile ?","answer":"La protection civile est l''ensemble des mesures de protection des populations face aux catastrophes (inondations, incendies, épidémies). Au Mali, la Direction Générale de la Protection Civile coordonne les secours. Mesures : plans d''évacuation, premiers secours, éducation aux risques, gestion des catastrophes naturelles. Chaque citoyen doit connaître les gestes de premiers secours et les numéros d''urgence."},
      {"id":"fc7","category":"Concept","question":"Qu''est-ce que la culture de la paix ?","answer":"La culture de la paix est un ensemble de valeurs, attitudes et comportements qui rejettent la violence et préviennent les conflits. Elle promeut : le dialogue, la tolérance, le respect de la diversité, la non-violence, la coopération. Au Mali, l''Accord pour la paix et la réconciliation issu du processus d''Alger (2015) vise à rétablir la paix et l''unité nationale. La culture de la paix s''enseigne à l''école et dans les familles."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre patriotisme et nationalisme ?","answer":"Le patriotisme est l''amour raisonné de son pays, le désir de le servir et de le défendre tout en respectant les autres nations. Il est positif et inclusif. Le nationalisme excessif est le sentiment de supériorité de sa nation sur les autres, qui peut mener à l''intolérance et aux conflits. Au Mali, le patriotisme se manifeste par la fierté de l''histoire et de la culture malienne, le respect des symboles nationaux et l''engagement pour le développement."}
    ],
    "schema": {
      "title": "Sécurité et civisme au Mali",
      "nodes": [
        {"id":"n1","label":"Civisme et\nsécurité","type":"main"},
        {"id":"n2","label":"Civisme","type":"branch"},
        {"id":"n3","label":"Sécurité","type":"branch"},
        {"id":"n4","label":"Droits et\ndevoirs","type":"leaf"},
        {"id":"n5","label":"Citoyenneté\nresponsable","type":"leaf"},
        {"id":"n6","label":"Sécurité\nnationale","type":"leaf"},
        {"id":"n7","label":"Culture de\nla paix","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"citoyen"},
        {"from":"n1","to":"n3","label":"protection"},
        {"from":"n2","to":"n4","label":"constitution"},
        {"from":"n2","to":"n5","label":"engagement"},
        {"from":"n3","to":"n6","label":"défense"},
        {"from":"n3","to":"n7","label":"prévention"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le civisme implique :","options":["Uniquement le paiement des impôts","Le respect des lois et la participation à la vie publique","L''obéissance aveugle","Le rejet des traditions"],"correct":1,"explanation":"Le civisme est l''attitude du bon citoyen qui respecte les lois, accomplit ses devoirs et participe activement à la vie publique de son pays."},
      {"id":"q2","question":"Quel est le premier devoir du citoyen ?","options":["Payer des impôts élevés","Respecter les lois de la République","Être riche","Voyager à l''étranger"],"correct":1,"explanation":"Le respect des lois est le premier devoir fondamental du citoyen. Sans respect des lois, il n''y a pas d''ordre social ni de démocratie possible."},
      {"id":"q3","question":"L''Accord pour la paix au Mali est issu du processus de :","options":["Bamako","Alger","Paris","Abidjan"],"correct":1,"explanation":"L''Accord pour la paix et la réconciliation au Mali est issu du processus d''Alger et a été signé en 2015. Il vise à rétablir la paix et l''unité nationale."},
      {"id":"q4","question":"La protection civile concerne :","options":["Uniquement les militaires","La protection des populations face aux catastrophes","La vie politique","Le commerce international"],"correct":1,"explanation":"La protection civile protège les populations contre les catastrophes naturelles et industrielles : inondations, incendies, épidémies, etc."},
      {"id":"q5","question":"Le patriotisme se distingue du nationalisme excessif par :","options":["Son rejet total de son pays","Son respect des autres nations","Son sentiment de supériorité","Son indifférence"],"correct":1,"explanation":"Le patriotisme est l''amour de son pays tout en respectant les autres nations. Le nationalisme excessif affirme la supériorité de sa nation et peut mener à l''intolérance."},
      {"id":"q6","question":"Les droits et les devoirs du citoyen sont :","options":["Indépendants l''un de l''autre","Inséparables","Uniquement des droits","Uniquement des devoirs"],"correct":1,"explanation":"Les droits et les devoirs sont inséparables : tout droit implique un devoir correspondant. On ne peut revendiquer des droits sans assumer ses devoirs envers la communauté."},
      {"id":"q7","question":"La culture de la paix promeut principalement :","options":["La violence comme moyen de résolution","Le dialogue et la tolérance","L''isolement des communautés","La domination d''un groupe"],"correct":1,"explanation":"La culture de la paix promeut le dialogue, la tolérance, le respect de la diversité et la non-violence comme moyens de prévention et de résolution des conflits."},
      {"id":"q8","question":"Les forces de sécurité du Mali comprennent :","options":["Uniquement la police","L''armée, la gendarmerie, la police et la garde nationale","Uniquement l''armée","Les milices privées"],"correct":1,"explanation":"Les forces de sécurité du Mali comprennent les Forces Armées Maliennes (FAMa), la gendarmerie nationale, la police nationale et la garde nationale."}
    ]
  }');

  -- ============================================================
  -- ECM - CHAPTER 2: Démocratie et institutions
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (ecm_id, 'democratie-institutions', 2, 'Démocratie et institutions', 'Constitution, pouvoirs, organisations', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'democratie-institutions-fiche', 'Démocratie et institutions', 'La démocratie et les institutions au Mali', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la démocratie ?","answer":"La démocratie est un régime politique dans lequel le pouvoir appartient au peuple. Étymologie : demos (peuple) + kratos (pouvoir). Formes : démocratie directe (le peuple vote directement les lois) et démocratie représentative (le peuple élit des représentants). Principes : souveraineté du peuple, séparation des pouvoirs, pluralisme politique, respect des droits de l''homme, État de droit. Le Mali est une démocratie depuis 1992."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les trois pouvoirs dans une démocratie ?","answer":"Pouvoir législatif : fait les lois (Assemblée nationale au Mali). Pouvoir exécutif : applique les lois (Président de la République et Gouvernement). Pouvoir judiciaire : juge selon les lois (tribunaux, cours). La séparation des pouvoirs (Montesquieu) empêche la concentration du pouvoir et protège les libertés. Chaque pouvoir contrôle les autres (checks and balances)."},
      {"id":"fc3","category":"Concept","question":"Qu''est-ce que la Constitution du Mali ?","answer":"La Constitution est la loi fondamentale qui organise les pouvoirs de l''État et garantit les droits des citoyens. Elle est supérieure à toutes les autres lois. La Constitution du Mali (adoptée par référendum en 1992) consacre : la République, la démocratie, la laïcité, les droits fondamentaux, la séparation des pouvoirs. Elle a été révisée en 2023. La Cour constitutionnelle veille au respect de la Constitution."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que l''État de droit ?","answer":"L''État de droit est un système dans lequel les pouvoirs publics sont soumis au droit. Personne n''est au-dessus de la loi, pas même le chef de l''État. Principes : hiérarchie des normes (Constitution > lois > décrets), indépendance de la justice, égalité devant la loi, protection des droits fondamentaux. L''État de droit s''oppose à l''arbitraire et garantit les libertés individuelles."},
      {"id":"fc5","category":"Distinction","question":"Quelles sont les organisations internationales auxquelles le Mali appartient ?","answer":"ONU : Organisation des Nations Unies (paix et coopération mondiale). UA : Union Africaine (coopération continentale). CEDEAO : Communauté Économique des États de l''Afrique de l''Ouest (intégration économique régionale). UEMOA : Union Économique et Monétaire Ouest-Africaine (monnaie commune FCFA). OCI : Organisation de la Coopération Islamique. AES : Alliance des États du Sahel (Mali, Burkina Faso, Niger)."},
      {"id":"fc6","category":"Concept","question":"Qu''est-ce que le suffrage universel ?","answer":"Le suffrage universel est le droit de vote accordé à tous les citoyens majeurs sans discrimination de sexe, de race, de religion ou de fortune. Au Mali, le droit de vote est accordé à tout citoyen malien âgé de 18 ans révolus et jouissant de ses droits civiques. Le vote est un droit ET un devoir civique. Il peut être direct (le peuple vote pour ses représentants) ou indirect (vote par des grands électeurs)."},
      {"id":"fc7","category":"Méthode","question":"Comment fonctionne le processus électoral au Mali ?","answer":"1) Inscription sur les listes électorales. 2) Campagne électorale des candidats. 3) Jour du scrutin : les citoyens votent dans les bureaux de vote. 4) Dépouillement et proclamation des résultats provisoires. 5) Examen des recours éventuels par la Cour constitutionnelle. 6) Proclamation des résultats définitifs. Les élections doivent être libres, transparentes et démocratiques. L''observation électorale garantit la régularité."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce que la décentralisation au Mali ?","answer":"La décentralisation est le transfert de compétences de l''État central vers les collectivités territoriales (régions, cercles, communes). Au Mali, la décentralisation vise à rapprocher l''administration des citoyens et à favoriser le développement local. Les collectivités sont dirigées par des élus locaux (maires, conseillers). Elles gèrent l''éducation, la santé, l''eau et l''assainissement au niveau local. La décentralisation est un enjeu majeur de la gouvernance malienne."}
    ],
    "schema": {
      "title": "Démocratie et institutions",
      "nodes": [
        {"id":"n1","label":"Démocratie\net institutions","type":"main"},
        {"id":"n2","label":"Principes","type":"branch"},
        {"id":"n3","label":"Institutions","type":"branch"},
        {"id":"n4","label":"Souveraineté\nÉtat de droit","type":"leaf"},
        {"id":"n5","label":"Séparation\ndes pouvoirs","type":"leaf"},
        {"id":"n6","label":"Constitution\nÉlections","type":"leaf"},
        {"id":"n7","label":"Organisations\ninternationales","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"fondements"},
        {"from":"n1","to":"n3","label":"organisation"},
        {"from":"n2","to":"n4","label":"valeurs"},
        {"from":"n2","to":"n5","label":"Montesquieu"},
        {"from":"n3","to":"n6","label":"Mali"},
        {"from":"n3","to":"n7","label":"coopération"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le pouvoir législatif au Mali est exercé par :","options":["Le Président","L''Assemblée nationale","Les tribunaux","L''armée"],"correct":1,"explanation":"Le pouvoir législatif (faire les lois) est exercé par l''Assemblée nationale. Le Président exerce le pouvoir exécutif, et les tribunaux le pouvoir judiciaire."},
      {"id":"q2","question":"La séparation des pouvoirs a été théorisée par :","options":["Rousseau","Voltaire","Montesquieu","Marx"],"correct":2,"explanation":"Montesquieu a théorisé la séparation des pouvoirs dans ''De l''esprit des lois'' (1748). Il distingue le législatif, l''exécutif et le judiciaire pour éviter la tyrannie."},
      {"id":"q3","question":"L''âge minimum pour voter au Mali est :","options":["16 ans","18 ans","21 ans","25 ans"],"correct":1,"explanation":"Au Mali, tout citoyen âgé de 18 ans révolus et jouissant de ses droits civiques peut voter. Le suffrage universel est un principe fondamental de la démocratie."},
      {"id":"q4","question":"La CEDEAO est :","options":["Une organisation mondiale","Une communauté économique ouest-africaine","Une banque internationale","Un parti politique"],"correct":1,"explanation":"La CEDEAO (Communauté Économique des États de l''Afrique de l''Ouest) est une organisation d''intégration économique régionale regroupant les pays d''Afrique de l''Ouest."},
      {"id":"q5","question":"La Constitution est :","options":["Une loi ordinaire","La loi fondamentale de l''État","Un décret présidentiel","Un règlement intérieur"],"correct":1,"explanation":"La Constitution est la loi fondamentale qui organise les pouvoirs de l''État et garantit les droits des citoyens. Elle est supérieure à toutes les autres lois."},
      {"id":"q6","question":"L''État de droit signifie que :","options":["L''État a tous les droits","Personne n''est au-dessus de la loi","Seul le président fait les lois","Les lois n''existent pas"],"correct":1,"explanation":"L''État de droit signifie que tous, y compris les gouvernants, sont soumis au droit. Personne n''est au-dessus de la loi. C''est une garantie contre l''arbitraire."},
      {"id":"q7","question":"La décentralisation vise à :","options":["Centraliser tous les pouvoirs","Rapprocher l''administration des citoyens","Supprimer les communes","Privatiser les services publics"],"correct":1,"explanation":"La décentralisation transfère des compétences de l''État central vers les collectivités locales pour rapprocher l''administration des citoyens et favoriser le développement local."},
      {"id":"q8","question":"Le Mali est membre de l''Alliance des États du Sahel (AES) avec :","options":["Le Sénégal et la Guinée","Le Burkina Faso et le Niger","La Côte d''Ivoire et le Ghana","Le Maroc et la Tunisie"],"correct":1,"explanation":"L''Alliance des États du Sahel (AES) regroupe le Mali, le Burkina Faso et le Niger. Cette alliance vise la coopération sécuritaire et le développement dans la région sahélienne."}
    ]
  }');

  -- ============================================================
  -- EPS - CHAPTER 1: Pratique sportive
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (eps_id, 'pratique-sportive', 1, 'Pratique sportive', 'Athlétisme, sports collectifs, évaluation', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'pratique-sportive-fiche', 'Pratique sportive', 'Athlétisme, sports collectifs et préparation physique', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelles sont les disciplines d''athlétisme au bac ?","answer":"Courses : 100 m (vitesse), 200 m (vitesse), 800 m (demi-fond), 1500 m (demi-fond), relais 4x100 m. Sauts : saut en longueur, saut en hauteur, triple saut. Lancers : poids (garçons 5 kg, filles 3 kg), disque, javelot. L''évaluation porte sur la performance (barème) et la maîtrise technique. L''entraînement régulier est essentiel pour progresser."},
      {"id":"fc2","category":"Méthode","question":"Comment bien se préparer au 100 m ?","answer":"1) Échauffement : 10-15 min de course légère, étirements dynamiques. 2) Position de départ : pieds dans les starting-blocks, genoux fléchis. 3) Phase d''accélération : corps penché en avant, mouvements de bras puissants. 4) Phase de vitesse maximale : corps redressé, foulées amples. 5) Arrivée : ne pas ralentir avant la ligne. Conseils : travailler les départs, le gainage et la fréquence gestuelle."},
      {"id":"fc3","category":"Méthode","question":"Quelles sont les techniques du saut en longueur ?","answer":"Phases : 1) Course d''élan : accélération progressive sur 30-40 m, repères visuels. 2) Impulsion : pied d''appel sur la planche, genou libre vers l''avant, bras levés. 3) Suspension : techniques en extension, en ciseaux ou en groupé. 4) Réception : pieds joints vers l''avant, genoux fléchis, bras en avant. Erreurs à éviter : regarder la planche (perte de vitesse), piétiner avant l''appel."},
      {"id":"fc4","category":"Distinction","question":"Quelles sont les règles principales du football ?","answer":"Terrain : 90-120 m x 45-90 m. Équipes : 11 joueurs. Durée : 2 x 45 min. But : marquer plus que l''adversaire. Règles clés : hors-jeu, fautes (coup franc, penalty dans la surface), cartons jaune/rouge, touche (à la main), corner, coup de pied de but. Rôles : gardien, défenseurs, milieux, attaquants. Sports collectifs au bac : football, basketball, handball, volleyball."},
      {"id":"fc5","category":"Concept","question":"Qu''est-ce que l''esprit sportif ?","answer":"L''esprit sportif (fair-play) est l''attitude du sportif qui respecte les règles, l''adversaire, l''arbitre et les équipiers. Il comprend : accepter la défaite avec dignité, féliciter le vainqueur, ne pas tricher, ne pas être violent, encourager ses coéquipiers, respecter les décisions de l''arbitre. L''esprit sportif est une valeur éducative fondamentale de l''EPS et une compétence évaluée au bac."},
      {"id":"fc6","category":"Formule","question":"Comment calcule-t-on l''Indice de Masse Corporelle (IMC) ?","answer":"IMC = masse (kg) / taille^2 (m2). Interprétation : IMC < 18,5 : insuffisance pondérale. 18,5 <= IMC < 25 : corpulence normale. 25 <= IMC < 30 : surpoids. IMC >= 30 : obésité. Exemple : masse = 70 kg, taille = 1,75 m. IMC = 70 / (1,75)^2 = 70 / 3,0625 = 22,9 (normal). L''IMC est un indicateur simple mais ne tient pas compte de la masse musculaire."},
      {"id":"fc7","category":"Méthode","question":"Comment s''échauffer correctement avant un effort ?","answer":"L''échauffement prépare le corps à l''effort et prévient les blessures. 3 phases : 1) Échauffement général (10 min) : course légère, montées de genoux, talons-fesses. 2) Échauffement articulaire : rotations des chevilles, genoux, hanches, épaules. 3) Échauffement spécifique : exercices liés à l''activité pratiquée (gammes pour le sprint, frappes pour le foot). Augmenter progressivement l''intensité. Ne jamais commencer un effort intense à froid."},
      {"id":"fc8","category":"Concept","question":"Quels sont les critères d''évaluation en EPS au bac ?","answer":"L''évaluation en EPS porte sur : 1) La performance : résultat mesuré (temps, distance, score) évalué selon un barème national. 2) La maîtrise technique : qualité d''exécution des gestes techniques. 3) L''investissement : assiduité, participation, progrès. 4) Les connaissances théoriques : règles, hygiène, physiologie. La note d''EPS compte au bac avec un coefficient 1."}
    ],
    "schema": {
      "title": "Pratique sportive",
      "nodes": [
        {"id":"n1","label":"Pratique\nsportive","type":"main"},
        {"id":"n2","label":"Athlétisme","type":"branch"},
        {"id":"n3","label":"Sports\ncollectifs","type":"branch"},
        {"id":"n4","label":"Courses\nSauts, Lancers","type":"leaf"},
        {"id":"n5","label":"Football\nBasketball","type":"leaf"},
        {"id":"n6","label":"Préparation\nÉchauffement","type":"leaf"},
        {"id":"n7","label":"Évaluation\nPerformance","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"individuel"},
        {"from":"n1","to":"n3","label":"équipe"},
        {"from":"n2","to":"n4","label":"disciplines"},
        {"from":"n3","to":"n5","label":"sports"},
        {"from":"n1","to":"n6","label":"préparation"},
        {"from":"n1","to":"n7","label":"bac"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le poids lancé par les garçons au bac pèse :","options":["3 kg","4 kg","5 kg","7 kg"],"correct":2,"explanation":"Au baccalauréat malien, le poids pour les garçons est de 5 kg et pour les filles de 3 kg."},
      {"id":"q2","question":"L''échauffement avant l''effort sert principalement à :","options":["Perdre du poids","Préparer le corps et prévenir les blessures","Montrer sa force","Se reposer"],"correct":1,"explanation":"L''échauffement augmente la température corporelle, prépare les muscles et les articulations à l''effort, et réduit le risque de blessures."},
      {"id":"q3","question":"L''IMC d''une personne de 60 kg mesurant 1,70 m est environ :","options":["17,6","20,8","25,3","30,1"],"correct":1,"explanation":"IMC = 60 / (1,70)^2 = 60 / 2,89 = 20,8. C''est dans la plage de corpulence normale (18,5-25)."},
      {"id":"q4","question":"Au football, le hors-jeu se produit quand :","options":["Un joueur est dans sa propre moitié de terrain","Un joueur est plus près du but adverse que le ballon et l''avant-dernier défenseur au moment de la passe","Un joueur touche le ballon de la main","Un joueur sort du terrain"],"correct":1,"explanation":"Le hors-jeu est signalé quand un joueur attaquant est plus proche de la ligne de but adverse que le ballon et l''avant-dernier défenseur au moment où le ballon est joué par un coéquipier."},
      {"id":"q5","question":"L''esprit sportif (fair-play) comprend :","options":["Tricher pour gagner","Respecter l''adversaire et l''arbitre","Insulter l''adversaire","Refuser de jouer si on perd"],"correct":1,"explanation":"L''esprit sportif est le respect des règles, de l''adversaire, de l''arbitre et de ses coéquipiers. C''est une valeur fondamentale du sport et de l''EPS."},
      {"id":"q6","question":"En saut en longueur, l''impulsion se fait :","options":["Avec les deux pieds","Avec un seul pied sur la planche d''appel","En courant","Sans élan"],"correct":1,"explanation":"L''impulsion en saut en longueur se fait avec un seul pied (le pied d''appel) sur la planche d''appel. L''autre genou (jambe libre) est poussé vers l''avant et le haut."},
      {"id":"q7","question":"Le 800 m est une course de :","options":["Vitesse","Demi-fond","Fond","Sprint"],"correct":1,"explanation":"Le 800 m est une course de demi-fond qui combine vitesse et endurance. Il nécessite une bonne gestion de l''effort et une stratégie de course."},
      {"id":"q8","question":"L''évaluation en EPS au bac porte sur :","options":["Uniquement la performance","Performance, technique, investissement et connaissances","Uniquement la théorie","Uniquement l''assiduité"],"correct":1,"explanation":"L''évaluation en EPS est globale : performance mesurée, maîtrise technique, investissement personnel (assiduité, progrès) et connaissances théoriques."}
    ]
  }');

  -- ============================================================
  -- EPS - CHAPTER 2: Hygiène et physiologie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (eps_id, 'hygiene-physiologie', 2, 'Hygiène et physiologie', 'Alimentation, hydratation, récupération, dopage', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'hygiene-physiologie-fiche', 'Hygiène et physiologie', 'Alimentation, hygiène de vie et physiologie du sport', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Concept","question":"Quelle est l''importance de l''alimentation pour le sportif ?","answer":"L''alimentation fournit l''énergie nécessaire à l''effort physique. Les macronutriments : glucides (55-60% de l''apport, énergie rapide), lipides (25-30%, énergie de réserve), protéines (12-15%, construction et réparation musculaire). Les micronutriments : vitamines et minéraux (fer, calcium, magnésium). Un sportif doit manger équilibré, 3 repas par jour, avec des collations si nécessaire. Au Mali, le riz, le mil, les légumes et le poisson fournissent une alimentation équilibrée."},
      {"id":"fc2","category":"Concept","question":"Pourquoi l''hydratation est-elle essentielle pendant l''effort ?","answer":"Le corps perd de l''eau par la transpiration pendant l''effort (0,5 à 2 litres par heure). La déshydratation diminue les performances et peut être dangereuse (coup de chaleur). Règles : boire avant la soif, par petites gorgées régulières. Avant l''effort : 500 mL dans les 2 heures précédentes. Pendant : 150-200 mL toutes les 15-20 minutes. Après : compenser les pertes. L''eau est la meilleure boisson pour le sportif."},
      {"id":"fc3","category":"Distinction","question":"Quels sont les types de filières énergétiques ?","answer":"Filière anaérobie alactique (ATP-CP) : effort très intense et très court (0-10 s). Exemple : sprint 100 m, lancer. Pas de production d''acide lactique. Filière anaérobie lactique (glycolyse) : effort intense et court (10 s - 2 min). Exemple : 400 m. Produit de l''acide lactique (fatigue musculaire). Filière aérobie : effort modéré et prolongé (> 2 min). Exemple : course de fond. Utilise l''oxygène, endurance."},
      {"id":"fc4","category":"Concept","question":"Qu''est-ce que le dopage et pourquoi est-il interdit ?","answer":"Le dopage est l''utilisation de substances ou de méthodes interdites pour améliorer artificiellement les performances sportives. Produits interdits : stéroïdes anabolisants, EPO, stimulants, hormones de croissance. Dangers : problèmes cardiaques, hépatiques, rénaux, troubles hormonaux, dépendance, mort. Le dopage est interdit car il est dangereux pour la santé, contraire à l''éthique sportive et fausse la compétition. L''AMA (Agence Mondiale Antidopage) lutte contre le dopage."},
      {"id":"fc5","category":"Méthode","question":"Comment récupérer après un effort intense ?","answer":"1) Récupération active : marche, jogging léger (10 min) pour éliminer l''acide lactique. 2) Étirements doux (pas de rebonds). 3) Hydratation : boire abondamment. 4) Alimentation : glucides dans les 30 min (fenêtre métabolique) + protéines. 5) Repos : sommeil suffisant (8-9 heures pour un adolescent sportif). 6) Soins : douche, massage si possible. La récupération est aussi importante que l''entraînement."},
      {"id":"fc6","category":"Formule","question":"Comment calcule-t-on la fréquence cardiaque maximale ?","answer":"Formule d''Astrand : FC max = 220 - âge. Pour un élève de 18 ans : FC max = 220 - 18 = 202 bpm. Zones d''entraînement : 50-60% FC max : échauffement, récupération. 60-70% : endurance fondamentale. 70-80% : endurance active. 80-90% : seuil anaérobie. 90-100% : effort maximal. La fréquence cardiaque de repos est normalement entre 60 et 80 bpm."},
      {"id":"fc7","category":"Concept","question":"Quels sont les bienfaits de l''activité physique sur la santé ?","answer":"Physiques : renforcement musculaire et osseux, amélioration cardiovasculaire, maintien du poids, prévention du diabète et de l''hypertension. Mentaux : réduction du stress et de l''anxiété, amélioration de l''humeur (endorphines), meilleure estime de soi, amélioration du sommeil. Sociaux : esprit d''équipe, socialisation, discipline, respect des règles. L''OMS recommande 60 minutes d''activité physique par jour pour les jeunes."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre courbatures et claquage ?","answer":"Courbatures : douleurs musculaires diffuses apparaissant 24-48 h après un effort inhabituel. Causées par des microlésions musculaires. Bénignes, disparaissent en 3-5 jours. Pas besoin d''arrêter le sport. Claquage (déchirure) : rupture partielle des fibres musculaires pendant l''effort. Douleur aiguë et brutale. Nécessite un arrêt sportif (2-6 semaines), de la glace (RICE : Rest, Ice, Compression, Elevation) et une consultation médicale."}
    ],
    "schema": {
      "title": "Hygiène et physiologie du sport",
      "nodes": [
        {"id":"n1","label":"Hygiène et\nphysiologie","type":"main"},
        {"id":"n2","label":"Alimentation\nHydratation","type":"branch"},
        {"id":"n3","label":"Physiologie\nde l''effort","type":"branch"},
        {"id":"n4","label":"Santé et\nprévention","type":"branch"},
        {"id":"n5","label":"Nutriments\nÉquilibre","type":"leaf"},
        {"id":"n6","label":"Filières\nénergétiques","type":"leaf"},
        {"id":"n7","label":"FC max\nRécupération","type":"leaf"},
        {"id":"n8","label":"Dopage\nBlessures","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"carburant"},
        {"from":"n1","to":"n3","label":"corps"},
        {"from":"n1","to":"n4","label":"bien-être"},
        {"from":"n2","to":"n5","label":"besoins"},
        {"from":"n3","to":"n6","label":"énergie"},
        {"from":"n3","to":"n7","label":"entraînement"},
        {"from":"n4","to":"n8","label":"risques"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La fréquence cardiaque maximale d''un élève de 18 ans est environ :","options":["180 bpm","192 bpm","202 bpm","220 bpm"],"correct":2,"explanation":"FC max = 220 - âge = 220 - 18 = 202 battements par minute. C''est une estimation théorique."},
      {"id":"q2","question":"La filière anaérobie alactique est utilisée pour des efforts de :","options":["0 à 10 secondes","1 à 5 minutes","30 minutes à 1 heure","Plus de 2 heures"],"correct":0,"explanation":"La filière anaérobie alactique (ATP-CP) fournit l''énergie pour les efforts très intenses et très courts (0-10 secondes), comme le sprint ou un lancer."},
      {"id":"q3","question":"Le dopage est interdit car :","options":["Il ne fonctionne pas","Il est dangereux pour la santé et contraire à l''éthique","Il est trop cher","Il est légal dans certains sports"],"correct":1,"explanation":"Le dopage est interdit car il met en danger la santé du sportif, il est contraire à l''éthique sportive (tricherie) et il fausse les résultats des compétitions."},
      {"id":"q4","question":"Après un effort intense, la première chose à faire est :","options":["Manger un gros repas","S''allonger immédiatement","Faire une récupération active (marche, jogging léger)","Prendre un bain froid"],"correct":2,"explanation":"La récupération active (10 min de marche ou jogging léger) aide à éliminer l''acide lactique et favorise le retour au calme progressif."},
      {"id":"q5","question":"Les glucides représentent idéalement quel pourcentage de l''alimentation du sportif ?","options":["10-15%","25-30%","55-60%","80-90%"],"correct":2,"explanation":"Les glucides doivent représenter 55-60% de l''apport calorique du sportif. Ils sont la principale source d''énergie pour l''effort musculaire."},
      {"id":"q6","question":"L''OMS recommande pour les jeunes par jour :","options":["10 minutes d''activité physique","30 minutes d''activité physique","60 minutes d''activité physique","120 minutes d''activité physique"],"correct":2,"explanation":"L''Organisation Mondiale de la Santé recommande au moins 60 minutes d''activité physique modérée à intense par jour pour les enfants et adolescents."},
      {"id":"q7","question":"Le protocole RICE pour les blessures signifie :","options":["Riz, Igname, Céréales, Eau","Rest, Ice, Compression, Elevation","Run, Increase, Continue, Exercise","Repos, Immobilisation, Course, Étirement"],"correct":1,"explanation":"RICE : Rest (repos), Ice (glace), Compression (bandage), Elevation (surélever le membre). C''est le protocole de premiers soins pour les blessures musculaires et articulaires."},
      {"id":"q8","question":"La différence entre courbatures et claquage est :","options":["Il n''y a pas de différence","Les courbatures sont bénignes, le claquage est une déchirure musculaire","Les courbatures sont plus graves","Le claquage est normal après l''effort"],"correct":1,"explanation":"Les courbatures sont des douleurs diffuses bénignes qui apparaissent après l''effort. Le claquage est une déchirure partielle des fibres musculaires, plus grave, nécessitant un arrêt sportif et des soins."}
    ]
  }');

END $$;
