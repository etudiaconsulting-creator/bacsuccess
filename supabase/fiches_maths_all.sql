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
