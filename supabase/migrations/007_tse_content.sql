-- ============================================================
-- BacSuccess - Migration 007: TSE Content
-- Série Terminale Sciences Exactes
-- 10 matières, 55 chapitres, 55 fiches
-- ============================================================

DO $$
DECLARE
  tse_id UUID;
  physique_id UUID;
  chimie_id UUID;
  maths_id UUID;
  svt_id UUID;
  dessin_id UUID;
  philo_id UUID;
  anglais_id UUID;
  francais_id UUID;
  ecm_id UUID;
  eps_id UUID;
  v_chapter_id UUID;
BEGIN

  -- Get the TSE series ID
  SELECT id INTO tse_id FROM series WHERE slug = 'tse';
  IF tse_id IS NULL THEN RAISE EXCEPTION 'Series not found: tse'; END IF;

  -- Activate TSE series
  UPDATE series SET is_active = true, description = 'Terminale Sciences Exactes' WHERE id = tse_id;

  -- ============================================================
  -- SUBJECTS (10 matières)
  -- ============================================================

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'physique-tse', 'Physique', 3, 4, 'physique', 'Zap', 1)
  RETURNING id INTO physique_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'chimie-tse', 'Chimie', 3, 4, 'chimie', 'FlaskConical', 2)
  RETURNING id INTO chimie_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'maths-tse', 'Mathématiques', 4, 5, 'maths', 'Compass', 3)
  RETURNING id INTO maths_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'svt-tse', 'Sciences de la Vie et de la Terre', 1, 2, 'svt', 'Dna', 4)
  RETURNING id INTO svt_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'dessin-industriel', 'Dessin Industriel', 2, 3, 'dessin', 'Ruler', 5)
  RETURNING id INTO dessin_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'philo-tse', 'Philosophie', 2, 2, 'philo', 'Brain', 6)
  RETURNING id INTO philo_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'anglais-tse', 'Anglais', 2, 2, 'anglais', 'Languages', 7)
  RETURNING id INTO anglais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'francais-tse', 'Français', 2, 2, 'francais', 'PenLine', 8)
  RETURNING id INTO francais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'ecm-tse', 'Éducation Civique et Morale', 1, 1, 'ecm', 'Landmark', 9)
  RETURNING id INTO ecm_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tse_id, 'eps-tse', 'Éducation Physique et Sportive', 1, 2, 'eps', 'Dumbbell', 10)
  RETURNING id INTO eps_id;

  -- ============================================================
  -- PHYSIQUE - CHAPTER 1: Mécanique — Mouvement du centre d''inertie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'mecanique-centre-inertie', 1, 'Mécanique — Mouvement du centre d''inertie', 'Rappels cinématique, dynamique, énergie', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'mecanique-centre-inertie-fiche', 'Mécanique — Mouvement du centre d''inertie', 'Cinématique, dynamique et énergie mécanique', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le centre d''inertie d''un système ?","answer":"Le centre d''inertie G (ou centre de masse) est le point où l''on peut considérer que toute la masse du système est concentrée. Pour un système de n points matériels : OG = (Σ mi·OMi) / Σ mi. Le mouvement du centre d''inertie obéit au théorème du centre d''inertie : Σ Fext = m·aG."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les équations horaires du mouvement rectiligne uniformément varié (MRUV) ?","answer":"Pour un MRUV d''accélération a constante : v(t) = v₀ + a·t ; x(t) = x₀ + v₀·t + ½·a·t² ; v² - v₀² = 2·a·(x - x₀). Si a = 0, on retrouve le MRU : v = constante et x = x₀ + v·t."},
      {"id":"fc3","category":"Formule","question":"Énoncer le Principe Fondamental de la Dynamique (PFD) ou 2e loi de Newton.","answer":"Le PFD stipule que dans un référentiel galiléen, la somme vectorielle des forces extérieures appliquées à un système est égale au produit de sa masse par l''accélération de son centre d''inertie : Σ Fext = m·aG. C''est la loi fondamentale de la mécanique classique. F en Newton (N), m en kg, a en m/s²."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un référentiel galiléen ?","answer":"Un référentiel galiléen (ou inertiel) est un référentiel dans lequel le principe d''inertie (1re loi de Newton) est vérifié : un corps isolé ou pseudo-isolé est en mouvement rectiligne uniforme ou au repos. Le référentiel héliocentrique est quasi-galiléen. Le référentiel géocentrique et le référentiel terrestre sont considérés galiléens pour des expériences de courte durée."},
      {"id":"fc5","category":"Formule","question":"Exprimer l''énergie cinétique et l''énergie potentielle de pesanteur.","answer":"Énergie cinétique : Ec = ½·m·v². Énergie potentielle de pesanteur : Ep = m·g·h (h = altitude par rapport à une référence). Énergie mécanique : Em = Ec + Ep. Théorème de l''énergie cinétique : ΔEc = Σ W(F), la variation d''énergie cinétique est égale à la somme des travaux des forces appliquées."},
      {"id":"fc6","category":"Méthode","question":"Comment résoudre un problème de dynamique avec le PFD ?","answer":"1) Définir le système et le référentiel (galiléen). 2) Faire le bilan des forces extérieures (poids, réaction normale, tension, frottement...). 3) Appliquer le PFD : Σ F = m·a. 4) Projeter sur les axes (Ox, Oy). 5) Résoudre les équations pour trouver a. 6) Intégrer pour obtenir v(t) et x(t) avec les conditions initiales."},
      {"id":"fc7","category":"Formule","question":"Qu''est-ce que le travail d''une force et sa puissance ?","answer":"Le travail d''une force constante F lors d''un déplacement AB est : W(F) = F·AB·cos(α) où α est l''angle entre F et AB. En joules (J). La puissance est P = W/Δt = F·v·cos(α) en watts (W). W > 0 : travail moteur. W < 0 : travail résistant. W = 0 : force perpendiculaire au déplacement."},
      {"id":"fc8","category":"Distinction","question":"Quelle est la différence entre forces conservatives et non conservatives ?","answer":"Une force conservative a un travail indépendant du chemin suivi (ne dépend que des positions initiale et finale). On peut lui associer une énergie potentielle : W = -ΔEp. Exemples : poids, force élastique, force électrostatique. Une force non conservative (frottements) a un travail qui dépend du chemin : l''énergie mécanique n''est pas conservée."},
      {"id":"fc9","category":"Formule","question":"Énoncer le théorème de l''énergie mécanique.","answer":"Si seules des forces conservatives travaillent, l''énergie mécanique Em = Ec + Ep se conserve : ΔEm = 0. En présence de forces non conservatives (frottements) : ΔEm = W(forces non conservatives). Les frottements dissipent de l''énergie mécanique sous forme de chaleur : ΔEm < 0."},
      {"id":"fc10","category":"Exemple","question":"Donner un exemple d''application du théorème de l''énergie cinétique.","answer":"Un véhicule de masse m = 1000 kg freine et passe de v₁ = 20 m/s à v₂ = 0 sur une distance d. ΔEc = ½m(v₂² - v₁²) = -200 000 J. Ce travail est fourni par la force de freinage f : W(f) = -f·d = -200 000 J. Si d = 50 m, f = 4000 N."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que la quantité de mouvement ?","answer":"La quantité de mouvement d''un point matériel est le vecteur p = m·v (en kg·m/s). Pour un système isolé, la quantité de mouvement totale se conserve : Σ pi = constante. C''est le principe de conservation de la quantité de mouvement, fondamental dans l''étude des chocs et des explosions."},
      {"id":"fc12","category":"Méthode","question":"Comment étudier un mouvement circulaire uniforme ?","answer":"Dans un MCU, la vitesse a un module constant v mais change de direction. L''accélération est centripète : a = v²/R dirigée vers le centre. Période T = 2πR/v. Fréquence f = 1/T. Vitesse angulaire ω = 2π/T = v/R. La force centripète nécessaire : F = m·v²/R = m·ω²·R."}
    ],
    "schema": {
      "title": "Mécanique du centre d''inertie",
      "nodes": [
        {"id":"n1","label":"Mécanique","type":"main"},
        {"id":"n2","label":"Cinématique","type":"branch"},
        {"id":"n3","label":"Dynamique","type":"branch"},
        {"id":"n4","label":"Énergie","type":"branch"},
        {"id":"n5","label":"MRU / MRUV\néquations horaires","type":"leaf"},
        {"id":"n6","label":"MCU\na = v²/R","type":"leaf"},
        {"id":"n7","label":"PFD\nΣF = m·a","type":"leaf"},
        {"id":"n8","label":"Quantité de\nmouvement p = mv","type":"leaf"},
        {"id":"n9","label":"Ec = ½mv²\nEp = mgh","type":"leaf"},
        {"id":"n10","label":"Théorème Ec\nΔEc = ΣW(F)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mouvement"},
        {"from":"n1","to":"n3","label":"forces"},
        {"from":"n1","to":"n4","label":"travail"},
        {"from":"n2","to":"n5","label":"rectiligne"},
        {"from":"n2","to":"n6","label":"circulaire"},
        {"from":"n3","to":"n7","label":"Newton"},
        {"from":"n3","to":"n8","label":"conservation"},
        {"from":"n4","to":"n9","label":"formes"},
        {"from":"n4","to":"n10","label":"théorèmes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est l''expression du PFD (2e loi de Newton) ?","options":["Σ Fext = m·v","Σ Fext = m·a","Σ Fext = m·g","Σ Fext = ½·m·v²"],"correct":1,"explanation":"Le Principe Fondamental de la Dynamique s''écrit Σ Fext = m·aG. La somme des forces extérieures égale le produit de la masse par l''accélération du centre d''inertie."},
      {"id":"q2","question":"L''énergie cinétique d''un corps de masse m et de vitesse v vaut :","options":["m·v","m·v²","½·m·v²","2·m·v²"],"correct":2,"explanation":"L''énergie cinétique est Ec = ½·m·v². Elle est toujours positive et s''exprime en joules (J)."},
      {"id":"q3","question":"Dans un MRUV, quelle grandeur est constante ?","options":["La vitesse","La position","L''accélération","La force résultante"],"correct":2,"explanation":"Dans un mouvement rectiligne uniformément varié, l''accélération est constante. La vitesse varie linéairement avec le temps et la position varie quadratiquement."},
      {"id":"q4","question":"Le travail d''une force perpendiculaire au déplacement vaut :","options":["W = F·d","W = F·d·cos(90°) = 0","W = ½·F·d","W = -F·d"],"correct":1,"explanation":"Quand la force est perpendiculaire au déplacement, cos(90°) = 0, donc W = 0. La réaction normale du sol et la force centripète ne travaillent pas."},
      {"id":"q5","question":"L''accélération dans un mouvement circulaire uniforme est :","options":["Tangente à la trajectoire","Centripète, dirigée vers le centre","Nulle","Centrifuge, dirigée vers l''extérieur"],"correct":1,"explanation":"Dans un MCU, l''accélération est centripète (dirigée vers le centre) et vaut a = v²/R. La vitesse a un module constant mais change continuellement de direction."},
      {"id":"q6","question":"Un système est isolé. Sa quantité de mouvement totale :","options":["Augmente","Diminue","Reste constante","S''annule"],"correct":2,"explanation":"D''après le principe de conservation de la quantité de mouvement, la quantité de mouvement totale d''un système isolé reste constante : Σ pi = constante."},
      {"id":"q7","question":"L''énergie mécanique se conserve si :","options":["La vitesse est constante","Seules des forces conservatives travaillent","Le mouvement est circulaire","La masse est constante"],"correct":1,"explanation":"L''énergie mécanique Em = Ec + Ep se conserve uniquement lorsque seules des forces conservatives (poids, force élastique) travaillent. Les frottements dissipent Em."},
      {"id":"q8","question":"L''unité SI de la quantité de mouvement est :","options":["N","J","kg·m/s","W"],"correct":2,"explanation":"La quantité de mouvement p = m·v s''exprime en kg·m/s dans le système international. C''est aussi équivalent à N·s."},
      {"id":"q9","question":"Un objet de 2 kg chute de 10 m. Quelle énergie potentielle perd-il ? (g = 10 m/s²)","options":["20 J","100 J","200 J","2000 J"],"correct":2,"explanation":"ΔEp = m·g·Δh = 2 × 10 × 10 = 200 J. Cette énergie potentielle est convertie en énergie cinétique si on néglige les frottements."},
      {"id":"q10","question":"Quel est le rôle du référentiel galiléen en mécanique ?","options":["Il simplifie les calculs","Il permet d''appliquer les lois de Newton","Il élimine la gravité","Il fixe la masse des objets"],"correct":1,"explanation":"Les lois de Newton (dont le PFD) ne sont valables que dans un référentiel galiléen, c''est-à-dire un référentiel dans lequel le principe d''inertie est vérifié."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 2: Applications du PFD
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'applications-pfd', 2, 'Applications du PFD', 'Projectile, particule chargée champ E/B, satellites', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'applications-pfd-fiche', 'Applications du PFD', 'Projectile, particule chargée dans E et B, satellites', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Comment étudier le mouvement d''un projectile dans le champ de pesanteur ?","answer":"On applique le PFD au projectile (seul le poids P = m·g) : a = g (vertical, vers le bas). En projetant : ax = 0, ay = -g. Par intégration : vx = v₀·cos(α), vy = v₀·sin(α) - g·t. Puis x = v₀·cos(α)·t, y = v₀·sin(α)·t - ½·g·t². La trajectoire est une parabole : y = -g·x²/(2v₀²cos²α) + x·tan(α)."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les caractéristiques du mouvement d''un projectile ?","answer":"Portée horizontale : L = v₀²·sin(2α)/g (maximale pour α = 45°). Hauteur maximale : H = v₀²·sin²(α)/(2g). Temps de vol : T = 2·v₀·sin(α)/g. Au sommet de la trajectoire, vy = 0 et vx = v₀·cos(α). La trajectoire est parabolique si la résistance de l''air est négligée."},
      {"id":"fc3","category":"Formule","question":"Comment se comporte une particule chargée dans un champ électrique uniforme E ?","answer":"La force électrique est F = q·E. Le PFD donne a = q·E/m. Si q > 0, la particule accélère dans le sens de E. Si q < 0, elle accélère en sens inverse. Dans un condensateur plan, E = U/d (U : tension, d : distance entre plaques). La trajectoire est parabolique (analogie avec le projectile) si la vitesse initiale est perpendiculaire à E."},
      {"id":"fc4","category":"Formule","question":"Quelle est la force de Lorentz sur une particule chargée dans un champ magnétique B ?","answer":"La force de Lorentz est F = q·v ∧ B (produit vectoriel). Son module : F = |q|·v·B·sin(θ) où θ est l''angle entre v et B. Cette force est toujours perpendiculaire à v, donc elle ne travaille pas (ΔEc = 0, v = constante). Si v ⊥ B, la trajectoire est un cercle de rayon r = m·v/(|q|·B)."},
      {"id":"fc5","category":"Formule","question":"Quelles sont les lois de Kepler pour le mouvement des satellites ?","answer":"1re loi : La trajectoire d''un satellite est une ellipse dont le centre attracteur occupe un foyer. 2e loi : Le rayon vecteur balaie des aires égales en des temps égaux (loi des aires). 3e loi : T²/a³ = constante (T : période, a : demi-grand axe). Pour une orbite circulaire de rayon r : T² = 4π²r³/(G·M)."},
      {"id":"fc6","category":"Formule","question":"Quelle est la vitesse orbitale d''un satellite en orbite circulaire ?","answer":"Pour un satellite en orbite circulaire de rayon r autour d''un astre de masse M : la force gravitationnelle fournit la force centripète. G·M·m/r² = m·v²/r, donc v = √(G·M/r). La vitesse diminue quand l''altitude augmente. En orbite basse terrestre (r ≈ R_T) : v ≈ 7,9 km/s."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce qu''un satellite géostationnaire ?","answer":"Un satellite géostationnaire orbite dans le plan de l''équateur avec une période T = 24 h (synchrone avec la rotation terrestre). Il paraît fixe vu de la Terre. Son altitude est h ≈ 35 786 km (r ≈ 42 164 km). Applications : télécommunications, météorologie, télévision par satellite."},
      {"id":"fc8","category":"Formule","question":"Exprimer l''énergie mécanique d''un satellite en orbite circulaire.","answer":"Ec = ½·m·v² = G·M·m/(2r). Ep = -G·M·m/r. Em = Ec + Ep = -G·M·m/(2r). L''énergie mécanique est négative (le satellite est lié). On remarque que Ec = -Em et Ep = 2·Em. Pour qu''un satellite s''échappe : Em ≥ 0, soit v ≥ v_lib = √(2·G·M/r)."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre impesanteur et apesanteur ?","answer":"L''impesanteur (ou apesanteur) est l''état dans lequel un corps ne ressent pas son poids. Un satellite en orbite est en chute libre permanente : ses occupants flottent car ils ont la même accélération que le satellite. Le poids existe toujours (la gravité n''est pas nulle), mais la réaction normale est nulle. C''est le poids apparent qui est nul."},
      {"id":"fc10","category":"Méthode","question":"Comment déterminer la déviation d''une particule chargée dans un condensateur ?","answer":"1) Identifier la particule (masse m, charge q) et sa vitesse initiale v₀. 2) Calculer E = U/d dans le condensateur. 3) Appliquer le PFD : ay = q·E/m (déviation), ax = 0. 4) Calculer le temps de traversée : t₁ = L/v₀ (L : longueur des plaques). 5) Déviation verticale : y₁ = ½·(qE/m)·t₁². 6) Angle de déviation : tan(θ) = vy/vx = qEL/(mv₀²)."},
      {"id":"fc11","category":"Exemple","question":"Calculer le rayon de la trajectoire d''un proton dans un champ magnétique B = 0,5 T à v = 10⁶ m/s.","answer":"Le proton a m = 1,67×10⁻²⁷ kg, q = 1,6×10⁻¹⁹ C. Si v ⊥ B, le rayon est r = m·v/(q·B) = (1,67×10⁻²⁷ × 10⁶)/(1,6×10⁻¹⁹ × 0,5) = 1,67×10⁻²¹/8×10⁻²⁰ ≈ 0,021 m = 2,1 cm. La trajectoire est un cercle parcouru dans le sens déterminé par la règle de la main droite."},
      {"id":"fc12","category":"Formule","question":"Énoncer la loi de la gravitation universelle.","answer":"Deux corps ponctuels de masses m₁ et m₂ séparés par une distance r s''attirent avec une force F = G·m₁·m₂/r². G = 6,674×10⁻¹¹ N·m²/kg² est la constante de gravitation universelle. La force est attractive, dirigée selon la droite joignant les deux corps. Elle est responsable du mouvement des planètes et des satellites."}
    ],
    "schema": {
      "title": "Applications du PFD",
      "nodes": [
        {"id":"n1","label":"Applications\ndu PFD","type":"main"},
        {"id":"n2","label":"Projectiles","type":"branch"},
        {"id":"n3","label":"Particules\nchargées","type":"branch"},
        {"id":"n4","label":"Satellites","type":"branch"},
        {"id":"n5","label":"Parabole\nPortée, hauteur","type":"leaf"},
        {"id":"n6","label":"Champ E\nF = qE","type":"leaf"},
        {"id":"n7","label":"Champ B\nF = qv∧B","type":"leaf"},
        {"id":"n8","label":"Lois de Kepler","type":"leaf"},
        {"id":"n9","label":"Orbite circulaire\nv = √(GM/r)","type":"leaf"},
        {"id":"n10","label":"Géostationnaire\nT = 24h","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"champ pesanteur"},
        {"from":"n1","to":"n3","label":"champs E et B"},
        {"from":"n1","to":"n4","label":"gravitation"},
        {"from":"n2","to":"n5","label":"trajectoire"},
        {"from":"n3","to":"n6","label":"électrique"},
        {"from":"n3","to":"n7","label":"magnétique"},
        {"from":"n4","to":"n8","label":"lois"},
        {"from":"n4","to":"n9","label":"vitesse"},
        {"from":"n4","to":"n10","label":"application"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La trajectoire d''un projectile dans le champ de pesanteur uniforme est :","options":["Une droite","Un cercle","Une parabole","Une ellipse"],"correct":2,"explanation":"En négligeant la résistance de l''air, un projectile soumis uniquement au poids décrit une trajectoire parabolique dans un champ de pesanteur uniforme."},
      {"id":"q2","question":"La portée d''un projectile est maximale pour un angle de tir de :","options":["30°","45°","60°","90°"],"correct":1,"explanation":"La portée L = v₀²·sin(2α)/g est maximale quand sin(2α) = 1, soit 2α = 90°, donc α = 45°."},
      {"id":"q3","question":"La force de Lorentz F = qv∧B est toujours :","options":["Parallèle à v","Parallèle à B","Perpendiculaire à v","Dans le sens de E"],"correct":2,"explanation":"Le produit vectoriel v∧B donne un vecteur perpendiculaire à la fois à v et à B. La force de Lorentz ne travaille jamais, elle dévie sans accélérer."},
      {"id":"q4","question":"Le rayon de la trajectoire circulaire d''une particule chargée dans un champ B est :","options":["r = qB/mv","r = mv/(qB)","r = qv/mB","r = mB/qv"],"correct":1,"explanation":"Le rayon est r = mv/(|q|B). Il augmente avec la masse et la vitesse, et diminue avec la charge et l''intensité du champ magnétique."},
      {"id":"q5","question":"D''après la 3e loi de Kepler, si la distance Terre-Soleil double, la période orbitale :","options":["Double","Quadruple","Est multipliée par 2√2","Est multipliée par 4√2"],"correct":2,"explanation":"T² ∝ r³, donc T ∝ r^(3/2). Si r double : T'' = T·2^(3/2) = T·2√2 ≈ 2,83·T."},
      {"id":"q6","question":"La vitesse d''un satellite en orbite circulaire basse (h ≈ 0) autour de la Terre vaut environ :","options":["3,1 km/s","7,9 km/s","11,2 km/s","29,8 km/s"],"correct":1,"explanation":"En orbite basse, v = √(gR) ≈ √(10 × 6,4×10⁶) ≈ 7,9 km/s. La vitesse de libération est √2 fois plus grande, soit 11,2 km/s."},
      {"id":"q7","question":"L''énergie mécanique d''un satellite lié est :","options":["Positive","Nulle","Négative","Infinie"],"correct":2,"explanation":"Em = -GMm/(2r) < 0 pour un satellite lié. Si Em ≥ 0, le satellite s''échappe de l''attraction gravitationnelle."},
      {"id":"q8","question":"Dans un condensateur plan, le champ électrique E est relié à la tension U et la distance d par :","options":["E = U·d","E = U/d","E = d/U","E = U²/d"],"correct":1,"explanation":"Dans un condensateur plan, le champ électrique uniforme vaut E = U/d, où U est la tension entre les plaques et d leur écartement."},
      {"id":"q9","question":"Un satellite géostationnaire a une période de :","options":["12 h","24 h","48 h","1 an"],"correct":1,"explanation":"Un satellite géostationnaire a une période de 24 h (période de rotation de la Terre). Il orbite dans le plan équatorial et paraît fixe vu du sol."},
      {"id":"q10","question":"La constante de gravitation universelle G vaut environ :","options":["9,81 m/s²","6,674×10⁻¹¹ N·m²/kg²","6,022×10²³ mol⁻¹","1,6×10⁻¹⁹ C"],"correct":1,"explanation":"G = 6,674×10⁻¹¹ N·m²/kg² est la constante de gravitation universelle. Ne pas confondre avec g (accélération de la pesanteur) qui vaut environ 9,81 m/s² à la surface terrestre."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 3: Énergie interne — Thermodynamique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'thermodynamique', 3, 'Énergie interne — Thermodynamique', '1er principe, calorimétrie', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'thermodynamique-fiche', 'Énergie interne — Thermodynamique', 'Premier principe et calorimétrie', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''énergie interne d''un système ?","answer":"L''énergie interne U d''un système est la somme de toutes les énergies microscopiques : énergie cinétique d''agitation thermique des molécules + énergie potentielle d''interaction entre molécules. U dépend de la température T et de l''état physique. Pour un gaz parfait, U ne dépend que de T : U = n·Cv·T."},
      {"id":"fc2","category":"Formule","question":"Énoncer le premier principe de la thermodynamique.","answer":"Pour un système fermé, la variation d''énergie interne est : ΔU = W + Q. W est le travail échangé (positif si reçu par le système) et Q est la quantité de chaleur échangée (positive si reçue). L''énergie se conserve : elle ne peut être ni créée ni détruite, seulement transformée ou transférée."},
      {"id":"fc3","category":"Formule","question":"Comment calculer la quantité de chaleur échangée lors d''un changement de température ?","answer":"Q = m·c·ΔT = m·c·(Tf - Ti) où m est la masse (kg), c la capacité thermique massique (J·kg⁻¹·K⁻¹) et ΔT la variation de température. Pour l''eau : c = 4185 J·kg⁻¹·K⁻¹. Q > 0 si le corps se réchauffe, Q < 0 s''il se refroidit."},
      {"id":"fc4","category":"Formule","question":"Comment calculer la chaleur lors d''un changement d''état ?","answer":"Q = m·L où L est la chaleur latente de changement d''état (J/kg). Pour l''eau : L_fusion = 334 kJ/kg, L_vaporisation = 2260 kJ/kg. Pendant le changement d''état, la température reste constante : toute l''énergie sert à rompre ou former les liaisons intermoléculaires."},
      {"id":"fc5","category":"Méthode","question":"Comment résoudre un problème de calorimétrie ?","answer":"1) Identifier les corps en présence et leurs états. 2) Supposer une température finale d''équilibre Tf. 3) Écrire le bilan thermique : Σ Qi = 0 (le calorimètre est isolé). 4) Exprimer chaque Qi = mi·ci·(Tf - Ti) + éventuels changements d''état. 5) Résoudre pour Tf. Vérifier la cohérence : Tf est entre les températures extrêmes."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce qu''un calorimètre et quelle est sa capacité thermique ?","answer":"Un calorimètre est un récipient isolé thermiquement qui empêche les échanges de chaleur avec l''extérieur. Sa capacité thermique Ccal (en J/K ou J/°C) représente la quantité de chaleur nécessaire pour élever sa température de 1°C. La chaleur absorbée par le calorimètre : Qcal = Ccal·ΔT."},
      {"id":"fc7","category":"Formule","question":"Quel est le travail des forces de pression pour un gaz ?","answer":"Pour une transformation quasi-statique : W = -∫P·dV. À pression constante (isobare) : W = -P·ΔV. À volume constant (isochore) : W = 0. Pour un gaz parfait en transformation isotherme : W = -n·R·T·ln(Vf/Vi). Signe : W > 0 si le gaz est comprimé (ΔV < 0)."},
      {"id":"fc8","category":"Distinction","question":"Quelles sont les différentes transformations thermodynamiques ?","answer":"Isotherme : T = constante (ΔU = 0 pour un gaz parfait). Isochore : V = constante (W = 0, donc ΔU = Q). Isobare : P = constante (W = -PΔV). Adiabatique : Q = 0 (ΔU = W, pas d''échange de chaleur). Chaque transformation impose une relation entre P, V et T via l''équation d''état PV = nRT."},
      {"id":"fc9","category":"Formule","question":"Quelle est l''équation d''état des gaz parfaits ?","answer":"PV = nRT où P est la pression (Pa), V le volume (m³), n le nombre de moles, R = 8,314 J·mol⁻¹·K⁻¹ la constante des gaz parfaits, T la température absolue (K). Forme massique : PV = (m/M)RT. T(K) = T(°C) + 273,15."},
      {"id":"fc10","category":"Exemple","question":"Appliquer le premier principe à une transformation isochore d''un gaz parfait.","answer":"Isochore : V = constante, donc W = -PΔV = 0. Le premier principe donne ΔU = Q. Toute la chaleur reçue sert à augmenter l''énergie interne, donc la température : Q = nCvΔT. Pour un gaz parfait monoatomique, Cv = 3R/2, pour un diatomique Cv = 5R/2."},
      {"id":"fc11","category":"Distinction","question":"Quelle est la différence entre Cv et Cp ?","answer":"Cv est la capacité thermique molaire à volume constant : Q = nCvΔT (isochore). Cp est la capacité thermique molaire à pression constante : Q = nCpΔT (isobare). Relation de Mayer : Cp - Cv = R. Le rapport γ = Cp/Cv vaut 5/3 pour un gaz monoatomique et 7/5 pour un diatomique."},
      {"id":"fc12","category":"Méthode","question":"Comment déterminer la capacité thermique d''un solide par calorimétrie ?","answer":"1) Chauffer le solide de masse m à une température T1 connue. 2) Le plonger dans le calorimètre contenant de l''eau à T2. 3) Mesurer la température d''équilibre Tf. 4) Bilan : m·c·(Tf - T1) + meau·ceau·(Tf - T2) + Ccal·(Tf - T2) = 0. 5) En déduire c = [-(meau·ceau + Ccal)·(Tf - T2)] / [m·(Tf - T1)]."}
    ],
    "schema": {
      "title": "Thermodynamique",
      "nodes": [
        {"id":"n1","label":"Thermodynamique","type":"main"},
        {"id":"n2","label":"Énergie interne","type":"branch"},
        {"id":"n3","label":"1er principe","type":"branch"},
        {"id":"n4","label":"Calorimétrie","type":"branch"},
        {"id":"n5","label":"U = f(T)\nGaz parfait","type":"leaf"},
        {"id":"n6","label":"ΔU = W + Q","type":"leaf"},
        {"id":"n7","label":"Transformations\niso/adia","type":"leaf"},
        {"id":"n8","label":"Q = mcΔT\nQ = mL","type":"leaf"},
        {"id":"n9","label":"Bilan thermique\nΣQi = 0","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"microscopique"},
        {"from":"n1","to":"n3","label":"conservation"},
        {"from":"n1","to":"n4","label":"mesures"},
        {"from":"n2","to":"n5","label":"gaz parfait"},
        {"from":"n3","to":"n6","label":"énoncé"},
        {"from":"n3","to":"n7","label":"cas particuliers"},
        {"from":"n4","to":"n8","label":"formules"},
        {"from":"n4","to":"n9","label":"méthode"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le premier principe de la thermodynamique s''écrit :","options":["ΔU = W - Q","ΔU = W + Q","ΔU = Q/W","ΔU = W × Q"],"correct":1,"explanation":"Le premier principe stipule que ΔU = W + Q. La variation d''énergie interne est la somme du travail W et de la chaleur Q échangés avec l''extérieur."},
      {"id":"q2","question":"Lors d''une transformation isochore, le travail des forces de pression vaut :","options":["W = PΔV","W = -PΔV","W = 0","W = nRΔT"],"correct":2,"explanation":"Isochore signifie à volume constant (ΔV = 0), donc W = -PΔV = 0. Toute l''énergie échangée est sous forme de chaleur : ΔU = Q."},
      {"id":"q3","question":"La relation de Mayer relie :","options":["P et V","T et U","Cp et Cv","W et Q"],"correct":2,"explanation":"La relation de Mayer pour un gaz parfait est Cp - Cv = R, où R = 8,314 J·mol⁻¹·K⁻¹. Elle relie les capacités thermiques molaires à pression constante et à volume constant."},
      {"id":"q4","question":"La capacité thermique massique de l''eau vaut environ :","options":["1000 J·kg⁻¹·K⁻¹","2000 J·kg⁻¹·K⁻¹","4185 J·kg⁻¹·K⁻¹","8314 J·kg⁻¹·K⁻¹"],"correct":2,"explanation":"L''eau a une capacité thermique massique c ≈ 4185 J·kg⁻¹·K⁻¹, ce qui est très élevé comparé aux autres substances. C''est pourquoi l''eau est un excellent régulateur thermique."},
      {"id":"q5","question":"Pendant un changement d''état, la température :","options":["Augmente toujours","Diminue toujours","Reste constante","Oscille"],"correct":2,"explanation":"Pendant un changement d''état (fusion, vaporisation, etc.), la température reste constante. Toute l''énergie fournie sert à rompre les liaisons intermoléculaires."},
      {"id":"q6","question":"L''équation d''état des gaz parfaits est :","options":["PV = mRT","PV = nRT","PV = nCvT","P = nRT/V²"],"correct":1,"explanation":"L''équation d''état du gaz parfait est PV = nRT avec P en Pa, V en m³, n en mol, R = 8,314 J·mol⁻¹·K⁻¹ et T en Kelvin."},
      {"id":"q7","question":"Pour une transformation adiabatique, on a :","options":["Q = 0","W = 0","ΔT = 0","ΔV = 0"],"correct":0,"explanation":"Adiabatique signifie sans échange de chaleur : Q = 0. Le premier principe donne alors ΔU = W. Si le gaz se détend (W < 0), il se refroidit."},
      {"id":"q8","question":"Quelle est la relation entre température en Kelvin et en Celsius ?","options":["T(K) = T(°C) - 273","T(K) = T(°C) + 273","T(K) = T(°C) × 273","T(K) = T(°C) / 273"],"correct":1,"explanation":"T(K) = T(°C) + 273,15. Le zéro absolu (0 K = -273,15 °C) est la température la plus basse possible, où l''agitation thermique est minimale."},
      {"id":"q9","question":"Le bilan thermique en calorimétrie repose sur :","options":["Σ Qi > 0","Σ Qi < 0","Σ Qi = 0","Σ Qi = Ccal"],"correct":2,"explanation":"Dans un calorimètre (système isolé), la somme des chaleurs échangées est nulle : Σ Qi = 0. Ce que perd le corps chaud est gagné par le corps froid."},
      {"id":"q10","question":"Le coefficient γ = Cp/Cv d''un gaz parfait diatomique vaut :","options":["5/3","7/5","3/2","9/7"],"correct":1,"explanation":"Pour un gaz parfait diatomique (N₂, O₂) : Cv = 5R/2 et Cp = 7R/2, donc γ = Cp/Cv = 7/5 = 1,4. Pour un monoatomique : γ = 5/3."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 4: Induction électromagnétique et auto-induction
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'induction-electromagnetique', 4, 'Induction électromagnétique et auto-induction', 'Flux, loi de Lenz, alternateurs, bobine', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'induction-electromagnetique-fiche', 'Induction électromagnétique et auto-induction', 'Flux magnétique, loi de Faraday-Lenz, bobine', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le flux magnétique à travers une bobine ?","answer":"Le flux magnétique à travers une spire de surface S dans un champ B uniforme est : Φ = B·S·cos(α) où α est l''angle entre B et la normale à la spire. Pour une bobine de N spires : Φ_total = N·B·S·cos(α). L''unité est le weber (Wb). 1 Wb = 1 T·m² = 1 V·s."},
      {"id":"fc2","category":"Formule","question":"Énoncer la loi de Faraday de l''induction électromagnétique.","answer":"La force électromotrice (f.é.m.) induite dans un circuit est égale à l''opposé de la dérivée temporelle du flux magnétique : e = -dΦ/dt. Pour une bobine de N spires : e = -N·dΦ/dt. Une f.é.m. apparaît chaque fois que le flux magnétique à travers le circuit varie (variation de B, de S, ou de l''angle α)."},
      {"id":"fc3","category":"Définition","question":"Énoncer la loi de Lenz.","answer":"La loi de Lenz stipule que le courant induit circule dans un sens tel qu''il s''oppose à la cause qui lui a donné naissance. Si le flux augmente, le courant induit crée un champ qui s''oppose à l''augmentation. Si le flux diminue, le courant induit tend à maintenir le flux. C''est une conséquence de la conservation de l''énergie."},
      {"id":"fc4","category":"Formule","question":"Comment fonctionne un alternateur ?","answer":"Un alternateur est un générateur de courant alternatif. Une bobine de N spires (rotor) tourne à vitesse angulaire ω dans un champ B uniforme. Le flux varie : Φ = NBS·cos(ωt). La f.é.m. induite est : e = NBSω·sin(ωt) = E₀·sin(ωt) avec E₀ = NBSω (amplitude). La fréquence f = ω/(2π) et la période T = 2π/ω."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que l''auto-induction et l''inductance L ?","answer":"L''auto-induction est le phénomène par lequel une bobine s''oppose aux variations du courant qui la traverse. Le flux propre est Φ = L·i où L est l''inductance (en Henry, H). La f.é.m. d''auto-induction est : e_L = -L·di/dt. L dépend de la géométrie : pour un solénoïde, L = μ₀·N²·S/ℓ."},
      {"id":"fc6","category":"Formule","question":"Quelle est l''énergie stockée dans une bobine ?","answer":"L''énergie magnétique stockée dans une bobine d''inductance L parcourue par un courant i est : E = ½·L·i². Cette énergie est stockée dans le champ magnétique créé par la bobine. Lors de l''ouverture d''un circuit inductif, cette énergie se libère brutalement, pouvant provoquer des étincelles."},
      {"id":"fc7","category":"Distinction","question":"Quelle est la différence entre courant continu et courant alternatif ?","answer":"Le courant continu (CC) circule toujours dans le même sens, avec une intensité constante : i = I. Le courant alternatif (CA) change périodiquement de sens : i(t) = I₀·sin(ωt + φ). Valeur efficace : I_eff = I₀/√2. La tension du secteur au Mali est 220 V efficace, 50 Hz, donc U₀ = 220√2 ≈ 311 V."},
      {"id":"fc8","category":"Méthode","question":"Comment appliquer la loi de Lenz pour déterminer le sens du courant induit ?","answer":"1) Identifier la cause de l''induction (variation du flux). 2) Déterminer si le flux augmente ou diminue. 3) Le courant induit crée un champ B_induit qui s''oppose à la variation du flux. 4) Si Φ augmente, B_induit est en sens inverse de B. Si Φ diminue, B_induit est dans le même sens que B. 5) Utiliser la règle de la main droite pour trouver le sens du courant."},
      {"id":"fc9","category":"Exemple","question":"Un aimant s''approche d''une bobine. Que se passe-t-il ?","answer":"Quand le pôle Nord de l''aimant s''approche de la bobine, le flux à travers la bobine augmente. Par la loi de Lenz, le courant induit crée un champ qui repousse l''aimant (la face de la bobine proche de l''aimant se comporte comme un pôle Nord). Si l''aimant s''éloigne, le courant s''inverse et la bobine attire l''aimant."},
      {"id":"fc10","category":"Définition","question":"Qu''est-ce qu''un transformateur et comment fonctionne-t-il ?","answer":"Un transformateur est constitué de deux bobines (primaire N₁ et secondaire N₂) couplées par un noyau ferromagnétique. La relation des tensions est : U₂/U₁ = N₂/N₁ (rapport de transformation). Si N₂ > N₁ : élévateur de tension. Si N₂ < N₁ : abaisseur. Le transformateur ne fonctionne qu''en courant alternatif (le flux doit varier)."},
      {"id":"fc11","category":"Formule","question":"Exprimer la tension aux bornes d''une bobine réelle en régime variable.","answer":"La tension aux bornes d''une bobine réelle (inductance L, résistance r) est : u_L = L·di/dt + r·i. En régime permanent continu (di/dt = 0) : u_L = r·i, la bobine se comporte comme une résistance. En régime variable, le terme L·di/dt traduit l''auto-induction qui s''oppose aux variations de courant."},
      {"id":"fc12","category":"Distinction","question":"Quelles sont les applications industrielles de l''induction ?","answer":"1) Alternateurs (centrales électriques) : conversion énergie mécanique → électrique. 2) Transformateurs : adaptation des tensions pour le transport d''électricité. 3) Moteurs électriques : conversion énergie électrique → mécanique. 4) Plaques à induction : chauffage par courants de Foucault. 5) Freinage par induction (trains, camions). 6) Détecteurs de métaux."}
    ],
    "schema": {
      "title": "Induction électromagnétique",
      "nodes": [
        {"id":"n1","label":"Induction\nélectromagnétique","type":"main"},
        {"id":"n2","label":"Flux magnétique","type":"branch"},
        {"id":"n3","label":"Lois","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"Φ = NBS·cos(α)","type":"leaf"},
        {"id":"n6","label":"Faraday\ne = -dΦ/dt","type":"leaf"},
        {"id":"n7","label":"Lenz\nopposition","type":"leaf"},
        {"id":"n8","label":"Auto-induction\ne = -Ldi/dt","type":"leaf"},
        {"id":"n9","label":"Alternateur\nTransformateur","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"grandeur"},
        {"from":"n1","to":"n3","label":"principes"},
        {"from":"n1","to":"n4","label":"techniques"},
        {"from":"n2","to":"n5","label":"expression"},
        {"from":"n3","to":"n6","label":"f.é.m."},
        {"from":"n3","to":"n7","label":"sens courant"},
        {"from":"n3","to":"n8","label":"bobine"},
        {"from":"n4","to":"n9","label":"machines"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La loi de Faraday de l''induction s''écrit :","options":["e = dΦ/dt","e = -dΦ/dt","e = Φ/t","e = -Φ·t"],"correct":1,"explanation":"La f.é.m. induite est l''opposé de la dérivée temporelle du flux : e = -dΦ/dt. Le signe négatif traduit la loi de Lenz (opposition)."},
      {"id":"q2","question":"L''unité du flux magnétique est :","options":["Le Tesla","Le Weber","Le Henry","L''Ampère"],"correct":1,"explanation":"Le flux magnétique s''exprime en Weber (Wb). 1 Wb = 1 T·m². Le Tesla est l''unité du champ magnétique, le Henry est l''unité de l''inductance."},
      {"id":"q3","question":"La loi de Lenz indique que le courant induit :","options":["Renforce toujours le flux","S''oppose à la variation de flux","Est toujours nul","A une direction fixe"],"correct":1,"explanation":"La loi de Lenz stipule que le courant induit s''oppose à la cause qui l''a produit (variation de flux). C''est une conséquence de la conservation de l''énergie."},
      {"id":"q4","question":"L''énergie stockée dans une bobine d''inductance L parcourue par un courant i est :","options":["E = L·i","E = L·i²","E = ½·L·i²","E = ½·L²·i"],"correct":2,"explanation":"L''énergie magnétique stockée dans une bobine est E = ½·L·i², analogue à l''énergie cinétique ½mv² ou à l''énergie du condensateur ½Cu²."},
      {"id":"q5","question":"Un transformateur a N₁ = 1000 spires au primaire et N₂ = 100 au secondaire. Si U₁ = 220 V, U₂ vaut :","options":["22 V","220 V","2200 V","22 000 V"],"correct":0,"explanation":"U₂/U₁ = N₂/N₁, donc U₂ = U₁ × N₂/N₁ = 220 × 100/1000 = 22 V. C''est un transformateur abaisseur."},
      {"id":"q6","question":"La f.é.m. d''un alternateur vaut e = E₀·sin(ωt). La valeur efficace est :","options":["E₀","E₀/2","E₀/√2","E₀·√2"],"correct":2,"explanation":"La valeur efficace d''un signal sinusoïdal est E_eff = E₀/√2 ≈ 0,707·E₀. C''est la valeur du courant continu qui produirait le même effet thermique."},
      {"id":"q7","question":"L''inductance d''un solénoïde dépend de :","options":["L''intensité du courant","Le nombre de spires, la section et la longueur","La tension appliquée","La fréquence du courant"],"correct":1,"explanation":"L = μ₀·N²·S/ℓ. L''inductance dépend de la géométrie (N : nombre de spires, S : section, ℓ : longueur) mais pas du courant ni de la tension."},
      {"id":"q8","question":"Un transformateur fonctionne uniquement en :","options":["Courant continu","Courant alternatif","Courant pulsé","Tout type de courant"],"correct":1,"explanation":"Un transformateur nécessite un flux magnétique variable pour induire une f.é.m. au secondaire. En courant continu, le flux serait constant et aucune tension ne serait induite au secondaire."},
      {"id":"q9","question":"La tension aux bornes d''une bobine idéale (r = 0) en régime variable est :","options":["u = R·i","u = L·i","u = L·di/dt","u = L·dΦ/dt"],"correct":2,"explanation":"Pour une bobine idéale (résistance nulle), u = L·di/dt. La tension est proportionnelle à la dérivée du courant, ce qui traduit l''opposition aux variations de courant."},
      {"id":"q10","question":"Les courants de Foucault sont :","options":["Des courants dans un circuit ouvert","Des courants induits dans les masses métalliques","Des courants continus","Des courants dans le vide"],"correct":1,"explanation":"Les courants de Foucault sont des courants induits qui circulent dans les masses métalliques soumises à un flux magnétique variable. Ils provoquent un échauffement (pertes par effet Joule), utilisé dans les plaques à induction."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 5: Vibrations et ondes
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'vibrations-ondes', 5, 'Vibrations et ondes', 'Son, interférences, Young, spectres, laser', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'vibrations-ondes-fiche', 'Vibrations et ondes', 'Ondes sonores, lumineuses, interférences et diffraction', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une onde et quels sont les types d''ondes ?","answer":"Une onde est la propagation d''une perturbation sans transport de matière. Onde transversale : la perturbation est perpendiculaire à la direction de propagation (onde sur une corde, lumière). Onde longitudinale : la perturbation est parallèle à la propagation (son). Relation fondamentale : v = λ·f (v : célérité, λ : longueur d''onde, f : fréquence)."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les caractéristiques d''une onde sonore ?","answer":"Le son est une onde mécanique longitudinale de compression/dilatation de l''air. Vitesse dans l''air : v ≈ 340 m/s (à 20°C). Domaine audible : 20 Hz à 20 000 Hz. Infrasons < 20 Hz, ultrasons > 20 kHz. L''intensité sonore I (W/m²) et le niveau sonore L = 10·log(I/I₀) en décibels (dB), avec I₀ = 10⁻¹² W/m²."},
      {"id":"fc3","category":"Formule","question":"Qu''est-ce que la diffraction et quand est-elle observable ?","answer":"La diffraction est la déviation de la direction de propagation d''une onde lorsqu''elle rencontre un obstacle ou une ouverture de dimension comparable à sa longueur d''onde. Condition : a ≈ λ (a : taille de l''ouverture). L''angle de diffraction θ ≈ λ/a. Plus l''ouverture est petite (par rapport à λ), plus la diffraction est importante."},
      {"id":"fc4","category":"Formule","question":"Décrire l''expérience des fentes d''Young et la figure d''interférence.","answer":"Deux fentes fines (sources cohérentes) séparées de a produisent des interférences sur un écran à distance D. Interfrange : i = λ·D/a. Franges brillantes (interférence constructive) : différence de marche δ = k·λ (k entier). Franges sombres (destructive) : δ = (k + ½)·λ. Cette expérience prouve la nature ondulatoire de la lumière."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que la lumière et le spectre électromagnétique ?","answer":"La lumière est une onde électromagnétique. Spectre visible : λ = 400 nm (violet) à 800 nm (rouge). Vitesse dans le vide : c = 3×10⁸ m/s. Le spectre électromagnétique comprend (par λ croissante) : rayons γ, rayons X, UV, visible, infrarouge, micro-ondes, ondes radio. E = h·f = h·c/λ."},
      {"id":"fc6","category":"Distinction","question":"Quelle est la différence entre un spectre d''émission et un spectre d''absorption ?","answer":"Spectre d''émission : lumière émise par une source. Continu (solide/liquide chaud), de raies (gaz sous basse pression excité). Spectre d''absorption : spectre continu traversant un gaz froid, des raies sombres apparaissent aux longueurs d''onde absorbées. Les raies d''absorption correspondent exactement aux raies d''émission du même élément (loi de Kirchhoff)."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce qu''un laser et quelles sont ses propriétés ?","answer":"LASER = Light Amplification by Stimulated Emission of Radiation. Propriétés : 1) Monochromatique (une seule longueur d''onde). 2) Directionnel (faisceau très peu divergent). 3) Cohérent (ondes en phase). 4) Intense. Le laser fonctionne par émission stimulée : un photon incident provoque l''émission d''un photon identique par un atome excité."},
      {"id":"fc8","category":"Formule","question":"Quelles sont les conditions d''interférence constructive et destructive ?","answer":"Interférence constructive (maximum d''amplitude) : δ = k·λ, les ondes arrivent en phase. Interférence destructive (amplitude nulle) : δ = (2k+1)·λ/2, les ondes arrivent en opposition de phase. δ est la différence de marche, k est un entier relatif. L''intensité résultante dépend du déphasage Δφ = 2π·δ/λ."},
      {"id":"fc9","category":"Méthode","question":"Comment mesurer une longueur d''onde par l''expérience des fentes d''Young ?","answer":"1) Éclairer deux fentes fines séparées de a avec une lumière monochromatique. 2) Observer la figure d''interférence sur un écran à distance D. 3) Mesurer l''interfrange i (distance entre deux franges brillantes consécutives). 4) Calculer λ = i·a/D. Précision : mesurer plusieurs interfranges et diviser."},
      {"id":"fc10","category":"Exemple","question":"Calculer l''interfrange pour λ = 600 nm, a = 0,2 mm, D = 2 m.","answer":"i = λ·D/a = (600×10⁻⁹ × 2)/(0,2×10⁻³) = 1,2×10⁻⁶/2×10⁻⁴ = 6×10⁻³ m = 6 mm. Les franges sont espacées de 6 mm. Si on augmente D ou diminue a, l''interfrange augmente. Si on utilise une lumière rouge (λ plus grand), l''interfrange est plus grand qu''avec du bleu."},
      {"id":"fc11","category":"Distinction","question":"Quelle est la différence entre ondes stationnaires et ondes progressives ?","answer":"Onde progressive : la perturbation se déplace dans l''espace : y(x,t) = A·sin(ωt - kx). Onde stationnaire : superposition de deux ondes progressives de même fréquence se propageant en sens opposés : y(x,t) = 2A·sin(kx)·cos(ωt). L''onde stationnaire présente des nœuds (amplitude nulle) et des ventres (amplitude maximale) fixes."},
      {"id":"fc12","category":"Formule","question":"Quelles sont les fréquences propres d''une corde vibrante ?","answer":"Une corde de longueur L fixée aux deux extrémités vibre à ses fréquences propres : fn = n·v/(2L) = n·f₁ (n = 1, 2, 3...). f₁ = v/(2L) est le fondamental, les harmoniques sont f₂ = 2f₁, f₃ = 3f₁... La vitesse de propagation : v = √(T/μ) où T est la tension et μ la masse linéique."}
    ],
    "schema": {
      "title": "Vibrations et ondes",
      "nodes": [
        {"id":"n1","label":"Vibrations\net ondes","type":"main"},
        {"id":"n2","label":"Ondes sonores","type":"branch"},
        {"id":"n3","label":"Ondes lumineuses","type":"branch"},
        {"id":"n4","label":"Phénomènes","type":"branch"},
        {"id":"n5","label":"v ≈ 340 m/s\n20 Hz - 20 kHz","type":"leaf"},
        {"id":"n6","label":"Spectres\némission/absorption","type":"leaf"},
        {"id":"n7","label":"Laser\nmonochromatique","type":"leaf"},
        {"id":"n8","label":"Diffraction\nθ ≈ λ/a","type":"leaf"},
        {"id":"n9","label":"Interférences\nYoung : i = λD/a","type":"leaf"},
        {"id":"n10","label":"Ondes\nstationnaires","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mécaniques"},
        {"from":"n1","to":"n3","label":"EM"},
        {"from":"n1","to":"n4","label":"propriétés"},
        {"from":"n2","to":"n5","label":"caractéristiques"},
        {"from":"n3","to":"n6","label":"analyse"},
        {"from":"n3","to":"n7","label":"source cohérente"},
        {"from":"n4","to":"n8","label":"ouverture"},
        {"from":"n4","to":"n9","label":"deux sources"},
        {"from":"n4","to":"n10","label":"réflexion"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La relation fondamentale des ondes est :","options":["v = λ + f","v = λ · f","v = λ / f","v = f / λ"],"correct":1,"explanation":"La célérité v = λ·f relie la vitesse de propagation, la longueur d''onde et la fréquence. C''est la relation fondamentale valable pour toutes les ondes."},
      {"id":"q2","question":"Le domaine audible des fréquences sonores est :","options":["0 - 20 Hz","20 Hz - 20 kHz","20 kHz - 200 kHz","200 kHz - 2 MHz"],"correct":1,"explanation":"L''oreille humaine perçoit les sons de fréquence comprise entre 20 Hz (grave) et 20 000 Hz = 20 kHz (aigu). En dessous : infrasons, au-dessus : ultrasons."},
      {"id":"q3","question":"L''interfrange dans l''expérience de Young est donné par :","options":["i = a·D/λ","i = λ·a/D","i = λ·D/a","i = D/(λ·a)"],"correct":2,"explanation":"L''interfrange i = λ·D/a, où λ est la longueur d''onde, D la distance fentes-écran et a l''écartement entre les fentes."},
      {"id":"q4","question":"La diffraction est observable quand :","options":["λ >> a","a ≈ λ","a >> λ","λ = 0"],"correct":1,"explanation":"La diffraction est significative quand la taille de l''ouverture a est du même ordre de grandeur que la longueur d''onde λ. Si a >> λ, l''onde se propage en ligne droite."},
      {"id":"q5","question":"La vitesse de la lumière dans le vide vaut :","options":["340 m/s","3×10⁶ m/s","3×10⁸ m/s","3×10¹⁰ m/s"],"correct":2,"explanation":"La vitesse de la lumière dans le vide est c = 3×10⁸ m/s = 300 000 km/s. C''est une constante fondamentale de la physique."},
      {"id":"q6","question":"Un laser produit une lumière :","options":["Polychromatique et divergente","Monochromatique et cohérente","Blanche et intense","Continue et incohérente"],"correct":1,"explanation":"Un laser émet une lumière monochromatique (une seule longueur d''onde), cohérente (ondes en phase), directionnelle et intense."},
      {"id":"q7","question":"Les interférences sont constructives quand la différence de marche vaut :","options":["δ = k·λ","δ = (k+½)·λ","δ = k·λ/2","δ = 0 uniquement"],"correct":0,"explanation":"Les interférences sont constructives quand δ = k·λ (k entier), c''est-à-dire quand les ondes arrivent en phase. Pour k = 0 : frange centrale."},
      {"id":"q8","question":"Le spectre d''absorption d''un gaz froid présente :","options":["Un fond continu coloré","Des raies brillantes sur fond noir","Des raies sombres sur fond continu","Un spectre entièrement noir"],"correct":2,"explanation":"Le spectre d''absorption présente des raies sombres sur un fond continu. Le gaz absorbe la lumière aux longueurs d''onde correspondant aux transitions de ses atomes."},
      {"id":"q9","question":"Le niveau sonore en décibels est donné par :","options":["L = I/I₀","L = ln(I/I₀)","L = 10·log(I/I₀)","L = 20·log(I/I₀)"],"correct":2,"explanation":"L = 10·log(I/I₀) en dB, avec I₀ = 10⁻¹² W/m² (seuil d''audibilité). Un doublement de l''intensité correspond à +3 dB."},
      {"id":"q10","question":"La fréquence fondamentale d''une corde vibrante de longueur L est :","options":["f₁ = v/L","f₁ = v/(2L)","f₁ = 2v/L","f₁ = v/(4L)"],"correct":1,"explanation":"Pour une corde fixée aux deux extrémités, f₁ = v/(2L). La corde vibre avec un ventre au centre et des nœuds aux extrémités. Les harmoniques sont fn = n·f₁."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 6: Oscillations libres
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'oscillations-libres', 6, 'Oscillations libres', 'Pendule élastique, pendule pesant/simple/torsion, circuit LC', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oscillations-libres-fiche', 'Oscillations libres', 'Systèmes oscillants mécaniques et électriques', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une oscillation libre non amortie ?","answer":"Une oscillation libre non amortie est un mouvement périodique qui se répète indéfiniment à fréquence constante sans apport d''énergie extérieure et sans perte d''énergie. L''équation différentielle caractéristique est : x'''' + ω₀²·x = 0, dont la solution est x(t) = Xm·cos(ω₀t + φ). ω₀ est la pulsation propre, T₀ = 2π/ω₀ la période propre."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les caractéristiques de l''oscillateur harmonique élastique ?","answer":"Masse m fixée à un ressort de raideur k. Le PFD donne : m·x'''' + k·x = 0, soit x'''' + (k/m)·x = 0. Pulsation propre : ω₀ = √(k/m). Période : T₀ = 2π√(m/k). L''énergie mécanique : Em = ½kx² + ½mv² = ½kXm² = constante. L''énergie oscille entre Ec et Ep."},
      {"id":"fc3","category":"Formule","question":"Quelles sont les caractéristiques du pendule simple ?","answer":"Fil inextensible de longueur l, masse m. Pour de petites oscillations (θ < 15°) : θ'''' + (g/l)·θ = 0. Pulsation : ω₀ = √(g/l). Période : T₀ = 2π√(l/g). La période ne dépend ni de la masse ni de l''amplitude (isochronisme des petites oscillations, loi de Huygens). Application : mesure de g."},
      {"id":"fc4","category":"Formule","question":"Quelles sont les caractéristiques du pendule de torsion ?","answer":"Un disque ou une barre suspendu par un fil de torsion de constante C. L''équation du mouvement : J·θ'''' + C·θ = 0 où J est le moment d''inertie. Pulsation : ω₀ = √(C/J). Période : T₀ = 2π√(J/C). Énergie : E = ½Cθ² + ½Jθ''² = constante."},
      {"id":"fc5","category":"Formule","question":"Décrire les oscillations libres dans un circuit LC.","answer":"Un condensateur C chargé sous q₀ se décharge dans une bobine L. L''équation : L·q'''' + q/C = 0, soit q'''' + ω₀²·q = 0 avec ω₀ = 1/√(LC). Période : T₀ = 2π√(LC). Solution : q(t) = q₀·cos(ω₀t + φ). L''énergie oscille entre énergie électrique ½q²/C et magnétique ½Li². Énergie totale conservée."},
      {"id":"fc6","category":"Distinction","question":"Comparer l''analogie entre oscillateur mécanique et électrique.","answer":"Mécanique → Électrique : x → q, v → i, m → L, k → 1/C, F → u, ½mv² → ½Li², ½kx² → ½q²/C. L''équation est la même : x'''' + ω₀²x = 0 et q'''' + ω₀²q = 0. La masse joue le rôle de l''inductance (inertie), la raideur celui de l''inverse de la capacité (rappel)."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que l''amortissement d''un oscillateur ?","answer":"L''amortissement est la diminution progressive de l''amplitude des oscillations due à des forces dissipatives. Oscillateur mécanique : frottements visqueux f = -h·v. Oscillateur électrique : résistance R dans le circuit RLC. L''équation devient : x'''' + (h/m)·x'' + ω₀²·x = 0. Trois régimes : pseudo-périodique, critique, apériodique."},
      {"id":"fc8","category":"Distinction","question":"Quels sont les trois régimes d''amortissement ?","answer":"Régime pseudo-périodique : l''amplitude décroît exponentiellement mais le système oscille (amortissement faible). Régime critique : retour le plus rapide à l''équilibre sans oscillation (amortissement optimal). Régime apériodique : retour lent à l''équilibre sans oscillation (amortissement fort). La frontière est déterminée par le discriminant de l''équation caractéristique."},
      {"id":"fc9","category":"Méthode","question":"Comment déterminer expérimentalement la période propre d''un pendule simple ?","answer":"1) Écarter le pendule d''un petit angle (< 15°) et le lâcher sans vitesse initiale. 2) Mesurer le temps de N oscillations complètes (N ≥ 10 pour la précision). 3) T₀ = temps total / N. 4) Vérifier l''isochronisme en changeant l''amplitude. 5) Pour déterminer g : g = 4π²l/T₀². La longueur l se mesure du point de suspension au centre de la masse."},
      {"id":"fc10","category":"Formule","question":"Exprimer l''énergie mécanique d''un oscillateur harmonique élastique.","answer":"Em = Ec + Ep = ½mv² + ½kx². À l''élongation maximale (x = Xm, v = 0) : Em = ½kXm². À la position d''équilibre (x = 0, v = vm) : Em = ½mvm². Conservation : ½kXm² = ½mvm², donc vm = Xm·ω₀ = Xm·√(k/m)."},
      {"id":"fc11","category":"Exemple","question":"Un pendule simple de longueur l = 1 m oscille à la surface de la Terre. Calculer sa période.","answer":"T₀ = 2π√(l/g) = 2π√(1/9,81) = 2π × 0,319 = 2,006 s ≈ 2 s. C''est la règle du pendule battant la seconde : un pendule de 1 m a une période très proche de 2 s. Si on va sur la Lune (g = 1,6 m/s²), T = 2π√(1/1,6) = 4,97 s (oscillation plus lente)."},
      {"id":"fc12","category":"Méthode","question":"Comment résoudre l''équation différentielle x'''' + ω₀²x = 0 ?","answer":"1) Identifier l''équation harmonique. 2) L''équation caractéristique r² + ω₀² = 0 donne r = ±jω₀. 3) Solution générale : x(t) = A·cos(ω₀t) + B·sin(ω₀t) = Xm·cos(ω₀t + φ). 4) Déterminer Xm et φ avec les conditions initiales : x(0) = Xm·cos(φ), v(0) = -Xm·ω₀·sin(φ)."}
    ],
    "schema": {
      "title": "Oscillations libres",
      "nodes": [
        {"id":"n1","label":"Oscillations\nlibres","type":"main"},
        {"id":"n2","label":"Mécaniques","type":"branch"},
        {"id":"n3","label":"Électriques","type":"branch"},
        {"id":"n4","label":"Amortissement","type":"branch"},
        {"id":"n5","label":"Pendule simple\nT = 2π√(l/g)","type":"leaf"},
        {"id":"n6","label":"Ressort\nT = 2π√(m/k)","type":"leaf"},
        {"id":"n7","label":"Torsion\nT = 2π√(J/C)","type":"leaf"},
        {"id":"n8","label":"Circuit LC\nT = 2π√(LC)","type":"leaf"},
        {"id":"n9","label":"Pseudo-périodique\ncritique\napériodique","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"x'''' + ω₀²x = 0"},
        {"from":"n1","to":"n3","label":"q'''' + ω₀²q = 0"},
        {"from":"n1","to":"n4","label":"dissipation"},
        {"from":"n2","to":"n5","label":"gravité"},
        {"from":"n2","to":"n6","label":"élastique"},
        {"from":"n2","to":"n7","label":"torsion"},
        {"from":"n3","to":"n8","label":"analogie"},
        {"from":"n4","to":"n9","label":"régimes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La période propre d''un pendule simple est :","options":["T = 2π√(m/g)","T = 2π√(l/g)","T = 2π√(g/l)","T = 2π√(l/m)"],"correct":1,"explanation":"T₀ = 2π√(l/g). La période ne dépend que de la longueur l et de g, pas de la masse (isochronisme des petites oscillations)."},
      {"id":"q2","question":"La pulsation propre d''un oscillateur masse-ressort est :","options":["ω₀ = k/m","ω₀ = √(k/m)","ω₀ = m/k","ω₀ = √(m/k)"],"correct":1,"explanation":"ω₀ = √(k/m) avec k la raideur du ressort et m la masse. La période correspondante est T₀ = 2π/ω₀ = 2π√(m/k)."},
      {"id":"q3","question":"Dans un circuit LC, la pulsation propre est :","options":["ω₀ = LC","ω₀ = 1/(LC)","ω₀ = √(LC)","ω₀ = 1/√(LC)"],"correct":3,"explanation":"ω₀ = 1/√(LC). La période est T₀ = 2π√(LC). L joue le rôle de la masse et C joue le rôle de l''inverse de la raideur."},
      {"id":"q4","question":"L''énergie mécanique d''un oscillateur harmonique non amorti est :","options":["Variable","Constante","Toujours nulle","Croissante"],"correct":1,"explanation":"En l''absence d''amortissement, l''énergie mécanique Em = Ec + Ep est constante. Elle oscille entre forme cinétique et potentielle."},
      {"id":"q5","question":"L''isochronisme des petites oscillations du pendule simple signifie que :","options":["La masse n''influe pas sur la période","L''amplitude n''influe pas sur la période","La longueur n''influe pas sur la période","g n''influe pas sur la période"],"correct":1,"explanation":"L''isochronisme signifie que la période ne dépend pas de l''amplitude (pour de petites oscillations θ < 15°). Elle ne dépend que de l et g."},
      {"id":"q6","question":"L''analogie mécanique-électrique associe la masse m à :","options":["La résistance R","La capacité C","L''inductance L","La charge q"],"correct":2,"explanation":"m ↔ L : la masse représente l''inertie mécanique, l''inductance représente l''inertie électrique (opposition aux variations de courant)."},
      {"id":"q7","question":"En régime pseudo-périodique, l''amplitude des oscillations :","options":["Reste constante","Augmente exponentiellement","Décroît exponentiellement","Oscille"],"correct":2,"explanation":"En régime pseudo-périodique, l''amplitude décroît exponentiellement avec le temps à cause de la dissipation d''énergie. Le système oscille encore mais de moins en moins fort."},
      {"id":"q8","question":"La solution de l''équation x'''' + ω₀²x = 0 est :","options":["x = Xm·exp(-ω₀t)","x = Xm·cos(ω₀t + φ)","x = Xm·t²","x = Xm·sin(ω₀²t)"],"correct":1,"explanation":"La solution générale est x(t) = Xm·cos(ω₀t + φ), une fonction sinusoïdale de pulsation ω₀. Xm est l''amplitude et φ la phase initiale."},
      {"id":"q9","question":"Dans un circuit LC, l''énergie oscille entre :","options":["Cinétique et potentielle","Électrique et magnétique","Thermique et mécanique","Chimique et électrique"],"correct":1,"explanation":"L''énergie oscille entre énergie électrique ½q²/C (condensateur) et énergie magnétique ½Li² (bobine). L''énergie totale est constante."},
      {"id":"q10","question":"Le régime critique correspond à :","options":["Le retour le plus lent à l''équilibre","Le retour le plus rapide sans oscillation","Des oscillations permanentes","Un amortissement nul"],"correct":1,"explanation":"Le régime critique est le retour le plus rapide à l''équilibre sans oscillation. C''est le cas idéal pour les amortisseurs de voiture."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 7: Oscillations forcées
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'oscillations-forcees', 7, 'Oscillations forcées', 'Résonance mécanique et électrique', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oscillations-forcees-fiche', 'Oscillations forcées', 'Résonance mécanique et électrique RLC', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une oscillation forcée ?","answer":"Une oscillation forcée est produite lorsqu''un système oscillant est soumis à une excitation extérieure périodique de fréquence f (excitateur). En régime permanent, le système oscille à la fréquence de l''excitateur (pas à sa fréquence propre). L''amplitude dépend de la fréquence d''excitation et de l''amortissement."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce que la résonance ?","answer":"La résonance est le phénomène qui se produit quand la fréquence d''excitation f est égale (ou proche) de la fréquence propre f₀ du système. L''amplitude des oscillations est alors maximale. Plus l''amortissement est faible, plus le pic de résonance est aigu et élevé. La résonance peut être mécanique (pont, balançoire) ou électrique (circuit RLC)."},
      {"id":"fc3","category":"Formule","question":"Décrire le circuit RLC série en régime sinusoïdal forcé.","answer":"Un circuit RLC série alimenté par u(t) = Um·sin(ωt). L''impédance Z = √(R² + (Lω - 1/(Cω))²). Le courant : I = Um/Z. La résonance d''intensité se produit quand Lω = 1/(Cω), soit ω = ω₀ = 1/√(LC). À la résonance : Z = R (minimale) et I = Um/R (maximale)."},
      {"id":"fc4","category":"Formule","question":"Qu''est-ce que le facteur de qualité Q d''un circuit RLC ?","answer":"Le facteur de qualité Q = Lω₀/R = 1/(Rω₀C) = (1/R)·√(L/C). Q caractérise l''acuité de la résonance : plus Q est grand, plus le pic est aigu et élevé. La bande passante est Δf = f₀/Q. Pour Q >> 1, la résonance est très sélective (filtrage étroit). Applications : tuner radio, filtre passe-bande."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre résonance d''amplitude et résonance d''intensité ?","answer":"Résonance d''intensité (circuit RLC) : l''intensité du courant est maximale à f = f₀ = 1/(2π√(LC)). L''impédance est minimale (Z = R). Résonance d''amplitude (mécanique) : l''amplitude est maximale à fr = f₀√(1 - 1/(2Q²)), légèrement inférieure à f₀ si Q est modéré. Pour Q grand : fr ≈ f₀."},
      {"id":"fc6","category":"Formule","question":"Exprimer l''impédance et le déphasage dans un circuit RLC série.","answer":"Impédance : Z = √(R² + (Lω - 1/(Cω))²). Déphasage tension/courant : tan(φ) = (Lω - 1/(Cω))/R. Si Lω > 1/(Cω) : circuit inductif (φ > 0, u en avance sur i). Si Lω < 1/(Cω) : circuit capacitif (φ < 0, i en avance sur u). À la résonance : φ = 0 (u et i en phase)."},
      {"id":"fc7","category":"Méthode","question":"Comment exploiter une courbe de résonance ?","answer":"1) Lire l''amplitude maximale Am (ou Imax) au sommet. 2) La fréquence au sommet donne f₀ (ou fr). 3) Mesurer la bande passante Δf à Am/√2 (ou Imax/√2). 4) Calculer Q = f₀/Δf. 5) Un pic aigu indique un faible amortissement (Q élevé). 6) Si on change R : plus R est grand, plus le pic s''aplatit et s''élargit."},
      {"id":"fc8","category":"Exemple","question":"Donner des exemples de résonance en physique.","answer":"1) Balançoire : on pousse à la fréquence propre pour maximiser l''amplitude. 2) Pont de Tacoma (1940) : effondrement par résonance avec le vent. 3) Radio : le circuit LC est accordé à la fréquence de la station (résonance électrique). 4) Four micro-ondes : la fréquence 2,45 GHz correspond à la résonance de la molécule d''eau. 5) IRM : résonance magnétique nucléaire."},
      {"id":"fc9","category":"Formule","question":"Quelle est l''équation différentielle d''un oscillateur mécanique forcé ?","answer":"Pour un système masse-ressort amorti et excité par F(t) = Fm·cos(ωt) : m·x'''' + h·x'' + k·x = Fm·cos(ωt). En régime permanent, x(t) = Xm·cos(ωt + φ). L''amplitude Xm = Fm/√((k - mω²)² + h²ω²). Xm est maximale pour ω proche de ω₀ = √(k/m)."},
      {"id":"fc10","category":"Distinction","question":"Comparer les régimes transitoire et permanent.","answer":"Régime transitoire : au début de l''excitation, le système oscille avec un mélange de sa fréquence propre f₀ et de la fréquence d''excitation f. La composante à f₀ s''amortit progressivement. Régime permanent : après amortissement du transitoire, seule subsiste l''oscillation à la fréquence f de l''excitateur. L''amplitude et le déphasage sont constants."},
      {"id":"fc11","category":"Formule","question":"Exprimer la puissance moyenne dissipée dans un circuit RLC.","answer":"La puissance moyenne consommée est P = U_eff·I_eff·cos(φ) = R·I_eff². cos(φ) est le facteur de puissance. À la résonance : φ = 0, cos(φ) = 1, P = U_eff²/R (puissance maximale). Hors résonance : P diminue car I diminue et cos(φ) < 1. Seule la résistance R dissipe de l''énergie."},
      {"id":"fc12","category":"Méthode","question":"Comment accorder un récepteur radio à une station ?","answer":"Le récepteur contient un circuit LC variable. Pour capter une station de fréquence f, on ajuste C (condensateur variable) pour que f₀ = 1/(2π√(LC)) = f (résonance). Le circuit sélectionne la fréquence désirée et rejette les autres. Un facteur de qualité Q élevé assure une bonne sélectivité (séparation des stations proches)."}
    ],
    "schema": {
      "title": "Oscillations forcées et résonance",
      "nodes": [
        {"id":"n1","label":"Oscillations\nforcées","type":"main"},
        {"id":"n2","label":"Mécanique","type":"branch"},
        {"id":"n3","label":"Électrique\nRLC","type":"branch"},
        {"id":"n4","label":"Résonance","type":"branch"},
        {"id":"n5","label":"Excitation\nF = Fm·cos(ωt)","type":"leaf"},
        {"id":"n6","label":"Régime permanent\nf = f_excitateur","type":"leaf"},
        {"id":"n7","label":"Impédance Z\nDéphasage φ","type":"leaf"},
        {"id":"n8","label":"Amplitude max\nquand f ≈ f₀","type":"leaf"},
        {"id":"n9","label":"Facteur Q\nBande passante","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"masse-ressort"},
        {"from":"n1","to":"n3","label":"circuit"},
        {"from":"n1","to":"n4","label":"phénomène"},
        {"from":"n2","to":"n5","label":"force"},
        {"from":"n2","to":"n6","label":"solution"},
        {"from":"n3","to":"n7","label":"caractéristiques"},
        {"from":"n4","to":"n8","label":"condition"},
        {"from":"n4","to":"n9","label":"sélectivité"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"En régime permanent d''oscillations forcées, le système oscille à :","options":["Sa fréquence propre f₀","La fréquence de l''excitateur f","La moyenne (f + f₀)/2","Le double 2f₀"],"correct":1,"explanation":"En régime permanent, le système oscille à la fréquence f de l''excitateur, quelle que soit sa fréquence propre. L''amplitude dépend de l''écart |f - f₀|."},
      {"id":"q2","question":"La résonance d''intensité dans un circuit RLC série se produit quand :","options":["R = 0","Lω = 1/(Cω)","L = C","ω = 0"],"correct":1,"explanation":"La résonance d''intensité se produit quand Lω = 1/(Cω), soit ω = 1/√(LC) = ω₀. L''impédance Z = R est minimale et le courant I = Um/R est maximal."},
      {"id":"q3","question":"Le facteur de qualité Q d''un circuit RLC série est donné par :","options":["Q = R/(Lω₀)","Q = Lω₀/R","Q = RCω₀","Q = R·L·C"],"correct":1,"explanation":"Q = Lω₀/R = (1/R)·√(L/C). Plus R est faible, plus Q est grand et la résonance est aiguë et sélective."},
      {"id":"q4","question":"À la résonance d''un circuit RLC série, le déphasage φ entre u et i vaut :","options":["π/2","π","-π/2","0"],"correct":3,"explanation":"À la résonance, la tension et le courant sont en phase (φ = 0). Les tensions aux bornes de L et C se compensent exactement."},
      {"id":"q5","question":"La bande passante Δf d''un circuit résonant est liée au facteur de qualité par :","options":["Δf = Q·f₀","Δf = f₀/Q","Δf = Q/f₀","Δf = f₀·Q²"],"correct":1,"explanation":"Δf = f₀/Q. Plus Q est grand, plus la bande passante est étroite et la sélectivité est grande."},
      {"id":"q6","question":"L''impédance d''un circuit RLC série est :","options":["Z = R + Lω + 1/(Cω)","Z = √(R² + (Lω - 1/(Cω))²)","Z = R·L·C·ω","Z = R² + L²ω²"],"correct":1,"explanation":"Z = √(R² + (Lω - 1/(Cω))²). Elle est minimale à la résonance (Z = R) quand Lω = 1/(Cω)."},
      {"id":"q7","question":"Le pont de Tacoma s''est effondré à cause de :","options":["La corrosion","La résonance avec le vent","Un tremblement de terre","La surcharge"],"correct":1,"explanation":"Le pont de Tacoma (1940) s''est effondré par résonance : le vent excitait le pont à sa fréquence propre, provoquant des oscillations d''amplitude croissante et fatale."},
      {"id":"q8","question":"La puissance moyenne dans un circuit RLC à la résonance est :","options":["P = 0","P = Ueff²/R","P = Ueff·Ieff/2","P = R·Ieff"],"correct":1,"explanation":"À la résonance, cos(φ) = 1, donc P = Ueff·Ieff = Ueff²/R = R·Ieff². C''est la puissance maximale que le circuit peut absorber."},
      {"id":"q9","question":"Quand l''amortissement augmente dans un circuit RLC :","options":["Le pic de résonance devient plus aigu","Le pic de résonance s''aplatit et s''élargit","La fréquence de résonance double","Le circuit ne résonne plus jamais"],"correct":1,"explanation":"Quand R augmente (amortissement accru), le facteur Q diminue, le pic de résonance s''aplatit et s''élargit. La sélectivité diminue."},
      {"id":"q10","question":"Pour accorder un récepteur radio, on fait varier :","options":["La résistance R","L''inductance L ou la capacité C","La tension d''alimentation","Le nombre de spires"],"correct":1,"explanation":"On fait varier C (condensateur variable) pour que f₀ = 1/(2π√(LC)) corresponde à la fréquence de la station désirée. Le circuit LC sélectionne cette fréquence par résonance."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 8: Effet photoélectrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'effet-photoelectrique', 8, 'Effet photoélectrique', 'Lois, applications', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'effet-photoelectrique-fiche', 'Effet photoélectrique', 'Lois de l''effet photoélectrique et applications', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''effet photoélectrique ?","answer":"L''effet photoélectrique est l''émission d''électrons par une surface métallique éclairée par un rayonnement de fréquence suffisante. Découvert par Hertz (1887), expliqué par Einstein (1905). Chaque photon incident d''énergie E = hν cède son énergie à un électron. Si hν ≥ W (travail d''extraction), l''électron est arraché du métal."},
      {"id":"fc2","category":"Formule","question":"Énoncer la relation d''Einstein pour l''effet photoélectrique.","answer":"hν = W + ½mv²_max où h = 6,626×10⁻³⁴ J·s (constante de Planck), ν la fréquence de la lumière, W = hν₀ le travail d''extraction du métal, ½mv²_max l''énergie cinétique maximale des photoélectrons. Le seuil photoélectrique est ν₀ = W/h (ou λ₀ = hc/W)."},
      {"id":"fc3","category":"Formule","question":"Quelles sont les lois de l''effet photoélectrique ?","answer":"1) Loi du seuil : l''effet n''existe que si ν ≥ ν₀ (seuil), indépendamment de l''intensité lumineuse. 2) Loi de l''énergie cinétique : Ec_max = hν - W, proportionnelle à ν, indépendante de l''intensité. 3) L''intensité du courant photoélectrique (nombre d''électrons émis) est proportionnelle à l''intensité lumineuse (nombre de photons)."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un photon ?","answer":"Le photon est le quantum de lumière, particule de masse nulle se déplaçant à la vitesse c. Son énergie est E = hν = hc/λ. Sa quantité de mouvement est p = h/λ = E/c. La lumière a une double nature : ondulatoire (interférences, diffraction) et corpusculaire (effet photoélectrique). C''est la dualité onde-corpuscule."},
      {"id":"fc5","category":"Distinction","question":"Pourquoi la physique classique ne peut-elle pas expliquer l''effet photoélectrique ?","answer":"La physique classique (ondulatoire) prédit que n''importe quelle fréquence devrait émettre des électrons si l''intensité est suffisante (accumulation d''énergie). Or l''expérience montre : 1) l''existence d''un seuil de fréquence, 2) l''émission instantanée, 3) Ec indépendante de l''intensité. Seule la théorie quantique d''Einstein (photons) explique ces faits."},
      {"id":"fc6","category":"Formule","question":"Comment déterminer le potentiel d''arrêt ?","answer":"Le potentiel d''arrêt V₀ est la tension inverse minimale qui annule le courant photoélectrique. Il correspond à l''énergie cinétique maximale : e·V₀ = ½mv²_max = hν - W. Donc V₀ = (hν - W)/e. V₀ augmente linéairement avec ν. La pente de la droite V₀(ν) donne h/e, l''ordonnée à l''origine donne -W/e."},
      {"id":"fc7","category":"Méthode","question":"Comment déterminer h et W expérimentalement ?","answer":"1) Mesurer le potentiel d''arrêt V₀ pour différentes fréquences ν. 2) Tracer V₀ = f(ν) : c''est une droite. 3) La pente donne h/e, donc h = pente × e. 4) L''intersection avec l''axe des fréquences donne ν₀ (seuil). 5) W = hν₀. 6) L''ordonnée à l''origine vaut -W/e. h ≈ 6,63×10⁻³⁴ J·s."},
      {"id":"fc8","category":"Exemple","question":"Le travail d''extraction du césium est W = 1,9 eV. Quel est le seuil photoélectrique ?","answer":"W = 1,9 eV = 1,9 × 1,6×10⁻¹⁹ = 3,04×10⁻¹⁹ J. Le seuil en fréquence : ν₀ = W/h = 3,04×10⁻¹⁹/6,63×10⁻³⁴ = 4,59×10¹⁴ Hz. Le seuil en longueur d''onde : λ₀ = c/ν₀ = 3×10⁸/4,59×10¹⁴ = 654 nm (rouge). Le césium est sensible à la lumière visible."},
      {"id":"fc9","category":"Distinction","question":"Quelles sont les applications de l''effet photoélectrique ?","answer":"1) Cellules photoélectriques (portes automatiques, alarmes). 2) Panneaux photovoltaïques (conversion lumière → électricité). 3) Capteurs CCD/CMOS (caméras numériques). 4) Photomultiplicateurs (détection de lumière très faible). 5) Spectroscopie photoélectronique (analyse de surfaces). L''effet photoélectrique est à la base de l''énergie solaire."},
      {"id":"fc10","category":"Formule","question":"Qu''est-ce que la dualité onde-corpuscule ?","answer":"Toute particule de quantité de mouvement p possède une longueur d''onde associée : λ = h/p (relation de De Broglie). Pour la lumière : aspect ondulatoire (interférences, diffraction) et corpusculaire (effet photoélectrique). Pour les électrons : aspect corpusculaire (trajectoire) et ondulatoire (diffraction des électrons). C''est un pilier de la mécanique quantique."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que l''électronvolt (eV) ?","answer":"L''électronvolt est l''énergie acquise par un électron accéléré sous une différence de potentiel de 1 volt : 1 eV = e × 1 V = 1,6×10⁻¹⁹ J. C''est une unité pratique en physique atomique et nucléaire. Les travaux d''extraction sont de l''ordre de quelques eV. Les énergies de liaison nucléaire sont en MeV."},
      {"id":"fc12","category":"Méthode","question":"Comment résoudre un exercice sur l''effet photoélectrique ?","answer":"1) Identifier les données : λ ou ν de la lumière, W ou ν₀ du métal. 2) Calculer l''énergie du photon : E = hν = hc/λ. 3) Vérifier si E ≥ W (sinon pas d''effet). 4) Calculer Ec_max = hν - W. 5) Si demandé, calculer v_max = √(2Ec_max/m) avec m = 9,11×10⁻³¹ kg. 6) Calculer le potentiel d''arrêt V₀ = Ec_max/e."}
    ],
    "schema": {
      "title": "Effet photoélectrique",
      "nodes": [
        {"id":"n1","label":"Effet\nphotoélectrique","type":"main"},
        {"id":"n2","label":"Lois","type":"branch"},
        {"id":"n3","label":"Photon","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"Seuil ν₀ = W/h","type":"leaf"},
        {"id":"n6","label":"Einstein\nhν = W + Ec","type":"leaf"},
        {"id":"n7","label":"E = hν\np = h/λ","type":"leaf"},
        {"id":"n8","label":"Dualité\nonde-corpuscule","type":"leaf"},
        {"id":"n9","label":"Cellule photoélectrique\nPanneaux solaires","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"expérimental"},
        {"from":"n1","to":"n3","label":"quantique"},
        {"from":"n1","to":"n4","label":"technologie"},
        {"from":"n2","to":"n5","label":"condition"},
        {"from":"n2","to":"n6","label":"bilan énergie"},
        {"from":"n3","to":"n7","label":"propriétés"},
        {"from":"n3","to":"n8","label":"De Broglie"},
        {"from":"n4","to":"n9","label":"exemples"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''énergie d''un photon est donnée par :","options":["E = mc²","E = hν","E = ½mv²","E = qV"],"correct":1,"explanation":"L''énergie d''un photon est E = hν = hc/λ, où h est la constante de Planck et ν la fréquence du rayonnement."},
      {"id":"q2","question":"L''effet photoélectrique se produit si :","options":["L''intensité lumineuse est suffisante","La fréquence ν ≥ ν₀ (seuil)","La tension est positive","Le métal est chaud"],"correct":1,"explanation":"L''effet photoélectrique nécessite que la fréquence du rayonnement soit supérieure au seuil ν₀ du métal. L''intensité lumineuse n''a aucun effet si ν < ν₀."},
      {"id":"q3","question":"La relation d''Einstein pour l''effet photoélectrique est :","options":["hν = W + ½mv²","hν = W - ½mv²","hν = ½mv² - W","hν = W × ½mv²"],"correct":0,"explanation":"hν = W + ½mv²_max. L''énergie du photon est partagée entre le travail d''extraction W et l''énergie cinétique maximale du photoélectron."},
      {"id":"q4","question":"1 eV vaut :","options":["1,6×10⁻¹⁹ J","9,11×10⁻³¹ J","6,63×10⁻³⁴ J","1,6×10⁻¹⁹ C"],"correct":0,"explanation":"1 eV = 1,6×10⁻¹⁹ J. C''est l''énergie gagnée par un électron accéléré sous 1 volt. Ne pas confondre avec la charge e = 1,6×10⁻¹⁹ C."},
      {"id":"q5","question":"Le potentiel d''arrêt V₀ augmente quand :","options":["L''intensité lumineuse augmente","La fréquence augmente","La surface du métal augmente","La distance source-métal diminue"],"correct":1,"explanation":"V₀ = (hν - W)/e. Le potentiel d''arrêt augmente linéairement avec la fréquence ν. Il ne dépend pas de l''intensité lumineuse."},
      {"id":"q6","question":"La constante de Planck h vaut environ :","options":["6,63×10⁻³⁴ J·s","1,6×10⁻¹⁹ J","9,81 m/s²","3×10⁸ m/s"],"correct":0,"explanation":"h = 6,626×10⁻³⁴ J·s est la constante de Planck, grandeur fondamentale de la physique quantique."},
      {"id":"q7","question":"La relation de De Broglie est :","options":["E = mc²","λ = h/p","F = ma","E = hν"],"correct":1,"explanation":"λ = h/p associe une longueur d''onde à toute particule de quantité de mouvement p. C''est le fondement de la dualité onde-corpuscule."},
      {"id":"q8","question":"L''effet photoélectrique a été expliqué par :","options":["Newton","Maxwell","Einstein","Bohr"],"correct":2,"explanation":"Einstein a expliqué l''effet photoélectrique en 1905 en introduisant le concept de photon (quantum de lumière). Il a reçu le prix Nobel de physique en 1921 pour cette découverte."},
      {"id":"q9","question":"Le courant photoélectrique augmente quand :","options":["La fréquence augmente","La tension augmente indéfiniment","L''intensité lumineuse augmente","Le travail d''extraction augmente"],"correct":2,"explanation":"Le courant photoélectrique (nombre d''électrons émis par seconde) est proportionnel à l''intensité lumineuse (nombre de photons incidents par seconde)."},
      {"id":"q10","question":"Le seuil photoélectrique du césium est λ₀ = 654 nm. Un rayonnement UV de λ = 300 nm :","options":["Ne produit pas d''effet photoélectrique","Produit des photoélectrons avec Ec > 0","Produit des photoélectrons avec Ec = 0","Est absorbé sans émission"],"correct":1,"explanation":"λ = 300 nm < λ₀ = 654 nm, donc ν > ν₀. Le photon a assez d''énergie : Ec = hc/λ - hc/λ₀ > 0. Des photoélectrons sont émis avec une énergie cinétique positive."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 9: Niveaux d''énergie et spectres
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'niveaux-energie-spectres', 9, 'Niveaux d''énergie et spectres', 'Hydrogène, raies, rayons X', 9)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'niveaux-energie-spectres-fiche', 'Niveaux d''énergie et spectres', 'Atome d''hydrogène, raies spectrales et rayons X', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la quantification de l''énergie dans l''atome ?","answer":"Dans le modèle de Bohr, l''électron ne peut occuper que des niveaux d''énergie discrets (quantifiés). Pour l''hydrogène : En = -13,6/n² eV (n = 1, 2, 3...). n = 1 est l''état fondamental (E₁ = -13,6 eV), n ≥ 2 sont les états excités. L''énergie d''ionisation est |E₁| = 13,6 eV."},
      {"id":"fc2","category":"Formule","question":"Comment se produit l''émission ou l''absorption d''un photon par un atome ?","answer":"Émission : l''atome passe d''un niveau En (supérieur) à un niveau Ep (inférieur) en émettant un photon d''énergie hν = En - Ep. Absorption : l''atome absorbe un photon d''énergie hν = Ep - En pour passer d''un niveau inférieur à un niveau supérieur. La fréquence du photon est ν = (En - Ep)/h."},
      {"id":"fc3","category":"Formule","question":"Quelles sont les séries spectrales de l''hydrogène ?","answer":"Série de Lyman (UV) : transitions vers n = 1. Série de Balmer (visible) : transitions vers n = 2. Série de Paschen (IR) : transitions vers n = 3. Formule de Rydberg : 1/λ = R_H·(1/p² - 1/n²) avec R_H = 1,097×10⁷ m⁻¹ (constante de Rydberg), p le niveau final, n > p le niveau initial."},
      {"id":"fc4","category":"Exemple","question":"Calculer la longueur d''onde de la raie Hα de la série de Balmer.","answer":"La raie Hα correspond à la transition n = 3 → n = 2. 1/λ = R_H(1/2² - 1/3²) = 1,097×10⁷(1/4 - 1/9) = 1,097×10⁷ × 5/36 = 1,524×10⁶ m⁻¹. λ = 656 nm (rouge). C''est la raie rouge caractéristique de l''hydrogène, visible dans les nébuleuses."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que le modèle de Bohr de l''atome d''hydrogène ?","answer":"Postulats de Bohr (1913) : 1) L''électron tourne sur des orbites circulaires stables de rayon quantifié : rn = n²·a₀ (a₀ = 0,053 nm, rayon de Bohr). 2) Le moment cinétique est quantifié : L = n·ℏ. 3) L''atome n''émet ni n''absorbe d''énergie sur ces orbites. 4) Il émet/absorbe un photon hν = |Ef - Ei| lors d''une transition."},
      {"id":"fc6","category":"Formule","question":"Comment sont produits les rayons X ?","answer":"Les rayons X sont produits quand des électrons de haute énergie cinétique frappent une cible métallique. Rayons X continus (Bremsstrahlung) : l''électron est freiné et émet un photon. λ_min = hc/(eU) (U : tension d''accélération). Rayons X caractéristiques : l''électron arrache un électron interne de l''atome cible, un électron externe comble la lacune en émettant un photon X."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre spectre continu et spectre de raies ?","answer":"Spectre continu : émis par un solide, un liquide ou un gaz dense chauffé. Toutes les longueurs d''onde sont présentes (ex : filament incandescent). Spectre de raies : émis par un gaz à basse pression excité. Seules certaines longueurs d''onde sont présentes, caractéristiques de l''élément (ex : lampe à sodium → raie jaune à 589 nm)."},
      {"id":"fc8","category":"Méthode","question":"Comment identifier un élément chimique par son spectre ?","answer":"1) Obtenir le spectre d''émission du gaz (tube à décharge ou flamme). 2) Comparer les raies observées avec les spectres de référence des éléments connus. 3) Chaque élément a un spectre unique (empreinte digitale). 4) En astrophysique, on analyse le spectre d''absorption des étoiles pour déterminer leur composition chimique."},
      {"id":"fc9","category":"Formule","question":"Quelle est l''énergie d''ionisation de l''hydrogène ?","answer":"L''énergie d''ionisation est l''énergie minimale pour arracher l''électron de l''état fondamental : Eion = E∞ - E₁ = 0 - (-13,6) = 13,6 eV = 2,18×10⁻¹⁸ J. La longueur d''onde correspondante : λ = hc/Eion = 91,2 nm (UV lointain, série de Lyman)."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre émission spontanée et émission stimulée ?","answer":"Émission spontanée : un atome excité retombe spontanément à un niveau inférieur en émettant un photon dans une direction aléatoire. Émission stimulée : un photon incident d''énergie hν = En - Ep provoque la désexcitation, émettant un photon identique (même fréquence, direction, phase). L''émission stimulée est le principe du laser."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que le nombre quantique principal n ?","answer":"Le nombre quantique principal n (= 1, 2, 3...) détermine le niveau d''énergie de l''électron dans l''atome d''hydrogène : En = -13,6/n² eV. Il détermine aussi le rayon de l''orbite : rn = n²·a₀. Plus n est grand, plus l''énergie est élevée (moins négative) et l''électron est éloigné du noyau. n = ∞ correspond à l''ionisation."},
      {"id":"fc12","category":"Exemple","question":"Un atome d''hydrogène passe de n = 4 à n = 2. Quelle est l''énergie du photon émis ?","answer":"E₄ = -13,6/16 = -0,85 eV. E₂ = -13,6/4 = -3,4 eV. Énergie du photon : hν = E₄ - E₂ = -0,85 - (-3,4) = 2,55 eV. C''est la raie Hβ de la série de Balmer. λ = hc/E = 1240/2,55 ≈ 486 nm (bleu-vert). On utilise hc = 1240 eV·nm."}
    ],
    "schema": {
      "title": "Niveaux d''énergie et spectres",
      "nodes": [
        {"id":"n1","label":"Niveaux d''énergie\net spectres","type":"main"},
        {"id":"n2","label":"Atome de Bohr","type":"branch"},
        {"id":"n3","label":"Séries spectrales","type":"branch"},
        {"id":"n4","label":"Rayons X","type":"branch"},
        {"id":"n5","label":"En = -13,6/n² eV","type":"leaf"},
        {"id":"n6","label":"hν = En - Ep","type":"leaf"},
        {"id":"n7","label":"Lyman (UV)\nBalmer (visible)\nPaschen (IR)","type":"leaf"},
        {"id":"n8","label":"Continu\n(Bremsstrahlung)","type":"leaf"},
        {"id":"n9","label":"Caractéristiques\n(raies)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"modèle"},
        {"from":"n1","to":"n3","label":"hydrogène"},
        {"from":"n1","to":"n4","label":"haute énergie"},
        {"from":"n2","to":"n5","label":"quantification"},
        {"from":"n2","to":"n6","label":"transitions"},
        {"from":"n3","to":"n7","label":"séries"},
        {"from":"n4","to":"n8","label":"freinage"},
        {"from":"n4","to":"n9","label":"transitions internes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''énergie du niveau fondamental de l''hydrogène est :","options":["E₁ = 13,6 eV","E₁ = -13,6 eV","E₁ = -3,4 eV","E₁ = 0 eV"],"correct":1,"explanation":"E₁ = -13,6/1² = -13,6 eV. L''énergie est négative car l''électron est lié au noyau. Plus n augmente, plus E se rapproche de 0 (ionisation)."},
      {"id":"q2","question":"La série de Balmer correspond aux transitions vers :","options":["n = 1","n = 2","n = 3","n = ∞"],"correct":1,"explanation":"La série de Balmer correspond aux transitions vers le niveau n = 2. Elle se situe dans le domaine visible. Lyman → n = 1 (UV), Paschen → n = 3 (IR)."},
      {"id":"q3","question":"L''énergie du photon émis lors d''une transition est :","options":["hν = En + Ep","hν = En - Ep (avec En > Ep)","hν = En × Ep","hν = En / Ep"],"correct":1,"explanation":"Le photon emporte la différence d''énergie entre les niveaux : hν = En - Ep, où En est le niveau supérieur et Ep le niveau inférieur (En > Ep)."},
      {"id":"q4","question":"La constante de Rydberg R_H vaut environ :","options":["1,097×10⁷ m⁻¹","6,63×10⁻³⁴ J·s","9,11×10⁻³¹ kg","1,6×10⁻¹⁹ C"],"correct":0,"explanation":"R_H = 1,097×10⁷ m⁻¹ est la constante de Rydberg pour l''hydrogène. Elle intervient dans la formule : 1/λ = R_H(1/p² - 1/n²)."},
      {"id":"q5","question":"L''énergie d''ionisation de l''hydrogène vaut :","options":["1,51 eV","3,4 eV","13,6 eV","27,2 eV"],"correct":2,"explanation":"L''énergie d''ionisation est E_ion = |E₁| = 13,6 eV. C''est l''énergie nécessaire pour arracher l''électron du niveau fondamental (n = 1)."},
      {"id":"q6","question":"Les rayons X caractéristiques sont dus à :","options":["Des transitions nucléaires","Des transitions électroniques internes","La radioactivité","La fission nucléaire"],"correct":1,"explanation":"Les rayons X caractéristiques proviennent de transitions d''électrons des couches externes vers des couches internes vacantes d''un atome. Leur énergie est caractéristique de l''élément."},
      {"id":"q7","question":"La longueur d''onde minimale des rayons X continus est donnée par :","options":["λ_min = eU/hc","λ_min = hc/(eU)","λ_min = hU/ec","λ_min = ec/(hU)"],"correct":1,"explanation":"λ_min = hc/(eU) correspond au cas où toute l''énergie cinétique de l''électron (eU) est convertie en un seul photon X."},
      {"id":"q8","question":"L''émission stimulée (principe du laser) nécessite :","options":["Un photon incident d''énergie quelconque","Un photon incident d''énergie hν = En - Ep","Un champ magnétique intense","Une température très élevée"],"correct":1,"explanation":"L''émission stimulée se produit quand un photon d''énergie exactement égale à la différence entre deux niveaux provoque la désexcitation d''un atome excité, émettant un photon identique."},
      {"id":"q9","question":"Le spectre d''émission d''un gaz à basse pression est :","options":["Un spectre continu","Un spectre de raies","Un spectre d''absorption","Un spectre blanc"],"correct":1,"explanation":"Un gaz à basse pression excité émet un spectre de raies (raies brillantes sur fond noir), caractéristique de l''élément. C''est la base de l''analyse spectrale."},
      {"id":"q10","question":"La raie Hα de l''hydrogène (n=3 → n=2) a une longueur d''onde d''environ :","options":["121 nm","486 nm","656 nm","1875 nm"],"correct":2,"explanation":"La raie Hα (transition 3 → 2, série de Balmer) a λ ≈ 656 nm (rouge). C''est la raie la plus intense du spectre visible de l''hydrogène."}
    ]
  }');

  -- ============================================================
  -- PHYSIQUE - CHAPTER 10: Physique nucléaire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (physique_id, 'physique-nucleaire', 10, 'Physique nucléaire', 'Noyau, radioactivité α/β/γ, fission, fusion', 10)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'physique-nucleaire-fiche', 'Physique nucléaire', 'Structure du noyau, radioactivité, fission et fusion', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Décrire la structure du noyau atomique.","answer":"Le noyau est composé de nucléons : Z protons (charge +e) et N neutrons (charge nulle). Nombre de masse A = Z + N. Notation : ᴬ_Z X. Le noyau a un rayon r ≈ 1,2×10⁻¹⁵·A^(1/3) m. Les nucléons sont liés par l''interaction forte, attractive et de courte portée (≈ 10⁻¹⁵ m). La masse du noyau est inférieure à la somme des masses des nucléons séparés."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce que le défaut de masse et l''énergie de liaison ?","answer":"Le défaut de masse est Δm = Z·mp + N·mn - m_noyau > 0. L''énergie de liaison est E_l = Δm·c² (relation d''Einstein E = mc²). C''est l''énergie qu''il faut fournir pour séparer tous les nucléons. L''énergie de liaison par nucléon E_l/A permet de comparer la stabilité des noyaux. Le fer-56 a le maximum de E_l/A (noyau le plus stable)."},
      {"id":"fc3","category":"Formule","question":"Quelles sont les lois de conservation en physique nucléaire ?","answer":"Lors d''une réaction nucléaire : 1) Conservation du nombre de masse A (nombre de nucléons). 2) Conservation du numéro atomique Z (nombre de charges). 3) Conservation de l''énergie totale (masse + énergie cinétique). 4) Conservation de la quantité de mouvement. Le bilan énergétique utilise : Q = (Σm_réactifs - Σm_produits)·c²."},
      {"id":"fc4","category":"Distinction","question":"Quels sont les trois types de radioactivité ?","answer":"Radioactivité α : émission d''un noyau d''hélium ⁴₂He. ᴬ_ZX → ᴬ⁻⁴_(Z-2)Y + ⁴₂He. Radioactivité β⁻ : un neutron se transforme en proton + électron + antineutrino. ᴬ_ZX → ᴬ_(Z+1)Y + ⁰₋₁e + ν̄. Radioactivité β⁺ : un proton → neutron + positron + neutrino. Radioactivité γ : désexcitation du noyau par émission d''un photon γ (pas de changement de A ni Z)."},
      {"id":"fc5","category":"Formule","question":"Quelle est la loi de décroissance radioactive ?","answer":"N(t) = N₀·e^(-λt) où N₀ est le nombre initial de noyaux, λ la constante radioactive (s⁻¹). La demi-vie (période) T₁/₂ = ln(2)/λ ≈ 0,693/λ est le temps au bout duquel la moitié des noyaux se sont désintégrés. L''activité A(t) = λ·N(t) = A₀·e^(-λt) en becquerels (Bq). 1 Bq = 1 désintégration/s."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la fission nucléaire ?","answer":"La fission est la cassure d''un noyau lourd (U-235, Pu-239) en deux noyaux plus légers sous l''impact d''un neutron. Exemple : ²³⁵U + ¹n → ¹⁴⁴Ba + ⁸⁹Kr + 3¹n + énergie (≈ 200 MeV). Les neutrons produits peuvent provoquer d''autres fissions : réaction en chaîne. Applications : centrales nucléaires, bombe atomique."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la fusion nucléaire ?","answer":"La fusion est l''union de deux noyaux légers pour former un noyau plus lourd. Exemple : ²H + ³H → ⁴He + ¹n + 17,6 MeV. La fusion libère plus d''énergie par nucléon que la fission. Elle nécessite des températures très élevées (≈ 10⁸ K) pour vaincre la répulsion coulombienne. C''est la source d''énergie des étoiles (cycle proton-proton dans le Soleil)."},
      {"id":"fc8","category":"Formule","question":"Comment calculer l''énergie libérée lors d''une réaction nucléaire ?","answer":"Q = (Σm_réactifs - Σm_produits)·c². Si Q > 0 : réaction exoénergétique (fission, fusion). Si Q < 0 : réaction endoénergétique. En pratique : Q = Σ E_l(produits) - Σ E_l(réactifs). On utilise 1 u·c² = 931,5 MeV (unité de masse atomique u = 1,66054×10⁻²⁷ kg)."},
      {"id":"fc9","category":"Distinction","question":"Comparer fission et fusion nucléaire.","answer":"Fission : noyaux lourds → noyaux moyens. Déchet radioactifs, risque d''emballement. 200 MeV/fission. Technologie maîtrisée (centrales). Fusion : noyaux légers → noyaux moyens. Peu de déchets, combustible abondant (deutérium). 17,6 MeV/fusion mais plus d''énergie par nucléon. Pas encore maîtrisée pour la production d''électricité (projet ITER)."},
      {"id":"fc10","category":"Méthode","question":"Comment dater un échantillon par le carbone 14 ?","answer":"Le ¹⁴C (T₁/₂ = 5730 ans) est formé dans l''atmosphère et incorporé par les êtres vivants. À la mort, l''apport cesse et le ¹⁴C décroît. En mesurant l''activité A et en comparant à A₀ : t = -ln(A/A₀)/λ = T₁/₂·ln(A₀/A)/ln(2). Valable jusqu''à environ 50 000 ans (≈ 9 demi-vies)."},
      {"id":"fc11","category":"Formule","question":"Qu''est-ce que la relation d''Einstein E = mc² ?","answer":"L''énergie de masse est E = mc². Toute masse m possède une énergie E = mc² (c = 3×10⁸ m/s). Inversement, toute énergie a une masse équivalente m = E/c². En physique nucléaire, la perte de masse lors d''une réaction se convertit en énergie cinétique et rayonnement. 1 u·c² = 931,5 MeV."},
      {"id":"fc12","category":"Exemple","question":"Calculer l''énergie libérée par la fusion de deutérium et tritium.","answer":"²H + ³H → ⁴He + ¹n. Masses : m(²H) = 2,01410 u, m(³H) = 3,01605 u, m(⁴He) = 4,00260 u, m(n) = 1,00866 u. Δm = (2,01410 + 3,01605) - (4,00260 + 1,00866) = 0,01889 u. Q = 0,01889 × 931,5 = 17,6 MeV. Cette énergie est colossale comparée aux réactions chimiques (quelques eV)."}
    ],
    "schema": {
      "title": "Physique nucléaire",
      "nodes": [
        {"id":"n1","label":"Physique\nnucléaire","type":"main"},
        {"id":"n2","label":"Structure\ndu noyau","type":"branch"},
        {"id":"n3","label":"Radioactivité","type":"branch"},
        {"id":"n4","label":"Réactions\nnucléaires","type":"branch"},
        {"id":"n5","label":"Nucléons\nA = Z + N","type":"leaf"},
        {"id":"n6","label":"Énergie de liaison\nΔm·c²","type":"leaf"},
        {"id":"n7","label":"α, β, γ","type":"leaf"},
        {"id":"n8","label":"N = N₀e^(-λt)\nT₁/₂ = ln2/λ","type":"leaf"},
        {"id":"n9","label":"Fission\nFusion","type":"leaf"},
        {"id":"n10","label":"E = mc²","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"composition"},
        {"from":"n1","to":"n3","label":"instabilité"},
        {"from":"n1","to":"n4","label":"transformations"},
        {"from":"n2","to":"n5","label":"constituants"},
        {"from":"n2","to":"n6","label":"stabilité"},
        {"from":"n3","to":"n7","label":"types"},
        {"from":"n3","to":"n8","label":"décroissance"},
        {"from":"n4","to":"n9","label":"types"},
        {"from":"n4","to":"n10","label":"bilan énergie"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le nombre de masse A d''un noyau est :","options":["Le nombre de protons","Le nombre de neutrons","Le nombre de protons + neutrons","Le nombre d''électrons"],"correct":2,"explanation":"A = Z + N, c''est le nombre total de nucléons (protons Z + neutrons N) dans le noyau."},
      {"id":"q2","question":"La radioactivité α correspond à l''émission de :","options":["Un électron","Un photon","Un noyau d''hélium ⁴₂He","Un neutron"],"correct":2,"explanation":"La radioactivité α émet un noyau d''hélium ⁴₂He (2 protons + 2 neutrons). Le noyau père perd 4 nucléons et 2 charges."},
      {"id":"q3","question":"La demi-vie T₁/₂ est reliée à la constante radioactive λ par :","options":["T₁/₂ = λ/ln(2)","T₁/₂ = ln(2)/λ","T₁/₂ = 1/λ","T₁/₂ = 2/λ"],"correct":1,"explanation":"T₁/₂ = ln(2)/λ ≈ 0,693/λ. Après une demi-vie, il reste N₀/2 noyaux. Après n demi-vies : N = N₀/2ⁿ."},
      {"id":"q4","question":"La relation d''Einstein E = mc² signifie que :","options":["L''énergie est toujours cinétique","La masse peut se convertir en énergie","La vitesse de la lumière varie","L''énergie est conservée"],"correct":1,"explanation":"E = mc² établit l''équivalence masse-énergie. Une perte de masse Δm libère une énergie ΔE = Δm·c². C''est le principe des réactions nucléaires."},
      {"id":"q5","question":"La fission de l''uranium-235 libère environ :","options":["2 eV","20 eV","200 MeV","2000 MeV"],"correct":2,"explanation":"La fission d''un noyau d''U-235 libère environ 200 MeV, soit environ 10⁷ fois plus d''énergie qu''une réaction chimique (quelques eV)."},
      {"id":"q6","question":"La fusion nucléaire est la source d''énergie :","options":["Des centrales nucléaires","Des étoiles","Des batteries","Des panneaux solaires"],"correct":1,"explanation":"Les étoiles, dont le Soleil, tirent leur énergie de la fusion nucléaire (fusion de l''hydrogène en hélium). La température au cœur du Soleil est d''environ 15 millions de kelvins."},
      {"id":"q7","question":"L''activité d''un échantillon radioactif s''exprime en :","options":["Gray (Gy)","Sievert (Sv)","Becquerel (Bq)","Curie (Ci) uniquement"],"correct":2,"explanation":"L''activité A = λN se mesure en Becquerel (Bq) dans le SI. 1 Bq = 1 désintégration par seconde. L''ancienne unité est le Curie (1 Ci = 3,7×10¹⁰ Bq)."},
      {"id":"q8","question":"L''énergie de liaison par nucléon E_l/A est maximale pour :","options":["L''hydrogène","L''hélium","Le fer","L''uranium"],"correct":2,"explanation":"Le fer-56 a le maximum de E_l/A (≈ 8,8 MeV/nucléon). Les noyaux plus légers gagnent en stabilité par fusion, les plus lourds par fission, tous deux tendant vers le fer."},
      {"id":"q9","question":"Lors d''une radioactivité β⁻, il se produit :","options":["p → n + e⁺ + ν","n → p + e⁻ + ν̄","Émission d''un noyau ⁴He","Émission d''un photon γ"],"correct":1,"explanation":"En radioactivité β⁻, un neutron se transforme en proton + électron + antineutrino : n → p + e⁻ + ν̄. Z augmente de 1, A reste constant."},
      {"id":"q10","question":"1 u·c² vaut :","options":["1,6×10⁻¹⁹ J","931,5 MeV","13,6 eV","511 keV"],"correct":1,"explanation":"1 unité de masse atomique (u) × c² = 931,5 MeV. C''est le facteur de conversion masse → énergie en physique nucléaire. 1 u = 1,66054×10⁻²⁷ kg."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 1: Stéréochimie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'stereochimie', 1, 'Stéréochimie', 'Isomères, Z/E, énantiomérie', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'stereochimie-fiche', 'Stéréochimie', 'Isomérie, configuration Z/E et chiralité', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la stéréochimie ?","answer":"La stéréochimie est la branche de la chimie qui étudie l''arrangement spatial des atomes dans les molécules. Deux molécules peuvent avoir la même formule brute et la même connectivité mais différer par leur agencement dans l''espace. On distingue l''isomérie de constitution (même formule brute, enchaînements différents) et la stéréoisomérie (même connectivité, géométrie différente)."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les différents types d''isomérie ?","answer":"Isomérie de constitution : de chaîne (ramification), de position (position du groupe fonctionnel), de fonction (groupe fonctionnel différent). Stéréoisomérie : de conformation (rotation autour des liaisons simples), de configuration Z/E (autour d''une double liaison C=C), énantiomérie (molécules images l''une de l''autre dans un miroir, non superposables)."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que l''isomérie Z/E ?","answer":"L''isomérie Z/E concerne les alcènes (double liaison C=C) portant des substituants différents sur chaque carbone. La règle CIP (Cahn-Ingold-Prelog) attribue des priorités selon le numéro atomique. Z (zusammen = ensemble) : les substituants prioritaires sont du même côté. E (entgegen = opposé) : les substituants prioritaires sont de côtés opposés."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un carbone asymétrique et la chiralité ?","answer":"Un carbone asymétrique (C*) est un carbone tétraédrique lié à 4 substituants différents. Une molécule possédant un C* est chirale : elle n''est pas superposable à son image dans un miroir. Les deux formes sont des énantiomères. Ils ont les mêmes propriétés physico-chimiques sauf le pouvoir rotatoire (activité optique) et la réactivité avec d''autres molécules chirales."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que le pouvoir rotatoire et la polarimétrie ?","answer":"Les énantiomères dévient le plan de polarisation de la lumière polarisée d''un angle α. L''énantiomère dextrogyre (+) dévie à droite, le lévogyre (-) à gauche. Pouvoir rotatoire spécifique : [α] = α/(l·c) où l est la longueur de la cuve (dm), c la concentration (g/mL). Un mélange racémique (50/50) est optiquement inactif (α = 0)."},
      {"id":"fc6","category":"Distinction","question":"Quelle est la différence entre énantiomères et diastéréoisomères ?","answer":"Énantiomères : images l''un de l''autre dans un miroir, non superposables. Ils ont les mêmes propriétés physiques sauf le pouvoir rotatoire. Diastéréoisomères : stéréoisomères qui ne sont pas des énantiomères (ex : Z/E, ou molécules avec plusieurs C* ne différant pas à tous les C*). Ils ont des propriétés physiques différentes (Tf, Téb, solubilité)."},
      {"id":"fc7","category":"Méthode","question":"Comment déterminer la configuration R ou S d''un carbone asymétrique ?","answer":"1) Identifier les 4 substituants du C*. 2) Classer par priorité CIP (numéro atomique décroissant : a > b > c > d). 3) Orienter la molécule avec d (plus faible priorité) vers l''arrière. 4) Lire le sens de rotation a → b → c : sens horaire = R (rectus), sens antihoraire = S (sinister)."},
      {"id":"fc8","category":"Méthode","question":"Comment appliquer les règles de priorité CIP ?","answer":"1) Comparer les numéros atomiques des atomes directement liés au C*. Le plus élevé est prioritaire. 2) En cas d''égalité, explorer les atomes suivants (couche par couche). 3) Une liaison double C=O est traitée comme C lié à deux O. 4) Exemples de priorité : I > Br > Cl > S > O > N > C > H."},
      {"id":"fc9","category":"Exemple","question":"Donner un exemple de molécule chirale en chimie organique.","answer":"L''alanine (acide α-aminé) : CH₃-CH(NH₂)-COOH. Le carbone central est asymétrique car il porte 4 groupes différents : -CH₃, -NH₂, -COOH, -H. Il existe en deux énantiomères : L-alanine (naturelle, dans les protéines) et D-alanine. En biochimie, les acides aminés naturels sont tous de configuration L."},
      {"id":"fc10","category":"Définition","question":"Qu''est-ce que la conformation d''une molécule ?","answer":"Les conformations sont les différentes dispositions spatiales obtenues par rotation autour des liaisons simples C-C. Pour l''éthane : conformation éclipsée (H face à face, énergie max) et décalée (H en quinconce, énergie min). Pour le butane : conformation anti (la plus stable) et gauche. La rotation est libre à température ambiante."},
      {"id":"fc11","category":"Distinction","question":"Quelle est la différence entre configuration et conformation ?","answer":"Configuration : arrangement spatial fixé, ne peut être modifié que par rupture de liaisons. Exemples : R/S, Z/E. Les stéréoisomères de configuration sont des espèces chimiques distinctes. Conformation : arrangement spatial obtenu par rotation autour d''une liaison simple, sans rupture de liaison. Les conformères s''interconvertissent rapidement à température ambiante."},
      {"id":"fc12","category":"Formule","question":"Combien de stéréoisomères possède une molécule à n carbones asymétriques ?","answer":"Au maximum 2ⁿ stéréoisomères. Avec 1 C* : 2 stéréoisomères (une paire d''énantiomères). Avec 2 C* : 4 stéréoisomères (2 paires d''énantiomères, les paires entre elles sont diastéréoisomères). Attention : s''il y a des éléments de symétrie interne, le nombre peut être réduit (formes méso, optiquement inactives malgré la présence de C*)."}
    ],
    "schema": {
      "title": "Stéréochimie",
      "nodes": [
        {"id":"n1","label":"Stéréochimie","type":"main"},
        {"id":"n2","label":"Isomérie de\nconstitution","type":"branch"},
        {"id":"n3","label":"Stéréoisomérie","type":"branch"},
        {"id":"n4","label":"Chiralité","type":"branch"},
        {"id":"n5","label":"Chaîne\nPosition\nFonction","type":"leaf"},
        {"id":"n6","label":"Z/E\n(double liaison)","type":"leaf"},
        {"id":"n7","label":"Conformation\n(liaison simple)","type":"leaf"},
        {"id":"n8","label":"C* asymétrique\nR/S","type":"leaf"},
        {"id":"n9","label":"Énantiomères\nPouvoir rotatoire","type":"leaf"},
        {"id":"n10","label":"Diastéréoisomères","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"formule brute"},
        {"from":"n1","to":"n3","label":"espace"},
        {"from":"n1","to":"n4","label":"miroir"},
        {"from":"n2","to":"n5","label":"types"},
        {"from":"n3","to":"n6","label":"configuration"},
        {"from":"n3","to":"n7","label":"rotation"},
        {"from":"n4","to":"n8","label":"centre chiral"},
        {"from":"n4","to":"n9","label":"paire"},
        {"from":"n4","to":"n10","label":"non-énantiomères"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un carbone asymétrique est lié à :","options":["2 substituants différents","3 substituants différents","4 substituants identiques","4 substituants différents"],"correct":3,"explanation":"Un carbone asymétrique (C*) porte 4 substituants tous différents, ce qui lui confère la chiralité."},
      {"id":"q2","question":"L''isomérie Z/E concerne :","options":["Les liaisons simples C-C","Les doubles liaisons C=C","Les triples liaisons","Les cycles"],"correct":1,"explanation":"L''isomérie Z/E concerne les alcènes (C=C) dont chaque carbone de la double liaison porte deux substituants différents. La rotation est bloquée."},
      {"id":"q3","question":"Deux énantiomères ont :","options":["Des propriétés physiques différentes","Le même pouvoir rotatoire","Des pouvoirs rotatoires opposés","Des formules brutes différentes"],"correct":2,"explanation":"Les énantiomères ont les mêmes propriétés physiques (Tf, Téb, solubilité) mais des pouvoirs rotatoires opposés en valeur absolue : l''un est (+), l''autre (-)."},
      {"id":"q4","question":"Un mélange racémique est :","options":["Un mélange équimolaire de deux énantiomères","Un mélange de diastéréoisomères","Un composé méso","Un mélange d''isomères Z et E"],"correct":0,"explanation":"Un mélange racémique contient 50% de chaque énantiomère. Il est optiquement inactif (les pouvoirs rotatoires se compensent)."},
      {"id":"q5","question":"La règle CIP classe les substituants par :","options":["Masse molaire décroissante","Numéro atomique croissant","Numéro atomique décroissant","Nombre d''hydrogènes"],"correct":2,"explanation":"Les règles CIP (Cahn-Ingold-Prelog) classent les substituants par numéro atomique décroissant : I > Br > Cl > O > N > C > H."},
      {"id":"q6","question":"Configuration R signifie que le sens de rotation a→b→c est :","options":["Antihoraire","Horaire","Quelconque","Nul"],"correct":1,"explanation":"R (rectus = droit) : le sens de rotation des substituants a→b→c (par priorité décroissante) est horaire, quand d est orienté vers l''arrière."},
      {"id":"q7","question":"Avec 2 carbones asymétriques, le nombre maximal de stéréoisomères est :","options":["2","4","8","16"],"correct":1,"explanation":"Avec n C*, le nombre maximal de stéréoisomères est 2ⁿ. Pour n = 2 : 2² = 4 stéréoisomères (2 paires d''énantiomères)."},
      {"id":"q8","question":"La conformation la plus stable de l''éthane est :","options":["Éclipsée","Décalée","Gauche","Anti"],"correct":1,"explanation":"La conformation décalée (staggered) est la plus stable car les atomes d''hydrogène sont le plus éloignés possible, minimisant les interactions répulsives."},
      {"id":"q9","question":"Les diastéréoisomères ont :","options":["Les mêmes propriétés physiques","Des propriétés physiques différentes","Le même pouvoir rotatoire","La même réactivité"],"correct":1,"explanation":"Contrairement aux énantiomères, les diastéréoisomères ont des propriétés physiques différentes (point de fusion, solubilité, etc.) et peuvent être séparés par des méthodes classiques."},
      {"id":"q10","question":"Les acides aminés naturels des protéines sont de configuration :","options":["D","L","R","Racémique"],"correct":1,"explanation":"Les acides aminés naturels des protéines sont tous de configuration L. C''est une homochiralité fondamentale du vivant. La glycine est le seul acide aminé non chiral (pas de C*)."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 2: Les alcools
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'alcools', 2, 'Les alcools', 'Classes, oxydation, déshydratation, estérification', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'alcools-fiche', 'Les alcools', 'Classification, réactions d''oxydation et de déshydratation', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un alcool et comment le classe-t-on ?","answer":"Un alcool est un composé organique possédant le groupe hydroxyle -OH fixé sur un carbone tétraédrique (sp3). Formule générale : R-OH. Classification : alcool primaire (C portant OH lié à 1 seul C), secondaire (lié à 2 C), tertiaire (lié à 3 C). Exemples : éthanol (primaire), propan-2-ol (secondaire), 2-méthylpropan-2-ol (tertiaire)."},
      {"id":"fc2","category":"Formule","question":"Quels sont les produits d''oxydation des alcools ?","answer":"Alcool primaire → aldéhyde (oxydation ménagée) → acide carboxylique (oxydation poussée). Alcool secondaire → cétone (oxydation ménagée). Alcool tertiaire → pas d''oxydation (pas de H sur le C portant OH). Oxydants ménagés : K₂Cr₂O₇/H₂SO₄ ou KMnO₄ dilué. Test : le réactif de Tollens ou la liqueur de Fehling distinguent aldéhydes et cétones."},
      {"id":"fc3","category":"Formule","question":"Qu''est-ce que la déshydratation d''un alcool ?","answer":"La déshydratation est l''élimination d''une molécule d''eau. Déshydratation intramoléculaire (T > 170°C, H₂SO₄) : formation d''un alcène. Règle de Zaïtsev : l''alcène le plus substitué (le plus stable) est majoritaire. Déshydratation intermoléculaire (T ≈ 140°C) : formation d''un éther-oxyde. Exemple : 2 C₂H₅OH → C₂H₅-O-C₂H₅ + H₂O."},
      {"id":"fc4","category":"Formule","question":"Qu''est-ce que l''estérification ?","answer":"L''estérification est la réaction entre un alcool et un acide carboxylique pour former un ester et de l''eau : R-COOH + R''-OH ⇌ R-COO-R'' + H₂O. La réaction est lente, limitée (équilibre) et athermique. Catalyseur : H₂SO₄ concentré ou H⁺. La réaction inverse est l''hydrolyse de l''ester."},
      {"id":"fc5","category":"Distinction","question":"Comment distinguer un alcool primaire, secondaire et tertiaire ?","answer":"Test de Lucas (ZnCl₂/HCl) : tertiaire → trouble immédiat, secondaire → trouble après quelques minutes, primaire → pas de trouble à froid. Oxydation : primaire → aldéhyde puis acide, secondaire → cétone, tertiaire → résistant. Test de Jones (CrO₃/H₂SO₄) : primaire et secondaire positifs (virage orange → vert), tertiaire négatif."},
      {"id":"fc6","category":"Méthode","question":"Comment nommer un alcool en nomenclature IUPAC ?","answer":"1) Trouver la chaîne carbonée la plus longue contenant le groupe OH. 2) Numéroter en donnant le plus petit indice au C portant OH. 3) Nom = préfixe de la chaîne + suffixe -ol. 4) Indiquer la position du OH. Exemples : butan-1-ol (primaire), butan-2-ol (secondaire), 2-méthylpropan-2-ol (tertiaire)."},
      {"id":"fc7","category":"Formule","question":"Quelles sont les propriétés physiques des alcools ?","answer":"Les alcools ont des températures d''ébullition élevées (liaisons hydrogène O-H···O). Le méthanol et l''éthanol sont miscibles à l''eau. La solubilité diminue quand la chaîne carbonée s''allonge. Les alcools sont des solvants polaires protiques. La liaison O-H est polaire (δ+ sur H, δ- sur O)."},
      {"id":"fc8","category":"Exemple","question":"Écrire la réaction d''oxydation ménagée de l''éthanol.","answer":"CH₃CH₂OH + [O] → CH₃CHO + H₂O (oxydation ménagée : alcool primaire → aldéhyde, éthanal). Avec excès d''oxydant : CH₃CHO + [O] → CH₃COOH (éthanal → acide éthanoïque). L''éthanol peut aussi être oxydé biologiquement par l''enzyme alcool déshydrogénase dans le foie."},
      {"id":"fc9","category":"Définition","question":"Qu''est-ce qu''un polyol ?","answer":"Un polyol est un alcool possédant plusieurs groupes -OH. Exemples : éthylène glycol (éthane-1,2-diol) HOCH₂CH₂OH (antigel), glycérol (propane-1,2,3-triol) HOCH₂CH(OH)CH₂OH (cosmétiques, explosifs). Le glycérol est un constituant des triglycérides (graisses). Les polyols sont très solubles dans l''eau grâce à de multiples liaisons hydrogène."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre un alcool et un phénol ?","answer":"Un alcool a le groupe OH fixé sur un carbone sp3 (tétraédrique). Un phénol a le groupe OH fixé directement sur un cycle benzénique (carbone sp2). Le phénol est plus acide que les alcools (pKa ≈ 10 vs 16-18) car l''ion phénolate est stabilisé par résonance avec le cycle aromatique."},
      {"id":"fc11","category":"Méthode","question":"Comment identifier un aldéhyde avec le test du miroir d''argent ?","answer":"Test de Tollens : on ajoute le réactif de Tollens [Ag(NH₃)₂]⁺ à la solution. Un aldéhyde réduit Ag⁺ en Ag métallique → dépôt de miroir d''argent sur les parois. Les cétones ne donnent pas ce test. Test de Fehling : l''aldéhyde réduit Cu²⁺ (bleu) en Cu₂O (précipité rouge brique). Permet de distinguer aldéhydes et cétones."},
      {"id":"fc12","category":"Formule","question":"Écrire la réaction de déshydratation du butan-2-ol.","answer":"CH₃CH(OH)CH₂CH₃ → CH₃CH=CHCH₃ + H₂O (but-2-ène, produit majoritaire par règle de Zaïtsev) ou CH₃CH=CH₂CH₃ → CH₂=CHCH₂CH₃ (but-1-ène, produit minoritaire). Conditions : H₂SO₄ concentré, T > 170°C. Le but-2-ène est le plus substitué (2 substituants sur chaque C de la double liaison), donc le plus stable."}
    ],
    "schema": {
      "title": "Les alcools",
      "nodes": [
        {"id":"n1","label":"Alcools\nR-OH","type":"main"},
        {"id":"n2","label":"Classification","type":"branch"},
        {"id":"n3","label":"Réactions","type":"branch"},
        {"id":"n4","label":"Propriétés","type":"branch"},
        {"id":"n5","label":"Primaire\nSecondaire\nTertiaire","type":"leaf"},
        {"id":"n6","label":"Oxydation\n→ aldéhyde/cétone","type":"leaf"},
        {"id":"n7","label":"Déshydratation\n→ alcène","type":"leaf"},
        {"id":"n8","label":"Estérification\n→ ester + H₂O","type":"leaf"},
        {"id":"n9","label":"Liaisons H\nSolubilité","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"classes"},
        {"from":"n1","to":"n3","label":"chimie"},
        {"from":"n1","to":"n4","label":"physiques"},
        {"from":"n2","to":"n5","label":"I, II, III"},
        {"from":"n3","to":"n6","label":"K₂Cr₂O₇"},
        {"from":"n3","to":"n7","label":"H₂SO₄, Δ"},
        {"from":"n3","to":"n8","label":"RCOOH"},
        {"from":"n4","to":"n9","label":"O-H"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un alcool secondaire donne par oxydation ménagée :","options":["Un aldéhyde","Une cétone","Un acide carboxylique","Pas de réaction"],"correct":1,"explanation":"L''oxydation ménagée d''un alcool secondaire donne une cétone. La cétone n''est pas oxydable davantage en conditions ménagées."},
      {"id":"q2","question":"La déshydratation intramoléculaire d''un alcool donne :","options":["Un ester","Un éther-oxyde","Un alcène","Un aldéhyde"],"correct":2,"explanation":"La déshydratation intramoléculaire (T > 170°C, H₂SO₄) élimine H₂O de la même molécule pour former un alcène."},
      {"id":"q3","question":"L''estérification est une réaction :","options":["Rapide et totale","Lente et limitée","Rapide et limitée","Lente et totale"],"correct":1,"explanation":"L''estérification est une réaction lente (nécessite un catalyseur acide), limitée (équilibre) et athermique. On peut déplacer l''équilibre en éliminant l''eau."},
      {"id":"q4","question":"Un alcool tertiaire face à l''oxydation ménagée :","options":["Donne un aldéhyde","Donne une cétone","Donne un acide","Ne réagit pas"],"correct":3,"explanation":"Un alcool tertiaire ne possède pas de H sur le C portant OH, il résiste à l''oxydation ménagée."},
      {"id":"q5","question":"Le test de Tollens est positif pour :","options":["Les cétones","Les aldéhydes","Les alcools","Les acides"],"correct":1,"explanation":"Le test de Tollens (miroir d''argent) est positif uniquement pour les aldéhydes, qui réduisent Ag⁺ en Ag métallique."},
      {"id":"q6","question":"La règle de Zaïtsev prédit la formation préférentielle de :","options":["L''alcène le moins substitué","L''alcène le plus substitué","L''alcool le plus stable","L''éther-oxyde"],"correct":1,"explanation":"Lors de la déshydratation, l''alcène le plus substitué (le plus stable) se forme préférentiellement (produit majoritaire)."},
      {"id":"q7","question":"La liaison hydrogène dans les alcools explique :","options":["Leur faible point d''ébullition","Leur point d''ébullition élevé","Leur insolubilité dans l''eau","Leur couleur"],"correct":1,"explanation":"Les liaisons hydrogène O-H···O entre molécules d''alcool augmentent les forces intermoléculaires, ce qui élève le point d''ébullition par rapport aux alcanes de masse similaire."},
      {"id":"q8","question":"Le glycérol est un :","options":["Monoalcool","Diol","Triol","Phénol"],"correct":2,"explanation":"Le glycérol (propane-1,2,3-triol) possède 3 fonctions -OH. C''est un triol utilisé en cosmétique et composant des triglycérides."},
      {"id":"q9","question":"La nomenclature IUPAC d''un alcool utilise le suffixe :","options":["-al","-one","-ol","-oïque"],"correct":2,"explanation":"Les alcools sont nommés avec le suffixe -ol (méthanol, éthanol, propan-1-ol, etc.). -al pour les aldéhydes, -one pour les cétones, -oïque pour les acides carboxyliques."},
      {"id":"q10","question":"L''éthanol est un alcool :","options":["Primaire","Secondaire","Tertiaire","Phénolique"],"correct":0,"explanation":"L''éthanol CH₃CH₂OH est un alcool primaire : le carbone portant le groupe -OH n''est lié qu''à un seul autre carbone."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 3: Les amines
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'amines', 3, 'Les amines', 'Classes, nomenclature, obtention', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'amines-fiche', 'Les amines', 'Classification, nomenclature et propriétés des amines', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une amine et comment la classe-t-on ?","answer":"Une amine est un dérivé de l''ammoniac NH₃ dans lequel un ou plusieurs H sont remplacés par des groupes carbonés. Amine primaire R-NH₂ (1 substituant), secondaire R₂NH (2 substituants), tertiaire R₃N (3 substituants). Le classement dépend du nombre de groupes carbonés sur N, pas du type de carbone comme pour les alcools."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les propriétés basiques des amines ?","answer":"Les amines sont des bases de Lewis (doublet libre sur N). Amine + H₂O ⇌ ammonium + OH⁻ : RNH₂ + H₂O ⇌ RNH₃⁺ + OH⁻. Le pKb des amines aliphatiques est ≈ 3-4 (bases plus fortes que NH₃). Les amines aromatiques (aniline) sont des bases plus faibles (pKb ≈ 9) car le doublet de N est délocalisé dans le cycle aromatique."},
      {"id":"fc3","category":"Méthode","question":"Comment nommer une amine en nomenclature IUPAC ?","answer":"Amine primaire : nom de la chaîne + amine (ou suffixe -amine). Exemples : méthanamine (CH₃NH₂), éthanamine (C₂H₅NH₂), propan-1-amine. Amine secondaire/tertiaire : on utilise le préfixe N- pour les substituants sur l''azote. Exemple : N-méthyléthanamine (CH₃NHCH₂CH₃), N,N-diméthyléthanamine."},
      {"id":"fc4","category":"Distinction","question":"Quelles sont les méthodes d''obtention des amines ?","answer":"1) Alkylation de l''ammoniac : NH₃ + R-X → R-NH₂ + HX (faible sélectivité). 2) Réduction des nitriles : R-CN + 2H₂ → R-CH₂-NH₂ (avec LiAlH₄ ou H₂/catalyseur). 3) Réduction des nitroarènes : Ar-NO₂ + 3H₂ → Ar-NH₂ + 2H₂O (réaction de Zinine). 4) Synthèse de Gabriel (plus sélective pour les amines primaires)."},
      {"id":"fc5","category":"Formule","question":"Quelles sont les propriétés physiques des amines ?","answer":"Les amines primaires et secondaires forment des liaisons hydrogène N-H···N (plus faibles que O-H···O). Les amines de faible masse moléculaire sont solubles dans l''eau. Les amines ont une odeur caractéristique (souvent désagréable, poisson). Le point d''ébullition : amine < alcool de même masse (liaisons H plus faibles avec N)."},
      {"id":"fc6","category":"Formule","question":"Comment les amines réagissent-elles avec les acides ?","answer":"Les amines, étant basiques, réagissent avec les acides pour former des sels d''ammonium : RNH₂ + HCl → RNH₃⁺Cl⁻ (chlorhydrate). Ces sels sont solides, solubles dans l''eau, inodores. C''est la forme sous laquelle de nombreux médicaments sont administrés. Réaction inverse par ajout de NaOH : RNH₃⁺ + OH⁻ → RNH₂ + H₂O."},
      {"id":"fc7","category":"Distinction","question":"Comparer les amines aliphatiques et aromatiques.","answer":"Amines aliphatiques (ex : éthylamine C₂H₅NH₂) : bases relativement fortes (pKb ≈ 3-4), le doublet de N est disponible. Amines aromatiques (ex : aniline C₆H₅NH₂) : bases faibles (pKb ≈ 9), le doublet de N est délocalisé dans le cycle aromatique par mésomérie, donc moins disponible pour capter H⁺."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce qu''un amide ?","answer":"Un amide est un composé possédant le groupe -CO-NH₂ (ou -CO-NHR, -CO-NR₂). C''est le produit de la réaction entre un acide carboxylique (ou un dérivé) et une amine : RCOOH + R''NH₂ → RCONHR'' + H₂O. La liaison amide (peptidique) est fondamentale en biochimie : elle relie les acides aminés dans les protéines."},
      {"id":"fc9","category":"Exemple","question":"Donner des exemples d''amines importantes.","answer":"Amines biologiques : adrénaline, dopamine, sérotonine, histamine (neurotransmetteurs). Amines industrielles : aniline (colorants, médicaments), triéthylamine (catalyseur). Acides aminés : tous possèdent un groupe -NH₂. Les amines biogènes (cadavérine, putrescine) sont responsables de l''odeur de décomposition."},
      {"id":"fc10","category":"Méthode","question":"Comment identifier une amine par un test chimique ?","answer":"1) Test au tournesol : les amines en solution aqueuse virent le tournesol au bleu (milieu basique). 2) Réaction avec HCl : formation d''un sel blanc (fumée blanche si amine volatile). 3) Test à l''acide nitreux (HNO₂) : amine primaire → dégagement de N₂ (diazotation), amine secondaire → nitrosamine, amine tertiaire → pas de réaction caractéristique."},
      {"id":"fc11","category":"Formule","question":"Qu''est-ce que la diazotation des amines aromatiques ?","answer":"La diazotation est la réaction d''une amine aromatique primaire avec l''acide nitreux à basse température (0-5°C) : Ar-NH₂ + HNO₂ + HCl → Ar-N₂⁺Cl⁻ + 2H₂O. Le sel de diazonium obtenu est très réactif. Il peut réagir avec des phénols ou des amines aromatiques pour donner des colorants azoïques (-N=N-)."},
      {"id":"fc12","category":"Distinction","question":"Quelle est la différence entre une amine et un amide ?","answer":"Amine : R-NH₂, base (doublet libre sur N disponible), point d''ébullition modéré. Amide : R-CO-NH₂, neutre ou très faiblement basique (doublet de N délocalisé vers C=O par mésomérie), point d''ébullition élevé (liaisons H fortes). La liaison peptidique dans les protéines est une liaison amide."}
    ],
    "schema": {
      "title": "Les amines",
      "nodes": [
        {"id":"n1","label":"Amines\nR-NH₂","type":"main"},
        {"id":"n2","label":"Classification","type":"branch"},
        {"id":"n3","label":"Propriétés","type":"branch"},
        {"id":"n4","label":"Réactions","type":"branch"},
        {"id":"n5","label":"Primaire\nSecondaire\nTertiaire","type":"leaf"},
        {"id":"n6","label":"Basicité\npKb","type":"leaf"},
        {"id":"n7","label":"Sels d''ammonium\nRNH₃⁺","type":"leaf"},
        {"id":"n8","label":"Diazotation\nColorants azo","type":"leaf"},
        {"id":"n9","label":"Liaison amide\npeptidique","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"substituants sur N"},
        {"from":"n1","to":"n3","label":"base de Lewis"},
        {"from":"n1","to":"n4","label":"chimie"},
        {"from":"n2","to":"n5","label":"classes"},
        {"from":"n3","to":"n6","label":"force"},
        {"from":"n4","to":"n7","label":"+ acide"},
        {"from":"n4","to":"n8","label":"ArNH₂ + HNO₂"},
        {"from":"n4","to":"n9","label":"+ acide carboxylique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Une amine primaire possède :","options":["Un substituant sur l''azote","Deux substituants sur l''azote","Trois substituants sur l''azote","Un carbone primaire"],"correct":0,"explanation":"Une amine primaire a un seul groupe carboné sur l''azote (R-NH₂). Le classement dépend du nombre de substituants sur N, pas du type de carbone."},
      {"id":"q2","question":"Les amines sont des :","options":["Acides de Lewis","Bases de Lewis","Acides de Brønsted","Composés neutres"],"correct":1,"explanation":"Les amines possèdent un doublet libre sur l''azote, ce qui en fait des bases de Lewis capables de capter un proton H⁺."},
      {"id":"q3","question":"L''aniline (C₆H₅NH₂) est une base plus faible que l''éthylamine car :","options":["Elle a plus de carbones","Le doublet de N est délocalisé dans le cycle","Elle est plus lourde","Elle est insoluble"],"correct":1,"explanation":"Dans l''aniline, le doublet libre de l''azote est délocalisé par mésomérie dans le cycle aromatique, le rendant moins disponible pour capter un proton."},
      {"id":"q4","question":"La liaison peptidique est une liaison :","options":["Ester","Éther","Amide","Amine"],"correct":2,"explanation":"La liaison peptidique est une liaison amide -CO-NH- qui relie deux acides aminés dans les protéines. Elle résulte de la réaction entre -COOH et -NH₂."},
      {"id":"q5","question":"La diazotation nécessite :","options":["Une température élevée","Une température de 0-5°C","Un milieu basique","L''absence d''acide"],"correct":1,"explanation":"La diazotation doit se faire à basse température (0-5°C) car les sels de diazonium sont très instables et se décomposent à température plus élevée."},
      {"id":"q6","question":"La réaction RNH₂ + HCl donne :","options":["Un ester","Un sel d''ammonium RNH₃⁺Cl⁻","Un amide","Un alcool"],"correct":1,"explanation":"Une amine réagit avec un acide pour donner un sel d''ammonium : RNH₂ + HCl → RNH₃⁺Cl⁻ (chlorhydrate d''amine)."},
      {"id":"q7","question":"Le point d''ébullition des amines est inférieur à celui des alcools de même masse car :","options":["Les amines sont plus légères","Les liaisons H avec N sont plus faibles qu''avec O","Les amines sont gazeuses","Les amines ne forment pas de liaisons H"],"correct":1,"explanation":"Les liaisons hydrogène N-H···N sont plus faibles que les liaisons O-H···O car N est moins électronégatif que O. Les amines ont donc des points d''ébullition plus bas que les alcools correspondants."},
      {"id":"q8","question":"La réduction d''un nitrile R-CN donne :","options":["Un alcool R-CH₂OH","Une amine R-CH₂NH₂","Un aldéhyde R-CHO","Un acide R-COOH"],"correct":1,"explanation":"La réduction d''un nitrile par LiAlH₄ ou H₂/catalyseur donne une amine primaire : R-CN + 2H₂ → R-CH₂-NH₂."},
      {"id":"q9","question":"Les colorants azoïques contiennent le groupe :","options":["-N=N-","-NH-NH-","-NO₂","-N=O"],"correct":0,"explanation":"Les colorants azoïques contiennent le groupe azo -N=N- qui résulte du couplage d''un sel de diazonium avec un composé aromatique activé."},
      {"id":"q10","question":"La formule de la méthylamine est :","options":["CH₃OH","CH₃NH₂","CH₃COOH","CH₃CHO"],"correct":1,"explanation":"La méthylamine CH₃NH₂ est l''amine primaire la plus simple. C''est un gaz à température ambiante, d''odeur désagréable."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 4: Acides carboxyliques et fonctions dérivées
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'acides-carboxyliques', 4, 'Acides carboxyliques et fonctions dérivées', 'Chlorures d''acyle, anhydrides, esters', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'acides-carboxyliques-fiche', 'Acides carboxyliques et fonctions dérivées', 'Acides, chlorures d''acyle, anhydrides et esters', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un acide carboxylique ?","answer":"Un acide carboxylique est un composé organique possédant le groupe carboxyle -COOH. Formule générale : R-COOH. En solution aqueuse : R-COOH ⇌ R-COO⁻ + H⁺. Ce sont des acides faibles. Nomenclature : chaîne + suffixe -oïque (acide méthanoïque HCOOH, acide éthanoïque CH₃COOH, acide propanoïque CH₃CH₂COOH)."},
      {"id":"fc2","category":"Formule","question":"Quels sont les dérivés d''acides carboxyliques ?","answer":"Les dérivés résultent du remplacement du -OH du groupe -COOH. Chlorure d''acyle R-COCl (remplacement par Cl). Anhydride d''acide (RCO)₂O (condensation de 2 acides). Ester R-COOR'' (remplacement par -OR''). Amide R-CONH₂ (remplacement par -NH₂). Réactivité décroissante : chlorure d''acyle > anhydride > ester > amide."},
      {"id":"fc3","category":"Formule","question":"Comment obtient-on un chlorure d''acyle ?","answer":"R-COOH + SOCl₂ → R-COCl + SO₂ + HCl (avec le chlorure de thionyle). Ou : R-COOH + PCl₅ → R-COCl + POCl₃ + HCl. Les chlorures d''acyle sont très réactifs : ils réagissent violemment avec l''eau (hydrolyse), les alcools (ester), les amines (amide). Cette forte réactivité les rend utiles en synthèse organique."},
      {"id":"fc4","category":"Formule","question":"Qu''est-ce qu''un anhydride d''acide et ses réactions ?","answer":"Un anhydride résulte de la condensation de deux molécules d''acide : 2 R-COOH → (RCO)₂O + H₂O (nécessite un déshydratant). L''anhydride réagit avec : l''eau → 2 acides (hydrolyse), un alcool → ester + acide (plus rapide que l''estérification directe), une amine → amide + acide. Exemple : anhydride éthanoïque (CH₃CO)₂O."},
      {"id":"fc5","category":"Distinction","question":"Comparer estérification directe et acylation.","answer":"Estérification directe (acide + alcool) : lente, limitée (équilibre), rendement ≈ 67% pour un alcool primaire. Acylation (chlorure d''acyle + alcool ou anhydride + alcool) : rapide, totale (irréversible), rendement élevé. L''acylation est préférée en synthèse car elle est plus efficace et ne nécessite pas de déplacer un équilibre."},
      {"id":"fc6","category":"Formule","question":"Écrire les réactions de l''anhydride éthanoïque avec un alcool et une amine.","answer":"Avec un alcool : (CH₃CO)₂O + R-OH → CH₃COOR + CH₃COOH. Avec une amine : (CH₃CO)₂O + R-NH₂ → CH₃CONHR + CH₃COOH. Ces réactions sont rapides et totales. L''anhydride éthanoïque est utilisé pour synthétiser l''aspirine (acide acétylsalicylique) à partir de l''acide salicylique."},
      {"id":"fc7","category":"Méthode","question":"Comment nommer un ester en nomenclature IUPAC ?","answer":"Un ester R-COO-R'' se nomme : alcanoate d''alkyle. La partie acide (R-CO-) donne le préfixe -anoate. La partie alcool (-O-R'') donne le suffixe d''alkyle. Exemples : méthanoate d''éthyle (HCOOC₂H₅), éthanoate de méthyle (CH₃COOCH₃), éthanoate d''éthyle (CH₃COOC₂H₅)."},
      {"id":"fc8","category":"Exemple","question":"Donner des exemples d''esters importants.","answer":"Éthanoate d''éthyle : solvant, vernis. Éthanoate d''isoamyle : arôme de banane. Butanoate d''éthyle : arôme d''ananas. Acide acétylsalicylique (aspirine) : ester de l''acide salicylique. Les graisses et huiles sont des triesters du glycérol (triglycérides). Le PET (polyéthylène téréphtalate) est un polyester."},
      {"id":"fc9","category":"Formule","question":"Qu''est-ce que la saponification ?","answer":"La saponification est l''hydrolyse basique d''un ester : R-COOR'' + NaOH → R-COO⁻Na⁺ + R''-OH. Contrairement à l''hydrolyse acide (réversible), la saponification est totale et irréversible (l''ion carboxylate R-COO⁻ ne réagit plus). Application : fabrication du savon à partir de triglycérides et de soude."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre hydrolyse acide et saponification d''un ester ?","answer":"Hydrolyse acide : R-COOR'' + H₂O ⇌ R-COOH + R''-OH. Réaction réversible (équilibre), catalysée par H⁺. Saponification : R-COOR'' + OH⁻ → R-COO⁻ + R''-OH. Réaction totale et irréversible car l''ion carboxylate est très stable. La saponification est plus efficace pour cliver un ester."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que l''aspirine et comment est-elle synthétisée ?","answer":"L''aspirine (acide acétylsalicylique) est un ester obtenu par acétylation de l''acide salicylique avec l''anhydride éthanoïque : acide salicylique + (CH₃CO)₂O → aspirine + CH₃COOH. C''est un anti-inflammatoire, analgésique et antipyrétique. Purification par recristallisation. Contrôle de pureté par chromatographie et point de fusion (135°C)."},
      {"id":"fc12","category":"Formule","question":"Quelle est la réactivité relative des dérivés d''acides ?","answer":"Réactivité décroissante : R-COCl > (RCO)₂O > R-COOR'' > R-CONH₂. Le chlore (très électronégatif) rend le carbone du C=O très électrophile dans R-COCl. L''amide est le moins réactif car le doublet de N est conjugué avec C=O. Cette échelle détermine le choix du réactif en synthèse."}
    ],
    "schema": {
      "title": "Acides carboxyliques et dérivés",
      "nodes": [
        {"id":"n1","label":"Acides carboxyliques\nR-COOH","type":"main"},
        {"id":"n2","label":"Dérivés d''acides","type":"branch"},
        {"id":"n3","label":"Réactions","type":"branch"},
        {"id":"n4","label":"Chlorure d''acyle\nR-COCl","type":"leaf"},
        {"id":"n5","label":"Anhydride\n(RCO)₂O","type":"leaf"},
        {"id":"n6","label":"Ester\nR-COOR''","type":"leaf"},
        {"id":"n7","label":"Estérification\néquilibre","type":"leaf"},
        {"id":"n8","label":"Saponification\ntotale","type":"leaf"},
        {"id":"n9","label":"Acylation\nrapide, totale","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"substitution OH"},
        {"from":"n1","to":"n3","label":"chimie"},
        {"from":"n2","to":"n4","label":"+ SOCl₂"},
        {"from":"n2","to":"n5","label":"condensation"},
        {"from":"n2","to":"n6","label":"+ alcool"},
        {"from":"n3","to":"n7","label":"acide + alcool"},
        {"from":"n3","to":"n8","label":"ester + OH⁻"},
        {"from":"n3","to":"n9","label":"RCOCl + alcool"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le dérivé d''acide le plus réactif est :","options":["L''ester","L''amide","Le chlorure d''acyle","L''anhydride"],"correct":2,"explanation":"Le chlorure d''acyle R-COCl est le plus réactif car le chlore, très électronégatif, rend le carbone du carbonyle très électrophile, facilitant l''attaque nucléophile."},
      {"id":"q2","question":"La saponification d''un ester est :","options":["Réversible et lente","Irréversible et totale","Réversible et rapide","Impossible"],"correct":1,"explanation":"La saponification (hydrolyse basique) est totale et irréversible car l''ion carboxylate formé est très stable et ne réagit pas avec l''alcool."},
      {"id":"q3","question":"L''aspirine est obtenue par réaction de l''acide salicylique avec :","options":["L''éthanol","L''anhydride éthanoïque","L''acide chlorhydrique","L''hydroxyde de sodium"],"correct":1,"explanation":"L''aspirine est un ester obtenu par acétylation de l''acide salicylique avec l''anhydride éthanoïque (CH₃CO)₂O."},
      {"id":"q4","question":"Un ester se nomme :","options":["Alkyle d''alcanoate","Alcanoate d''alkyle","Acide alcanamide","Alkanoyle d''alkyle"],"correct":1,"explanation":"Un ester R-COO-R'' se nomme alcanoate d''alkyle : la partie acide donne -anoate, la partie alcool donne d''alkyle."},
      {"id":"q5","question":"Le chlorure d''acyle est obtenu par réaction de l''acide avec :","options":["NaOH","HCl","SOCl₂","H₂SO₄"],"correct":2,"explanation":"R-COOH + SOCl₂ → R-COCl + SO₂ + HCl. Le chlorure de thionyle SOCl₂ est le réactif le plus utilisé pour préparer les chlorures d''acyle."},
      {"id":"q6","question":"L''acylation est préférée à l''estérification directe car elle est :","options":["Plus lente mais moins coûteuse","Rapide et totale","Réversible","Plus sélective"],"correct":1,"explanation":"L''acylation (chlorure d''acyle ou anhydride + alcool) est rapide et totale, contrairement à l''estérification directe qui est lente et limitée (équilibre)."},
      {"id":"q7","question":"Le savon est obtenu par :","options":["Estérification","Saponification de triglycérides","Oxydation d''alcools","Réduction d''acides"],"correct":1,"explanation":"Le savon (sel de sodium d''acide gras) est obtenu par saponification de triglycérides (graisses) avec NaOH : triglycéride + 3NaOH → glycérol + 3 savons."},
      {"id":"q8","question":"L''anhydride éthanoïque réagit avec un alcool pour donner :","options":["Un acide + un alcool","Un ester + un acide","Deux esters","Un éther + de l''eau"],"correct":1,"explanation":"(CH₃CO)₂O + R-OH → CH₃COOR + CH₃COOH. L''anhydride donne un ester et régénère un acide carboxylique."},
      {"id":"q9","question":"L''hydrolyse acide d''un ester est :","options":["Totale","Irréversible","Réversible (équilibre)","Impossible"],"correct":2,"explanation":"L''hydrolyse acide d''un ester est la réaction inverse de l''estérification : R-COOR'' + H₂O ⇌ R-COOH + R''OH. C''est un équilibre."},
      {"id":"q10","question":"L''acide éthanoïque a pour formule :","options":["HCOOH","CH₃COOH","C₂H₅COOH","CH₃CHO"],"correct":1,"explanation":"L''acide éthanoïque (acide acétique) est CH₃COOH. C''est le principal constituant du vinaigre (≈ 5%)."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 5: Acides α-aminés, glucose et polymères
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'acides-amines-polymeres', 5, 'Acides α-aminés, glucose et polymères', 'Acides aminés, glucose, polymérisation', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'acides-amines-polymeres-fiche', 'Acides α-aminés, glucose et polymères', 'Biomolécules et réactions de polymérisation', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un acide α-aminé ?","answer":"Un acide α-aminé possède sur le même carbone (Cα) un groupe amine -NH₂ et un groupe carboxyle -COOH. Formule générale : H₂N-CHR-COOH où R est la chaîne latérale. Il existe 20 acides aminés naturels. Le Cα est asymétrique si R ≠ H (tous sauf la glycine). En solution, ils existent sous forme de zwitterion : ⁺H₃N-CHR-COO⁻."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce que la liaison peptidique ?","answer":"La liaison peptidique est une liaison amide -CO-NH- formée par condensation entre le -COOH d''un acide aminé et le -NH₂ d''un autre : H₂N-CHR-COOH + H₂N-CHR''-COOH → H₂N-CHR-CO-NH-CHR''-COOH + H₂O. Un dipeptide a une liaison peptidique, un polypeptide en a plusieurs. Les protéines sont des polypeptides de plus de 50 acides aminés."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que le glucose ?","answer":"Le glucose C₆H₁₂O₆ est un aldohexose (aldéhyde + 6 carbones + sucre). En solution, il existe sous formes cycliques (α-glucose et β-glucose) en équilibre avec la forme ouverte. C''est le principal carburant des cellules. Il peut être détecté par le test de Fehling (sucre réducteur) car il possède une fonction aldéhyde."},
      {"id":"fc4","category":"Distinction","question":"Quelle est la différence entre polymérisation par addition et polycondensation ?","answer":"Addition : des monomères insaturés (alcènes) s''enchaînent sans perte de petites molécules. Exemple : n CH₂=CH₂ → (-CH₂-CH₂-)n (polyéthylène). Polycondensation : des monomères bifonctionnels réagissent avec perte d''eau ou HCl. Exemple : diacide + diol → polyester + nH₂O. Les protéines et le nylon sont des produits de polycondensation."},
      {"id":"fc5","category":"Exemple","question":"Donner des exemples de polymères courants.","answer":"Polyaddition : polyéthylène PE (emballages), polypropylène PP, polychlorure de vinyle PVC (tuyaux), polystyrène PS (isolation), PTFE (téflon). Polycondensation : nylon 6,6 (polyamide, textiles), PET (polyester, bouteilles), bakélite (phénoplaste). Biopolymères : protéines (polyamides), amidon et cellulose (polyosides), ADN."},
      {"id":"fc6","category":"Formule","question":"Comment se forme l''amidon et la cellulose à partir du glucose ?","answer":"L''amidon et la cellulose sont des polyosides (polysaccharides) formés par polycondensation du glucose avec élimination d''eau. Amidon : polymère de α-glucose (liaison α-1,4 et α-1,6), réserve énergétique des plantes. Cellulose : polymère de β-glucose (liaison β-1,4), composant structural des parois végétales. Les enzymes humaines digèrent l''amidon mais pas la cellulose."},
      {"id":"fc7","category":"Méthode","question":"Comment identifier un acide aminé par électrophorèse ?","answer":"L''électrophorèse sépare les acides aminés selon leur charge à un pH donné. Au point isoélectrique (pI), le zwitterion est globalement neutre et ne migre pas. Si pH < pI : forme cationique (+), migre vers la cathode (-). Si pH > pI : forme anionique (-), migre vers l''anode (+). Chaque acide aminé a un pI caractéristique."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que le point isoélectrique (pI) ?","answer":"Le point isoélectrique est le pH auquel l''acide aminé existe sous forme de zwitterion neutre ⁺H₃N-CHR-COO⁻ (charge nette nulle). Pour un acide aminé simple : pI = (pKa₁ + pKa₂)/2 où pKa₁ (COOH) ≈ 2 et pKa₂ (NH₃⁺) ≈ 9-10. Au pI, la solubilité est minimale et la molécule ne migre pas en électrophorèse."},
      {"id":"fc9","category":"Formule","question":"Écrire la réaction de polymérisation du chlorure de vinyle.","answer":"n CH₂=CHCl → (-CH₂-CHCl-)n. C''est une polyaddition : la double liaison C=C s''ouvre et les monomères s''enchaînent. Le PVC (polychlorure de vinyle) est un thermoplastique utilisé pour les tuyaux, revêtements, fenêtres. Le catalyseur est un initiateur radicalaire ou un catalyseur Ziegler-Natta."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre thermoplastique et thermodurcissable ?","answer":"Thermoplastique : peut être ramolli par chauffage et remoulé (chaînes linéaires ou ramifiées). Exemples : PE, PVC, PS, PET. Recyclable. Thermodurcissable : durcit irréversiblement par chauffage (réseau tridimensionnel réticulé). Exemples : bakélite, résines époxy. Non recyclable par fusion. Les élastomères (caoutchouc) sont une catégorie intermédiaire."},
      {"id":"fc11","category":"Formule","question":"Comment se forme le nylon 6,6 ?","answer":"Le nylon 6,6 est un polyamide obtenu par polycondensation de l''hexanediamine H₂N-(CH₂)₆-NH₂ et de l''acide adipique HOOC-(CH₂)₄-COOH : n H₂N-(CH₂)₆-NH₂ + n HOOC-(CH₂)₄-COOH → [-NH-(CH₂)₆-NH-CO-(CH₂)₄-CO-]n + 2n H₂O. Utilisé pour les textiles, les cordes, les engrenages."},
      {"id":"fc12","category":"Définition","question":"Qu''est-ce qu''un sucre réducteur ?","answer":"Un sucre réducteur possède une fonction aldéhyde (ou cétone) libre capable de réduire les ions métalliques. Le glucose est réducteur : il réduit Cu²⁺ (bleu) en Cu₂O (rouge brique, test de Fehling) et Ag⁺ en Ag (miroir d''argent, test de Tollens). Le saccharose n''est pas réducteur car ses deux fonctions réductrices sont engagées dans la liaison osidique."}
    ],
    "schema": {
      "title": "Biomolécules et polymères",
      "nodes": [
        {"id":"n1","label":"Biomolécules\net polymères","type":"main"},
        {"id":"n2","label":"Acides aminés","type":"branch"},
        {"id":"n3","label":"Glucides","type":"branch"},
        {"id":"n4","label":"Polymères","type":"branch"},
        {"id":"n5","label":"Zwitterion\nLiaison peptidique","type":"leaf"},
        {"id":"n6","label":"Glucose\nAmidon\nCellulose","type":"leaf"},
        {"id":"n7","label":"Polyaddition\nPE, PVC, PS","type":"leaf"},
        {"id":"n8","label":"Polycondensation\nNylon, PET","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"protéines"},
        {"from":"n1","to":"n3","label":"sucres"},
        {"from":"n1","to":"n4","label":"macromolécules"},
        {"from":"n2","to":"n5","label":"propriétés"},
        {"from":"n3","to":"n6","label":"types"},
        {"from":"n4","to":"n7","label":"addition"},
        {"from":"n4","to":"n8","label":"condensation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un acide α-aminé possède sur le carbone α :","options":["Un -NH₂ et un -CHO","Un -NH₂ et un -COOH","Un -OH et un -COOH","Un -NH₂ et un -OH"],"correct":1,"explanation":"Un acide α-aminé possède un groupe amine -NH₂ et un groupe carboxyle -COOH portés par le même carbone (Cα)."},
      {"id":"q2","question":"La liaison peptidique est une liaison :","options":["Ester","Éther","Amide","Ionique"],"correct":2,"explanation":"La liaison peptidique -CO-NH- est une liaison amide formée par condensation entre -COOH d''un acide aminé et -NH₂ d''un autre, avec perte d''H₂O."},
      {"id":"q3","question":"Le glucose est détecté par le test de Fehling car c''est un :","options":["Sucre non réducteur","Sucre réducteur","Acide aminé","Polymère"],"correct":1,"explanation":"Le glucose possède une fonction aldéhyde libre qui réduit Cu²⁺ en Cu₂O (précipité rouge brique). C''est un sucre réducteur."},
      {"id":"q4","question":"Le polyéthylène est obtenu par :","options":["Polycondensation","Polyaddition","Saponification","Estérification"],"correct":1,"explanation":"n CH₂=CH₂ → (-CH₂-CH₂-)n. C''est une polyaddition : la double liaison C=C s''ouvre sans perte de petites molécules."},
      {"id":"q5","question":"Le nylon 6,6 est un :","options":["Polyester","Polyamide","Polyéthylène","Polysaccharide"],"correct":1,"explanation":"Le nylon 6,6 est un polyamide obtenu par polycondensation d''une diamine et d''un diacide, formant des liaisons amide -CO-NH-."},
      {"id":"q6","question":"Au point isoélectrique, l''acide aminé est sous forme de :","options":["Cation","Anion","Zwitterion neutre","Molécule non chargée"],"correct":2,"explanation":"Au pI, l''acide aminé existe sous forme de zwitterion ⁺H₃N-CHR-COO⁻ avec une charge nette nulle. Il ne migre pas en électrophorèse."},
      {"id":"q7","question":"La cellulose est un polymère de :","options":["α-glucose","β-glucose","Fructose","Saccharose"],"correct":1,"explanation":"La cellulose est un polymère de β-glucose lié en β-1,4. Les enzymes humaines ne peuvent pas hydrolyser ces liaisons β (contrairement aux liaisons α de l''amidon)."},
      {"id":"q8","question":"Un thermoplastique peut être :","options":["Ramolli et remoulé par chauffage","Durci irréversiblement","Réticulé en 3D","Transformé en caoutchouc"],"correct":0,"explanation":"Un thermoplastique (PE, PVC, PS) peut être ramolli par chauffage et remoulé plusieurs fois. Ses chaînes sont linéaires ou ramifiées, sans réticulation."},
      {"id":"q9","question":"La polycondensation produit, en plus du polymère :","options":["De l''énergie","De petites molécules (H₂O, HCl)","Des radicaux libres","Des monomères"],"correct":1,"explanation":"Lors de la polycondensation, chaque liaison formée libère une petite molécule (H₂O pour les polyesters et polyamides, HCl pour certains polymères)."},
      {"id":"q10","question":"Les protéines sont des :","options":["Polyesters","Polyamides naturels","Polysaccharides","Polyoléfines"],"correct":1,"explanation":"Les protéines sont des polyamides naturels formés par enchaînement d''acides aminés par des liaisons peptidiques (amide) -CO-NH-."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 6: Cinétique chimique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'cinetique-chimique', 6, 'Cinétique chimique', 'Facteurs, ordre, catalyse, mécanisme', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'cinetique-chimique-fiche', 'Cinétique chimique', 'Vitesse de réaction, ordre et catalyse', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la cinétique chimique ?","answer":"La cinétique chimique étudie la vitesse des réactions et les facteurs qui l''influencent. La vitesse de réaction v est la variation de la concentration d''un réactif ou produit par unité de temps : v = -d[A]/dt = (1/a)d[P]/dt (a : coefficient stœchiométrique). L''unité est mol·L⁻¹·s⁻¹."},
      {"id":"fc2","category":"Formule","question":"Quels facteurs influencent la vitesse d''une réaction ?","answer":"1) Concentration des réactifs : v augmente avec la concentration (plus de collisions). 2) Température : v double environ tous les 10°C (loi d''Arrhenius). 3) Catalyseur : accélère la réaction sans être consommé. 4) Surface de contact : pour les hétérogènes, plus la surface est grande, plus v est élevée. 5) Nature des réactifs et du solvant."},
      {"id":"fc3","category":"Formule","question":"Qu''est-ce que l''ordre d''une réaction ?","answer":"Pour une réaction aA + bB → produits, la loi de vitesse est v = k·[A]^α·[B]^β. α est l''ordre partiel par rapport à A, β par rapport à B. L''ordre global est n = α + β. k est la constante de vitesse. L''ordre n''est pas forcément égal aux coefficients stœchiométriques (il est déterminé expérimentalement)."},
      {"id":"fc4","category":"Formule","question":"Quelles sont les lois de vitesse pour les ordres 0, 1 et 2 ?","answer":"Ordre 0 : v = k, [A] = [A]₀ - kt, t₁/₂ = [A]₀/(2k). Ordre 1 : v = k[A], [A] = [A]₀·e^(-kt), t₁/₂ = ln(2)/k (indépendant de [A]₀). Ordre 2 : v = k[A]², 1/[A] = 1/[A]₀ + kt, t₁/₂ = 1/(k[A]₀). La demi-vie t₁/₂ est le temps pour que [A] diminue de moitié."},
      {"id":"fc5","category":"Formule","question":"Énoncer la loi d''Arrhenius.","answer":"k = A·e^(-Ea/(RT)) où k est la constante de vitesse, A le facteur de fréquence (ou facteur pré-exponentiel), Ea l''énergie d''activation (J/mol), R = 8,314 J·mol⁻¹·K⁻¹ et T la température (K). ln(k) = ln(A) - Ea/(RT). Le tracé de ln(k) = f(1/T) est une droite de pente -Ea/R."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce qu''un catalyseur ?","answer":"Un catalyseur accélère une réaction chimique sans être consommé et sans modifier l''équilibre thermodynamique. Il abaisse l''énergie d''activation Ea en fournissant un chemin réactionnel alternatif. Catalyse homogène : le catalyseur est dans la même phase (ex : H⁺ en solution). Catalyse hétérogène : phases différentes (ex : platine solide pour les gaz). Catalyse enzymatique : enzymes biologiques."},
      {"id":"fc7","category":"Méthode","question":"Comment déterminer l''ordre d''une réaction expérimentalement ?","answer":"Méthode des temps de demi-réaction : si t₁/₂ est indépendant de [A]₀ → ordre 1. Si t₁/₂ ∝ [A]₀ → ordre 0. Si t₁/₂ ∝ 1/[A]₀ → ordre 2. Méthode graphique : tracer [A] vs t (droite si ordre 0), ln[A] vs t (droite si ordre 1), 1/[A] vs t (droite si ordre 2). Méthode de l''excès : isoler l''influence de chaque réactif."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce qu''un mécanisme réactionnel ?","answer":"Un mécanisme réactionnel décrit les étapes élémentaires successives par lesquelles les réactifs se transforment en produits. Chaque étape élémentaire a un ordre égal à sa molécularité (1 = unimoléculaire, 2 = bimoléculaire). L''étape la plus lente est l''étape cinétiquement déterminante (elle fixe la vitesse globale). Les intermédiaires réactionnels sont formés puis consommés."},
      {"id":"fc9","category":"Distinction","question":"Quelle est la différence entre catalyse homogène et hétérogène ?","answer":"Catalyse homogène : catalyseur et réactifs dans la même phase (ex : ions H⁺ en solution aqueuse pour l''estérification). Avantage : contact intime. Inconvénient : séparation difficile. Catalyse hétérogène : catalyseur dans une phase différente (ex : Pt, Pd, Ni solides pour l''hydrogénation des gaz). Avantage : séparation facile. Inconvénient : surface de contact limitée."},
      {"id":"fc10","category":"Exemple","question":"Donner des exemples de catalyse enzymatique.","answer":"Les enzymes sont des catalyseurs biologiques (protéines). Exemples : amylase (hydrolyse de l''amidon), lipase (hydrolyse des lipides), protéase (hydrolyse des protéines), catalase (décomposition de H₂O₂). Caractéristiques : très spécifiques (modèle clé-serrure), très efficaces, conditions douces (37°C, pH neutre), inhibition possible."},
      {"id":"fc11","category":"Formule","question":"Qu''est-ce que l''énergie d''activation ?","answer":"L''énergie d''activation Ea est l''énergie minimale que doivent posséder les réactifs pour que la réaction ait lieu. Elle correspond à la barrière énergétique entre réactifs et produits. Plus Ea est élevée, plus la réaction est lente. Un catalyseur abaisse Ea en proposant un chemin réactionnel alternatif avec une barrière plus basse."},
      {"id":"fc12","category":"Méthode","question":"Comment déterminer Ea à partir de données expérimentales ?","answer":"1) Mesurer la constante de vitesse k à différentes températures T. 2) Tracer ln(k) = f(1/T) (droite d''Arrhenius). 3) La pente de la droite est -Ea/R. 4) Ea = -pente × R. Autre méthode : pour deux températures T₁ et T₂ : ln(k₂/k₁) = (Ea/R)·(1/T₁ - 1/T₂)."}
    ],
    "schema": {
      "title": "Cinétique chimique",
      "nodes": [
        {"id":"n1","label":"Cinétique\nchimique","type":"main"},
        {"id":"n2","label":"Vitesse","type":"branch"},
        {"id":"n3","label":"Ordre","type":"branch"},
        {"id":"n4","label":"Catalyse","type":"branch"},
        {"id":"n5","label":"v = k[A]^n\nFacteurs","type":"leaf"},
        {"id":"n6","label":"Arrhenius\nk = Ae^(-Ea/RT)","type":"leaf"},
        {"id":"n7","label":"Ordre 0, 1, 2\nt₁/₂","type":"leaf"},
        {"id":"n8","label":"Mécanisme\nétape lente","type":"leaf"},
        {"id":"n9","label":"Homogène\nHétérogène\nEnzymatique","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mesure"},
        {"from":"n1","to":"n3","label":"loi de vitesse"},
        {"from":"n1","to":"n4","label":"accélération"},
        {"from":"n2","to":"n5","label":"expression"},
        {"from":"n2","to":"n6","label":"température"},
        {"from":"n3","to":"n7","label":"intégration"},
        {"from":"n3","to":"n8","label":"étapes"},
        {"from":"n4","to":"n9","label":"types"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La vitesse de réaction augmente quand :","options":["La température diminue","La concentration diminue","La température augmente","On ajoute un produit"],"correct":2,"explanation":"La vitesse augmente avec la température (loi d''Arrhenius : k augmente exponentiellement avec T) et avec la concentration des réactifs."},
      {"id":"q2","question":"Pour une réaction d''ordre 1, le temps de demi-réaction t₁/₂ est :","options":["Proportionnel à [A]₀","Indépendant de [A]₀","Inversement proportionnel à [A]₀","Égal à k"],"correct":1,"explanation":"Pour l''ordre 1 : t₁/₂ = ln(2)/k. Le temps de demi-réaction ne dépend pas de la concentration initiale, seulement de la constante de vitesse k."},
      {"id":"q3","question":"Un catalyseur modifie :","options":["L''énergie d''activation","La constante d''équilibre","L''enthalpie de réaction","Le bilan de la réaction"],"correct":0,"explanation":"Un catalyseur abaisse l''énergie d''activation Ea sans modifier la thermodynamique de la réaction (ni ΔH, ni K). Il accélère l''atteinte de l''équilibre."},
      {"id":"q4","question":"La loi d''Arrhenius s''écrit :","options":["k = A + Ea/RT","k = A·e^(Ea/RT)","k = A·e^(-Ea/RT)","k = Ea/(A·RT)"],"correct":2,"explanation":"k = A·e^(-Ea/RT). La constante de vitesse k augmente exponentiellement quand T augmente, car le facteur exponentiel e^(-Ea/RT) croît."},
      {"id":"q5","question":"Pour une réaction d''ordre 2, la représentation linéaire est :","options":["[A] vs t","ln[A] vs t","1/[A] vs t","[A]² vs t"],"correct":2,"explanation":"Pour l''ordre 2 : 1/[A] = 1/[A]₀ + kt. Le tracé de 1/[A] en fonction de t est une droite de pente k et d''ordonnée à l''origine 1/[A]₀."},
      {"id":"q6","question":"L''étape cinétiquement déterminante d''un mécanisme est :","options":["La plus rapide","La plus lente","La première","La dernière"],"correct":1,"explanation":"L''étape cinétiquement déterminante est l''étape la plus lente du mécanisme. C''est elle qui fixe la vitesse globale de la réaction."},
      {"id":"q7","question":"La catalyse enzymatique se caractérise par :","options":["Une faible spécificité","Une grande spécificité","Des températures très élevées","L''absence de catalyseur"],"correct":1,"explanation":"Les enzymes sont très spécifiques : chaque enzyme ne catalyse qu''une réaction donnée (modèle clé-serrure). Elles fonctionnent dans des conditions douces (37°C, pH neutre)."},
      {"id":"q8","question":"L''énergie d''activation représente :","options":["L''énergie libérée par la réaction","La barrière énergétique à franchir","L''énergie cinétique des produits","La chaleur de réaction"],"correct":1,"explanation":"L''énergie d''activation Ea est la barrière énergétique minimale que les réactifs doivent franchir pour se transformer en produits. Elle correspond à l''état de transition."},
      {"id":"q9","question":"Pour déterminer Ea, on trace :","options":["v vs T","k vs T","ln(k) vs 1/T","[A] vs t"],"correct":2,"explanation":"Le tracé d''Arrhenius ln(k) = f(1/T) est une droite de pente -Ea/R. On en déduit Ea = -pente × R."},
      {"id":"q10","question":"La molécularité d''une étape élémentaire est :","options":["L''ordre global de la réaction","Le nombre de molécules qui interviennent","La vitesse de l''étape","Le nombre de produits"],"correct":1,"explanation":"La molécularité est le nombre de molécules (ou espèces) qui participent à une étape élémentaire. Pour une étape élémentaire, l''ordre est égal à la molécularité."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 7: Estérification, hydrolyse et équilibres
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'esterification-equilibres', 7, 'Estérification, hydrolyse et équilibres', 'Le Chatelier, loi d''action de masse', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'esterification-equilibres-fiche', 'Estérification, hydrolyse et équilibres', 'Équilibres chimiques et déplacement', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un équilibre chimique ?","answer":"Un équilibre chimique est atteint quand les vitesses des réactions directe et inverse sont égales. Les concentrations restent constantes (mais la réaction n''est pas arrêtée : c''est un équilibre dynamique). La constante d''équilibre K = [produits]^p/[réactifs]^r ne dépend que de la température. Si K >> 1 : réaction quasi-totale. Si K << 1 : réaction très limitée."},
      {"id":"fc2","category":"Formule","question":"Exprimer la constante d''équilibre de l''estérification.","answer":"Acide + Alcool ⇌ Ester + Eau. K = [Ester][H₂O]/([Acide][Alcool]). Pour un alcool primaire : K ≈ 4 (rendement ≈ 67%). Pour un alcool secondaire : K ≈ 2,3 (rendement ≈ 60%). Pour un alcool tertiaire : K ≈ 0,25 (rendement ≈ 33%). K ne dépend que de T, pas du catalyseur."},
      {"id":"fc3","category":"Formule","question":"Énoncer le principe de Le Chatelier.","answer":"Quand on modifie un facteur d''équilibre (concentration, pression, température), le système évolue dans le sens qui tend à s''opposer à la modification. Exemples : ajouter un réactif → déplacement vers les produits. Retirer un produit → déplacement vers les produits. Augmenter T pour une réaction exothermique → déplacement vers les réactifs."},
      {"id":"fc4","category":"Méthode","question":"Comment déplacer l''équilibre d''estérification vers la formation de l''ester ?","answer":"1) Utiliser un excès d''un réactif (acide ou alcool). 2) Éliminer un produit au fur et à mesure (distiller l''eau avec un appareil de Dean-Stark, ou l''ester s''il est volatil). 3) Utiliser un déshydratant (tamis moléculaire). 4) Remplacer l''acide par un chlorure d''acyle ou un anhydride (réaction totale, pas d''équilibre)."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que le quotient réactionnel Qr ?","answer":"Le quotient réactionnel Qr a la même expression que K mais calculé à un instant quelconque (pas forcément à l''équilibre). Si Qr < K : la réaction évolue dans le sens direct (formation de produits). Si Qr > K : la réaction évolue dans le sens inverse. Si Qr = K : le système est à l''équilibre."},
      {"id":"fc6","category":"Distinction","question":"Quelle est l''influence de la température sur l''équilibre ?","answer":"La constante K dépend de T : K = K₀·e^(-ΔH/RT). Pour une réaction exothermique (ΔH < 0) : K diminue quand T augmente (déplacement vers les réactifs). Pour une réaction endothermique (ΔH > 0) : K augmente quand T augmente (déplacement vers les produits). Un catalyseur ne modifie pas K."},
      {"id":"fc7","category":"Méthode","question":"Comment calculer le rendement d''une réaction à l''équilibre ?","answer":"1) Écrire le tableau d''avancement avec les quantités initiales. 2) Exprimer les quantités à l''équilibre en fonction de x (avancement). 3) Écrire K en fonction de x et des quantités initiales. 4) Résoudre l''équation pour trouver x. 5) Rendement η = x/x_max × 100%. Pour l''estérification avec quantités équimolaires : η = 1/(1 + 1/√K)."},
      {"id":"fc8","category":"Exemple","question":"Calculer le rendement de l''estérification pour K = 4 avec des quantités équimolaires.","answer":"Acide + Alcool ⇌ Ester + H₂O. Si n₀ moles de chaque réactif : K = x²/(n₀-x)² = 4. Donc x/(n₀-x) = 2, x = 2n₀/3. Rendement = x/n₀ = 2/3 ≈ 67%. Avec 1 mol d''acide et 1 mol d''alcool, on obtient 0,67 mol d''ester à l''équilibre."},
      {"id":"fc9","category":"Distinction","question":"Comparer les effets d''un catalyseur et d''un excès de réactif.","answer":"Catalyseur : accélère l''atteinte de l''équilibre mais ne modifie pas la composition finale (K inchangé). Le rendement est le même, mais atteint plus rapidement. Excès de réactif : modifie la composition à l''équilibre en déplaçant l''équilibre vers les produits (augmente le rendement par rapport au réactif en défaut). K reste constant."},
      {"id":"fc10","category":"Formule","question":"Écrire la loi d''action de masse.","answer":"Pour la réaction aA + bB ⇌ cC + dD, la loi d''action de masse (ou loi de Guldberg et Waage) donne : K = [C]^c·[D]^d / ([A]^a·[B]^b). Les concentrations sont celles à l''équilibre. K est la constante d''équilibre (ou constante thermodynamique). Elle ne dépend que de la température."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce qu''un taux d''avancement final ?","answer":"Le taux d''avancement final τ = x_f/x_max mesure l''avancement de la réaction par rapport à l''avancement maximal théorique. Si τ = 1 (100%) : réaction totale. Si τ < 1 : réaction limitée (équilibre). Pour l''estérification avec quantités équimolaires et K = 4 : τ = 2/3 ≈ 67%. Le taux d''avancement dépend des conditions initiales et de K."},
      {"id":"fc12","category":"Méthode","question":"Comment vérifier expérimentalement qu''un équilibre est atteint ?","answer":"1) Suivre une propriété physique au cours du temps (absorbance, conductivité, pression, pH). 2) L''équilibre est atteint quand la propriété ne varie plus. 3) On peut aussi doser un réactif ou un produit à différents instants. 4) Vérifier que le même état final est atteint en partant des réactifs ou des produits (caractère dynamique)."}
    ],
    "schema": {
      "title": "Équilibres chimiques",
      "nodes": [
        {"id":"n1","label":"Équilibres\nchimiques","type":"main"},
        {"id":"n2","label":"Loi d''action\nde masse","type":"branch"},
        {"id":"n3","label":"Déplacement","type":"branch"},
        {"id":"n4","label":"Estérification","type":"branch"},
        {"id":"n5","label":"K = [P]^p/[R]^r\nQr vs K","type":"leaf"},
        {"id":"n6","label":"Le Chatelier\nconcentration, T, P","type":"leaf"},
        {"id":"n7","label":"K ≈ 4 (primaire)\nRendement ≈ 67%","type":"leaf"},
        {"id":"n8","label":"Excès réactif\nÉliminer produit","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"constante K"},
        {"from":"n1","to":"n3","label":"perturbation"},
        {"from":"n1","to":"n4","label":"application"},
        {"from":"n2","to":"n5","label":"expression"},
        {"from":"n3","to":"n6","label":"principe"},
        {"from":"n4","to":"n7","label":"rendement"},
        {"from":"n4","to":"n8","label":"optimisation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La constante d''équilibre K dépend de :","options":["La concentration","La pression","La température uniquement","Le catalyseur"],"correct":2,"explanation":"K ne dépend que de la température. Ni les concentrations, ni la pression, ni le catalyseur ne modifient K. Ils peuvent déplacer l''équilibre (Qr ≠ K) mais K reste constant à T constante."},
      {"id":"q2","question":"Si Qr < K, la réaction évolue :","options":["Dans le sens inverse","Dans le sens direct","L''équilibre est atteint","La réaction s''arrête"],"correct":1,"explanation":"Si Qr < K, il n''y a pas assez de produits par rapport à l''équilibre. La réaction évolue dans le sens direct (formation de produits) jusqu''à Qr = K."},
      {"id":"q3","question":"Le rendement de l''estérification avec quantités équimolaires et K = 4 est :","options":["50%","67%","75%","100%"],"correct":1,"explanation":"K = x²/(n₀-x)² = 4, donc x/(n₀-x) = 2, x = 2n₀/3. Rendement = 2/3 ≈ 67%."},
      {"id":"q4","question":"Pour déplacer l''équilibre vers la formation du produit, on peut :","options":["Ajouter un produit","Retirer un réactif","Ajouter un excès de réactif","Diminuer la température toujours"],"correct":2,"explanation":"Ajouter un excès de réactif déplace l''équilibre vers les produits (Le Chatelier). Ajouter un produit ou retirer un réactif déplacerait vers les réactifs."},
      {"id":"q5","question":"Un catalyseur modifie :","options":["La constante K","Le rendement à l''équilibre","La vitesse d''atteinte de l''équilibre","Le sens de la réaction"],"correct":2,"explanation":"Un catalyseur accélère l''atteinte de l''équilibre (accélère les deux sens) mais ne modifie pas K ni le rendement final."},
      {"id":"q6","question":"Pour une réaction exothermique, augmenter T :","options":["Déplace l''équilibre vers les produits","Déplace l''équilibre vers les réactifs","N''a aucun effet","Augmente K"],"correct":1,"explanation":"Pour une réaction exothermique (ΔH < 0), augmenter T déplace l''équilibre dans le sens endothermique, c''est-à-dire vers les réactifs. K diminue."},
      {"id":"q7","question":"La loi d''action de masse a été formulée par :","options":["Le Chatelier","Arrhenius","Guldberg et Waage","Lavoisier"],"correct":2,"explanation":"La loi d''action de masse (K = [produits]/[réactifs] à l''équilibre) a été formulée par les Norvégiens Guldberg et Waage en 1864."},
      {"id":"q8","question":"Un taux d''avancement final de 100% signifie que la réaction est :","options":["Limitée","Totale","Impossible","À l''équilibre"],"correct":1,"explanation":"τ = 100% signifie que la réaction est totale : tous les réactifs (ou le réactif limitant) ont été consommés. C''est le cas des réactions avec K très grand."},
      {"id":"q9","question":"L''estérification est catalysée par :","options":["NaOH","H₂SO₄ concentré","KMnO₄","Le platine"],"correct":1,"explanation":"L''estérification est catalysée par les acides forts comme H₂SO₄ concentré. Les ions H⁺ accélèrent la réaction sans modifier l''équilibre."},
      {"id":"q10","question":"L''hydrolyse d''un ester est la réaction :","options":["Directe de l''estérification","Inverse de l''estérification","De l''ester avec NaOH","De l''ester avec HCl"],"correct":1,"explanation":"L''hydrolyse est la réaction inverse de l''estérification : Ester + H₂O ⇌ Acide + Alcool. Elle est aussi lente et limitée. La saponification (NaOH) est une hydrolyse basique totale."}
    ]
  }');

  -- ============================================================
  -- CHIMIE - CHAPTER 8: Acides et bases
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (chimie_id, 'acides-bases', 8, 'Acides et bases', 'pH, couples, indicateurs, dosage', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'acides-bases-fiche', 'Acides et bases', 'pH, couples acide/base, dosages', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un acide et une base selon Brønsted ?","answer":"Selon Brønsted-Lowry, un acide est un donneur de protons H⁺ (AH → A⁻ + H⁺) et une base est un accepteur de protons (B + H⁺ → BH⁺). Un couple acide/base est noté AH/A⁻. L''eau est amphotère : elle peut être acide (H₂O → OH⁻ + H⁺) ou base (H₂O + H⁺ → H₃O⁺). Le produit ionique de l''eau : Ke = [H₃O⁺][OH⁻] = 10⁻¹⁴ à 25°C."},
      {"id":"fc2","category":"Formule","question":"Comment calculer le pH d''une solution ?","answer":"pH = -log[H₃O⁺]. Pour un acide fort de concentration Ca : pH = -log(Ca). Pour une base forte de concentration Cb : pH = 14 + log(Cb). Pour un acide faible : pH ≈ ½(pKa - log(Ca)). Pour une base faible : pH ≈ ½(14 + pKa + log(Cb)). Solution tampon : pH = pKa + log([A⁻]/[AH]) (Henderson-Hasselbalch)."},
      {"id":"fc3","category":"Distinction","question":"Quelle est la différence entre un acide fort et un acide faible ?","answer":"Acide fort : dissociation totale dans l''eau (AH → A⁻ + H⁺). Exemples : HCl, H₂SO₄, HNO₃. pH = -log(Ca). Acide faible : dissociation partielle (AH ⇌ A⁻ + H⁺). Ka = [A⁻][H⁺]/[AH]. Exemples : CH₃COOH (Ka = 1,8×10⁻⁵), H₂CO₃. pH > -log(Ca)."},
      {"id":"fc4","category":"Formule","question":"Qu''est-ce que le pKa et comment l''utiliser ?","answer":"pKa = -log(Ka) caractérise la force d''un acide. Plus pKa est petit, plus l''acide est fort. Pour un couple AH/A⁻ : si pH < pKa, la forme acide AH prédomine. Si pH > pKa, la forme basique A⁻ prédomine. Si pH = pKa, [AH] = [A⁻] (demi-équivalence). Exemples : CH₃COOH/CH₃COO⁻ pKa = 4,75 ; NH₄⁺/NH₃ pKa = 9,25."},
      {"id":"fc5","category":"Méthode","question":"Comment réaliser un dosage acido-basique ?","answer":"1) Verser la solution titrante (burette) dans la solution à doser (bécher + indicateur ou pH-mètre). 2) Relever le pH à chaque ajout. 3) Tracer la courbe pH = f(V). 4) Déterminer le point d''équivalence (saut de pH ou méthode des tangentes ou dpH/dV max). 5) À l''équivalence : na = nb (moles d''acide = moles de base). Ca·Va = Cb·Vb."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce qu''un indicateur coloré ?","answer":"Un indicateur coloré est un acide faible dont la forme acide HIn et la forme basique In⁻ ont des couleurs différentes. La zone de virage est centrée sur pKa_indicateur (pH ≈ pKa ± 1). Exemples : hélianthine (3,1-4,4, rouge → jaune), bleu de bromothymol BBT (6,0-7,6, jaune → bleu), phénolphtaléine (8,2-10, incolore → rose). Choisir un indicateur dont la zone de virage contient le pH d''équivalence."},
      {"id":"fc7","category":"Formule","question":"Qu''est-ce qu''une solution tampon ?","answer":"Une solution tampon résiste aux variations de pH lors d''ajouts modérés d''acide ou de base. Elle contient un acide faible et sa base conjuguée en concentrations comparables. pH = pKa + log([A⁻]/[AH]) (Henderson-Hasselbalch). Le pouvoir tampon est maximal quand [A⁻] = [AH], soit pH = pKa. Exemple : tampon acétique CH₃COOH/CH₃COO⁻Na⁺."},
      {"id":"fc8","category":"Exemple","question":"Décrire la courbe de dosage d''un acide fort par une base forte.","answer":"Dosage de HCl par NaOH : pH initial bas (≈ 1-2). Le pH augmente lentement, puis brusquement autour de l''équivalence (saut de pH de ≈ 4 à ≈ 10). pH à l''équivalence = 7 (acide fort + base forte → sel neutre + H₂O). Après l''équivalence, pH élevé (≈ 12-13). Indicateur adapté : BBT ou phénolphtaléine."},
      {"id":"fc9","category":"Distinction","question":"Comparer le dosage d''un acide fort et d''un acide faible par une base forte.","answer":"Acide fort : pH initial très bas, grand saut de pH à l''équivalence, pH_éq = 7. Acide faible : pH initial plus élevé, saut de pH plus petit, pH_éq > 7 (car la base conjuguée A⁻ est basique). Point de demi-équivalence : pH = pKa (zone tampon). L''indicateur doit avoir une zone de virage correspondant au pH d''équivalence."},
      {"id":"fc10","category":"Formule","question":"Exprimer le produit ionique de l''eau.","answer":"L''autoprotolyse de l''eau : 2H₂O ⇌ H₃O⁺ + OH⁻. Ke = [H₃O⁺]·[OH⁻] = 10⁻¹⁴ à 25°C. Donc pKe = pH + pOH = 14. Solution neutre : [H₃O⁺] = [OH⁻] = 10⁻⁷ mol/L, pH = 7. Solution acide : pH < 7. Solution basique : pH > 7. Ke augmente avec la température."},
      {"id":"fc11","category":"Méthode","question":"Comment déterminer le point d''équivalence d''un dosage ?","answer":"1) Méthode des tangentes : tracer deux tangentes parallèles de part et d''autre du saut de pH, le point d''équivalence est au milieu. 2) Méthode de la dérivée : dpH/dV est maximal au point d''équivalence. 3) Avec indicateur coloré : le virage de couleur indique l''équivalence. 4) Méthode conductimétrique : changement de pente de la conductivité."},
      {"id":"fc12","category":"Exemple","question":"On dose 20 mL de HCl 0,1 mol/L par NaOH 0,1 mol/L. Quel volume à l''équivalence ?","answer":"À l''équivalence : na = nb. Ca·Va = Cb·Vb. 0,1 × 20 = 0,1 × Vb. Vb = 20 mL. pH à l''équivalence = 7 (acide fort + base forte). Avant l''équivalence (V = 10 mL) : n(H⁺) excès = 2 - 1 = 1 mmol dans 30 mL, pH = -log(1/30) ≈ 1,48. Après (V = 30 mL) : n(OH⁻) excès = 1 mmol dans 50 mL, pOH = -log(1/50) ≈ 1,70, pH = 12,30."}
    ],
    "schema": {
      "title": "Acides et bases",
      "nodes": [
        {"id":"n1","label":"Acides et bases","type":"main"},
        {"id":"n2","label":"Définitions","type":"branch"},
        {"id":"n3","label":"pH et pKa","type":"branch"},
        {"id":"n4","label":"Dosages","type":"branch"},
        {"id":"n5","label":"Brønsted\nfort/faible","type":"leaf"},
        {"id":"n6","label":"Ke = 10⁻¹⁴\npH + pOH = 14","type":"leaf"},
        {"id":"n7","label":"Henderson\npH = pKa + log","type":"leaf"},
        {"id":"n8","label":"Solution tampon","type":"leaf"},
        {"id":"n9","label":"Courbe pH\nÉquivalence","type":"leaf"},
        {"id":"n10","label":"Indicateurs\ncolorés","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"théorie"},
        {"from":"n1","to":"n3","label":"quantitatif"},
        {"from":"n1","to":"n4","label":"expérimental"},
        {"from":"n2","to":"n5","label":"couples"},
        {"from":"n2","to":"n6","label":"eau"},
        {"from":"n3","to":"n7","label":"formule"},
        {"from":"n3","to":"n8","label":"application"},
        {"from":"n4","to":"n9","label":"méthode"},
        {"from":"n4","to":"n10","label":"détection"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le pH d''une solution de HCl 0,01 mol/L est :","options":["1","2","7","12"],"correct":1,"explanation":"HCl est un acide fort : dissociation totale. [H₃O⁺] = Ca = 0,01 = 10⁻² mol/L. pH = -log(10⁻²) = 2."},
      {"id":"q2","question":"Le produit ionique de l''eau à 25°C vaut :","options":["10⁻⁷","10⁻¹⁴","10⁷","1"],"correct":1,"explanation":"Ke = [H₃O⁺]·[OH⁻] = 10⁻¹⁴ à 25°C. C''est une constante d''équilibre de l''autoprotolyse de l''eau."},
      {"id":"q3","question":"À la demi-équivalence du dosage d''un acide faible par une base forte :","options":["pH = 0","pH = 7","pH = pKa","pH = 14"],"correct":2,"explanation":"À la demi-équivalence, [AH] = [A⁻], donc pH = pKa + log(1) = pKa. C''est le point central de la zone tampon."},
      {"id":"q4","question":"Le pH à l''équivalence du dosage d''un acide faible par une base forte est :","options":["< 7","= 7","> 7","= 0"],"correct":2,"explanation":"À l''équivalence, la solution contient la base conjuguée A⁻ (basique), donc pH > 7. L''indicateur adapté est la phénolphtaléine (zone de virage 8,2-10)."},
      {"id":"q5","question":"La phénolphtaléine vire dans la zone de pH :","options":["3,1 - 4,4","6,0 - 7,6","8,2 - 10,0","1,2 - 2,8"],"correct":2,"explanation":"La phénolphtaléine est incolore en milieu acide et rose en milieu basique. Sa zone de virage est pH 8,2 à 10,0. Elle est adaptée aux dosages avec pH_éq > 7."},
      {"id":"q6","question":"Une solution tampon contient :","options":["Un acide fort et une base forte","Un acide faible et sa base conjuguée","Uniquement de l''eau pure","Un sel neutre"],"correct":1,"explanation":"Une solution tampon contient un acide faible et sa base conjuguée en concentrations comparables. Elle résiste aux variations de pH."},
      {"id":"q7","question":"Plus le pKa d''un acide est petit :","options":["Plus l''acide est faible","Plus l''acide est fort","Plus la base conjuguée est forte","Plus le pH est élevé"],"correct":1,"explanation":"pKa = -log(Ka). Plus Ka est grand (acide fort), plus pKa est petit. HCl (pKa ≈ -7) est bien plus fort que CH₃COOH (pKa = 4,75)."},
      {"id":"q8","question":"À l''équivalence d''un dosage : na = nb signifie :","options":["Les volumes sont égaux","Les concentrations sont égales","Les moles d''acide et de base sont égales","Le pH est neutre"],"correct":2,"explanation":"À l''équivalence, la quantité de matière d''acide est égale à celle de base : na = nb, soit Ca·Va = Cb·Vb."},
      {"id":"q9","question":"L''acide éthanoïque CH₃COOH est un acide :","options":["Fort","Faible","Très fort","Neutre"],"correct":1,"explanation":"L''acide éthanoïque (acide acétique, pKa = 4,75) est un acide faible : il ne se dissocie que partiellement dans l''eau (Ka = 1,8×10⁻⁵)."},
      {"id":"q10","question":"La formule de Henderson-Hasselbalch est :","options":["pH = -log[H⁺]","pH = pKa + log([A⁻]/[AH])","pH = 14 - pOH","pH = ½(pKa - log Ca)"],"correct":1,"explanation":"pH = pKa + log([A⁻]/[AH]) est la formule de Henderson-Hasselbalch. Elle donne le pH d''un tampon en fonction du rapport des concentrations de la base conjuguée et de l''acide."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 1: Pourcentages
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'pourcentages', 1, 'Pourcentages', 'Directs, additifs, successifs, indirects', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'pourcentages-fiche', 'Pourcentages', 'Pourcentages directs, additifs, successifs et indirects', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un pourcentage direct ?","answer":"Un pourcentage direct exprime une proportion : p% d''une quantité Q vaut (p/100)×Q. Exemple : 25% de 200 = (25/100)×200 = 50. Le pourcentage est un rapport multiplié par 100 : si 15 élèves sur 60 ont la mention Bien, le pourcentage est (15/60)×100 = 25%."},
      {"id":"fc2","category":"Formule","question":"Comment calculer un pourcentage d''augmentation ou de diminution ?","answer":"Taux de variation t = (Vf - Vi)/Vi × 100. Augmentation de t% : Vf = Vi × (1 + t/100). Diminution de t% : Vf = Vi × (1 - t/100). Le coefficient multiplicateur CM = 1 + t/100 pour une hausse, CM = 1 - t/100 pour une baisse. Exemple : hausse de 20% → CM = 1,20 ; baisse de 15% → CM = 0,85."},
      {"id":"fc3","category":"Formule","question":"Comment calculer des pourcentages successifs ?","answer":"Des variations successives se composent en multipliant les coefficients multiplicateurs. Hausse de a% puis baisse de b% : CM global = (1 + a/100) × (1 - b/100). Attention : une hausse de 20% suivie d''une baisse de 20% ne revient pas au prix initial ! CM = 1,20 × 0,80 = 0,96 (baisse globale de 4%)."},
      {"id":"fc4","category":"Formule","question":"Comment calculer un pourcentage indirect (pourcentage de pourcentage) ?","answer":"Si p₁% d''une population possède une propriété A, et parmi ceux-ci, p₂% possèdent aussi la propriété B, alors le pourcentage de la population totale ayant A et B est : (p₁/100) × (p₂/100) × 100 = p₁×p₂/100. Exemple : 60% des élèves font du sport, parmi eux 30% font du football. Footballeurs = 60×30/100 = 18% du total."},
      {"id":"fc5","category":"Méthode","question":"Comment retrouver la valeur initiale connaissant la valeur finale et le pourcentage ?","answer":"Si Vf = Vi × CM, alors Vi = Vf / CM. Exemple : un article coûte 120 000 FCFA après une hausse de 20%. Vi = 120 000 / 1,20 = 100 000 FCFA. Attention à ne pas faire l''erreur de calculer 120 000 × 0,80 = 96 000 (qui serait une baisse de 20% sur 120 000, pas l''inverse de la hausse)."},
      {"id":"fc6","category":"Formule","question":"Comment calculer le taux d''évolution global pour des variations successives ?","answer":"CM_global = CM₁ × CM₂ × ... × CMn. Le taux global t_global = (CM_global - 1) × 100. Exemple : hausses successives de 10%, 20%, 5%. CM = 1,10 × 1,20 × 1,05 = 1,386. Taux global = 38,6%. Le taux moyen annuel tm vérifie (1 + tm/100)^n = CM_global."},
      {"id":"fc7","category":"Exemple","question":"Un prix augmente de 30% puis baisse de 20%. Quel est le taux global ?","answer":"CM = 1,30 × 0,80 = 1,04. Le taux global est +4% (hausse). Le prix n''a pas retrouvé sa valeur initiale après la baisse de 20%. Si le prix initial est 10 000 FCFA : après +30% → 13 000 FCFA, après -20% → 10 400 FCFA. La hausse nette est de 400 FCFA soit 4%."},
      {"id":"fc8","category":"Distinction","question":"Quelle est la différence entre pourcentage additif et pourcentage multiplicatif ?","answer":"Pourcentage additif : on ajoute les pourcentages quand ils portent sur la même base (les populations sont disjointes). Exemple : 30% + 25% + 15% = 70% (parts de marché). Pourcentage multiplicatif : on multiplie les coefficients quand les pourcentages sont successifs (appliqués l''un après l''autre). Ne jamais additionner des variations successives."},
      {"id":"fc9","category":"Méthode","question":"Comment comparer deux évolutions ?","answer":"Pour comparer, utiliser les coefficients multiplicateurs ou les taux de variation rapportés à la même base. Deux hausses de 50% et 100% n''ont pas le même impact : CM₁ = 1,50, CM₂ = 2,00. On peut aussi utiliser des indices : en posant une valeur de base à 100, on suit l''évolution relative. L''indice mesure l''évolution par rapport à une année de référence."},
      {"id":"fc10","category":"Formule","question":"Comment calculer le taux d''évolution réciproque ?","answer":"Si un prix augmente de t%, le taux de baisse tr pour revenir au prix initial vérifie : (1 + t/100)(1 + tr/100) = 1. Donc tr = -t/(1 + t/100) × 100. Exemple : après une hausse de 25%, il faut une baisse de 25/1,25 = 20% pour revenir au prix initial (pas 25%)."},
      {"id":"fc11","category":"Exemple","question":"Le PIB d''un pays passe de 5000 à 6500 milliards en 5 ans. Quel est le taux moyen annuel ?","answer":"CM_global = 6500/5000 = 1,30. Taux moyen annuel : (1 + tm)^5 = 1,30, donc 1 + tm = 1,30^(1/5) = 1,30^0,2 ≈ 1,0539. Le taux moyen annuel est tm ≈ 5,39%. Vérification : 5000 × 1,0539^5 ≈ 6500."},
      {"id":"fc12","category":"Méthode","question":"Comment résoudre un problème de TVA ?","answer":"Prix TTC = Prix HT × (1 + TVA/100). Prix HT = Prix TTC / (1 + TVA/100). Exemple avec TVA = 18% : un article à 50 000 FCFA HT → TTC = 50 000 × 1,18 = 59 000 FCFA. Un article à 59 000 FCFA TTC → HT = 59 000 / 1,18 = 50 000 FCFA. La TVA payée = TTC - HT."}
    ],
    "schema": {
      "title": "Pourcentages",
      "nodes": [
        {"id":"n1","label":"Pourcentages","type":"main"},
        {"id":"n2","label":"Directs","type":"branch"},
        {"id":"n3","label":"Variations","type":"branch"},
        {"id":"n4","label":"Successifs","type":"branch"},
        {"id":"n5","label":"p% de Q\n= (p/100)×Q","type":"leaf"},
        {"id":"n6","label":"CM = 1 ± t/100\nTaux de variation","type":"leaf"},
        {"id":"n7","label":"CM global\n= CM₁×CM₂×...","type":"leaf"},
        {"id":"n8","label":"Taux moyen\nTaux réciproque","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"proportion"},
        {"from":"n1","to":"n3","label":"évolution"},
        {"from":"n1","to":"n4","label":"composition"},
        {"from":"n2","to":"n5","label":"calcul"},
        {"from":"n3","to":"n6","label":"formule"},
        {"from":"n4","to":"n7","label":"multiplication"},
        {"from":"n4","to":"n8","label":"applications"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le coefficient multiplicateur pour une hausse de 15% est :","options":["0,15","0,85","1,15","1,85"],"correct":2,"explanation":"CM = 1 + 15/100 = 1,15. On multiplie la valeur initiale par 1,15 pour obtenir la valeur après hausse de 15%."},
      {"id":"q2","question":"Une hausse de 50% suivie d''une baisse de 50% donne un taux global de :","options":["0%","-25%","+25%","-50%"],"correct":1,"explanation":"CM = 1,50 × 0,50 = 0,75. Taux global = 0,75 - 1 = -0,25 = -25%. Une hausse et une baisse de même pourcentage ne se compensent pas."},
      {"id":"q3","question":"Un article coûte 23 600 FCFA TTC avec une TVA de 18%. Le prix HT est :","options":["19 322 FCFA","20 000 FCFA","21 240 FCFA","23 600 FCFA"],"correct":1,"explanation":"Prix HT = TTC / (1 + 18/100) = 23 600 / 1,18 = 20 000 FCFA."},
      {"id":"q4","question":"Après une hausse de 25%, le taux de baisse pour revenir au prix initial est :","options":["20%","25%","30%","15%"],"correct":0,"explanation":"tr = -25/125 × 100 = -20%. Il faut une baisse de 20% (pas 25%) pour revenir au prix initial. Vérification : 1,25 × 0,80 = 1,00."},
      {"id":"q5","question":"30% de 40% d''une population représente :","options":["70% de la population","12% de la population","10% de la population","35% de la population"],"correct":1,"explanation":"Pourcentage indirect : (30/100) × (40/100) = 0,12 = 12% de la population totale. On multiplie les proportions."},
      {"id":"q6","question":"Le taux de variation de 80 à 100 est :","options":["20%","25%","80%","125%"],"correct":1,"explanation":"t = (100 - 80)/80 × 100 = 20/80 × 100 = 25%. La variation de 20 rapportée à la valeur initiale 80 donne 25%."},
      {"id":"q7","question":"Pour des variations successives, on :","options":["Additionne les taux","Multiplie les coefficients multiplicateurs","Soustrait les taux","Divise les pourcentages"],"correct":1,"explanation":"Les variations successives se composent par multiplication des CM : CM_global = CM₁ × CM₂ × ... On ne peut pas additionner des taux successifs."},
      {"id":"q8","question":"Le CM pour une baisse de 30% est :","options":["0,30","0,70","1,30","1,70"],"correct":1,"explanation":"CM = 1 - 30/100 = 0,70. La valeur finale est 70% de la valeur initiale."},
      {"id":"q9","question":"Un prix double en 5 ans. Le taux moyen annuel est environ :","options":["20%","40%","14,9%","10%"],"correct":2,"explanation":"(1+tm)^5 = 2, donc 1+tm = 2^(1/5) ≈ 1,149. Le taux moyen annuel est environ 14,9%. Ce n''est pas 100/5 = 20%."},
      {"id":"q10","question":"25% de 600 vaut :","options":["25","100","150","250"],"correct":2,"explanation":"25% de 600 = (25/100) × 600 = 0,25 × 600 = 150."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 2: Progressions arithmétique et géométrique
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'progressions', 2, 'Progressions arithmétique et géométrique', 'Terme général, somme', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'progressions-fiche', 'Progressions arithmétique et géométrique', 'Suites arithmétiques et géométriques : terme général et somme', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une suite arithmétique ?","answer":"Une suite arithmétique est une suite (un) où chaque terme s''obtient en ajoutant une constante r (raison) au terme précédent : un+1 = un + r. Terme général : un = u₀ + n·r = up + (n-p)·r. Si r > 0 : suite croissante. Si r < 0 : suite décroissante. Exemple : 2, 5, 8, 11, 14... (r = 3)."},
      {"id":"fc2","category":"Formule","question":"Quelle est la somme des n premiers termes d''une suite arithmétique ?","answer":"Sn = u₁ + u₂ + ... + un = n × (u₁ + un)/2 = n × (premier + dernier)/2. Aussi : Sn = n × (2u₁ + (n-1)r)/2. Cas particulier : 1 + 2 + 3 + ... + n = n(n+1)/2. Exemple : somme de 1 à 100 = 100×101/2 = 5050 (Gauss)."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''une suite géométrique ?","answer":"Une suite géométrique est une suite (un) où chaque terme s''obtient en multipliant le précédent par une constante q (raison) : un+1 = un × q. Terme général : un = u₀ × qⁿ = up × q^(n-p). Si q > 1 : suite croissante (u₀ > 0). Si 0 < q < 1 : suite décroissante (u₀ > 0). Exemple : 2, 6, 18, 54... (q = 3)."},
      {"id":"fc4","category":"Formule","question":"Quelle est la somme des n premiers termes d''une suite géométrique ?","answer":"Si q ≠ 1 : Sn = u₁ × (1 - qⁿ)/(1 - q) = u₁ × (qⁿ - 1)/(q - 1). Si q = 1 : Sn = n × u₁. Cas particulier : 1 + q + q² + ... + qⁿ⁻¹ = (qⁿ - 1)/(q - 1). Si |q| < 1, la somme infinie converge : S∞ = u₁/(1 - q)."},
      {"id":"fc5","category":"Méthode","question":"Comment reconnaître une suite arithmétique ou géométrique ?","answer":"Arithmétique : la différence un+1 - un = r est constante. Représentation graphique : points alignés. Géométrique : le rapport un+1/un = q est constant (un ≠ 0). Représentation : croissance/décroissance exponentielle. Attention : vérifier sur plusieurs termes, pas seulement deux consécutifs."},
      {"id":"fc6","category":"Formule","question":"Comment calculer la raison r d''une suite arithmétique ?","answer":"Si on connaît deux termes up et un : r = (un - up)/(n - p). Exemple : si u₃ = 7 et u₇ = 19, r = (19 - 7)/(7 - 3) = 12/4 = 3. Puis u₁ = u₃ - 2r = 7 - 6 = 1. Vérification : u₇ = 1 + 6×3 = 19."},
      {"id":"fc7","category":"Formule","question":"Comment calculer la raison q d''une suite géométrique ?","answer":"Si on connaît deux termes up et un : q^(n-p) = un/up, donc q = (un/up)^(1/(n-p)). Exemple : si u₂ = 6 et u₅ = 162, q³ = 162/6 = 27, q = 3. Puis u₁ = u₂/q = 6/3 = 2. Vérification : u₅ = 2 × 3⁴ = 162."},
      {"id":"fc8","category":"Exemple","question":"Calculer la somme S = 1 + 2 + 4 + 8 + ... + 1024.","answer":"C''est une suite géométrique de raison q = 2, premier terme u₁ = 1. Il faut trouver n : 1024 = 2^(n-1), n-1 = 10, n = 11. S = 1 × (2¹¹ - 1)/(2 - 1) = 2048 - 1 = 2047. Ou directement : S = 2¹¹ - 1 = 2047."},
      {"id":"fc9","category":"Distinction","question":"Quand une suite géométrique converge-t-elle ?","answer":"Une suite géométrique converge (tend vers une limite finie) si |q| < 1. Dans ce cas, un → 0 et la somme infinie converge : S∞ = u₁/(1 - q). Si q > 1 : un → +∞. Si q < -1 : la suite diverge en oscillant. Si q = 1 : suite constante. Si q = -1 : suite alternée (oscille entre u₁ et -u₁)."},
      {"id":"fc10","category":"Méthode","question":"Comment résoudre un problème de placement à intérêts composés ?","answer":"Un capital C₀ placé au taux annuel t pendant n ans donne : Cn = C₀ × (1 + t)ⁿ. C''est une suite géométrique de raison q = 1 + t. Exemple : 1 000 000 FCFA à 5% pendant 10 ans → C₁₀ = 10⁶ × 1,05¹⁰ ≈ 1 628 895 FCFA. Les intérêts gagnés : I = C₁₀ - C₀ ≈ 628 895 FCFA."},
      {"id":"fc11","category":"Distinction","question":"Quelle est la différence entre intérêts simples et intérêts composés ?","answer":"Intérêts simples : les intérêts sont calculés sur le capital initial uniquement. Cn = C₀(1 + n·t). Suite arithmétique de raison C₀·t. Intérêts composés : les intérêts sont ajoutés au capital et produisent eux-mêmes des intérêts. Cn = C₀(1+t)ⁿ. Suite géométrique. Sur le long terme, les intérêts composés sont beaucoup plus avantageux."},
      {"id":"fc12","category":"Formule","question":"Comment exprimer un terme général en fonction du rang pour une suite arithmético-géométrique ?","answer":"Une suite définie par un+1 = a·un + b (avec a ≠ 1) est arithmético-géométrique. Méthode : 1) Trouver le point fixe l = al + b, soit l = b/(1-a). 2) Poser vn = un - l. 3) Alors vn+1 = a·vn (suite géométrique). 4) vn = v₀·aⁿ. 5) un = vn + l = (u₀ - l)·aⁿ + l."}
    ],
    "schema": {
      "title": "Progressions arithmétique et géométrique",
      "nodes": [
        {"id":"n1","label":"Progressions","type":"main"},
        {"id":"n2","label":"Arithmétique","type":"branch"},
        {"id":"n3","label":"Géométrique","type":"branch"},
        {"id":"n4","label":"un = u₀ + nr\nSn = n(u₁+un)/2","type":"leaf"},
        {"id":"n5","label":"un = u₀·qⁿ\nSn = u₁(qⁿ-1)/(q-1)","type":"leaf"},
        {"id":"n6","label":"Intérêts\nsimples","type":"leaf"},
        {"id":"n7","label":"Intérêts\ncomposés","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"un+1 = un + r"},
        {"from":"n1","to":"n3","label":"un+1 = un × q"},
        {"from":"n2","to":"n4","label":"formules"},
        {"from":"n3","to":"n5","label":"formules"},
        {"from":"n2","to":"n6","label":"application"},
        {"from":"n3","to":"n7","label":"application"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le terme général d''une suite arithmétique de premier terme u₁ = 3 et de raison r = 4 est :","options":["un = 3 + 4n","un = 3 + 4(n-1)","un = 4n + 3","un = 3 × 4ⁿ"],"correct":1,"explanation":"un = u₁ + (n-1)r = 3 + 4(n-1) = 4n - 1. Pour n = 1 : u₁ = 3, pour n = 2 : u₂ = 7, etc."},
      {"id":"q2","question":"La somme 1 + 2 + 3 + ... + 100 vaut :","options":["100","1000","5050","10000"],"correct":2,"explanation":"S = n(n+1)/2 = 100 × 101/2 = 5050. C''est la formule de la somme d''une suite arithmétique de raison 1."},
      {"id":"q3","question":"Le terme général d''une suite géométrique de premier terme u₁ = 2 et de raison q = 3 est :","options":["un = 2 + 3n","un = 2 × 3ⁿ","un = 2 × 3ⁿ⁻¹","un = 3 × 2ⁿ"],"correct":2,"explanation":"un = u₁ × q^(n-1) = 2 × 3^(n-1). Pour n = 1 : u₁ = 2, pour n = 2 : u₂ = 6, pour n = 3 : u₃ = 18."},
      {"id":"q4","question":"La somme des n premiers termes d''une suite géométrique de raison q ≠ 1 est :","options":["Sn = n·u₁","Sn = u₁(qⁿ-1)/(q-1)","Sn = n(u₁+un)/2","Sn = u₁·qⁿ"],"correct":1,"explanation":"Sn = u₁(qⁿ-1)/(q-1) pour q ≠ 1. C''est obtenu en multipliant Sn par q et en soustrayant."},
      {"id":"q5","question":"Une suite géométrique de raison q converge si :","options":["q > 1","q < 0","q = 1","|q| < 1"],"correct":3,"explanation":"Une suite géométrique converge vers 0 si |q| < 1. La somme infinie converge alors vers S∞ = u₁/(1-q)."},
      {"id":"q6","question":"Un capital de 500 000 FCFA placé à 6% en intérêts composés pendant 3 ans donne :","options":["590 000 FCFA","500 000 × 1,06³ FCFA","500 000 + 3×30 000 FCFA","500 000 × 3 × 1,06 FCFA"],"correct":1,"explanation":"Cn = C₀ × (1+t)ⁿ = 500 000 × 1,06³ ≈ 595 508 FCFA. En intérêts composés, les intérêts produisent eux-mêmes des intérêts."},
      {"id":"q7","question":"Pour une suite arithmétique, la représentation graphique des termes est :","options":["Une parabole","Des points alignés","Une courbe exponentielle","Un cercle"],"correct":1,"explanation":"Les termes un = u₀ + nr forment une fonction affine de n. Les points (n, un) sont alignés sur une droite de pente r."},
      {"id":"q8","question":"Si u₃ = 12 et u₇ = 28 pour une suite arithmétique, la raison r vaut :","options":["2","3","4","5"],"correct":2,"explanation":"r = (u₇ - u₃)/(7 - 3) = (28 - 12)/4 = 16/4 = 4."},
      {"id":"q9","question":"La somme infinie 1 + 1/2 + 1/4 + 1/8 + ... vaut :","options":["1","2","∞","1/2"],"correct":1,"explanation":"Suite géométrique de u₁ = 1 et q = 1/2. Comme |q| < 1 : S∞ = u₁/(1-q) = 1/(1-1/2) = 2."},
      {"id":"q10","question":"La différence entre intérêts composés et intérêts simples est que :","options":["Les intérêts simples sont plus rentables","Les intérêts composés capitalisent les intérêts","Les intérêts simples varient chaque année","Il n''y a aucune différence"],"correct":1,"explanation":"En intérêts composés, les intérêts sont ajoutés au capital et produisent à leur tour des intérêts (capitalisation). C''est plus rentable sur le long terme."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 3: Limites, continuité, dérivation, primitives
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'limites-derivation', 3, 'Limites, continuité, dérivation, primitives', 'Composée, réciproque, intégration', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'limites-derivation-fiche', 'Limites, continuité, dérivation, primitives', 'Analyse : limites, dérivées et intégrales', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la limite d''une fonction en un point ?","answer":"lim(x→a) f(x) = L signifie que f(x) peut être rendue aussi proche de L que l''on veut en prenant x suffisamment proche de a. Limites à l''infini : lim(x→+∞) f(x) = L (asymptote horizontale y = L). lim(x→a) f(x) = ±∞ (asymptote verticale x = a). Formes indéterminées : 0/0, ∞/∞, ∞-∞, 0×∞, 1^∞, 0⁰."},
      {"id":"fc2","category":"Formule","question":"Quelles sont les principales règles de dérivation ?","answer":"(u + v)'' = u'' + v''. (k·u)'' = k·u''. (u·v)'' = u''·v + u·v''. (u/v)'' = (u''·v - u·v'')/v². (uⁿ)'' = n·uⁿ⁻¹·u'' (composée). Dérivées de base : (xⁿ)'' = n·xⁿ⁻¹, (eˣ)'' = eˣ, (ln x)'' = 1/x, (sin x)'' = cos x, (cos x)'' = -sin x."},
      {"id":"fc3","category":"Formule","question":"Comment dériver une fonction composée ?","answer":"Si f = g∘u (f(x) = g(u(x))), alors f''(x) = u''(x) × g''(u(x)). Exemples : (e^(u(x)))'' = u''(x)·e^(u(x)). (ln(u(x)))'' = u''(x)/u(x). ((u(x))ⁿ)'' = n·u''(x)·(u(x))ⁿ⁻¹. (sin(u(x)))'' = u''(x)·cos(u(x))."},
      {"id":"fc4","category":"Formule","question":"Quelles sont les primitives des fonctions usuelles ?","answer":"∫xⁿ dx = xⁿ⁺¹/(n+1) + C (n ≠ -1). ∫1/x dx = ln|x| + C. ∫eˣ dx = eˣ + C. ∫cos x dx = sin x + C. ∫sin x dx = -cos x + C. ∫e^(ax) dx = e^(ax)/a + C. ∫u''/u dx = ln|u| + C. ∫u''·eᵘ dx = eᵘ + C."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que l''intégrale définie et ses propriétés ?","answer":"∫[a,b] f(x) dx = F(b) - F(a) où F est une primitive de f. Propriétés : linéarité, relation de Chasles ∫[a,b] + ∫[b,c] = ∫[a,c]. Si f ≥ 0 sur [a,b], ∫[a,b] f(x) dx ≥ 0 (aire sous la courbe). Valeur moyenne : (1/(b-a))∫[a,b] f(x) dx."},
      {"id":"fc6","category":"Méthode","question":"Comment lever une indétermination de type 0/0 ?","answer":"1) Factoriser numérateur et dénominateur. 2) Simplifier le facteur commun. 3) Calculer la limite. Exemple : lim(x→2) (x²-4)/(x-2) = lim(x→2) (x-2)(x+2)/(x-2) = lim(x→2) (x+2) = 4. Autre technique : diviser par le terme de plus haut degré pour ∞/∞."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la continuité d''une fonction ?","answer":"f est continue en a si lim(x→a) f(x) = f(a). Trois conditions : 1) f(a) existe. 2) lim(x→a) f(x) existe. 3) La limite égale f(a). Les polynômes, fonctions rationnelles (sur leur domaine), exp, ln, sin, cos sont continues. Le théorème des valeurs intermédiaires (TVI) : si f continue sur [a,b] et f(a)·f(b) < 0, alors ∃c ∈ ]a,b[ tel que f(c) = 0."},
      {"id":"fc8","category":"Formule","question":"Comment calculer la dérivée de la fonction réciproque ?","answer":"Si y = f⁻¹(x), alors (f⁻¹)''(x) = 1/f''(f⁻¹(x)). Applications : (√x)'' = 1/(2√x) car √x est la réciproque de x² (pour x > 0). (ln x)'' = 1/x car ln est la réciproque de eˣ. (arctan x)'' = 1/(1+x²). (arcsin x)'' = 1/√(1-x²)."},
      {"id":"fc9","category":"Méthode","question":"Comment étudier les variations d''une fonction avec la dérivée ?","answer":"1) Calculer f''(x). 2) Trouver les zéros de f''(x). 3) Déterminer le signe de f''(x) sur chaque intervalle. 4) f'' > 0 : f croissante. f'' < 0 : f décroissante. f''(a) = 0 avec changement de signe : extremum local. 5) Dresser le tableau de variations avec les valeurs remarquables."},
      {"id":"fc10","category":"Formule","question":"Quelles sont les limites de croissance comparée ?","answer":"lim(x→+∞) eˣ/xⁿ = +∞ (l''exponentielle l''emporte sur toute puissance). lim(x→+∞) (ln x)/xⁿ = 0 (toute puissance l''emporte sur le logarithme). lim(x→+∞) xⁿ/eˣ = 0. lim(x→0⁺) xⁿ·ln x = 0. Ces résultats sont fondamentaux pour les limites en analyse."},
      {"id":"fc11","category":"Exemple","question":"Calculer ∫[0,1] (2x + 1)² dx.","answer":"Développons : (2x+1)² = 4x² + 4x + 1. Primitive : F(x) = 4x³/3 + 2x² + x. ∫[0,1] = F(1) - F(0) = (4/3 + 2 + 1) - 0 = 4/3 + 3 = 13/3 ≈ 4,33. Autre méthode : poser u = 2x+1, du = 2dx, ∫ u²/2 du = u³/6 = (2x+1)³/6 |[0,1] = 27/6 - 1/6 = 26/6 = 13/3."},
      {"id":"fc12","category":"Distinction","question":"Quelle est la différence entre primitive et intégrale définie ?","answer":"Une primitive F de f est une fonction telle que F'' = f. Elle est définie à une constante près (F + C). L''intégrale définie ∫[a,b] f(x) dx est un nombre (valeur numérique) qui représente l''aire algébrique sous la courbe de f entre a et b. Lien : ∫[a,b] f(x) dx = F(b) - F(a) (théorème fondamental du calcul intégral)."}
    ],
    "schema": {
      "title": "Limites, dérivation, intégration",
      "nodes": [
        {"id":"n1","label":"Analyse","type":"main"},
        {"id":"n2","label":"Limites","type":"branch"},
        {"id":"n3","label":"Dérivation","type":"branch"},
        {"id":"n4","label":"Intégration","type":"branch"},
        {"id":"n5","label":"Formes\nindéterminées","type":"leaf"},
        {"id":"n6","label":"Continuité\nTVI","type":"leaf"},
        {"id":"n7","label":"Règles\ncomposée","type":"leaf"},
        {"id":"n8","label":"Variations\nextremums","type":"leaf"},
        {"id":"n9","label":"Primitives\n∫[a,b] f dx","type":"leaf"},
        {"id":"n10","label":"Aire sous\nla courbe","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"x → a"},
        {"from":"n1","to":"n3","label":"f''(x)"},
        {"from":"n1","to":"n4","label":"F'' = f"},
        {"from":"n2","to":"n5","label":"0/0, ∞/∞"},
        {"from":"n2","to":"n6","label":"théorème"},
        {"from":"n3","to":"n7","label":"calcul"},
        {"from":"n3","to":"n8","label":"application"},
        {"from":"n4","to":"n9","label":"formules"},
        {"from":"n4","to":"n10","label":"géométrie"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La dérivée de eˣ est :","options":["xeˣ⁻¹","eˣ","1/eˣ","x·eˣ"],"correct":1,"explanation":"La fonction exponentielle est sa propre dérivée : (eˣ)'' = eˣ. C''est la propriété fondamentale de l''exponentielle."},
      {"id":"q2","question":"∫1/x dx = ","options":["x²/2 + C","ln|x| + C","-1/x² + C","eˣ + C"],"correct":1,"explanation":"La primitive de 1/x est ln|x| + C. C''est le cas n = -1 qui n''entre pas dans la formule xⁿ⁺¹/(n+1)."},
      {"id":"q3","question":"La dérivée de ln(2x+1) est :","options":["1/(2x+1)","2/(2x+1)","ln(2)","2·ln(2x+1)"],"correct":1,"explanation":"Par la règle de la composée : (ln(u))'' = u''/u. Ici u = 2x+1, u'' = 2. Donc (ln(2x+1))'' = 2/(2x+1)."},
      {"id":"q4","question":"lim(x→+∞) eˣ/x² = ","options":["0","1","+∞","Indéterminé"],"correct":2,"explanation":"Par croissance comparée, l''exponentielle l''emporte sur toute puissance : lim(x→+∞) eˣ/xⁿ = +∞."},
      {"id":"q5","question":"Le théorème des valeurs intermédiaires dit que si f est continue sur [a,b] avec f(a)·f(b) < 0 :","options":["f a un maximum","f s''annule en au moins un point de ]a,b[","f est dérivable","f est constante"],"correct":1,"explanation":"Le TVI garantit l''existence d''au moins un c ∈ ]a,b[ tel que f(c) = 0. C''est un outil fondamental pour prouver l''existence de solutions d''équations."},
      {"id":"q6","question":"(u·v)'' = ","options":["u''·v''","u''·v + u·v''","u''·v - u·v''","(u'' + v'')/2"],"correct":1,"explanation":"La dérivée d''un produit est (u·v)'' = u''·v + u·v'' (formule de Leibniz)."},
      {"id":"q7","question":"∫[0,1] 2x dx = ","options":["0","1","2","1/2"],"correct":1,"explanation":"Primitive de 2x : F(x) = x². ∫[0,1] 2x dx = F(1) - F(0) = 1 - 0 = 1."},
      {"id":"q8","question":"Si f''(x) > 0 sur un intervalle, alors f est :","options":["Décroissante","Constante","Croissante","Nulle"],"correct":2,"explanation":"Si f''(x) > 0 sur un intervalle, f est strictement croissante sur cet intervalle."},
      {"id":"q9","question":"La dérivée de sin(3x) est :","options":["cos(3x)","3cos(3x)","-3cos(3x)","sin(3x)/3"],"correct":1,"explanation":"Par la règle de la composée : (sin(u))'' = u''·cos(u). Ici u = 3x, u'' = 3. Donc (sin(3x))'' = 3cos(3x)."},
      {"id":"q10","question":"Une primitive de cos x est :","options":["-sin x","sin x","cos x","tan x"],"correct":1,"explanation":"∫cos x dx = sin x + C car (sin x)'' = cos x."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 4: Étude de fonctions
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'etude-fonctions', 4, 'Étude de fonctions', 'Polynômes, rationnelles, ln, exp, puissances', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'etude-fonctions-fiche', 'Étude de fonctions', 'Étude complète : polynômes, rationnelles, ln, exp', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Quelles sont les étapes d''une étude complète de fonction ?","answer":"1) Domaine de définition Df. 2) Parité, périodicité. 3) Limites aux bornes de Df (asymptotes). 4) Dérivée f''(x), signe et tableau de variations. 5) Points remarquables (extremums, points d''inflexion). 6) Asymptotes (horizontales, verticales, obliques). 7) Intersection avec les axes. 8) Tableau de valeurs et tracé de la courbe."},
      {"id":"fc2","category":"Formule","question":"Rappeler les propriétés de la fonction exponentielle.","answer":"Df = ℝ, f(x) = eˣ > 0 pour tout x. e⁰ = 1. eˣ est strictement croissante sur ℝ. lim(x→-∞) eˣ = 0, lim(x→+∞) eˣ = +∞. (eˣ)'' = eˣ. Propriétés algébriques : eᵃ⁺ᵇ = eᵃ·eᵇ, eᵃ⁻ᵇ = eᵃ/eᵇ, (eᵃ)ⁿ = eⁿᵃ. Équation : eˣ = a ⟺ x = ln(a) (si a > 0)."},
      {"id":"fc3","category":"Formule","question":"Rappeler les propriétés de la fonction logarithme népérien.","answer":"Df = ]0, +∞[. ln(1) = 0, ln(e) = 1. ln est strictement croissante. lim(x→0⁺) ln(x) = -∞, lim(x→+∞) ln(x) = +∞. (ln x)'' = 1/x. Propriétés : ln(ab) = ln(a) + ln(b), ln(a/b) = ln(a) - ln(b), ln(aⁿ) = n·ln(a). ln et exp sont réciproques : ln(eˣ) = x, e^(ln x) = x."},
      {"id":"fc4","category":"Formule","question":"Comment trouver les asymptotes d''une fonction rationnelle ?","answer":"f(x) = P(x)/Q(x). Asymptote verticale : x = a si Q(a) = 0 et P(a) ≠ 0. Asymptote horizontale : si deg(P) < deg(Q), y = 0 ; si deg(P) = deg(Q), y = rapport des coefficients dominants. Asymptote oblique y = ax + b : si deg(P) = deg(Q) + 1, effectuer la division euclidienne P/Q = ax + b + R/Q."},
      {"id":"fc5","category":"Méthode","question":"Comment étudier la position relative de la courbe par rapport à une asymptote oblique ?","answer":"Si f(x) = ax + b + R(x)/Q(x), la position relative dépend du signe de R(x)/Q(x). Si R(x)/Q(x) > 0 : la courbe est au-dessus de l''asymptote. Si R(x)/Q(x) < 0 : en dessous. Le changement de signe indique un point d''intersection entre la courbe et l''asymptote."},
      {"id":"fc6","category":"Formule","question":"Comment étudier une fonction x ↦ xᵃ (puissance réelle) ?","answer":"f(x) = xᵃ = e^(a·ln x), définie pour x > 0. f''(x) = a·xᵃ⁻¹. Si a > 1 : f convexe, croissante, f(0) = 0 (si a > 0). Si 0 < a < 1 : f concave, croissante (ex : √x = x^(1/2)). Si a < 0 : f décroissante (ex : 1/x = x⁻¹). Limites : xᵃ → +∞ (a > 0), xᵃ → 0 (a < 0) quand x → +∞."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce qu''un point d''inflexion ?","answer":"Un point d''inflexion est un point où la courbe change de concavité. En ce point, f''''(x₀) = 0 et f'''' change de signe. La tangente en un point d''inflexion traverse la courbe. f'''' > 0 : concavité vers le haut (convexe). f'''' < 0 : concavité vers le bas (concave). Le point d''inflexion est aussi le point où la dérivée f'' a un extremum."},
      {"id":"fc8","category":"Méthode","question":"Comment résoudre une équation f(x) = 0 graphiquement ?","answer":"1) Tracer la courbe de f. 2) Les solutions sont les abscisses des points d''intersection avec l''axe Ox. 3) Utiliser le TVI pour prouver l''existence de solutions sur chaque intervalle où f change de signe. 4) Encadrer les solutions par dichotomie. 5) Le nombre de solutions correspond au nombre de changements de signe dans le tableau de variations."},
      {"id":"fc9","category":"Exemple","question":"Étudier la fonction f(x) = xe^(-x).","answer":"Df = ℝ. f''(x) = e^(-x) - xe^(-x) = (1-x)e^(-x). f''(x) = 0 ⟺ x = 1. f'' > 0 sur ]-∞, 1[ et f'' < 0 sur ]1, +∞[. Maximum en x = 1 : f(1) = e⁻¹ ≈ 0,37. Limites : lim(x→-∞) f(x) = -∞, lim(x→+∞) f(x) = 0⁺ (croissance comparée). Asymptote horizontale y = 0 en +∞."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre maximum local et maximum global ?","answer":"Maximum local : f(a) ≥ f(x) pour tout x dans un voisinage de a. Maximum global (ou absolu) : f(a) ≥ f(x) pour tout x du domaine. Un maximum global est un maximum local, mais la réciproque est fausse. Pour trouver le maximum global, comparer les maxima locaux et les valeurs aux bornes du domaine."},
      {"id":"fc11","category":"Formule","question":"Comment résoudre l''équation eˣ = a ?","answer":"Si a ≤ 0 : pas de solution (eˣ > 0). Si a > 0 : x = ln(a). Propriétés utiles : eˣ = eᵃ ⟺ x = a. eˣ > eᵃ ⟺ x > a (car exp est croissante). e^(f(x)) = e^(g(x)) ⟺ f(x) = g(x). ln(f(x)) = ln(g(x)) ⟺ f(x) = g(x) (avec f(x) > 0, g(x) > 0)."},
      {"id":"fc12","category":"Méthode","question":"Comment montrer qu''une équation admet une unique solution sur un intervalle ?","answer":"1) Montrer que f est continue sur [a,b]. 2) Calculer f(a) et f(b) et vérifier que f(a)·f(b) < 0 (TVI : existence). 3) Montrer que f est strictement monotone sur [a,b] (unicité : f'' de signe constant). Conclusion : f(x) = 0 admet une unique solution sur [a,b]. Encadrer par dichotomie."}
    ],
    "schema": {
      "title": "Étude de fonctions",
      "nodes": [
        {"id":"n1","label":"Étude de\nfonctions","type":"main"},
        {"id":"n2","label":"Polynômes\nRationnelles","type":"branch"},
        {"id":"n3","label":"exp et ln","type":"branch"},
        {"id":"n4","label":"Méthode","type":"branch"},
        {"id":"n5","label":"Asymptotes\nV, H, O","type":"leaf"},
        {"id":"n6","label":"eˣ : ℝ → ℝ₊*\nln : ℝ₊* → ℝ","type":"leaf"},
        {"id":"n7","label":"Puissances\nxᵃ = e^(a ln x)","type":"leaf"},
        {"id":"n8","label":"Df, f'', variations\ntableau, courbe","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"algébriques"},
        {"from":"n1","to":"n3","label":"transcendantes"},
        {"from":"n1","to":"n4","label":"étapes"},
        {"from":"n2","to":"n5","label":"comportement"},
        {"from":"n3","to":"n6","label":"réciproques"},
        {"from":"n3","to":"n7","label":"généralisation"},
        {"from":"n4","to":"n8","label":"plan type"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le domaine de définition de ln(x-2) est :","options":["ℝ","]0, +∞[","]2, +∞[","]-∞, 2["],"correct":2,"explanation":"ln est défini pour un argument strictement positif : x - 2 > 0, soit x > 2. Df = ]2, +∞[."},
      {"id":"q2","question":"lim(x→+∞) ln(x)/x = ","options":["+∞","1","0","-∞"],"correct":2,"explanation":"Par croissance comparée, toute puissance de x (même x¹) l''emporte sur ln(x) : lim(x→+∞) ln(x)/x = 0."},
      {"id":"q3","question":"La fonction f(x) = eˣ a pour asymptote :","options":["y = 0 en -∞","y = 0 en +∞","x = 0","y = 1"],"correct":0,"explanation":"lim(x→-∞) eˣ = 0 : l''axe y = 0 (axe des abscisses) est asymptote horizontale en -∞."},
      {"id":"q4","question":"ln(a·b) = ","options":["ln(a) × ln(b)","ln(a) + ln(b)","ln(a) - ln(b)","ln(a)/ln(b)"],"correct":1,"explanation":"Le logarithme transforme le produit en somme : ln(ab) = ln(a) + ln(b). C''est une propriété fondamentale du logarithme."},
      {"id":"q5","question":"f(x) = x² - 4x + 3 s''annule pour :","options":["x = 1 et x = 3","x = -1 et x = -3","x = 2 et x = 6","x = 0 et x = 4"],"correct":0,"explanation":"x² - 4x + 3 = (x-1)(x-3) = 0 ⟺ x = 1 ou x = 3. Discriminant : Δ = 16 - 12 = 4, racines : (4±2)/2."},
      {"id":"q6","question":"Un point d''inflexion correspond à :","options":["f''(x₀) = 0","f''''(x₀) = 0 avec changement de signe","f(x₀) = 0","f''(x₀) > 0"],"correct":1,"explanation":"Un point d''inflexion est un point où f'''' s''annule et change de signe : la courbe change de concavité."},
      {"id":"q7","question":"e^(ln 5) = ","options":["e⁵","5","ln 5","5e"],"correct":1,"explanation":"exp et ln sont des fonctions réciproques : e^(ln x) = x. Donc e^(ln 5) = 5."},
      {"id":"q8","question":"La dérivée de f(x) = x³ - 3x est :","options":["3x² - 3","3x² + 3","x² - 3","3x³ - 3"],"correct":0,"explanation":"f''(x) = 3x² - 3. Les extremums : f''(x) = 0 ⟺ x² = 1 ⟺ x = ±1."},
      {"id":"q9","question":"Une asymptote oblique y = ax + b existe quand :","options":["deg(P) = deg(Q)","deg(P) = deg(Q) + 1","deg(P) < deg(Q)","deg(P) > deg(Q) + 1"],"correct":1,"explanation":"Pour f(x) = P(x)/Q(x), une asymptote oblique existe quand le degré du numérateur dépasse celui du dénominateur d''exactement 1."},
      {"id":"q10","question":"Le TVI affirme que si f continue sur [a,b] avec f(a)·f(b) < 0 :","options":["f est dérivable","f admet au moins un zéro dans ]a,b[","f est monotone","f est bornée"],"correct":1,"explanation":"Le théorème des valeurs intermédiaires garantit l''existence d''au moins un c ∈ ]a,b[ tel que f(c) = 0 quand f est continue et change de signe."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 5: Dénombrement
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'denombrement', 5, 'Dénombrement', 'Arrangements, combinaisons, permutations', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'denombrement-fiche', 'Dénombrement', 'Arrangements, combinaisons et permutations', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un arrangement ?","answer":"Un arrangement de p éléments parmi n est un choix ordonné de p éléments distincts parmi n. Aⁿₚ = n!/(n-p)! = n(n-1)(n-2)...(n-p+1). L''ordre compte. Exemple : A⁵₃ = 5×4×3 = 60. Application : de combien de façons peut-on attribuer 3 prix distincts à 5 candidats ? A⁵₃ = 60."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce qu''une permutation ?","answer":"Une permutation de n éléments est un arrangement de n éléments parmi n. Pn = n! = n(n-1)(n-2)...2×1. C''est le nombre de façons d''ordonner n éléments. Exemples : 3! = 6, 5! = 120, 10! = 3 628 800. Convention : 0! = 1. Les anagrammes d''un mot de n lettres distinctes : n!."},
      {"id":"fc3","category":"Formule","question":"Qu''est-ce qu''une combinaison ?","answer":"Une combinaison de p éléments parmi n est un choix non ordonné de p éléments distincts parmi n. Cⁿₚ = n!/((n-p)!·p!) = Aⁿₚ/p!. L''ordre ne compte pas. Propriétés : Cⁿ₀ = Cⁿₙ = 1, Cⁿ₁ = n, Cⁿₚ = Cⁿₙ₋ₚ. Exemple : C⁵₃ = 5!/(2!·3!) = 10. Application : choisir 3 personnes parmi 5 pour un comité."},
      {"id":"fc4","category":"Formule","question":"Énoncer la formule du binôme de Newton.","answer":"(a + b)ⁿ = Σ(k=0 à n) Cⁿₖ · aⁿ⁻ᵏ · bᵏ. Les coefficients Cⁿₖ forment le triangle de Pascal. Propriété : Cⁿ₊₁ₖ = Cⁿₖ₋₁ + Cⁿₖ. Cas particulier : (1 + x)ⁿ = Σ Cⁿₖ · xᵏ. Somme des coefficients : Σ Cⁿₖ = 2ⁿ."},
      {"id":"fc5","category":"Distinction","question":"Quand utiliser arrangement vs combinaison ?","answer":"Arrangement (ordre compte) : classement, attribution de prix différents, codes (1234 ≠ 4321). Combinaison (ordre ne compte pas) : comités, groupes, sélection d''équipe, tirage au loto. Question clé : si on permute les éléments choisis, obtient-on un résultat différent ? Oui → arrangement. Non → combinaison."},
      {"id":"fc6","category":"Méthode","question":"Comment résoudre un problème de dénombrement ?","answer":"1) Identifier s''il s''agit d''un tirage avec ou sans remise, ordonné ou non. 2) Avec remise + ordonné : nᵖ (p-uplets). 3) Sans remise + ordonné : Aⁿₚ (arrangements). 4) Sans remise + non ordonné : Cⁿₚ (combinaisons). 5) Avec remise + non ordonné : Cⁿ⁺ᵖ⁻¹ₚ. 6) Utiliser le principe multiplicatif ou additif selon le contexte."},
      {"id":"fc7","category":"Formule","question":"Énoncer le principe multiplicatif et le principe additif.","answer":"Principe multiplicatif : si un choix se décompose en étapes successives indépendantes avec n₁, n₂, ..., nk possibilités, le nombre total est n₁ × n₂ × ... × nk. Principe additif : si les choix sont exclusifs (disjoints), le nombre total est n₁ + n₂ + ... + nk."},
      {"id":"fc8","category":"Exemple","question":"De combien de façons peut-on former un comité de 3 personnes parmi 10 ?","answer":"L''ordre n''importe pas (comité), c''est une combinaison. C¹⁰₃ = 10!/(7!·3!) = (10×9×8)/(3×2×1) = 720/6 = 120 façons. Si on devait en plus désigner un président, un secrétaire et un trésorier parmi les 3, il faudrait multiplier par 3! = 6 : 120 × 6 = 720 (= A¹⁰₃)."},
      {"id":"fc9","category":"Exemple","question":"Combien de codes à 4 chiffres peut-on former avec les chiffres 0 à 9 ?","answer":"Avec remise (un chiffre peut être répété) : 10⁴ = 10 000 codes. Sans remise (chiffres distincts) : A¹⁰₄ = 10×9×8×7 = 5040 codes. Si le premier chiffre ne peut pas être 0 : avec remise : 9 × 10³ = 9000. Sans remise : 9 × 9 × 8 × 7 = 4536."},
      {"id":"fc10","category":"Formule","question":"Quelle est la relation entre arrangements, combinaisons et permutations ?","answer":"Aⁿₚ = Cⁿₚ × p! (un arrangement = un choix non ordonné × les ordres possibles). Pn = Aⁿₙ = n! (une permutation est un arrangement de tous les éléments). Cⁿₚ = Aⁿₚ/p! = n!/(p!(n-p)!). Ces trois formules sont fondamentalement liées."},
      {"id":"fc11","category":"Méthode","question":"Comment utiliser le triangle de Pascal ?","answer":"Le triangle de Pascal donne les coefficients binomiaux Cⁿₖ. Chaque nombre est la somme des deux nombres au-dessus : Cⁿ₊₁ₖ = Cⁿₖ₋₁ + Cⁿₖ. Ligne 0 : 1. Ligne 1 : 1 1. Ligne 2 : 1 2 1. Ligne 3 : 1 3 3 1. Ligne 4 : 1 4 6 4 1. Application : développer (a+b)⁴ = a⁴ + 4a³b + 6a²b² + 4ab³ + b⁴."},
      {"id":"fc12","category":"Exemple","question":"Au loto, on tire 5 numéros parmi 49. Combien de combinaisons possibles ?","answer":"C''est un tirage sans remise et non ordonné : C⁴⁹₅ = 49!/(44!·5!) = (49×48×47×46×45)/(5×4×3×2×1) = 1 906 884. Il y a donc presque 2 millions de combinaisons possibles. La probabilité de gagner avec un bulletin est 1/1 906 884 ≈ 5,24×10⁻⁷."}
    ],
    "schema": {
      "title": "Dénombrement",
      "nodes": [
        {"id":"n1","label":"Dénombrement","type":"main"},
        {"id":"n2","label":"Arrangements","type":"branch"},
        {"id":"n3","label":"Combinaisons","type":"branch"},
        {"id":"n4","label":"Outils","type":"branch"},
        {"id":"n5","label":"Aⁿₚ = n!/(n-p)!\nordonné","type":"leaf"},
        {"id":"n6","label":"Permutations\nPn = n!","type":"leaf"},
        {"id":"n7","label":"Cⁿₚ = n!/(p!(n-p)!)\nnon ordonné","type":"leaf"},
        {"id":"n8","label":"Binôme Newton\nTriangle Pascal","type":"leaf"},
        {"id":"n9","label":"Principes\nmultiplicatif/additif","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"ordre compte"},
        {"from":"n1","to":"n3","label":"ordre ne compte pas"},
        {"from":"n1","to":"n4","label":"méthodes"},
        {"from":"n2","to":"n5","label":"formule"},
        {"from":"n2","to":"n6","label":"cas p = n"},
        {"from":"n3","to":"n7","label":"formule"},
        {"from":"n3","to":"n8","label":"(a+b)ⁿ"},
        {"from":"n4","to":"n9","label":"règles de base"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le nombre de permutations de 4 éléments est :","options":["4","12","24","64"],"correct":2,"explanation":"P₄ = 4! = 4×3×2×1 = 24. C''est le nombre de façons d''ordonner 4 éléments."},
      {"id":"q2","question":"C⁵₂ vaut :","options":["5","10","20","25"],"correct":1,"explanation":"C⁵₂ = 5!/(3!·2!) = (5×4)/(2×1) = 10. C''est le nombre de façons de choisir 2 éléments parmi 5 sans tenir compte de l''ordre."},
      {"id":"q3","question":"A⁵₃ vaut :","options":["10","20","60","120"],"correct":2,"explanation":"A⁵₃ = 5×4×3 = 60. C''est le nombre de façons de choisir et ordonner 3 éléments parmi 5."},
      {"id":"q4","question":"Le principe multiplicatif s''applique quand les choix sont :","options":["Exclusifs","Successifs et indépendants","Identiques","Aléatoires"],"correct":1,"explanation":"Le principe multiplicatif s''applique quand les choix sont successifs et indépendants : le nombre total est le produit des possibilités à chaque étape."},
      {"id":"q5","question":"Dans le binôme de Newton, le coefficient de a²b³ dans (a+b)⁵ est :","options":["5","10","20","1"],"correct":1,"explanation":"Le coefficient est C⁵₃ = C⁵₂ = 10. (a+b)⁵ = a⁵ + 5a⁴b + 10a³b² + 10a²b³ + 5ab⁴ + b⁵."},
      {"id":"q6","question":"0! vaut :","options":["0","1","Indéfini","∞"],"correct":1,"explanation":"Par convention, 0! = 1. C''est nécessaire pour que les formules de combinaisons soient cohérentes : Cⁿ₀ = n!/(n!·0!) = 1."},
      {"id":"q7","question":"Cⁿₚ = Cⁿₙ₋ₚ signifie que :","options":["Choisir p éléments revient à exclure n-p éléments","Les combinaisons sont toujours paires","p = n - p","L''ordre importe"],"correct":0,"explanation":"Choisir p éléments parmi n revient à choisir les n-p éléments qu''on ne prend pas. C''est la propriété de symétrie des combinaisons."},
      {"id":"q8","question":"Combien de mots de 3 lettres distinctes peut-on former avec l''alphabet (26 lettres) ?","options":["26³","26×25×24","C²⁶₃","26!"],"correct":1,"explanation":"C''est un arrangement (l''ordre des lettres compte, lettres distinctes) : A²⁶₃ = 26×25×24 = 15 600."},
      {"id":"q9","question":"La somme de tous les coefficients binomiaux de la ligne n du triangle de Pascal vaut :","options":["n","n²","2ⁿ","n!"],"correct":2,"explanation":"Σ(k=0 à n) Cⁿₖ = 2ⁿ. C''est obtenu en posant a = b = 1 dans (a+b)ⁿ : (1+1)ⁿ = 2ⁿ."},
      {"id":"q10","question":"La relation Aⁿₚ = Cⁿₚ × p! signifie que :","options":["Arrangement = combinaison × ordres possibles","Combinaison = arrangement × ordres","Permutation = arrangement + combinaison","Aucune relation"],"correct":0,"explanation":"Un arrangement correspond à un choix non ordonné (combinaison) suivi d''un ordonnancement (p! permutations). Donc Aⁿₚ = Cⁿₚ × p!."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 6: Statistiques à deux caractères
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'statistiques-deux-caracteres', 6, 'Statistiques à deux caractères', 'Nuage de points, moindres carrés', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'statistiques-deux-caracteres-fiche', 'Statistiques à deux caractères', 'Corrélation linéaire et droite des moindres carrés', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une série statistique à deux caractères ?","answer":"Une série à deux caractères (ou double) étudie simultanément deux variables x et y sur n individus. On obtient n couples (xi, yi). Le nuage de points est la représentation graphique de ces couples dans un repère. On cherche à déterminer s''il existe une relation (corrélation) entre x et y, et à la modéliser (ajustement)."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce que le point moyen G et comment le calculer ?","answer":"Le point moyen G(x̄, ȳ) a pour coordonnées les moyennes de x et y : x̄ = (Σxi)/n et ȳ = (Σyi)/n. G est toujours sur la droite de régression. Il représente le centre de gravité du nuage de points. Propriété : la droite de régression passe par G."},
      {"id":"fc3","category":"Formule","question":"Qu''est-ce que le coefficient de corrélation linéaire r ?","answer":"r = cov(x,y)/(σx·σy) où cov(x,y) = (Σxiyi)/n - x̄·ȳ. r est compris entre -1 et 1. |r| proche de 1 : forte corrélation linéaire. |r| proche de 0 : pas de corrélation linéaire. r > 0 : corrélation positive (y augmente avec x). r < 0 : corrélation négative."},
      {"id":"fc4","category":"Formule","question":"Comment déterminer la droite de régression par la méthode des moindres carrés ?","answer":"La droite de régression de y en x est y = ax + b avec : a = cov(x,y)/V(x) = (Σxiyi/n - x̄ȳ)/(Σxi²/n - x̄²) et b = ȳ - a·x̄. Cette droite minimise la somme des carrés des écarts verticaux entre les points et la droite : Σ(yi - axi - b)² est minimale."},
      {"id":"fc5","category":"Méthode","question":"Comment ajuster un nuage de points non linéaire ?","answer":"Si le nuage ne suit pas une droite, on peut tenter un changement de variable : 1) Exponentiel y = ae^(bx) → ln(y) = ln(a) + bx (ajustement affine de ln(y) en x). 2) Puissance y = axᵇ → ln(y) = ln(a) + b·ln(x). 3) Logarithmique y = a·ln(x) + b (ajustement affine de y en ln(x)). Choisir le modèle donnant le meilleur r."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la covariance et la variance ?","answer":"Variance : V(x) = σx² = (Σxi²)/n - x̄² = (Σ(xi - x̄)²)/n. Mesure la dispersion de x. Écart-type : σx = √V(x). Covariance : cov(x,y) = (Σxiyi)/n - x̄·ȳ = (Σ(xi-x̄)(yi-ȳ))/n. Mesure la liaison linéaire entre x et y. Si cov > 0 : tendance à varier dans le même sens."},
      {"id":"fc7","category":"Méthode","question":"Comment utiliser la droite de régression pour faire des prévisions ?","answer":"1) Vérifier que |r| est proche de 1 (ajustement linéaire pertinent). 2) Calculer la droite y = ax + b. 3) Pour prédire y connaissant x : substituer x dans l''équation. 4) Interpolation (x dans la plage des données) : fiable. Extrapolation (x hors de la plage) : moins fiable, à utiliser avec prudence."},
      {"id":"fc8","category":"Exemple","question":"Calculer le coefficient directeur a de la droite de régression avec les données suivantes : Σxi = 15, Σyi = 25, Σxiyi = 95, Σxi² = 55, n = 5.","answer":"x̄ = 15/5 = 3, ȳ = 25/5 = 5. cov(x,y) = 95/5 - 3×5 = 19 - 15 = 4. V(x) = 55/5 - 3² = 11 - 9 = 2. a = cov/V(x) = 4/2 = 2. b = ȳ - a·x̄ = 5 - 2×3 = -1. Droite : y = 2x - 1."},
      {"id":"fc9","category":"Distinction","question":"Quelle est la différence entre corrélation et causalité ?","answer":"Corrélation : deux variables évoluent ensemble (mesurée par r). Causalité : une variable cause le changement de l''autre. Corrélation ≠ causalité ! Exemple : la vente de glaces et les noyades sont corrélées (toutes deux augmentent en été), mais les glaces ne causent pas les noyades (variable cachée : la chaleur)."},
      {"id":"fc10","category":"Formule","question":"Quelles sont les propriétés du coefficient de corrélation ?","answer":"-1 ≤ r ≤ 1. r = 1 : corrélation positive parfaite (points alignés, pente positive). r = -1 : corrélation négative parfaite. r = 0 : absence de corrélation linéaire (mais il peut y avoir une relation non linéaire). r² est le coefficient de détermination : il donne la proportion de la variance de y expliquée par x."},
      {"id":"fc11","category":"Méthode","question":"Comment calculer r avec la calculatrice ?","answer":"Mode statistique à deux variables (STAT ou REG). 1) Entrer les couples (xi, yi). 2) La calculatrice donne directement : x̄, ȳ, σx, σy, a, b, r. 3) Vérifier |r| : si |r| > 0,87 (r² > 0,75), l''ajustement linéaire est acceptable. 4) La droite y = ax + b est directement disponible."},
      {"id":"fc12","category":"Distinction","question":"Quand utiliser la droite de y en x ou de x en y ?","answer":"Droite de y en x (y = ax + b) : pour prédire y connaissant x (minimise les écarts verticaux). Droite de x en y (x = a''y + b'') : pour prédire x connaissant y (minimise les écarts horizontaux). Les deux droites ne coïncident que si r = ±1. Elles se coupent toujours au point moyen G."}
    ],
    "schema": {
      "title": "Statistiques à deux caractères",
      "nodes": [
        {"id":"n1","label":"Statistiques\ndoubles","type":"main"},
        {"id":"n2","label":"Nuage de\npoints","type":"branch"},
        {"id":"n3","label":"Corrélation","type":"branch"},
        {"id":"n4","label":"Régression","type":"branch"},
        {"id":"n5","label":"Point moyen G\n(x̄, ȳ)","type":"leaf"},
        {"id":"n6","label":"r = cov/(σxσy)\n-1 ≤ r ≤ 1","type":"leaf"},
        {"id":"n7","label":"y = ax + b\nmoindres carrés","type":"leaf"},
        {"id":"n8","label":"Changement\nde variable","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"représentation"},
        {"from":"n1","to":"n3","label":"liaison"},
        {"from":"n1","to":"n4","label":"modélisation"},
        {"from":"n2","to":"n5","label":"centre"},
        {"from":"n3","to":"n6","label":"coefficient"},
        {"from":"n4","to":"n7","label":"linéaire"},
        {"from":"n4","to":"n8","label":"non linéaire"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le coefficient de corrélation r est compris entre :","options":["0 et 1","-1 et 1","0 et +∞","-∞ et +∞"],"correct":1,"explanation":"-1 ≤ r ≤ 1. r = 1 : corrélation positive parfaite. r = -1 : corrélation négative parfaite. r = 0 : pas de corrélation linéaire."},
      {"id":"q2","question":"La droite de régression passe toujours par :","options":["L''origine","Le point (1, 1)","Le point moyen G(x̄, ȳ)","Le point (0, b)"],"correct":2,"explanation":"La droite de régression y = ax + b passe toujours par le point moyen G(x̄, ȳ) car b = ȳ - a·x̄."},
      {"id":"q3","question":"Le coefficient directeur a de la droite de régression de y en x est :","options":["a = V(x)/cov(x,y)","a = cov(x,y)/V(x)","a = σx/σy","a = r"],"correct":1,"explanation":"a = cov(x,y)/V(x). Le coefficient directeur est le rapport de la covariance à la variance de x."},
      {"id":"q4","question":"Si r = -0,95, la corrélation est :","options":["Faible et positive","Forte et positive","Faible et négative","Forte et négative"],"correct":3,"explanation":"|r| = 0,95 est proche de 1 : corrélation forte. r < 0 : corrélation négative (y diminue quand x augmente)."},
      {"id":"q5","question":"La covariance mesure :","options":["La dispersion d''une variable","La liaison linéaire entre deux variables","La moyenne des produits","Le carré de r"],"correct":1,"explanation":"La covariance cov(x,y) mesure la tendance de x et y à varier ensemble. Positive si elles varient dans le même sens, négative sinon."},
      {"id":"q6","question":"Pour un ajustement exponentiel y = ae^(bx), on effectue le changement :","options":["X = ln(x)","Y = ln(y)","X = x², Y = y²","X = 1/x"],"correct":1,"explanation":"En posant Y = ln(y) : ln(y) = ln(a) + bx, soit Y = bx + ln(a). L''ajustement de Y en x est linéaire."},
      {"id":"q7","question":"r² = 0,81 signifie que :","options":["81% de la variance de y est expliquée par x","r = 0,81","La corrélation est faible","L''ajustement est parfait"],"correct":0,"explanation":"r² est le coefficient de détermination. r² = 0,81 signifie que 81% de la variabilité de y est expliquée par la relation linéaire avec x. r = 0,9 ou -0,9."},
      {"id":"q8","question":"L''extrapolation est :","options":["Toujours fiable","Moins fiable que l''interpolation","Impossible","Plus précise que l''interpolation"],"correct":1,"explanation":"L''extrapolation (prédiction en dehors de la plage des données) est moins fiable que l''interpolation car on suppose que la relation observée se prolonge."},
      {"id":"q9","question":"Corrélation forte implique-t-elle causalité ?","options":["Oui toujours","Non, corrélation ≠ causalité","Oui si r > 0,9","Seulement pour r = 1"],"correct":1,"explanation":"Une forte corrélation ne signifie pas qu''une variable cause l''autre. Il peut y avoir une variable cachée (confondante) ou une coïncidence."},
      {"id":"q10","question":"La variance V(x) est toujours :","options":["Positive ou nulle","Négative","Comprise entre -1 et 1","Égale à la moyenne"],"correct":0,"explanation":"V(x) = Σ(xi - x̄)²/n ≥ 0. La variance est toujours positive ou nulle (nulle si tous les xi sont identiques). L''écart-type σ = √V(x)."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 7: Probabilités
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'probabilites', 7, 'Probabilités', 'Conditionnelle, variable aléatoire, loi binomiale', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'probabilites-fiche', 'Probabilités', 'Probabilités conditionnelles, variables aléatoires et loi binomiale', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une probabilité et ses axiomes ?","answer":"La probabilité P(A) d''un événement A est un nombre entre 0 et 1 mesurant sa chance de se réaliser. Axiomes de Kolmogorov : 1) 0 ≤ P(A) ≤ 1. 2) P(Ω) = 1 (événement certain). 3) Si A et B incompatibles : P(A∪B) = P(A) + P(B). Équiprobabilité : P(A) = card(A)/card(Ω)."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce qu''une probabilité conditionnelle ?","answer":"P(B|A) = P(A∩B)/P(A) est la probabilité de B sachant que A est réalisé (P(A) > 0). Formule des probabilités composées : P(A∩B) = P(A) × P(B|A) = P(B) × P(A|B). Deux événements sont indépendants si P(A∩B) = P(A) × P(B), soit P(B|A) = P(B)."},
      {"id":"fc3","category":"Formule","question":"Énoncer la formule des probabilités totales.","answer":"Si B₁, B₂, ..., Bn forment une partition de Ω (union = Ω, deux à deux incompatibles), alors pour tout événement A : P(A) = Σ P(Bi) × P(A|Bi). C''est utile quand on connaît P(A|Bi) mais pas P(A) directement. Application fréquente avec les arbres de probabilité."},
      {"id":"fc4","category":"Formule","question":"Énoncer la formule de Bayes.","answer":"P(Bk|A) = P(Bk) × P(A|Bk) / P(A) = P(Bk) × P(A|Bk) / (Σ P(Bi) × P(A|Bi)). Elle permet de « retourner » le conditionnement : connaissant P(A|B), on calcule P(B|A). Application : diagnostic médical (probabilité d''être malade sachant que le test est positif)."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce qu''une variable aléatoire discrète ?","answer":"Une variable aléatoire X est une fonction qui associe un nombre réel à chaque résultat d''une expérience aléatoire. Sa loi de probabilité donne P(X = xi) pour chaque valeur xi. Espérance : E(X) = Σ xi·P(X=xi) (valeur moyenne). Variance : V(X) = E(X²) - (E(X))² = Σ xi²·P(X=xi) - (E(X))². Écart-type : σ = √V(X)."},
      {"id":"fc6","category":"Formule","question":"Qu''est-ce que la loi binomiale ?","answer":"X suit une loi binomiale B(n,p) si X compte le nombre de succès dans n épreuves de Bernoulli indépendantes de probabilité p. P(X = k) = Cⁿₖ × pᵏ × (1-p)ⁿ⁻ᵏ pour k = 0, 1, ..., n. E(X) = np. V(X) = np(1-p). σ = √(np(1-p))."},
      {"id":"fc7","category":"Méthode","question":"Comment construire un arbre de probabilité ?","answer":"1) Chaque nœud représente un événement. 2) Les branches partant d''un nœud correspondent aux issues possibles. 3) La somme des probabilités des branches partant d''un nœud = 1. 4) La probabilité d''un chemin = produit des probabilités le long du chemin. 5) P(A) = somme des probabilités de tous les chemins menant à A."},
      {"id":"fc8","category":"Distinction","question":"Quelle est la différence entre événements indépendants et incompatibles ?","answer":"Indépendants : la réalisation de l''un n''influence pas la probabilité de l''autre. P(A∩B) = P(A)×P(B). Ils peuvent se réaliser simultanément. Incompatibles (mutuellement exclusifs) : A et B ne peuvent pas se réaliser en même temps. P(A∩B) = 0. P(A∪B) = P(A) + P(B). Attention : indépendant ≠ incompatible !"},
      {"id":"fc9","category":"Exemple","question":"On lance un dé 3 fois. Quelle est la probabilité d''obtenir exactement 2 six ?","answer":"X = nombre de 6 suit B(3, 1/6). P(X=2) = C³₂ × (1/6)² × (5/6)¹ = 3 × 1/36 × 5/6 = 15/216 ≈ 0,069 = 6,9%. On utilise la loi binomiale car il y a 3 épreuves indépendantes (lancers) avec probabilité de succès p = 1/6."},
      {"id":"fc10","category":"Formule","question":"Propriétés de l''espérance et de la variance.","answer":"Espérance : E(aX + b) = aE(X) + b. E(X + Y) = E(X) + E(Y) (toujours). Variance : V(aX + b) = a²V(X). Si X et Y indépendants : V(X + Y) = V(X) + V(Y). Attention : V(X + Y) ≠ V(X) + V(Y) en général (sauf indépendance)."},
      {"id":"fc11","category":"Méthode","question":"Comment reconnaître une situation de loi binomiale ?","answer":"La loi binomiale B(n,p) s''applique si : 1) L''expérience est répétée n fois. 2) Chaque épreuve a deux issues : succès (p) ou échec (1-p). 3) Les épreuves sont indépendantes. 4) La probabilité p est constante. Si une de ces conditions n''est pas vérifiée (ex : tirage sans remise), ce n''est pas une loi binomiale."},
      {"id":"fc12","category":"Exemple","question":"Un QCM a 10 questions à 4 choix. Si on répond au hasard, quelle est la note espérée ?","answer":"X = nombre de bonnes réponses suit B(10, 1/4). E(X) = np = 10 × 1/4 = 2,5. En moyenne, on obtient 2,5 bonnes réponses sur 10 en répondant au hasard. σ = √(np(1-p)) = √(10 × 1/4 × 3/4) = √(1,875) ≈ 1,37. P(X ≥ 5) = 1 - P(X ≤ 4) ≈ 0,078 (7,8% de chance d''avoir la moyenne au hasard)."}
    ],
    "schema": {
      "title": "Probabilités",
      "nodes": [
        {"id":"n1","label":"Probabilités","type":"main"},
        {"id":"n2","label":"Conditionnelles","type":"branch"},
        {"id":"n3","label":"Variables\naléatoires","type":"branch"},
        {"id":"n4","label":"Loi binomiale","type":"branch"},
        {"id":"n5","label":"P(B|A) = P(A∩B)/P(A)\nBayes","type":"leaf"},
        {"id":"n6","label":"Formule des\nprobabilités totales","type":"leaf"},
        {"id":"n7","label":"E(X), V(X)\nσ(X)","type":"leaf"},
        {"id":"n8","label":"B(n,p)\nP(X=k) = Cⁿₖpᵏ(1-p)ⁿ⁻ᵏ","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"sachant que"},
        {"from":"n1","to":"n3","label":"X : Ω → ℝ"},
        {"from":"n1","to":"n4","label":"n épreuves"},
        {"from":"n2","to":"n5","label":"formules"},
        {"from":"n2","to":"n6","label":"partition"},
        {"from":"n3","to":"n7","label":"caractéristiques"},
        {"from":"n4","to":"n8","label":"formule"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"P(A∪B) pour A et B incompatibles vaut :","options":["P(A) × P(B)","P(A) + P(B)","P(A) + P(B) - P(A∩B)","1"],"correct":1,"explanation":"Si A et B sont incompatibles (A∩B = ∅), P(A∪B) = P(A) + P(B). C''est le 3e axiome de Kolmogorov."},
      {"id":"q2","question":"Deux événements sont indépendants si :","options":["P(A∩B) = 0","P(A∩B) = P(A) × P(B)","P(A) = P(B)","P(A∪B) = 1"],"correct":1,"explanation":"A et B sont indépendants si P(A∩B) = P(A) × P(B), ce qui équivaut à P(B|A) = P(B)."},
      {"id":"q3","question":"E(X) pour X ~ B(20, 0,3) vaut :","options":["3","6","14","20"],"correct":1,"explanation":"E(X) = np = 20 × 0,3 = 6. L''espérance de la loi binomiale est le produit du nombre d''épreuves par la probabilité de succès."},
      {"id":"q4","question":"P(X = k) pour X ~ B(n,p) est donné par :","options":["Cⁿₖ × pⁿ × (1-p)ᵏ","Cⁿₖ × pᵏ × (1-p)ⁿ⁻ᵏ","pᵏ × (1-p)ⁿ⁻ᵏ","n × pᵏ"],"correct":1,"explanation":"P(X = k) = Cⁿₖ × pᵏ × (1-p)ⁿ⁻ᵏ. Le terme Cⁿₖ compte le nombre de façons de placer k succès parmi n épreuves."},
      {"id":"q5","question":"La formule de Bayes permet de calculer :","options":["P(A∪B)","P(B|A) à partir de P(A|B)","P(A) × P(B)","La variance"],"correct":1,"explanation":"La formule de Bayes « retourne » le conditionnement : P(B|A) = P(B)×P(A|B)/P(A)."},
      {"id":"q6","question":"V(2X + 3) = ","options":["2V(X) + 3","4V(X)","4V(X) + 3","2V(X) + 9"],"correct":1,"explanation":"V(aX + b) = a²V(X). Donc V(2X + 3) = 4V(X). La constante additive n''affecte pas la variance."},
      {"id":"q7","question":"Dans un arbre de probabilité, la probabilité d''un chemin est :","options":["La somme des branches","Le produit des branches","La moyenne des branches","La dernière branche"],"correct":1,"explanation":"La probabilité d''un chemin est le produit des probabilités sur chaque branche du chemin (probabilités composées)."},
      {"id":"q8","question":"La loi binomiale nécessite que les épreuves soient :","options":["Dépendantes","Indépendantes et de même probabilité","De probabilités variables","Sans remise"],"correct":1,"explanation":"Pour appliquer la loi binomiale, les épreuves doivent être indépendantes et de même probabilité de succès p à chaque épreuve."},
      {"id":"q9","question":"E(X + Y) = ","options":["E(X) × E(Y)","E(X) + E(Y)","E(X) - E(Y)","Max(E(X), E(Y))"],"correct":1,"explanation":"E(X + Y) = E(X) + E(Y) toujours, que X et Y soient indépendants ou non. C''est la linéarité de l''espérance."},
      {"id":"q10","question":"σ(X) pour X ~ B(10, 0,5) vaut :","options":["2,5","√2,5","5","√5"],"correct":1,"explanation":"V(X) = np(1-p) = 10 × 0,5 × 0,5 = 2,5. σ(X) = √V(X) = √2,5 ≈ 1,58."}
    ]
  }');

  -- ============================================================
  -- MATHS - CHAPTER 8: Algèbre linéaire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'algebre-lineaire', 8, 'Algèbre linéaire', 'Systèmes, matrices', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'algebre-lineaire-fiche', 'Algèbre linéaire', 'Systèmes d''équations linéaires et calcul matriciel', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un système d''équations linéaires ?","answer":"Un système linéaire est un ensemble d''équations du 1er degré en plusieurs inconnues. Forme générale (2×2) : a₁x + b₁y = c₁ et a₂x + b₂y = c₂. Solutions possibles : unique (droites sécantes), infinité (droites confondues), aucune (droites parallèles). Le déterminant D = a₁b₂ - a₂b₁ : si D ≠ 0, solution unique."},
      {"id":"fc2","category":"Formule","question":"Qu''est-ce qu''une matrice et les opérations de base ?","answer":"Une matrice A de taille m×n est un tableau de m lignes et n colonnes. Addition : (A+B)ij = aij + bij (même taille). Multiplication par un scalaire : (λA)ij = λ·aij. Multiplication matricielle : (AB)ij = Σk aik·bkj. Attention : AB ≠ BA en général (non commutative). La matrice identité I vérifie AI = IA = A."},
      {"id":"fc3","category":"Formule","question":"Comment résoudre un système 2×2 par la méthode de Cramer ?","answer":"Système : a₁x + b₁y = c₁, a₂x + b₂y = c₂. D = a₁b₂ - a₂b₁. Si D ≠ 0 : x = (c₁b₂ - c₂b₁)/D, y = (a₁c₂ - a₂c₁)/D. C''est la méthode des déterminants de Cramer. Exemple : 2x + 3y = 8, x - y = 1. D = -2-3 = -5, x = (-8-3)/(-5) = 11/(-5)... On utilise D = 2(-1)-3(1) = -5, Dx = 8(-1)-3(1) = -11, x = 11/5."},
      {"id":"fc4","category":"Formule","question":"Comment calculer le déterminant d''une matrice 2×2 et 3×3 ?","answer":"Matrice 2×2 : det(A) = ad - bc pour A = [[a,b],[c,d]]. Matrice 3×3 (règle de Sarrus) : développer selon la première ligne : det = a₁₁(a₂₂a₃₃-a₂₃a₃₂) - a₁₂(a₂₁a₃₃-a₂₃a₃₁) + a₁₃(a₂₁a₃₂-a₂₂a₃₁). Si det ≠ 0, la matrice est inversible."},
      {"id":"fc5","category":"Formule","question":"Qu''est-ce que la matrice inverse ?","answer":"A⁻¹ est la matrice inverse de A si A·A⁻¹ = A⁻¹·A = I. Elle existe si det(A) ≠ 0. Pour une matrice 2×2 A = [[a,b],[c,d]] : A⁻¹ = (1/det(A))·[[d,-b],[-c,a]]. Application : résoudre AX = B donne X = A⁻¹B."},
      {"id":"fc6","category":"Méthode","question":"Comment résoudre un système par la méthode de Gauss ?","answer":"1) Écrire la matrice augmentée [A|B]. 2) Par opérations élémentaires sur les lignes (Li ← Li + λLj), transformer en forme échelonnée (triangulaire). 3) Résoudre de bas en haut par substitution. Opérations autorisées : échanger deux lignes, multiplier une ligne par un scalaire non nul, ajouter un multiple d''une ligne à une autre."},
      {"id":"fc7","category":"Formule","question":"Quelles sont les propriétés du produit matriciel ?","answer":"Associativité : (AB)C = A(BC). Distributivité : A(B+C) = AB + AC. Non commutativité : AB ≠ BA en général. Élément neutre : AI = IA = A. Transposée : (AB)ᵀ = BᵀAᵀ. Déterminant : det(AB) = det(A)·det(B). Inverse : (AB)⁻¹ = B⁻¹A⁻¹."},
      {"id":"fc8","category":"Exemple","question":"Résoudre le système : 2x + y = 5, 3x - 2y = 4.","answer":"D = 2(-2) - 1(3) = -4 - 3 = -7 ≠ 0. Solution unique. x = (5(-2) - 4(1))/(-7) = (-10 - 4)/(-7) = -14/(-7) = 2. y = (2(4) - 3(5))/(-7) = (8 - 15)/(-7) = -7/(-7) = 1. Solution : x = 2, y = 1. Vérification : 2(2)+1 = 5 ✓, 3(2)-2(1) = 4 ✓."},
      {"id":"fc9","category":"Distinction","question":"Quels sont les types de solutions d''un système linéaire ?","answer":"Soit un système de n équations à n inconnues de matrice A. Si det(A) ≠ 0 : solution unique (système de Cramer). Si det(A) = 0 : soit aucune solution (système incompatible), soit une infinité de solutions (système indéterminé). Pour un système 2×2 : D = 0 signifie droites parallèles (incompatible) ou confondues (infinité)."},
      {"id":"fc10","category":"Formule","question":"Comment multiplier deux matrices 2×2 ?","answer":"Si A = [[a,b],[c,d]] et B = [[e,f],[g,h]], alors AB = [[ae+bg, af+bh],[ce+dg, cf+dh]]. Chaque élément (AB)ij est le produit scalaire de la ligne i de A par la colonne j de B. Condition : le nombre de colonnes de A doit égaler le nombre de lignes de B."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que la transposée d''une matrice ?","answer":"La transposée Aᵀ s''obtient en échangeant lignes et colonnes de A : (Aᵀ)ij = Aji. Si A est m×n, Aᵀ est n×m. Propriétés : (Aᵀ)ᵀ = A, (A+B)ᵀ = Aᵀ+Bᵀ, (λA)ᵀ = λAᵀ, (AB)ᵀ = BᵀAᵀ. Une matrice symétrique vérifie Aᵀ = A."},
      {"id":"fc12","category":"Méthode","question":"Comment utiliser les matrices pour résoudre un problème économique ?","answer":"Modèle de Leontief (entrées-sorties) : X = AX + D, où X est le vecteur de production, A la matrice des coefficients techniques, D la demande finale. Solution : X = (I - A)⁻¹D si (I - A) est inversible. Les matrices modélisent les interdépendances entre secteurs économiques."}
    ],
    "schema": {
      "title": "Algèbre linéaire",
      "nodes": [
        {"id":"n1","label":"Algèbre\nlinéaire","type":"main"},
        {"id":"n2","label":"Systèmes","type":"branch"},
        {"id":"n3","label":"Matrices","type":"branch"},
        {"id":"n4","label":"Déterminant","type":"branch"},
        {"id":"n5","label":"Cramer\nGauss","type":"leaf"},
        {"id":"n6","label":"Opérations\nA+B, λA, AB","type":"leaf"},
        {"id":"n7","label":"Inverse A⁻¹\nAX = B → X = A⁻¹B","type":"leaf"},
        {"id":"n8","label":"det(A)\nSarrus","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"résolution"},
        {"from":"n1","to":"n3","label":"calcul"},
        {"from":"n1","to":"n4","label":"condition"},
        {"from":"n2","to":"n5","label":"méthodes"},
        {"from":"n3","to":"n6","label":"base"},
        {"from":"n3","to":"n7","label":"inversion"},
        {"from":"n4","to":"n8","label":"calcul"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le déterminant de la matrice [[3,1],[2,4]] est :","options":["10","12","14","5"],"correct":0,"explanation":"det = 3×4 - 1×2 = 12 - 2 = 10."},
      {"id":"q2","question":"Un système de Cramer a une solution unique si :","options":["D = 0","D ≠ 0","D > 0","D < 0"],"correct":1,"explanation":"Un système de Cramer (n équations, n inconnues) a une solution unique si le déterminant D ≠ 0."},
      {"id":"q3","question":"Le produit matriciel est :","options":["Toujours commutatif","Jamais commutatif","Non commutatif en général","Commutatif si les matrices sont carrées"],"correct":2,"explanation":"En général AB ≠ BA. Le produit matriciel n''est pas commutatif, sauf dans des cas particuliers (matrices diagonales, multiples de I, etc.)."},
      {"id":"q4","question":"L''inverse de A = [[2,1],[5,3]] est :","options":["[[3,-1],[-5,2]]","[[3,1],[5,2]]","[[-3,1],[5,-2]]","N''existe pas"],"correct":0,"explanation":"det(A) = 6-5 = 1. A⁻¹ = (1/1)[[3,-1],[-5,2]] = [[3,-1],[-5,2]]. Vérification : AA⁻¹ = I."},
      {"id":"q5","question":"La méthode de Gauss utilise des opérations élémentaires sur :","options":["Les colonnes","Les lignes","Les déterminants","Les inverses"],"correct":1,"explanation":"La méthode de Gauss transforme le système en forme échelonnée par des opérations élémentaires sur les lignes de la matrice augmentée."},
      {"id":"q6","question":"(AB)ᵀ = ","options":["AᵀBᵀ","BᵀAᵀ","(AB)","Aᵀ + Bᵀ"],"correct":1,"explanation":"La transposée d''un produit inverse l''ordre : (AB)ᵀ = BᵀAᵀ."},
      {"id":"q7","question":"det(AB) = ","options":["det(A) + det(B)","det(A) × det(B)","det(A) - det(B)","det(A)/det(B)"],"correct":1,"explanation":"Le déterminant d''un produit est le produit des déterminants : det(AB) = det(A) × det(B)."},
      {"id":"q8","question":"AX = B a pour solution X = ","options":["A⁻¹B","BA⁻¹","AB⁻¹","B/A"],"correct":0,"explanation":"En multipliant à gauche par A⁻¹ : A⁻¹AX = A⁻¹B, donc IX = A⁻¹B, soit X = A⁻¹B (si A est inversible)."},
      {"id":"q9","question":"La matrice identité I vérifie :","options":["AI = 0","AI = A + I","AI = IA = A","AI = A²"],"correct":2,"explanation":"La matrice identité I est l''élément neutre de la multiplication : AI = IA = A pour toute matrice carrée A."},
      {"id":"q10","question":"Si det(A) = 0, la matrice A est :","options":["Inversible","Singulière (non inversible)","Symétrique","Diagonale"],"correct":1,"explanation":"Si det(A) = 0, la matrice est singulière : elle n''a pas d''inverse. Le système AX = B peut avoir 0 ou une infinité de solutions."}
    ]
  }');

-- ================================================
-- SVT (8 chapitres) – 10 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : Profils topographiques et coupes géologiques (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'profils-topographiques', 1, 'Profils topographiques et coupes géologiques', 'Réalisation et interprétation de profils topographiques et de coupes géologiques.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'profils-topographiques-fiche', 'Profils topographiques et coupes géologiques', 'Lecture de carte, tracé et interprétation', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce qu''un profil topographique ?","verso":"C''est une coupe verticale du relief le long d''une ligne tracée sur une carte topographique. Il montre les variations d''altitude.","category":"Définition"},
    {"id":"f2","recto":"Comment tracer un profil topographique ?","verso":"1) Tracer la ligne de coupe sur la carte. 2) Reporter chaque courbe de niveau sur un papier millimétré. 3) Relier les points pour obtenir le profil.","category":"Méthode"},
    {"id":"f3","recto":"Qu''est-ce qu''une courbe de niveau ?","verso":"Ligne imaginaire joignant tous les points situés à la même altitude. L''écart entre deux courbes successives est l''équidistance.","category":"Définition"},
    {"id":"f4","recto":"Qu''indiquent des courbes de niveau resserrées ?","verso":"Des courbes resserrées indiquent une pente forte (terrain escarpé). Des courbes espacées indiquent une pente douce.","category":"Méthode"},
    {"id":"f5","recto":"Qu''est-ce qu''une coupe géologique ?","verso":"Représentation verticale de la structure interne de la Terre le long d''un tracé. Elle montre la disposition des couches (strates), failles et plis.","category":"Définition"},
    {"id":"f6","recto":"Quelle est la différence entre un profil topographique et une coupe géologique ?","verso":"Le profil topographique montre seulement le relief de surface. La coupe géologique montre aussi la structure interne (couches, failles, plis).","category":"Distinction"},
    {"id":"f7","recto":"Qu''est-ce que l''exagération verticale ?","verso":"Rapport entre l''échelle verticale et l''échelle horizontale d''un profil. Elle accentue le relief pour mieux visualiser les variations d''altitude.","category":"Définition"},
    {"id":"f8","recto":"Comment reconnaître un anticlinal et un synclinal sur une coupe ?","verso":"Anticlinal : pli convexe vers le haut, les couches les plus anciennes sont au cœur. Synclinal : pli concave, les couches les plus jeunes sont au cœur.","category":"Distinction"},
    {"id":"f9","recto":"Qu''est-ce qu''une faille sur une coupe géologique ?","verso":"Cassure de terrain avec déplacement relatif des blocs. Faille normale (extension), faille inverse (compression), décrochement (coulissement horizontal).","category":"Définition"},
    {"id":"f10","recto":"Comment déterminer le pendage d''une couche ?","verso":"Le pendage est l''angle d''inclinaison d''une couche par rapport à l''horizontale. On le détermine par le symbole en T sur la carte : le trait long indique la direction, le court le sens du pendage.","category":"Méthode"}
  ],
  "schema": {
    "title": "Profils topographiques et coupes géologiques",
    "nodes": [
      {"id":"n1","label":"Cartographie géologique","type":"main","x":400,"y":50},
      {"id":"n2","label":"Profil topographique","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Coupe géologique","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Courbes de niveau","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Échelle et exagération","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Structures (plis, failles)","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Stratigraphie","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Pendage et direction","type":"leaf","x":750,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"relief"},
      {"from":"n1","to":"n3","label":"structure interne"},
      {"from":"n2","to":"n4","label":"lecture"},
      {"from":"n2","to":"n5","label":"tracé"},
      {"from":"n3","to":"n6","label":"déformation"},
      {"from":"n3","to":"n7","label":"couches"},
      {"from":"n3","to":"n8","label":"orientation"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Des courbes de niveau resserrées indiquent :","options":["Une pente douce","Une pente forte","Un plateau","Une vallée"],"correct":1,"explanation":"Plus les courbes de niveau sont resserrées, plus la pente est forte (terrain escarpé)."},
    {"id":"q2","question":"L''équidistance est :","options":["La distance horizontale entre deux points","L''écart d''altitude entre deux courbes de niveau successives","La longueur du profil","L''échelle de la carte"],"correct":1,"explanation":"L''équidistance est la différence d''altitude constante entre deux courbes de niveau consécutives."},
    {"id":"q3","question":"Un anticlinal a au cœur des couches :","options":["Jeunes","Anciennes","Métamorphiques","Volcaniques"],"correct":1,"explanation":"Dans un anticlinal (pli convexe vers le haut), l''érosion met à nu les couches les plus anciennes au cœur."},
    {"id":"q4","question":"L''exagération verticale sert à :","options":["Réduire le profil","Accentuer les variations de relief","Changer l''échelle horizontale","Corriger les erreurs"],"correct":1,"explanation":"L''exagération verticale (échelle verticale > échelle horizontale) accentue le relief pour mieux visualiser les variations d''altitude."},
    {"id":"q5","question":"Une faille normale est associée à :","options":["Une compression","Une extension","Un plissement","Une érosion"],"correct":1,"explanation":"Une faille normale résulte d''une extension : le bloc supérieur (toit) descend par rapport au bloc inférieur (mur)."},
    {"id":"q6","question":"Le pendage d''une couche est :","options":["Son épaisseur","Son angle avec l''horizontale","Sa longueur","Sa couleur sur la carte"],"correct":1,"explanation":"Le pendage est l''angle d''inclinaison maximal de la couche par rapport au plan horizontal."},
    {"id":"q7","question":"Sur un profil topographique, l''axe vertical représente :","options":["La distance","L''altitude","Le temps","La température"],"correct":1,"explanation":"L''axe vertical (ordonnées) d''un profil topographique représente l''altitude, et l''axe horizontal la distance le long de la ligne de coupe."},
    {"id":"q8","question":"Un synclinal est un pli :","options":["Convexe vers le haut","Concave (creux)","Horizontal","Vertical"],"correct":1,"explanation":"Un synclinal est un pli concave dont la partie basse (charnière) est orientée vers le bas, avec les couches les plus jeunes au cœur."}
  ]
}');

-- Chapitre 2 : Géologie du Mali
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'geologie-mali', 2, 'Géologie du Mali', 'Évolution géologique, carte géologique et ressources minières du Mali.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'geologie-mali-fiche', 'Géologie du Mali', 'Histoire géologique, formations et ressources', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quels sont les grands ensembles géologiques du Mali ?","verso":"1) Le socle précambrien (bouclier ouest-africain). 2) Les bassins sédimentaires (Taoudéni, Iullemeden). 3) Les formations récentes (quaternaire, alluvions du Niger).","category":"Définition"},
    {"id":"f2","recto":"Qu''est-ce que le bouclier ouest-africain ?","verso":"Ensemble de roches très anciennes (précambrien, > 2 Ga) formant le socle cristallin de l''Afrique de l''Ouest. Il affleure dans l''ouest et le sud du Mali (Kéniéba, Kayes).","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que le bassin de Taoudéni ?","verso":"Vaste bassin sédimentaire couvrant le nord du Mali, rempli de sédiments du Protérozoïque et du Paléozoïque. Il contient des grès, calcaires et argiles.","category":"Définition"},
    {"id":"f4","recto":"Quelles sont les principales ressources minières du Mali ?","verso":"Or (Kéniéba, Bougouni, Sikasso), bauxite (Kita, Bafing), fer (Diamou), phosphates (Tilemsi), sel gemme (Taoudéni), uranium (Faléa).","category":"Exemple"},
    {"id":"f5","recto":"Comment lire une carte géologique ?","verso":"Identifier : 1) Les figurés de couleur (âge des formations). 2) Les symboles structuraux (pendage, failles). 3) La légende stratigraphique. 4) Les coupes associées.","category":"Méthode"},
    {"id":"f6","recto":"Quelles sont les ères géologiques représentées au Mali ?","verso":"Précambrien (socle cristallin), Paléozoïque (grès du bassin de Taoudéni), Mésozoïque (rare, quelques formations crétacées), Cénozoïque et Quaternaire (alluvions, latérites).","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce que la latérite ?","verso":"Roche résiduelle riche en oxydes de fer et d''aluminium, formée par altération intense en climat tropical. Elle donne les sols rouges caractéristiques du Mali.","category":"Définition"},
    {"id":"f8","recto":"Quelle est l''importance du fleuve Niger en géologie ?","verso":"Le Niger et ses affluents déposent des alluvions (sédiments fluviatiles) qui forment le delta intérieur et des plaines fertiles. Ces dépôts sont du Quaternaire récent.","category":"Exemple"},
    {"id":"f9","recto":"Qu''est-ce que l''orogenèse éburnéenne ?","verso":"Événement tectonique majeur du Paléoprotérozoïque (~2,1 Ga) ayant structuré le socle ouest-africain. Il a provoqué métamorphisme, magmatisme et minéralisation aurifère.","category":"Définition"},
    {"id":"f10","recto":"Comment se forment les gisements d''or au Mali ?","verso":"L''or est associé aux formations birimiennes (volcanosédimentaires) du Précambrien. Il se concentre dans des filons de quartz liés à des zones de cisaillement tectonique.","category":"Méthode"}
  ],
  "schema": {
    "title": "Géologie du Mali",
    "nodes": [
      {"id":"n1","label":"Géologie du Mali","type":"main","x":400,"y":50},
      {"id":"n2","label":"Socle précambrien","type":"branch","x":150,"y":150},
      {"id":"n3","label":"Bassins sédimentaires","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Ressources minières","type":"branch","x":650,"y":150},
      {"id":"n5","label":"Bouclier ouest-africain","type":"leaf","x":50,"y":250},
      {"id":"n6","label":"Orogenèse éburnéenne","type":"leaf","x":250,"y":250},
      {"id":"n7","label":"Taoudéni","type":"leaf","x":350,"y":250},
      {"id":"n8","label":"Iullemeden","type":"leaf","x":500,"y":250},
      {"id":"n9","label":"Or, bauxite, fer","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"ancien"},
      {"from":"n1","to":"n3","label":"couverture"},
      {"from":"n1","to":"n4","label":"exploitation"},
      {"from":"n2","to":"n5","label":"structure"},
      {"from":"n2","to":"n6","label":"formation"},
      {"from":"n3","to":"n7","label":"nord"},
      {"from":"n3","to":"n8","label":"est"},
      {"from":"n4","to":"n9","label":"minerais"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le socle précambrien du Mali date de plus de :","options":["500 Ma","1 Ga","2 Ga","100 Ma"],"correct":2,"explanation":"Le socle cristallin ouest-africain est d''âge archéen à paléoprotérozoïque, soit plus de 2 milliards d''années."},
    {"id":"q2","question":"Le bassin de Taoudéni se situe :","options":["Au sud du Mali","Au nord du Mali","À l''est du Mali","Au centre du Mali"],"correct":1,"explanation":"Le bassin de Taoudéni est un vaste bassin sédimentaire couvrant essentiellement le nord du Mali et s''étendant vers la Mauritanie et l''Algérie."},
    {"id":"q3","question":"La principale ressource minière du Mali est :","options":["Le diamant","Le pétrole","L''or","Le cuivre"],"correct":2,"explanation":"Le Mali est l''un des plus grands producteurs d''or en Afrique, avec des gisements dans les zones de Kéniéba, Bougouni et Sikasso."},
    {"id":"q4","question":"La latérite est riche en oxydes de :","options":["Silicium et calcium","Fer et aluminium","Sodium et potassium","Magnésium et phosphore"],"correct":1,"explanation":"La latérite est une roche résiduelle formée par altération tropicale intense, riche en oxydes de fer (Fe₂O₃) et d''aluminium (Al₂O₃)."},
    {"id":"q5","question":"L''orogenèse éburnéenne date d''environ :","options":["500 Ma","2,1 Ga","3,5 Ga","200 Ma"],"correct":1,"explanation":"L''orogenèse éburnéenne (~2,1 Ga, Paléoprotérozoïque) a structuré le socle et favorisé la minéralisation aurifère."},
    {"id":"q6","question":"Les alluvions du fleuve Niger datent du :","options":["Précambrien","Paléozoïque","Mésozoïque","Quaternaire"],"correct":3,"explanation":"Les dépôts alluvionnaires du Niger sont des formations récentes du Quaternaire (derniers 2,6 Ma)."},
    {"id":"q7","question":"Les gisements d''or du Mali sont associés aux formations :","options":["Crétacées","Birimiennes","Quaternaires","Jurassiques"],"correct":1,"explanation":"L''or malien est associé aux formations birimiennes (volcanosédimentaires du Paléoprotérozoïque), dans des filons de quartz."},
    {"id":"q8","question":"Sur une carte géologique, les couleurs indiquent :","options":["L''altitude","L''âge des formations","La végétation","La pluviométrie"],"correct":1,"explanation":"Les couleurs sur une carte géologique représentent l''âge des formations (chaque période a une couleur conventionnelle)."}
  ]
}');

-- Chapitre 3 : La lignée humaine
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'lignee-humaine', 3, 'La lignée humaine', 'Hominisation, bipédie, développement du cerveau et culture matérielle.', 3)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'lignee-humaine-fiche', 'La lignée humaine', 'Évolution des hominidés, bipédie et outils', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la lignée humaine ?","verso":"Ensemble des espèces d''hominidés qui se sont succédé depuis la divergence avec les grands singes (environ 7 Ma) jusqu''à Homo sapiens.","category":"Définition"},
    {"id":"f2","recto":"Quels sont les critères de la lignée humaine ?","verso":"1) Bipédie permanente. 2) Augmentation du volume crânien. 3) Réduction de la face. 4) Fabrication d''outils. 5) Langage articulé.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la bipédie ?","verso":"Mode de locomotion sur deux membres postérieurs. Adaptations : trou occipital centré, bassin court et large, fémur oblique, voûte plantaire, gros orteil non opposable.","category":"Définition"},
    {"id":"f4","recto":"Quel est le plus ancien hominidé connu ?","verso":"Toumaï (Sahelanthropus tchadensis), découvert au Tchad, daté d''environ 7 millions d''années. Il présente un trou occipital centré suggérant la bipédie.","category":"Exemple"},
    {"id":"f5","recto":"Quelles sont les caractéristiques d''Australopithecus ?","verso":"Genre apparu vers 4 Ma en Afrique. Bipède, volume crânien ~400-500 cm³, face prognathe, petite taille (~1,2 m). Ex : Lucy (A. afarensis, 3,2 Ma).","category":"Exemple"},
    {"id":"f6","recto":"Quand apparaissent les premiers outils ?","verso":"Les plus anciens outils connus datent de 3,3 Ma (Lomekwi, Kenya). Le genre Homo est associé aux outils oldowayens (galets aménagés, 2,6 Ma).","category":"Exemple"},
    {"id":"f7","recto":"Quelle est l''évolution du volume crânien dans la lignée humaine ?","verso":"Australopithecus : 400-500 cm³. H. habilis : 600-700 cm³. H. erectus : 800-1100 cm³. H. sapiens : 1300-1500 cm³.","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que l''Homme de Neandertal ?","verso":"Homo neanderthalensis, espèce ayant vécu en Europe et au Proche-Orient de 400 000 à 30 000 ans. Volume crânien ~1500 cm³, robuste, pratiquait des rites funéraires.","category":"Exemple"},
    {"id":"f9","recto":"Qu''est-ce que l''hypothèse multicentrique vs Out of Africa ?","verso":"Multicentrique : H. sapiens aurait évolué en parallèle sur plusieurs continents. Out of Africa : H. sapiens est apparu en Afrique (~300 000 ans) et a migré partout.","category":"Distinction"},
    {"id":"f10","recto":"Comment les fossiles permettent de reconstituer la lignée humaine ?","verso":"Par l''anatomie comparée (crâne, bassin, fémur), la datation (radiométrique, stratigraphique) et l''analyse moléculaire (ADN, horloge moléculaire).","category":"Méthode"}
  ],
  "schema": {
    "title": "La lignée humaine",
    "nodes": [
      {"id":"n1","label":"Lignée humaine","type":"main","x":400,"y":50},
      {"id":"n2","label":"Caractères dérivés","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Genres fossiles","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Bipédie","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Volume crânien","type":"leaf","x":200,"y":250},
      {"id":"n6","label":"Outils","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Australopithecus","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Homo","type":"leaf","x":600,"y":250},
      {"id":"n9","label":"H. sapiens","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"évolution"},
      {"from":"n1","to":"n3","label":"fossiles"},
      {"from":"n2","to":"n4","label":"locomotion"},
      {"from":"n2","to":"n5","label":"encéphalisation"},
      {"from":"n2","to":"n6","label":"culture"},
      {"from":"n3","to":"n7","label":"4 Ma"},
      {"from":"n3","to":"n8","label":"2,5 Ma"},
      {"from":"n3","to":"n9","label":"300 ka"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La divergence homme/grands singes date d''environ :","options":["1 Ma","3 Ma","7 Ma","20 Ma"],"correct":2,"explanation":"La divergence entre la lignée humaine et celle des chimpanzés est estimée à environ 7 millions d''années."},
    {"id":"q2","question":"Le trou occipital centré est un critère de :","options":["Quadrupédie","Bipédie","Vol","Nage"],"correct":1,"explanation":"Un trou occipital (foramen magnum) centré sous le crâne permet l''équilibre de la tête sur une colonne vertébrale verticale, signe de bipédie."},
    {"id":"q3","question":"Lucy appartient à l''espèce :","options":["Homo habilis","Homo erectus","Australopithecus afarensis","Homo sapiens"],"correct":2,"explanation":"Lucy est un squelette d''Australopithecus afarensis découvert en Éthiopie, daté de 3,2 millions d''années."},
    {"id":"q4","question":"Le volume crânien d''Homo sapiens est environ :","options":["500 cm³","800 cm³","1400 cm³","2000 cm³"],"correct":2,"explanation":"Le volume crânien moyen d''Homo sapiens est d''environ 1300-1500 cm³."},
    {"id":"q5","question":"Les premiers outils oldowayens datent de :","options":["100 000 ans","500 000 ans","2,6 Ma","7 Ma"],"correct":2,"explanation":"Les outils oldowayens (galets aménagés) les plus anciens datent d''environ 2,6 millions d''années."},
    {"id":"q6","question":"L''hypothèse ''Out of Africa'' propose que H. sapiens :","options":["Est apparu en Europe","Est apparu en Asie","Est apparu en Afrique et a migré","A évolué partout simultanément"],"correct":2,"explanation":"L''hypothèse Out of Africa, soutenue par les données génétiques et fossiles, propose qu''Homo sapiens est apparu en Afrique (~300 ka) puis a colonisé le monde."},
    {"id":"q7","question":"Homo neanderthalensis a disparu il y a environ :","options":["1 Ma","100 000 ans","30 000 ans","5 000 ans"],"correct":2,"explanation":"Les derniers Néandertaliens ont disparu il y a environ 30 000 ans, probablement par compétition avec H. sapiens et changements climatiques."},
    {"id":"q8","question":"La datation radiométrique utilise :","options":["Les couleurs des roches","La désintégration d''isotopes radioactifs","La taille des fossiles","L''épaisseur des couches"],"correct":1,"explanation":"La datation radiométrique (ex : carbone 14, potassium-argon) mesure la désintégration d''isotopes radioactifs pour déterminer l''âge des roches et fossiles."}
  ]
}');

-- Chapitre 4 : La reproduction chez l'Homme
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'reproduction-humaine', 4, 'La reproduction chez l''Homme', 'Gamétogénèse, cycles sexuels, fécondation et contraception.', 4)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'reproduction-humaine-fiche', 'La reproduction chez l''Homme', 'Gamétogénèse, cycles et régulation hormonale', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la gamétogénèse ?","verso":"Processus de formation des gamètes par méiose. Spermatogénèse (testicules) → spermatozoïdes. Ovogénèse (ovaires) → ovocytes.","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les phases de la spermatogénèse ?","verso":"1) Multiplication (mitoses des spermatogonies). 2) Accroissement. 3) Maturation (méiose → spermatides). 4) Différenciation (spermiogénèse → spermatozoïdes). Durée : ~74 jours.","category":"Méthode"},
    {"id":"f3","recto":"Qu''est-ce que le cycle menstruel ?","verso":"Cycle de 28 jours en moyenne, comprenant : phase folliculaire (J1-J14), ovulation (J14), phase lutéale (J14-J28). Régulé par FSH, LH, œstrogènes et progestérone.","category":"Définition"},
    {"id":"f4","recto":"Quel est le rôle de la FSH et de la LH ?","verso":"FSH (hormone folliculostimulante) : stimule la maturation des follicules (femme) et la spermatogénèse (homme). LH (hormone lutéinisante) : déclenche l''ovulation et stimule le corps jaune.","category":"Définition"},
    {"id":"f5","recto":"Qu''est-ce que l''ovulation ?","verso":"Libération de l''ovocyte II par le follicule mûr (follicule de De Graaf) sous l''effet du pic de LH, vers le 14e jour du cycle.","category":"Définition"},
    {"id":"f6","recto":"Comment se déroule la fécondation ?","verso":"1) Capacitation du spermatozoïde. 2) Traversée de la corona radiata. 3) Réaction acrosomique (zone pellucide). 4) Fusion des membranes. 5) Blocage de polyspermie. 6) Fusion des pronucléi.","category":"Méthode"},
    {"id":"f7","recto":"Quels sont les différents types de contraception ?","verso":"Hormonale (pilule, implant, injection), mécanique (préservatif, DIU), chimique (spermicides), naturelle (abstinence périodique), chirurgicale (ligature, vasectomie).","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que le rétrocontrôle hormonal ?","verso":"Mécanisme de régulation : les hormones gonadiques (œstrogènes, progestérone, testostérone) exercent un rétrocontrôle (positif ou négatif) sur l''hypothalamus et l''hypophyse.","category":"Définition"},
    {"id":"f9","recto":"Quelle différence entre spermatogénèse et ovogénèse ?","verso":"Spermatogénèse : continue dès la puberté, 4 gamètes par méiose, production massive. Ovogénèse : commence avant la naissance, 1 gamète par méiose, stock limité (~400 ovulations).","category":"Distinction"},
    {"id":"f10","recto":"Qu''est-ce que la nidation ?","verso":"Implantation de l''embryon (blastocyste) dans la muqueuse utérine (endomètre), environ 7 jours après la fécondation. Elle nécessite un endomètre préparé par la progestérone.","category":"Définition"}
  ],
  "schema": {
    "title": "Reproduction chez l''Homme",
    "nodes": [
      {"id":"n1","label":"Reproduction humaine","type":"main","x":400,"y":50},
      {"id":"n2","label":"Gamétogénèse","type":"branch","x":150,"y":150},
      {"id":"n3","label":"Cycles et régulation","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Contraception","type":"branch","x":650,"y":150},
      {"id":"n5","label":"Spermatogénèse","type":"leaf","x":50,"y":250},
      {"id":"n6","label":"Ovogénèse","type":"leaf","x":250,"y":250},
      {"id":"n7","label":"FSH / LH","type":"leaf","x":350,"y":250},
      {"id":"n8","label":"Rétrocontrôle","type":"leaf","x":500,"y":250},
      {"id":"n9","label":"Hormonale / mécanique","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"gamètes"},
      {"from":"n1","to":"n3","label":"hormones"},
      {"from":"n1","to":"n4","label":"contrôle"},
      {"from":"n2","to":"n5","label":"mâle"},
      {"from":"n2","to":"n6","label":"femelle"},
      {"from":"n3","to":"n7","label":"hypophyse"},
      {"from":"n3","to":"n8","label":"feedback"},
      {"from":"n4","to":"n9","label":"types"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La méiose produit des cellules :","options":["Diploïdes","Haploïdes","Polyploïdes","Triploïdes"],"correct":1,"explanation":"La méiose est une division réductionnelle qui produit des cellules haploïdes (n chromosomes) à partir de cellules diploïdes (2n)."},
    {"id":"q2","question":"L''ovulation a lieu vers le :","options":["1er jour du cycle","7e jour","14e jour","28e jour"],"correct":2,"explanation":"L''ovulation se produit vers le 14e jour du cycle menstruel de 28 jours, déclenchée par le pic de LH."},
    {"id":"q3","question":"La spermatogénèse produit :","options":["1 spermatozoïde par méiose","2 spermatozoïdes","4 spermatozoïdes","8 spermatozoïdes"],"correct":2,"explanation":"Une spermatogonie diploïde donne par méiose 4 spermatides haploïdes qui se différencient en 4 spermatozoïdes."},
    {"id":"q4","question":"Le pic de LH déclenche :","options":["Les règles","L''ovulation","La fécondation","La nidation"],"correct":1,"explanation":"Le pic de LH (hormone lutéinisante) au 14e jour provoque la rupture du follicule mûr et la libération de l''ovocyte : c''est l''ovulation."},
    {"id":"q5","question":"La pilule contraceptive agit principalement par :","options":["Destruction des spermatozoïdes","Blocage de l''ovulation par rétrocontrôle négatif","Acidification du vagin","Épaississement de l''endomètre"],"correct":1,"explanation":"La pilule contient des hormones synthétiques qui exercent un rétrocontrôle négatif sur l''hypophyse, bloquant la sécrétion de FSH et LH et donc l''ovulation."},
    {"id":"q6","question":"La nidation a lieu environ :","options":["1 jour après la fécondation","7 jours après la fécondation","14 jours après la fécondation","28 jours après la fécondation"],"correct":1,"explanation":"La nidation (implantation du blastocyste dans l''endomètre) se produit environ 7 jours après la fécondation."},
    {"id":"q7","question":"L''ovogénèse commence :","options":["À la puberté","Avant la naissance","À la ménopause","Après la fécondation"],"correct":1,"explanation":"L''ovogénèse débute pendant la vie fœtale : les ovogonies se multiplient et entament la méiose I, qui se bloque en prophase I jusqu''à la puberté."},
    {"id":"q8","question":"Le corps jaune sécrète principalement :","options":["FSH","LH","Progestérone","Testostérone"],"correct":2,"explanation":"Après l''ovulation, le follicule se transforme en corps jaune qui sécrète de la progestérone (et des œstrogènes) pour préparer l''endomètre à la nidation."}
  ]
}');

-- Chapitre 5 : Brassage génétique et unicité
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'brassage-genetique', 5, 'Brassage génétique et unicité', 'Méiose, brassage interchromosomique et intrachromosomique, diversité génétique.', 5)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'brassage-genetique-fiche', 'Brassage génétique et unicité', 'Mécanismes de diversité génétique', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que le brassage génétique ?","verso":"Ensemble des mécanismes qui créent de nouvelles combinaisons d''allèles lors de la reproduction sexuée : brassage intrachromosomique (crossing-over) et interchromosomique (ségrégation indépendante).","category":"Définition"},
    {"id":"f2","recto":"Qu''est-ce que le brassage intrachromosomique ?","verso":"Échange de segments entre chromatides de chromosomes homologues pendant la prophase I de méiose (crossing-over). Il produit des chromatides recombinées.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que le brassage interchromosomique ?","verso":"Séparation aléatoire des chromosomes homologues en anaphase I de méiose. Pour n paires, il y a 2ⁿ combinaisons possibles de gamètes (2²³ ≈ 8 millions chez l''Homme).","category":"Définition"},
    {"id":"f4","recto":"Quelles sont les étapes de la méiose ?","verso":"Méiose I (réductionnelle) : prophase I (appariement, crossing-over), métaphase I, anaphase I, télophase I. Méiose II (équationnelle) : prophase II, métaphase II, anaphase II, télophase II.","category":"Méthode"},
    {"id":"f5","recto":"Qu''est-ce qu''un chiasma ?","verso":"Point de contact visible entre chromatides non sœurs de chromosomes homologues lors de la prophase I. C''est la trace cytologique du crossing-over.","category":"Définition"},
    {"id":"f6","recto":"Pourquoi chaque individu est-il génétiquement unique ?","verso":"La combinaison du brassage inter et intrachromosomique lors de la méiose, plus la rencontre aléatoire des gamètes lors de la fécondation, crée un nombre quasi infini de combinaisons génétiques.","category":"Définition"},
    {"id":"f7","recto":"Quelle est la différence entre mitose et méiose ?","verso":"Mitose : 1 division, 2 cellules diploïdes identiques (croissance). Méiose : 2 divisions, 4 cellules haploïdes différentes (reproduction).","category":"Distinction"},
    {"id":"f8","recto":"Comment vérifier un crossing-over par un test-cross ?","verso":"Croiser un individu hétérozygote avec un homozygote récessif. Si les phénotypes recombinés apparaissent, il y a eu crossing-over. Leur fréquence estime la distance génétique.","category":"Méthode"},
    {"id":"f9","recto":"Qu''est-ce que la fécondation apporte à la diversité ?","verso":"La fécondation associe aléatoirement deux gamètes parmi les millions possibles, créant un zygote avec une combinaison allélique unique. C''est le troisième niveau de brassage.","category":"Définition"},
    {"id":"f10","recto":"Qu''est-ce qu''une carte génétique ?","verso":"Représentation linéaire de l''ordre des gènes sur un chromosome, avec les distances génétiques entre eux exprimées en centiMorgans (cM), estimées par les fréquences de recombinaison.","category":"Définition"}
  ],
  "schema": {
    "title": "Brassage génétique et unicité",
    "nodes": [
      {"id":"n1","label":"Brassage génétique","type":"main","x":400,"y":50},
      {"id":"n2","label":"Brassage intrachromosomique","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Brassage interchromosomique","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Crossing-over","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Chiasmas","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Ségrégation indépendante","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"2ⁿ combinaisons","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Fécondation","type":"leaf","x":400,"y":300},
      {"id":"n9","label":"Unicité génétique","type":"leaf","x":400,"y":380}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"prophase I"},
      {"from":"n1","to":"n3","label":"anaphase I"},
      {"from":"n2","to":"n4","label":"échange"},
      {"from":"n2","to":"n5","label":"trace"},
      {"from":"n3","to":"n6","label":"aléatoire"},
      {"from":"n3","to":"n7","label":"diversité"},
      {"from":"n1","to":"n8","label":"rencontre"},
      {"from":"n8","to":"n9","label":"résultat"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le crossing-over a lieu en :","options":["Métaphase I","Prophase I","Anaphase II","Télophase II"],"correct":1,"explanation":"Le crossing-over se produit pendant la prophase I de méiose, quand les chromosomes homologues sont appariés (bivalents)."},
    {"id":"q2","question":"Le brassage interchromosomique a lieu en :","options":["Prophase I","Métaphase I","Anaphase I","Anaphase II"],"correct":2,"explanation":"Le brassage interchromosomique résulte de la séparation aléatoire des chromosomes homologues en anaphase I."},
    {"id":"q3","question":"Chez l''Homme (n=23), le nombre de combinaisons gamétiques est :","options":["23","46","2²³ ≈ 8 millions","23²"],"correct":2,"explanation":"Avec 23 paires de chromosomes, le brassage interchromosomique permet 2²³ ≈ 8,4 millions de combinaisons gamétiques différentes."},
    {"id":"q4","question":"Un chiasma est :","options":["Une cassure chromosomique","Le point de contact entre chromatides homologues lors du crossing-over","Un centromère","Un télomère"],"correct":1,"explanation":"Le chiasma est le point de contact visible entre chromatides non sœurs lors de la prophase I, témoignant d''un crossing-over."},
    {"id":"q5","question":"La méiose produit :","options":["2 cellules diploïdes","2 cellules haploïdes","4 cellules diploïdes","4 cellules haploïdes"],"correct":3,"explanation":"La méiose (2 divisions successives) produit 4 cellules haploïdes à partir d''une cellule diploïde."},
    {"id":"q6","question":"La distance génétique s''exprime en :","options":["Nanomètres","Daltons","CentiMorgans","Kilobases"],"correct":2,"explanation":"La distance génétique entre deux gènes s''exprime en centiMorgans (cM), calculée à partir du pourcentage de recombinaison."},
    {"id":"q7","question":"Le test-cross consiste à croiser un individu avec :","options":["Un hétérozygote","Un homozygote dominant","Un homozygote récessif","Un hybride F1"],"correct":2,"explanation":"Le test-cross (ou back-cross) croise l''individu étudié avec un homozygote récessif pour révéler son génotype par l''analyse de la descendance."},
    {"id":"q8","question":"La fécondation rétablit :","options":["L''haploïdie","La diploïdie","La polyploïdie","L''aneuploïdie"],"correct":1,"explanation":"La fécondation réunit deux gamètes haploïdes (n) pour former un zygote diploïde (2n), rétablissant le nombre chromosomique de l''espèce."}
  ]
}');

-- Chapitre 6 : Génétique humaine
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'genetique-humaine', 6, 'Génétique humaine', 'Hérédité autosomique et gonosomique, drépanocytose et maladies génétiques.', 6)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'genetique-humaine-fiche', 'Génétique humaine', 'Autosomes, gonosomes et maladies héréditaires', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que l''hérédité autosomique ?","verso":"Transmission de caractères portés par les autosomes (chromosomes non sexuels, 1 à 22). L''allèle peut être dominant ou récessif. La maladie touche les deux sexes également.","category":"Définition"},
    {"id":"f2","recto":"Qu''est-ce que l''hérédité gonosomique ?","verso":"Transmission de caractères portés par les chromosomes sexuels (X ou Y). Les maladies liées à l''X récessif touchent principalement les hommes (hémizygotes XY).","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la drépanocytose ?","verso":"Maladie génétique autosomique récessive due à une mutation de l''hémoglobine (HbA → HbS). Les globules rouges deviennent falciformes, provoquant anémie et crises vaso-occlusives.","category":"Définition"},
    {"id":"f4","recto":"Quelle est la mutation responsable de la drépanocytose ?","verso":"Substitution d''un nucléotide dans le gène de la β-globine (chromosome 11) : GAG → GTG, remplaçant l''acide glutamique par la valine en position 6. HbA → HbS.","category":"Exemple"},
    {"id":"f5","recto":"Comment analyser un arbre généalogique ?","verso":"1) Déterminer si le caractère est dominant ou récessif. 2) Vérifier s''il est lié au sexe (transmission père-fille, sauts de génération). 3) Déduire les génotypes des individus.","category":"Méthode"},
    {"id":"f6","recto":"Qu''est-ce que le daltonisme ?","verso":"Anomalie de la vision des couleurs (rouge-vert), liée au chromosome X récessif. Les hommes (XY) sont plus touchés car un seul allèle muté suffit.","category":"Exemple"},
    {"id":"f7","recto":"Qu''est-ce que l''hémophilie ?","verso":"Maladie héréditaire liée à l''X récessif, caractérisée par un déficit en facteur de coagulation (VIII pour hémophilie A, IX pour B). Saignements prolongés.","category":"Exemple"},
    {"id":"f8","recto":"Comment distinguer hérédité autosomique et gonosomique ?","verso":"Autosomique : les deux sexes sont touchés également, pas de transmission préférentielle père→fils ou mère→fils. Gonosomique liée à X : les garçons sont plus touchés, pas de transmission père→fils.","category":"Distinction"},
    {"id":"f9","recto":"Qu''est-ce qu''un porteur sain ?","verso":"Individu hétérozygote pour un allèle récessif pathologique. Il ne présente pas la maladie mais peut la transmettre à sa descendance (ex : AS pour la drépanocytose).","category":"Définition"},
    {"id":"f10","recto":"Pourquoi la drépanocytose est-elle fréquente en Afrique ?","verso":"L''hétérozygote AS bénéficie d''un avantage sélectif contre le paludisme (résistance partielle). C''est un exemple d''avantage de l''hétérozygote (sélection balancée).","category":"Exemple"}
  ],
  "schema": {
    "title": "Génétique humaine",
    "nodes": [
      {"id":"n1","label":"Génétique humaine","type":"main","x":400,"y":50},
      {"id":"n2","label":"Hérédité autosomique","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Hérédité gonosomique","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Dominante","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Récessive (drépanocytose)","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Liée à X (daltonisme)","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Hémophilie","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Arbre généalogique","type":"leaf","x":400,"y":300}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"autosomes"},
      {"from":"n1","to":"n3","label":"gonosomes"},
      {"from":"n2","to":"n4","label":"type"},
      {"from":"n2","to":"n5","label":"type"},
      {"from":"n3","to":"n6","label":"vision"},
      {"from":"n3","to":"n7","label":"coagulation"},
      {"from":"n1","to":"n8","label":"analyse"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La drépanocytose est une maladie :","options":["Autosomique dominante","Autosomique récessive","Liée à X dominante","Liée à X récessive"],"correct":1,"explanation":"La drépanocytose est autosomique récessive : il faut deux allèles S (génotype SS) pour être malade."},
    {"id":"q2","question":"La mutation de la drépanocytose remplace :","options":["Valine par acide glutamique","Acide glutamique par valine","Leucine par alanine","Glycine par proline"],"correct":1,"explanation":"La mutation ponctuelle GAG→GTG dans le gène de la β-globine remplace l''acide glutamique (Glu) par la valine (Val) en position 6."},
    {"id":"q3","question":"Un homme daltonien a le génotype :","options":["X^D X^d","X^d Y","X^D Y","X^d X^d"],"correct":1,"explanation":"Le daltonisme est lié à l''X récessif. L''homme étant hémizygote (XY), un seul allèle muté X^d suffit pour être atteint."},
    {"id":"q4","question":"Un porteur sain de drépanocytose a le génotype :","options":["SS","AS","AA","SA"],"correct":1,"explanation":"Le porteur sain est hétérozygote AS : il possède un allèle normal (A) et un allèle muté (S) sans présenter la maladie."},
    {"id":"q5","question":"L''avantage de l''hétérozygote AS est la résistance à :","options":["La tuberculose","Le VIH","Le paludisme","La grippe"],"correct":2,"explanation":"Les individus AS ont une résistance partielle au paludisme car le Plasmodium se développe mal dans les globules rouges contenant HbS."},
    {"id":"q6","question":"Dans l''hérédité liée à l''X, un père atteint transmet l''allèle à :","options":["Tous ses fils","Toutes ses filles","Aucun enfant","Seulement les fils"],"correct":1,"explanation":"Le père (XY) transmet son X à toutes ses filles et son Y à tous ses fils. Donc un père atteint (X muté Y) transmet l''allèle à toutes ses filles."},
    {"id":"q7","question":"L''hémophilie A est due à un déficit en facteur :","options":["V","VII","VIII","IX"],"correct":2,"explanation":"L''hémophilie A résulte d''un déficit en facteur VIII de la coagulation. L''hémophilie B concerne le facteur IX."},
    {"id":"q8","question":"Deux parents porteurs sains (AS) ont un risque d''enfant malade (SS) de :","options":["0 %","25 %","50 %","75 %"],"correct":1,"explanation":"Croisement AS × AS donne 1/4 AA, 2/4 AS, 1/4 SS. Le risque d''enfant malade (SS) est donc de 25 %."}
  ]
}');

-- Chapitre 7 : Régulation de la glycémie
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'regulation-glycemie', 7, 'Régulation de la glycémie', 'Homéostasie glycémique, insuline, glucagon et diabète.', 7)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'regulation-glycemie-fiche', 'Régulation de la glycémie', 'Insuline, glucagon et homéostasie', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la glycémie ?","verso":"Concentration de glucose dans le sang. Valeur normale à jeun : 0,7 à 1,1 g/L (3,9 à 6,1 mmol/L). Elle est maintenue constante par régulation hormonale.","category":"Définition"},
    {"id":"f2","recto":"Quel est le rôle de l''insuline ?","verso":"Hormone hypoglycémiante sécrétée par les cellules β des îlots de Langerhans (pancréas). Elle favorise l''entrée du glucose dans les cellules, la glycogénogénèse et la lipogénèse.","category":"Définition"},
    {"id":"f3","recto":"Quel est le rôle du glucagon ?","verso":"Hormone hyperglycémiante sécrétée par les cellules α des îlots de Langerhans. Elle stimule la glycogénolyse et la néoglucogénèse hépatique, libérant du glucose dans le sang.","category":"Définition"},
    {"id":"f4","recto":"Qu''est-ce que le glycogène ?","verso":"Polymère de glucose stocké dans le foie (75 g) et les muscles (400 g). Le foie libère le glucose dans le sang (glycogénolyse) ; les muscles l''utilisent localement.","category":"Définition"},
    {"id":"f5","recto":"Comment l''insuline et le glucagon interagissent-ils ?","verso":"Ils forment un couple antagoniste : après un repas, l''hyperglycémie stimule l''insuline et inhibe le glucagon. À jeun, l''hypoglycémie stimule le glucagon et inhibe l''insuline.","category":"Distinction"},
    {"id":"f6","recto":"Qu''est-ce que le diabète de type 1 ?","verso":"Maladie auto-immune détruisant les cellules β du pancréas. Carence absolue en insuline. Apparition chez le jeune. Traitement : injections d''insuline.","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce que le diabète de type 2 ?","verso":"Insulinorésistance des cellules cibles, puis épuisement progressif des cellules β. Facteurs de risque : obésité, sédentarité, hérédité. Traitement : régime, exercice, antidiabétiques oraux.","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que la néoglucogénèse ?","verso":"Synthèse de glucose à partir de précurseurs non glucidiques (acides aminés, glycérol, lactate) principalement dans le foie. Stimulée par le glucagon et le cortisol.","category":"Définition"},
    {"id":"f9","recto":"Quel organe est le pivot de la régulation glycémique ?","verso":"Le foie : il stocke le glucose (glycogénogénèse), le libère (glycogénolyse), et le synthétise (néoglucogénèse). C''est le seul organe qui libère du glucose dans le sang.","category":"Définition"},
    {"id":"f10","recto":"Comment diagnostiquer un diabète ?","verso":"Glycémie à jeun ≥ 1,26 g/L (7 mmol/L) à deux reprises, ou glycémie ≥ 2 g/L (11,1 mmol/L) à n''importe quel moment avec symptômes (polyurie, polydipsie, amaigrissement).","category":"Méthode"}
  ],
  "schema": {
    "title": "Régulation de la glycémie",
    "nodes": [
      {"id":"n1","label":"Glycémie (0,7-1,1 g/L)","type":"main","x":400,"y":50},
      {"id":"n2","label":"Hyperglycémie","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Hypoglycémie","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Insuline (cellules β)","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Glycogénogénèse","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Glucagon (cellules α)","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Glycogénolyse","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Diabète","type":"leaf","x":400,"y":330}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"après repas"},
      {"from":"n1","to":"n3","label":"à jeun"},
      {"from":"n2","to":"n4","label":"sécrétion"},
      {"from":"n4","to":"n5","label":"stockage"},
      {"from":"n3","to":"n6","label":"sécrétion"},
      {"from":"n6","to":"n7","label":"libération"},
      {"from":"n1","to":"n8","label":"dérèglement"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La glycémie normale à jeun est :","options":["0,3-0,5 g/L","0,7-1,1 g/L","1,5-2,0 g/L","2,5-3,0 g/L"],"correct":1,"explanation":"La glycémie normale à jeun est comprise entre 0,7 et 1,1 g/L (3,9-6,1 mmol/L)."},
    {"id":"q2","question":"L''insuline est sécrétée par les cellules :","options":["α du pancréas","β du pancréas","Hépatocytes du foie","Cellules musculaires"],"correct":1,"explanation":"L''insuline est produite par les cellules β des îlots de Langerhans du pancréas endocrine."},
    {"id":"q3","question":"Le glucagon stimule :","options":["La glycogénogénèse","La glycogénolyse","La lipogénèse","La glycolyse"],"correct":1,"explanation":"Le glucagon stimule la glycogénolyse (dégradation du glycogène en glucose) et la néoglucogénèse dans le foie pour augmenter la glycémie."},
    {"id":"q4","question":"Le diabète de type 1 est dû à :","options":["L''insulinorésistance","La destruction auto-immune des cellules β","L''excès de glucagon","L''obésité"],"correct":1,"explanation":"Le diabète de type 1 résulte de la destruction des cellules β du pancréas par le système immunitaire, entraînant une carence absolue en insuline."},
    {"id":"q5","question":"Le principal organe de stockage du glycogène sanguin est :","options":["Le muscle","Le cerveau","Le foie","Le rein"],"correct":2,"explanation":"Le foie est le principal régulateur : il stocke le glycogène et c''est le seul organe capable de libérer du glucose dans le sang."},
    {"id":"q6","question":"La néoglucogénèse produit du glucose à partir de :","options":["Glycogène","Glucose","Précurseurs non glucidiques","Lipides uniquement"],"correct":2,"explanation":"La néoglucogénèse synthétise du glucose à partir de précurseurs non glucidiques : acides aminés, glycérol, lactate, dans le foie."},
    {"id":"q7","question":"Le diabète de type 2 est favorisé par :","options":["Une infection virale","L''obésité et la sédentarité","Une carence en glucagon","Un excès d''exercice"],"correct":1,"explanation":"Le diabète de type 2 est favorisé par l''obésité, la sédentarité et les facteurs héréditaires, entraînant une insulinorésistance progressive."},
    {"id":"q8","question":"Insuline et glucagon sont des hormones :","options":["Synergiques","Antagonistes","Identiques","Indépendantes"],"correct":1,"explanation":"L''insuline (hypoglycémiante) et le glucagon (hyperglycémiante) sont antagonistes : ils ont des effets opposés sur la glycémie."}
  ]
}');

-- Chapitre 8 : Régulation de la pression artérielle
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (svt_id, 'regulation-pression-arterielle', 8, 'Régulation de la pression artérielle', 'Mécanismes nerveux et hormonaux de régulation de la pression artérielle.', 8)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'regulation-pression-arterielle-fiche', 'Régulation de la pression artérielle', 'Barorécepteurs, système nerveux et hormones', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la pression artérielle ?","verso":"Force exercée par le sang sur la paroi des artères. Elle s''exprime en mmHg : pression systolique (contraction, ~120 mmHg) / pression diastolique (relâchement, ~80 mmHg).","category":"Définition"},
    {"id":"f2","recto":"Quels sont les facteurs de la pression artérielle ?","verso":"PA = débit cardiaque × résistances périphériques. Le débit dépend de la fréquence et du volume d''éjection. Les résistances dépendent du diamètre des artérioles (vasoconstriction/dilatation).","category":"Formule"},
    {"id":"f3","recto":"Que sont les barorécepteurs ?","verso":"Récepteurs sensoriels situés dans la crosse aortique et les sinus carotidiens. Ils détectent les variations de pression artérielle et envoient des influx au centre cardiovasculaire bulbaire.","category":"Définition"},
    {"id":"f4","recto":"Comment fonctionne la régulation nerveuse de la PA ?","verso":"Les barorécepteurs informent le bulbe rachidien → système sympathique (accélère le cœur, vasoconstriction = ↑PA) ou parasympathique via le nerf vague (ralentit le cœur = ↓PA).","category":"Méthode"},
    {"id":"f5","recto":"Qu''est-ce que le système rénine-angiotensine-aldostérone (SRAA) ?","verso":"Système hormonal : baisse de PA → rénine (rein) → angiotensine I → angiotensine II (vasoconstricteur puissant) → aldostérone (rétention Na⁺ et eau) → ↑PA.","category":"Définition"},
    {"id":"f6","recto":"Quel est le rôle de l''ADH dans la régulation de la PA ?","verso":"L''hormone antidiurétique (ADH ou vasopressine) est sécrétée par l''hypothalamus/posthypophyse. Elle augmente la réabsorption d''eau par les reins et la vasoconstriction → ↑PA.","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce que l''hypertension artérielle (HTA) ?","verso":"PA ≥ 140/90 mmHg de façon chronique. Facteurs de risque : sel, obésité, stress, sédentarité, tabac, hérédité. Risques : AVC, infarctus, insuffisance rénale.","category":"Définition"},
    {"id":"f8","recto":"Quelle est la différence entre régulation nerveuse et hormonale de la PA ?","verso":"Nerveuse : rapide (secondes), réflexe barorécepteur, ajuste fréquence cardiaque et tonus vasculaire. Hormonale : plus lente (minutes à heures), SRAA et ADH, ajuste volémie et résistances.","category":"Distinction"},
    {"id":"f9","recto":"Qu''est-ce que la volémie ?","verso":"Volume total de sang circulant dans l''organisme (~5 L chez l''adulte). Une augmentation de la volémie augmente la PA ; une diminution (hémorragie, déshydratation) la diminue.","category":"Définition"},
    {"id":"f10","recto":"Comment le rein intervient-il dans la régulation de la PA ?","verso":"1) Sécrétion de rénine (SRAA). 2) Ajustement de l''excrétion de Na⁺ et d''eau (aldostérone, ADH). 3) Natriurèse de pression (excrétion accrue si PA élevée).","category":"Méthode"}
  ],
  "schema": {
    "title": "Régulation de la pression artérielle",
    "nodes": [
      {"id":"n1","label":"Pression artérielle","type":"main","x":400,"y":50},
      {"id":"n2","label":"Régulation nerveuse","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Régulation hormonale","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Barorécepteurs","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Sympathique / Parasympathique","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"SRAA","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"ADH","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"HTA (≥ 140/90)","type":"leaf","x":400,"y":330}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"rapide"},
      {"from":"n1","to":"n3","label":"lente"},
      {"from":"n2","to":"n4","label":"détection"},
      {"from":"n2","to":"n5","label":"effecteurs"},
      {"from":"n3","to":"n6","label":"rein"},
      {"from":"n3","to":"n7","label":"hypothalamus"},
      {"from":"n1","to":"n8","label":"pathologie"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La pression artérielle normale est environ :","options":["80/60 mmHg","120/80 mmHg","160/100 mmHg","200/120 mmHg"],"correct":1,"explanation":"La pression artérielle normale est d''environ 120 mmHg (systolique) sur 80 mmHg (diastolique)."},
    {"id":"q2","question":"Les barorécepteurs sont situés dans :","options":["Le foie et les reins","La crosse aortique et les sinus carotidiens","Le cerveau et la moelle","Les poumons"],"correct":1,"explanation":"Les barorécepteurs artériels sont localisés dans la crosse aortique et les sinus carotidiens, zones soumises à de fortes pressions."},
    {"id":"q3","question":"L''angiotensine II provoque :","options":["Une vasodilatation","Une vasoconstriction","Une bradycardie","Une hypotension"],"correct":1,"explanation":"L''angiotensine II est un puissant vasoconstricteur qui augmente la pression artérielle et stimule la sécrétion d''aldostérone."},
    {"id":"q4","question":"Le nerf vague (parasympathique) a pour effet de :","options":["Accélérer le cœur","Ralentir le cœur","Aucun effet sur le cœur","Augmenter la pression"],"correct":1,"explanation":"Le nerf vague (X) est le principal nerf parasympathique cardiaque. Il libère l''acétylcholine qui ralentit la fréquence cardiaque (effet chronotrope négatif)."},
    {"id":"q5","question":"L''HTA est définie par une PA ≥ :","options":["100/60 mmHg","120/80 mmHg","140/90 mmHg","180/110 mmHg"],"correct":2,"explanation":"L''hypertension artérielle (HTA) est définie par une pression artérielle ≥ 140/90 mmHg mesurée de façon répétée."},
    {"id":"q6","question":"L''aldostérone favorise la réabsorption de :","options":["Glucose","Potassium","Sodium et eau","Protéines"],"correct":2,"explanation":"L''aldostérone, sécrétée par les surrénales sous l''effet de l''angiotensine II, favorise la réabsorption de Na⁺ et d''eau par les reins, augmentant la volémie et la PA."},
    {"id":"q7","question":"PA = débit cardiaque × :","options":["Fréquence cardiaque","Volume sanguin","Résistances périphériques","Viscosité"],"correct":2,"explanation":"La pression artérielle est le produit du débit cardiaque par les résistances périphériques totales : PA = DC × RPT."},
    {"id":"q8","question":"La régulation nerveuse de la PA est :","options":["Lente (heures)","Rapide (secondes)","Très lente (jours)","Inexistante"],"correct":1,"explanation":"La régulation nerveuse (réflexe barorécepteur) est rapide (quelques secondes) contrairement à la régulation hormonale (minutes à heures)."}
  ]
}');

-- ================================================
-- DESSIN INDUSTRIEL (4 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : Correspondance entre les vues (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (dessin_id, 'correspondance-vues', 1, 'Correspondance entre les vues', 'Projection orthogonale, vues de face, de dessus et de droite.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'correspondance-vues-fiche', 'Correspondance entre les vues', 'Projection orthogonale et disposition des vues', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la projection orthogonale ?","verso":"Méthode de représentation d''un objet 3D sur un plan 2D par des rayons de projection perpendiculaires au plan. Chaque vue montre une face de l''objet sans déformation angulaire.","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les 6 vues principales ?","verso":"Vue de face (A), vue de dessus (B), vue de droite (C), vue de gauche (D), vue de dessous (E), vue arrière (F). On utilise généralement 3 vues suffisantes.","category":"Définition"},
    {"id":"f3","recto":"Comment sont disposées les vues en projection européenne ?","verso":"Vue de face au centre, vue de dessus en dessous, vue de droite à gauche, vue de gauche à droite. (Norme ISO, méthode du 1er dièdre.)","category":"Méthode"},
    {"id":"f4","recto":"Qu''est-ce que la correspondance entre les vues ?","verso":"Les vues sont alignées entre elles : la vue de face et la vue de dessus sont alignées verticalement ; la vue de face et la vue de droite sont alignées horizontalement.","category":"Définition"},
    {"id":"f5","recto":"Comment tracer une ligne de rappel ?","verso":"Ligne de construction fine (non visible sur le dessin final) reliant les mêmes points d''un objet entre deux vues. Elle assure la correspondance dimensionnelle entre les vues.","category":"Méthode"},
    {"id":"f6","recto":"Quelle est la différence entre trait continu fort et trait interrompu ?","verso":"Trait continu fort : contour visible de l''objet. Trait interrompu fin : contour caché (arête non visible depuis le point de vue considéré).","category":"Distinction"},
    {"id":"f7","recto":"Qu''est-ce que la droite à 45° de correspondance ?","verso":"Droite auxiliaire tracée à 45° permettant de reporter les dimensions entre la vue de dessus et la vue de droite (ou gauche) en passant par cette bissectrice.","category":"Méthode"},
    {"id":"f8","recto":"Comment choisir la vue de face ?","verso":"La vue de face doit montrer la forme la plus caractéristique de l''objet, donner le maximum d''informations et minimiser les contours cachés.","category":"Méthode"}
  ],
  "schema": {
    "title": "Correspondance entre les vues",
    "nodes": [
      {"id":"n1","label":"Projection orthogonale","type":"main","x":400,"y":50},
      {"id":"n2","label":"Vues principales","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Correspondance","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Face, dessus, droite","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"1er dièdre (européen)","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Lignes de rappel","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Droite à 45°","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Traits (continu, interrompu)","type":"leaf","x":400,"y":300}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"représentation"},
      {"from":"n1","to":"n3","label":"alignement"},
      {"from":"n2","to":"n4","label":"6 faces"},
      {"from":"n2","to":"n5","label":"norme"},
      {"from":"n3","to":"n6","label":"projection"},
      {"from":"n3","to":"n7","label":"report"},
      {"from":"n1","to":"n8","label":"conventions"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"En projection européenne (1er dièdre), la vue de dessus se place :","options":["Au-dessus de la vue de face","En dessous de la vue de face","À droite de la vue de face","À gauche de la vue de face"],"correct":1,"explanation":"En méthode du 1er dièdre (norme européenne ISO), la vue de dessus se place en dessous de la vue de face."},
    {"id":"q2","question":"Un trait interrompu fin représente :","options":["Un contour visible","Un contour caché","Un axe de symétrie","Une cote"],"correct":1,"explanation":"Le trait interrompu fin (tirets courts) représente les arêtes et contours cachés, non visibles depuis le point de vue considéré."},
    {"id":"q3","question":"La vue de face doit montrer :","options":["Le moins de détails possible","La forme la plus caractéristique","Uniquement les contours cachés","Les dimensions les plus petites"],"correct":1,"explanation":"La vue de face est choisie pour montrer la forme la plus caractéristique de l''objet, avec le maximum d''informations et le minimum de contours cachés."},
    {"id":"q4","question":"La droite à 45° sert à reporter les dimensions entre :","options":["La vue de face et la vue de dessus","La vue de face et la vue de droite","La vue de dessus et la vue de droite","Aucune correspondance"],"correct":2,"explanation":"La droite à 45° permet de reporter les dimensions (profondeur) entre la vue de dessus et la vue de droite."},
    {"id":"q5","question":"Combien de vues utilise-t-on généralement ?","options":["1","2","3","6"],"correct":2,"explanation":"On utilise généralement 3 vues (face, dessus, droite ou gauche) qui suffisent à définir complètement la plupart des objets."},
    {"id":"q6","question":"Les lignes de rappel sont :","options":["Des traits forts","Des traits fins de construction","Des hachures","Des cotes"],"correct":1,"explanation":"Les lignes de rappel sont des traits fins de construction (non représentés sur le dessin final) reliant les mêmes points entre deux vues."},
    {"id":"q7","question":"Un trait mixte fin (point-tiret) représente :","options":["Un contour visible","Un contour caché","Un axe de symétrie","Une coupe"],"correct":2,"explanation":"Le trait mixte fin (alternance point-tiret) représente les axes de symétrie et les axes de révolution des pièces."},
    {"id":"q8","question":"La projection orthogonale utilise des rayons :","options":["Convergents","Divergents","Perpendiculaires au plan","Obliques"],"correct":2,"explanation":"En projection orthogonale, les rayons de projection sont perpendiculaires (normaux) au plan de projection, ce qui élimine les déformations."}
  ]
}');

-- Chapitre 2 : Éléments d'assemblage
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (dessin_id, 'elements-assemblage', 2, 'Éléments d''assemblage', 'Vis, boulons, écrous, goupilles, soudure et autres liaisons.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'elements-assemblage-fiche', 'Éléments d''assemblage', 'Visserie, goupilles et soudure', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quels sont les deux types d''assemblage ?","verso":"Assemblage démontable (vis, boulons, écrous, goupilles) : peut être défait sans détruire les pièces. Assemblage permanent (soudure, rivetage, collage) : non démontable sans destruction.","category":"Distinction"},
    {"id":"f2","recto":"Qu''est-ce qu''un boulon ?","verso":"Ensemble vis + écrou assurant l''assemblage de pièces traversées par la vis. La vis a une tête (hexagonale, cylindrique) et un corps fileté. L''écrou se visse sur le filetage.","category":"Définition"},
    {"id":"f3","recto":"Comment représenter un filetage en dessin technique ?","verso":"Filetage extérieur (vis) : trait continu fort pour le diamètre nominal, trait continu fin pour le fond de filet. Filetage intérieur (écrou) : inversé (fin pour le nominal, fort pour le fond).","category":"Méthode"},
    {"id":"f4","recto":"Qu''est-ce qu''une goupille ?","verso":"Élément d''assemblage cylindrique ou conique inséré dans un trou traversant deux pièces. Types : goupille cylindrique, goupille conique, goupille fendue, goupille élastique.","category":"Définition"},
    {"id":"f5","recto":"Qu''est-ce qu''un rivet ?","verso":"Élément d''assemblage permanent constitué d''une tige cylindrique terminée par une tête. Après insertion, l''extrémité est écrasée (bouterolle) pour former une seconde tête.","category":"Définition"},
    {"id":"f6","recto":"Comment représenter une soudure en dessin technique ?","verso":"Par un triangle noir (soudure en V) ou un demi-cercle sur la ligne de joint. Le symbole est placé sur une ligne de repère avec indication du type de soudure selon la norme ISO 2553.","category":"Méthode"},
    {"id":"f7","recto":"Qu''est-ce que le pas d''un filetage ?","verso":"Distance entre deux filets consécutifs mesurée parallèlement à l''axe. Pour un filetage métrique M10×1,5, le diamètre nominal est 10 mm et le pas est 1,5 mm.","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce qu''un écrou frein ?","verso":"Écrou conçu pour résister au desserrage sous vibrations. Types : écrou Nylstop (bague nylon), écrou à créneaux + goupille fendue, contre-écrou, rondelle Grower.","category":"Définition"}
  ],
  "schema": {
    "title": "Éléments d''assemblage",
    "nodes": [
      {"id":"n1","label":"Assemblages","type":"main","x":400,"y":50},
      {"id":"n2","label":"Démontables","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Permanents","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Vis / Boulons","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Goupilles","type":"leaf","x":200,"y":250},
      {"id":"n6","label":"Écrous","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Soudure","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Rivetage","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"réversible"},
      {"from":"n1","to":"n3","label":"irréversible"},
      {"from":"n2","to":"n4","label":"filetage"},
      {"from":"n2","to":"n5","label":"liaison"},
      {"from":"n2","to":"n6","label":"serrage"},
      {"from":"n3","to":"n7","label":"fusion"},
      {"from":"n3","to":"n8","label":"déformation"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Un assemblage par vis-écrou est :","options":["Permanent","Démontable","Soudé","Collé"],"correct":1,"explanation":"Un assemblage par vis-écrou est démontable : on peut le défaire et le refaire sans détruire les pièces."},
    {"id":"q2","question":"Le pas d''un filetage M12×1,75 est :","options":["12 mm","1,75 mm","13,75 mm","10,25 mm"],"correct":1,"explanation":"Dans la désignation M12×1,75, M indique métrique, 12 est le diamètre nominal en mm, et 1,75 est le pas en mm."},
    {"id":"q3","question":"Le filetage extérieur d''une vis se représente par :","options":["Trait fort pour le fond de filet","Trait fort pour le diamètre nominal et trait fin pour le fond","Trait fin pour le diamètre nominal","Aucun trait particulier"],"correct":1,"explanation":"Pour un filetage extérieur (vis), le trait continu fort représente le diamètre nominal (extérieur) et le trait continu fin le fond de filet (intérieur)."},
    {"id":"q4","question":"Une goupille sert principalement à :","options":["Souder deux pièces","Positionner ou arrêter deux pièces","Étanchéifier un joint","Conduire l''électricité"],"correct":1,"explanation":"La goupille est un élément de positionnement et/ou d''arrêt qui empêche le déplacement relatif de deux pièces assemblées."},
    {"id":"q5","question":"Le rivetage est un assemblage :","options":["Démontable","Permanent","Temporaire","Élastique"],"correct":1,"explanation":"Le rivetage est un assemblage permanent : la tige du rivet est écrasée (bouterolle) et ne peut être démontée sans destruction."},
    {"id":"q6","question":"Un écrou Nylstop résiste au desserrage grâce à :","options":["Sa forme hexagonale","Une bague en nylon","Un ressort interne","Un adhésif"],"correct":1,"explanation":"L''écrou Nylstop (ou écrou autofreiné) contient une bague en nylon qui se déforme au passage du filetage, créant un freinage par friction."},
    {"id":"q7","question":"La soudure est représentée en dessin par :","options":["Un trait mixte","Un symbole normalisé sur ligne de repère","Des hachures","Un trait pointillé"],"correct":1,"explanation":"La soudure est représentée par un symbole normalisé (triangle, demi-cercle, etc.) placé sur une ligne de repère selon la norme ISO 2553."},
    {"id":"q8","question":"Le filetage intérieur (écrou) en vue de dessus montre :","options":["Un cercle fort extérieur et un cercle fin intérieur","Un cercle fin extérieur et un cercle fort intérieur (3/4)","Deux cercles forts","Aucun cercle"],"correct":0,"explanation":"En vue de dessus, le filetage intérieur montre le diamètre nominal en trait continu fort (cercle extérieur complet) et le fond de filet en trait continu fin (arc de cercle ~3/4)."}
  ]
}');

-- Chapitre 3 : Coupes et sections
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (dessin_id, 'coupes-sections', 3, 'Coupes et sections', 'Plans de coupe, hachures et sections pour révéler les formes intérieures.', 3)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'coupes-sections-fiche', 'Coupes et sections', 'Représentation des formes internes', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce qu''une coupe en dessin technique ?","verso":"Représentation obtenue en imaginant qu''on coupe l''objet par un plan. On retire la partie entre l''observateur et le plan de coupe pour révéler les formes intérieures.","category":"Définition"},
    {"id":"f2","recto":"Comment indiquer un plan de coupe ?","verso":"Par un trait mixte fort aux extrémités et fin au milieu, avec des flèches indiquant le sens d''observation et des lettres (A-A, B-B) identifiant la coupe.","category":"Méthode"},
    {"id":"f3","recto":"Que sont les hachures ?","verso":"Traits fins parallèles inclinés à 45° (en général) dessinés sur les surfaces coupées. Le type de hachures indique le matériau : acier (traits fins à 45°), aluminium (traits croisés), etc.","category":"Définition"},
    {"id":"f4","recto":"Quelle est la différence entre une coupe et une section ?","verso":"La coupe montre la partie coupée ET ce qui est derrière le plan de coupe. La section ne montre QUE la partie coupée (intersection avec le plan).","category":"Distinction"},
    {"id":"f5","recto":"Quels éléments ne se coupent jamais ?","verso":"Les nervures, les bras de poulie, les dents d''engrenage, les arbres pleins, les vis et les goupilles vus en coupe longitudinale ne se hachent pas (convention).","category":"Méthode"},
    {"id":"f6","recto":"Qu''est-ce qu''une demi-coupe ?","verso":"Représentation combinant une demi-vue extérieure et une demi-coupe, séparées par l''axe de symétrie. Utilisée pour les pièces symétriques. La coupe est à droite ou en bas.","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce qu''une coupe brisée ?","verso":"Coupe utilisant un plan de coupe non plan (en zigzag) pour passer par plusieurs détails intérieurs intéressants qui ne sont pas dans un même plan.","category":"Définition"},
    {"id":"f8","recto":"Comment hachurer deux pièces adjacentes en coupe ?","verso":"Les hachures de pièces adjacentes doivent être différentes : orientation différente (sens inversé) ou espacement différent pour distinguer les pièces.","category":"Méthode"}
  ],
  "schema": {
    "title": "Coupes et sections",
    "nodes": [
      {"id":"n1","label":"Coupes et sections","type":"main","x":400,"y":50},
      {"id":"n2","label":"Coupes","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Sections","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Coupe simple","type":"leaf","x":50,"y":250},
      {"id":"n5","label":"Demi-coupe","type":"leaf","x":175,"y":250},
      {"id":"n6","label":"Coupe brisée","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Hachures","type":"leaf","x":400,"y":300},
      {"id":"n8","label":"Section sortie","type":"leaf","x":550,"y":250},
      {"id":"n9","label":"Section rabattue","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"avec arrière-plan"},
      {"from":"n1","to":"n3","label":"sans arrière-plan"},
      {"from":"n2","to":"n4","label":"plan unique"},
      {"from":"n2","to":"n5","label":"symétrie"},
      {"from":"n2","to":"n6","label":"plan brisé"},
      {"from":"n1","to":"n7","label":"matériau"},
      {"from":"n3","to":"n8","label":"séparée"},
      {"from":"n3","to":"n9","label":"sur la vue"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Les hachures représentent :","options":["Les surfaces visibles","Les surfaces coupées par le plan de coupe","Les surfaces cachées","Les axes de symétrie"],"correct":1,"explanation":"Les hachures sont tracées sur les surfaces qui ont été coupées par le plan de coupe, pour montrer la matière pleine."},
    {"id":"q2","question":"Une section ne montre que :","options":["Ce qui est derrière le plan","L''intersection avec le plan de coupe","La vue extérieure","Les contours cachés"],"correct":1,"explanation":"Contrairement à la coupe (qui montre aussi l''arrière-plan), la section ne montre que l''intersection de l''objet avec le plan de coupe."},
    {"id":"q3","question":"En coupe, les nervures vues en long :","options":["Sont hachurées","Ne sont pas hachurées","Sont en trait fort","Sont supprimées"],"correct":1,"explanation":"Par convention, les nervures (ainsi que les bras de poulie, dents d''engrenage) vues en coupe longitudinale ne sont pas hachurées pour éviter une impression de masse pleine."},
    {"id":"q4","question":"Le plan de coupe est représenté par :","options":["Un trait continu fort","Un trait mixte fort aux extrémités","Un trait interrompu","Un trait ondulé"],"correct":1,"explanation":"Le plan de coupe est indiqué par un trait mixte fort aux extrémités (avec flèches et lettres) et fin au milieu."},
    {"id":"q5","question":"La demi-coupe est utilisée pour les pièces :","options":["Asymétriques","Symétriques","Très petites","Creuses"],"correct":1,"explanation":"La demi-coupe combine une demi-vue extérieure et une demi-coupe, idéale pour les pièces présentant un axe de symétrie."},
    {"id":"q6","question":"Les hachures de deux pièces adjacentes doivent être :","options":["Identiques","Différentes (orientation ou espacement)","Supprimées","Croisées"],"correct":1,"explanation":"Pour distinguer deux pièces adjacentes en coupe, les hachures doivent avoir une orientation ou un espacement différent."},
    {"id":"q7","question":"Les hachures pour l''acier sont des traits :","options":["Croisés","Fins parallèles à 45°","Points","Ondulés"],"correct":1,"explanation":"Les hachures conventionnelles pour l''acier (et les métaux ferreux en général) sont des traits fins parallèles inclinés à 45° par rapport aux contours."},
    {"id":"q8","question":"Une coupe brisée utilise un plan de coupe :","options":["Plan unique","En zigzag passant par plusieurs détails","Courbe","Parallèle à la vue"],"correct":1,"explanation":"La coupe brisée utilise un plan de coupe brisé (en zigzag) pour passer par des détails intérieurs situés dans des plans différents."}
  ]
}');

-- Chapitre 4 : Lecture d'un dessin d'ensemble
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (dessin_id, 'dessin-ensemble', 4, 'Lecture d''un dessin d''ensemble', 'Cartouche, nomenclature, repérage des pièces et liaisons mécaniques.', 4)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'dessin-ensemble-fiche', 'Lecture d''un dessin d''ensemble', 'Analyse fonctionnelle et identification des pièces', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce qu''un dessin d''ensemble ?","verso":"Représentation graphique d''un mécanisme complet montrant toutes les pièces assemblées avec leurs positions relatives, cotations fonctionnelles et liaisons.","category":"Définition"},
    {"id":"f2","recto":"Que contient le cartouche ?","verso":"Informations normalisées : nom de la pièce/ensemble, échelle, matière, format, date, dessinateur, nom de l''entreprise, numéro de plan et indice de révision.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la nomenclature ?","verso":"Tableau associé au dessin d''ensemble listant toutes les pièces avec : repère, nombre, désignation, matière et observations. Elle se lit de bas en haut.","category":"Définition"},
    {"id":"f4","recto":"Comment identifier une pièce sur un dessin d''ensemble ?","verso":"1) Repérer son numéro (repère avec flèche). 2) Trouver sa désignation dans la nomenclature. 3) Suivre ses contours sur toutes les vues (même hachures en coupe).","category":"Méthode"},
    {"id":"f5","recto":"Quels sont les types de liaisons mécaniques ?","verso":"Encastrement (0 mobilité), pivot (1 rotation), glissière (1 translation), hélicoïdale (rotation + translation liées), pivot-glissant, rotule, appui plan, linéaire.","category":"Définition"},
    {"id":"f6","recto":"Qu''est-ce que l''échelle d''un dessin ?","verso":"Rapport entre la dimension sur le dessin et la dimension réelle. Ex : 1:2 (réduction ×2), 1:1 (taille réelle), 2:1 (agrandissement ×2).","category":"Définition"},
    {"id":"f7","recto":"Comment lire une cotation fonctionnelle ?","verso":"La cote fonctionnelle est une dimension essentielle au fonctionnement du mécanisme. Elle est identifiée dans une chaîne de cotes reliant les surfaces fonctionnelles.","category":"Méthode"},
    {"id":"f8","recto":"Qu''est-ce qu''un ajustement ?","verso":"Relation dimensionnelle entre un arbre et un alésage. Types : avec jeu (l''arbre est plus petit), serré (l''arbre est plus grand, emmanchement à la presse), incertain (les deux sont possibles).","category":"Définition"}
  ],
  "schema": {
    "title": "Dessin d''ensemble",
    "nodes": [
      {"id":"n1","label":"Dessin d''ensemble","type":"main","x":400,"y":50},
      {"id":"n2","label":"Cartouche","type":"branch","x":150,"y":150},
      {"id":"n3","label":"Nomenclature","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Liaisons mécaniques","type":"branch","x":650,"y":150},
      {"id":"n5","label":"Échelle, format","type":"leaf","x":100,"y":250},
      {"id":"n6","label":"Repères, matière","type":"leaf","x":350,"y":250},
      {"id":"n7","label":"Pivot, glissière","type":"leaf","x":550,"y":250},
      {"id":"n8","label":"Ajustements","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"informations"},
      {"from":"n1","to":"n3","label":"liste pièces"},
      {"from":"n1","to":"n4","label":"fonctionnement"},
      {"from":"n2","to":"n5","label":"présentation"},
      {"from":"n3","to":"n6","label":"identification"},
      {"from":"n4","to":"n7","label":"mobilités"},
      {"from":"n4","to":"n8","label":"tolérances"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La nomenclature se lit :","options":["De haut en bas","De bas en haut","De gauche à droite","Dans n''importe quel ordre"],"correct":1,"explanation":"Par convention, la nomenclature se lit de bas en haut : la première pièce (repère 1) est en bas du tableau."},
    {"id":"q2","question":"L''échelle 1:5 signifie que le dessin est :","options":["5 fois plus grand que le réel","5 fois plus petit que le réel","À taille réelle","2,5 fois plus grand"],"correct":1,"explanation":"L''échelle 1:5 signifie que 1 unité sur le dessin représente 5 unités réelles : le dessin est 5 fois plus petit que l''objet."},
    {"id":"q3","question":"Une liaison pivot permet :","options":["Une translation","Une rotation autour d''un axe","Aucun mouvement","Deux rotations"],"correct":1,"explanation":"La liaison pivot autorise une seule rotation autour d''un axe fixe et bloque les 5 autres degrés de liberté."},
    {"id":"q4","question":"En coupe, deux pièces adjacentes ont :","options":["Les mêmes hachures","Des hachures d''orientation ou d''espacement différent","Pas de hachures","Des hachures uniquement sur une pièce"],"correct":1,"explanation":"Les pièces adjacentes doivent avoir des hachures différentes (orientation ou espacement) pour les distinguer visuellement."},
    {"id":"q5","question":"Un ajustement serré signifie :","options":["L''arbre est plus petit que l''alésage","L''arbre est plus grand que l''alésage","Ils sont identiques","Il y a toujours du jeu"],"correct":1,"explanation":"Dans un ajustement serré, le diamètre de l''arbre est supérieur à celui de l''alésage, nécessitant un emmanchement à la presse."},
    {"id":"q6","question":"Le cartouche se place :","options":["En haut à gauche","En bas à droite","Au centre","N''importe où"],"correct":1,"explanation":"Par convention normalisée, le cartouche se place en bas à droite de la feuille de dessin."},
    {"id":"q7","question":"Une liaison encastrement permet :","options":["1 rotation","1 translation","Aucun mouvement relatif","6 mouvements"],"correct":2,"explanation":"La liaison encastrement (ou liaison fixe) supprime les 6 degrés de liberté : aucun mouvement relatif n''est possible entre les deux pièces."},
    {"id":"q8","question":"Le repère d''une pièce est relié à la pièce par :","options":["Un trait ondulé","Une flèche fine terminée par un point sur la pièce","Un trait mixte","Une hachure"],"correct":1,"explanation":"Le repère de la pièce est placé dans un cercle relié par une ligne de repère terminée par un point (ou une flèche) touchant la pièce."}
  ]
}');

-- ================================================
-- PHILOSOPHIE (5 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : La conscience et la connaissance (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (philo_id, 'conscience-connaissance', 1, 'La conscience et la connaissance', 'Nature de la conscience, rapport sujet/objet et limites de la connaissance.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'conscience-connaissance-fiche', 'La conscience et la connaissance', 'Conscience de soi, perception et limites du savoir', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la conscience ?","verso":"Faculté par laquelle l''homme se sait exister et penser. La conscience spontanée est immédiate (sentir, percevoir). La conscience réfléchie est un retour sur soi (se savoir pensant).","category":"Définition"},
    {"id":"f2","recto":"Que signifie le Cogito de Descartes ?","verso":"« Je pense, donc je suis » (Cogito ergo sum). Même si je doute de tout, le fait même de douter prouve que je pense et donc que j''existe. C''est la première certitude indubitable.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la conscience morale ?","verso":"Capacité de juger le bien et le mal, de distinguer ce qui est moralement acceptable. Elle produit le sentiment de culpabilité ou de satisfaction morale.","category":"Définition"},
    {"id":"f4","recto":"Quelle est la critique de l''inconscient par Freud ?","verso":"Freud montre que la conscience n''est que la partie émergée du psychisme. L''inconscient (pulsions, souvenirs refoulés) influence nos actes à notre insu, limitant la maîtrise consciente de soi.","category":"Définition"},
    {"id":"f5","recto":"Quelle est la différence entre connaissance empirique et rationnelle ?","verso":"Empirique : fondée sur l''expérience sensible (les sens). Rationnelle : fondée sur la raison et la démonstration logique, indépendante de l''expérience (mathématiques, logique).","category":"Distinction"},
    {"id":"f6","recto":"Qu''est-ce que le doute cartésien ?","verso":"Méthode de Descartes consistant à mettre en doute systématiquement toutes les connaissances (sens trompeurs, rêve, malin génie) pour ne retenir que ce qui est absolument certain.","category":"Méthode"},
    {"id":"f7","recto":"Que dit Socrate sur la connaissance de soi ?","verso":"« Connais-toi toi-même. » Pour Socrate, la sagesse commence par la conscience de sa propre ignorance. Celui qui sait qu''il ne sait pas est plus sage que celui qui croit savoir.","category":"Exemple"},
    {"id":"f8","recto":"Qu''est-ce que l''intentionnalité de la conscience (Husserl) ?","verso":"Toute conscience est conscience de quelque chose. La conscience est toujours dirigée vers un objet (perception, imagination, souvenir). Il n''y a pas de conscience vide.","category":"Définition"}
  ],
  "schema": {
    "title": "La conscience et la connaissance",
    "nodes": [
      {"id":"n1","label":"Conscience et connaissance","type":"main","x":400,"y":50},
      {"id":"n2","label":"Conscience","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Connaissance","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Spontanée / réfléchie","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Morale","type":"leaf","x":200,"y":250},
      {"id":"n6","label":"Inconscient (Freud)","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Empirique","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Rationnelle","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"sujet"},
      {"from":"n1","to":"n3","label":"savoir"},
      {"from":"n2","to":"n4","label":"types"},
      {"from":"n2","to":"n5","label":"valeurs"},
      {"from":"n2","to":"n6","label":"limite"},
      {"from":"n3","to":"n7","label":"expérience"},
      {"from":"n3","to":"n8","label":"raison"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le Cogito de Descartes établit que :","options":["Les sens sont fiables","L''existence de Dieu est certaine","Le fait de penser prouve l''existence","Le monde extérieur existe"],"correct":2,"explanation":"Le Cogito (« Je pense, donc je suis ») établit que la pensée est la première certitude : même en doutant de tout, le sujet pensant ne peut douter de sa propre existence."},
    {"id":"q2","question":"La conscience réfléchie est :","options":["Une réaction spontanée","Un retour de la pensée sur elle-même","L''absence de pensée","Un réflexe biologique"],"correct":1,"explanation":"La conscience réfléchie est la capacité de la pensée à se prendre elle-même pour objet : je sais que je pense, je m''observe pensant."},
    {"id":"q3","question":"Selon Freud, l''inconscient :","options":["N''existe pas","Influence nos comportements à notre insu","Est totalement contrôlable","Est identique à la conscience"],"correct":1,"explanation":"Pour Freud, l''inconscient contient des pulsions et souvenirs refoulés qui influencent nos comportements, rêves et lapsus à notre insu."},
    {"id":"q4","question":"La connaissance empirique est fondée sur :","options":["La raison pure","L''expérience sensible","La révélation","L''intuition"],"correct":1,"explanation":"La connaissance empirique provient de l''expérience sensible : ce que nous apprenons par nos sens (observation, expérimentation)."},
    {"id":"q5","question":"L''injonction « Connais-toi toi-même » est attribuée à :","options":["Platon","Aristote","Socrate","Descartes"],"correct":2,"explanation":"Cette maxime, inscrite au fronton du temple de Delphes, est reprise par Socrate comme point de départ de la sagesse philosophique."},
    {"id":"q6","question":"L''intentionnalité de la conscience signifie que :","options":["La conscience est vide","Toute conscience est conscience de quelque chose","La conscience est inconsciente","La conscience est matérielle"],"correct":1,"explanation":"Husserl définit l''intentionnalité comme la propriété fondamentale de la conscience : elle est toujours dirigée vers un objet."},
    {"id":"q7","question":"Le doute cartésien est :","options":["Un doute sceptique définitif","Un doute méthodique provisoire","Un refus de penser","Une croyance aveugle"],"correct":1,"explanation":"Le doute de Descartes est méthodique (c''est un outil) et provisoire (il vise à trouver une certitude), contrairement au doute sceptique qui doute de tout définitivement."},
    {"id":"q8","question":"La conscience morale permet de :","options":["Calculer des équations","Distinguer le bien et le mal","Percevoir les couleurs","Mémoriser des faits"],"correct":1,"explanation":"La conscience morale est la faculté de juger nos actions et celles d''autrui selon des critères de bien et de mal."}
  ]
}');

-- Chapitre 2 : La science et la vérité
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (philo_id, 'science-verite', 2, 'La science et la vérité', 'Démarche scientifique, critères de vérité et limites de la science.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'science-verite-fiche', 'La science et la vérité', 'Méthode scientifique, vérité et limites', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la vérité en philosophie ?","verso":"Adéquation entre un jugement (ou une proposition) et la réalité. La vérité formelle (logique) est la cohérence interne ; la vérité matérielle est la correspondance avec les faits.","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les étapes de la démarche scientifique ?","verso":"1) Observation. 2) Formulation d''une hypothèse. 3) Expérimentation (test de l''hypothèse). 4) Analyse des résultats. 5) Conclusion (validation ou réfutation). 6) Publication et vérification par les pairs.","category":"Méthode"},
    {"id":"f3","recto":"Qu''est-ce que la falsifiabilité selon Popper ?","verso":"Une théorie est scientifique si et seulement si elle est réfutable (falsifiable), c''est-à-dire qu''on peut concevoir une expérience capable de la contredire. Sinon, elle est dogmatique.","category":"Définition"},
    {"id":"f4","recto":"Quelle est la différence entre opinion et vérité scientifique ?","verso":"L''opinion est subjective, non vérifiée, variable selon les individus. La vérité scientifique est objective, vérifiable, reproductible et universelle (jusqu''à réfutation).","category":"Distinction"},
    {"id":"f5","recto":"Qu''est-ce qu''un paradigme scientifique (Kuhn) ?","verso":"Ensemble de théories, méthodes et valeurs partagées par une communauté scientifique à une époque. Les révolutions scientifiques surviennent quand un paradigme est remplacé par un autre.","category":"Définition"},
    {"id":"f6","recto":"La science peut-elle tout expliquer ?","verso":"Non. La science explique le « comment » (lois naturelles) mais pas le « pourquoi » ultime (sens, valeurs). Les questions morales, esthétiques et métaphysiques échappent à la méthode scientifique.","category":"Distinction"},
    {"id":"f7","recto":"Qu''est-ce que le rationalisme ?","verso":"Courant philosophique affirmant que la raison est la source principale de la connaissance. La vérité se découvre par la démonstration logique. Représentants : Descartes, Leibniz, Spinoza.","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que l''empirisme ?","verso":"Courant philosophique affirmant que toute connaissance vient de l''expérience sensible. L''esprit est une « table rase » (tabula rasa) à la naissance. Représentants : Locke, Hume, Berkeley.","category":"Définition"}
  ],
  "schema": {
    "title": "La science et la vérité",
    "nodes": [
      {"id":"n1","label":"Science et vérité","type":"main","x":400,"y":50},
      {"id":"n2","label":"Démarche scientifique","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Critères de vérité","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Observation / Hypothèse","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Expérimentation","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Falsifiabilité (Popper)","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Paradigme (Kuhn)","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Limites de la science","type":"leaf","x":400,"y":330}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"méthode"},
      {"from":"n1","to":"n3","label":"validité"},
      {"from":"n2","to":"n4","label":"début"},
      {"from":"n2","to":"n5","label":"test"},
      {"from":"n3","to":"n6","label":"réfutabilité"},
      {"from":"n3","to":"n7","label":"cadre"},
      {"from":"n1","to":"n8","label":"questions ouvertes"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Selon Popper, une théorie est scientifique si elle est :","options":["Vérifiable","Falsifiable (réfutable)","Populaire","Ancienne"],"correct":1,"explanation":"Pour Popper, le critère de démarcation entre science et non-science est la falsifiabilité : une théorie scientifique doit pouvoir être réfutée par l''expérience."},
    {"id":"q2","question":"La démarche scientifique commence par :","options":["La conclusion","L''observation","La publication","La théorie"],"correct":1,"explanation":"La démarche scientifique commence par l''observation d''un phénomène, qui conduit à formuler une question puis une hypothèse à tester."},
    {"id":"q3","question":"Un paradigme (Kuhn) est :","options":["Une expérience","Un ensemble de théories partagées par une communauté scientifique","Un instrument de mesure","Une opinion"],"correct":1,"explanation":"Le paradigme (Kuhn) est le cadre théorique dominant à une époque, partagé par la communauté scientifique, qui guide la recherche."},
    {"id":"q4","question":"L''empirisme affirme que la connaissance vient de :","options":["La raison pure","L''expérience sensible","La révélation divine","L''intuition"],"correct":1,"explanation":"L''empirisme (Locke, Hume) soutient que toute connaissance provient de l''expérience sensible et que l''esprit est une table rase à la naissance."},
    {"id":"q5","question":"Le rationalisme est représenté par :","options":["Locke et Hume","Descartes et Leibniz","Marx et Engels","Freud et Jung"],"correct":1,"explanation":"Le rationalisme (Descartes, Leibniz, Spinoza) affirme que la raison est la source principale de la connaissance vraie."},
    {"id":"q6","question":"La vérité formelle concerne :","options":["La correspondance avec les faits","La cohérence logique interne","L''opinion de la majorité","La tradition"],"correct":1,"explanation":"La vérité formelle est la cohérence logique d''un raisonnement (non-contradiction), indépendamment de la correspondance avec la réalité."},
    {"id":"q7","question":"La science ne peut pas répondre aux questions :","options":["Physiques","Chimiques","Morales et métaphysiques","Biologiques"],"correct":2,"explanation":"La science explique le « comment » des phénomènes naturels, mais les questions de sens, de valeurs et de morale relèvent de la philosophie, de l''éthique et de la métaphysique."},
    {"id":"q8","question":"Une opinion se distingue d''une vérité scientifique par :","options":["Sa rigueur","Son caractère subjectif et non vérifié","Sa précision","Son universalité"],"correct":1,"explanation":"L''opinion est subjective, personnelle et non soumise à vérification expérimentale, contrairement à la vérité scientifique qui est objective et reproductible."}
  ]
}');

-- Chapitre 3 : La liberté et la responsabilité
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (philo_id, 'liberte-responsabilite', 3, 'La liberté et la responsabilité', 'Libre arbitre, déterminisme, engagement et responsabilité morale.', 3)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'liberte-responsabilite-fiche', 'La liberté et la responsabilité', 'Libre arbitre, déterminisme et engagement', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la liberté en philosophie ?","verso":"Capacité d''agir selon sa propre volonté, sans contrainte extérieure ni intérieure. On distingue liberté physique (mouvement), liberté civile (droits) et liberté morale (autonomie de la volonté).","category":"Définition"},
    {"id":"f2","recto":"Qu''est-ce que le libre arbitre ?","verso":"Pouvoir de la volonté de se déterminer elle-même, de choisir entre plusieurs possibilités. C''est la capacité de dire oui ou non, indépendamment des causes extérieures.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que le déterminisme ?","verso":"Doctrine selon laquelle tout événement est déterminé par des causes antérieures. Si tout est causé, le libre arbitre serait une illusion (Spinoza : « les hommes se croient libres parce qu''ils ignorent les causes »).","category":"Définition"},
    {"id":"f4","recto":"Que dit Sartre sur la liberté ?","verso":"« L''homme est condamné à être libre. » Pour Sartre, l''existence précède l''essence : l''homme n''a pas de nature prédéfinie, il se fait par ses choix. La liberté est absolue et angoissante.","category":"Exemple"},
    {"id":"f5","recto":"Qu''est-ce que la responsabilité ?","verso":"Obligation de répondre de ses actes et d''en assumer les conséquences. La responsabilité suppose la liberté : on n''est responsable que si l''on pouvait agir autrement.","category":"Définition"},
    {"id":"f6","recto":"Quelle est la différence entre liberté et licence ?","verso":"La liberté est l''exercice raisonné de sa volonté dans le respect des lois et d''autrui. La licence est l''absence de toute règle, la liberté sans limite qui mène à l''anarchie.","category":"Distinction"},
    {"id":"f7","recto":"Qu''est-ce que l''autonomie selon Kant ?","verso":"Capacité de se donner à soi-même sa propre loi morale par la raison. L''homme autonome agit par devoir et non par inclination. Opposé : hétéronomie (soumission à des causes extérieures).","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que l''engagement selon Sartre ?","verso":"L''homme libre doit s''engager dans le monde par ses choix et ses actions. Ne pas choisir est encore un choix. L''engagement est la traduction concrète de la liberté et de la responsabilité.","category":"Définition"}
  ],
  "schema": {
    "title": "Liberté et responsabilité",
    "nodes": [
      {"id":"n1","label":"Liberté et responsabilité","type":"main","x":400,"y":50},
      {"id":"n2","label":"Liberté","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Responsabilité","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Libre arbitre","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Déterminisme","type":"leaf","x":200,"y":250},
      {"id":"n6","label":"Autonomie (Kant)","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Engagement (Sartre)","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Conséquences","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"pouvoir"},
      {"from":"n1","to":"n3","label":"devoir"},
      {"from":"n2","to":"n4","label":"choix"},
      {"from":"n2","to":"n5","label":"critique"},
      {"from":"n2","to":"n6","label":"raison"},
      {"from":"n3","to":"n7","label":"action"},
      {"from":"n3","to":"n8","label":"assumer"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Selon Sartre, l''homme est :","options":["Déterminé par sa nature","Condamné à être libre","Libre seulement en pensée","Soumis au destin"],"correct":1,"explanation":"Pour Sartre, l''existence précède l''essence : l''homme n''a pas de nature fixe, il est condamné à être libre et à se définir par ses choix."},
    {"id":"q2","question":"Le déterminisme affirme que :","options":["L''homme est totalement libre","Tout événement a des causes qui le déterminent","Le hasard gouverne tout","La volonté est toute-puissante"],"correct":1,"explanation":"Le déterminisme soutient que tout est causé par des facteurs antérieurs, ce qui remet en question la possibilité du libre arbitre."},
    {"id":"q3","question":"L''autonomie selon Kant signifie :","options":["Obéir aux autres","Se donner sa propre loi morale par la raison","Faire ce qu''on veut","Rejeter toute loi"],"correct":1,"explanation":"Pour Kant, l''autonomie est la capacité de la volonté rationnelle à se donner sa propre loi morale (l''impératif catégorique), sans soumission à des influences extérieures."},
    {"id":"q4","question":"La responsabilité suppose :","options":["L''ignorance","La contrainte","La liberté","L''instinct"],"correct":2,"explanation":"On n''est responsable que si l''on est libre : la responsabilité suppose qu''on pouvait agir autrement et qu''on a choisi librement."},
    {"id":"q5","question":"La licence se distingue de la liberté par :","options":["Le respect des lois","L''absence de toute règle","La maîtrise de soi","La raison"],"correct":1,"explanation":"La licence est la liberté sans limite ni règle, contrairement à la vraie liberté qui s''exerce dans le respect des lois et d''autrui."},
    {"id":"q6","question":"Spinoza pense que les hommes se croient libres parce qu''ils :","options":["Sont vraiment libres","Ignorent les causes qui les déterminent","Connaissent toutes les lois","Maîtrisent leur destin"],"correct":1,"explanation":"Pour Spinoza, le sentiment de liberté est une illusion née de l''ignorance des causes (naturelles, psychologiques) qui déterminent nos actions."},
    {"id":"q7","question":"L''engagement chez Sartre est :","options":["Facultatif","Obligatoire car ne pas choisir est encore un choix","Impossible","Réservé aux philosophes"],"correct":1,"explanation":"Pour Sartre, l''homme libre ne peut échapper à l''engagement : même l''abstention est un choix dont on est responsable."},
    {"id":"q8","question":"L''hétéronomie est le contraire de :","options":["La liberté","L''autonomie","La responsabilité","La connaissance"],"correct":1,"explanation":"L''hétéronomie (soumission à une loi extérieure) est le contraire de l''autonomie (se donner sa propre loi morale par la raison) chez Kant."}
  ]
}');

-- Chapitre 4 : Étude d'œuvres de penseurs
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (philo_id, 'oeuvres-penseurs', 4, 'Étude d''œuvres de penseurs', 'Analyse d''extraits de textes philosophiques classiques et africains.', 4)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'oeuvres-penseurs-fiche', 'Étude d''œuvres de penseurs', 'Penseurs classiques et africains', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quelle est la thèse principale du Discours de la méthode de Descartes ?","verso":"Descartes propose 4 règles pour bien conduire sa raison : évidence, analyse, synthèse et dénombrement. Il fonde la certitude sur le Cogito et affirme la primauté de la raison.","category":"Exemple"},
    {"id":"f2","recto":"Que soutient Platon dans l''allégorie de la caverne ?","verso":"Les hommes sont comme des prisonniers enchaînés dans une caverne, prenant des ombres pour la réalité. Le philosophe sort de la caverne et accède au monde des Idées (la vérité).","category":"Exemple"},
    {"id":"f3","recto":"Quelle est la pensée d''Aristote sur le bonheur ?","verso":"Le bonheur (eudaimonia) est le souverain bien, la fin ultime de l''action humaine. Il se réalise dans l''activité vertueuse de l''âme conformément à la raison (Éthique à Nicomaque).","category":"Exemple"},
    {"id":"f4","recto":"Que dit Rousseau dans le Contrat social ?","verso":"L''homme naît libre mais vit en société sous des chaînes. Le contrat social est l''accord par lequel chacun aliène sa liberté naturelle en échange de la liberté civile et de la protection collective.","category":"Exemple"},
    {"id":"f5","recto":"Quelle est la contribution de Cheikh Anta Diop à la philosophie africaine ?","verso":"Historien et anthropologue sénégalais, Diop a démontré l''antériorité des civilisations africaines (Égypte noire) et contribué à réhabiliter la pensée et l''histoire africaines.","category":"Exemple"},
    {"id":"f6","recto":"Qu''est-ce que la négritude (Senghor, Césaire) ?","verso":"Mouvement littéraire et philosophique affirmant la dignité et les valeurs culturelles des peuples noirs. Senghor : « l''émotion est nègre, la raison hellène » (critique du rationalisme exclusif).","category":"Exemple"},
    {"id":"f7","recto":"Que dit Kant sur le devoir moral ?","verso":"Le devoir moral est un impératif catégorique : « Agis de telle sorte que la maxime de ton action puisse être érigée en loi universelle. » Le devoir prime sur les inclinations.","category":"Exemple"},
    {"id":"f8","recto":"Comment analyser un texte philosophique ?","verso":"1) Identifier le thème et la thèse. 2) Dégager la structure argumentative. 3) Repérer les concepts-clés. 4) Expliciter les arguments. 5) Confronter avec d''autres penseurs. 6) Évaluer la pertinence.","category":"Méthode"}
  ],
  "schema": {
    "title": "Étude d''œuvres de penseurs",
    "nodes": [
      {"id":"n1","label":"Œuvres philosophiques","type":"main","x":400,"y":50},
      {"id":"n2","label":"Penseurs classiques","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Penseurs africains","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Descartes, Platon","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Kant, Rousseau","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Aristote","type":"leaf","x":150,"y":320},
      {"id":"n7","label":"Cheikh Anta Diop","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Senghor, Césaire","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"tradition occidentale"},
      {"from":"n1","to":"n3","label":"tradition africaine"},
      {"from":"n2","to":"n4","label":"raison"},
      {"from":"n2","to":"n5","label":"morale et société"},
      {"from":"n2","to":"n6","label":"bonheur"},
      {"from":"n3","to":"n7","label":"histoire"},
      {"from":"n3","to":"n8","label":"négritude"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"L''allégorie de la caverne est de :","options":["Aristote","Descartes","Platon","Kant"],"correct":2,"explanation":"L''allégorie de la caverne se trouve dans La République de Platon (livre VII). Elle illustre le passage de l''ignorance à la connaissance."},
    {"id":"q2","question":"Le Cogito (« Je pense, donc je suis ») est de :","options":["Platon","Descartes","Socrate","Hegel"],"correct":1,"explanation":"Le Cogito est formulé par Descartes dans le Discours de la méthode (1637) et les Méditations métaphysiques (1641)."},
    {"id":"q3","question":"Le contrat social est un concept développé par :","options":["Marx","Nietzsche","Rousseau","Freud"],"correct":2,"explanation":"Jean-Jacques Rousseau développe la théorie du contrat social dans Du Contrat social (1762)."},
    {"id":"q4","question":"L''impératif catégorique est formulé par :","options":["Hume","Kant","Hegel","Locke"],"correct":1,"explanation":"Kant formule l''impératif catégorique dans la Critique de la raison pratique et les Fondements de la métaphysique des mœurs."},
    {"id":"q5","question":"Cheikh Anta Diop est connu pour avoir démontré :","options":["L''inexistence de l''Afrique","L''antériorité des civilisations africaines","La supériorité de l''Occident","L''inutilité de l''histoire"],"correct":1,"explanation":"Cheikh Anta Diop, dans Nations nègres et culture, a démontré l''antériorité et l''importance des civilisations africaines, notamment l''Égypte ancienne."},
    {"id":"q6","question":"La négritude est un mouvement fondé par :","options":["Descartes et Leibniz","Senghor, Césaire et Damas","Marx et Engels","Kant et Hegel"],"correct":1,"explanation":"La négritude est un mouvement littéraire et philosophique fondé dans les années 1930 par Aimé Césaire, Léopold Sédar Senghor et Léon-Gontran Damas."},
    {"id":"q7","question":"Pour Aristote, le bonheur est :","options":["Le plaisir immédiat","La richesse matérielle","L''activité vertueuse de l''âme","L''absence de souffrance"],"correct":2,"explanation":"Pour Aristote, le bonheur (eudaimonia) est le souverain bien, réalisé par l''activité vertueuse de l''âme conformément à la raison."},
    {"id":"q8","question":"Analyser un texte philosophique commence par :","options":["Donner son opinion","Identifier le thème et la thèse","Critiquer l''auteur","Résumer le texte en une phrase"],"correct":1,"explanation":"L''analyse d''un texte philosophique commence par identifier le thème (de quoi il parle) et la thèse (ce que l''auteur soutient)."}
  ]
}');

-- Chapitre 5 : Méthodologie philosophique
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (philo_id, 'methodologie-philo', 5, 'Méthodologie philosophique', 'Commentaire de texte et dissertation philosophique.', 5)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'methodologie-philo-fiche', 'Méthodologie philosophique', 'Commentaire de texte et dissertation', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quelles sont les étapes du commentaire de texte philosophique ?","verso":"1) Introduction (auteur, œuvre, thème, thèse, plan). 2) Explication linéaire ou thématique du texte. 3) Discussion critique (confrontation avec d''autres thèses). 4) Conclusion (bilan et ouverture).","category":"Méthode"},
    {"id":"f2","recto":"Quelles sont les étapes de la dissertation philosophique ?","verso":"1) Introduction (amorce, problématique, annonce du plan). 2) Développement (thèse, antithèse, synthèse ou plan progressif). 3) Conclusion (bilan, réponse à la problématique, ouverture).","category":"Méthode"},
    {"id":"f3","recto":"Qu''est-ce qu''une problématique ?","verso":"Question philosophique soulevée par le sujet, qui met en tension des thèses opposées. Elle transforme le sujet en un problème à résoudre par l''argumentation.","category":"Définition"},
    {"id":"f4","recto":"Comment formuler une bonne introduction ?","verso":"1) Amorce (entrée en matière par un exemple, une citation, un fait). 2) Analyse des termes du sujet. 3) Formulation de la problématique. 4) Annonce du plan.","category":"Méthode"},
    {"id":"f5","recto":"Quelle est la différence entre thèse, antithèse et synthèse ?","verso":"Thèse : position initiale soutenue. Antithèse : position contraire qui conteste la thèse. Synthèse : dépassement qui intègre les apports des deux positions en les réconciliant.","category":"Distinction"},
    {"id":"f6","recto":"Comment utiliser un exemple philosophique ?","verso":"L''exemple illustre un argument, il ne le remplace pas. Il doit être précis (auteur, œuvre, contexte) et suivi d''une analyse montrant en quoi il soutient l''argument.","category":"Méthode"},
    {"id":"f7","recto":"Qu''est-ce qu''un argument d''autorité ?","verso":"Argument qui s''appuie sur la pensée d''un philosophe reconnu pour soutenir une thèse. Il est valide s''il est pertinent et bien expliqué, mais insuffisant seul (il faut aussi raisonner).","category":"Définition"},
    {"id":"f8","recto":"Comment conclure une dissertation ?","verso":"1) Bilan : résumer les étapes du raisonnement. 2) Réponse : donner une réponse claire à la problématique. 3) Ouverture : élargir la réflexion vers un nouveau problème connexe.","category":"Méthode"}
  ],
  "schema": {
    "title": "Méthodologie philosophique",
    "nodes": [
      {"id":"n1","label":"Méthodologie","type":"main","x":400,"y":50},
      {"id":"n2","label":"Dissertation","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Commentaire de texte","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Introduction","type":"leaf","x":50,"y":250},
      {"id":"n5","label":"Thèse / Antithèse / Synthèse","type":"leaf","x":225,"y":250},
      {"id":"n6","label":"Conclusion","type":"leaf","x":375,"y":250},
      {"id":"n7","label":"Explication linéaire","type":"leaf","x":525,"y":250},
      {"id":"n8","label":"Discussion critique","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"sujet"},
      {"from":"n1","to":"n3","label":"texte"},
      {"from":"n2","to":"n4","label":"problématique"},
      {"from":"n2","to":"n5","label":"plan"},
      {"from":"n2","to":"n6","label":"bilan"},
      {"from":"n3","to":"n7","label":"analyse"},
      {"from":"n3","to":"n8","label":"évaluation"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La problématique d''une dissertation est :","options":["La réponse au sujet","La question philosophique soulevée par le sujet","Le résumé du sujet","La conclusion"],"correct":1,"explanation":"La problématique est la question fondamentale que le sujet pose, mettant en tension des positions opposées qu''il faudra examiner."},
    {"id":"q2","question":"Le plan thèse-antithèse-synthèse est dit :","options":["Analytique","Dialectique","Chronologique","Descriptif"],"correct":1,"explanation":"Le plan dialectique (thèse-antithèse-synthèse) examine une position, sa contestation, puis tente un dépassement qui intègre les deux."},
    {"id":"q3","question":"L''introduction d''une dissertation contient :","options":["Seulement le sujet","Amorce, problématique et annonce du plan","La réponse finale","Les exemples"],"correct":1,"explanation":"L''introduction comporte une amorce (entrée en matière), l''analyse du sujet, la formulation de la problématique et l''annonce du plan."},
    {"id":"q4","question":"Le commentaire de texte commence par identifier :","options":["Les fautes de l''auteur","L''auteur, le thème et la thèse du texte","Les exemples","La conclusion"],"correct":1,"explanation":"Le commentaire commence par situer le texte (auteur, œuvre) puis identifier le thème (sujet) et la thèse (position défendue par l''auteur)."},
    {"id":"q5","question":"Un exemple en philosophie doit être :","options":["Vague et général","Précis et suivi d''une analyse","Le seul argument","Inventé"],"correct":1,"explanation":"Un bon exemple philosophique est précis (auteur, situation, contexte) et toujours accompagné d''une analyse montrant son lien avec l''argument."},
    {"id":"q6","question":"La synthèse dans un plan dialectique vise à :","options":["Répéter la thèse","Contredire l''antithèse","Dépasser la contradiction en intégrant les deux positions","Ignorer le problème"],"correct":2,"explanation":"La synthèse ne choisit pas un camp mais dépasse la contradiction en proposant une position plus nuancée qui intègre les apports de la thèse et de l''antithèse."},
    {"id":"q7","question":"La conclusion d''une dissertation doit :","options":["Poser de nouvelles questions sans répondre","Donner une réponse à la problématique","Simplement résumer l''introduction","Éviter toute prise de position"],"correct":1,"explanation":"La conclusion doit offrir une réponse claire à la problématique posée en introduction, en faisant le bilan du raisonnement développé."},
    {"id":"q8","question":"L''amorce d''une introduction est :","options":["La problématique","L''annonce du plan","L''entrée en matière qui accroche le lecteur","La définition des termes"],"correct":2,"explanation":"L''amorce est la première phrase qui introduit le sujet de manière engageante (exemple, citation, fait d''actualité) pour capter l''attention du lecteur."}
  ]
}');

-- ================================================
-- ANGLAIS (4 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : Oral communication (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (anglais_id, 'oral-communication', 1, 'Oral Communication', 'Speaking skills, presentations and debates for scientific contexts.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'oral-communication-fiche', 'Oral Communication', 'Speaking, debating and presenting in English', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"What are the key elements of a good oral presentation?","verso":"1) Clear introduction with topic statement. 2) Logical structure (main points). 3) Supporting evidence/examples. 4) Confident delivery (eye contact, pace). 5) Strong conclusion with summary.","category":"Méthode"},
    {"id":"f2","recto":"How do you introduce yourself in a formal context?","verso":"\"Good morning/afternoon. My name is [name]. I am a student at [school]. Today, I would like to talk about [topic].\" Use polite, formal register.","category":"Exemple"},
    {"id":"f3","recto":"What is the difference between formal and informal English?","verso":"Formal: complete sentences, no contractions, polite expressions (\"I would like to...\"). Informal: contractions (\"I''d like to\"), slang, shorter sentences, casual tone.","category":"Distinction"},
    {"id":"f4","recto":"How do you express opinions in English?","verso":"\"In my opinion...\", \"I believe that...\", \"From my point of view...\", \"As far as I am concerned...\", \"I am convinced that...\". Avoid \"I think\" repetition.","category":"Méthode"},
    {"id":"f5","recto":"How do you agree and disagree politely?","verso":"Agree: \"I totally agree\", \"That''s a good point\", \"I share that view\". Disagree: \"I see your point, but...\", \"I''m afraid I disagree\", \"I understand, however...\".","category":"Méthode"},
    {"id":"f6","recto":"What are connectors for oral presentations?","verso":"Sequence: first, then, next, finally. Addition: moreover, furthermore, in addition. Contrast: however, nevertheless, on the other hand. Conclusion: in conclusion, to sum up.","category":"Définition"},
    {"id":"f7","recto":"How do you describe a scientific process in English?","verso":"Use passive voice (\"The solution is heated to 100°C\"), sequence words (\"First... Then... After that...\"), and precise scientific vocabulary. Present tense for general processes.","category":"Méthode"},
    {"id":"f8","recto":"What are common pronunciation mistakes for French speakers?","verso":"The /h/ sound (\"house\" not \"ouse\"), the /th/ sounds (/θ/ as in \"think\", /ð/ as in \"this\"), vowel sounds (/i:/ vs /ɪ/ as in \"sheep\" vs \"ship\"), and word stress patterns.","category":"Exemple"}
  ],
  "schema": {
    "title": "Oral Communication",
    "nodes": [
      {"id":"n1","label":"Oral Communication","type":"main","x":400,"y":50},
      {"id":"n2","label":"Presentation","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Debate","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Structure","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Delivery","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Opinion & Agreement","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Connectors","type":"leaf","x":650,"y":250},
      {"id":"n8","label":"Register (formal/informal)","type":"leaf","x":400,"y":300}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"monologue"},
      {"from":"n1","to":"n3","label":"interaction"},
      {"from":"n2","to":"n4","label":"organisation"},
      {"from":"n2","to":"n5","label":"performance"},
      {"from":"n3","to":"n6","label":"expression"},
      {"from":"n3","to":"n7","label":"cohérence"},
      {"from":"n1","to":"n8","label":"adaptation"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Which expression is formal for giving an opinion?","options":["I think...","In my opinion...","Like, you know...","I guess..."],"correct":1,"explanation":"\"In my opinion\" is a formal expression for giving opinions. \"I think\" is neutral, while \"like, you know\" and \"I guess\" are informal."},
    {"id":"q2","question":"A polite way to disagree is:","options":["You''re wrong!","That''s stupid","I see your point, but...","No way!"],"correct":2,"explanation":"\"I see your point, but...\" acknowledges the other person''s view before presenting a different perspective, which is polite and diplomatic."},
    {"id":"q3","question":"Which connector expresses contrast?","options":["Moreover","Furthermore","However","In addition"],"correct":2,"explanation":"\"However\" introduces a contrasting idea. \"Moreover\", \"furthermore\" and \"in addition\" all express addition."},
    {"id":"q4","question":"In scientific English, processes are often described using:","options":["Active voice only","Passive voice","Future tense only","Imperative mood"],"correct":1,"explanation":"Scientific processes are typically described using passive voice (e.g., \"The mixture is heated\") because the focus is on the process, not the person performing it."},
    {"id":"q5","question":"Which sentence is in formal register?","options":["Wanna grab a coffee?","I would like a cup of coffee, please.","Gimme some coffee.","Hey, coffee?"],"correct":1,"explanation":"\"I would like a cup of coffee, please\" uses full verb forms, polite vocabulary and a complete sentence structure, which is characteristic of formal English."},
    {"id":"q6","question":"The /th/ sound in \"think\" is:","options":["Voiced /ð/","Voiceless /θ/","Silent","Pronounced as /t/"],"correct":1,"explanation":"The \"th\" in \"think\" is the voiceless dental fricative /θ/. The voiced version /ð/ appears in words like \"this\", \"that\", \"there\"."},
    {"id":"q7","question":"\"To sum up\" is used to:","options":["Add information","Give an example","Introduce a conclusion","Express contrast"],"correct":2,"explanation":"\"To sum up\" (like \"in conclusion\" and \"to summarise\") is used to introduce the concluding part of a presentation or argument."},
    {"id":"q8","question":"A good presentation should start with:","options":["The conclusion","A clear introduction with the topic","A list of sources","An apology"],"correct":1,"explanation":"A good presentation begins with a clear introduction that states the topic, captures attention and gives an overview of what will be discussed."}
  ]
}');

-- Chapitre 2 : Reading comprehension
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (anglais_id, 'reading-comprehension', 2, 'Reading Comprehension', 'Strategies for understanding and analysing English texts.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'reading-comprehension-fiche', 'Reading Comprehension', 'Strategies for understanding texts', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"What are the main reading strategies?","verso":"1) Skimming: quick reading for general idea. 2) Scanning: searching for specific information. 3) Intensive reading: detailed analysis. 4) Extensive reading: reading for pleasure/fluency.","category":"Méthode"},
    {"id":"f2","recto":"How do you identify the main idea of a text?","verso":"1) Read the title and subtitle. 2) Read the first and last paragraphs. 3) Look for topic sentences (usually first sentence of each paragraph). 4) Identify repeated keywords.","category":"Méthode"},
    {"id":"f3","recto":"What are context clues?","verso":"Information in the text that helps you guess the meaning of unknown words: synonyms, antonyms, definitions, examples, or the general meaning of the surrounding sentences.","category":"Définition"},
    {"id":"f4","recto":"How do you answer comprehension questions?","verso":"1) Read questions first to know what to look for. 2) Locate relevant parts of the text. 3) Answer in your own words (don''t copy). 4) Justify with evidence from the text.","category":"Méthode"},
    {"id":"f5","recto":"What is the difference between explicit and implicit information?","verso":"Explicit: directly stated in the text (\"The author says...\"). Implicit: suggested or implied, requiring inference from context (\"The author implies/suggests...\").","category":"Distinction"},
    {"id":"f6","recto":"What are text types?","verso":"Narrative (tells a story), descriptive (describes a scene/object), argumentative (defends a position), expository (explains/informs), instructional (gives directions).","category":"Définition"},
    {"id":"f7","recto":"How do you identify the author''s tone?","verso":"Look for emotional words, adjectives, and language choices. Tones include: objective/neutral, critical, enthusiastic, ironic, pessimistic, optimistic, persuasive.","category":"Méthode"},
    {"id":"f8","recto":"What are common prefixes and suffixes in English?","verso":"Prefixes: un- (not), re- (again), pre- (before), dis- (opposite), mis- (wrong). Suffixes: -tion (noun), -ly (adverb), -able (adjective), -ment (noun), -ful (full of).","category":"Définition"}
  ],
  "schema": {
    "title": "Reading Comprehension",
    "nodes": [
      {"id":"n1","label":"Reading Comprehension","type":"main","x":400,"y":50},
      {"id":"n2","label":"Strategies","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Analysis","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Skimming / Scanning","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Context clues","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Main idea / Details","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Tone / Purpose","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"how to read"},
      {"from":"n1","to":"n3","label":"how to understand"},
      {"from":"n2","to":"n4","label":"speed reading"},
      {"from":"n2","to":"n5","label":"vocabulary"},
      {"from":"n3","to":"n6","label":"content"},
      {"from":"n3","to":"n7","label":"interpretation"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Skimming is reading to find:","options":["Specific details","The general idea","Grammar mistakes","Word meanings"],"correct":1,"explanation":"Skimming is a quick reading technique to get the general idea or gist of a text without reading every word."},
    {"id":"q2","question":"A topic sentence is usually found:","options":["At the end of a paragraph","In the middle","At the beginning of a paragraph","In the title only"],"correct":2,"explanation":"The topic sentence, which states the main idea of a paragraph, is usually the first sentence."},
    {"id":"q3","question":"Context clues help you to:","options":["Write faster","Guess the meaning of unknown words","Correct grammar","Improve pronunciation"],"correct":1,"explanation":"Context clues are surrounding words, phrases and sentences that help you deduce the meaning of unfamiliar vocabulary."},
    {"id":"q4","question":"Implicit information is:","options":["Directly stated","Suggested or implied","Always false","In the title"],"correct":1,"explanation":"Implicit information is not directly stated but suggested through context. The reader must infer meaning from clues in the text."},
    {"id":"q5","question":"An argumentative text aims to:","options":["Tell a story","Describe a scene","Defend a position or opinion","Give instructions"],"correct":2,"explanation":"An argumentative text presents and defends a position using evidence, reasoning and persuasive language."},
    {"id":"q6","question":"The prefix \"un-\" means:","options":["Again","Before","Not / opposite","Wrong"],"correct":2,"explanation":"The prefix \"un-\" negates the meaning: unhappy = not happy, unable = not able, unfair = not fair."},
    {"id":"q7","question":"Scanning is reading to find:","options":["The general idea","Specific information","The author''s name","Grammatical errors"],"correct":1,"explanation":"Scanning is a targeted reading technique to find specific information quickly (a name, date, number, keyword)."},
    {"id":"q8","question":"When answering comprehension questions, you should:","options":["Copy sentences from the text","Answer in your own words with text evidence","Guess without reading","Only write yes or no"],"correct":1,"explanation":"Good practice is to answer in your own words (showing understanding) while supporting your answer with evidence from the text."}
  ]
}');

-- Chapitre 3 : Writing skills
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (anglais_id, 'writing-skills', 3, 'Writing Skills', 'Essay writing, letter writing and structured composition.', 3)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'writing-skills-fiche', 'Writing Skills', 'Essays, letters and compositions', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"What is the structure of an essay?","verso":"1) Introduction (hook, background, thesis statement). 2) Body paragraphs (topic sentence, supporting details, examples). 3) Conclusion (summary, restated thesis, final thought).","category":"Méthode"},
    {"id":"f2","recto":"What is a thesis statement?","verso":"A clear, concise sentence (usually at the end of the introduction) that states the main argument or position of the essay. It guides the entire essay.","category":"Définition"},
    {"id":"f3","recto":"How do you write a formal letter?","verso":"1) Sender''s address (top right). 2) Date. 3) Recipient''s address (left). 4) Dear Sir/Madam. 5) Body paragraphs. 6) Yours faithfully (if unknown) / Yours sincerely (if named).","category":"Méthode"},
    {"id":"f4","recto":"What are linking words for essays?","verso":"Cause: because, since, due to. Effect: therefore, consequently, as a result. Addition: moreover, furthermore. Contrast: however, although, whereas. Example: for instance, such as.","category":"Définition"},
    {"id":"f5","recto":"What is the difference between formal and informal letters?","verso":"Formal: Dear Sir/Madam, Yours faithfully, full sentences, no contractions. Informal: Dear [name], Best wishes/Love, contractions allowed, casual tone.","category":"Distinction"},
    {"id":"f6","recto":"How do you write a good paragraph?","verso":"PEEL method: Point (topic sentence), Evidence (facts, quotes, data), Explanation (analyse the evidence), Link (connect back to the main argument or thesis).","category":"Méthode"},
    {"id":"f7","recto":"What are common writing mistakes to avoid?","verso":"1) Run-on sentences. 2) Subject-verb disagreement. 3) Mixing tenses. 4) Spelling errors. 5) No paragraph structure. 6) Repetitive vocabulary. 7) No linking words.","category":"Méthode"},
    {"id":"f8","recto":"How do you write about advantages and disadvantages?","verso":"Structure: Introduction (topic). Paragraph 1: advantages (On the one hand... Firstly... Moreover...). Paragraph 2: disadvantages (On the other hand... However...). Conclusion: balanced opinion.","category":"Méthode"}
  ],
  "schema": {
    "title": "Writing Skills",
    "nodes": [
      {"id":"n1","label":"Writing Skills","type":"main","x":400,"y":50},
      {"id":"n2","label":"Essay","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Letter","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Introduction / Body / Conclusion","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"PEEL paragraphs","type":"leaf","x":275,"y":250},
      {"id":"n6","label":"Formal","type":"leaf","x":525,"y":250},
      {"id":"n7","label":"Informal","type":"leaf","x":675,"y":250},
      {"id":"n8","label":"Linking words","type":"leaf","x":400,"y":320}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"argumentation"},
      {"from":"n1","to":"n3","label":"correspondence"},
      {"from":"n2","to":"n4","label":"structure"},
      {"from":"n2","to":"n5","label":"development"},
      {"from":"n3","to":"n6","label":"professional"},
      {"from":"n3","to":"n7","label":"personal"},
      {"from":"n1","to":"n8","label":"coherence"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"A thesis statement is placed:","options":["At the end of the essay","In the conclusion","At the end of the introduction","In every paragraph"],"correct":2,"explanation":"The thesis statement is typically the last sentence of the introduction, clearly stating the main argument or position of the essay."},
    {"id":"q2","question":"A formal letter ends with \"Yours faithfully\" when:","options":["You know the person''s name","You don''t know the person''s name","It''s an informal letter","It''s an email"],"correct":1,"explanation":"\"Yours faithfully\" is used when you don''t know the recipient''s name (Dear Sir/Madam). \"Yours sincerely\" is used when you know the name."},
    {"id":"q3","question":"The PEEL method stands for:","options":["Plan, Edit, Evaluate, Learn","Point, Evidence, Explanation, Link","Prepare, Execute, Examine, List","Paragraph, Essay, Exercise, Language"],"correct":1,"explanation":"PEEL is a paragraph structure: Point (topic sentence), Evidence (support), Explanation (analysis), Link (connection to thesis)."},
    {"id":"q4","question":"\"Consequently\" expresses:","options":["Addition","Contrast","Cause and effect","Example"],"correct":2,"explanation":"\"Consequently\" (like \"therefore\" and \"as a result\") is a linking word that introduces a consequence or effect."},
    {"id":"q5","question":"A run-on sentence is:","options":["A very short sentence","Two independent clauses joined without proper punctuation","A question","A fragment"],"correct":1,"explanation":"A run-on sentence occurs when two or more independent clauses are joined without proper punctuation or conjunction."},
    {"id":"q6","question":"An essay introduction should contain:","options":["Only the thesis","Hook, background and thesis statement","All the arguments","The conclusion"],"correct":1,"explanation":"A good introduction includes a hook (attention-grabber), background information on the topic, and a clear thesis statement."},
    {"id":"q7","question":"\"Although\" is used to express:","options":["Addition","Cause","Concession/contrast","Time"],"correct":2,"explanation":"\"Although\" (like \"even though\" and \"whereas\") introduces a concession or contrast between two ideas."},
    {"id":"q8","question":"In a formal letter, the salutation for an unknown recipient is:","options":["Hi there","Dear friend","Dear Sir/Madam","Hey"],"correct":2,"explanation":"\"Dear Sir/Madam\" is the standard formal salutation when the recipient''s name is unknown."}
  ]
}');

-- Chapitre 4 : Grammar and vocabulary
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (anglais_id, 'grammar-vocabulary', 4, 'Grammar and Vocabulary', 'Essential grammar structures and scientific vocabulary.', 4)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'grammar-vocabulary-fiche', 'Grammar and Vocabulary', 'Tenses, conditionals and scientific terms', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"What are the main English tenses?","verso":"Present simple (habits), present continuous (now), past simple (finished action), present perfect (link past-present), future (will/going to). Each has active and passive forms.","category":"Définition"},
    {"id":"f2","recto":"What are the three conditional types?","verso":"Type 1: If + present, will + verb (real/likely). Type 2: If + past, would + verb (unreal present). Type 3: If + past perfect, would have + past participle (unreal past).","category":"Définition"},
    {"id":"f3","recto":"How is the passive voice formed?","verso":"Subject + be (conjugated) + past participle. Ex: \"Water is heated to 100°C\" (present). \"The experiment was conducted\" (past). \"Results will be published\" (future).","category":"Méthode"},
    {"id":"f4","recto":"What are common scientific vocabulary words?","verso":"Experiment, hypothesis, variable, data, result, conclusion, analysis, equation, formula, molecule, atom, cell, energy, force, reaction, solution, temperature, wavelength.","category":"Définition"},
    {"id":"f5","recto":"What is the difference between \"since\" and \"for\"?","verso":"\"Since\" is used with a specific point in time (since 2020, since Monday). \"For\" is used with a duration of time (for 3 years, for 2 hours). Both are used with present perfect.","category":"Distinction"},
    {"id":"f6","recto":"What are reported speech rules?","verso":"Direct → Indirect: present → past, past → past perfect, will → would, can → could. Pronouns and time references also change. Ex: \"I will come\" → He said he would come.","category":"Méthode"},
    {"id":"f7","recto":"What are relative pronouns?","verso":"Who (people), which (things), that (people/things), whose (possession), where (place), when (time). Ex: \"The scientist who discovered DNA\" / \"The lab where we work\".","category":"Définition"},
    {"id":"f8","recto":"What is the difference between \"make\" and \"do\"?","verso":"Make: create/produce (make a decision, make a mistake, make progress). Do: perform/carry out (do homework, do an experiment, do research, do one''s best).","category":"Distinction"}
  ],
  "schema": {
    "title": "Grammar and Vocabulary",
    "nodes": [
      {"id":"n1","label":"Grammar & Vocabulary","type":"main","x":400,"y":50},
      {"id":"n2","label":"Tenses","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Structures","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Vocabulary","type":"branch","x":600,"y":150},
      {"id":"n5","label":"Simple / Continuous / Perfect","type":"leaf","x":100,"y":250},
      {"id":"n6","label":"Conditionals","type":"leaf","x":300,"y":250},
      {"id":"n7","label":"Passive / Reported","type":"leaf","x":450,"y":250},
      {"id":"n8","label":"Scientific terms","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"conjugaison"},
      {"from":"n1","to":"n3","label":"syntax"},
      {"from":"n1","to":"n4","label":"lexique"},
      {"from":"n2","to":"n5","label":"aspects"},
      {"from":"n3","to":"n6","label":"if-clauses"},
      {"from":"n3","to":"n7","label":"transformations"},
      {"from":"n4","to":"n8","label":"science"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"The second conditional uses:","options":["If + present, will + verb","If + past, would + verb","If + past perfect, would have + past participle","If + present, present"],"correct":1,"explanation":"Type 2 conditional (unreal present): If + past simple, would + base verb. Ex: \"If I had a lab, I would do experiments.\""},
    {"id":"q2","question":"The passive of \"Scientists discover cures\" is:","options":["Cures are discovered by scientists","Cures discovered by scientists","Scientists are discovered","Cures discovering scientists"],"correct":0,"explanation":"Passive voice: Object becomes subject + \"be\" + past participle: \"Cures are discovered by scientists.\""},
    {"id":"q3","question":"\"She has lived here _____ 2015\":","options":["for","since","during","while"],"correct":1,"explanation":"\"Since\" is used with a specific point in time (2015). \"For\" would require a duration (e.g., \"for 10 years\")."},
    {"id":"q4","question":"\"I will help you\" in reported speech becomes:","options":["He said he will help me","He said he would help me","He said he helps me","He said he helped me"],"correct":1,"explanation":"In reported speech, \"will\" changes to \"would\": \"I will help you\" → He said he would help me."},
    {"id":"q5","question":"The relative pronoun for possession is:","options":["Who","Which","Whose","Where"],"correct":2,"explanation":"\"Whose\" indicates possession: \"The scientist whose discovery changed the world\" (the scientist''s discovery)."},
    {"id":"q6","question":"\"Do\" is used with:","options":["A mistake","A decision","Research","Progress"],"correct":2,"explanation":"We say \"do research\", \"do homework\", \"do an experiment\". We say \"make a mistake\", \"make a decision\", \"make progress\"."},
    {"id":"q7","question":"The present perfect is used for:","options":["A finished action in the past","An action linking past and present","A future action","A habitual action"],"correct":1,"explanation":"The present perfect (have/has + past participle) expresses an action that started in the past and has relevance to the present."},
    {"id":"q8","question":"\"Which\" is used for:","options":["People only","Things and animals","Places","Time"],"correct":1,"explanation":"\"Which\" is a relative pronoun used for things and animals. \"Who\" is used for people, \"where\" for places, and \"when\" for time."}
  ]
}');

-- ================================================
-- FRANÇAIS (4 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : La dissertation littéraire (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (francais_id, 'dissertation-litteraire', 1, 'La dissertation littéraire', 'Méthodologie de la dissertation littéraire au baccalauréat.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'dissertation-litteraire-fiche', 'La dissertation littéraire', 'Méthodologie et rédaction', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce qu''une dissertation littéraire ?","verso":"Exercice d''argumentation organisée portant sur une question littéraire. Elle exige une réflexion personnelle appuyée sur des connaissances littéraires (œuvres, auteurs, mouvements).","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les étapes de la dissertation ?","verso":"1) Analyse du sujet (termes-clés, présupposés). 2) Problématique. 3) Plan (thèse/antithèse/synthèse ou thématique). 4) Rédaction (intro, développement, conclusion). 5) Relecture.","category":"Méthode"},
    {"id":"f3","recto":"Comment rédiger l''introduction ?","verso":"1) Amorce (citation, fait littéraire). 2) Présentation du sujet (reformulation). 3) Problématique (question centrale). 4) Annonce du plan (grandes parties).","category":"Méthode"},
    {"id":"f4","recto":"Comment construire un argument littéraire ?","verso":"Idée (affirmation) → argument (raisonnement) → exemple littéraire précis (auteur, titre, passage) → analyse de l''exemple → transition vers le point suivant.","category":"Méthode"},
    {"id":"f5","recto":"Qu''est-ce qu''une transition ?","verso":"Phrase(s) reliant deux parties du développement. Elle résume la partie précédente et annonce la suivante, assurant la cohérence du raisonnement.","category":"Définition"},
    {"id":"f6","recto":"Quels sont les types de plans possibles ?","verso":"Dialectique (thèse/antithèse/synthèse), thématique (aspects différents du sujet), analytique (constat/causes/conséquences), chronologique (évolution dans le temps).","category":"Définition"},
    {"id":"f7","recto":"Comment choisir de bons exemples littéraires ?","verso":"Varier : genres (roman, poésie, théâtre), époques (classique, romantisme, moderne), auteurs (français, francophones, africains). Être précis : titre, auteur, passage, date.","category":"Méthode"},
    {"id":"f8","recto":"Comment rédiger la conclusion ?","verso":"1) Bilan synthétique (résumer les grandes étapes du raisonnement). 2) Réponse à la problématique. 3) Ouverture (question connexe, prolongement du sujet).","category":"Méthode"}
  ],
  "schema": {
    "title": "La dissertation littéraire",
    "nodes": [
      {"id":"n1","label":"Dissertation littéraire","type":"main","x":400,"y":50},
      {"id":"n2","label":"Analyse du sujet","type":"branch","x":150,"y":150},
      {"id":"n3","label":"Rédaction","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Argumentation","type":"branch","x":650,"y":150},
      {"id":"n5","label":"Termes-clés, présupposés","type":"leaf","x":100,"y":250},
      {"id":"n6","label":"Introduction / Développement / Conclusion","type":"leaf","x":400,"y":250},
      {"id":"n7","label":"Idée → Argument → Exemple","type":"leaf","x":600,"y":250},
      {"id":"n8","label":"Transitions","type":"leaf","x":750,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"compréhension"},
      {"from":"n1","to":"n3","label":"structure"},
      {"from":"n1","to":"n4","label":"raisonnement"},
      {"from":"n2","to":"n5","label":"décryptage"},
      {"from":"n3","to":"n6","label":"parties"},
      {"from":"n4","to":"n7","label":"méthode"},
      {"from":"n4","to":"n8","label":"cohérence"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La dissertation littéraire est un exercice :","options":["De narration","D''argumentation organisée","De description","De traduction"],"correct":1,"explanation":"La dissertation est un exercice d''argumentation structurée où l''on développe une réflexion personnelle sur un sujet littéraire."},
    {"id":"q2","question":"La problématique est :","options":["La réponse au sujet","La question centrale que pose le sujet","Le résumé de l''œuvre","L''amorce"],"correct":1,"explanation":"La problématique est la question fondamentale soulevée par le sujet, à laquelle le développement tentera de répondre."},
    {"id":"q3","question":"Un plan dialectique comprend :","options":["Introduction et conclusion seulement","Thèse, antithèse, synthèse","Trois exemples","Un seul argument"],"correct":1,"explanation":"Le plan dialectique examine une thèse (position), son antithèse (position contraire) et une synthèse (dépassement des deux)."},
    {"id":"q4","question":"Un bon exemple littéraire doit être :","options":["Vague et général","Précis (auteur, titre, passage)","Inventé","Sans rapport avec l''argument"],"correct":1,"explanation":"Un bon exemple littéraire est précis : il cite l''auteur, le titre de l''œuvre, le passage concerné et est analysé en lien avec l''argument."},
    {"id":"q5","question":"La transition sert à :","options":["Conclure la dissertation","Relier deux parties du développement","Présenter le sujet","Citer un auteur"],"correct":1,"explanation":"La transition assure la cohérence en résumant ce qui précède et en annonçant ce qui suit."},
    {"id":"q6","question":"L''amorce de l''introduction est :","options":["L''annonce du plan","L''entrée en matière (citation, fait)","La problématique","La conclusion"],"correct":1,"explanation":"L''amorce est le tout premier élément de l''introduction : une citation, un fait historique ou littéraire qui introduit le sujet."},
    {"id":"q7","question":"La conclusion doit contenir :","options":["De nouveaux arguments","Un bilan et une réponse à la problématique","La copie de l''introduction","Aucune opinion personnelle"],"correct":1,"explanation":"La conclusion fait le bilan du raisonnement, répond à la problématique et propose une ouverture vers une question connexe."},
    {"id":"q8","question":"Un argument littéraire suit l''ordre :","options":["Exemple → Idée → Analyse","Idée → Argument → Exemple → Analyse","Analyse → Conclusion","Citation → Résumé"],"correct":1,"explanation":"La méthode argumentative suit : Idée (ce qu''on veut montrer) → Argument (le raisonnement) → Exemple (la preuve littéraire) → Analyse (l''explication)."}
  ]
}');

-- Chapitre 2 : Le commentaire composé
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (francais_id, 'commentaire-compose', 2, 'Le commentaire composé', 'Analyse littéraire d''un texte selon des axes de lecture.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'commentaire-compose-fiche', 'Le commentaire composé', 'Analyse méthodique d''un texte littéraire', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce qu''un commentaire composé ?","verso":"Exercice d''analyse littéraire consistant à étudier un texte selon des axes de lecture (thèmes) en montrant comment la forme (style, figures) sert le fond (sens, message).","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les étapes du commentaire composé ?","verso":"1) Lecture attentive du texte. 2) Repérage des procédés stylistiques. 3) Choix de 2-3 axes de lecture. 4) Rédaction organisée (intro, axes, conclusion). 5) Relecture.","category":"Méthode"},
    {"id":"f3","recto":"Qu''est-ce qu''un axe de lecture ?","verso":"Angle d''analyse thématique regroupant plusieurs procédés convergents. Ex : « La puissance de la nature » ou « Un portrait satirique ». Chaque axe constitue une grande partie du commentaire.","category":"Définition"},
    {"id":"f4","recto":"Quelles sont les principales figures de style ?","verso":"Métaphore, comparaison, personnification, hyperbole, litote, antithèse, oxymore, anaphore, chiasme, gradation, allégorie, métonymie.","category":"Définition"},
    {"id":"f5","recto":"Comment analyser un procédé stylistique ?","verso":"1) Identifier le procédé (ex : métaphore). 2) Le citer dans le texte (avec guillemets). 3) Expliquer son effet sur le sens (ce qu''il apporte à la signification, à l''émotion).","category":"Méthode"},
    {"id":"f6","recto":"Quelle est la différence entre fond et forme ?","verso":"Le fond : le contenu, les idées, le message, les thèmes du texte. La forme : les moyens d''expression (figures de style, rythme, sonorités, structure, registre, type de phrases).","category":"Distinction"},
    {"id":"f7","recto":"Quels sont les registres littéraires ?","verso":"Tragique (destin fatal), comique (rire), lyrique (sentiments personnels), épique (héroïsme), pathétique (compassion), satirique (critique moqueuse), fantastique (surnaturel).","category":"Définition"},
    {"id":"f8","recto":"Comment rédiger l''introduction du commentaire ?","verso":"1) Amorce (contexte littéraire). 2) Présentation du texte (auteur, œuvre, genre, date). 3) Bref résumé ou situation du passage. 4) Annonce des axes de lecture.","category":"Méthode"}
  ],
  "schema": {
    "title": "Le commentaire composé",
    "nodes": [
      {"id":"n1","label":"Commentaire composé","type":"main","x":400,"y":50},
      {"id":"n2","label":"Analyse du texte","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Rédaction","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Procédés stylistiques","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Axes de lecture","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Registres","type":"leaf","x":175,"y":320},
      {"id":"n7","label":"Introduction / Développement","type":"leaf","x":500,"y":250},
      {"id":"n8","label":"Conclusion","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"étude"},
      {"from":"n1","to":"n3","label":"expression"},
      {"from":"n2","to":"n4","label":"figures"},
      {"from":"n2","to":"n5","label":"thèmes"},
      {"from":"n2","to":"n6","label":"tonalité"},
      {"from":"n3","to":"n7","label":"structure"},
      {"from":"n3","to":"n8","label":"bilan"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le commentaire composé analyse :","options":["Seulement le fond","Seulement la forme","Le lien entre fond et forme","La biographie de l''auteur"],"correct":2,"explanation":"Le commentaire composé montre comment la forme (style, procédés) sert le fond (sens, message, thèmes) du texte."},
    {"id":"q2","question":"Un axe de lecture est :","options":["Un résumé du texte","Un angle d''analyse thématique","Une figure de style","Une citation"],"correct":1,"explanation":"L''axe de lecture est un angle d''analyse regroupant plusieurs observations convergentes autour d''un thème ou d''un effet du texte."},
    {"id":"q3","question":"Une métaphore est :","options":["Une comparaison avec « comme »","Une comparaison sans mot de comparaison","Une exagération","Une répétition"],"correct":1,"explanation":"La métaphore est une comparaison implicite (sans mot de comparaison comme « comme » ou « tel ») : « la mer de nuages »."},
    {"id":"q4","question":"Le registre lyrique exprime :","options":["Le rire","Les sentiments personnels","L''héroïsme","La critique"],"correct":1,"explanation":"Le registre lyrique exprime les sentiments personnels, les émotions intimes (amour, mélancolie, joie) avec musicalité."},
    {"id":"q5","question":"Analyser un procédé c''est :","options":["Seulement le nommer","Le nommer, le citer et expliquer son effet","Le résumer","Le traduire"],"correct":1,"explanation":"Une analyse complète identifie le procédé, le cite dans le texte (guillemets) et explique son effet sur le sens et l''émotion."},
    {"id":"q6","question":"L''antithèse est :","options":["Une exagération","L''opposition de deux termes contraires","Une répétition en début de phrase","Un raccourci d''expression"],"correct":1,"explanation":"L''antithèse oppose deux termes ou idées contraires pour créer un effet de contraste : « la beauté et la laideur »."},
    {"id":"q7","question":"L''introduction du commentaire doit contenir :","options":["L''analyse complète du texte","La présentation du texte et les axes de lecture","Seulement une citation","Le plan détaillé"],"correct":1,"explanation":"L''introduction présente le texte (auteur, œuvre, contexte), situe le passage et annonce les axes de lecture qui structurent le commentaire."},
    {"id":"q8","question":"L''anaphore est :","options":["Une exagération","La répétition d''un mot en début de phrase ou de vers","Un contraire","Un symbole"],"correct":1,"explanation":"L''anaphore est la répétition d''un même mot ou groupe de mots au début de phrases ou de vers successifs, créant un effet d''insistance."}
  ]
}');

-- Chapitre 3 : Le résumé et la discussion
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (francais_id, 'resume-discussion', 3, 'Le résumé et la discussion', 'Technique du résumé de texte et de la discussion argumentée.', 3)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'resume-discussion-fiche', 'Le résumé et la discussion', 'Condenser un texte et argumenter', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que le résumé de texte ?","verso":"Exercice consistant à reformuler un texte en le réduisant à un quart (ou un tiers) de sa longueur, en conservant les idées essentielles dans l''ordre du texte, avec ses propres mots.","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les règles du résumé ?","verso":"1) Respecter l''ordre du texte. 2) Reformuler (pas de copié-collé). 3) Conserver les idées principales. 4) Supprimer exemples et détails. 5) Respecter la longueur imposée (±10%). 6) Rester objectif.","category":"Méthode"},
    {"id":"f3","recto":"Comment identifier les idées principales d''un texte ?","verso":"1) Lire attentivement. 2) Repérer la thèse et les arguments. 3) Distinguer idées principales (indispensables) et secondaires (exemples, détails, illustrations). 4) Faire un plan du texte.","category":"Méthode"},
    {"id":"f4","recto":"Qu''est-ce que la discussion ?","verso":"Exercice d''argumentation personnelle sur le thème du texte. On prend position, on développe des arguments et des exemples pour et/ou contre la thèse de l''auteur.","category":"Définition"},
    {"id":"f5","recto":"Comment structurer une discussion ?","verso":"1) Introduction (présentation du thème, problématique). 2) Arguments pour la thèse (avec exemples). 3) Arguments contre (avec exemples). 4) Conclusion (position personnelle nuancée).","category":"Méthode"},
    {"id":"f6","recto":"Quelle est la différence entre résumé et analyse ?","verso":"Le résumé condense le texte sans commentaire personnel. L''analyse (commentaire) interprète le texte, explique les procédés et évalue les arguments.","category":"Distinction"},
    {"id":"f7","recto":"Comment compter les mots ?","verso":"Un mot = toute unité séparée par des espaces. Les articles, prépositions et conjonctions comptent. Les mots composés avec trait d''union comptent pour un seul mot (ex : peut-être = 1 mot).","category":"Méthode"},
    {"id":"f8","recto":"Quelles erreurs éviter dans le résumé ?","verso":"1) Copier des phrases du texte. 2) Ajouter des idées personnelles. 3) Changer l''ordre des idées. 4) Oublier des idées essentielles. 5) Dépasser la longueur autorisée.","category":"Méthode"}
  ],
  "schema": {
    "title": "Résumé et discussion",
    "nodes": [
      {"id":"n1","label":"Résumé et discussion","type":"main","x":400,"y":50},
      {"id":"n2","label":"Résumé","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Discussion","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Reformulation","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Idées principales","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Arguments pour/contre","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Position personnelle","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"condenser"},
      {"from":"n1","to":"n3","label":"argumenter"},
      {"from":"n2","to":"n4","label":"reformuler"},
      {"from":"n2","to":"n5","label":"sélectionner"},
      {"from":"n3","to":"n6","label":"débattre"},
      {"from":"n3","to":"n7","label":"conclure"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le résumé doit respecter :","options":["L''ordre chronologique de l''histoire","L''ordre des idées du texte","L''ordre alphabétique","Aucun ordre particulier"],"correct":1,"explanation":"Le résumé doit respecter l''ordre de présentation des idées dans le texte original."},
    {"id":"q2","question":"Dans un résumé, on doit :","options":["Copier les phrases du texte","Reformuler avec ses propres mots","Ajouter des commentaires","Donner son opinion"],"correct":1,"explanation":"Le résumé exige une reformulation personnelle : on exprime les idées de l''auteur avec ses propres mots, sans copier."},
    {"id":"q3","question":"La longueur du résumé est généralement :","options":["Le double du texte","La moitié du texte","Un quart du texte","Identique au texte"],"correct":2,"explanation":"Traditionnellement, le résumé réduit le texte à environ un quart de sa longueur (parfois un tiers, selon les consignes)."},
    {"id":"q4","question":"La discussion est un exercice :","options":["De résumé","D''argumentation personnelle","De traduction","De narration"],"correct":1,"explanation":"La discussion est un exercice d''argumentation où l''on prend position sur le thème du texte avec des arguments et exemples personnels."},
    {"id":"q5","question":"Un mot composé avec trait d''union compte pour :","options":["Deux mots","Un seul mot","Trois mots","Zéro mot"],"correct":1,"explanation":"Par convention, un mot composé avec trait d''union (ex : peut-être, c''est-à-dire) compte pour un seul mot."},
    {"id":"q6","question":"Dans le résumé, les exemples du texte doivent être :","options":["Conservés intégralement","Supprimés ou très réduits","Développés davantage","Remplacés par d''autres"],"correct":1,"explanation":"Les exemples et illustrations sont des éléments secondaires qui doivent être supprimés ou très réduits dans le résumé pour ne garder que l''essentiel."},
    {"id":"q7","question":"La conclusion de la discussion doit :","options":["Répéter l''introduction","Présenter une position personnelle nuancée","Simplement résumer le texte","Poser une nouvelle question sans répondre"],"correct":1,"explanation":"La conclusion de la discussion synthétise le raisonnement et exprime une position personnelle nuancée sur la question."},
    {"id":"q8","question":"La différence entre résumé et analyse est que le résumé :","options":["Interprète le texte","Condense le texte sans commentaire","Critique l''auteur","Évalue les procédés"],"correct":1,"explanation":"Le résumé se limite à condenser les idées du texte sans interprétation ni commentaire, contrairement à l''analyse qui examine la forme et le fond."}
  ]
}');

-- Chapitre 4 : Les genres littéraires
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (francais_id, 'genres-litteraires', 4, 'Les genres littéraires', 'Roman, poésie, théâtre, essai et littérature africaine.', 4)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'genres-litteraires-fiche', 'Les genres littéraires', 'Caractéristiques des grands genres et littérature africaine', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quels sont les quatre grands genres littéraires ?","verso":"1) Le roman (récit en prose, fiction). 2) La poésie (expression rythmée, versifiée ou libre). 3) Le théâtre (texte joué sur scène). 4) L''essai (réflexion argumentée).","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les caractéristiques du roman ?","verso":"Récit en prose, longue fiction, personnages développés, intrigue (exposition, péripéties, dénouement). Sous-genres : réaliste, historique, d''aventures, autobiographique, épistolaire.","category":"Définition"},
    {"id":"f3","recto":"Quelles sont les caractéristiques de la poésie ?","verso":"Expression concentrée des émotions et des idées. Moyens : rythme, rimes, sonorités, images (métaphores). Formes : sonnet, ode, vers libre, prose poétique.","category":"Définition"},
    {"id":"f4","recto":"Quelles sont les formes du théâtre ?","verso":"Tragédie (destin fatal, héros nobles), comédie (rire, satire sociale), drame (mélange tragique et comique), farce (comique de gestes), théâtre de l''absurde (Ionesco, Beckett).","category":"Définition"},
    {"id":"f5","recto":"Quels sont les grands auteurs de la littérature africaine francophone ?","verso":"Camara Laye (L''Enfant noir), Sembène Ousmane (Les Bouts de bois de Dieu), Aminata Sow Fall (La Grève des Bàttu), Ahmadou Kourouma (Les Soleils des indépendances).","category":"Exemple"},
    {"id":"f6","recto":"Qu''est-ce que la littérature de la négritude ?","verso":"Mouvement littéraire (années 1930-50) affirmant l''identité et la dignité noire. Fondateurs : Aimé Césaire (Cahier d''un retour au pays natal), Senghor (Chants d''ombre), Damas.","category":"Définition"},
    {"id":"f7","recto":"Quelle est la différence entre un auteur et un narrateur ?","verso":"L''auteur est la personne réelle qui écrit l''œuvre. Le narrateur est la voix qui raconte l''histoire dans le texte (peut être un personnage ou une voix extérieure). Ils ne sont pas toujours identiques.","category":"Distinction"},
    {"id":"f8","recto":"Quels sont les points de vue narratifs ?","verso":"Interne (le narrateur est un personnage, « je »), externe (le narrateur observe de l''extérieur, vision limitée), omniscient (le narrateur sait tout, y compris les pensées des personnages).","category":"Définition"}
  ],
  "schema": {
    "title": "Les genres littéraires",
    "nodes": [
      {"id":"n1","label":"Genres littéraires","type":"main","x":400,"y":50},
      {"id":"n2","label":"Roman","type":"branch","x":100,"y":150},
      {"id":"n3","label":"Poésie","type":"branch","x":300,"y":150},
      {"id":"n4","label":"Théâtre","type":"branch","x":500,"y":150},
      {"id":"n5","label":"Essai","type":"branch","x":700,"y":150},
      {"id":"n6","label":"Réaliste, historique...","type":"leaf","x":100,"y":250},
      {"id":"n7","label":"Sonnet, vers libre...","type":"leaf","x":300,"y":250},
      {"id":"n8","label":"Tragédie, comédie...","type":"leaf","x":500,"y":250},
      {"id":"n9","label":"Littérature africaine","type":"leaf","x":400,"y":330}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"prose fiction"},
      {"from":"n1","to":"n3","label":"vers/rythme"},
      {"from":"n1","to":"n4","label":"scène"},
      {"from":"n1","to":"n5","label":"argumentation"},
      {"from":"n2","to":"n6","label":"sous-genres"},
      {"from":"n3","to":"n7","label":"formes"},
      {"from":"n4","to":"n8","label":"formes"},
      {"from":"n1","to":"n9","label":"francophonie"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le roman est un récit :","options":["En vers","En prose, de fiction","Joué sur scène","Chanté"],"correct":1,"explanation":"Le roman est un récit en prose de fiction, caractérisé par une intrigue développée et des personnages travaillés."},
    {"id":"q2","question":"La tragédie classique met en scène :","options":["Des personnages comiques","Des héros nobles face à un destin fatal","Des animaux","Des événements quotidiens"],"correct":1,"explanation":"La tragédie classique (Racine, Corneille) met en scène des héros nobles confrontés à un destin inéluctable, suscitant terreur et pitié."},
    {"id":"q3","question":"L''auteur de « L''Enfant noir » est :","options":["Senghor","Camara Laye","Aimé Césaire","Victor Hugo"],"correct":1,"explanation":"L''Enfant noir (1953) est un roman autobiographique de Camara Laye, écrivain guinéen, relatant son enfance en Haute-Guinée."},
    {"id":"q4","question":"Le point de vue omniscient signifie que le narrateur :","options":["Ne sait rien","Sait tout, y compris les pensées des personnages","Est un personnage","Observe de l''extérieur"],"correct":1,"explanation":"Le narrateur omniscient a une connaissance totale : il connaît les pensées, sentiments et le passé de tous les personnages."},
    {"id":"q5","question":"La négritude est un mouvement fondé dans les années :","options":["1800","1930","1970","2000"],"correct":1,"explanation":"Le mouvement de la négritude est né dans les années 1930 à Paris, fondé par Césaire, Senghor et Damas."},
    {"id":"q6","question":"Un sonnet comprend :","options":["10 vers","12 vers","14 vers","20 vers"],"correct":2,"explanation":"Le sonnet est un poème de 14 vers répartis en deux quatrains (4+4 vers) et deux tercets (3+3 vers)."},
    {"id":"q7","question":"Le narrateur et l''auteur sont :","options":["Toujours la même personne","Pas nécessairement la même personne","Jamais la même personne","Synonymes"],"correct":1,"explanation":"L''auteur est la personne réelle qui écrit. Le narrateur est la voix fictive qui raconte dans le texte. Ils peuvent coïncider (autobiographie) mais pas toujours."},
    {"id":"q8","question":"Le théâtre de l''absurde est représenté par :","options":["Molière et Racine","Ionesco et Beckett","Hugo et Balzac","Senghor et Césaire"],"correct":1,"explanation":"Le théâtre de l''absurde (années 1950) est représenté par Ionesco (La Cantatrice chauve) et Beckett (En attendant Godot), qui dénoncent l''absurdité de la condition humaine."}
  ]
}');

-- ================================================
-- ECM (2 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : Sécurité et civisme au Mali (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (ecm_id, 'securite-civisme', 1, 'Sécurité et civisme au Mali', 'Sécurité nationale, civisme et rôle du citoyen dans la société malienne.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'securite-civisme-fiche', 'Sécurité et civisme au Mali', 'Citoyenneté, devoirs civiques et sécurité', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que le civisme ?","verso":"Attitude du bon citoyen qui respecte les lois, les institutions et les règles de la vie en société. Il implique le respect du bien public, le paiement des impôts et la participation à la vie démocratique.","category":"Définition"},
    {"id":"f2","recto":"Quels sont les devoirs du citoyen malien ?","verso":"1) Respecter la Constitution et les lois. 2) Défendre la patrie. 3) Payer les impôts. 4) Participer aux élections. 5) Respecter le bien public. 6) Contribuer au développement national.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la sécurité nationale ?","verso":"Protection de l''État, de son territoire et de ses citoyens contre les menaces internes et externes. Elle inclut la défense militaire, la sécurité intérieure et la protection civile.","category":"Définition"},
    {"id":"f4","recto":"Quels sont les défis sécuritaires au Mali ?","verso":"Terrorisme dans le nord et le centre, conflits intercommunautaires, trafics transfrontaliers (drogue, armes), déplacements de populations, reconstruction post-conflit.","category":"Exemple"},
    {"id":"f5","recto":"Qu''est-ce que la cohésion sociale ?","verso":"Capacité d''une société à vivre ensemble malgré les différences (ethniques, religieuses, sociales). Elle repose sur le dialogue, la tolérance, la solidarité et le respect mutuel.","category":"Définition"},
    {"id":"f6","recto":"Quel est le rôle de l''école dans le civisme ?","verso":"L''école forme les futurs citoyens en transmettant les valeurs républicaines (liberté, égalité, solidarité), le respect des règles, l''esprit critique et la connaissance des institutions.","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce que la protection civile ?","verso":"Ensemble des mesures visant à protéger les populations contre les catastrophes (inondations, incendies, épidémies). Elle implique prévention, alerte, secours et assistance aux sinistrés.","category":"Définition"},
    {"id":"f8","recto":"Quelle est la différence entre droits et devoirs du citoyen ?","verso":"Les droits sont ce que la société garantit au citoyen (liberté, éducation, santé). Les devoirs sont ce que le citoyen doit à la société (respect des lois, impôts, défense). Ils sont indissociables.","category":"Distinction"}
  ],
  "schema": {
    "title": "Sécurité et civisme",
    "nodes": [
      {"id":"n1","label":"Sécurité et civisme","type":"main","x":400,"y":50},
      {"id":"n2","label":"Civisme","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Sécurité","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Devoirs du citoyen","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Cohésion sociale","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"Sécurité nationale","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Protection civile","type":"leaf","x":700,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"citoyen"},
      {"from":"n1","to":"n3","label":"État"},
      {"from":"n2","to":"n4","label":"obligations"},
      {"from":"n2","to":"n5","label":"vivre ensemble"},
      {"from":"n3","to":"n6","label":"défense"},
      {"from":"n3","to":"n7","label":"catastrophes"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"Le civisme implique :","options":["L''indifférence aux lois","Le respect des lois et des institutions","La désobéissance systématique","L''absence de participation"],"correct":1,"explanation":"Le civisme est l''attitude du citoyen responsable qui respecte les lois, les institutions et participe activement à la vie de la société."},
    {"id":"q2","question":"Parmi les devoirs du citoyen malien, on trouve :","options":["Refuser de payer les impôts","Défendre la patrie et payer les impôts","Ignorer les élections","Détruire le bien public"],"correct":1,"explanation":"La Constitution malienne impose aux citoyens de défendre la patrie, payer les impôts, respecter les lois et contribuer au développement."},
    {"id":"q3","question":"La cohésion sociale repose sur :","options":["L''exclusion","La discrimination","Le dialogue et la tolérance","La violence"],"correct":2,"explanation":"La cohésion sociale exige le dialogue entre communautés, la tolérance des différences, la solidarité et le respect mutuel."},
    {"id":"q4","question":"La protection civile concerne :","options":["La défense militaire uniquement","La protection contre les catastrophes","Le commerce international","La diplomatie"],"correct":1,"explanation":"La protection civile protège les populations civiles contre les catastrophes naturelles, les incendies, les épidémies et autres sinistres."},
    {"id":"q5","question":"Les droits et devoirs du citoyen sont :","options":["Indépendants","Indissociables","Opposés","Facultatifs"],"correct":1,"explanation":"Les droits et devoirs sont indissociables : le citoyen a des droits garantis par la société et des devoirs envers cette même société."},
    {"id":"q6","question":"L''école contribue au civisme en :","options":["Ignorant les valeurs","Transmettant les valeurs républicaines","Encourageant la violence","Refusant l''esprit critique"],"correct":1,"explanation":"L''école forme les citoyens en transmettant les valeurs de liberté, égalité, solidarité et en développant l''esprit critique."},
    {"id":"q7","question":"Un défi sécuritaire majeur au Mali est :","options":["Le tourisme","Le terrorisme","L''excès de pluie","La surpopulation urbaine"],"correct":1,"explanation":"Le terrorisme, notamment dans le nord et le centre du Mali, constitue un défi sécuritaire majeur depuis la crise de 2012."},
    {"id":"q8","question":"Le bien public doit être :","options":["Détruit","Privatisé","Respecté et protégé par tous","Ignoré"],"correct":2,"explanation":"Le bien public (routes, écoles, hôpitaux, espaces verts) appartient à la collectivité et doit être respecté et protégé par chaque citoyen."}
  ]
}');

-- Chapitre 2 : Démocratie et institutions
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (ecm_id, 'democratie-institutions', 2, 'Démocratie et institutions', 'Principes démocratiques, institutions maliennes et organisations internationales.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'democratie-institutions-fiche', 'Démocratie et institutions', 'Pouvoir, séparation des pouvoirs et organisations', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Qu''est-ce que la démocratie ?","verso":"Régime politique dans lequel le pouvoir appartient au peuple, exercé directement ou par des représentants élus. Elle repose sur le suffrage universel, le pluralisme et le respect des droits fondamentaux.","category":"Définition"},
    {"id":"f2","recto":"Quels sont les trois pouvoirs dans une démocratie ?","verso":"Législatif (fait les lois : Assemblée nationale), exécutif (applique les lois : Président, gouvernement), judiciaire (interprète les lois : tribunaux, juges). Leur séparation garantit les libertés.","category":"Définition"},
    {"id":"f3","recto":"Quelles sont les institutions de la République du Mali ?","verso":"Président de la République (chef de l''État), Gouvernement (Premier ministre et ministres), Assemblée nationale (pouvoir législatif), Cour suprême, Cour constitutionnelle, Haut Conseil des Collectivités.","category":"Définition"},
    {"id":"f4","recto":"Qu''est-ce que le suffrage universel ?","verso":"Droit de vote accordé à tous les citoyens majeurs sans distinction de sexe, de race, de religion ou de richesse. C''est le fondement de la démocratie représentative.","category":"Définition"},
    {"id":"f5","recto":"Qu''est-ce que la Constitution ?","verso":"Loi fondamentale et suprême d''un État définissant l''organisation des pouvoirs, les droits et devoirs des citoyens. Toutes les autres lois doivent être conformes à la Constitution.","category":"Définition"},
    {"id":"f6","recto":"Qu''est-ce que l''Union Africaine (UA) ?","verso":"Organisation continentale regroupant 55 États africains, fondée en 2002 (succédant à l''OUA). Objectifs : unité africaine, paix, développement économique, intégration régionale.","category":"Définition"},
    {"id":"f7","recto":"Qu''est-ce que la CEDEAO ?","verso":"Communauté Économique des États de l''Afrique de l''Ouest, créée en 1975. Elle vise l''intégration économique, la libre circulation des personnes et des biens, et la résolution des crises.","category":"Définition"},
    {"id":"f8","recto":"Qu''est-ce que l''ONU ?","verso":"Organisation des Nations Unies, fondée en 1945 pour maintenir la paix internationale, protéger les droits de l''homme, promouvoir le développement et le droit international. Siège : New York.","category":"Définition"}
  ],
  "schema": {
    "title": "Démocratie et institutions",
    "nodes": [
      {"id":"n1","label":"Démocratie et institutions","type":"main","x":400,"y":50},
      {"id":"n2","label":"Principes démocratiques","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Institutions maliennes","type":"branch","x":400,"y":150},
      {"id":"n4","label":"Organisations internationales","type":"branch","x":650,"y":150},
      {"id":"n5","label":"Séparation des pouvoirs","type":"leaf","x":100,"y":250},
      {"id":"n6","label":"Suffrage universel","type":"leaf","x":250,"y":250},
      {"id":"n7","label":"Président, AN, Justice","type":"leaf","x":400,"y":250},
      {"id":"n8","label":"UA, CEDEAO, ONU","type":"leaf","x":650,"y":250}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"valeurs"},
      {"from":"n1","to":"n3","label":"Mali"},
      {"from":"n1","to":"n4","label":"coopération"},
      {"from":"n2","to":"n5","label":"garantie"},
      {"from":"n2","to":"n6","label":"vote"},
      {"from":"n3","to":"n7","label":"pouvoirs"},
      {"from":"n4","to":"n8","label":"organisations"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La séparation des pouvoirs garantit :","options":["La dictature","Les libertés individuelles","La concentration du pouvoir","L''anarchie"],"correct":1,"explanation":"La séparation des pouvoirs (législatif, exécutif, judiciaire) empêche la concentration du pouvoir et protège les libertés individuelles."},
    {"id":"q2","question":"Le pouvoir législatif au Mali est exercé par :","options":["Le Président","L''Assemblée nationale","La Cour suprême","L''armée"],"correct":1,"explanation":"L''Assemblée nationale est l''institution qui détient le pouvoir législatif : elle vote les lois et contrôle l''action du gouvernement."},
    {"id":"q3","question":"Le suffrage universel signifie que :","options":["Seuls les riches votent","Tous les citoyens majeurs peuvent voter","Seuls les hommes votent","Le vote est réservé aux élites"],"correct":1,"explanation":"Le suffrage universel accorde le droit de vote à tous les citoyens majeurs sans discrimination de sexe, de race, de religion ou de fortune."},
    {"id":"q4","question":"La Constitution est :","options":["Une loi ordinaire","La loi fondamentale et suprême de l''État","Un règlement intérieur","Un décret présidentiel"],"correct":1,"explanation":"La Constitution est la loi suprême qui organise les pouvoirs et garantit les droits fondamentaux. Toutes les autres lois lui sont subordonnées."},
    {"id":"q5","question":"L''Union Africaine a été fondée en :","options":["1963","1975","2002","2015"],"correct":2,"explanation":"L''Union Africaine (UA) a été fondée en 2002 à Durban (Afrique du Sud), succédant à l''Organisation de l''Unité Africaine (OUA, 1963)."},
    {"id":"q6","question":"La CEDEAO vise principalement :","options":["L''intégration économique de l''Afrique de l''Ouest","La conquête militaire","L''isolement des États","La colonisation"],"correct":0,"explanation":"La CEDEAO (1975) promeut l''intégration économique, la libre circulation des personnes et des biens, et le développement en Afrique de l''Ouest."},
    {"id":"q7","question":"L''ONU a été fondée en :","options":["1918","1939","1945","1960"],"correct":2,"explanation":"L''Organisation des Nations Unies a été fondée le 24 octobre 1945 après la Seconde Guerre mondiale pour maintenir la paix internationale."},
    {"id":"q8","question":"Le pouvoir judiciaire est exercé par :","options":["Le Parlement","Le Président","Les tribunaux et les juges","Les ministres"],"correct":2,"explanation":"Le pouvoir judiciaire est exercé par les tribunaux et les juges qui interprètent les lois, tranchent les litiges et sanctionnent les infractions."}
  ]
}');

-- ================================================
-- EPS (2 chapitres) – 8 flashcards + 8 quiz
-- ================================================

-- Chapitre 1 : Pratique sportive (GRATUIT)
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (eps_id, 'pratique-sportive', 1, 'Pratique sportive', 'Activités physiques, règlements et techniques sportives.', 1)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'pratique-sportive-fiche', 'Pratique sportive', 'Activités, règlements et entraînement', true, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quelles sont les grandes familles d''activités physiques ?","verso":"1) Athlétisme (courses, sauts, lancers). 2) Sports collectifs (football, basket, handball). 3) Sports individuels (natation, gymnastique). 4) Sports de combat (lutte, judo). 5) Sports de raquette.","category":"Définition"},
    {"id":"f2","recto":"Quelles sont les épreuves d''athlétisme au bac ?","verso":"Courses : 100 m, 200 m, 800 m, 1500 m, relais 4×100 m. Sauts : longueur, hauteur, triple saut. Lancers : poids, disque, javelot.","category":"Définition"},
    {"id":"f3","recto":"Quels sont les principes de l''échauffement ?","verso":"1) Progressivité (intensité croissante). 2) Spécificité (adapté à l''activité). 3) Globalité (tout le corps). Phases : cardio-respiratoire, articulaire, musculaire, spécifique.","category":"Méthode"},
    {"id":"f4","recto":"Quelles sont les qualités physiques fondamentales ?","verso":"1) Endurance (capacité à durer). 2) Vitesse (rapidité d''exécution). 3) Force (puissance musculaire). 4) Souplesse (amplitude articulaire). 5) Coordination (harmonie des mouvements).","category":"Définition"},
    {"id":"f5","recto":"Qu''est-ce que le fair-play ?","verso":"Esprit sportif caractérisé par le respect des règles, de l''adversaire, de l''arbitre et des spectateurs. Il inclut l''honnêteté, la maîtrise de soi et l''acceptation du résultat.","category":"Définition"},
    {"id":"f6","recto":"Quelles sont les règles de base du football ?","verso":"11 joueurs par équipe, 2 mi-temps de 45 min, hors-jeu, fautes (carton jaune = avertissement, rouge = expulsion), coup franc, penalty, corner, touche.","category":"Définition"},
    {"id":"f7","recto":"Comment améliorer l''endurance ?","verso":"Par un entraînement régulier en course continue (footing), en fractionné (intervalles d''efforts intenses et de récupération), et en respectant les zones de fréquence cardiaque cible.","category":"Méthode"},
    {"id":"f8","recto":"Quelle est l''importance du retour au calme après l''effort ?","verso":"Le retour au calme permet de : 1) Faire baisser progressivement la fréquence cardiaque. 2) Éliminer l''acide lactique. 3) Prévenir les courbatures. 4) Favoriser la récupération musculaire.","category":"Méthode"}
  ],
  "schema": {
    "title": "Pratique sportive",
    "nodes": [
      {"id":"n1","label":"Pratique sportive","type":"main","x":400,"y":50},
      {"id":"n2","label":"Activités","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Entraînement","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Athlétisme","type":"leaf","x":50,"y":250},
      {"id":"n5","label":"Sports collectifs","type":"leaf","x":200,"y":250},
      {"id":"n6","label":"Qualités physiques","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Échauffement / Récupération","type":"leaf","x":700,"y":250},
      {"id":"n8","label":"Fair-play","type":"leaf","x":400,"y":300}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"disciplines"},
      {"from":"n1","to":"n3","label":"préparation"},
      {"from":"n2","to":"n4","label":"courses, sauts, lancers"},
      {"from":"n2","to":"n5","label":"équipe"},
      {"from":"n3","to":"n6","label":"développement"},
      {"from":"n3","to":"n7","label":"protocole"},
      {"from":"n1","to":"n8","label":"éthique"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"L''échauffement doit être :","options":["Brutal et rapide","Progressif et adapté à l''activité","Inutile","Uniquement du stretching"],"correct":1,"explanation":"L''échauffement doit être progressif (intensité croissante) et spécifique (adapté à l''activité qui suit) pour préparer le corps à l''effort."},
    {"id":"q2","question":"L''endurance est la capacité de :","options":["Courir très vite sur 10 mètres","Maintenir un effort sur une longue durée","Soulever des charges lourdes","Être très souple"],"correct":1,"explanation":"L''endurance est la capacité à maintenir un effort d''intensité modérée sur une longue durée (course de fond, cyclisme, natation)."},
    {"id":"q3","question":"Au football, un carton rouge signifie :","options":["Un avertissement","L''expulsion du joueur","Un but","Une remise en jeu"],"correct":1,"explanation":"Le carton rouge entraîne l''expulsion définitive du joueur pour le reste du match (faute grave, violence, deuxième carton jaune)."},
    {"id":"q4","question":"Le retour au calme après l''effort sert à :","options":["Augmenter l''intensité","Favoriser la récupération et éliminer l''acide lactique","Commencer un nouvel entraînement","Rien de particulier"],"correct":1,"explanation":"Le retour au calme (marche, étirements) permet de diminuer progressivement la fréquence cardiaque, d''éliminer les déchets métaboliques et de prévenir les courbatures."},
    {"id":"q5","question":"Le fair-play inclut :","options":["Tricher pour gagner","Le respect des règles et de l''adversaire","L''insulte de l''arbitre","La violence"],"correct":1,"explanation":"Le fair-play est l''esprit sportif : respect des règles, de l''adversaire, de l''arbitre, maîtrise de soi et acceptation du résultat."},
    {"id":"q6","question":"Le relais 4×100 m nécessite :","options":["1 coureur","2 coureurs","4 coureurs","8 coureurs"],"correct":2,"explanation":"Le relais 4×100 m est une course d''équipe où 4 coureurs se relaient en se transmettant un témoin sur 100 m chacun."},
    {"id":"q7","question":"L''entraînement fractionné alterne :","options":["Repos et repos","Efforts intenses et récupération","Marche lente uniquement","Étirements uniquement"],"correct":1,"explanation":"Le fractionné (interval training) alterne des phases d''effort intense et des phases de récupération active, améliorant la capacité aérobie."},
    {"id":"q8","question":"Les qualités physiques fondamentales sont :","options":["Seulement la force","Endurance, vitesse, force, souplesse et coordination","Seulement l''endurance","Seulement la vitesse"],"correct":1,"explanation":"Les 5 qualités physiques fondamentales sont l''endurance, la vitesse, la force, la souplesse et la coordination."}
  ]
}');

-- Chapitre 2 : Hygiène et physiologie
INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
VALUES (eps_id, 'hygiene-physiologie', 2, 'Hygiène et physiologie', 'Alimentation du sportif, hygiène de vie et notions de physiologie.', 2)
RETURNING id INTO v_chapter_id;

INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
VALUES (v_chapter_id, 'hygiene-physiologie-fiche', 'Hygiène et physiologie', 'Alimentation, hygiène et physiologie de l''effort', false, true, 1, '{
  "flashcards": [
    {"id":"f1","recto":"Quels sont les besoins nutritionnels du sportif ?","verso":"Glucides (énergie principale, 55-60%), lipides (énergie de réserve, 25-30%), protéines (construction musculaire, 12-15%), eau (hydratation), vitamines et minéraux.","category":"Définition"},
    {"id":"f2","recto":"Pourquoi l''hydratation est-elle importante pendant l''effort ?","verso":"L''exercice provoque la sudation (perte d''eau et de sels). La déshydratation diminue les performances, augmente la fréquence cardiaque et risque l''hyperthermie. Boire régulièrement avant, pendant et après l''effort.","category":"Définition"},
    {"id":"f3","recto":"Qu''est-ce que la fréquence cardiaque maximale (FCmax) ?","verso":"Nombre maximal de battements par minute que le cœur peut atteindre. Estimation : FCmax ≈ 220 - âge. Pour un élève de 18 ans : FCmax ≈ 202 bpm.","category":"Formule"},
    {"id":"f4","recto":"Qu''est-ce que la VO2max ?","verso":"Volume maximal d''oxygène que l''organisme peut utiliser par minute lors d''un effort intense. Elle reflète la capacité aérobie (endurance). Valeurs moyennes : 35-45 mL/kg/min.","category":"Définition"},
    {"id":"f5","recto":"Quels sont les effets de l''entraînement sur le cœur ?","verso":"Le cœur du sportif entraîné est plus volumineux (hypertrophie), éjecte plus de sang par battement (volume d''éjection augmenté) et bat plus lentement au repos (bradycardie sinusale).","category":"Définition"},
    {"id":"f6","recto":"Qu''est-ce que la filière anaérobie et aérobie ?","verso":"Aérobie : production d''énergie avec oxygène (efforts prolongés, modérés). Anaérobie lactique : sans O₂, production d''acide lactique (efforts intenses, 30s-3min). Anaérobie alactique : sans O₂ ni lactate (efforts explosifs, < 10s).","category":"Distinction"},
    {"id":"f7","recto":"Quels sont les principes d''hygiène de vie du sportif ?","verso":"1) Alimentation équilibrée. 2) Hydratation suffisante. 3) Sommeil régulier (8h). 4) Pas de tabac, alcool ni drogues. 5) Hygiène corporelle. 6) Gestion du stress.","category":"Méthode"},
    {"id":"f8","recto":"Qu''est-ce que le dopage et pourquoi est-il interdit ?","verso":"Usage de substances ou méthodes interdites pour améliorer artificiellement les performances. Interdit car : dangereux pour la santé (risques cardiaques, hépatiques, hormonaux), contraire à l''éthique sportive et puni par la loi.","category":"Définition"}
  ],
  "schema": {
    "title": "Hygiène et physiologie",
    "nodes": [
      {"id":"n1","label":"Hygiène et physiologie","type":"main","x":400,"y":50},
      {"id":"n2","label":"Nutrition","type":"branch","x":200,"y":150},
      {"id":"n3","label":"Physiologie de l''effort","type":"branch","x":600,"y":150},
      {"id":"n4","label":"Glucides, lipides, protéines","type":"leaf","x":100,"y":250},
      {"id":"n5","label":"Hydratation","type":"leaf","x":250,"y":250},
      {"id":"n6","label":"FC, VO2max","type":"leaf","x":500,"y":250},
      {"id":"n7","label":"Filières énergétiques","type":"leaf","x":700,"y":250},
      {"id":"n8","label":"Anti-dopage","type":"leaf","x":400,"y":330}
    ],
    "edges": [
      {"from":"n1","to":"n2","label":"alimentation"},
      {"from":"n1","to":"n3","label":"adaptation"},
      {"from":"n2","to":"n4","label":"macronutriments"},
      {"from":"n2","to":"n5","label":"eau"},
      {"from":"n3","to":"n6","label":"indicateurs"},
      {"from":"n3","to":"n7","label":"énergie"},
      {"from":"n1","to":"n8","label":"éthique"}
    ]
  },
  "quiz": [
    {"id":"q1","question":"La source d''énergie principale du sportif est :","options":["Les protéines","Les lipides","Les glucides","Les vitamines"],"correct":2,"explanation":"Les glucides (55-60% de l''apport calorique) sont la source d''énergie principale pour l''effort musculaire, stockés sous forme de glycogène."},
    {"id":"q2","question":"La FCmax estimée pour un élève de 17 ans est :","options":["170 bpm","185 bpm","203 bpm","220 bpm"],"correct":2,"explanation":"FCmax ≈ 220 - âge = 220 - 17 = 203 battements par minute."},
    {"id":"q3","question":"La VO2max mesure :","options":["La vitesse de course","La capacité maximale d''utilisation de l''oxygène","La force musculaire","La souplesse"],"correct":1,"explanation":"La VO2max (volume maximal d''oxygène) est la quantité maximale d''O₂ que l''organisme peut consommer par minute, indicateur de la capacité aérobie."},
    {"id":"q4","question":"La filière anaérobie lactique est utilisée pour :","options":["Un sprint de 5 secondes","Un effort intense de 30 secondes à 3 minutes","Un marathon","Le repos"],"correct":1,"explanation":"La filière anaérobie lactique fournit l''énergie pour des efforts intenses de 30 secondes à 3 minutes (400m, 800m), avec production d''acide lactique."},
    {"id":"q5","question":"Le dopage est interdit parce qu''il est :","options":["Efficace","Dangereux pour la santé et contraire à l''éthique","Gratuit","Légal"],"correct":1,"explanation":"Le dopage est interdit car il met en danger la santé du sportif (risques cardiaques, hépatiques) et viole les principes d''éthique et d''équité sportive."},
    {"id":"q6","question":"Un sportif entraîné a une fréquence cardiaque au repos :","options":["Plus élevée qu''un sédentaire","Plus basse qu''un sédentaire","Identique","Irrégulière"],"correct":1,"explanation":"L''entraînement d''endurance provoque une bradycardie (FC au repos basse, ~50-60 bpm) car le cœur est plus efficient (volume d''éjection augmenté)."},
    {"id":"q7","question":"Pendant l''effort, il faut boire :","options":["Uniquement après l''effort","Régulièrement, avant, pendant et après","Jamais pendant l''effort","Seulement quand on a soif"],"correct":1,"explanation":"L''hydratation doit être régulière : avant (préparer), pendant (compenser les pertes) et après l''effort (récupérer), sans attendre la soif."},
    {"id":"q8","question":"Le sommeil recommandé pour un sportif est d''environ :","options":["4 heures","6 heures","8 heures","12 heures"],"correct":2,"explanation":"Un sommeil de qualité d''environ 8 heures par nuit est recommandé pour la récupération musculaire, la synthèse hormonale et la performance."}
  ]
}');

END $$;
