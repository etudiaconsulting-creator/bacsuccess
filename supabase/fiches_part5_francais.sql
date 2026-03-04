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
  ON CONFLICT (subject_id, slug) DO UPDATE SET
    number = EXCLUDED.number,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order
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
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

  -- ============================================================
  -- CHAPITRE 2: Le commentaire compose
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'commentaire-compose', 2, 'Le commentaire compose', 'Analyse de texte, axes de lecture, procédés littéraires', 2)
  ON CONFLICT (subject_id, slug) DO UPDATE SET
    number = EXCLUDED.number,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order
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
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

  -- ============================================================
  -- CHAPITRE 3: Le résumé et la contraction de texte
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'resume-contraction', 3, 'Le résumé et la contraction de texte', 'Techniques de reformulation et de synthèse', 3)
  ON CONFLICT (subject_id, slug) DO UPDATE SET
    number = EXCLUDED.number,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order
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
  )
  ON CONFLICT (chapter_id, slug) DO UPDATE SET
    title = EXCLUDED.title,
    is_free = EXCLUDED.is_free,
    is_published = EXCLUDED.is_published,
    display_order = EXCLUDED.display_order,
    content = EXCLUDED.content,
    updated_at = now();

  -- ============================================================
  -- CHAPITRE 4: Les genres et mouvements littéraires
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (v_subject_id, 'genres-mouvements-litteraires', 4, 'Les genres et mouvements littéraires', 'Roman, poésie, theatre, négritude, réalisme', 4)
  ON CONFLICT (subject_id, slug) DO UPDATE SET
    number = EXCLUDED.number,
    title = EXCLUDED.title,
    description = EXCLUDED.description,
    display_order = EXCLUDED.display_order
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
          "explanation": "Une si longue lettre (1979) de Mariama Ba aborde la condition feminine au Sénégal, notamment la polygamie et l''émancipation des femmes, à travers le témoignage épistolaire d''une femme confrontée au second mariage de son mari."
        }
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
-- BacSuccess - Fiches Histoire-Géo (4 chapitres, 4 fiches)
-- Programme Histoire-Géographie - Baccalauréat malien TSECO
-- ============================================================
