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
