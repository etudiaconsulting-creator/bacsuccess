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
