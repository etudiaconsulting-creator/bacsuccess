-- ============================================================
-- BacSuccess - Migration 006: TSS Content
-- Série Terminale Sciences Sociales
-- 9 matières, 47 chapitres, 47 fiches
-- ============================================================

DO $$
DECLARE
  tss_id UUID;
  philo_id UUID;
  socio_id UUID;
  histoire_id UUID;
  geo_id UUID;
  maths_id UUID;
  anglais_id UUID;
  francais_id UUID;
  ecm_id UUID;
  eps_id UUID;
  v_chapter_id UUID;
BEGIN

  -- Get the TSS series ID
  SELECT id INTO tss_id FROM series WHERE slug = 'tss';
  IF tss_id IS NULL THEN RAISE EXCEPTION 'Series not found: tss'; END IF;

  -- Activate TSS series
  UPDATE series SET is_active = true, description = 'Terminale Sciences Sociales' WHERE id = tss_id;

  -- ============================================================
  -- SUBJECTS (9 matières)
  -- ============================================================

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'philo-tss', 'Philosophie', 4, 5, 'philo', 'Brain', 1)
  RETURNING id INTO philo_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'sociologie', 'Sociologie', 3, 4, 'sociologie', 'Users', 2)
  RETURNING id INTO socio_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'histoire', 'Histoire', 3, 4, 'histoire', 'ScrollText', 3)
  RETURNING id INTO histoire_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'geographie', 'Géographie', 3, 4, 'geographie', 'Globe2', 4)
  RETURNING id INTO geo_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'maths-tss', 'Mathématiques', 1, 2, 'maths', 'Compass', 5)
  RETURNING id INTO maths_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'anglais-tss', 'Anglais', 2, 2, 'anglais', 'Languages', 6)
  RETURNING id INTO anglais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'francais-tss', 'Français', 2, 2, 'francais', 'PenLine', 7)
  RETURNING id INTO francais_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'ecm-tss', 'Éducation Civique et Morale', 1, 1, 'ecm', 'Landmark', 8)
  RETURNING id INTO ecm_id;

  INSERT INTO subjects (id, series_id, slug, name, coefficient, hours_per_week, color, icon, display_order)
  VALUES (gen_random_uuid(), tss_id, 'eps-tss', 'Éducation Physique et Sportive', 1, 2, 'eps', 'Dumbbell', 9)
  RETURNING id INTO eps_id;

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 1 : La question de l''être et du devenir
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'etre-et-devenir', 1, 'La question de l''être et du devenir', 'De l''Antiquité à l''époque contemporaine : Platon, Aristote, Descartes, Marx, Sartre', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'etre-et-devenir-fiche', 'La question de l''être et du devenir', 'Les grandes conceptions de l''être à travers les époques philosophiques', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''ontologie ?","answer":"L''ontologie est la branche de la philosophie qui étudie l''être en tant qu''être. Elle s''interroge sur la nature fondamentale de la réalité, sur ce qui existe et sur les catégories de l''existence. Le terme vient du grec « ontos » (être) et « logos » (discours, étude)."},
      {"id":"fc2","category":"Citation/Idée","question":"Quelle est la théorie des Idées de Platon ?","answer":"Pour Platon, le monde sensible (ce que nous percevons) n''est qu''une copie imparfaite du monde des Idées (ou Formes). Les Idées sont éternelles, immuables et parfaites. Par exemple, les cercles que nous dessinons sont des copies imparfaites de l''Idée du Cercle parfait. La vraie connaissance consiste à accéder au monde des Idées par la raison."},
      {"id":"fc3","category":"Citation/Idée","question":"Comment Aristote conçoit-il l''être et le devenir ?","answer":"Aristote rejette la séparation platonicienne entre monde sensible et monde des Idées. Pour lui, l''être se dit en plusieurs sens (substance, qualité, quantité...). Le devenir s''explique par les quatre causes : matérielle, formelle, efficiente et finale. La substance individuelle (cet homme, ce cheval) est l''être premier."},
      {"id":"fc4","category":"Citation/Idée","question":"Quelle est la position de Saint Thomas d''Aquin sur l''être ?","answer":"Saint Thomas d''Aquin, philosophe médiéval chrétien, réalise une synthèse entre la philosophie d''Aristote et la théologie chrétienne. Pour lui, Dieu est l''Être par excellence (l''Être nécessaire), et toutes les créatures reçoivent leur être de Dieu. Il distingue l''essence (ce qu''une chose est) de l''existence (le fait qu''elle soit)."},
      {"id":"fc5","category":"Citation/Idée","question":"Quelle est la contribution d''Averroès à la philosophie ?","answer":"Averroès (Ibn Rushd), philosophe arabe du XIIe siècle, est le plus grand commentateur d''Aristote. Il défend l''autonomie de la raison philosophique par rapport à la foi religieuse (théorie de la double vérité). Il soutient l''éternité du monde et l''unicité de l''intellect agent, ce qui a profondément influencé la pensée occidentale médiévale."},
      {"id":"fc6","category":"Citation/Idée","question":"Quel est le cogito de Descartes et sa portée philosophique ?","answer":"Descartes, par le doute méthodique, arrive à la certitude fondamentale : « Je pense, donc je suis » (cogito ergo sum). Même en doutant de tout, je ne peux douter que je doute, donc que je pense, donc que j''existe. Le cogito fonde la philosophie moderne sur le sujet pensant et inaugure le rationalisme."},
      {"id":"fc7","category":"Citation/Idée","question":"Comment Spinoza conçoit-il l''être et la substance ?","answer":"Pour Spinoza, il n''existe qu''une seule substance infinie : Dieu ou la Nature (Deus sive Natura). Tout ce qui existe est un mode (une modification) de cette substance unique. Spinoza est panthéiste : Dieu n''est pas un être transcendant mais la totalité de la réalité. L''homme fait partie de la Nature et est soumis à ses lois."},
      {"id":"fc8","category":"Citation/Idée","question":"Comment Marx conçoit-il l''être humain et le devenir historique ?","answer":"Pour Marx, l''être humain se définit par son travail et ses rapports de production. Le devenir historique est mû par les contradictions économiques et la lutte des classes. L''être n''est pas d''abord une conscience (contre Hegel) mais un être social : « Ce n''est pas la conscience des hommes qui détermine leur être, c''est leur être social qui détermine leur conscience. »"},
      {"id":"fc9","category":"Citation/Idée","question":"Qu''est-ce que l''existentialisme de Sartre ?","answer":"Pour Sartre, « l''existence précède l''essence » : l''homme n''a pas de nature prédéfinie, il se construit par ses choix et ses actes. L''homme est « condamné à être libre ». La mauvaise foi consiste à nier cette liberté en se réfugiant derrière des excuses (déterminisme, nature humaine, rôle social)."},
      {"id":"fc10","category":"Distinction","question":"Quelle est la différence entre l''être et le devenir en philosophie ?","answer":"L''être désigne ce qui est stable, permanent, identique à soi-même (conception de Parménide). Le devenir désigne le changement, le mouvement, la transformation (conception d''Héraclite : « on ne se baigne jamais deux fois dans le même fleuve »). L''histoire de la philosophie est en grande partie une tentative de concilier ces deux notions."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre rationalisme et empirisme ?","answer":"Le rationalisme (Descartes, Spinoza) affirme que la raison est la source principale de la connaissance. Certaines idées sont innées. L''empirisme (Locke, Hume) soutient que toute connaissance vient de l''expérience sensible. L''esprit est une « table rase » à la naissance. Kant tentera une synthèse des deux approches dans la Critique de la raison pure."},
      {"id":"fc12","category":"Méthode","question":"Comment comparer deux philosophes dans une dissertation ?","answer":"Pour comparer deux philosophes : 1) Identifier le problème commun qu''ils traitent. 2) Exposer la thèse de chacun avec des citations précises. 3) Montrer les points de convergence et de divergence. 4) Évaluer la pertinence de chaque position avec des arguments. 5) Proposer éventuellement une synthèse ou un dépassement des deux positions."}
    ],
    "schema": {
      "title": "L''être et le devenir à travers les époques",
      "nodes": [
        {"id":"n1","label":"Être et Devenir","type":"main"},
        {"id":"n2","label":"Antiquité","type":"branch"},
        {"id":"n3","label":"Moyen Âge","type":"branch"},
        {"id":"n4","label":"Époque moderne","type":"branch"},
        {"id":"n5","label":"Époque contemporaine","type":"branch"},
        {"id":"n6","label":"Platon : monde des Idées","type":"leaf"},
        {"id":"n7","label":"Aristote : substance et devenir","type":"leaf"},
        {"id":"n8","label":"Saint Thomas : être et essence","type":"leaf"},
        {"id":"n9","label":"Averroès : raison et foi","type":"leaf"},
        {"id":"n10","label":"Descartes : cogito","type":"leaf"},
        {"id":"n11","label":"Spinoza : substance unique","type":"leaf"},
        {"id":"n12","label":"Marx : être social","type":"leaf"},
        {"id":"n13","label":"Sartre : existence précède essence","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"origines"},
        {"from":"n1","to":"n3","label":"synthèse foi/raison"},
        {"from":"n1","to":"n4","label":"tournant du sujet"},
        {"from":"n1","to":"n5","label":"remise en question"},
        {"from":"n2","to":"n6","label":"idéalisme"},
        {"from":"n2","to":"n7","label":"réalisme"},
        {"from":"n3","to":"n8","label":"christianisme"},
        {"from":"n3","to":"n9","label":"islam"},
        {"from":"n4","to":"n10","label":"rationalisme"},
        {"from":"n4","to":"n11","label":"panthéisme"},
        {"from":"n5","to":"n12","label":"matérialisme"},
        {"from":"n5","to":"n13","label":"existentialisme"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel philosophe a formulé la théorie des Idées ?","options":["Aristote","Platon","Descartes","Spinoza"],"correct":1,"explanation":"Platon a formulé la théorie des Idées (ou Formes) selon laquelle le monde sensible est une copie imparfaite du monde intelligible des Idées éternelles et parfaites."},
      {"id":"q2","question":"Que signifie le cogito de Descartes ?","options":["L''homme est un animal rationnel","Je pense, donc je suis","L''être précède l''essence","Dieu est la substance unique"],"correct":1,"explanation":"Le cogito (« Je pense, donc je suis ») est la première certitude à laquelle Descartes parvient par le doute méthodique. Même en doutant de tout, je ne peux douter que je pense."},
      {"id":"q3","question":"Quel philosophe médiéval est considéré comme le plus grand commentateur d''Aristote ?","options":["Saint Thomas d''Aquin","Saint Augustin","Averroès","Avicenne"],"correct":2,"explanation":"Averroès (Ibn Rushd), philosophe arabe du XIIe siècle, est surnommé « le Commentateur » pour ses commentaires exhaustifs de l''œuvre d''Aristote."},
      {"id":"q4","question":"Selon Sartre, quelle proposition est vraie ?","options":["L''essence précède l''existence","L''existence précède l''essence","L''être et le néant sont identiques","La conscience détermine l''être social"],"correct":1,"explanation":"Pour Sartre, « l''existence précède l''essence » signifie que l''homme existe d''abord et se définit ensuite par ses choix. Il n''a pas de nature humaine prédéfinie."},
      {"id":"q5","question":"Comment Spinoza conçoit-il Dieu ?","options":["Un être transcendant séparé du monde","La substance unique identique à la Nature","Un horloger qui a créé le monde","Une idée de la raison pure"],"correct":1,"explanation":"Spinoza identifie Dieu à la Nature (Deus sive Natura). Pour lui, il n''existe qu''une seule substance infinie dont tout ce qui existe est un mode (une modification)."},
      {"id":"q6","question":"Quelle est la conception de l''être chez Marx ?","options":["L''être est d''abord spirituel","L''être se définit par la conscience","L''être est déterminé par les rapports sociaux de production","L''être est une substance immuable"],"correct":2,"explanation":"Pour Marx, « ce n''est pas la conscience qui détermine l''être social, c''est l''être social qui détermine la conscience ». L''homme se définit par son travail et ses rapports de production."},
      {"id":"q7","question":"Quel philosophe distingue les quatre causes (matérielle, formelle, efficiente, finale) ?","options":["Platon","Descartes","Aristote","Spinoza"],"correct":2,"explanation":"Aristote explique le devenir par quatre causes : la cause matérielle (la matière), formelle (la forme), efficiente (l''agent) et finale (le but). Cette théorie permet de comprendre le changement."},
      {"id":"q8","question":"Saint Thomas d''Aquin réalise une synthèse entre quelles traditions ?","options":["Platonisme et stoïcisme","Aristotélisme et théologie chrétienne","Épicurisme et scepticisme","Marxisme et existentialisme"],"correct":1,"explanation":"Saint Thomas d''Aquin a réalisé une synthèse majeure entre la philosophie d''Aristote et la théologie chrétienne, montrant leur compatibilité."},
      {"id":"q9","question":"Qu''est-ce que la mauvaise foi selon Sartre ?","options":["Le mensonge à autrui","Le doute méthodique","Le refus de reconnaître sa propre liberté","L''ignorance philosophique"],"correct":2,"explanation":"La mauvaise foi chez Sartre consiste à se mentir à soi-même en niant sa propre liberté, par exemple en disant « je n''ai pas le choix » ou « c''est ma nature »."},
      {"id":"q10","question":"Quel philosophe grec a dit « on ne se baigne jamais deux fois dans le même fleuve » ?","options":["Platon","Aristote","Parménide","Héraclite"],"correct":3,"explanation":"Héraclite d''Éphèse, philosophe présocratique, affirme le devenir universel : tout change, tout coule (panta rhei). Le fleuve est son image favorite pour illustrer le changement permanent."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 2 : Grandes figures de l''histoire de la pensée
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'grandes-figures', 2, 'Grandes figures de l''histoire de la pensée', 'Hobbes, Rousseau, Freud et Marcien Towa', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'grandes-figures-fiche', 'Grandes figures de l''histoire de la pensée', 'Hobbes, Rousseau, Freud et Marcien Towa : vies, œuvres et idées', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Citation/Idée","question":"Quelle est la conception de l''état de nature chez Hobbes ?","answer":"Pour Hobbes (1588-1679), l''état de nature est un état de « guerre de tous contre tous » (bellum omnium contra omnes). L''homme est un loup pour l''homme (homo homini lupus). Sans autorité politique, la vie serait « solitaire, pauvre, désagréable, brutale et brève ». Les hommes concluent un pacte social pour sortir de cet état."},
      {"id":"fc2","category":"Citation/Idée","question":"Qu''est-ce que le pacte social selon Hobbes ?","answer":"Chez Hobbes, le pacte social est un contrat par lequel les individus transfèrent tous leurs droits naturels à un souverain absolu (le Léviathan). Ce souverain possède un pouvoir illimité pour maintenir la paix et la sécurité. Le contrat est irréversible : une fois conclu, les sujets ne peuvent le rompre."},
      {"id":"fc3","category":"Citation/Idée","question":"Quelle est la conception de l''état de nature chez Rousseau ?","answer":"Pour Rousseau (1712-1778), l''état de nature est un état de bonheur originel où l''homme est « naturellement bon ». L''homme naturel vit isolé, autosuffisant, guidé par l''amour de soi et la pitié. C''est la société et la propriété privée qui l''ont corrompu : « L''homme est né libre, et partout il est dans les fers. »"},
      {"id":"fc4","category":"Citation/Idée","question":"Quelle est la conception de l''éducation chez Rousseau ?","answer":"Dans l''Émile (1762), Rousseau propose une éducation naturelle : respecter le développement naturel de l''enfant, apprendre par l''expérience plutôt que par les livres, préserver l''innocence naturelle. L''éducation doit former un homme libre et autonome, capable de juger par lui-même, et non un être soumis aux conventions sociales."},
      {"id":"fc5","category":"Citation/Idée","question":"Qu''est-ce que l''inconscient selon Freud ?","answer":"Pour Freud (1856-1939), l''inconscient est la partie la plus vaste de l''appareil psychique. Il contient des désirs refoulés, des souvenirs traumatiques et des pulsions que la conscience refuse d''admettre. L''inconscient se manifeste par les rêves, les lapsus, les actes manqués et les symptômes névrotiques. L''appareil psychique se divise en Ça, Moi et Surmoi."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la cure psychanalytique ?","answer":"La cure psychanalytique est la méthode thérapeutique inventée par Freud. Le patient, allongé sur un divan, pratique l''association libre (dire tout ce qui vient à l''esprit sans censure). L''analyste interprète les rêves, les résistances et le transfert pour rendre conscient ce qui était inconscient. Le but est de libérer le patient de ses conflits psychiques."},
      {"id":"fc7","category":"Citation/Idée","question":"Quel est l''apport majeur de la psychanalyse freudienne ?","answer":"La psychanalyse a révélé : 1) Le rôle des conflits intérieurs inconscients dans les comportements humains. 2) L''importance décisive de l''enfance dans la formation de la personnalité. 3) Le rôle central de la sexualité (libido) dans le développement psychique. Freud a montré que « le moi n''est pas maître dans sa propre maison »."},
      {"id":"fc8","category":"Citation/Idée","question":"Qui est Marcien Towa et quelle est sa vision du développement de l''Afrique ?","answer":"Marcien Towa (1931-2014) est un philosophe camerounais. Pour lui, le développement de l''Afrique passe par l''appropriation critique de la science et de la technique modernes, et non par un retour nostalgique aux traditions. Il critique la négritude de Senghor comme une célébration passive de l''identité. L''Afrique doit « détruire pour construire », c''est-à-dire rompre avec ce qui empêche le progrès."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre la conception de l''état de nature chez Hobbes et Rousseau ?","answer":"Hobbes voit l''état de nature comme un état de guerre et de misère, où l''homme est égoïste et violent. Rousseau le voit comme un état de bonheur où l''homme est bon et paisible. Pour Hobbes, la société sauve l''homme de la violence. Pour Rousseau, la société corrompt l''homme naturellement bon. Les deux justifient cependant un contrat social."},
      {"id":"fc10","category":"Distinction","question":"Quel est le rapport entre le Ça, le Moi et le Surmoi chez Freud ?","answer":"Le Ça est le réservoir des pulsions inconscientes (principe de plaisir). Le Surmoi représente les interdits moraux intériorisés (parents, société). Le Moi est l''instance médiatrice qui tente de concilier les exigences du Ça, du Surmoi et de la réalité extérieure (principe de réalité). Les névroses résultent de conflits entre ces trois instances."},
      {"id":"fc11","category":"Méthode","question":"Comment présenter un philosophe dans une dissertation ?","answer":"Pour présenter un philosophe : 1) Situer brièvement sa vie et son époque. 2) Identifier le problème qu''il traite. 3) Exposer sa thèse principale avec des citations. 4) Montrer l''originalité de sa position par rapport à ses prédécesseurs. 5) Évaluer sa pertinence et ses limites. Toujours relier le philosophe au sujet de la dissertation."},
      {"id":"fc12","category":"Exemple","question":"Comment Marcien Towa critique-t-il la négritude ?","answer":"Towa critique la négritude de Senghor car elle exalte l''émotion et l''intuition nègres face à la raison européenne. Pour Towa, cette opposition est un piège : elle enferme l''Africain dans l''irrationnel et lui interdit l''accès à la science. Il faut au contraire que l''Afrique s''approprie la rationalité scientifique tout en gardant sa créativité culturelle."}
    ],
    "schema": {
      "title": "Grandes figures de la pensée",
      "nodes": [
        {"id":"n1","label":"Grandes figures","type":"main"},
        {"id":"n2","label":"Hobbes (1588-1679)","type":"branch"},
        {"id":"n3","label":"Rousseau (1712-1778)","type":"branch"},
        {"id":"n4","label":"Freud (1856-1939)","type":"branch"},
        {"id":"n5","label":"Towa (1931-2014)","type":"branch"},
        {"id":"n6","label":"État de nature : guerre","type":"leaf"},
        {"id":"n7","label":"Pacte social : Léviathan","type":"leaf"},
        {"id":"n8","label":"Homme naturellement bon","type":"leaf"},
        {"id":"n9","label":"Éducation naturelle (Émile)","type":"leaf"},
        {"id":"n10","label":"Inconscient : Ça, Moi, Surmoi","type":"leaf"},
        {"id":"n11","label":"Cure psychanalytique","type":"leaf"},
        {"id":"n12","label":"Critique de la négritude","type":"leaf"},
        {"id":"n13","label":"Appropriation de la science","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"philosophie politique"},
        {"from":"n1","to":"n3","label":"contrat social"},
        {"from":"n1","to":"n4","label":"psychanalyse"},
        {"from":"n1","to":"n5","label":"philosophie africaine"},
        {"from":"n2","to":"n6","label":"constat"},
        {"from":"n2","to":"n7","label":"solution"},
        {"from":"n3","to":"n8","label":"constat"},
        {"from":"n3","to":"n9","label":"pédagogie"},
        {"from":"n4","to":"n10","label":"théorie"},
        {"from":"n4","to":"n11","label":"pratique"},
        {"from":"n5","to":"n12","label":"critique"},
        {"from":"n5","to":"n13","label":"projet"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Pour Hobbes, l''état de nature est caractérisé par :","options":["La paix et l''harmonie","La guerre de tous contre tous","L''égalité sociale","La bonté naturelle"],"correct":1,"explanation":"Hobbes décrit l''état de nature comme une « guerre de tous contre tous » où la vie est « solitaire, pauvre, désagréable, brutale et brève »."},
      {"id":"q2","question":"Selon Rousseau, qu''est-ce qui a corrompu l''homme naturellement bon ?","options":["La religion","La philosophie","La société et la propriété privée","La science"],"correct":2,"explanation":"Pour Rousseau, c''est la société, en particulier l''institution de la propriété privée, qui a corrompu l''homme naturellement bon et créé les inégalités."},
      {"id":"q3","question":"Quel est le titre de l''œuvre majeure de Hobbes ?","options":["Le Contrat social","Le Léviathan","L''Émile","Le Prince"],"correct":1,"explanation":"Le Léviathan (1651) est l''œuvre majeure de Hobbes, dans laquelle il développe sa théorie du contrat social et de la souveraineté absolue."},
      {"id":"q4","question":"Quelles sont les trois instances de l''appareil psychique selon Freud ?","options":["Conscient, préconscient, inconscient","Ça, Moi, Surmoi","Raison, volonté, désir","Corps, âme, esprit"],"correct":1,"explanation":"Freud distingue le Ça (pulsions inconscientes), le Moi (instance médiatrice) et le Surmoi (interdits moraux intériorisés) comme les trois instances de l''appareil psychique."},
      {"id":"q5","question":"De quel pays est originaire le philosophe Marcien Towa ?","options":["Mali","Sénégal","Cameroun","Côte d''Ivoire"],"correct":2,"explanation":"Marcien Towa (1931-2014) est un philosophe camerounais, auteur de ''Essai sur la problématique philosophique dans l''Afrique actuelle''."},
      {"id":"q6","question":"Que propose Rousseau dans l''Émile ?","options":["Une éducation militaire stricte","Une éducation naturelle respectant le développement de l''enfant","L''abolition de l''éducation","Une éducation uniquement religieuse"],"correct":1,"explanation":"Dans l''Émile (1762), Rousseau propose une éducation naturelle qui respecte les étapes du développement de l''enfant et privilégie l''apprentissage par l''expérience."},
      {"id":"q7","question":"Comment se manifeste l''inconscient selon Freud ?","options":["Par la méditation","Par les rêves, lapsus et actes manqués","Par la prière","Par le raisonnement logique"],"correct":1,"explanation":"L''inconscient se manifeste indirectement par les rêves, les lapsus (erreurs de langage), les actes manqués et les symptômes névrotiques, qui sont autant de « formations de compromis »."},
      {"id":"q8","question":"Que critique Marcien Towa dans la négritude ?","options":["Son manque de poésie","Sa célébration passive de l''identité au détriment de la raison","Son excès de rationalisme","Son rejet des traditions africaines"],"correct":1,"explanation":"Towa critique la négritude de Senghor car elle exalte l''émotion et l''intuition nègres en opposition à la raison, enfermant l''Africain dans l''irrationnel."},
      {"id":"q9","question":"Quel principe régit le fonctionnement du Ça chez Freud ?","options":["Le principe de réalité","Le principe moral","Le principe de plaisir","Le principe de raison"],"correct":2,"explanation":"Le Ça fonctionne selon le principe de plaisir : il cherche la satisfaction immédiate des pulsions, sans tenir compte de la réalité ni de la morale."},
      {"id":"q10","question":"Quelle phrase célèbre de Rousseau ouvre le Contrat social ?","options":["Je pense, donc je suis","L''homme est un loup pour l''homme","L''homme est né libre, et partout il est dans les fers","L''existence précède l''essence"],"correct":2,"explanation":"La phrase « L''homme est né libre, et partout il est dans les fers » ouvre le Contrat social (1762) de Rousseau, posant le problème de la liberté perdue dans la société."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 3 : Technique du commentaire de texte
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'commentaire-texte', 3, 'Technique du commentaire de texte philosophique', 'Identification du problème, de la thèse et structure du commentaire', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'commentaire-texte-fiche', 'Technique du commentaire de texte philosophique', 'Méthode complète pour analyser et commenter un texte de philosophie', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un commentaire de texte philosophique ?","answer":"Le commentaire de texte philosophique est un exercice qui consiste à expliquer un texte d''un auteur philosophique de manière ordonnée. Il faut dégager le problème posé, identifier la thèse de l''auteur, analyser sa structure argumentative, expliquer les concepts clés et évaluer la portée du texte. Ce n''est ni un résumé ni une dissertation."},
      {"id":"fc2","category":"Méthode","question":"Quelles sont les étapes de la lecture préparatoire d''un texte philosophique ?","answer":"1) Lire le texte plusieurs fois attentivement. 2) Identifier le thème général. 3) Repérer la thèse de l''auteur (ce qu''il défend). 4) Identifier le problème philosophique auquel le texte répond. 5) Repérer les connecteurs logiques pour dégager la structure argumentative. 6) Souligner les concepts clés à définir et expliquer."},
      {"id":"fc3","category":"Méthode","question":"Comment identifier la thèse d''un texte philosophique ?","answer":"La thèse est l''idée principale que l''auteur défend dans le texte. Pour la trouver : chercher la phrase qui résume la position de l''auteur (souvent au début ou à la fin). Se demander : « Que veut prouver l''auteur ? Quelle est sa réponse au problème posé ? » La thèse doit être formulée clairement en une ou deux phrases."},
      {"id":"fc4","category":"Méthode","question":"Comment rédiger l''introduction d''un commentaire de texte ?","answer":"L''introduction comprend : 1) L''accroche : amener le thème du texte. 2) La présentation du texte : auteur, œuvre (si connus), thème. 3) La formulation du problème philosophique. 4) L''énoncé de la thèse de l''auteur. 5) L''annonce du plan (les mouvements du texte). L''introduction ne doit pas dépasser 10-15 lignes."},
      {"id":"fc5","category":"Méthode","question":"Comment structurer le développement d''un commentaire ?","answer":"Le développement suit les mouvements du texte (généralement 2 ou 3 parties). Pour chaque mouvement : 1) Énoncer l''idée principale du passage. 2) Expliquer les concepts et arguments de l''auteur. 3) Citer précisément le texte. 4) Analyser le raisonnement. 5) Évaluer (apporter un regard critique si possible). Ne pas paraphraser mais expliquer en profondeur."},
      {"id":"fc6","category":"Méthode","question":"Comment rédiger la conclusion d''un commentaire de texte ?","answer":"La conclusion comprend : 1) Le bilan : rappeler le problème et la thèse de l''auteur. 2) Synthèse : résumer les étapes de l''argumentation analysées. 3) Appréciation critique : évaluer la portée et les limites de la position de l''auteur. 4) Ouverture : élargir vers une question connexe ou un autre philosophe."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre expliquer et paraphraser un texte ?","answer":"Paraphraser, c''est répéter ce que dit l''auteur avec d''autres mots sans ajouter de compréhension. Expliquer, c''est éclairer le sens du texte : définir les concepts, montrer les implications, justifier le raisonnement, relier à des connaissances philosophiques. Le correcteur attend une explication qui montre votre compréhension profonde du texte."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre commentaire de texte et dissertation ?","answer":"Le commentaire part d''un texte précis : il faut expliquer ce que dit l''auteur et évaluer sa position. La dissertation part d''un sujet (question ou citation) : il faut construire sa propre réflexion avec une thèse, une antithèse et une synthèse. Le commentaire est centré sur le texte, la dissertation est centrée sur le problème."},
      {"id":"fc9","category":"Exemple","question":"Comment analyser un connecteur logique dans un texte ?","answer":"Les connecteurs révèlent la structure argumentative. Exemples : « mais », « cependant » → objection ou nuance. « Donc », « par conséquent » → conclusion. « Car », « en effet » → justification. « Or » → prémisse nouvelle. Analyser le connecteur, c''est montrer comment l''argument de l''auteur progresse et se construit."},
      {"id":"fc10","category":"Méthode","question":"Comment citer un texte dans un commentaire ?","answer":"Les citations doivent être : 1) Courtes (quelques mots à une phrase). 2) Intégrées dans votre propre phrase. 3) Mises entre guillemets. 4) Suivies d''une explication. Exemple : L''auteur affirme que « la liberté est le fondement de la morale », ce qui signifie que... Ne jamais citer sans expliquer ni recopier de longs passages."},
      {"id":"fc11","category":"Méthode","question":"Quels sont les pièges à éviter dans un commentaire de texte ?","answer":"Pièges courants : 1) Paraphraser au lieu d''expliquer. 2) Plaquer des connaissances sans rapport avec le texte. 3) Faire une dissertation au lieu d''un commentaire. 4) Oublier de citer le texte. 5) Ne pas identifier le problème philosophique. 6) Séparer explication et critique (les mêler dans chaque partie). 7) Résumer le texte au lieu de l''analyser."},
      {"id":"fc12","category":"Exemple","question":"Donnez un exemple de formulation de problème philosophique.","answer":"Pour un texte de Descartes sur le cogito, le problème pourrait être : « Comment atteindre une certitude absolue face au doute ? Peut-on trouver un fondement indubitable de la connaissance ? » Le problème doit être formulé sous forme de question(s) à laquelle la thèse de l''auteur répond."}
    ],
    "schema": {
      "title": "Structure du commentaire de texte",
      "nodes": [
        {"id":"n1","label":"Commentaire de texte","type":"main"},
        {"id":"n2","label":"Lecture préparatoire","type":"branch"},
        {"id":"n3","label":"Introduction","type":"branch"},
        {"id":"n4","label":"Développement","type":"branch"},
        {"id":"n5","label":"Conclusion","type":"branch"},
        {"id":"n6","label":"Thème, thèse, problème","type":"leaf"},
        {"id":"n7","label":"Structure argumentative","type":"leaf"},
        {"id":"n8","label":"Accroche + thèse + plan","type":"leaf"},
        {"id":"n9","label":"Mouvement 1 : explication","type":"leaf"},
        {"id":"n10","label":"Mouvement 2 : analyse","type":"leaf"},
        {"id":"n11","label":"Bilan et synthèse","type":"leaf"},
        {"id":"n12","label":"Appréciation critique","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"étape 1"},
        {"from":"n1","to":"n3","label":"étape 2"},
        {"from":"n1","to":"n4","label":"étape 3"},
        {"from":"n1","to":"n5","label":"étape 4"},
        {"from":"n2","to":"n6","label":"identifier"},
        {"from":"n2","to":"n7","label":"repérer"},
        {"from":"n3","to":"n8","label":"rédiger"},
        {"from":"n4","to":"n9","label":"partie I"},
        {"from":"n4","to":"n10","label":"partie II"},
        {"from":"n5","to":"n11","label":"résumer"},
        {"from":"n5","to":"n12","label":"évaluer"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel est le but principal du commentaire de texte philosophique ?","options":["Résumer le texte","Expliquer et évaluer la thèse de l''auteur","Donner son opinion personnelle","Raconter la vie de l''auteur"],"correct":1,"explanation":"Le commentaire vise à expliquer le texte de manière ordonnée : dégager le problème, analyser la thèse et l''argumentation, puis évaluer la portée de la position de l''auteur."},
      {"id":"q2","question":"Que faut-il identifier en premier dans un texte philosophique ?","options":["La biographie de l''auteur","Le problème philosophique et la thèse","Le nombre de paragraphes","Les figures de style"],"correct":1,"explanation":"La première étape est d''identifier le problème philosophique auquel le texte répond et la thèse (la position) que l''auteur défend."},
      {"id":"q3","question":"Quelle est la différence entre commenter et paraphraser ?","options":["Il n''y a aucune différence","Commenter c''est résumer, paraphraser c''est expliquer","Commenter c''est expliquer en profondeur, paraphraser c''est répéter sans ajouter de sens","Commenter c''est critiquer, paraphraser c''est approuver"],"correct":2,"explanation":"Paraphraser consiste à répéter les mots de l''auteur sans les éclairer. Commenter, c''est analyser, définir les concepts, montrer les implications et évaluer le raisonnement."},
      {"id":"q4","question":"Que doit contenir l''introduction d''un commentaire ?","options":["Seulement le résumé du texte","Accroche, présentation, problème, thèse et plan","Uniquement l''annonce du plan","La biographie complète de l''auteur"],"correct":1,"explanation":"L''introduction doit comprendre : une accroche, la présentation du texte, la formulation du problème, l''énoncé de la thèse de l''auteur et l''annonce du plan."},
      {"id":"q5","question":"Comment doit-on utiliser les citations dans un commentaire ?","options":["Recopier de longs passages du texte","Citer sans jamais expliquer","Citer brièvement et toujours expliquer ensuite","Ne jamais citer le texte"],"correct":2,"explanation":"Les citations doivent être courtes, entre guillemets, intégrées dans votre phrase et toujours suivies d''une explication. Ne jamais citer sans expliquer."},
      {"id":"q6","question":"Quel connecteur indique une objection ou une nuance ?","options":["Donc","En effet","Mais, cependant","Car"],"correct":2,"explanation":"Les connecteurs « mais », « cependant », « toutefois », « néanmoins » signalent une objection, une nuance ou un retournement dans l''argumentation de l''auteur."},
      {"id":"q7","question":"Le développement du commentaire suit :","options":["Un plan thèse-antithèse-synthèse","Les mouvements du texte","L''ordre chronologique de la vie de l''auteur","Un plan libre sans lien avec le texte"],"correct":1,"explanation":"Le développement du commentaire suit les mouvements du texte, c''est-à-dire les grandes étapes de l''argumentation de l''auteur, généralement 2 ou 3 parties."},
      {"id":"q8","question":"Quel piège faut-il absolument éviter au bac ?","options":["Citer le texte","Expliquer les concepts","Faire une dissertation au lieu d''un commentaire","Formuler le problème"],"correct":2,"explanation":"Un piège courant est de transformer le commentaire en dissertation en développant ses propres idées sans analyser le texte. Le commentaire doit rester centré sur le texte de l''auteur."},
      {"id":"q9","question":"La conclusion du commentaire doit contenir :","options":["De nouvelles idées jamais évoquées","Le bilan, la synthèse et une ouverture","Seulement la reformulation du sujet","La correction des erreurs de l''auteur"],"correct":1,"explanation":"La conclusion comprend le bilan (rappel du problème et de la thèse), la synthèse de l''analyse, une appréciation critique et une ouverture vers une question connexe."},
      {"id":"q10","question":"Comment formuler le problème philosophique d''un texte ?","options":["Résumer le texte en une phrase","Poser une question à laquelle la thèse de l''auteur répond","Critiquer l''auteur","Citer un autre philosophe"],"correct":1,"explanation":"Le problème philosophique se formule sous forme de question(s) fondamentale(s) à laquelle la thèse de l''auteur constitue une réponse argumentée."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 4 : L''homme et le monde
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'homme-et-monde', 4, 'L''homme et le monde', 'Nature et culture, langage, travail et mondialisation, démocratie', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'homme-et-monde-fiche', 'L''homme et le monde', 'Nature/culture, langage, travail, mondialisation et démocratie', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la nature humaine ?","answer":"La nature humaine désigne l''ensemble des caractéristiques essentielles qui définissent l''être humain en tant que tel, indépendamment des différences culturelles. La question est controversée : pour les essentialistes (Aristote), l''homme a une nature fixe (animal rationnel). Pour les existentialistes (Sartre), il n''y a pas de nature humaine : l''homme se construit par ses choix."},
      {"id":"fc2","category":"Distinction","question":"Quelle est la différence entre nature et culture ?","answer":"La nature désigne ce qui est inné, universel, biologique (respirer, manger). La culture désigne ce qui est acquis, variable, appris (langage, coutumes, techniques). Lévi-Strauss propose comme critère de distinction : est naturel ce qui est universel et spontané ; est culturel ce qui relève de règles et varie selon les sociétés. La règle de l''interdit de l''inceste marque le passage de la nature à la culture."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que la maîtrise de la nature ?","answer":"La maîtrise de la nature est le projet moderne de dominer et transformer la nature par la science et la technique pour améliorer les conditions de vie humaine. Descartes parle de se rendre « maîtres et possesseurs de la nature ». Aujourd''hui, la crise écologique remet en question ce projet : la domination excessive menace la survie même de l''humanité."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que le langage et quels sont les éléments de la communication ?","answer":"Le langage est la faculté humaine de communiquer par un système de signes (mots, gestes). Les éléments de la communication (schéma de Jakobson) sont : l''émetteur (qui parle), le récepteur (qui écoute), le message (ce qui est dit), le code (la langue), le canal (le moyen) et le référent (ce dont on parle). Le langage distingue l''homme de l''animal."},
      {"id":"fc5","category":"Citation/Idée","question":"Quel est le rapport entre travail, progrès et développement ?","answer":"Le travail est l''activité par laquelle l''homme transforme la nature pour satisfaire ses besoins. Hegel y voit un moyen de réalisation de soi (dialectique du maître et de l''esclave). Marx dénonce l''aliénation du travailleur dans le capitalisme. Le progrès technique augmente la productivité mais peut aussi déshumaniser le travail. Le développement suppose un progrès équitable et durable."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la mondialisation ?","answer":"La mondialisation est le processus d''intensification des échanges économiques, culturels et politiques à l''échelle planétaire. Elle a des avantages (ouverture, croissance) et des inconvénients (inégalités, uniformisation culturelle, exploitation). Pour le Mali, elle pose la question de l''intégration dans l''économie mondiale tout en préservant l''identité culturelle."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la démocratie ?","answer":"La démocratie est un régime politique où le pouvoir appartient au peuple. Elle repose sur la souveraineté populaire, la séparation des pouvoirs (législatif, exécutif, judiciaire), le pluralisme politique, les élections libres et le respect des droits fondamentaux. Tocqueville avertit du risque de « tyrannie de la majorité ». Au Mali, la démocratie est instaurée depuis 1991."},
      {"id":"fc8","category":"Citation/Idée","question":"Qu''est-ce que les droits de l''homme ?","answer":"Les droits de l''homme sont des droits inaliénables et universels reconnus à tout être humain : liberté, égalité, dignité, sûreté. La Déclaration universelle des droits de l''homme (1948) en est le texte fondateur. Leur universalité est débattue : certains y voient des valeurs occidentales imposées, d''autres des principes universels transcendant les cultures."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre liberté et égalité ?","answer":"La liberté est le droit d''agir selon sa volonté dans les limites de la loi. L''égalité est le principe selon lequel tous les hommes ont les mêmes droits. Ces deux valeurs peuvent entrer en tension : une liberté absolue engendre des inégalités (le plus fort domine), une égalité absolue peut limiter les libertés individuelles. La démocratie cherche à concilier les deux."},
      {"id":"fc10","category":"Exemple","question":"Comment le langage peut-il être un instrument de pouvoir ?","answer":"Le langage peut dominer : la propagande politique manipule par les mots, la « novlangue » d''Orwell (1984) appauvrit la pensée. Celui qui maîtrise le langage maîtrise la communication et le pouvoir. En Afrique, la question des langues nationales vs langues coloniales illustre ce rapport de pouvoir : le français reste la langue du pouvoir au Mali."},
      {"id":"fc11","category":"Méthode","question":"Comment traiter un sujet sur nature et culture ?","answer":"1) Définir précisément les deux termes. 2) Montrer leur opposition (inné vs acquis). 3) Nuancer : la frontière est floue (l''homme est un être de nature et de culture). 4) Donner des exemples concrets (enfants sauvages, diversité culturelle). 5) Conclure en montrant que l''homme est toujours à la fois naturel et culturel."},
      {"id":"fc12","category":"Citation/Idée","question":"Que signifie l''expression « animal politique » d''Aristote ?","answer":"Pour Aristote, l''homme est un « animal politique » (zoon politikon) : il est naturellement fait pour vivre en société. Celui qui vit hors de la cité est « soit une bête, soit un dieu ». La vie en société n''est pas un choix mais une nécessité de la nature humaine. Le langage, propre à l''homme, est l''outil de cette vie politique."}
    ],
    "schema": {
      "title": "L''homme et le monde",
      "nodes": [
        {"id":"n1","label":"L''homme et le monde","type":"main"},
        {"id":"n2","label":"Nature et culture","type":"branch"},
        {"id":"n3","label":"Langage","type":"branch"},
        {"id":"n4","label":"Travail et mondialisation","type":"branch"},
        {"id":"n5","label":"Démocratie et droits","type":"branch"},
        {"id":"n6","label":"Inné vs acquis","type":"leaf"},
        {"id":"n7","label":"Maîtrise de la nature","type":"leaf"},
        {"id":"n8","label":"Communication (Jakobson)","type":"leaf"},
        {"id":"n9","label":"Progrès et aliénation","type":"leaf"},
        {"id":"n10","label":"Mondialisation","type":"leaf"},
        {"id":"n11","label":"Souveraineté populaire","type":"leaf"},
        {"id":"n12","label":"Droits de l''homme","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"anthropologie"},
        {"from":"n1","to":"n3","label":"communication"},
        {"from":"n1","to":"n4","label":"économie"},
        {"from":"n1","to":"n5","label":"politique"},
        {"from":"n2","to":"n6","label":"distinction"},
        {"from":"n2","to":"n7","label":"projet moderne"},
        {"from":"n3","to":"n8","label":"schéma"},
        {"from":"n4","to":"n9","label":"Marx/Hegel"},
        {"from":"n4","to":"n10","label":"échanges"},
        {"from":"n5","to":"n11","label":"fondement"},
        {"from":"n5","to":"n12","label":"universalité"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Selon Lévi-Strauss, quel critère distingue nature et culture ?","options":["Le langage","L''universalité (nature) vs la règle variable (culture)","La religion","L''intelligence"],"correct":1,"explanation":"Pour Lévi-Strauss, est naturel ce qui est universel et spontané, est culturel ce qui relève de règles et varie selon les sociétés. L''interdit de l''inceste est la charnière entre les deux."},
      {"id":"q2","question":"Qui a dit que l''homme doit se rendre « maître et possesseur de la nature » ?","options":["Aristote","Rousseau","Descartes","Marx"],"correct":2,"explanation":"Descartes, dans le Discours de la méthode (1637), affirme que la science et la technique doivent nous rendre « comme maîtres et possesseurs de la nature »."},
      {"id":"q3","question":"Que signifie « zoon politikon » chez Aristote ?","options":["Animal sauvage","Animal rationnel","Animal politique","Animal social"],"correct":2,"explanation":"Pour Aristote, l''homme est un « animal politique » (zoon politikon), naturellement fait pour vivre en cité (polis) et participer à la vie politique."},
      {"id":"q4","question":"Quels sont les éléments de la communication selon Jakobson ?","options":["Sujet, verbe, complément","Émetteur, récepteur, message, code, canal, référent","Parole, écriture, geste","Conscient et inconscient"],"correct":1,"explanation":"Le schéma de Jakobson identifie 6 éléments de la communication : émetteur, récepteur, message, code, canal et référent."},
      {"id":"q5","question":"Comment Marx qualifie-t-il la condition du travailleur dans le capitalisme ?","options":["Libération","Aliénation","Émancipation","Satisfaction"],"correct":1,"explanation":"Marx parle d''aliénation du travailleur : dans le capitalisme, l''ouvrier est séparé du produit de son travail, de l''activité de production, de son être générique et des autres hommes."},
      {"id":"q6","question":"Depuis quelle année le Mali est-il une démocratie ?","options":["1960","1968","1991","2000"],"correct":2,"explanation":"Le Mali est devenu une démocratie en 1991 après la révolution du 26 mars 1991 qui a mis fin au régime de Moussa Traoré."},
      {"id":"q7","question":"Quel texte est le fondement des droits de l''homme au niveau international ?","options":["La Constitution malienne","La Déclaration universelle des droits de l''homme (1948)","Le Code Napoléon","La Charte de l''Atlantique"],"correct":1,"explanation":"La Déclaration universelle des droits de l''homme, adoptée le 10 décembre 1948 par l''ONU, est le texte fondateur des droits humains au niveau international."},
      {"id":"q8","question":"Quel risque Tocqueville identifie-t-il dans la démocratie ?","options":["L''anarchie","La tyrannie de la majorité","La dictature militaire","L''absence de lois"],"correct":1,"explanation":"Tocqueville, dans De la démocratie en Amérique, met en garde contre la « tyrannie de la majorité » : la majorité peut opprimer les minorités en imposant ses vues."},
      {"id":"q9","question":"La mondialisation se caractérise principalement par :","options":["L''isolement des nations","L''intensification des échanges à l''échelle planétaire","La fin du commerce","Le retour aux traditions"],"correct":1,"explanation":"La mondialisation est le processus d''intensification des échanges économiques, culturels et politiques à l''échelle mondiale, facilité par les transports et les technologies de communication."},
      {"id":"q10","question":"Quelle est la position de Sartre sur la nature humaine ?","options":["L''homme a une nature fixe et immuable","L''homme est naturellement bon","Il n''y a pas de nature humaine, l''homme se construit par ses choix","L''homme est déterminé par ses gènes"],"correct":2,"explanation":"Pour Sartre, « l''existence précède l''essence » : l''homme n''a pas de nature prédéfinie, il se définit par ses actes et ses choix libres."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 5 : Histoire et progrès
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'histoire-et-progres', 5, 'Histoire et progrès', 'Marx, la lutte des classes et le matérialisme historique', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'histoire-et-progres-fiche', 'Histoire et progrès', 'Marx : lutte des classes et matérialisme historique', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le matérialisme historique ?","answer":"Le matérialisme historique est la théorie de Marx selon laquelle l''évolution des sociétés s''explique par les conditions matérielles d''existence (économie, modes de production) et non par les idées. L''infrastructure économique (forces productives + rapports de production) détermine la superstructure (droit, politique, religion, philosophie)."},
      {"id":"fc2","category":"Citation/Idée","question":"Qu''est-ce que la lutte des classes selon Marx ?","answer":"Pour Marx, « l''histoire de toute société jusqu''à nos jours est l''histoire de la lutte des classes » (Manifeste du Parti communiste, 1848). Dans chaque époque, une classe dominante exploite une classe dominée : maîtres/esclaves dans l''Antiquité, seigneurs/serfs au Moyen Âge, bourgeois/prolétaires dans le capitalisme. Cette lutte est le moteur de l''histoire."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que l''infrastructure et la superstructure chez Marx ?","answer":"L''infrastructure est la base économique de la société : les forces productives (outils, machines, travail) et les rapports de production (propriété des moyens de production). La superstructure comprend les institutions politiques, juridiques, religieuses et culturelles. Marx affirme que l''infrastructure détermine la superstructure."},
      {"id":"fc4","category":"Citation/Idée","question":"Qu''est-ce que la dialectique chez Marx ?","answer":"Marx emprunte à Hegel la méthode dialectique mais la « renverse » : au lieu de la dialectique de l''Esprit (idéalisme), il propose une dialectique matérialiste. L''histoire avance par contradictions : chaque mode de production engendre ses propres contradictions qui mènent à son dépassement. Le capitalisme porte en lui les germes de sa propre destruction."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre idéalisme et matérialisme historique ?","answer":"L''idéalisme (Hegel) pense que les idées, la conscience et l''Esprit sont le moteur de l''histoire. Le matérialisme (Marx) affirme que ce sont les conditions matérielles (économie, travail, production) qui déterminent l''histoire et la conscience. Marx dit : « Ce n''est pas la conscience qui détermine l''être social, c''est l''être social qui détermine la conscience. »"},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que le prolétariat selon Marx ?","answer":"Le prolétariat est la classe des travailleurs salariés qui ne possèdent pas les moyens de production et qui sont contraints de vendre leur force de travail à la bourgeoisie. Marx voit dans le prolétariat la classe révolutionnaire qui renversera le capitalisme et instaurera une société sans classes."},
      {"id":"fc7","category":"Citation/Idée","question":"Comment Marx conçoit-il le progrès historique ?","answer":"Le progrès n''est pas linéaire mais dialectique : chaque époque porte en elle les contradictions qui mèneront à l''époque suivante. Les modes de production se succèdent : communisme primitif → esclavagisme → féodalisme → capitalisme → socialisme → communisme. Le progrès est le résultat de la lutte des classes, pas d''un plan providentiel."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre bourgeoisie et prolétariat ?","answer":"La bourgeoisie est la classe qui possède les moyens de production (usines, terres, capitaux). Le prolétariat est la classe qui ne possède que sa force de travail. Le rapport entre les deux est un rapport d''exploitation : la bourgeoisie extrait la plus-value du travail du prolétaire (il produit plus de valeur qu''il ne reçoit en salaire)."},
      {"id":"fc9","category":"Définition","question":"Qu''est-ce que la plus-value chez Marx ?","answer":"La plus-value est la différence entre la valeur produite par le travailleur et le salaire qu''il reçoit. C''est la source du profit capitaliste. Par exemple, si un ouvrier produit pour 100 unités de valeur par jour mais ne reçoit que 50 en salaire, la plus-value est de 50. Marx voit dans la plus-value le mécanisme fondamental de l''exploitation capitaliste."},
      {"id":"fc10","category":"Exemple","question":"Comment la lutte des classes s''applique-t-elle au contexte africain ?","answer":"En Afrique et au Mali, la grille marxiste peut éclairer : les rapports entre élites urbaines et paysans, l''exploitation des ressources par les multinationales, les inégalités croissantes liées à la mondialisation, ou encore les luttes syndicales des travailleurs maliens pour de meilleures conditions. Cependant, la structure sociale africaine ne se réduit pas à deux classes."},
      {"id":"fc11","category":"Méthode","question":"Comment utiliser Marx dans une dissertation ?","answer":"1) Citer précisément Marx (Manifeste, Capital, Idéologie allemande). 2) Expliquer le concept mobilisé (lutte des classes, aliénation, etc.). 3) Montrer sa pertinence pour le sujet. 4) Apporter des nuances et critiques (Weber : rôle des idées ; Aron : pluralisme des conflits). 5) Ne pas réduire Marx au marxisme politique (URSS)."},
      {"id":"fc12","category":"Citation/Idée","question":"Qu''est-ce que l''aliénation selon Marx ?","answer":"L''aliénation est le processus par lequel le travailleur devient étranger à lui-même dans le capitalisme. Il est aliéné par rapport : 1) au produit de son travail (qui ne lui appartient pas), 2) à l''activité de production (travail imposé), 3) à son être générique (sa créativité humaine), 4) aux autres hommes (concurrence). L''aliénation déshumanise le travailleur."}
    ],
    "schema": {
      "title": "Marx : Histoire et progrès",
      "nodes": [
        {"id":"n1","label":"Matérialisme historique","type":"main"},
        {"id":"n2","label":"Infrastructure","type":"branch"},
        {"id":"n3","label":"Superstructure","type":"branch"},
        {"id":"n4","label":"Lutte des classes","type":"branch"},
        {"id":"n5","label":"Dialectique","type":"branch"},
        {"id":"n6","label":"Forces productives","type":"leaf"},
        {"id":"n7","label":"Rapports de production","type":"leaf"},
        {"id":"n8","label":"Droit, politique, religion","type":"leaf"},
        {"id":"n9","label":"Bourgeoisie vs prolétariat","type":"leaf"},
        {"id":"n10","label":"Plus-value et exploitation","type":"leaf"},
        {"id":"n11","label":"Contradictions internes","type":"leaf"},
        {"id":"n12","label":"Succession des modes de production","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"base économique"},
        {"from":"n1","to":"n3","label":"déterminée par"},
        {"from":"n1","to":"n4","label":"moteur"},
        {"from":"n1","to":"n5","label":"méthode"},
        {"from":"n2","to":"n6","label":"outils/machines"},
        {"from":"n2","to":"n7","label":"propriété"},
        {"from":"n3","to":"n8","label":"institutions"},
        {"from":"n4","to":"n9","label":"conflit"},
        {"from":"n4","to":"n10","label":"mécanisme"},
        {"from":"n5","to":"n11","label":"thèse/antithèse"},
        {"from":"n5","to":"n12","label":"progrès historique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Selon Marx, qu''est-ce qui est le moteur de l''histoire ?","options":["Les grandes idées","La lutte des classes","La volonté divine","Le progrès technique seul"],"correct":1,"explanation":"Pour Marx, « l''histoire de toute société est l''histoire de la lutte des classes ». Ce sont les conflits entre classes exploiteuses et exploitées qui font avancer l''histoire."},
      {"id":"q2","question":"Que détermine l''infrastructure selon Marx ?","options":["Le climat","La superstructure (droit, politique, religion)","La géographie","La biologie humaine"],"correct":1,"explanation":"L''infrastructure économique (forces productives + rapports de production) détermine la superstructure (institutions politiques, juridiques, religieuses et culturelles)."},
      {"id":"q3","question":"Qu''est-ce que la plus-value ?","options":["Le salaire du travailleur","La différence entre la valeur produite et le salaire reçu","Le prix de vente d''un produit","L''impôt sur le revenu"],"correct":1,"explanation":"La plus-value est la différence entre la valeur produite par le travailleur et son salaire. C''est la source du profit capitaliste et le mécanisme de l''exploitation."},
      {"id":"q4","question":"Quel philosophe Marx « renverse » pour fonder son matérialisme ?","options":["Platon","Descartes","Hegel","Aristote"],"correct":2,"explanation":"Marx « renverse » la dialectique de Hegel : au lieu d''une dialectique idéaliste de l''Esprit, il propose une dialectique matérialiste fondée sur les conditions économiques."},
      {"id":"q5","question":"Quelle est la classe révolutionnaire chez Marx ?","options":["La bourgeoisie","L''aristocratie","Le prolétariat","La paysannerie"],"correct":2,"explanation":"Pour Marx, le prolétariat est la classe révolutionnaire qui renversera le capitalisme car il n''a « rien à perdre que ses chaînes » et représente l''intérêt universel."},
      {"id":"q6","question":"Quel est l''ordre des modes de production selon Marx ?","options":["Féodalisme → capitalisme → esclavagisme","Communisme primitif → esclavagisme → féodalisme → capitalisme","Capitalisme → féodalisme → socialisme","Socialisme → capitalisme → communisme"],"correct":1,"explanation":"Marx décrit la succession : communisme primitif → esclavagisme → féodalisme → capitalisme → socialisme → communisme, chaque mode engendrant les contradictions menant au suivant."},
      {"id":"q7","question":"L''aliénation du travailleur chez Marx signifie :","options":["Le travailleur est satisfait","Le travailleur devient étranger à lui-même","Le travailleur est libre","Le travailleur possède les moyens de production"],"correct":1,"explanation":"L''aliénation signifie que le travailleur devient étranger à lui-même : il ne se reconnaît pas dans son travail ni dans le produit de son travail."},
      {"id":"q8","question":"Dans quel ouvrage Marx écrit-il que l''histoire est l''histoire de la lutte des classes ?","options":["Le Capital","L''Idéologie allemande","Le Manifeste du Parti communiste","La Sainte Famille"],"correct":2,"explanation":"C''est dans le Manifeste du Parti communiste (1848), co-écrit avec Engels, que Marx affirme que l''histoire de toute société est l''histoire de la lutte des classes."},
      {"id":"q9","question":"Quelle critique majeure adresse-t-on au matérialisme historique ?","options":["Il accorde trop d''importance à la culture","Il réduit tout à l''économie en négligeant le rôle des idées et des valeurs","Il est trop spiritualiste","Il ignore l''existence des classes sociales"],"correct":1,"explanation":"La critique principale est le réductionnisme économique : Marx sous-estime le rôle des idées, de la religion, de la culture (Weber montre que l''éthique protestante a influencé le capitalisme)."},
      {"id":"q10","question":"Que signifie « Ce n''est pas la conscience qui détermine l''être, c''est l''être social qui détermine la conscience » ?","options":["Les idées créent la réalité","Les conditions matérielles façonnent notre manière de penser","La conscience est indépendante de la société","L''être humain est purement spirituel"],"correct":1,"explanation":"Cette phrase célèbre de Marx signifie que nos idées, nos croyances et notre conscience sont déterminées par notre position dans les rapports de production et nos conditions matérielles d''existence."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 6 : Épistémologie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'epistemologie', 6, 'Épistémologie', 'Pensée scientifique, esprit scientifique, types de sciences, obstacles épistémologiques', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'epistemologie-fiche', 'Épistémologie', 'Science, méthode scientifique et obstacles épistémologiques', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''épistémologie ?","answer":"L''épistémologie est la branche de la philosophie qui étudie la connaissance scientifique : ses fondements, ses méthodes, sa valeur et ses limites. Elle s''interroge sur ce qui distingue la science des autres formes de savoir (opinion, croyance, mythe). Le terme vient du grec « epistémè » (science, connaissance certaine) et « logos » (discours)."},
      {"id":"fc2","category":"Citation/Idée","question":"Comment a émergé la pensée scientifique ?","answer":"La pensée scientifique émerge dans la Grèce antique avec le passage du mythe au logos (raison). Thalès, Pythagore et les présocratiques cherchent des explications rationnelles des phénomènes naturels. La révolution scientifique moderne (XVIe-XVIIe siècles) avec Galilée, Copernic et Newton introduit la méthode expérimentale et la mathématisation de la nature."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que l''esprit scientifique selon Bachelard ?","answer":"Pour Bachelard, l''esprit scientifique est un esprit de remise en question permanente. Il se forme « contre » les évidences premières, les opinions et les préjugés. « L''opinion pense mal ; elle ne pense pas. » L''esprit scientifique dit « non » à l''expérience première et reconstruit le réel par la raison et l''expérimentation rigoureuse."},
      {"id":"fc4","category":"Distinction","question":"Quels sont les différents types de sciences ?","answer":"On distingue : 1) Les sciences formelles (mathématiques, logique) qui étudient des objets abstraits par la démonstration. 2) Les sciences expérimentales (physique, chimie, biologie) qui étudient la nature par l''observation et l''expérimentation. 3) Les sciences humaines et sociales (sociologie, psychologie, histoire) qui étudient l''homme et la société."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre science et technique ?","answer":"La science vise la connaissance théorique du réel (savoir pourquoi). La technique vise l''application pratique (savoir comment). La science cherche la vérité, la technique cherche l''efficacité. Historiquement, la technique a précédé la science (artisans avant savants). Aujourd''hui, science et technique sont étroitement liées : la technoscience."},
      {"id":"fc6","category":"Citation/Idée","question":"Qu''est-ce qu''un obstacle épistémologique selon Bachelard ?","answer":"Un obstacle épistémologique est un frein interne à la connaissance scientifique. Bachelard en identifie plusieurs : l''expérience première (croire ce que l''on voit), la généralisation hâtive, l''obstacle verbal (les métaphores trompeuses), la connaissance unitaire (tout ramener à un seul principe), l''obstacle animiste (projeter la vie sur la matière). La science progresse en surmontant ces obstacles."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la philosophie des mathématiques ?","answer":"La philosophie des mathématiques s''interroge sur la nature des objets mathématiques : existent-ils réellement (platonisme) ou sont-ils des constructions de l''esprit (constructivisme) ? Les nombres, les figures géométriques sont-ils découverts ou inventés ? Pourquoi les mathématiques sont-elles si efficaces pour décrire le monde physique ?"},
      {"id":"fc8","category":"Méthode","question":"Quelles sont les étapes de la méthode expérimentale ?","answer":"La méthode expérimentale (Claude Bernard) comprend : 1) L''observation d''un fait. 2) La formulation d''une hypothèse explicative. 3) La mise en place d''une expérience pour tester l''hypothèse. 4) L''analyse des résultats. 5) La conclusion : confirmation ou réfutation de l''hypothèse. Ce cycle peut être répété (méthode itérative)."},
      {"id":"fc9","category":"Citation/Idée","question":"Qu''est-ce que le critère de falsifiabilité de Popper ?","answer":"Pour Karl Popper, une théorie est scientifique si et seulement si elle est falsifiable (réfutable) : elle doit pouvoir être contredite par l''expérience. Une théorie qui explique tout (astrologie, certaines interprétations de la psychanalyse) n''est pas scientifique car elle ne prend aucun risque d''être réfutée. La science progresse par conjectures et réfutations."},
      {"id":"fc10","category":"Distinction","question":"Quelle différence entre opinion et connaissance scientifique ?","answer":"L''opinion est une croyance subjective, non vérifiée, souvent fondée sur l''habitude ou le préjugé. La connaissance scientifique est objective, méthodique, vérifiable et réfutable. Bachelard affirme : « La science s''oppose absolument à l''opinion. » L''opinion peut être vraie par hasard, mais elle n''est pas fondée rationnellement."},
      {"id":"fc11","category":"Exemple","question":"Donnez un exemple d''obstacle épistémologique.","answer":"L''obstacle de l''expérience première : quand on voit le soleil se lever et se coucher, on croit spontanément que le Soleil tourne autour de la Terre (géocentrisme). La science a dû surmonter cette évidence trompeuse pour établir l''héliocentrisme (Copernic, Galilée). Nos sens nous trompent et la science doit aller contre l''évidence immédiate."},
      {"id":"fc12","category":"Méthode","question":"Comment traiter un sujet d''épistémologie au bac ?","answer":"1) Définir les termes clés (science, vérité, méthode). 2) Distinguer les types de sciences. 3) Mobiliser Bachelard (obstacles épistémologiques, rupture avec l''opinion), Popper (falsifiabilité), Kuhn (paradigmes). 4) Donner des exemples concrets de la pratique scientifique. 5) Discuter les limites de la science (questions éthiques, incertitude)."}
    ],
    "schema": {
      "title": "Épistémologie : la connaissance scientifique",
      "nodes": [
        {"id":"n1","label":"Épistémologie","type":"main"},
        {"id":"n2","label":"Émergence de la science","type":"branch"},
        {"id":"n3","label":"Esprit scientifique","type":"branch"},
        {"id":"n4","label":"Types de sciences","type":"branch"},
        {"id":"n5","label":"Obstacles épistémologiques","type":"branch"},
        {"id":"n6","label":"Du mythe au logos","type":"leaf"},
        {"id":"n7","label":"Révolution scientifique","type":"leaf"},
        {"id":"n8","label":"Rupture avec l''opinion (Bachelard)","type":"leaf"},
        {"id":"n9","label":"Formelles, expérimentales, humaines","type":"leaf"},
        {"id":"n10","label":"Science vs technique","type":"leaf"},
        {"id":"n11","label":"Expérience première","type":"leaf"},
        {"id":"n12","label":"Généralisation hâtive","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"histoire"},
        {"from":"n1","to":"n3","label":"attitude"},
        {"from":"n1","to":"n4","label":"classification"},
        {"from":"n1","to":"n5","label":"difficultés"},
        {"from":"n2","to":"n6","label":"Grèce antique"},
        {"from":"n2","to":"n7","label":"XVIe-XVIIe siècles"},
        {"from":"n3","to":"n8","label":"Bachelard"},
        {"from":"n4","to":"n9","label":"3 catégories"},
        {"from":"n4","to":"n10","label":"distinction"},
        {"from":"n5","to":"n11","label":"obstacle 1"},
        {"from":"n5","to":"n12","label":"obstacle 2"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Qu''est-ce que l''épistémologie ?","options":["L''étude de la morale","L''étude de la connaissance scientifique","L''étude de la beauté","L''étude de l''être"],"correct":1,"explanation":"L''épistémologie est la branche de la philosophie qui étudie la connaissance scientifique, ses fondements, ses méthodes et ses limites."},
      {"id":"q2","question":"Selon Bachelard, quel est le rapport entre science et opinion ?","options":["La science prolonge l''opinion","La science s''oppose absolument à l''opinion","La science et l''opinion sont identiques","L''opinion est plus fiable que la science"],"correct":1,"explanation":"Bachelard affirme que « la science s''oppose absolument à l''opinion ». La connaissance scientifique se construit contre les évidences premières et les préjugés."},
      {"id":"q3","question":"Qu''est-ce qu''un obstacle épistémologique ?","options":["Un problème de financement de la recherche","Un frein interne à la connaissance scientifique","Un manque de matériel","Une erreur de calcul"],"correct":1,"explanation":"Un obstacle épistémologique est un frein interne à l''esprit qui empêche la connaissance scientifique de progresser (expérience première, généralisation hâtive, etc.)."},
      {"id":"q4","question":"Selon Popper, quand une théorie est-elle scientifique ?","options":["Quand elle est vraie","Quand elle est acceptée par la majorité","Quand elle est falsifiable (réfutable)","Quand elle est simple"],"correct":2,"explanation":"Pour Popper, une théorie est scientifique si elle est falsifiable : elle doit pouvoir être contredite par l''expérience. Une théorie qui explique tout sans risque de réfutation n''est pas scientifique."},
      {"id":"q5","question":"Les sciences formelles comprennent :","options":["La physique et la chimie","Les mathématiques et la logique","La sociologie et la psychologie","La biologie et la géologie"],"correct":1,"explanation":"Les sciences formelles (mathématiques, logique) étudient des objets abstraits et procèdent par démonstration, sans recourir à l''expérimentation."},
      {"id":"q6","question":"Quelle est la différence fondamentale entre science et technique ?","options":["La science est plus ancienne que la technique","La science cherche la connaissance, la technique cherche l''efficacité","La technique est plus importante que la science","Il n''y a aucune différence"],"correct":1,"explanation":"La science vise la connaissance théorique du réel (savoir pourquoi), tandis que la technique vise l''application pratique et l''efficacité (savoir comment)."},
      {"id":"q7","question":"La méthode expérimentale a été formalisée par :","options":["Platon","Descartes","Claude Bernard","Bachelard"],"correct":2,"explanation":"Claude Bernard, dans son Introduction à l''étude de la médecine expérimentale (1865), a formalisé les étapes de la méthode expérimentale : observation, hypothèse, expérience, conclusion."},
      {"id":"q8","question":"Le passage du mythe au logos caractérise :","options":["La philosophie médiévale","L''émergence de la pensée scientifique en Grèce","La Renaissance européenne","La révolution industrielle"],"correct":1,"explanation":"L''émergence de la pensée scientifique en Grèce antique se caractérise par le passage du mythe (explication par les dieux) au logos (explication rationnelle des phénomènes)."},
      {"id":"q9","question":"Le géocentrisme est un exemple de :","options":["Connaissance scientifique avancée","Obstacle de l''expérience première","Méthode expérimentale","Philosophie des mathématiques"],"correct":1,"explanation":"Le géocentrisme (croire que le Soleil tourne autour de la Terre parce qu''on le voit bouger) est un exemple d''obstacle de l''expérience première : nos sens nous trompent."},
      {"id":"q10","question":"Le platonisme en philosophie des mathématiques affirme que :","options":["Les mathématiques sont inutiles","Les objets mathématiques existent réellement et sont découverts","Les mathématiques sont de pures conventions","Les nombres n''existent pas"],"correct":1,"explanation":"Le platonisme mathématique soutient que les objets mathématiques (nombres, figures) existent indépendamment de l''esprit humain et sont découverts, non inventés."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 7 : Technique de la dissertation
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'dissertation-philo', 7, 'Technique de la dissertation philosophique', 'Introduction, développement, conclusion, argumentation', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'dissertation-philo-fiche', 'Technique de la dissertation philosophique', 'Méthode complète : introduction, développement et conclusion', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une dissertation philosophique ?","answer":"La dissertation philosophique est un exercice de réflexion argumentée sur un sujet donné (question ou citation). Elle consiste à examiner un problème de manière ordonnée en confrontant des thèses opposées pour aboutir à une réponse nuancée. Elle comprend une introduction, un développement (généralement en trois parties) et une conclusion."},
      {"id":"fc2","category":"Méthode","question":"Comment analyser un sujet de dissertation ?","answer":"1) Lire le sujet plusieurs fois. 2) Définir chaque terme important (sens courant et philosophique). 3) Identifier le type de sujet : question ouverte (Peut-on... ?), question fermée (La liberté est-elle... ?), citation à discuter. 4) Reformuler le problème philosophique. 5) Trouver des thèses opposées pour alimenter le débat."},
      {"id":"fc3","category":"Méthode","question":"Comment rédiger l''introduction d''une dissertation ?","answer":"L''introduction comprend 4 étapes : 1) Accroche : une situation concrète, un exemple, une citation qui amène le sujet. 2) Reformulation et définition des termes clés. 3) Problématisation : poser la question qui fait problème, montrer les tensions. 4) Annonce du plan : présenter les grandes parties du développement. L''introduction fait environ 15-20 lignes."},
      {"id":"fc4","category":"Méthode","question":"Comment structurer le développement en trois parties ?","answer":"Plan classique (dialectique) : Partie I (Thèse) : développer une première réponse au problème avec arguments et exemples. Partie II (Antithèse) : présenter une position opposée ou critique de la thèse. Partie III (Synthèse) : dépasser l''opposition par une réponse nuancée qui intègre les apports des deux premières parties. Chaque partie a 2-3 sous-parties."},
      {"id":"fc5","category":"Méthode","question":"Comment argumenter en philosophie ?","answer":"Un argument philosophique comprend : 1) Une affirmation (thèse). 2) Une justification rationnelle (pourquoi cette thèse est défendable). 3) Un exemple concret ou une référence à un philosophe. 4) Une analyse de l''exemple. Éviter les arguments d''autorité seuls (« X a dit que... donc c''est vrai »). Toujours montrer le raisonnement."},
      {"id":"fc6","category":"Méthode","question":"Comment rédiger la conclusion d''une dissertation ?","answer":"La conclusion comprend : 1) Bilan : rappeler le problème et résumer le parcours argumentatif. 2) Réponse : donner sa réponse finale au problème, qui doit être nuancée et tenir compte de toute la réflexion. 3) Ouverture : élargir vers une question connexe ou un enjeu plus large. Ne pas introduire de nouvelle idée. Environ 10 lignes."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre thèse, antithèse et synthèse ?","answer":"La thèse est la première position défendue sur le problème. L''antithèse est la position contraire ou critique. La synthèse n''est pas un simple compromis mais un dépassement qui montre les limites des deux positions et propose une réponse plus complète. Exemple : « La liberté est-elle absolue ? » — Thèse : oui. Antithèse : non, elle a des limites. Synthèse : elle est conquête et responsabilité."},
      {"id":"fc8","category":"Méthode","question":"Comment utiliser les références philosophiques ?","answer":"Les références doivent : 1) Être précises (nom du philosophe, titre de l''œuvre si possible). 2) Servir l''argumentation (pas de name-dropping). 3) Être expliquées (ne pas citer sans analyser). 4) Être variées (ne pas utiliser un seul philosophe). 5) Être mobilisées au bon moment (dans la partie où elles sont pertinentes)."},
      {"id":"fc9","category":"Exemple","question":"Donnez un exemple de problématisation.","answer":"Sujet : « Peut-on être libre et obéir aux lois ? » Problématisation : La liberté semble s''opposer à l''obéissance (être libre = faire ce que l''on veut). Mais sans lois, la liberté du plus fort écrase celle du plus faible. Le problème est donc : la loi est-elle un obstacle ou une condition de la liberté ? Comment concilier obéissance et autonomie ?"},
      {"id":"fc10","category":"Distinction","question":"Quelle différence entre un plan dialectique et un plan thématique ?","answer":"Le plan dialectique suit le schéma thèse/antithèse/synthèse : il convient aux sujets qui posent une question à laquelle on peut répondre oui ou non. Le plan thématique organise la réflexion autour de grands thèmes ou aspects du sujet : il convient aux sujets larges (« Qu''est-ce que la justice ? »). Au bac malien, le plan dialectique est le plus courant."},
      {"id":"fc11","category":"Méthode","question":"Quelles sont les erreurs fréquentes à éviter ?","answer":"Erreurs courantes : 1) Hors-sujet : ne pas répondre à la question posée. 2) Catalogue de citations sans argumentation personnelle. 3) Absence de problématisation. 4) Synthèse qui répète thèse et antithèse sans les dépasser. 5) Exemples sans analyse. 6) Introduction trop longue ou trop courte. 7) Oublier de définir les termes du sujet."},
      {"id":"fc12","category":"Méthode","question":"Comment gérer son temps à l''épreuve du bac ?","answer":"Durée de l''épreuve de philo au bac : 4 heures. Répartition conseillée : 1) Analyse du sujet et brouillon du plan : 45 min - 1h. 2) Rédaction de l''introduction : 20 min. 3) Rédaction du développement (3 parties) : 2h. 4) Rédaction de la conclusion : 15 min. 5) Relecture : 15-20 min. Ne jamais rendre sans relire."}
    ],
    "schema": {
      "title": "Structure de la dissertation philosophique",
      "nodes": [
        {"id":"n1","label":"Dissertation philosophique","type":"main"},
        {"id":"n2","label":"Introduction","type":"branch"},
        {"id":"n3","label":"Développement","type":"branch"},
        {"id":"n4","label":"Conclusion","type":"branch"},
        {"id":"n5","label":"Accroche + problème + plan","type":"leaf"},
        {"id":"n6","label":"Définition des termes","type":"leaf"},
        {"id":"n7","label":"I. Thèse","type":"leaf"},
        {"id":"n8","label":"II. Antithèse","type":"leaf"},
        {"id":"n9","label":"III. Synthèse","type":"leaf"},
        {"id":"n10","label":"Bilan + réponse","type":"leaf"},
        {"id":"n11","label":"Ouverture","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"commencer"},
        {"from":"n1","to":"n3","label":"argumenter"},
        {"from":"n1","to":"n4","label":"conclure"},
        {"from":"n2","to":"n5","label":"structure"},
        {"from":"n2","to":"n6","label":"préciser"},
        {"from":"n3","to":"n7","label":"partie 1"},
        {"from":"n3","to":"n8","label":"partie 2"},
        {"from":"n3","to":"n9","label":"partie 3"},
        {"from":"n4","to":"n10","label":"résumer"},
        {"from":"n4","to":"n11","label":"élargir"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Combien de parties comprend le plan dialectique classique ?","options":["2 parties","3 parties (thèse, antithèse, synthèse)","4 parties","1 seule partie"],"correct":1,"explanation":"Le plan dialectique comprend 3 parties : la thèse (première réponse), l''antithèse (réponse opposée) et la synthèse (dépassement des deux positions)."},
      {"id":"q2","question":"Que doit contenir l''introduction d''une dissertation ?","options":["Seulement le plan","Accroche, définitions, problématisation et plan","La réponse finale","Un résumé du cours"],"correct":1,"explanation":"L''introduction comprend : une accroche, la définition des termes, la problématisation (poser le problème) et l''annonce du plan."},
      {"id":"q3","question":"Qu''est-ce que la problématisation ?","options":["Résumer le sujet","Critiquer le sujet","Montrer en quoi le sujet pose un problème philosophique","Donner sa réponse immédiate"],"correct":2,"explanation":"Problématiser, c''est montrer que le sujet contient une tension, un paradoxe ou une difficulté qui nécessite une réflexion approfondie."},
      {"id":"q4","question":"La synthèse dans une dissertation doit :","options":["Répéter la thèse","Répéter l''antithèse","Dépasser l''opposition entre thèse et antithèse","Ignorer les deux premières parties"],"correct":2,"explanation":"La synthèse ne répète pas les parties précédentes mais les dépasse en proposant une réponse plus nuancée qui intègre les acquis des deux positions."},
      {"id":"q5","question":"Combien de temps est conseillé pour le brouillon au bac ?","options":["5 minutes","45 minutes à 1 heure","2 heures","3 heures"],"correct":1,"explanation":"Il est conseillé de consacrer 45 minutes à 1 heure à l''analyse du sujet et à l''élaboration du plan au brouillon, sur les 4 heures de l''épreuve."},
      {"id":"q6","question":"Comment utiliser un philosophe dans une dissertation ?","options":["Citer son nom sans explication","Expliquer sa pensée en lien avec le sujet","Recopier tout son cours","Le mentionner uniquement en introduction"],"correct":1,"explanation":"Un philosophe doit être mobilisé pour servir l''argumentation : citer sa position, l''expliquer et montrer comment elle éclaire le problème posé."},
      {"id":"q7","question":"Quel type de plan convient à la question « Peut-on être libre et obéir ? » ?","options":["Plan thématique","Plan chronologique","Plan dialectique","Plan analytique"],"correct":2,"explanation":"Les questions du type « Peut-on... ? » appellent un plan dialectique : thèse (oui, on peut), antithèse (non, c''est contradictoire), synthèse (cela dépend de quel type de liberté et de lois)."},
      {"id":"q8","question":"Quelle erreur est la plus grave dans une dissertation ?","options":["Un plan en deux parties","Le hors-sujet","Une conclusion courte","L''absence de citation"],"correct":1,"explanation":"Le hors-sujet est l''erreur la plus grave : ne pas répondre à la question posée signifie que toute la copie est sans objet, quel que soit la qualité de l''argumentation."},
      {"id":"q9","question":"La conclusion doit-elle introduire de nouvelles idées ?","options":["Oui, toujours","Non, elle doit résumer et ouvrir sans nouvelle idée","Oui, c''est obligatoire au bac","La conclusion est facultative"],"correct":1,"explanation":"La conclusion ne doit pas introduire de nouvelles idées. Elle résume le parcours argumentatif, donne une réponse et propose une ouverture vers une question connexe."},
      {"id":"q10","question":"Quel est le rôle des exemples dans une dissertation ?","options":["Illustrer et renforcer l''argumentation","Remplacer l''argumentation","Décorer la copie","Remplir la copie"],"correct":0,"explanation":"Les exemples illustrent et renforcent l''argumentation. Ils doivent être analysés (et non simplement cités) pour montrer en quoi ils soutiennent la thèse défendue."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 8 : Étude d''œuvres de penseurs
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'etude-oeuvres', 8, 'Étude d''œuvres de penseurs', 'Montesquieu, Marx et Cheikh Anta Diop', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'etude-oeuvres-fiche', 'Étude d''œuvres de penseurs', 'Montesquieu (L''Esprit des lois), Marx (L''Idéologie allemande), Cheikh Anta Diop', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Citation/Idée","question":"Quel est le thème central de L''Esprit des lois de Montesquieu ?","answer":"L''Esprit des lois (1748) étudie les lois politiques et leur rapport avec le climat, les mœurs, la religion et le commerce. Montesquieu y développe la théorie de la séparation des pouvoirs (législatif, exécutif, judiciaire) pour prévenir la tyrannie. « Pour qu''on ne puisse abuser du pouvoir, il faut que, par la disposition des choses, le pouvoir arrête le pouvoir. »"},
      {"id":"fc2","category":"Citation/Idée","question":"Quels sont les trois types de gouvernement selon Montesquieu ?","answer":"Montesquieu distingue : 1) La république (démocratique ou aristocratique), dont le principe est la vertu. 2) La monarchie, dont le principe est l''honneur. 3) Le despotisme, dont le principe est la crainte. La classification repose sur la nature du gouvernement (qui détient le pouvoir) et son principe (ce qui le fait fonctionner)."},
      {"id":"fc3","category":"Citation/Idée","question":"Quel est le contenu de L''Idéologie allemande de Marx ?","answer":"L''Idéologie allemande (1846, publiée en 1932) est une œuvre co-écrite par Marx et Engels. Elle critique les « jeunes hégéliens » (Feuerbach, Stirner) et pose les bases du matérialisme historique : les idées dominantes d''une époque sont les idées de la classe dominante. La conscience est déterminée par les conditions matérielles d''existence, non l''inverse."},
      {"id":"fc4","category":"Citation/Idée","question":"Que soutient Cheikh Anta Diop sur les civilisations nègres ?","answer":"Cheikh Anta Diop (1923-1986), savant sénégalais, soutient dans Nations nègres et culture (1954) que l''Égypte ancienne était une civilisation nègre et que l''Afrique noire est le berceau de l''humanité et de la civilisation. Il affirme l''antériorité des civilisations nègres, remettant en cause l''eurocentrisme de l''historiographie traditionnelle."},
      {"id":"fc5","category":"Distinction","question":"L''antériorité des civilisations nègres : mythe ou réalité ?","answer":"Cheikh Anta Diop s''appuie sur des preuves archéologiques, linguistiques et anthropologiques. Ses thèses ont été partiellement confirmées (origine africaine de l''humanité) mais certaines restent débattues (caractère « nègre » de l''Égypte ancienne). Le débat oppose : ceux qui y voient une révolution historiographique et ceux qui critiquent certaines généralisations."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la séparation des pouvoirs ?","answer":"La séparation des pouvoirs est le principe selon lequel les trois fonctions de l''État (faire les lois, les appliquer, juger) doivent être exercées par des organes distincts et indépendants. Pouvoir législatif (Assemblée), exécutif (gouvernement) et judiciaire (tribunaux). Ce principe, théorisé par Montesquieu, est le fondement des démocraties modernes."},
      {"id":"fc7","category":"Citation/Idée","question":"Que dit Marx sur l''idéologie dans L''Idéologie allemande ?","answer":"Pour Marx, l''idéologie est un système d''idées qui reflète et justifie les intérêts de la classe dominante. « Les idées dominantes d''une époque n''ont jamais été que les idées de la classe dominante. » L''idéologie masque les rapports d''exploitation en les présentant comme naturels ou universels. La critique de l''idéologie est nécessaire pour la prise de conscience révolutionnaire."},
      {"id":"fc8","category":"Exemple","question":"Comment Cheikh Anta Diop argumente-t-il sur l''Égypte nègre ?","answer":"Diop utilise : 1) Le test de la mélanine sur des momies égyptiennes (pigmentation foncée). 2) Les témoignages des Grecs (Hérodote décrit les Égyptiens comme ayant la peau noire). 3) La parenté linguistique entre l''égyptien ancien et les langues africaines (wolof). 4) Les représentations iconographiques. 5) L''analyse anthropologique des crânes. Ces preuves ont fait débat dans la communauté scientifique."},
      {"id":"fc9","category":"Méthode","question":"Comment étudier une œuvre philosophique au bac ?","answer":"Pour étudier une œuvre : 1) Connaître le contexte historique et la biographie de l''auteur. 2) Identifier la thèse principale et les arguments clés. 3) Maîtriser les concepts fondamentaux. 4) Retenir quelques citations précises. 5) Comprendre l''apport et les limites de l''œuvre. 6) Savoir mobiliser l''œuvre dans une dissertation ou un commentaire."},
      {"id":"fc10","category":"Distinction","question":"Quelle différence entre Montesquieu et Rousseau sur le contrat social ?","answer":"Montesquieu est un libéral : il veut limiter le pouvoir par la séparation des pouvoirs et le pluralisme. Rousseau est un démocrate radical : il veut que le peuple exerce directement la souveraineté par la volonté générale. Montesquieu accepte la monarchie constitutionnelle, Rousseau la refuse car elle aliène la liberté du peuple."},
      {"id":"fc11","category":"Citation/Idée","question":"Quel est l''apport de Cheikh Anta Diop à la philosophie africaine ?","answer":"Diop a restauré la fierté historique de l''Afrique noire en montrant sa contribution à la civilisation universelle. Il a ouvert la voie à une historiographie décolonisée de l''Afrique. Son œuvre a inspiré le mouvement afrocentrique et le panafricanisme intellectuel. Il est considéré comme l''un des plus grands intellectuels africains du XXe siècle."},
      {"id":"fc12","category":"Exemple","question":"Pourquoi Montesquieu est-il pertinent pour comprendre la politique malienne ?","answer":"La Constitution du Mali (1992) s''inspire directement de Montesquieu : séparation des pouvoirs entre l''Assemblée nationale (législatif), le Président et le gouvernement (exécutif), et les tribunaux (judiciaire). Les crises politiques maliennes peuvent s''analyser comme des violations de cette séparation (coups d''État, concentration des pouvoirs)."}
    ],
    "schema": {
      "title": "Trois grandes œuvres philosophiques",
      "nodes": [
        {"id":"n1","label":"Étude d''œuvres","type":"main"},
        {"id":"n2","label":"Montesquieu","type":"branch"},
        {"id":"n3","label":"Marx","type":"branch"},
        {"id":"n4","label":"Cheikh Anta Diop","type":"branch"},
        {"id":"n5","label":"L''Esprit des lois (1748)","type":"leaf"},
        {"id":"n6","label":"Séparation des pouvoirs","type":"leaf"},
        {"id":"n7","label":"L''Idéologie allemande (1846)","type":"leaf"},
        {"id":"n8","label":"Critique de l''idéologie","type":"leaf"},
        {"id":"n9","label":"Nations nègres et culture (1954)","type":"leaf"},
        {"id":"n10","label":"Antériorité des civilisations nègres","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"Lumières"},
        {"from":"n1","to":"n3","label":"matérialisme"},
        {"from":"n1","to":"n4","label":"afrocentrisme"},
        {"from":"n2","to":"n5","label":"œuvre"},
        {"from":"n2","to":"n6","label":"thèse centrale"},
        {"from":"n3","to":"n7","label":"œuvre"},
        {"from":"n3","to":"n8","label":"thèse centrale"},
        {"from":"n4","to":"n9","label":"œuvre"},
        {"from":"n4","to":"n10","label":"thèse centrale"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel est le principe du despotisme selon Montesquieu ?","options":["La vertu","L''honneur","La crainte","La liberté"],"correct":2,"explanation":"Montesquieu associe à chaque type de gouvernement un principe : la vertu pour la république, l''honneur pour la monarchie, et la crainte pour le despotisme."},
      {"id":"q2","question":"Qui est l''auteur de Nations nègres et culture ?","options":["Léopold Sédar Senghor","Frantz Fanon","Cheikh Anta Diop","Marcien Towa"],"correct":2,"explanation":"Nations nègres et culture (1954) est l''œuvre majeure de Cheikh Anta Diop, dans laquelle il défend l''antériorité des civilisations nègres."},
      {"id":"q3","question":"Selon Marx dans L''Idéologie allemande, les idées dominantes sont :","options":["Les idées des philosophes","Les idées de la classe dominante","Les idées du peuple","Les idées religieuses"],"correct":1,"explanation":"Marx affirme que « les idées dominantes d''une époque n''ont jamais été que les idées de la classe dominante », car celle-ci contrôle les moyens de production intellectuelle."},
      {"id":"q4","question":"Quels sont les trois pouvoirs que Montesquieu veut séparer ?","options":["Militaire, religieux, civil","Législatif, exécutif, judiciaire","Royal, populaire, aristocratique","Économique, politique, culturel"],"correct":1,"explanation":"Montesquieu propose la séparation du pouvoir législatif (faire les lois), exécutif (les appliquer) et judiciaire (juger) pour empêcher la tyrannie."},
      {"id":"q5","question":"Cheikh Anta Diop soutient que l''Égypte ancienne était :","options":["Une civilisation européenne","Une civilisation asiatique","Une civilisation nègre","Une civilisation arabe"],"correct":2,"explanation":"Cheikh Anta Diop, s''appuyant sur des preuves archéologiques et anthropologiques, soutient que l''Égypte ancienne était une civilisation nègre africaine."},
      {"id":"q6","question":"L''Idéologie allemande a été publiée pour la première fois en :","options":["1846, l''année de sa rédaction","1867, avec Le Capital","1932, après la mort de Marx","1848, avec le Manifeste"],"correct":2,"explanation":"Bien que rédigée en 1845-1846, L''Idéologie allemande n''a été publiée pour la première fois qu''en 1932, bien après la mort de Marx (1883)."},
      {"id":"q7","question":"Pour Montesquieu, quel est le but de la séparation des pouvoirs ?","options":["Renforcer le roi","Empêcher l''abus de pouvoir","Simplifier le gouvernement","Supprimer les lois"],"correct":1,"explanation":"La séparation des pouvoirs vise à empêcher l''abus de pouvoir : « pour qu''on ne puisse abuser du pouvoir, il faut que le pouvoir arrête le pouvoir »."},
      {"id":"q8","question":"Quel historien grec Cheikh Anta Diop cite-t-il pour soutenir sa thèse ?","options":["Thucydide","Aristote","Hérodote","Platon"],"correct":2,"explanation":"Diop cite Hérodote qui, dans ses Histoires, décrit les Égyptiens comme ayant la peau noire et les cheveux crépus."},
      {"id":"q9","question":"Qu''est-ce que l''idéologie selon Marx ?","options":["La science politique","Un système d''idées masquant les rapports d''exploitation","La philosophie pure","La religion"],"correct":1,"explanation":"Pour Marx, l''idéologie est un système d''idées qui reflète et justifie les intérêts de la classe dominante, masquant les rapports réels d''exploitation."},
      {"id":"q10","question":"La Constitution malienne de 1992 s''inspire de quel principe de Montesquieu ?","options":["Le despotisme éclairé","La séparation des pouvoirs","La monarchie absolue","Le communisme"],"correct":1,"explanation":"La Constitution du Mali (1992) organise la séparation des pouvoirs entre l''Assemblée nationale, le Président/gouvernement et les tribunaux, suivant le principe de Montesquieu."}
    ]
  }');

  -- ============================================================
  -- PHILOSOPHIE - Chapitre 9 : Approfondissement commentaire et dissertation
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (philo_id, 'approfondissement-techniques', 9, 'Approfondissement : commentaire et dissertation', 'Exercices pratiques et préparation à l''épreuve du bac', 9)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'approfondissement-techniques-fiche', 'Approfondissement : commentaire et dissertation', 'Exercices pratiques et stratégies pour l''épreuve du baccalauréat', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Comment choisir entre commentaire et dissertation au bac ?","answer":"Au bac, vous avez le choix entre un commentaire de texte et une dissertation. Choisissez le commentaire si : vous comprenez bien le texte, vous savez identifier la thèse et les arguments. Choisissez la dissertation si : le sujet vous inspire, vous avez des références philosophiques à mobiliser. Prenez 5 minutes pour évaluer les deux sujets avant de choisir."},
      {"id":"fc2","category":"Méthode","question":"Comment rédiger un paragraphe argumentatif efficace ?","answer":"Un paragraphe argumentatif suit le schéma AEEI : 1) Affirmation : énoncer l''idée du paragraphe. 2) Explication : développer l''idée avec un raisonnement. 3) Exemple : illustrer avec un cas concret ou une référence philosophique. 4) Interprétation : analyser l''exemple et montrer ce qu''il prouve. Chaque paragraphe = une idée = un argument."},
      {"id":"fc3","category":"Méthode","question":"Comment faire une transition entre les parties ?","answer":"La transition est un court paragraphe (3-5 lignes) entre deux parties. Elle comprend : 1) Un bilan de la partie précédente (ce qu''on a montré). 2) Une limite ou une objection (ce qui reste à examiner). 3) Une annonce de la partie suivante. La transition montre que votre réflexion progresse logiquement d''une partie à l''autre."},
      {"id":"fc4","category":"Exemple","question":"Exemple de sujet de dissertation type bac malien.","answer":"Sujets fréquents au bac malien : « La liberté est-elle une illusion ? », « Peut-on vivre sans philosopher ? », « Le travail est-il aliénation ou libération ? », « La technique rend-elle l''homme plus libre ? », « La diversité des cultures est-elle un obstacle à l''unité du genre humain ? » Ces sujets appellent un plan dialectique avec des références variées."},
      {"id":"fc5","category":"Méthode","question":"Comment éviter le hors-sujet ?","answer":"Pour éviter le hors-sujet : 1) Relire le sujet après chaque paragraphe : est-ce que je réponds à la question ? 2) Reformuler le sujet avec vos propres mots. 3) Vérifier que chaque argument est en lien direct avec le sujet. 4) Attention aux sujets proches mais différents (ex : « liberté » et « libre arbitre »). 5) Toujours revenir aux termes exacts du sujet."},
      {"id":"fc6","category":"Méthode","question":"Comment améliorer son expression écrite en philosophie ?","answer":"Conseils : 1) Phrases courtes et claires (sujet + verbe + complément). 2) Un seul concept par phrase. 3) Éviter le « je » : préférer « on peut considérer que... ». 4) Utiliser des connecteurs logiques (donc, cependant, en effet, or). 5) Relire à voix basse pour repérer les phrases maladroites. 6) Soigner l''orthographe et les accents."},
      {"id":"fc7","category":"Distinction","question":"Quels sont les critères de notation au bac ?","answer":"Les critères principaux : 1) Compréhension du sujet (pas de hors-sujet). 2) Problématisation (le sujet est-il traité comme un problème ?). 3) Argumentation (les idées sont-elles justifiées ?). 4) Références philosophiques (mobilisation des auteurs). 5) Structure (intro, développement ordonné, conclusion). 6) Expression (clarté, rigueur, orthographe)."},
      {"id":"fc8","category":"Exemple","question":"Donnez un exemple de bonne accroche de dissertation.","answer":"Sujet : « Le travail libère-t-il l''homme ? » Accroche : « Au Mali comme ailleurs, le travail est souvent vécu comme une contrainte pénible. Pourtant, perdre son emploi est une source de souffrance qui montre que le travail est aussi un besoin fondamental. Cette ambiguïté nous amène à nous demander si le travail est une servitude ou une libération. »"},
      {"id":"fc9","category":"Méthode","question":"Comment relire efficacement sa copie ?","answer":"Relecture en 3 passes : 1) Première lecture : vérifier la cohérence du raisonnement (chaque partie répond-elle au sujet ?). 2) Deuxième lecture : corriger l''orthographe et la grammaire (accords, conjugaisons, accents). 3) Troisième lecture : vérifier les noms propres, les dates et les citations. Prévoir 15-20 minutes de relecture."},
      {"id":"fc10","category":"Méthode","question":"Comment traiter un sujet-citation au bac ?","answer":"Pour un sujet-citation : 1) Identifier l''auteur et le contexte. 2) Reformuler la thèse de la citation avec vos mots. 3) Trouver le problème philosophique sous-jacent. 4) Discuter la citation : la soutenir avec des arguments (thèse), la critiquer (antithèse), la nuancer (synthèse). 5) Ne pas simplement dire « je suis d''accord » ou « je ne suis pas d''accord »."},
      {"id":"fc11","category":"Exemple","question":"Comment mobiliser le contexte malien dans une dissertation ?","answer":"Le contexte malien enrichit la réflexion : pour un sujet sur la démocratie, évoquer l''expérience démocratique malienne depuis 1991. Pour un sujet sur le travail, parler du chômage des jeunes au Mali. Pour un sujet sur la culture, mentionner la diversité culturelle malienne (Bambara, Peul, Touareg). Le correcteur appréciera des exemples locaux pertinents."},
      {"id":"fc12","category":"Méthode","question":"Quels philosophes sont les plus utiles pour le bac TSS ?","answer":"Philosophes incontournables pour TSS : Platon et Aristote (bases), Descartes (raison), Rousseau (contrat social, éducation), Marx (travail, histoire, classes), Sartre (liberté), Freud (inconscient), Montesquieu (pouvoirs), Bachelard (science). Pour le contexte africain : Cheikh Anta Diop, Marcien Towa, Senghor. Maîtrisez bien 4-5 philosophes plutôt que survoler 15."}
    ],
    "schema": {
      "title": "Préparation à l''épreuve du bac",
      "nodes": [
        {"id":"n1","label":"Préparation bac philo","type":"main"},
        {"id":"n2","label":"Choix du sujet","type":"branch"},
        {"id":"n3","label":"Rédaction","type":"branch"},
        {"id":"n4","label":"Relecture","type":"branch"},
        {"id":"n5","label":"Commentaire vs dissertation","type":"leaf"},
        {"id":"n6","label":"Gestion du temps","type":"leaf"},
        {"id":"n7","label":"Paragraphe argumentatif (AEEI)","type":"leaf"},
        {"id":"n8","label":"Transitions","type":"leaf"},
        {"id":"n9","label":"3 passes de relecture","type":"leaf"},
        {"id":"n10","label":"Orthographe et style","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"étape 1"},
        {"from":"n1","to":"n3","label":"étape 2"},
        {"from":"n1","to":"n4","label":"étape 3"},
        {"from":"n2","to":"n5","label":"évaluer"},
        {"from":"n2","to":"n6","label":"planifier"},
        {"from":"n3","to":"n7","label":"structure"},
        {"from":"n3","to":"n8","label":"lier les parties"},
        {"from":"n4","to":"n9","label":"vérifier"},
        {"from":"n4","to":"n10","label":"corriger"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Combien de temps faut-il prévoir pour la relecture au bac ?","options":["0 minutes","5 minutes","15-20 minutes","1 heure"],"correct":2,"explanation":"Il faut prévoir 15 à 20 minutes pour une relecture efficace en trois passes : cohérence, orthographe et vérification des références."},
      {"id":"q2","question":"Que signifie le schéma AEEI pour un paragraphe ?","options":["Auteur, Époque, Exemple, Idée","Affirmation, Explication, Exemple, Interprétation","Analyse, Évaluation, Examen, Introduction","Argument, Erreur, Excès, Insuffisance"],"correct":1,"explanation":"AEEI signifie : Affirmation (énoncer l''idée), Explication (développer), Exemple (illustrer), Interprétation (analyser ce que l''exemple prouve)."},
      {"id":"q3","question":"Comment éviter le hors-sujet ?","options":["Écrire le plus possible","Relire régulièrement le sujet pour vérifier la pertinence","Ne citer aucun philosophe","Copier le cours"],"correct":1,"explanation":"Pour éviter le hors-sujet, il faut relire le sujet après chaque paragraphe et vérifier que chaque argument répond directement à la question posée."},
      {"id":"q4","question":"Quelle est la fonction d''une transition ?","options":["Remplir la copie","Montrer la progression logique entre les parties","Résumer toute la dissertation","Critiquer l''auteur"],"correct":1,"explanation":"La transition fait le lien entre deux parties : elle résume la partie terminée, montre ses limites et annonce la partie suivante, assurant la cohérence du raisonnement."},
      {"id":"q5","question":"Au bac, combien de temps consacrer au brouillon ?","options":["0 minutes, rédiger directement","45 minutes à 1 heure","3 heures","Tout le temps disponible"],"correct":1,"explanation":"Il est conseillé de consacrer 45 minutes à 1 heure au brouillon (analyse du sujet, plan détaillé) sur les 4 heures de l''épreuve."},
      {"id":"q6","question":"Quel conseil pour l''expression écrite en philosophie ?","options":["Utiliser des phrases longues et complexes","Écrire des phrases courtes et claires","Utiliser beaucoup de « je pense que »","Éviter les connecteurs logiques"],"correct":1,"explanation":"En philosophie, les phrases courtes et claires sont préférables. Il faut aussi utiliser des connecteurs logiques et éviter le « je » au profit de formulations impersonnelles."},
      {"id":"q7","question":"Comment traiter un sujet-citation ?","options":["Simplement dire si on est d''accord","Reformuler la thèse, trouver le problème et discuter la citation","Recopier la citation plusieurs fois","Ignorer la citation et traiter un autre sujet"],"correct":1,"explanation":"Pour un sujet-citation, il faut reformuler la thèse de l''auteur, identifier le problème sous-jacent et discuter la citation en la soutenant, la critiquant, puis en la nuançant."},
      {"id":"q8","question":"Pourquoi utiliser des exemples du contexte malien ?","options":["C''est obligatoire","Cela enrichit la réflexion et montre l''ancrage dans la réalité","Pour éviter les philosophes occidentaux","Le correcteur ne comprend que les exemples locaux"],"correct":1,"explanation":"Les exemples du contexte malien enrichissent la réflexion en montrant que les problèmes philosophiques ont une résonance locale et concrète. Le correcteur appréciera cette pertinence."},
      {"id":"q9","question":"Combien de philosophes faut-il bien maîtriser pour le bac TSS ?","options":["1 seul","4-5 philosophes bien maîtrisés","Tous les philosophes existants","Aucun, seule l''opinion compte"],"correct":1,"explanation":"Il vaut mieux maîtriser en profondeur 4-5 philosophes (Platon, Descartes, Marx, Sartre, plus un penseur africain) que survoler une dizaine de références sans les comprendre."},
      {"id":"q10","question":"Quel est le critère de notation le plus important au bac philo ?","options":["La longueur de la copie","La problématisation et l''argumentation","L''écriture calligraphiée","Le nombre de citations"],"correct":1,"explanation":"Les critères les plus importants sont la compréhension du sujet, la problématisation et la qualité de l''argumentation. Une copie courte mais bien argumentée vaut mieux qu''une copie longue et creuse."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 1 : Notions fondamentales
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'notions-fondamentales', 1, 'Notions fondamentales de sociologie', 'Société, rapports sociaux, socialisation, groupes et catégories sociales', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'notions-fondamentales-fiche', 'Notions fondamentales de sociologie', 'Société, socialisation, groupes sociaux et catégories socioprofessionnelles', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la sociologie ?","answer":"La sociologie est la science qui étudie les faits sociaux, c''est-à-dire les manières d''agir, de penser et de sentir qui s''imposent aux individus. Fondée par Auguste Comte et Émile Durkheim, elle analyse les structures sociales, les institutions, les relations entre individus et groupes. Durkheim définit les faits sociaux comme « des manières d''agir extérieures à l''individu et dotées d''un pouvoir de coercition »."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce qu''une société ?","answer":"Une société est un ensemble organisé d''individus partageant un territoire, une culture, des institutions et des règles communes. Elle est caractérisée par des rapports sociaux (relations entre individus et groupes), une hiérarchie sociale et des mécanismes de régulation (lois, normes, valeurs). Au Mali, la société est structurée par la famille, l''ethnie, la religion et l''État."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que la socialisation ?","answer":"La socialisation est le processus par lequel un individu apprend et intériorise les normes, les valeurs et les comportements de sa société. On distingue la socialisation primaire (enfance : famille, école) et la socialisation secondaire (âge adulte : travail, associations). La socialisation forme l''« individu social » : un être capable de vivre en société."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre groupe social et catégorie sociale ?","answer":"Un groupe social est un ensemble d''individus qui interagissent, partagent un sentiment d''appartenance et ont des objectifs communs (ex : une famille, un syndicat). Une catégorie sociale est un ensemble statistique d''individus partageant une caractéristique commune mais sans interaction nécessaire (ex : les femmes, les jeunes de 15-24 ans). Les catégories socioprofessionnelles (CSP) classent les individus selon leur métier."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que les rapports sociaux ?","answer":"Les rapports sociaux sont les relations qui s''établissent entre les individus et les groupes au sein d''une société. Ils peuvent être de coopération (solidarité, entraide), de conflit (lutte des classes, rivalités), de domination (pouvoir, autorité) ou d''échange (commerce, réciprocité). Les rapports sociaux structurent l''organisation de toute société."},
      {"id":"fc6","category":"Citation/Idée","question":"Comment Durkheim conçoit-il le fait social ?","answer":"Pour Durkheim, un fait social est « toute manière de faire, fixée ou non, susceptible d''exercer sur l''individu une contrainte extérieure ». Les faits sociaux sont extérieurs à l''individu (ils existent avant lui), contraignants (on ne peut les ignorer) et généraux (ils concernent l''ensemble de la société). Exemples : les règles juridiques, les coutumes, les modes."},
      {"id":"fc7","category":"Distinction","question":"Quelle différence entre socialisation primaire et secondaire ?","answer":"La socialisation primaire se déroule pendant l''enfance, principalement dans la famille et à l''école. Elle transmet les normes fondamentales (langage, politesse, valeurs morales). La socialisation secondaire se poursuit à l''âge adulte dans le milieu professionnel, les associations et les groupes de pairs. Elle adapte l''individu à de nouveaux rôles sociaux."},
      {"id":"fc8","category":"Exemple","question":"Comment la socialisation fonctionne-t-elle au Mali ?","answer":"Au Mali, la socialisation primaire est fortement marquée par la famille élargie et la communauté. L''enfant apprend le respect des aînés, les traditions, la langue maternelle et souvent les pratiques religieuses (Islam). Le « griotisme », le système de castes et les classes d''âge sont des agents de socialisation spécifiques à la société malienne."},
      {"id":"fc9","category":"Définition","question":"Qu''est-ce qu''une norme sociale ?","answer":"Une norme sociale est une règle de conduite partagée par les membres d''une société ou d''un groupe. Les normes peuvent être formelles (lois, règlements) ou informelles (coutumes, usages, bonnes manières). Elles sont intériorisées par la socialisation et sanctionnées en cas de transgression (sanction pénale, exclusion sociale, désapprobation)."},
      {"id":"fc10","category":"Définition","question":"Qu''est-ce qu''une valeur en sociologie ?","answer":"Une valeur est un idéal partagé par les membres d''une société : ce qui est considéré comme bien, juste ou souhaitable. Les valeurs orientent les comportements et fondent les normes. Exemples de valeurs : la liberté, l''égalité, la solidarité, le respect des anciens (valeur importante au Mali). Les valeurs varient selon les cultures et les époques."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre statut et rôle social ?","answer":"Le statut est la position occupée par un individu dans la structure sociale (étudiant, père, employé). Le rôle est l''ensemble des comportements attendus de quelqu''un qui occupe un statut (un étudiant doit étudier, respecter les professeurs). Un individu a plusieurs statuts simultanés (père, employé, membre d''une association) et joue plusieurs rôles."},
      {"id":"fc12","category":"Méthode","question":"Comment étudier un phénomène social ?","answer":"Pour étudier un phénomène social : 1) Observer le phénomène. 2) Le définir précisément. 3) Identifier les acteurs concernés. 4) Analyser les causes (économiques, culturelles, historiques). 5) Examiner les conséquences. 6) Comparer avec d''autres sociétés ou époques. 7) Mobiliser des données statistiques si disponibles. 8) Proposer une interprétation sociologique."}
    ],
    "schema": {
      "title": "Notions fondamentales de sociologie",
      "nodes": [
        {"id":"n1","label":"Sociologie","type":"main"},
        {"id":"n2","label":"Société","type":"branch"},
        {"id":"n3","label":"Socialisation","type":"branch"},
        {"id":"n4","label":"Groupes sociaux","type":"branch"},
        {"id":"n5","label":"Rapports sociaux","type":"leaf"},
        {"id":"n6","label":"Normes et valeurs","type":"leaf"},
        {"id":"n7","label":"Primaire (enfance)","type":"leaf"},
        {"id":"n8","label":"Secondaire (adulte)","type":"leaf"},
        {"id":"n9","label":"Groupe vs catégorie","type":"leaf"},
        {"id":"n10","label":"CSP","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"objet d''étude"},
        {"from":"n1","to":"n3","label":"processus"},
        {"from":"n1","to":"n4","label":"structures"},
        {"from":"n2","to":"n5","label":"relations"},
        {"from":"n2","to":"n6","label":"régulation"},
        {"from":"n3","to":"n7","label":"famille/école"},
        {"from":"n3","to":"n8","label":"travail/associations"},
        {"from":"n4","to":"n9","label":"distinction"},
        {"from":"n4","to":"n10","label":"classification"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Qui est considéré comme le fondateur de la sociologie en tant que science ?","options":["Karl Marx","Max Weber","Émile Durkheim","Jean-Jacques Rousseau"],"correct":2,"explanation":"Émile Durkheim est considéré comme le fondateur de la sociologie comme discipline scientifique, avec ses Règles de la méthode sociologique (1895)."},
      {"id":"q2","question":"Qu''est-ce qu''un fait social selon Durkheim ?","options":["Un événement historique","Une manière d''agir extérieure à l''individu et contraignante","Une opinion personnelle","Un phénomène naturel"],"correct":1,"explanation":"Pour Durkheim, un fait social est une manière d''agir, de penser ou de sentir qui est extérieure à l''individu et qui exerce sur lui une contrainte (pouvoir de coercition)."},
      {"id":"q3","question":"La socialisation primaire se déroule principalement :","options":["Au travail","Dans la famille et à l''école","À la retraite","Dans les médias"],"correct":1,"explanation":"La socialisation primaire se déroule pendant l''enfance, principalement dans la famille (premier agent de socialisation) et à l''école."},
      {"id":"q4","question":"Quelle est la différence entre un groupe social et une catégorie sociale ?","options":["Il n''y a aucune différence","Le groupe implique une interaction, la catégorie est un regroupement statistique","Le groupe est plus grand que la catégorie","La catégorie est plus organisée que le groupe"],"correct":1,"explanation":"Un groupe social implique des interactions et un sentiment d''appartenance. Une catégorie sociale est un regroupement statistique d''individus partageant une caractéristique commune sans interaction nécessaire."},
      {"id":"q5","question":"Qu''est-ce qu''une norme sociale ?","options":["Une moyenne statistique","Une règle de conduite partagée par une société","Une loi physique","Une opinion majoritaire"],"correct":1,"explanation":"Une norme sociale est une règle de conduite (formelle ou informelle) partagée par les membres d''une société, intériorisée par la socialisation et sanctionnée en cas de transgression."},
      {"id":"q6","question":"Au Mali, quel agent de socialisation est particulièrement important ?","options":["Les médias sociaux uniquement","La famille élargie et la communauté","L''armée","Les partis politiques"],"correct":1,"explanation":"Au Mali, la famille élargie et la communauté jouent un rôle central dans la socialisation, transmettant les traditions, le respect des aînés et les pratiques religieuses."},
      {"id":"q7","question":"Qu''est-ce qu''une valeur en sociologie ?","options":["Le prix d''un bien","Un idéal partagé considéré comme bien ou juste","Un calcul mathématique","Une loi juridique"],"correct":1,"explanation":"En sociologie, une valeur est un idéal partagé par les membres d''une société qui oriente les comportements et fonde les normes (liberté, égalité, solidarité, respect des anciens)."},
      {"id":"q8","question":"La socialisation secondaire concerne :","options":["La petite enfance","L''âge adulte (travail, associations)","La période prénatale","La vieillesse uniquement"],"correct":1,"explanation":"La socialisation secondaire se poursuit à l''âge adulte, dans le milieu professionnel, les associations, les groupes de pairs, adaptant l''individu à de nouveaux rôles sociaux."},
      {"id":"q9","question":"Quel est le rapport entre statut et rôle social ?","options":["Ce sont des synonymes","Le statut est la position, le rôle est le comportement attendu","Le rôle précède le statut","Le statut n''existe pas"],"correct":1,"explanation":"Le statut est la position dans la structure sociale (étudiant, parent) ; le rôle est l''ensemble des comportements attendus de celui qui occupe ce statut."},
      {"id":"q10","question":"Les catégories socioprofessionnelles (CSP) classent les individus selon :","options":["Leur religion","Leur ethnie","Leur métier et position professionnelle","Leur âge"],"correct":2,"explanation":"Les CSP classent les individus selon leur métier et leur position dans la hiérarchie professionnelle (cadres, employés, ouvriers, agriculteurs, etc.)."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 2 : Méthodes quantitatives
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'methodes-quantitatives', 2, 'Initiation aux méthodes quantitatives', 'Techniques d''enquête et outils statistiques de base', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'methodes-quantitatives-fiche', 'Initiation aux méthodes quantitatives', 'Techniques d''enquête quantitative et outils statistiques', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une méthode quantitative en sociologie ?","answer":"Les méthodes quantitatives recueillent des données chiffrées sur un grand nombre d''individus pour dégager des régularités statistiques. Elles utilisent des questionnaires standardisés, des sondages et des analyses statistiques. Elles permettent de mesurer des phénomènes sociaux (taux de chômage, taux de scolarisation) et de vérifier des hypothèses sur de larges échantillons."},
      {"id":"fc2","category":"Méthode","question":"Quelles sont les étapes d''une enquête quantitative ?","answer":"1) Définir l''objet et les hypothèses. 2) Construire le questionnaire (questions fermées, à choix multiple). 3) Définir l''échantillon (taille, méthode d''échantillonnage). 4) Administrer le questionnaire (face-à-face, téléphone, en ligne). 5) Coder et saisir les données. 6) Analyser statistiquement. 7) Interpréter les résultats et rédiger un rapport."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''un échantillon représentatif ?","answer":"Un échantillon représentatif est un sous-ensemble de la population étudiée qui reproduit fidèlement ses caractéristiques (âge, sexe, profession, lieu de résidence). Il permet de généraliser les résultats à l''ensemble de la population. Méthodes d''échantillonnage : aléatoire simple, stratifié (par catégories), par quotas."},
      {"id":"fc4","category":"Distinction","question":"Quelle différence entre question ouverte et question fermée ?","answer":"Une question fermée propose des réponses prédéfinies (oui/non, choix multiple, échelle). Elle facilite le traitement statistique. Une question ouverte laisse le répondant s''exprimer librement (« Que pensez-vous de... ? »). Elle est plus riche mais plus difficile à analyser. Les méthodes quantitatives privilégient les questions fermées."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que la moyenne en statistique ?","answer":"La moyenne est la somme de toutes les valeurs divisée par le nombre d''observations. Exemple : si les notes de 5 élèves sont 8, 12, 14, 10, 16, la moyenne est (8+12+14+10+16)/5 = 12. La moyenne est un indicateur de tendance centrale, mais elle peut être influencée par les valeurs extrêmes."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la médiane ?","answer":"La médiane est la valeur qui partage une série ordonnée en deux parties égales : 50% des valeurs sont inférieures et 50% sont supérieures. Exemple : pour la série 3, 5, 7, 9, 11, la médiane est 7. La médiane est moins sensible aux valeurs extrêmes que la moyenne et donne une meilleure idée de la valeur « typique »."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que le mode en statistique ?","answer":"Le mode est la valeur la plus fréquente dans une série statistique. Exemple : dans la série 2, 3, 3, 5, 7, 3, 8, le mode est 3 (il apparaît 3 fois). Une série peut avoir plusieurs modes (bimodale) ou aucun mode (si toutes les valeurs sont différentes). Le mode est utile pour les variables qualitatives."},
      {"id":"fc8","category":"Méthode","question":"Comment construire un bon questionnaire ?","answer":"Règles : 1) Questions claires et simples (pas d''ambiguïté). 2) Une seule idée par question. 3) Éviter les questions orientées (qui suggèrent la réponse). 4) Aller du général au particulier. 5) Regrouper les questions par thème. 6) Prévoir une question d''identification (âge, sexe, profession). 7) Tester le questionnaire avant administration (pré-test)."},
      {"id":"fc9","category":"Exemple","question":"Donnez un exemple d''enquête quantitative au Mali.","answer":"Exemple : enquête sur le chômage des jeunes à Bamako. Hypothèse : le chômage touche davantage les jeunes sans diplôme. Questionnaire : âge, sexe, niveau d''études, situation professionnelle, durée de chômage, secteur recherché. Échantillon : 500 jeunes de 18-30 ans, répartis par quartier. Analyse : tableau croisé diplôme × situation d''emploi."},
      {"id":"fc10","category":"Distinction","question":"Quelle différence entre variable qualitative et quantitative ?","answer":"Une variable qualitative décrit une qualité ou une catégorie (sexe, profession, état civil). Elle ne se mesure pas en chiffres. Une variable quantitative se mesure en chiffres : discrète (nombre d''enfants : 0, 1, 2...) ou continue (taille, poids, salaire). Le choix des outils statistiques dépend du type de variable."},
      {"id":"fc11","category":"Méthode","question":"Comment lire un tableau statistique ?","answer":"Pour lire un tableau statistique : 1) Lire le titre (quel phénomène est mesuré). 2) Identifier les variables (lignes et colonnes). 3) Repérer l''unité de mesure (%, nombre, taux). 4) Lire les données significatives (les plus grandes, les plus petites). 5) Interpréter : que nous apprend le tableau sur le phénomène étudié ?"},
      {"id":"fc12","category":"Méthode","question":"Comment calculer un pourcentage ?","answer":"Pourcentage = (effectif de la catégorie / effectif total) × 100. Exemple : sur 200 enquêtés, 60 sont au chômage. Le pourcentage de chômeurs est (60/200) × 100 = 30%. Les pourcentages permettent de comparer des groupes de tailles différentes et de mettre en évidence des proportions."}
    ],
    "schema": {
      "title": "Méthodes quantitatives en sociologie",
      "nodes": [
        {"id":"n1","label":"Méthodes quantitatives","type":"main"},
        {"id":"n2","label":"Enquête par questionnaire","type":"branch"},
        {"id":"n3","label":"Outils statistiques","type":"branch"},
        {"id":"n4","label":"Analyse des données","type":"branch"},
        {"id":"n5","label":"Questionnaire standardisé","type":"leaf"},
        {"id":"n6","label":"Échantillonnage","type":"leaf"},
        {"id":"n7","label":"Moyenne, médiane, mode","type":"leaf"},
        {"id":"n8","label":"Variables quali/quanti","type":"leaf"},
        {"id":"n9","label":"Tableaux et graphiques","type":"leaf"},
        {"id":"n10","label":"Pourcentages","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"collecte"},
        {"from":"n1","to":"n3","label":"traitement"},
        {"from":"n1","to":"n4","label":"interprétation"},
        {"from":"n2","to":"n5","label":"outil"},
        {"from":"n2","to":"n6","label":"sélection"},
        {"from":"n3","to":"n7","label":"tendance centrale"},
        {"from":"n3","to":"n8","label":"types"},
        {"from":"n4","to":"n9","label":"présentation"},
        {"from":"n4","to":"n10","label":"calcul"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Qu''est-ce qu''une méthode quantitative ?","options":["Une méthode basée sur des entretiens","Une méthode recueillant des données chiffrées sur un grand nombre","Une méthode d''observation participante","Une méthode philosophique"],"correct":1,"explanation":"Les méthodes quantitatives recueillent des données chiffrées (questionnaires, sondages) sur un grand nombre d''individus pour dégager des régularités statistiques."},
      {"id":"q2","question":"La moyenne de 4, 8, 12, 16 est :","options":["8","10","12","16"],"correct":1,"explanation":"La moyenne est (4+8+12+16)/4 = 40/4 = 10."},
      {"id":"q3","question":"La médiane de la série 3, 5, 7, 9, 11 est :","options":["5","7","9","3"],"correct":1,"explanation":"La médiane est la valeur centrale de la série ordonnée. Ici, c''est 7 (deux valeurs en dessous, deux au-dessus)."},
      {"id":"q4","question":"Un échantillon représentatif doit :","options":["Inclure toute la population","Reproduire les caractéristiques de la population étudiée","Être le plus petit possible","Ne contenir que des hommes"],"correct":1,"explanation":"Un échantillon représentatif reproduit fidèlement les caractéristiques de la population (âge, sexe, profession) pour permettre la généralisation des résultats."},
      {"id":"q5","question":"Une question fermée propose :","options":["Une réponse libre","Des réponses prédéfinies","Aucune réponse","Une question philosophique"],"correct":1,"explanation":"Une question fermée propose des réponses prédéfinies (oui/non, choix multiple, échelle) qui facilitent le traitement statistique."},
      {"id":"q6","question":"Sur 300 personnes interrogées, 90 sont au chômage. Quel est le pourcentage ?","options":["90%","33%","30%","10%"],"correct":2,"explanation":"Le pourcentage est (90/300) × 100 = 30%."},
      {"id":"q7","question":"Le mode d''une série statistique est :","options":["La valeur centrale","La valeur la plus fréquente","La valeur la plus grande","La somme des valeurs"],"correct":1,"explanation":"Le mode est la valeur qui apparaît le plus souvent dans une série statistique."},
      {"id":"q8","question":"Une variable qualitative décrit :","options":["Un nombre mesurable","Une qualité ou une catégorie","Une température","Un salaire"],"correct":1,"explanation":"Une variable qualitative décrit une qualité ou une catégorie (sexe, profession, couleur) et ne se mesure pas en chiffres."},
      {"id":"q9","question":"Quelle est la première étape d''une enquête quantitative ?","options":["Administrer le questionnaire","Analyser les données","Définir l''objet et les hypothèses","Rédiger le rapport"],"correct":2,"explanation":"La première étape est de définir l''objet de l''enquête et les hypothèses de recherche, avant de construire le questionnaire et de définir l''échantillon."},
      {"id":"q10","question":"Pourquoi faut-il faire un pré-test du questionnaire ?","options":["Pour impressionner les enquêtés","Pour vérifier que les questions sont claires et compréhensibles","Pour augmenter le nombre de réponses","Pour publier les résultats"],"correct":1,"explanation":"Le pré-test permet de vérifier que les questions sont claires, non ambiguës et bien comprises par les répondants, avant l''administration à l''échantillon complet."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 3 : Le travail comme facteur d''intégration
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'travail-integration', 3, 'Le travail comme facteur d''intégration sociale', 'Travail et identité, hiérarchie, mutations du marché, chômage au Mali', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'travail-integration-fiche', 'Le travail comme facteur d''intégration sociale', 'Identité sociale, hiérarchie, mutations du travail et chômage au Mali', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Comment le travail contribue-t-il à l''identité sociale ?","answer":"Le travail est un facteur central d''identité sociale : il détermine le statut social, les revenus, le prestige et le réseau de relations d''un individu. Quand on rencontre quelqu''un, la première question est souvent « Que faites-vous ? ». Le travail donne un sentiment d''utilité sociale, d''appartenance à un groupe professionnel et structure le temps quotidien."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce qu''une catégorie socioprofessionnelle (CSP) ?","answer":"Une CSP est un regroupement d''individus ayant des caractéristiques professionnelles et sociales similaires. En France, l''INSEE distingue : agriculteurs, artisans/commerçants, cadres, professions intermédiaires, employés, ouvriers. Au Mali, on peut distinguer : fonctionnaires, commerçants, agriculteurs, artisans, secteur informel. La CSP détermine en partie le niveau de vie et le prestige social."},
      {"id":"fc3","category":"Citation/Idée","question":"Comment le travail crée-t-il de la hiérarchie sociale ?","answer":"Le travail crée une hiérarchie sociale basée sur : 1) Le niveau de qualification (cadre vs ouvrier). 2) Le type de travail (intellectuel vs manuel). 3) Le niveau de revenu. 4) Le prestige associé au métier. Cette hiérarchie peut engendrer des inégalités et des rapports de domination. Au Mali, la fonction publique et le commerce sont souvent valorisés."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que l''exclusion sociale par le travail ?","answer":"L''exclusion sociale par le travail se produit quand un individu est durablement privé d''emploi. Le chômage de longue durée entraîne : perte de revenus, isolement social, perte d''estime de soi, marginalisation. Le travail précaire (emplois temporaires, sous-payés) peut aussi produire une intégration partielle et instable."},
      {"id":"fc5","category":"Exemple","question":"Quelles sont les caractéristiques du chômage au Mali ?","answer":"Le chômage au Mali touche particulièrement les jeunes (15-24 ans) et les diplômés. Causes : insuffisance de l''offre d''emploi, inadéquation formation/marché du travail, faiblesse du secteur industriel, croissance démographique forte. Le secteur informel absorbe une grande partie de la main-d''œuvre (plus de 80%). Le sous-emploi est aussi très répandu."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre secteur formel et informel ?","answer":"Le secteur formel regroupe les emplois déclarés, réglementés, avec contrat de travail et protection sociale (entreprises, administration). Le secteur informel regroupe les activités économiques non déclarées, sans protection sociale (petits commerces, artisanat de rue, services domestiques). Au Mali, le secteur informel représente la majorité des emplois."},
      {"id":"fc7","category":"Citation/Idée","question":"Comment Durkheim analyse-t-il le lien entre travail et intégration ?","answer":"Pour Durkheim, la division du travail social crée de la solidarité organique : chaque individu dépend des autres par la spécialisation de son travail. Contrairement à la solidarité mécanique (sociétés traditionnelles, similitude), la solidarité organique repose sur la complémentarité des fonctions. Le travail lie les individus entre eux et les intègre dans la société."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que la précarité de l''emploi ?","answer":"La précarité de l''emploi désigne une situation d''instabilité professionnelle : contrats à durée déterminée, emplois saisonniers, travail temporaire, sous-emploi. Le travailleur précaire vit dans l''incertitude du lendemain, ne peut pas planifier sa vie et risque l''exclusion sociale. Au Mali, la précarité touche une grande partie de la population active."},
      {"id":"fc9","category":"Méthode","question":"Comment analyser le chômage d''un point de vue sociologique ?","answer":"Pour analyser le chômage sociologiquement : 1) Définir le chômage (BIT : être sans emploi, disponible, chercher activement). 2) Mesurer : taux de chômage, durée, catégories touchées. 3) Identifier les causes structurelles (économie, formation, démographie). 4) Analyser les conséquences sociales (exclusion, pauvreté). 5) Examiner les politiques d''emploi."},
      {"id":"fc10","category":"Exemple","question":"Quelles solutions au chômage des jeunes au Mali ?","answer":"Solutions proposées : 1) Formation professionnelle adaptée au marché. 2) Soutien à l''entrepreneuriat jeune (micro-crédit, incubateurs). 3) Développement du secteur agricole moderne. 4) Amélioration du climat des affaires. 5) Programmes d''insertion (APEJ - Agence pour la Promotion de l''Emploi des Jeunes). 6) Diversification de l''économie au-delà de l''or et du coton."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre chômage et sous-emploi ?","answer":"Le chômage désigne la situation d''une personne sans emploi qui en cherche un. Le sous-emploi désigne une personne qui travaille mais en dessous de ses capacités : temps partiel involontaire, emploi sous-qualifié, emploi peu rémunéré. Au Mali, le sous-emploi est souvent plus répandu que le chômage au sens strict."},
      {"id":"fc12","category":"Citation/Idée","question":"Comment le travail peut-il être source d''aliénation ?","answer":"Marx montre que dans le capitalisme, le travail aliène le travailleur : il ne maîtrise ni le produit ni le processus de production. Aujourd''hui, l''aliénation prend de nouvelles formes : stress, burn-out, perte de sens, surveillance numérique. Le travail peut alors devenir source de souffrance au lieu d''être facteur d''intégration et d''épanouissement."}
    ],
    "schema": {
      "title": "Travail et intégration sociale",
      "nodes": [
        {"id":"n1","label":"Travail et intégration","type":"main"},
        {"id":"n2","label":"Identité sociale","type":"branch"},
        {"id":"n3","label":"Hiérarchie et CSP","type":"branch"},
        {"id":"n4","label":"Exclusion et chômage","type":"branch"},
        {"id":"n5","label":"Statut et prestige","type":"leaf"},
        {"id":"n6","label":"Solidarité organique","type":"leaf"},
        {"id":"n7","label":"Qualification et revenus","type":"leaf"},
        {"id":"n8","label":"Formel vs informel","type":"leaf"},
        {"id":"n9","label":"Chômage au Mali","type":"leaf"},
        {"id":"n10","label":"Précarité et sous-emploi","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"donne"},
        {"from":"n1","to":"n3","label":"crée"},
        {"from":"n1","to":"n4","label":"quand absent"},
        {"from":"n2","to":"n5","label":"détermine"},
        {"from":"n2","to":"n6","label":"Durkheim"},
        {"from":"n3","to":"n7","label":"critères"},
        {"from":"n3","to":"n8","label":"distinction"},
        {"from":"n4","to":"n9","label":"contexte"},
        {"from":"n4","to":"n10","label":"formes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le travail contribue à l''identité sociale en déterminant :","options":["Uniquement le salaire","Le statut, le prestige et le réseau social","La couleur des yeux","La religion"],"correct":1,"explanation":"Le travail détermine le statut social, les revenus, le prestige et le réseau de relations, constituant ainsi un élément central de l''identité sociale."},
      {"id":"q2","question":"Le secteur informel au Mali représente :","options":["Moins de 10% des emplois","Environ 30% des emplois","La majorité des emplois (plus de 80%)","Exactement 50% des emplois"],"correct":2,"explanation":"Au Mali, le secteur informel absorbe plus de 80% de la main-d''œuvre, regroupant les activités économiques non déclarées et sans protection sociale."},
      {"id":"q3","question":"Selon Durkheim, la division du travail crée :","options":["De l''anarchie","De la solidarité organique","De l''individualisme pur","De la violence"],"correct":1,"explanation":"Pour Durkheim, la division du travail social crée de la solidarité organique : les individus sont interdépendants grâce à la spécialisation de leurs fonctions."},
      {"id":"q4","question":"Le chômage au Mali touche particulièrement :","options":["Les retraités","Les jeunes et les diplômés","Les fonctionnaires","Les agriculteurs exclusivement"],"correct":1,"explanation":"Le chômage au Mali touche principalement les jeunes (15-24 ans) et paradoxalement les diplômés, en raison de l''inadéquation entre la formation et le marché du travail."},
      {"id":"q5","question":"Quelle est la différence entre chômage et sous-emploi ?","options":["Il n''y a aucune différence","Le chômage est l''absence d''emploi, le sous-emploi est un emploi en dessous des capacités","Le sous-emploi est plus grave","Le chômage n''existe pas au Mali"],"correct":1,"explanation":"Le chômage est l''absence totale d''emploi, tandis que le sous-emploi désigne une situation où la personne travaille en dessous de ses capacités (temps partiel involontaire, emploi sous-qualifié)."},
      {"id":"q6","question":"L''APEJ au Mali est :","options":["Une banque","L''Agence pour la Promotion de l''Emploi des Jeunes","Un parti politique","Une école"],"correct":1,"explanation":"L''APEJ (Agence pour la Promotion de l''Emploi des Jeunes) est l''organisme public malien chargé de faciliter l''insertion professionnelle des jeunes."},
      {"id":"q7","question":"La précarité de l''emploi se caractérise par :","options":["Un emploi stable et bien payé","L''instabilité professionnelle et l''incertitude","Des vacances prolongées","Un salaire élevé"],"correct":1,"explanation":"La précarité se caractérise par l''instabilité professionnelle (CDD, intérim, saisonnier), l''incertitude du lendemain et le risque d''exclusion sociale."},
      {"id":"q8","question":"Comment Marx explique-t-il l''aliénation par le travail ?","options":["Le travailleur est trop libre","Le travailleur ne maîtrise ni le produit ni le processus de production","Le travailleur gagne trop d''argent","Le travailleur choisit son métier"],"correct":1,"explanation":"Pour Marx, l''aliénation signifie que le travailleur est dépossédé du produit de son travail et du processus de production dans le système capitaliste."},
      {"id":"q9","question":"La solidarité mécanique (Durkheim) caractérise :","options":["Les sociétés industrielles","Les sociétés traditionnelles (similitude des membres)","Les sociétés capitalistes","Les sociétés futures"],"correct":1,"explanation":"La solidarité mécanique, selon Durkheim, caractérise les sociétés traditionnelles où les individus se ressemblent et partagent les mêmes croyances et activités."},
      {"id":"q10","question":"Le secteur formel se distingue du secteur informel par :","options":["L''absence de travail","La présence de contrats, de déclaration et de protection sociale","La taille des entreprises uniquement","Le type de produits vendus"],"correct":1,"explanation":"Le secteur formel regroupe les emplois déclarés, réglementés, avec contrat de travail et protection sociale, contrairement au secteur informel."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 4 : Recherche qualitative
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'recherche-qualitative', 4, 'Initiation à la recherche qualitative', 'Observation, entretien, analyse de contenu et méthodologie', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'recherche-qualitative-fiche', 'Initiation à la recherche qualitative', 'Observation, entretien et analyse de contenu en sciences sociales', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une méthode qualitative en sociologie ?","answer":"Les méthodes qualitatives visent à comprendre en profondeur les phénomènes sociaux en recueillant des données non chiffrées : discours, comportements, représentations. Elles portent sur un petit nombre de cas étudiés en détail. Les principales techniques sont : l''observation (participante ou non), l''entretien (directif, semi-directif, libre) et l''analyse de contenu."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce que l''observation en sociologie ?","answer":"L''observation est une technique de recueil de données qui consiste à regarder et noter systématiquement les comportements des individus dans leur milieu naturel. L''observation participante implique que le chercheur s''intègre au groupe étudié. L''observation non participante maintient une distance. Le chercheur utilise une grille d''observation et un journal de terrain."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce qu''un entretien en sociologie ?","answer":"L''entretien est une conversation méthodique entre un chercheur et un enquêté. On distingue : 1) L''entretien directif (questions précises, réponses courtes). 2) L''entretien semi-directif (guide d''entretien avec thèmes, liberté de réponse). 3) L''entretien libre (non directif, l''enquêté parle librement). L''entretien semi-directif est le plus utilisé en sociologie."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que l''analyse de contenu ?","answer":"L''analyse de contenu est une technique d''étude systématique de documents (textes, discours, images, médias). Elle consiste à découper le matériau en unités, les classer par thèmes et interpréter les résultats. Elle peut être quantitative (compter la fréquence des thèmes) ou qualitative (analyser le sens des discours)."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre méthode qualitative et quantitative ?","answer":"Quantitative : données chiffrées, grand échantillon, questionnaire standardisé, analyse statistique, vise à mesurer et généraliser. Qualitative : données verbales/observées, petit échantillon, entretien/observation, analyse thématique, vise à comprendre en profondeur. Les deux sont complémentaires et peuvent être combinées dans une approche mixte."},
      {"id":"fc6","category":"Méthode","question":"Comment mener un entretien semi-directif ?","answer":"1) Préparer un guide d''entretien (liste de thèmes à aborder). 2) Créer un climat de confiance avec l''enquêté. 3) Poser des questions ouvertes et relancer si nécessaire. 4) Laisser l''enquêté s''exprimer sans l''interrompre. 5) Enregistrer (avec accord) ou prendre des notes. 6) Retranscrire intégralement l''entretien. 7) Analyser les thèmes récurrents."},
      {"id":"fc7","category":"Méthode","question":"Comment rédiger un guide d''entretien ?","answer":"Le guide d''entretien comprend : 1) Une consigne de départ (question inaugurale large). 2) Des thèmes principaux à aborder (3-5 thèmes). 3) Des sous-thèmes ou questions de relance pour chaque thème. 4) Les thèmes sont ordonnés logiquement (du général au spécifique). Le guide est un aide-mémoire flexible, pas un questionnaire rigide."},
      {"id":"fc8","category":"Exemple","question":"Donnez un exemple de recherche qualitative au Mali.","answer":"Exemple : étude sur le mariage au Mali. Méthode : entretiens semi-directifs avec 20 femmes mariées de Bamako (10 en mariage monogame, 10 en mariage polygame). Thèmes : vécu du mariage, rôle de la famille, décision du choix du conjoint, rapport à la polygamie. Analyse thématique des discours pour comprendre les représentations du mariage."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre observation participante et non participante ?","answer":"L''observation participante : le chercheur s''intègre au groupe étudié, participe à ses activités, vit avec les enquêtés. Avantage : compréhension intime. Risque : perte d''objectivité. L''observation non participante : le chercheur observe de l''extérieur sans intervenir. Avantage : objectivité. Risque : compréhension superficielle."},
      {"id":"fc10","category":"Méthode","question":"Qu''est-ce que la triangulation en recherche ?","answer":"La triangulation consiste à croiser plusieurs méthodes, sources de données ou chercheurs pour renforcer la validité des résultats. Par exemple : combiner entretiens + observation + analyse de documents sur le même sujet. Si les résultats convergent, ils sont plus fiables. La triangulation réduit les biais propres à chaque méthode."},
      {"id":"fc11","category":"Définition","question":"Qu''est-ce que la saturation en recherche qualitative ?","answer":"La saturation est le point où les entretiens ou observations supplémentaires n''apportent plus d''informations nouvelles. Le chercheur entend les mêmes idées, les mêmes thèmes revenir. C''est le critère pour arrêter la collecte de données. En général, la saturation est atteinte après 15-30 entretiens, selon la complexité du sujet."},
      {"id":"fc12","category":"Méthode","question":"Comment analyser un entretien ?","answer":"Analyse thématique : 1) Retranscrire intégralement l''entretien. 2) Lire plusieurs fois pour s''imprégner. 3) Découper le texte en unités de sens. 4) Coder chaque unité (attribuer un thème). 5) Regrouper les codes en catégories. 6) Comparer les entretiens entre eux. 7) Interpréter les résultats en lien avec la problématique de recherche."}
    ],
    "schema": {
      "title": "Méthodes qualitatives en sociologie",
      "nodes": [
        {"id":"n1","label":"Recherche qualitative","type":"main"},
        {"id":"n2","label":"Observation","type":"branch"},
        {"id":"n3","label":"Entretien","type":"branch"},
        {"id":"n4","label":"Analyse de contenu","type":"branch"},
        {"id":"n5","label":"Participante","type":"leaf"},
        {"id":"n6","label":"Non participante","type":"leaf"},
        {"id":"n7","label":"Directif","type":"leaf"},
        {"id":"n8","label":"Semi-directif","type":"leaf"},
        {"id":"n9","label":"Quantitative (fréquences)","type":"leaf"},
        {"id":"n10","label":"Qualitative (sens)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"observer"},
        {"from":"n1","to":"n3","label":"interroger"},
        {"from":"n1","to":"n4","label":"analyser"},
        {"from":"n2","to":"n5","label":"intégrée"},
        {"from":"n2","to":"n6","label":"distanciée"},
        {"from":"n3","to":"n7","label":"structuré"},
        {"from":"n3","to":"n8","label":"semi-structuré"},
        {"from":"n4","to":"n9","label":"compter"},
        {"from":"n4","to":"n10","label":"interpréter"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''entretien semi-directif se caractérise par :","options":["Des questions fermées uniquement","Un guide de thèmes avec liberté de réponse","L''absence totale de questions","Un questionnaire standardisé"],"correct":1,"explanation":"L''entretien semi-directif utilise un guide de thèmes à aborder tout en laissant à l''enquêté la liberté de développer ses réponses."},
      {"id":"q2","question":"L''observation participante implique que le chercheur :","options":["Reste invisible","S''intègre au groupe étudié et participe à ses activités","Observe depuis un laboratoire","Envoie des questionnaires"],"correct":1,"explanation":"Dans l''observation participante, le chercheur s''intègre au groupe étudié, vit avec les enquêtés et participe à leurs activités quotidiennes."},
      {"id":"q3","question":"Qu''est-ce que la saturation en recherche qualitative ?","options":["Le point où l''on a trop de données","Le point où les entretiens n''apportent plus d''informations nouvelles","L''impossibilité de trouver des enquêtés","Le manque de financement"],"correct":1,"explanation":"La saturation est le point où les entretiens supplémentaires n''apportent plus d''informations nouvelles, indiquant qu''il est temps d''arrêter la collecte de données."},
      {"id":"q4","question":"L''analyse de contenu consiste à :","options":["Lire rapidement un texte","Étudier systématiquement des documents en les classant par thèmes","Résumer un livre","Corriger les fautes d''orthographe"],"correct":1,"explanation":"L''analyse de contenu étudie systématiquement des documents (textes, discours) en les découpant en unités, les classant par thèmes et interprétant les résultats."},
      {"id":"q5","question":"La triangulation en recherche consiste à :","options":["Utiliser une seule méthode","Croiser plusieurs méthodes pour renforcer la validité","Étudier des triangles","Interviewer trois personnes"],"correct":1,"explanation":"La triangulation croise plusieurs méthodes, sources ou chercheurs pour vérifier la convergence des résultats et renforcer leur validité."},
      {"id":"q6","question":"Quel est le principal avantage des méthodes qualitatives ?","options":["La rapidité","La compréhension en profondeur des phénomènes","La représentativité statistique","Le faible coût"],"correct":1,"explanation":"Les méthodes qualitatives permettent une compréhension en profondeur des phénomènes sociaux, en explorant les motivations, les représentations et le vécu des individus."},
      {"id":"q7","question":"Comment code-t-on un entretien ?","options":["En le traduisant dans une autre langue","En attribuant un thème à chaque unité de sens","En le résumant en une phrase","En le comptant en nombre de mots"],"correct":1,"explanation":"Coder un entretien consiste à découper le texte en unités de sens et à attribuer un thème ou un code à chaque unité, puis à regrouper les codes en catégories."},
      {"id":"q8","question":"Un guide d''entretien comprend :","options":["Des questions fermées uniquement","Une consigne de départ et des thèmes avec sous-thèmes","Aucune question","Un questionnaire à choix multiples"],"correct":1,"explanation":"Le guide d''entretien comprend une consigne inaugurale et des thèmes principaux avec des sous-thèmes ou questions de relance, ordonnés logiquement."},
      {"id":"q9","question":"Quel risque principal pose l''observation participante ?","options":["Le coût élevé","La perte d''objectivité par trop grande proximité","L''impossibilité d''observer","Le manque de données"],"correct":1,"explanation":"Le risque principal de l''observation participante est la perte d''objectivité : en s''intégrant trop au groupe, le chercheur peut perdre sa distance critique."},
      {"id":"q10","question":"Les méthodes qualitatives et quantitatives sont :","options":["Totalement opposées et incompatibles","Complémentaires et peuvent être combinées","Identiques","L''une est toujours supérieure à l''autre"],"correct":1,"explanation":"Les méthodes qualitatives et quantitatives sont complémentaires : les quantitatives mesurent, les qualitatives comprennent. Les combiner (approche mixte) renforce la recherche."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 5 : Institution familiale
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'institution-familiale', 5, 'Institution familiale et socialisation', 'Famille, mariage, traditions matrimoniales, polygamie au Mali', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'institution-familiale-fiche', 'Institution familiale et socialisation', 'Famille, mariage, traditions et régimes matrimoniaux au Mali', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Comment définir la famille en sociologie ?","answer":"La famille est un groupe social fondé sur les liens de parenté (sang ou alliance) dont les membres vivent ensemble ou maintiennent des relations régulières. On distingue : la famille nucléaire (parents + enfants), la famille élargie (incluant grands-parents, oncles, cousins) et la famille recomposée. Au Mali, la famille élargie reste le modèle dominant."},
      {"id":"fc2","category":"Distinction","question":"Quels sont les types de famille ?","answer":"1) Famille nucléaire : couple marié + enfants (modèle occidental). 2) Famille élargie : trois générations ou plus sous le même toit (modèle africain traditionnel). 3) Famille monoparentale : un seul parent + enfants. 4) Famille recomposée : couple dont un ou les deux ont des enfants d''une union précédente. Au Mali, la famille élargie (du) est la structure de base."},
      {"id":"fc3","category":"Définition","question":"Comment le mariage fonde-t-il la famille ?","answer":"Le mariage est l''union légale ou coutumière entre deux personnes, fondatrice de la famille. Il crée des droits et obligations réciproques entre époux (fidélité, assistance, contribution aux charges). Au Mali, le mariage peut être civil, religieux (islamique) et/ou coutumier. Il implique souvent les deux familles (alliance entre lignages)."},
      {"id":"fc4","category":"Exemple","question":"Quelles sont les traditions matrimoniales au Mali ?","answer":"Au Mali, le mariage traditionnel comprend : 1) Les négociations entre familles (envoi de cola). 2) Le versement de la dot (par la famille du marié). 3) Les cérémonies coutumières et religieuses. 4) Le « djéliya » (rôle des griots). Les traditions varient selon les ethnies : Bambara, Peul, Sonrhaï, Touareg ont chacun leurs rites spécifiques. La religion (Islam) et les traditions s''entremêlent."},
      {"id":"fc5","category":"Distinction","question":"Quelle différence entre polygamie et monogamie ?","answer":"La monogamie est le régime matrimonial où une personne est mariée à une seule autre personne. La polygamie permet le mariage avec plusieurs conjoints : la polygynie (un homme, plusieurs femmes) est la forme la plus courante, pratiquée dans de nombreuses sociétés africaines et autorisée par l''Islam (jusqu''à 4 épouses). La polyandrie (une femme, plusieurs maris) est très rare."},
      {"id":"fc6","category":"Exemple","question":"Comment le mariage diffère-t-il en milieu sédentaire et nomade au Mali ?","answer":"En milieu sédentaire (Bambara, Malinké) : mariage souvent arrangé entre familles du même village, dot importante, cérémonie communautaire élaborée. En milieu nomade (Touareg, Peul) : le mariage peut être endogamique (dans le même groupe), la dot peut être en bétail, les cérémonies suivent les déplacements. Chez les Touareg, la femme possède la tente conjugale."},
      {"id":"fc7","category":"Citation/Idée","question":"Comment la famille assure-t-elle la socialisation ?","answer":"La famille est le premier agent de socialisation : elle transmet la langue, les valeurs morales, les normes de comportement, les croyances religieuses et l''identité culturelle. Au Mali, la famille enseigne le respect des aînés (« maaya » en bambara), les règles de politesse, le sens de la communauté et les rôles de genre. Elle transmet aussi le statut social et le capital culturel."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que le divorce en sociologie ?","answer":"Le divorce est la rupture légale du lien conjugal. En sociologie, il est analysé comme un indicateur des transformations de la famille. Au Mali, le divorce est possible légalement et dans l''Islam (talaq pour l''homme, khul'' pour la femme). Les causes fréquentes : mésentente, infidélité, problèmes économiques, ingérence des belles-familles, stérilité."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre endogamie et exogamie ?","answer":"L''endogamie est la règle qui impose de se marier à l''intérieur de son groupe (même ethnie, même caste, même religion). L''exogamie impose de se marier en dehors de son groupe. Au Mali, certaines sociétés pratiquent l''endogamie de caste (forgerons entre eux) tandis que l''exogamie de clan est parfois obligatoire (interdiction de mariage entre certains clans)."},
      {"id":"fc10","category":"Citation/Idée","question":"Comment la famille malienne évolue-t-elle ?","answer":"La famille malienne connaît des mutations : urbanisation (réduction de la taille), scolarisation des filles (retard du mariage), influence des médias, migration (familles transnationales). Cependant, les valeurs traditionnelles persistent : respect des aînés, solidarité familiale, importance du lignage. On observe une coexistence entre modernité et tradition."},
      {"id":"fc11","category":"Méthode","question":"Comment étudier sociologiquement l''institution familiale ?","answer":"Pour étudier la famille : 1) Définir le type de famille étudié. 2) Observer les rôles et relations au sein de la famille. 3) Analyser les fonctions de la famille (socialisation, reproduction, solidarité). 4) Comparer les modèles familiaux (rural/urbain, ethnies). 5) Étudier les transformations (divorce, famille monoparentale). 6) Situer dans le contexte malien."},
      {"id":"fc12","category":"Exemple","question":"Quel est le rôle du Code des personnes et de la famille au Mali ?","answer":"Le Code des personnes et de la famille (2011) régit le mariage, le divorce, la filiation et la succession au Mali. Il fixe l''âge minimum du mariage (18 ans pour les garçons, 16 pour les filles avec dérogation), reconnaît la polygamie (option au moment du mariage), définit les droits des époux et organise le divorce. Il a fait l''objet de débats vifs entre modernistes et traditionalistes."}
    ],
    "schema": {
      "title": "Institution familiale au Mali",
      "nodes": [
        {"id":"n1","label":"Famille et mariage","type":"main"},
        {"id":"n2","label":"Types de famille","type":"branch"},
        {"id":"n3","label":"Mariage","type":"branch"},
        {"id":"n4","label":"Socialisation familiale","type":"branch"},
        {"id":"n5","label":"Nucléaire vs élargie","type":"leaf"},
        {"id":"n6","label":"Traditions matrimoniales","type":"leaf"},
        {"id":"n7","label":"Polygamie vs monogamie","type":"leaf"},
        {"id":"n8","label":"Sédentaire vs nomade","type":"leaf"},
        {"id":"n9","label":"Transmission des valeurs","type":"leaf"},
        {"id":"n10","label":"Mutations familiales","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"structures"},
        {"from":"n1","to":"n3","label":"fondement"},
        {"from":"n1","to":"n4","label":"fonction"},
        {"from":"n2","to":"n5","label":"modèles"},
        {"from":"n3","to":"n6","label":"Mali"},
        {"from":"n3","to":"n7","label":"régimes"},
        {"from":"n3","to":"n8","label":"milieux"},
        {"from":"n4","to":"n9","label":"rôle"},
        {"from":"n4","to":"n10","label":"évolution"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le modèle familial dominant au Mali est :","options":["La famille nucléaire","La famille élargie","La famille monoparentale","La famille recomposée"],"correct":1,"explanation":"Au Mali, la famille élargie (incluant grands-parents, oncles, cousins) reste le modèle dominant, même si l''urbanisation tend à réduire la taille des ménages."},
      {"id":"q2","question":"La polygynie est :","options":["Le mariage d''une femme avec plusieurs hommes","Le mariage d''un homme avec plusieurs femmes","L''interdiction du mariage","Le divorce"],"correct":1,"explanation":"La polygynie est le mariage d''un homme avec plusieurs femmes, forme la plus courante de polygamie, pratiquée dans de nombreuses sociétés africaines et autorisée par l''Islam."},
      {"id":"q3","question":"L''endogamie impose de se marier :","options":["Avec un étranger","À l''intérieur de son groupe","Avec plusieurs personnes","Sans cérémonie"],"correct":1,"explanation":"L''endogamie est la règle qui impose de se marier à l''intérieur de son groupe (même ethnie, même caste, même religion)."},
      {"id":"q4","question":"Quel est le premier agent de socialisation ?","options":["L''école","Les médias","La famille","Le travail"],"correct":2,"explanation":"La famille est le premier agent de socialisation : c''est dans la famille que l''enfant apprend la langue, les valeurs, les normes de comportement et l''identité culturelle."},
      {"id":"q5","question":"Le Code des personnes et de la famille au Mali date de :","options":["1960","1992","2011","2020"],"correct":2,"explanation":"Le Code des personnes et de la famille a été adopté au Mali en 2011, après de longs débats entre modernistes et traditionalistes."},
      {"id":"q6","question":"Chez les Touareg du Mali, qui possède la tente conjugale ?","options":["Le mari","La femme","Le chef du village","L''État"],"correct":1,"explanation":"Dans la tradition touarègue, c''est la femme qui possède la tente conjugale (ehan), ce qui lui confère un statut particulier dans le mariage."},
      {"id":"q7","question":"La dot au Mali est traditionnellement versée par :","options":["La famille de la mariée","La famille du marié","L''État","La communauté"],"correct":1,"explanation":"Au Mali, la dot (ou compensation matrimoniale) est traditionnellement versée par la famille du marié à la famille de la mariée."},
      {"id":"q8","question":"Quels facteurs transforment la famille malienne ?","options":["Aucun, la famille est immuable","Urbanisation, scolarisation des filles, migration, médias","Le climat uniquement","La politique gouvernementale uniquement"],"correct":1,"explanation":"La famille malienne évolue sous l''effet de l''urbanisation, de la scolarisation des filles, des migrations et de l''influence des médias, tout en conservant certaines valeurs traditionnelles."},
      {"id":"q9","question":"L''Islam autorise la polygamie jusqu''à :","options":["2 épouses","3 épouses","4 épouses","Aucune limite"],"correct":2,"explanation":"L''Islam autorise la polygynie jusqu''à 4 épouses, à condition que le mari traite toutes ses femmes de manière équitable."},
      {"id":"q10","question":"Quelle est la fonction principale de la famille en matière de socialisation ?","options":["Produire des biens économiques","Transmettre les normes, valeurs et identité culturelle","Organiser les élections","Gérer l''administration publique"],"correct":1,"explanation":"La fonction principale de la famille en matière de socialisation est de transmettre aux enfants les normes, les valeurs, les comportements et l''identité culturelle de leur société."}
    ]
  }');

  -- ============================================================
  -- SOCIOLOGIE - Chapitre 6 : Méthodes quantitatives et qualitatives (approfondissement)
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (socio_id, 'methodes-approfondissement', 6, 'Méthodes quantitatives et qualitatives (approfondissement)', 'Graphiques, tableaux, synthèse des méthodes de recherche', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'methodes-approfondissement-fiche', 'Approfondissement des méthodes de recherche', 'Graphiques, tableaux statistiques et synthèse méthodologique', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Méthode","question":"Comment construire un tableau statistique ?","answer":"Un tableau statistique comprend : 1) Un titre clair et précis. 2) Des lignes (modalités de la variable 1). 3) Des colonnes (modalités de la variable 2). 4) Des cellules (effectifs ou pourcentages). 5) Les totaux en marge. 6) La source des données. Exemple : tableau croisé « Niveau d''études × situation d''emploi » avec effectifs et pourcentages en ligne."},
      {"id":"fc2","category":"Méthode","question":"Quels sont les principaux types de graphiques ?","answer":"1) Diagramme en barres : comparaison de catégories (variable qualitative). 2) Histogramme : distribution d''une variable quantitative continue. 3) Diagramme circulaire (camembert) : proportions d''un tout (100%). 4) Courbe : évolution dans le temps. 5) Nuage de points : relation entre deux variables quantitatives. Choisir le graphique adapté au type de données."},
      {"id":"fc3","category":"Méthode","question":"Comment choisir entre méthode quantitative et qualitative ?","answer":"Choisir la méthode quantitative si : l''objectif est de mesurer, comparer, généraliser ; le phénomène est bien connu ; on dispose d''un grand échantillon. Choisir la qualitative si : l''objectif est de comprendre en profondeur ; le phénomène est peu connu ; on veut explorer des représentations. L''approche mixte combine les deux pour une vision complète."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''un tableau croisé ?","answer":"Un tableau croisé (ou tableau de contingence) présente la distribution conjointe de deux variables. En ligne : les modalités de la variable 1. En colonne : les modalités de la variable 2. Les cellules contiennent les effectifs ou pourcentages. Il permet de repérer les relations entre variables. Exemple : sexe × opinion sur la polygamie."},
      {"id":"fc5","category":"Méthode","question":"Comment interpréter un pourcentage en ligne vs en colonne ?","answer":"Pourcentage en ligne : on calcule le pourcentage par rapport au total de la ligne. Il compare les colonnes au sein de chaque ligne. Pourcentage en colonne : on calcule par rapport au total de la colonne. Il compare les lignes au sein de chaque colonne. Le choix dépend de la question posée : « Parmi les femmes, combien... ? » (% en ligne si les femmes sont en ligne)."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre corrélation et causalité ?","answer":"La corrélation est un lien statistique entre deux variables (quand l''une varie, l''autre aussi). La causalité est un lien de cause à effet (l''une provoque l''autre). Une corrélation ne prouve pas la causalité ! Exemple : il y a une corrélation entre la vente de glaces et les noyades, mais les glaces ne causent pas les noyades (variable cachée : la chaleur)."},
      {"id":"fc7","category":"Méthode","question":"Comment présenter les résultats d''une recherche ?","answer":"Structure du rapport de recherche : 1) Introduction (problématique, hypothèses). 2) Revue de littérature (ce qu''on sait déjà). 3) Méthodologie (méthode, échantillon, outils). 4) Résultats (données, tableaux, graphiques). 5) Discussion (interprétation, liens avec la théorie). 6) Conclusion (réponse aux hypothèses, limites, perspectives)."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que l''objectivité en recherche sociale ?","answer":"L''objectivité est l''idéal de neutralité du chercheur : ne pas laisser ses opinions, préjugés ou valeurs influencer la recherche. En pratique, l''objectivité absolue est impossible en sciences sociales (le chercheur est lui-même un être social). On vise plutôt la rigueur méthodologique, la transparence et la réflexivité (conscience de ses propres biais)."},
      {"id":"fc9","category":"Exemple","question":"Comment combiner quantitatif et qualitatif dans une recherche ?","answer":"Exemple de recherche mixte sur l''éducation des filles au Mali : 1) Phase quantitative : questionnaire auprès de 500 familles sur la scolarisation des filles (taux, durée, abandon). 2) Phase qualitative : 20 entretiens avec des parents et des filles pour comprendre les raisons de la déscolarisation. Les données chiffrées sont éclairées par les témoignages."},
      {"id":"fc10","category":"Méthode","question":"Comment calculer un taux de variation ?","answer":"Taux de variation = ((Valeur finale - Valeur initiale) / Valeur initiale) × 100. Exemple : le chômage passe de 200 000 à 250 000 personnes. Taux de variation = ((250 000 - 200 000) / 200 000) × 100 = 25%. Le chômage a augmenté de 25%. Un taux négatif indique une baisse."},
      {"id":"fc11","category":"Distinction","question":"Quelle différence entre population et échantillon ?","answer":"La population est l''ensemble total des individus concernés par l''étude (ex : tous les jeunes de 18-25 ans au Mali). L''échantillon est le sous-ensemble sélectionné pour l''étude (ex : 500 jeunes interrogés). L''échantillon doit être représentatif de la population pour que les résultats soient généralisables."},
      {"id":"fc12","category":"Méthode","question":"Quelles sont les limites des méthodes de recherche en sciences sociales ?","answer":"Limites : 1) Quantitative : réduit la réalité à des chiffres, risque de questionnaire biaisé, ne capture pas le sens. 2) Qualitative : non généralisable, subjectivité du chercheur, petit échantillon. 3) Éthiques : consentement éclairé, anonymat, protection des enquêtés. 4) Pratiques : coût, temps, accès au terrain. La combinaison des méthodes atténue ces limites."}
    ],
    "schema": {
      "title": "Synthèse des méthodes de recherche",
      "nodes": [
        {"id":"n1","label":"Méthodes de recherche","type":"main"},
        {"id":"n2","label":"Quantitative","type":"branch"},
        {"id":"n3","label":"Qualitative","type":"branch"},
        {"id":"n4","label":"Approche mixte","type":"branch"},
        {"id":"n5","label":"Tableaux et graphiques","type":"leaf"},
        {"id":"n6","label":"Statistiques descriptives","type":"leaf"},
        {"id":"n7","label":"Entretiens et observation","type":"leaf"},
        {"id":"n8","label":"Analyse thématique","type":"leaf"},
        {"id":"n9","label":"Complémentarité","type":"leaf"},
        {"id":"n10","label":"Triangulation","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mesurer"},
        {"from":"n1","to":"n3","label":"comprendre"},
        {"from":"n1","to":"n4","label":"combiner"},
        {"from":"n2","to":"n5","label":"présentation"},
        {"from":"n2","to":"n6","label":"outils"},
        {"from":"n3","to":"n7","label":"collecte"},
        {"from":"n3","to":"n8","label":"traitement"},
        {"from":"n4","to":"n9","label":"force"},
        {"from":"n4","to":"n10","label":"validation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel graphique est le plus adapté pour montrer des proportions ?","options":["La courbe","L''histogramme","Le diagramme circulaire (camembert)","Le nuage de points"],"correct":2,"explanation":"Le diagramme circulaire (camembert) est le plus adapté pour montrer les proportions d''un tout (100%), chaque secteur représentant une catégorie."},
      {"id":"q2","question":"Si le chômage passe de 100 000 à 130 000, le taux de variation est :","options":["13%","30%","130%","3%"],"correct":1,"explanation":"Taux de variation = ((130 000 - 100 000) / 100 000) × 100 = 30%."},
      {"id":"q3","question":"Une corrélation entre deux variables prouve-t-elle la causalité ?","options":["Oui, toujours","Non, corrélation n''est pas causalité","Seulement si les variables sont quantitatives","Seulement en sciences exactes"],"correct":1,"explanation":"Non, une corrélation ne prouve pas la causalité. Deux variables peuvent varier ensemble sans que l''une cause l''autre (variable cachée possible)."},
      {"id":"q4","question":"L''approche mixte en recherche combine :","options":["Théorie et pratique","Méthodes quantitatives et qualitatives","Plusieurs chercheurs","Plusieurs pays"],"correct":1,"explanation":"L''approche mixte combine méthodes quantitatives (questionnaires, statistiques) et qualitatives (entretiens, observation) pour une compréhension plus complète."},
      {"id":"q5","question":"Un tableau croisé permet de :","options":["Calculer la moyenne","Repérer les relations entre deux variables","Mesurer le temps","Dessiner un graphique"],"correct":1,"explanation":"Un tableau croisé présente la distribution conjointe de deux variables, permettant de repérer d''éventuelles relations entre elles."},
      {"id":"q6","question":"L''objectivité parfaite est-elle possible en sciences sociales ?","options":["Oui, toujours","Non, mais on vise la rigueur et la réflexivité","Seulement en sociologie","Seulement avec des chiffres"],"correct":1,"explanation":"L''objectivité parfaite est impossible en sciences sociales car le chercheur est lui-même un être social. On vise la rigueur méthodologique et la réflexivité."},
      {"id":"q7","question":"Quel type de graphique montre une évolution dans le temps ?","options":["Le diagramme circulaire","Le diagramme en barres","La courbe","Le nuage de points"],"correct":2,"explanation":"La courbe est le graphique le plus adapté pour montrer l''évolution d''un phénomène dans le temps, avec le temps en abscisse et les valeurs en ordonnée."},
      {"id":"q8","question":"Le rapport de recherche comprend notamment :","options":["Uniquement les résultats","Introduction, méthodologie, résultats, discussion, conclusion","Seulement la bibliographie","Les notes de cours"],"correct":1,"explanation":"Le rapport de recherche suit une structure : introduction (problématique), revue de littérature, méthodologie, résultats, discussion et conclusion."},
      {"id":"q9","question":"Les pourcentages en ligne permettent de :","options":["Calculer la moyenne","Comparer les colonnes au sein de chaque ligne","Mesurer la dispersion","Tracer un histogramme"],"correct":1,"explanation":"Les pourcentages en ligne calculent la proportion par rapport au total de chaque ligne, permettant de comparer la distribution des colonnes pour chaque ligne."},
      {"id":"q10","question":"Quelle limite est commune aux deux types de méthodes ?","options":["Le coût et le temps","L''absence de données","L''impossibilité de publier","Le manque d''intérêt"],"correct":0,"explanation":"Les deux types de méthodes partagent des limites pratiques (coût, temps, accès au terrain) et éthiques (consentement, anonymat). La combinaison des méthodes atténue les limites méthodologiques."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 1 : La Deuxième Guerre mondiale
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'deuxieme-guerre-mondiale', 1, 'La Deuxième Guerre mondiale (1939-1945)', 'Causes, étapes, conséquences et l''Afrique dans la guerre', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'deuxieme-guerre-mondiale-fiche', 'La Deuxième Guerre mondiale (1939-1945)', 'Causes, étapes, conséquences et le Soudan français dans la guerre', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelles sont les causes de la Deuxième Guerre mondiale ?","answer":"Causes profondes : 1) Les frustrations issues du traité de Versailles (1919). 2) La crise économique de 1929. 3) La montée des totalitarismes (nazisme en Allemagne, fascisme en Italie). 4) L''expansionnisme du Japon et de l''Allemagne nazie. 5) L''échec de la SDN. Cause immédiate : l''invasion de la Pologne par l''Allemagne le 1er septembre 1939."},
      {"id":"fc2","category":"Définition","question":"Quelles sont les grandes étapes de la guerre ?","answer":"1) 1939-1942 : victoires de l''Axe (Blitzkrieg, chute de la France, attaque de l''URSS, Pearl Harbor). 2) 1942-1943 : tournant (Stalingrad, El-Alamein, Midway). 3) 1943-1945 : victoire des Alliés (débarquement en Normandie juin 1944, libération de l''Europe, capitulation de l''Allemagne 8 mai 1945, bombes atomiques Hiroshima et Nagasaki, capitulation du Japon 2 septembre 1945)."},
      {"id":"fc3","category":"Définition","question":"Quelles sont les conséquences immédiates de la guerre ?","answer":"1) Bilan humain : 50-60 millions de morts dont majorité de civils, Shoah (6 millions de Juifs). 2) Bilan matériel : destructions massives, villes rasées. 3) Bilan politique : déclin de l''Europe, émergence de deux superpuissances (USA et URSS), création de l''ONU (1945). 4) Bilan moral : procès de Nuremberg, Déclaration universelle des droits de l''homme (1948)."},
      {"id":"fc4","category":"Exemple","question":"Quel a été le rôle de l''Afrique dans la Deuxième Guerre mondiale ?","answer":"L''Afrique a contribué massivement : 1) Des centaines de milliers de soldats africains (tirailleurs sénégalais) ont combattu pour la France. 2) L''Afrique du Nord a été un théâtre d''opérations majeur (campagne de Tunisie, débarquement en Afrique du Nord 1942). 3) Les colonies africaines ont fourni matières premières et vivres. 4) L''effort de guerre a renforcé les aspirations à l''indépendance."},
      {"id":"fc5","category":"Exemple","question":"Quel a été le rôle du Soudan français (Mali) dans la guerre ?","answer":"Le Soudan français (actuel Mali) a participé à l''effort de guerre : des milliers de Soudanais ont été mobilisés comme tirailleurs sénégalais et ont combattu en France, en Italie et en Allemagne. Le pays a aussi fourni des ressources agricoles. Après la guerre, les anciens combattants ont revendiqué des droits et contribué au mouvement d''émancipation politique."},
      {"id":"fc6","category":"Distinction","question":"Quels étaient les deux camps pendant la guerre ?","answer":"Les Alliés : France, Royaume-Uni, URSS (à partir de 1941), États-Unis (à partir de 1941), Chine. L''Axe : Allemagne nazie (Hitler), Italie fasciste (Mussolini), Japon impérial (Hirohito). Certains pays sont restés neutres (Suisse, Suède). La guerre a opposé les démocraties et l''URSS communiste aux régimes fascistes et militaristes."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la Shoah ?","answer":"La Shoah (« catastrophe » en hébreu) désigne le génocide de 6 millions de Juifs européens par le régime nazi d''Hitler entre 1941 et 1945. Les Juifs ont été persécutés, déportés dans des camps de concentration et d''extermination (Auschwitz, Treblinka). C''est le plus grand génocide de l''histoire, condamné au procès de Nuremberg comme crime contre l''humanité."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que le procès de Nuremberg ?","answer":"Le procès de Nuremberg (1945-1946) est le tribunal militaire international qui a jugé les principaux responsables nazis pour crimes de guerre, crimes contre l''humanité et crime contre la paix. Il a établi le principe que l''obéissance aux ordres ne justifie pas les crimes. 12 accusés ont été condamnés à mort. Ce procès a fondé le droit pénal international."},
      {"id":"fc9","category":"Méthode","question":"Comment analyser les causes d''un conflit en histoire ?","answer":"Pour analyser les causes : 1) Distinguer causes profondes (économiques, politiques, idéologiques) et cause immédiate (événement déclencheur). 2) Hiérarchiser les causes (principales vs secondaires). 3) Montrer les liens entre les causes. 4) Situer dans le contexte de l''époque. 5) Utiliser des dates et des faits précis."},
      {"id":"fc10","category":"Distinction","question":"Quelle différence entre la SDN et l''ONU ?","answer":"La SDN (Société des Nations, 1920) a échoué à maintenir la paix : absence des USA, pas de force armée, retrait de l''Allemagne et du Japon. L''ONU (Organisation des Nations Unies, 1945) a tiré les leçons de cet échec : les USA sont membres fondateurs, le Conseil de sécurité peut autoriser l''usage de la force, les grandes puissances ont un droit de véto."}
    ],
    "schema": {
      "title": "La Deuxième Guerre mondiale (1939-1945)",
      "nodes": [
        {"id":"n1","label":"Seconde Guerre mondiale","type":"main"},
        {"id":"n2","label":"Causes","type":"branch"},
        {"id":"n3","label":"Étapes","type":"branch"},
        {"id":"n4","label":"Conséquences","type":"branch"},
        {"id":"n5","label":"Versailles, crise, totalitarismes","type":"leaf"},
        {"id":"n6","label":"1939-42 : Axe domine","type":"leaf"},
        {"id":"n7","label":"1942-43 : tournant","type":"leaf"},
        {"id":"n8","label":"1943-45 : victoire Alliés","type":"leaf"},
        {"id":"n9","label":"Bilan humain : 50-60M morts","type":"leaf"},
        {"id":"n10","label":"ONU, deux superpuissances","type":"leaf"},
        {"id":"n11","label":"Afrique et Soudan français","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"origines"},
        {"from":"n1","to":"n3","label":"déroulement"},
        {"from":"n1","to":"n4","label":"résultats"},
        {"from":"n2","to":"n5","label":"facteurs"},
        {"from":"n3","to":"n6","label":"phase 1"},
        {"from":"n3","to":"n7","label":"phase 2"},
        {"from":"n3","to":"n8","label":"phase 3"},
        {"from":"n4","to":"n9","label":"humain"},
        {"from":"n4","to":"n10","label":"politique"},
        {"from":"n1","to":"n11","label":"participation africaine"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la cause immédiate de la Seconde Guerre mondiale ?","options":["L''assassinat de l''archiduc François-Ferdinand","L''invasion de la Pologne par l''Allemagne le 1er septembre 1939","L''attaque de Pearl Harbor","La crise de 1929"],"correct":1,"explanation":"La cause immédiate est l''invasion de la Pologne par l''Allemagne nazie le 1er septembre 1939, ce qui provoque la déclaration de guerre de la France et du Royaume-Uni."},
      {"id":"q2","question":"Quelle bataille marque le tournant de la guerre sur le front est ?","options":["Verdun","Stalingrad (1942-1943)","Waterloo","Austerlitz"],"correct":1,"explanation":"La bataille de Stalingrad (1942-1943) est le tournant de la guerre sur le front est : la défaite de l''Allemagne nazie face à l''URSS marque le début du recul de l''Axe."},
      {"id":"q3","question":"Combien de personnes sont mortes pendant la Seconde Guerre mondiale ?","options":["10 millions","25 millions","50 à 60 millions","100 millions"],"correct":2,"explanation":"La Seconde Guerre mondiale a fait entre 50 et 60 millions de morts, dont une majorité de civils, ce qui en fait le conflit le plus meurtrier de l''histoire."},
      {"id":"q4","question":"Qu''est-ce que la Shoah ?","options":["Une bataille","Le génocide de 6 millions de Juifs par les nazis","Un traité de paix","Une organisation internationale"],"correct":1,"explanation":"La Shoah est le génocide systématique de 6 millions de Juifs européens par le régime nazi entre 1941 et 1945."},
      {"id":"q5","question":"Comment le Soudan français (Mali) a-t-il participé à la guerre ?","options":["Il est resté neutre","Par la mobilisation de tirailleurs et la fourniture de ressources","En déclarant son indépendance","En s''alliant à l''Axe"],"correct":1,"explanation":"Le Soudan français a fourni des milliers de tirailleurs sénégalais et des ressources agricoles à l''effort de guerre allié."},
      {"id":"q6","question":"Quand l''Allemagne a-t-elle capitulé ?","options":["1er septembre 1939","6 juin 1944","8 mai 1945","2 septembre 1945"],"correct":2,"explanation":"L''Allemagne nazie a capitulé le 8 mai 1945, mettant fin à la guerre en Europe."},
      {"id":"q7","question":"Le procès de Nuremberg a jugé :","options":["Les résistants français","Les principaux responsables nazis","Les soldats américains","Les dirigeants soviétiques"],"correct":1,"explanation":"Le procès de Nuremberg (1945-1946) a jugé les principaux responsables nazis pour crimes de guerre et crimes contre l''humanité."},
      {"id":"q8","question":"Quelle organisation internationale est créée après la guerre ?","options":["La SDN","L''ONU","L''Union africaine","L''OTAN"],"correct":1,"explanation":"L''Organisation des Nations Unies (ONU) est créée en 1945 pour maintenir la paix et la sécurité internationales, remplaçant la SDN qui avait échoué."},
      {"id":"q9","question":"Quels pays forment l''Axe ?","options":["France, Royaume-Uni, USA","Allemagne, Italie, Japon","URSS, Chine, France","USA, URSS, Chine"],"correct":1,"explanation":"L''Axe regroupe l''Allemagne nazie (Hitler), l''Italie fasciste (Mussolini) et le Japon impérial, liés par des accords militaires."},
      {"id":"q10","question":"Quand les bombes atomiques ont-elles été larguées sur le Japon ?","options":["Juin 1944","Mai 1945","Août 1945","Septembre 1945"],"correct":2,"explanation":"Les bombes atomiques ont été larguées sur Hiroshima (6 août 1945) et Nagasaki (9 août 1945), conduisant à la capitulation du Japon le 2 septembre 1945."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 2 : L''ONU et l''ordre mondial
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'onu-ordre-mondial', 2, 'L''ONU et l''ordre mondial d''après-guerre', 'Création, objectifs, organes, bilan de l''ONU', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'onu-ordre-mondial-fiche', 'L''ONU et l''ordre mondial d''après-guerre', 'Création, organes, institutions spécialisées et bilan', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Comment l''ONU a-t-elle été créée ?","answer":"L''ONU a été créée en plusieurs étapes : Charte de l''Atlantique (1941, Roosevelt-Churchill), Conférence de Téhéran (1943), Conférence de Dumbarton Oaks (1944, projet de charte), Conférence de Yalta (février 1945, accord sur le droit de véto), Conférence de Potsdam (juillet 1945). La Charte des Nations Unies est signée à San Francisco le 26 juin 1945 par 51 États fondateurs."},
      {"id":"fc2","category":"Définition","question":"Quels sont les objectifs de l''ONU ?","answer":"Les objectifs de l''ONU (Article 1 de la Charte) : 1) Maintenir la paix et la sécurité internationales. 2) Développer les relations amicales entre les nations. 3) Réaliser la coopération internationale (économique, sociale, culturelle, humanitaire). 4) Promouvoir le respect des droits de l''homme et des libertés fondamentales."},
      {"id":"fc3","category":"Définition","question":"Quels sont les principaux organes de l''ONU ?","answer":"Les 6 organes principaux : 1) Assemblée générale (193 États, un État = une voix). 2) Conseil de sécurité (15 membres dont 5 permanents avec droit de véto). 3) Secrétariat général (dirigé par le Secrétaire général). 4) Cour internationale de Justice (La Haye). 5) Conseil économique et social (ECOSOC). 6) Conseil de tutelle (suspendu depuis 1994)."},
      {"id":"fc4","category":"Définition","question":"Quelles sont les principales institutions spécialisées de l''ONU ?","answer":"Institutions spécialisées : UNESCO (éducation, science, culture), OMS (santé), FAO (alimentation, agriculture), UNICEF (enfance), HCR (réfugiés), OIT (travail), FMI (finances), Banque mondiale (développement), PNUD (développement). Chacune a son mandat spécifique et contribue à la coopération internationale dans son domaine."},
      {"id":"fc5","category":"Distinction","question":"Quels sont les succès et les limites de l''ONU ?","answer":"Succès : maintien de la paix dans certains conflits, décolonisation, promotion des droits de l''homme, aide humanitaire, coopération internationale. Limites : échec du désarmement nucléaire, multiplication des conflits locaux, blocage par le droit de véto, incapacité à prévenir certains génocides (Rwanda 1994), dépendance financière envers les grandes puissances."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que le droit de véto au Conseil de sécurité ?","answer":"Le droit de véto est le pouvoir dont disposent les 5 membres permanents du Conseil de sécurité (USA, Russie, Chine, France, Royaume-Uni) de bloquer toute résolution. Un seul véto suffit à empêcher l''adoption d''une résolution. Ce droit est critiqué car il paralyse parfois l''ONU (ex : conflit syrien) et crée une inégalité entre les États."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser le rôle d''une organisation internationale ?","answer":"Pour analyser le rôle d''une OI : 1) Contexte de création (pourquoi ?). 2) Objectifs (pour quoi ?). 3) Structure (comment ?). 4) Moyens d''action (avec quoi ?). 5) Bilan (succès et limites). 6) Réformes envisagées. Toujours confronter les objectifs affichés à la réalité des actions."},
      {"id":"fc8","category":"Exemple","question":"Quel rôle l''ONU joue-t-elle au Mali ?","answer":"L''ONU au Mali : la MINUSMA (Mission multidimensionnelle intégrée des Nations Unies pour la stabilisation au Mali) a été déployée en 2013 pour soutenir la paix et la sécurité après la crise de 2012. L''ONU intervient aussi via le PNUD (développement), l''UNICEF (enfance), la FAO (agriculture) et le HCR (réfugiés déplacés par le conflit du Nord)."}
    ],
    "schema": {
      "title": "L''ONU et l''ordre mondial",
      "nodes": [
        {"id":"n1","label":"ONU (1945)","type":"main"},
        {"id":"n2","label":"Création","type":"branch"},
        {"id":"n3","label":"Organes","type":"branch"},
        {"id":"n4","label":"Bilan","type":"branch"},
        {"id":"n5","label":"Conférences fondatrices","type":"leaf"},
        {"id":"n6","label":"Assemblée générale","type":"leaf"},
        {"id":"n7","label":"Conseil de sécurité (véto)","type":"leaf"},
        {"id":"n8","label":"Institutions spécialisées","type":"leaf"},
        {"id":"n9","label":"Succès : paix, décolonisation","type":"leaf"},
        {"id":"n10","label":"Limites : véto, conflits","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"origines"},
        {"from":"n1","to":"n3","label":"structure"},
        {"from":"n1","to":"n4","label":"évaluation"},
        {"from":"n2","to":"n5","label":"étapes"},
        {"from":"n3","to":"n6","label":"délibération"},
        {"from":"n3","to":"n7","label":"décision"},
        {"from":"n3","to":"n8","label":"coopération"},
        {"from":"n4","to":"n9","label":"réussites"},
        {"from":"n4","to":"n10","label":"échecs"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"En quelle année l''ONU a-t-elle été créée ?","options":["1919","1939","1945","1948"],"correct":2,"explanation":"L''ONU a été créée en 1945 par la signature de la Charte des Nations Unies à San Francisco le 26 juin 1945, entrée en vigueur le 24 octobre 1945."},
      {"id":"q2","question":"Combien de membres permanents compte le Conseil de sécurité ?","options":["3","5","10","15"],"correct":1,"explanation":"Le Conseil de sécurité compte 5 membres permanents avec droit de véto : États-Unis, Russie, Chine, France et Royaume-Uni, plus 10 membres non permanents élus pour 2 ans."},
      {"id":"q3","question":"Quel est le principal objectif de l''ONU ?","options":["Promouvoir le commerce mondial","Maintenir la paix et la sécurité internationales","Gérer les finances mondiales","Organiser les Jeux olympiques"],"correct":1,"explanation":"Le premier objectif de l''ONU est de maintenir la paix et la sécurité internationales, en prévenant les conflits et en facilitant leur résolution."},
      {"id":"q4","question":"Le droit de véto permet à un membre permanent de :","options":["Proposer une résolution","Bloquer toute résolution du Conseil de sécurité","Quitter l''ONU","Nommer le Secrétaire général"],"correct":1,"explanation":"Le droit de véto permet à chacun des 5 membres permanents de bloquer toute résolution du Conseil de sécurité, même si tous les autres membres sont d''accord."},
      {"id":"q5","question":"L''UNESCO est l''institution de l''ONU pour :","options":["La santé","L''éducation, la science et la culture","L''alimentation","Les réfugiés"],"correct":1,"explanation":"L''UNESCO (Organisation des Nations Unies pour l''éducation, la science et la culture) promeut la coopération dans ces domaines."},
      {"id":"q6","question":"Combien d''États ont signé la Charte de l''ONU à l''origine ?","options":["20","51","100","193"],"correct":1,"explanation":"51 États ont signé la Charte des Nations Unies lors de la Conférence de San Francisco en 1945. Aujourd''hui l''ONU compte 193 membres."},
      {"id":"q7","question":"Quelle mission de l''ONU a été déployée au Mali ?","options":["MINUSMA","FINUL","MONUSCO","MINUSTAH"],"correct":0,"explanation":"La MINUSMA (Mission multidimensionnelle intégrée des Nations Unies pour la stabilisation au Mali) a été déployée en 2013 pour soutenir la paix au Mali."},
      {"id":"q8","question":"La Cour internationale de Justice siège à :","options":["New York","Genève","La Haye","Paris"],"correct":2,"explanation":"La Cour internationale de Justice (CIJ), organe judiciaire principal de l''ONU, siège à La Haye aux Pays-Bas."},
      {"id":"q9","question":"Quelle conférence a décidé du droit de véto ?","options":["San Francisco","Dumbarton Oaks","Yalta","Téhéran"],"correct":2,"explanation":"La Conférence de Yalta (février 1945) a décidé du droit de véto des 5 grandes puissances au Conseil de sécurité."},
      {"id":"q10","question":"Quelle limite majeure de l''ONU est souvent critiquée ?","options":["Le nombre trop élevé de membres","Le blocage par le droit de véto qui paralyse les décisions","L''excès de financement","Le manque de langues officielles"],"correct":1,"explanation":"Le droit de véto est une limite majeure : il permet à une seule puissance de bloquer les résolutions, paralysant l''ONU face à certains conflits (ex : Syrie, Palestine)."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 3 : La division du monde et la fin des blocs
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'guerre-froide', 3, 'La division du monde et la fin des blocs', 'Guerre froide, coexistence pacifique et fin de la bipolarité', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'guerre-froide-fiche', 'La division du monde et la fin des blocs', 'Guerre froide, coexistence pacifique et dislocation du bloc communiste', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la guerre froide ?","answer":"La guerre froide (1947-1991) est la période de tension entre les deux superpuissances : les États-Unis (bloc occidental, capitaliste) et l''URSS (bloc communiste). Caractéristiques : confrontation idéologique, course aux armements nucléaires, guerres par procuration (Corée, Vietnam), mais pas d''affrontement direct. Le terme « froide » signifie qu''il n''y a pas eu de guerre ouverte entre les deux."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce que la coexistence pacifique ?","answer":"La coexistence pacifique est la politique adoptée après la mort de Staline (1953) et surtout sous Khrouchtchev, reconnaissant la nécessité de cohabiter sans guerre directe. Elle n''exclut pas les tensions (crise de Cuba 1962, guerre du Vietnam) mais accepte le statu quo et la négociation. Les accords SALT sur la limitation des armements illustrent cette politique."},
      {"id":"fc3","category":"Définition","question":"Comment le bloc communiste s''est-il effondré ?","answer":"L''effondrement du bloc communiste : 1) Crise économique des pays communistes (stagnation, pénuries). 2) Réformes de Gorbatchev en URSS : Glasnost (transparence) et Perestroïka (restructuration économique). 3) Chute du mur de Berlin (9 novembre 1989). 4) Dislocation des démocraties populaires d''Europe de l''Est. 5) Dissolution de l''URSS (25 décembre 1991)."},
      {"id":"fc4","category":"Distinction","question":"Quelles différences entre le bloc occidental et le bloc communiste ?","answer":"Bloc occidental (USA) : économie de marché capitaliste, démocratie libérale, pluralisme politique, OTAN (alliance militaire), Plan Marshall (aide économique). Bloc communiste (URSS) : économie planifiée, parti unique, Pacte de Varsovie (alliance militaire), CAEM/COMECON (coopération économique). Chacun dispose de l''arme nucléaire (dissuasion mutuelle)."},
      {"id":"fc5","category":"Exemple","question":"Quelles ont été les principales crises de la guerre froide ?","answer":"Principales crises : 1) Blocus de Berlin (1948-1949). 2) Guerre de Corée (1950-1953). 3) Crise de Suez (1956). 4) Construction du mur de Berlin (1961). 5) Crise des missiles de Cuba (1962, risque de guerre nucléaire). 6) Guerre du Vietnam (1955-1975). 7) Invasion de l''Afghanistan par l''URSS (1979). Chaque crise a failli dégénérer en conflit mondial."},
      {"id":"fc6","category":"Définition","question":"Qui est Gorbatchev et quel est son rôle ?","answer":"Mikhaïl Gorbatchev (né en 1931, mort en 2022) est le dernier dirigeant de l''URSS (1985-1991). Il a lancé la Glasnost (transparence politique, liberté d''expression) et la Perestroïka (restructuration de l''économie). Ces réformes ont accéléré l''effondrement du bloc communiste. Il a reçu le prix Nobel de la paix en 1990 pour sa contribution à la fin de la guerre froide."},
      {"id":"fc7","category":"Définition","question":"Qu''est-ce que la chute du mur de Berlin ?","answer":"Le mur de Berlin, construit en 1961 pour empêcher la fuite des Allemands de l''Est vers l''Ouest, est tombé le 9 novembre 1989 sous la pression populaire. C''est le symbole de la fin de la guerre froide et de la division de l''Europe. Il a conduit à la réunification de l''Allemagne (3 octobre 1990) et à la fin de la division du monde en deux blocs."},
      {"id":"fc8","category":"Méthode","question":"Comment analyser la guerre froide dans une dissertation ?","answer":"Plan possible : I. Les origines de la bipolarité (1945-1947) : méfiance, idéologies opposées. II. Les manifestations de la guerre froide : crises, course aux armements, guerres par procuration. III. La fin de la bipolarité : détente, réformes, effondrement du communisme. Toujours replacer les événements dans leur contexte et mobiliser des dates précises."}
    ],
    "schema": {
      "title": "La guerre froide et la fin des blocs",
      "nodes": [
        {"id":"n1","label":"Division du monde","type":"main"},
        {"id":"n2","label":"Guerre froide (1947-1991)","type":"branch"},
        {"id":"n3","label":"Coexistence pacifique","type":"branch"},
        {"id":"n4","label":"Fin des blocs","type":"branch"},
        {"id":"n5","label":"USA vs URSS","type":"leaf"},
        {"id":"n6","label":"Crises (Cuba, Berlin, Vietnam)","type":"leaf"},
        {"id":"n7","label":"Négociation (SALT)","type":"leaf"},
        {"id":"n8","label":"Gorbatchev : Glasnost, Perestroïka","type":"leaf"},
        {"id":"n9","label":"Chute du mur (1989)","type":"leaf"},
        {"id":"n10","label":"Dissolution URSS (1991)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"tension"},
        {"from":"n1","to":"n3","label":"détente"},
        {"from":"n1","to":"n4","label":"dénouement"},
        {"from":"n2","to":"n5","label":"bipolarité"},
        {"from":"n2","to":"n6","label":"conflits"},
        {"from":"n3","to":"n7","label":"diplomatie"},
        {"from":"n4","to":"n8","label":"réformes"},
        {"from":"n4","to":"n9","label":"symbole"},
        {"from":"n4","to":"n10","label":"fin"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La guerre froide oppose principalement :","options":["La France et l''Allemagne","Les USA et l''URSS","Le Japon et la Chine","L''Angleterre et la Russie"],"correct":1,"explanation":"La guerre froide (1947-1991) oppose les deux superpuissances : les États-Unis (bloc capitaliste occidental) et l''URSS (bloc communiste)."},
      {"id":"q2","question":"En quelle année le mur de Berlin est-il tombé ?","options":["1945","1961","1989","1991"],"correct":2,"explanation":"Le mur de Berlin est tombé le 9 novembre 1989, événement symbolique marquant la fin de la guerre froide."},
      {"id":"q3","question":"Que signifie « Perestroïka » ?","options":["Transparence","Restructuration économique","Révolution","Désarmement"],"correct":1,"explanation":"Perestroïka signifie « restructuration » : c''est la réforme économique lancée par Gorbatchev pour moderniser l''économie soviétique stagnante."},
      {"id":"q4","question":"Quelle crise a failli provoquer une guerre nucléaire en 1962 ?","options":["La crise de Suez","La crise de Cuba","La guerre de Corée","Le blocus de Berlin"],"correct":1,"explanation":"La crise des missiles de Cuba (octobre 1962) a été le moment le plus dangereux de la guerre froide, avec un risque réel de guerre nucléaire entre USA et URSS."},
      {"id":"q5","question":"L''URSS s''est dissoute en :","options":["1989","1990","1991","1993"],"correct":2,"explanation":"L''URSS s''est officiellement dissoute le 25 décembre 1991, marquant la fin définitive de la guerre froide et du bloc communiste."},
      {"id":"q6","question":"L''OTAN est l''alliance militaire du :","options":["Bloc communiste","Bloc occidental","Mouvement des non-alignés","Tiers-monde"],"correct":1,"explanation":"L''OTAN (Organisation du Traité de l''Atlantique Nord, 1949) est l''alliance militaire du bloc occidental, dirigée par les États-Unis."},
      {"id":"q7","question":"Que signifie « Glasnost » ?","options":["Restructuration","Transparence politique","Armement","Révolution"],"correct":1,"explanation":"Glasnost signifie « transparence » : c''est la politique de liberté d''expression et d''ouverture politique lancée par Gorbatchev en URSS."},
      {"id":"q8","question":"Quel prix Gorbatchev a-t-il reçu en 1990 ?","options":["Prix Nobel de littérature","Prix Nobel de la paix","Prix Nobel d''économie","Médaille Fields"],"correct":1,"explanation":"Mikhaïl Gorbatchev a reçu le prix Nobel de la paix en 1990 pour sa contribution à la fin de la guerre froide."},
      {"id":"q9","question":"La réunification de l''Allemagne a eu lieu en :","options":["1989","1990","1991","1945"],"correct":1,"explanation":"L''Allemagne a été officiellement réunifiée le 3 octobre 1990, un an après la chute du mur de Berlin."},
      {"id":"q10","question":"Le Pacte de Varsovie est l''alliance militaire du :","options":["Bloc occidental","Bloc communiste","Mouvement des non-alignés","Monde arabe"],"correct":1,"explanation":"Le Pacte de Varsovie (1955) est l''alliance militaire du bloc communiste dirigée par l''URSS, en réponse à l''OTAN du bloc occidental."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 4 : La décolonisation
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'decolonisation', 4, 'La décolonisation', 'Facteurs, décolonisation en Afrique, évolution politique du Mali', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'decolonisation-fiche', 'La décolonisation', 'Mise en cause du système colonial et indépendances africaines', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quels sont les facteurs de la décolonisation ?","answer":"Facteurs internes : montée du nationalisme, élites formées revendiquant l''indépendance, résistance populaire. Facteurs externes : affaiblissement des puissances coloniales par la guerre, Charte de l''ONU (droit des peuples à disposer d''eux-mêmes), pression des USA et de l''URSS (anticolonialistes), Conférence de Bandung (1955, solidarité des pays colonisés)."},
      {"id":"fc2","category":"Exemple","question":"Comment s''est déroulée la décolonisation de l''Algérie ?","answer":"L''Algérie, colonie française depuis 1830, a obtenu son indépendance après une guerre longue et violente (1954-1962). Le FLN (Front de Libération Nationale) a mené la lutte armée. Les accords d''Évian (18 mars 1962) ont mis fin au conflit. Le référendum du 1er juillet 1962 a confirmé l''indépendance. Le bilan : plus d''un million de morts, exode des pieds-noirs."},
      {"id":"fc3","category":"Définition","question":"Comment s''est déroulée la décolonisation de l''Afrique noire française ?","answer":"La décolonisation de l''Afrique noire française s''est faite progressivement et de manière relativement pacifique : 1) Loi-cadre Defferre (1956) : autonomie interne. 2) Référendum de 1958 : choix entre la Communauté française ou l''indépendance (seule la Guinée a voté non). 3) 1960 : année de l''Afrique, indépendance de 17 pays africains dont le Mali."},
      {"id":"fc4","category":"Exemple","question":"Quelle est l''évolution politique du Mali de 1946 à 1960 ?","answer":"1946 : création de l''Union Soudanaise-RDA (parti de Modibo Keïta, section du RDA). 1956 : Loi-cadre, autonomie interne. 1958 : le Soudan français vote oui au référendum et entre dans la Communauté française. 1959 : création de la Fédération du Mali (Soudan + Sénégal). 1960 : éclatement de la Fédération et proclamation de l''indépendance de la République du Mali (22 septembre 1960) sous Modibo Keïta."},
      {"id":"fc5","category":"Exemple","question":"Quelle est l''évolution politique du Mali de 1960 à nos jours ?","answer":"1960-1968 : Première République, Modibo Keïta (régime socialiste à parti unique). 1968-1991 : coup d''État de Moussa Traoré, dictature militaire. 1991 : révolution du 26 mars (Amadou Toumani Touré), transition démocratique. 1992-2012 : IIIe République démocratique (Alpha Oumar Konaré, ATT). 2012 : crise sécuritaire (rébellion au Nord, coup d''État). 2020 : nouveau coup d''État, transition en cours."},
      {"id":"fc6","category":"Exemple","question":"Comment s''est déroulée l''indépendance du Zimbabwe ?","answer":"La Rhodésie du Sud (actuel Zimbabwe), colonie britannique, a vu sa minorité blanche déclarer unilatéralement l''indépendance en 1965 (Ian Smith, régime d''apartheid). La lutte de libération armée (ZANU de Mugabe, ZAPU de Nkomo) et les sanctions internationales ont conduit aux accords de Lancaster House (1979). Le Zimbabwe est devenu indépendant en 1980 avec Robert Mugabe comme Premier ministre."},
      {"id":"fc7","category":"Exemple","question":"Comment l''Angola a-t-il obtenu son indépendance ?","answer":"L''Angola, colonie portugaise, a connu une longue guerre de libération (1961-1975) menée par trois mouvements : MPLA (soutenu par l''URSS et Cuba), FNLA et UNITA (soutenus par les USA et l''Afrique du Sud). L''indépendance a été proclamée le 11 novembre 1975 après la révolution des Œillets au Portugal (1974). Une guerre civile a suivi jusqu''en 2002."},
      {"id":"fc8","category":"Définition","question":"Qu''est-ce que le droit des peuples à disposer d''eux-mêmes ?","answer":"Le droit des peuples à disposer d''eux-mêmes est le principe selon lequel tout peuple a le droit de déterminer librement son statut politique et de poursuivre son développement économique, social et culturel. Ce principe, inscrit dans la Charte de l''ONU (1945), a fourni la base juridique des revendications indépendantistes en Afrique et en Asie."},
      {"id":"fc9","category":"Distinction","question":"Quelle différence entre décolonisation pacifique et violente ?","answer":"Décolonisation pacifique : négociation entre colonisateurs et nationalistes, transition progressive (cas de la plupart des colonies françaises d''Afrique noire). Décolonisation violente : guerre de libération armée (Algérie, Angola, Mozambique, Zimbabwe, Kenya). Les facteurs qui déterminent le type : présence de colons, intransigeance du colonisateur, radicalisation des nationalistes."},
      {"id":"fc10","category":"Méthode","question":"Comment traiter un sujet sur la décolonisation au bac ?","answer":"Plan possible : I. Les causes de la décolonisation (internes et externes). II. Les formes de la décolonisation (pacifique et violente, avec des exemples africains). III. Les conséquences et défis post-indépendance. Toujours inclure le Mali et l''Afrique dans l''analyse. Dates clés à connaître : Bandung 1955, Loi-cadre 1956, année 1960."}
    ],
    "schema": {
      "title": "La décolonisation en Afrique",
      "nodes": [
        {"id":"n1","label":"Décolonisation","type":"main"},
        {"id":"n2","label":"Facteurs","type":"branch"},
        {"id":"n3","label":"Afrique du Nord","type":"branch"},
        {"id":"n4","label":"Afrique noire","type":"branch"},
        {"id":"n5","label":"Internes : nationalisme","type":"leaf"},
        {"id":"n6","label":"Externes : ONU, Bandung","type":"leaf"},
        {"id":"n7","label":"Algérie (guerre 1954-62)","type":"leaf"},
        {"id":"n8","label":"Afrique française (1960)","type":"leaf"},
        {"id":"n9","label":"Mali : indépendance 22/09/1960","type":"leaf"},
        {"id":"n10","label":"Afrique lusophone (Angola)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"causes"},
        {"from":"n1","to":"n3","label":"violente"},
        {"from":"n1","to":"n4","label":"pacifique/violente"},
        {"from":"n2","to":"n5","label":"interne"},
        {"from":"n2","to":"n6","label":"externe"},
        {"from":"n3","to":"n7","label":"guerre"},
        {"from":"n4","to":"n8","label":"négociation"},
        {"from":"n4","to":"n9","label":"cas malien"},
        {"from":"n4","to":"n10","label":"guerre"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"En quelle année le Mali a-t-il obtenu son indépendance ?","options":["1958","1959","1960","1962"],"correct":2,"explanation":"Le Mali a proclamé son indépendance le 22 septembre 1960, après l''éclatement de la Fédération du Mali (Mali + Sénégal)."},
      {"id":"q2","question":"Qui est le premier président du Mali indépendant ?","options":["Moussa Traoré","Amadou Toumani Touré","Modibo Keïta","Alpha Oumar Konaré"],"correct":2,"explanation":"Modibo Keïta est le premier président de la République du Mali indépendant (1960-1968), leader de l''Union Soudanaise-RDA."},
      {"id":"q3","question":"La Conférence de Bandung (1955) a réuni :","options":["Les puissances coloniales","Les pays d''Afrique et d''Asie colonisés ou récemment indépendants","Les pays européens","Les membres de l''OTAN"],"correct":1,"explanation":"La Conférence de Bandung (1955, Indonésie) a réuni 29 pays d''Afrique et d''Asie pour affirmer la solidarité des peuples colonisés et revendiquer leur droit à l''indépendance."},
      {"id":"q4","question":"La Loi-cadre Defferre (1956) a accordé :","options":["L''indépendance immédiate","L''autonomie interne aux colonies","Le droit de vote aux femmes","La nationalité française aux colonisés"],"correct":1,"explanation":"La Loi-cadre Defferre (1956) a accordé l''autonomie interne aux colonies françaises d''Afrique, avec un gouvernement local élu, étape vers l''indépendance."},
      {"id":"q5","question":"L''indépendance de l''Algérie a été obtenue en :","options":["1954","1958","1960","1962"],"correct":3,"explanation":"L''Algérie est devenue indépendante en 1962 (accords d''Évian, 18 mars 1962 ; référendum d''autodétermination, 1er juillet 1962), après 8 ans de guerre (1954-1962)."},
      {"id":"q6","question":"1960 est appelée « l''année de l''Afrique » car :","options":["L''Afrique a été découverte","17 pays africains ont obtenu leur indépendance","La guerre froide a pris fin en Afrique","L''ONU a été créée"],"correct":1,"explanation":"L''année 1960 est appelée « l''année de l''Afrique » car 17 pays africains ont accédé à l''indépendance cette année-là."},
      {"id":"q7","question":"La révolution du 26 mars 1991 au Mali a mis fin au régime de :","options":["Modibo Keïta","Moussa Traoré","Alpha Oumar Konaré","Amadou Toumani Touré"],"correct":1,"explanation":"La révolution populaire du 26 mars 1991 a renversé la dictature militaire de Moussa Traoré (au pouvoir depuis 1968), ouvrant la voie à la démocratie."},
      {"id":"q8","question":"Le Zimbabwe (ex-Rhodésie du Sud) est devenu indépendant en :","options":["1960","1975","1980","1990"],"correct":2,"explanation":"Le Zimbabwe est devenu indépendant en 1980, après les accords de Lancaster House (1979) qui ont mis fin au régime de la minorité blanche de Ian Smith."},
      {"id":"q9","question":"Quel pays d''Afrique noire française a voté non au référendum de 1958 ?","options":["Le Sénégal","Le Mali","La Guinée","La Côte d''Ivoire"],"correct":2,"explanation":"La Guinée de Sékou Touré est le seul pays d''Afrique noire française à avoir voté non au référendum de 1958, obtenant ainsi son indépendance immédiate."},
      {"id":"q10","question":"L''Angola, colonie de quel pays, est devenu indépendant en 1975 ?","options":["France","Angleterre","Portugal","Espagne"],"correct":2,"explanation":"L''Angola était une colonie portugaise. Son indépendance a été proclamée le 11 novembre 1975, après la révolution des Œillets au Portugal (1974)."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 5 : La notion de civilisation et son évolution
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'notion-civilisation', 5, 'La notion de civilisation et son évolution', 'Afrique Noire : religion traditionnelle, Islam, Christianisme, panafricanisme', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'notion-civilisation-fiche', 'La notion de civilisation et son évolution', 'Religions, Islam, Christianisme et panafricanisme en Afrique Noire', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une civilisation ?","answer":"Une civilisation est un ensemble de traits culturels, techniques, religieux, artistiques et sociaux qui caractérisent une société à une époque donnée. Elle se manifeste par la langue, la religion, l''art, l''organisation politique et sociale, les techniques et les valeurs morales. Le mot vient du latin « civilis » (citoyen, citadin)."},
      {"id":"fc2","category":"Exemple","question":"Quelles sont les caractéristiques de la religion traditionnelle africaine ?","answer":"La religion traditionnelle africaine se caractérise par : le culte des ancêtres (les morts protègent les vivants), l''animisme (forces spirituelles dans la nature), le rôle des devins et guérisseurs, les rites d''initiation, les sacrifices et offrandes, la croyance en un Dieu suprême créateur (Amma chez les Dogon, Maa Ngala chez les Bambara). Elle structure la vie communautaire."},
      {"id":"fc3","category":"Exemple","question":"Comment l''Islam s''est-il diffusé en Afrique Noire ?","answer":"L''Islam s''est diffusé en Afrique Noire par : 1) Le commerce transsaharien (marchands arabes et berbères, VIIIe-Xe siècle). 2) Les confréries soufies (Tidjaniya, Qadiriya). 3) Les empires musulmans (Ghana, Mali, Songhaï). 4) Le djihad (El Hadj Omar Tall au XIXe siècle). L''Islam s''est adapté aux réalités locales, créant un islam syncrétique en Afrique de l''Ouest."},
      {"id":"fc4","category":"Exemple","question":"Comment le Christianisme s''est-il implanté en Afrique ?","answer":"Le Christianisme s''est implanté en Afrique par : 1) L''Éthiopie (IVe siècle, christianisme copte). 2) La colonisation européenne (XVe-XXe siècle) avec les missionnaires catholiques et protestants. 3) L''évangélisation accompagnait souvent la colonisation (écoles, hôpitaux). 4) Aujourd''hui, les Églises africaines indépendantes (kimbanguisme, harrisme) adaptent le christianisme aux cultures locales."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que le panafricanisme ?","answer":"Le panafricanisme est un mouvement politique et culturel qui vise l''unité et la solidarité des peuples africains et de la diaspora. Précurseurs : W.E.B. Du Bois, Marcus Garvey, George Padmore. En Afrique : Kwame Nkrumah (Ghana), Modibo Keïta (Mali). Il a conduit à la création de l''OUA (1963, Addis-Abeba) puis de l''Union Africaine (2002)."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre panafricanisme et négritude ?","answer":"Le panafricanisme est un mouvement politique visant l''unité des peuples africains et la libération du continent. La négritude est un mouvement littéraire et culturel (Senghor, Césaire, Damas) qui valorise l''identité noire et la civilisation africaine face à l''assimilation coloniale. Les deux se complètent : la négritude nourrit la conscience africaine, le panafricanisme traduit cette conscience en action politique."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser l''évolution d''une civilisation ?","answer":"Pour analyser l''évolution d''une civilisation : 1) Identifier les fondements (géographie, économie, croyances). 2) Repérer les apports extérieurs (contacts, échanges, conquêtes). 3) Analyser les transformations (acculturation, syncrétisme). 4) Évaluer la permanence des traits culturels. 5) Étudier les résistances et adaptations. Toujours éviter l''ethnocentrisme."},
      {"id":"fc8","category":"Exemple","question":"Qu''est-ce que le syncrétisme religieux en Afrique ?","answer":"Le syncrétisme religieux est la fusion d''éléments de différentes religions. En Afrique, il se manifeste par : les pratiques traditionnelles intégrées à l''Islam (maraboutage, amulettes coraniques), le vaudou (mélange de traditions africaines et catholicisme en Haïti/Bénin), les Églises africaines indépendantes mêlant christianisme et traditions locales. Ce phénomène témoigne de la capacité d''adaptation des cultures africaines."}
    ],
    "schema": {
      "title": "Civilisation et évolution en Afrique Noire",
      "nodes": [
        {"id":"n1","label":"Civilisation africaine","type":"main"},
        {"id":"n2","label":"Religion traditionnelle","type":"branch"},
        {"id":"n3","label":"Islam en Afrique","type":"branch"},
        {"id":"n4","label":"Christianisme","type":"branch"},
        {"id":"n5","label":"Panafricanisme","type":"branch"},
        {"id":"n6","label":"Animisme, ancêtres","type":"leaf"},
        {"id":"n7","label":"Commerce, confréries","type":"leaf"},
        {"id":"n8","label":"Missionnaires, colonisation","type":"leaf"},
        {"id":"n9","label":"OUA → Union Africaine","type":"leaf"},
        {"id":"n10","label":"Syncrétisme","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"fondement"},
        {"from":"n1","to":"n3","label":"VIIIe siècle"},
        {"from":"n1","to":"n4","label":"XVe siècle"},
        {"from":"n1","to":"n5","label":"XXe siècle"},
        {"from":"n2","to":"n6","label":"croyances"},
        {"from":"n3","to":"n7","label":"diffusion"},
        {"from":"n4","to":"n8","label":"implantation"},
        {"from":"n5","to":"n9","label":"institutions"},
        {"from":"n2","to":"n10","label":"adaptation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel est le fondement principal de la religion traditionnelle africaine ?","options":["Le monothéisme strict","Le culte des ancêtres et l''animisme","Le polythéisme grec","Le bouddhisme"],"correct":1,"explanation":"La religion traditionnelle africaine repose sur le culte des ancêtres (les morts protègent les vivants) et l''animisme (forces spirituelles présentes dans la nature)."},
      {"id":"q2","question":"Par quelle voie principale l''Islam s''est-il diffusé en Afrique de l''Ouest ?","options":["Les croisades","Le commerce transsaharien","La colonisation européenne","Les guerres mondiales"],"correct":1,"explanation":"L''Islam s''est diffusé en Afrique de l''Ouest principalement par le commerce transsaharien (marchands arabes et berbères) à partir du VIIIe siècle."},
      {"id":"q3","question":"Qui est considéré comme un père du panafricanisme ?","options":["Léopold Sédar Senghor","W.E.B. Du Bois","Albert Camus","Karl Marx"],"correct":1,"explanation":"W.E.B. Du Bois est considéré comme un père du panafricanisme. Il a organisé plusieurs congrès panafricains au début du XXe siècle pour promouvoir l''unité des peuples noirs."},
      {"id":"q4","question":"L''Organisation de l''Unité Africaine (OUA) a été créée en :","options":["1945","1955","1963","1975"],"correct":2,"explanation":"L''OUA a été créée le 25 mai 1963 à Addis-Abeba (Éthiopie) par 32 États africains indépendants, pour promouvoir l''unité et la solidarité africaines."},
      {"id":"q5","question":"Le syncrétisme religieux désigne :","options":["Le rejet de toute religion","La fusion d''éléments de différentes religions","La conversion forcée","L''athéisme"],"correct":1,"explanation":"Le syncrétisme religieux est la fusion d''éléments de différentes religions. En Afrique, il se manifeste par le mélange de pratiques traditionnelles avec l''Islam ou le Christianisme."},
      {"id":"q6","question":"Quel empire africain a favorisé la diffusion de l''Islam en Afrique de l''Ouest ?","options":["L''Empire romain","L''Empire du Mali","L''Empire ottoman","L''Empire britannique"],"correct":1,"explanation":"L''Empire du Mali (XIIIe-XVe siècle), sous Soundjata Keïta puis Mansa Moussa, a favorisé la diffusion de l''Islam en Afrique de l''Ouest, notamment par le pèlerinage de Mansa Moussa à La Mecque (1324)."},
      {"id":"q7","question":"La négritude est un mouvement :","options":["Politique et militaire","Littéraire et culturel","Économique","Sportif"],"correct":1,"explanation":"La négritude est un mouvement littéraire et culturel fondé par Senghor, Césaire et Damas dans les années 1930, valorisant l''identité et la culture noires face à l''assimilation coloniale."},
      {"id":"q8","question":"L''Union Africaine a remplacé l''OUA en :","options":["1999","2000","2002","2005"],"correct":2,"explanation":"L''Union Africaine (UA) a remplacé l''OUA en 2002, avec des objectifs élargis : intégration économique, gouvernance démocratique, paix et sécurité, et développement durable du continent."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 6 : L''Afrique Noire contemporaine
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'afrique-noire-contemporaine', 6, 'L''Afrique Noire contemporaine', 'Union Africaine, problèmes politiques, économiques, socioculturels, monde islamique', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'afrique-noire-contemporaine-fiche', 'L''Afrique Noire contemporaine', 'Défis politiques, économiques et socioculturels de l''Afrique actuelle', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''Union Africaine (UA) ?","answer":"L''Union Africaine est une organisation continentale créée en 2002 (succédant à l''OUA de 1963). Elle regroupe 55 États membres. Ses organes : Conférence des chefs d''État, Commission de l''UA (Addis-Abeba), Parlement panafricain, Conseil de paix et de sécurité. Objectifs : intégration politique et économique, paix, démocratie, développement durable."},
      {"id":"fc2","category":"Exemple","question":"Quels sont les principaux problèmes politiques de l''Afrique contemporaine ?","answer":"Les problèmes politiques : 1) Instabilité politique (coups d''État : Mali 2012, 2020, 2021). 2) Conflits armés (terrorisme au Sahel, guerres civiles). 3) Faiblesse de la démocratie (élections contestées, autoritarisme). 4) Corruption et mauvaise gouvernance. 5) Frontières héritées de la colonisation (sources de tensions ethniques). 6) Ingérence des puissances étrangères."},
      {"id":"fc3","category":"Exemple","question":"Quels sont les problèmes économiques de l''Afrique ?","answer":"Les problèmes économiques : 1) Dépendance aux matières premières (pétrole, or, coton). 2) Dette extérieure élevée. 3) Faible industrialisation. 4) Échanges inégaux avec les pays développés. 5) Pauvreté de masse (plus de 40 % sous le seuil de pauvreté). 6) Chômage des jeunes. 7) Insuffisance des infrastructures (routes, énergie, télécommunications)."},
      {"id":"fc4","category":"Exemple","question":"Quels sont les défis socioculturels de l''Afrique ?","answer":"Les défis socioculturels : 1) Forte croissance démographique (doublement prévu d''ici 2050). 2) Urbanisation rapide et désordonnée. 3) Systèmes éducatifs insuffisants. 4) Problèmes de santé (paludisme, VIH/SIDA). 5) Exode rural et émigration des jeunes. 6) Menaces sur les langues et cultures locales. 7) Inégalités de genre."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que le NEPAD ?","answer":"Le NEPAD (Nouveau Partenariat pour le Développement de l''Afrique) est un programme de l''Union Africaine adopté en 2001. Objectifs : éradiquer la pauvreté, promouvoir la croissance durable, intégrer l''Afrique dans l''économie mondiale. Priorités : agriculture, infrastructures, éducation, santé, environnement, TIC, gouvernance. Renommé AUDA-NEPAD en 2018."},
      {"id":"fc6","category":"Exemple","question":"Quel est le rôle du monde islamique en Afrique ?","answer":"Le monde islamique en Afrique : 1) L''Islam est la religion majoritaire en Afrique du Nord et au Sahel. 2) Organisations : Organisation de la Coopération Islamique (OCI), Banque Islamique de Développement. 3) Financement de mosquées, écoles coraniques (médersas). 4) Défis : montée de l''islamisme radical (Boko Haram, AQMI, JNIM). 5) Dialogue interreligieux nécessaire pour la paix."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser les défis d''un continent ?","answer":"Méthode d''analyse : 1) Identifier les causes historiques (colonisation, traite). 2) Distinguer les facteurs internes (gouvernance, corruption) et externes (néocolonialisme, mondialisation). 3) Analyser les dimensions politique, économique, sociale et culturelle. 4) Repérer les solutions envisagées et les progrès réalisés. 5) Utiliser des données chiffrées pour étayer l''analyse."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre l''OUA et l''Union Africaine ?","answer":"L''OUA (1963-2002) : principe de non-ingérence, respect des frontières coloniales, lutte pour la décolonisation et l''apartheid. L''UA (depuis 2002) : droit d''intervention dans les crises graves (génocide, crimes de guerre), promotion de la démocratie, intégration économique (ZLECAf), Conseil de paix et de sécurité. L''UA a une vision plus ambitieuse et interventionniste."}
    ],
    "schema": {
      "title": "L''Afrique Noire contemporaine",
      "nodes": [
        {"id":"n1","label":"Afrique contemporaine","type":"main"},
        {"id":"n2","label":"Union Africaine","type":"branch"},
        {"id":"n3","label":"Problèmes politiques","type":"branch"},
        {"id":"n4","label":"Problèmes économiques","type":"branch"},
        {"id":"n5","label":"Défis socioculturels","type":"branch"},
        {"id":"n6","label":"OUA → UA (2002)","type":"leaf"},
        {"id":"n7","label":"Instabilité, terrorisme","type":"leaf"},
        {"id":"n8","label":"Dépendance, dette","type":"leaf"},
        {"id":"n9","label":"Démographie, santé","type":"leaf"},
        {"id":"n10","label":"Monde islamique","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"institution"},
        {"from":"n1","to":"n3","label":"politique"},
        {"from":"n1","to":"n4","label":"économie"},
        {"from":"n1","to":"n5","label":"société"},
        {"from":"n2","to":"n6","label":"évolution"},
        {"from":"n3","to":"n7","label":"manifestations"},
        {"from":"n4","to":"n8","label":"caractéristiques"},
        {"from":"n5","to":"n9","label":"enjeux"},
        {"from":"n1","to":"n10","label":"influence"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"En quelle année l''Union Africaine a-t-elle été créée ?","options":["1963","1999","2002","2010"],"correct":2,"explanation":"L''Union Africaine a été créée en 2002, succédant à l''OUA fondée en 1963. Son siège est à Addis-Abeba, Éthiopie."},
      {"id":"q2","question":"Combien d''États membres compte l''Union Africaine ?","options":["32","45","55","60"],"correct":2,"explanation":"L''Union Africaine compte 55 États membres, soit tous les pays du continent africain."},
      {"id":"q3","question":"Quel est le principal problème économique de l''Afrique ?","options":["L''excès d''industrialisation","La dépendance aux matières premières","Le surplus commercial","La surproduction agricole"],"correct":1,"explanation":"La dépendance aux matières premières (pétrole, minerais, produits agricoles) rend les économies africaines vulnérables aux fluctuations des prix mondiaux."},
      {"id":"q4","question":"Que signifie NEPAD ?","options":["Nouveau Partenariat pour le Développement de l''Afrique","Nations Européennes Pour l''Aide au Développement","Nouvelle Économie Pour l''Afrique Démocratique","Nouveau Engagement Politique Africain Durable"],"correct":0,"explanation":"Le NEPAD (Nouveau Partenariat pour le Développement de l''Afrique) est un programme de l''UA adopté en 2001 pour promouvoir la croissance et le développement durables en Afrique."},
      {"id":"q5","question":"Quel groupe terroriste sévit au Sahel ?","options":["Hezbollah","AQMI/JNIM","IRA","ETA"],"correct":1,"explanation":"AQMI (Al-Qaïda au Maghreb Islamique) et le JNIM (Groupe de soutien à l''Islam et aux musulmans) sont les principaux groupes terroristes actifs au Sahel, menaçant la sécurité du Mali et des pays voisins."},
      {"id":"q6","question":"La ZLECAf est :","options":["Une zone militaire","La Zone de Libre-Échange Continentale Africaine","Un programme éducatif","Une organisation sportive"],"correct":1,"explanation":"La ZLECAf (Zone de Libre-Échange Continentale Africaine), entrée en vigueur en 2021, vise à créer un marché unique africain pour stimuler le commerce intra-africain et l''industrialisation."},
      {"id":"q7","question":"Quelle différence majeure existe entre l''OUA et l''UA ?","options":["L''UA a moins de membres","L''UA reconnaît le droit d''intervention dans les crises graves","L''OUA était plus interventionniste","L''UA ne s''occupe pas de paix"],"correct":1,"explanation":"Contrairement à l''OUA qui respectait strictement la non-ingérence, l''UA reconnaît le droit d''intervention dans les États membres en cas de génocide, crimes de guerre ou crimes contre l''humanité."},
      {"id":"q8","question":"Quel est le principal défi démographique de l''Afrique ?","options":["Le vieillissement de la population","La forte croissance démographique","La baisse de la natalité","L''émigration massive vers l''Europe"],"correct":1,"explanation":"La forte croissance démographique (environ 2,5 % par an) est un défi majeur : la population africaine devrait doubler d''ici 2050, nécessitant des investissements massifs en éducation, santé et emploi."}
    ]
  }');

  -- ============================================================
  -- HISTOIRE - Chapitre 7 : Le monde occidental et la civilisation universelle
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (histoire_id, 'monde-occidental-civilisation', 7, 'Le monde occidental et la civilisation universelle', 'Héritage gréco-romain, christianisme, rationalisme, démocratie', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'monde-occidental-civilisation-fiche', 'Le monde occidental et la civilisation universelle', 'Héritage gréco-romain, christianisme, Lumières et démocratie', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''héritage gréco-romain ?","answer":"L''héritage gréco-romain désigne l''ensemble des apports de la Grèce antique et de Rome à la civilisation occidentale : la philosophie (Socrate, Platon, Aristote), la démocratie athénienne, le droit romain, l''art et l''architecture (colonnes, amphithéâtres), la littérature (Homère, Virgile), les sciences (Euclide, Archimède). Cet héritage constitue le socle de la pensée occidentale."},
      {"id":"fc2","category":"Exemple","question":"Quel est le rôle du christianisme dans la civilisation occidentale ?","answer":"Le christianisme a façonné la civilisation occidentale par : 1) Les valeurs morales (amour du prochain, dignité humaine, égalité devant Dieu). 2) L''organisation sociale (paroisses, diocèses). 3) L''art (cathédrales, peinture religieuse). 4) L''éducation (universités médiévales créées par l''Église). 5) Le calendrier (ère chrétienne). 6) Le droit (influence sur la législation). Il est devenu religion d''État de Rome en 380."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que le rationalisme ?","answer":"Le rationalisme est un courant philosophique qui fait de la raison la source principale de la connaissance. Développé par Descartes (XVIIe siècle, « Je pense, donc je suis »), il s''oppose à l''empirisme. Les Lumières (XVIIIe siècle : Voltaire, Montesquieu, Rousseau, Diderot) ont étendu le rationalisme à tous les domaines : politique, religion, sciences, société. La raison devient l''outil de progrès et d''émancipation."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que la démocratie occidentale ?","answer":"La démocratie occidentale repose sur : 1) La souveraineté du peuple. 2) La séparation des pouvoirs (Montesquieu : législatif, exécutif, judiciaire). 3) Les droits de l''homme (Déclaration de 1789). 4) Le suffrage universel. 5) Le pluralisme politique. 6) L''État de droit. Ses origines : démocratie athénienne (Ve siècle av. J.-C.), Magna Carta (1215), révolutions américaine (1776) et française (1789)."},
      {"id":"fc5","category":"Distinction","question":"Peut-on parler d''une civilisation universelle ?","answer":"Arguments pour : les droits de l''homme sont universels, la science est universelle, la mondialisation uniformise les modes de vie. Arguments contre : l''universalisme masque parfois l''impérialisme occidental, chaque civilisation a ses valeurs propres (relativisme culturel), le « choc des civilisations » (Huntington) montre les résistances. La civilisation universelle serait un dialogue entre civilisations, pas l''imposition d''un modèle unique."},
      {"id":"fc6","category":"Exemple","question":"Quelles sont les grandes révolutions qui ont fondé la démocratie moderne ?","answer":"Les révolutions fondatrices : 1) Révolution anglaise (1688, « Glorieuse Révolution » : monarchie parlementaire, Bill of Rights). 2) Révolution américaine (1776, Déclaration d''indépendance, Constitution de 1787). 3) Révolution française (1789, Déclaration des droits de l''homme et du citoyen, abolition des privilèges). Ces révolutions ont établi les principes de liberté, égalité et souveraineté populaire."},
      {"id":"fc7","category":"Méthode","question":"Comment comparer deux civilisations ?","answer":"Méthode de comparaison : 1) Situer chaque civilisation dans son contexte géographique et historique. 2) Identifier les fondements (religion, philosophie, organisation sociale). 3) Analyser les apports (art, sciences, techniques, droit). 4) Repérer les échanges et influences mutuelles. 5) Éviter l''ethnocentrisme : ne pas juger une civilisation à l''aune d''une autre. 6) Chercher les points communs et les différences."},
      {"id":"fc8","category":"Exemple","question":"Quels sont les apports de la Renaissance à la civilisation occidentale ?","answer":"La Renaissance (XVe-XVIe siècle) a apporté : 1) L''humanisme (l''homme au centre, Érasme, Montaigne). 2) Le renouveau artistique (Léonard de Vinci, Michel-Ange, Raphaël). 3) Les grandes découvertes (Christophe Colomb, Vasco de Gama). 4) L''imprimerie (Gutenberg, 1450). 5) La réforme protestante (Luther, Calvin). 6) Le développement des sciences (Copernic, Galilée). Elle marque le passage du Moyen Âge à l''époque moderne."}
    ],
    "schema": {
      "title": "Monde occidental et civilisation universelle",
      "nodes": [
        {"id":"n1","label":"Civilisation occidentale","type":"main"},
        {"id":"n2","label":"Héritage gréco-romain","type":"branch"},
        {"id":"n3","label":"Christianisme","type":"branch"},
        {"id":"n4","label":"Rationalisme / Lumières","type":"branch"},
        {"id":"n5","label":"Démocratie","type":"branch"},
        {"id":"n6","label":"Philosophie, droit, art","type":"leaf"},
        {"id":"n7","label":"Valeurs, Église, éducation","type":"leaf"},
        {"id":"n8","label":"Descartes, Voltaire","type":"leaf"},
        {"id":"n9","label":"Droits de l''homme, suffrage","type":"leaf"},
        {"id":"n10","label":"Civilisation universelle ?","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"Antiquité"},
        {"from":"n1","to":"n3","label":"Moyen Âge"},
        {"from":"n1","to":"n4","label":"XVIIe-XVIIIe"},
        {"from":"n1","to":"n5","label":"modernité"},
        {"from":"n2","to":"n6","label":"apports"},
        {"from":"n3","to":"n7","label":"influence"},
        {"from":"n4","to":"n8","label":"penseurs"},
        {"from":"n5","to":"n9","label":"principes"},
        {"from":"n5","to":"n10","label":"débat"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quel philosophe grec est considéré comme le père de la démocratie ?","options":["Aristote","Platon","Périclès","Socrate"],"correct":2,"explanation":"Périclès (Ve siècle av. J.-C.) est considéré comme le père de la démocratie athénienne. Sous son gouvernement, Athènes a connu l''apogée de la démocratie directe."},
      {"id":"q2","question":"La Déclaration des droits de l''homme et du citoyen date de :","options":["1776","1789","1815","1848"],"correct":1,"explanation":"La Déclaration des droits de l''homme et du citoyen a été adoptée le 26 août 1789 par l''Assemblée nationale constituante française, proclamant les droits naturels et imprescriptibles de l''homme."},
      {"id":"q3","question":"Le rationalisme de Descartes se résume par :","options":["« L''homme est un loup pour l''homme »","« Je pense, donc je suis »","« L''État, c''est moi »","« Connais-toi toi-même »"],"correct":1,"explanation":"« Je pense, donc je suis » (Cogito ergo sum) est le principe fondamental du rationalisme cartésien : la pensée est la première certitude indubitable, fondement de toute connaissance."},
      {"id":"q4","question":"La séparation des pouvoirs a été théorisée par :","options":["Voltaire","Rousseau","Montesquieu","Diderot"],"correct":2,"explanation":"Montesquieu a théorisé la séparation des pouvoirs (législatif, exécutif, judiciaire) dans « De l''esprit des lois » (1748), principe fondamental de la démocratie moderne."},
      {"id":"q5","question":"Le christianisme est devenu religion d''État de Rome en :","options":["313","380","476","800"],"correct":1,"explanation":"Le christianisme est devenu religion d''État de l''Empire romain en 380, par l''édit de Thessalonique de l''empereur Théodose Ier, interdisant les cultes païens."},
      {"id":"q6","question":"L''humanisme de la Renaissance place au centre :","options":["Dieu","L''État","L''homme","La nature"],"correct":2,"explanation":"L''humanisme de la Renaissance place l''homme au centre de ses préoccupations, valorisant la raison, l''éducation, la dignité humaine et la connaissance, en rupture avec la vision théocentrique du Moyen Âge."},
      {"id":"q7","question":"La thèse du « choc des civilisations » est de :","options":["Francis Fukuyama","Samuel Huntington","Karl Marx","Max Weber"],"correct":1,"explanation":"Samuel Huntington a développé la thèse du « choc des civilisations » (1996), affirmant que les futurs conflits mondiaux seraient culturels et religieux plutôt qu''idéologiques ou économiques."},
      {"id":"q8","question":"Quelle révolution a établi la monarchie parlementaire en Angleterre ?","options":["La Révolution française","La Révolution américaine","La Glorieuse Révolution (1688)","La Révolution industrielle"],"correct":2,"explanation":"La Glorieuse Révolution de 1688 en Angleterre a établi la monarchie parlementaire et le Bill of Rights (1689), limitant les pouvoirs du roi et garantissant les droits du Parlement et des citoyens."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 1 : Le Mali
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'le-mali', 1, 'Le Mali', 'Relief, climat, population, économie, place en Afrique et dans le monde', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'le-mali-fiche', 'Le Mali', 'Relief, climat, population, économie et place dans le monde', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelle est la situation géographique du Mali ?","answer":"Le Mali est un pays enclavé d''Afrique de l''Ouest, couvrant 1 241 238 km². Il est bordé par 7 pays : Algérie (nord), Niger (est), Burkina Faso et Côte d''Ivoire (sud), Guinée et Sénégal (ouest), Mauritanie (nord-ouest). Capitale : Bamako. Le pays est traversé par deux grands fleuves : le Niger (4 200 km) et le Sénégal."},
      {"id":"fc2","category":"Définition","question":"Quels sont les grands ensembles du relief malien ?","answer":"Le relief du Mali comprend : 1) La zone saharienne au nord (désert, plateaux gréseux : Adrar des Ifoghas). 2) La zone sahélienne au centre (plaines, savane sèche). 3) La zone soudanienne au sud (savane, collines). 4) Le delta intérieur du Niger (zone inondable fertile). 5) La falaise de Bandiagara (pays dogon). Le point culminant est le mont Hombori Tondo (1 155 m)."},
      {"id":"fc3","category":"Définition","question":"Quels sont les climats du Mali ?","answer":"Le Mali connaît trois zones climatiques : 1) Climat saharien (nord) : très aride, moins de 200 mm de pluie/an, températures extrêmes. 2) Climat sahélien (centre) : semi-aride, 200-600 mm de pluie, une saison des pluies courte. 3) Climat soudanien (sud) : 600-1 200 mm de pluie, une saison des pluies de juin à octobre. Le Mali subit les effets de la désertification et du changement climatique."},
      {"id":"fc4","category":"Exemple","question":"Quelle est la composition de la population malienne ?","answer":"La population du Mali est d''environ 22 millions d''habitants (2023), avec un taux de croissance de 3 % par an. Ethnies principales : Bambara (33 %), Peul/Fulani (14 %), Sénoufo (10 %), Soninké (10 %), Dogon (8 %), Songhaï, Touareg, Maure. Religion : Islam (95 %), christianisme (2 %), animisme (3 %). La population est jeune (50 % a moins de 15 ans) et majoritairement rurale."},
      {"id":"fc5","category":"Exemple","question":"Quels sont les secteurs de l''économie malienne ?","answer":"L''économie malienne repose sur : 1) Agriculture (40 % du PIB) : coton (premier producteur africain), riz, mil, sorgho, arachide. 2) Élevage (important au Sahel : bovins, ovins, caprins). 3) Mines : or (3e producteur africain), phosphates. 4) Pêche (delta du Niger). 5) Commerce et services. Le Mali est classé parmi les PMA (Pays les Moins Avancés) avec un PIB par habitant faible."},
      {"id":"fc6","category":"Distinction","question":"Quels sont les atouts et contraintes du Mali ?","answer":"Atouts : richesses minières (or), potentiel agricole (Niger, delta intérieur), jeunesse de la population, richesse culturelle. Contraintes : enclavement (pas d''accès à la mer), climat aride au nord, désertification, dépendance aux matières premières, insuffisance des infrastructures, instabilité sécuritaire au nord, faible couverture sanitaire et éducative."},
      {"id":"fc7","category":"Exemple","question":"Quelle est la place du Mali en Afrique ?","answer":"Le Mali en Afrique : membre de l''Union Africaine, de la CEDEAO (suspendu depuis 2022), de l''UEMOA. Il fait partie de l''Alliance des États du Sahel (AES) avec le Burkina Faso et le Niger. Le Mali est un acteur culturel majeur (musique, artisanat, festivals). Il est aussi au cœur des enjeux sécuritaires du Sahel (lutte contre le terrorisme)."},
      {"id":"fc8","category":"Méthode","question":"Comment faire une étude géographique d''un pays ?","answer":"Méthode d''étude géographique : 1) Localisation et situation (continent, voisins, superficie). 2) Milieu naturel (relief, climat, hydrographie, végétation). 3) Population (effectif, répartition, composition, dynamique). 4) Activités économiques (agriculture, industrie, services). 5) Organisation du territoire (villes, réseaux, inégalités régionales). 6) Place dans le monde (intégration régionale et mondiale)."}
    ],
    "schema": {
      "title": "Le Mali : géographie",
      "nodes": [
        {"id":"n1","label":"Le Mali","type":"main"},
        {"id":"n2","label":"Milieu naturel","type":"branch"},
        {"id":"n3","label":"Population","type":"branch"},
        {"id":"n4","label":"Économie","type":"branch"},
        {"id":"n5","label":"Relief : Sahara, Sahel, Soudan","type":"leaf"},
        {"id":"n6","label":"Climat : 3 zones","type":"leaf"},
        {"id":"n7","label":"22 M hab, jeune, diverse","type":"leaf"},
        {"id":"n8","label":"Agriculture, or, élevage","type":"leaf"},
        {"id":"n9","label":"Place en Afrique (UA, CEDEAO)","type":"leaf"},
        {"id":"n10","label":"Enclavement, défis","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"physique"},
        {"from":"n1","to":"n3","label":"humaine"},
        {"from":"n1","to":"n4","label":"secteurs"},
        {"from":"n2","to":"n5","label":"formes"},
        {"from":"n2","to":"n6","label":"types"},
        {"from":"n3","to":"n7","label":"caractéristiques"},
        {"from":"n4","to":"n8","label":"ressources"},
        {"from":"n1","to":"n9","label":"intégration"},
        {"from":"n1","to":"n10","label":"contraintes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la superficie du Mali ?","options":["240 000 km²","640 000 km²","1 241 238 km²","2 500 000 km²"],"correct":2,"explanation":"Le Mali couvre 1 241 238 km², ce qui en fait le plus grand pays d''Afrique de l''Ouest et l''un des plus vastes du continent."},
      {"id":"q2","question":"Quel fleuve traverse le Mali sur 1 700 km ?","options":["Le Congo","Le Nil","Le Niger","Le Sénégal"],"correct":2,"explanation":"Le fleuve Niger traverse le Mali sur environ 1 700 km, formant le delta intérieur du Niger, zone fertile essentielle pour l''agriculture et la pêche."},
      {"id":"q3","question":"Quel est le point culminant du Mali ?","options":["Mont Cameroun","Mont Hombori Tondo","Mont Kilimandjaro","Falaise de Bandiagara"],"correct":1,"explanation":"Le mont Hombori Tondo, situé dans la région de Mopti, est le point culminant du Mali avec 1 155 mètres d''altitude."},
      {"id":"q4","question":"Quelle est l''ethnie majoritaire au Mali ?","options":["Peul","Dogon","Bambara","Touareg"],"correct":2,"explanation":"Les Bambara (ou Bamanan) constituent environ 33 % de la population malienne, ce qui en fait l''ethnie la plus nombreuse du pays."},
      {"id":"q5","question":"Quel est le principal produit d''exportation agricole du Mali ?","options":["Le cacao","Le coton","Le café","L''arachide"],"correct":1,"explanation":"Le coton est le principal produit d''exportation agricole du Mali. Le pays est l''un des premiers producteurs de coton en Afrique."},
      {"id":"q6","question":"Le Mali est un pays :","options":["Côtier","Insulaire","Enclavé","Péninsulaire"],"correct":2,"explanation":"Le Mali est un pays enclavé, c''est-à-dire sans accès à la mer. Il dépend des ports de ses voisins côtiers (Dakar, Abidjan, Lomé) pour son commerce extérieur."},
      {"id":"q7","question":"Combien de zones climatiques distingue-t-on au Mali ?","options":["2","3","4","5"],"correct":1,"explanation":"On distingue 3 zones climatiques au Mali : saharienne (nord, très aride), sahélienne (centre, semi-aride) et soudanienne (sud, plus humide)."},
      {"id":"q8","question":"Le Mali est le combientième producteur d''or en Afrique ?","options":["1er","2e","3e","5e"],"correct":2,"explanation":"Le Mali est le 3e producteur d''or en Afrique (après l''Afrique du Sud et le Ghana). L''or représente une part importante des recettes d''exportation du pays."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 2 : Les États-Unis
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'les-etats-unis', 2, 'Les États-Unis', 'Milieu naturel, population, économie, rôle mondial', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'les-etats-unis-fiche', 'Les États-Unis', 'Superpuissance : territoire, population, économie et influence mondiale', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelles sont les caractéristiques du territoire américain ?","answer":"Les États-Unis couvrent 9,8 millions de km² (4e mondial). Le relief comprend : les Appalaches (est, montagnes anciennes), les Grandes Plaines (centre, agriculture), les Rocheuses (ouest, montagnes jeunes), la côte Pacifique (Californie). Climat varié : continental, subtropical, aride, méditerranéen, tropical (Hawaï), polaire (Alaska). Ressources abondantes : pétrole, gaz, charbon, terres fertiles."},
      {"id":"fc2","category":"Exemple","question":"Quelle est la composition de la population américaine ?","answer":"Les États-Unis comptent environ 335 millions d''habitants (3e mondial). Population diverse : Blancs non hispaniques (58 %), Hispaniques (19 %), Afro-Américains (13 %), Asiatiques (6 %). C''est un pays d''immigration (melting pot puis salad bowl). Urbanisation élevée (83 %). Mégalopoles : BosWash (nord-est), ChiPitts (Grands Lacs), SanSan (Californie). Densité moyenne : 36 hab/km²."},
      {"id":"fc3","category":"Exemple","question":"Pourquoi les États-Unis sont-ils la première puissance économique mondiale ?","answer":"Les États-Unis sont la 1re puissance économique (PIB : 25 000 milliards $). Forces : 1) Agriculture puissante et mécanisée (blé, maïs, soja). 2) Industrie diversifiée (haute technologie, automobile, aéronautique). 3) Services dominants (75 % du PIB : finance, GAFAM). 4) Innovation (Silicon Valley, universités). 5) Dollar, monnaie de référence mondiale. 6) Multinationales (Apple, Google, Amazon)."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que la Sun Belt ?","answer":"La Sun Belt (ceinture du soleil) désigne le sud des États-Unis (de la Californie à la Floride), région dynamique en croissance depuis les années 1970. Atouts : climat ensoleillé, industries de haute technologie (Silicon Valley, Houston), tourisme (Floride), pétrole (Texas), main-d''œuvre immigrée. Elle s''oppose à la Manufacturing Belt (nord-est, ancienne région industrielle en déclin relatif)."},
      {"id":"fc5","category":"Distinction","question":"Quels sont les aspects de la puissance mondiale des États-Unis ?","answer":"Puissance multidimensionnelle : 1) Militaire : 1re armée mondiale, bases partout, OTAN. 2) Économique : 1er PIB, Wall Street, FMI, dollar. 3) Technologique : Silicon Valley, NASA, GAFAM. 4) Culturelle (soft power) : Hollywood, musique, mode de vie, langue anglaise. 5) Diplomatique : membre permanent du Conseil de sécurité de l''ONU. Les USA sont qualifiés d''« hyperpuissance »."},
      {"id":"fc6","category":"Exemple","question":"Quelles sont les limites de la puissance américaine ?","answer":"Limites : 1) Inégalités sociales (pauvreté, sans-abri, accès aux soins). 2) Tensions raciales persistantes. 3) Déficit commercial. 4) Dette publique colossale. 5) Contestation de l''hégémonie par la Chine et la Russie. 6) Échecs militaires (Vietnam, Afghanistan). 7) Problèmes environnementaux (retrait de l''Accord de Paris sous Trump). 8) Polarisation politique interne."},
      {"id":"fc7","category":"Méthode","question":"Comment étudier une grande puissance ?","answer":"Méthode : 1) Analyser les fondements de la puissance (territoire, population, ressources). 2) Étudier les manifestations de la puissance (économie, armée, culture, diplomatie). 3) Identifier les limites et contestations. 4) Comparer avec d''autres puissances. 5) Utiliser des données chiffrées et des cartes. 6) Distinguer hard power (force militaire/économique) et soft power (influence culturelle)."},
      {"id":"fc8","category":"Exemple","question":"Quel rôle jouent les États-Unis dans la mondialisation ?","answer":"Rôle dans la mondialisation : 1) Moteur du libre-échange (OMC, accords bilatéraux). 2) Centre financier mondial (Wall Street, FMI). 3) Berceau des multinationales (GAFAM, Coca-Cola, McDonald''s). 4) Leader technologique (Internet, intelligence artificielle). 5) Diffusion culturelle mondiale (cinéma, musique, mode de vie). 6) Monnaie de référence (dollar). Les USA façonnent les règles de la mondialisation."}
    ],
    "schema": {
      "title": "Les États-Unis : superpuissance",
      "nodes": [
        {"id":"n1","label":"États-Unis","type":"main"},
        {"id":"n2","label":"Territoire","type":"branch"},
        {"id":"n3","label":"Population","type":"branch"},
        {"id":"n4","label":"Économie","type":"branch"},
        {"id":"n5","label":"Puissance mondiale","type":"branch"},
        {"id":"n6","label":"Relief, climat, ressources","type":"leaf"},
        {"id":"n7","label":"335 M, diverse, urbaine","type":"leaf"},
        {"id":"n8","label":"1er PIB, GAFAM","type":"leaf"},
        {"id":"n9","label":"Militaire, culturelle","type":"leaf"},
        {"id":"n10","label":"Limites et contestations","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"9,8 M km²"},
        {"from":"n1","to":"n3","label":"melting pot"},
        {"from":"n1","to":"n4","label":"1re mondiale"},
        {"from":"n1","to":"n5","label":"hyperpuissance"},
        {"from":"n2","to":"n6","label":"atouts"},
        {"from":"n3","to":"n7","label":"diversité"},
        {"from":"n4","to":"n8","label":"secteurs"},
        {"from":"n5","to":"n9","label":"hard/soft power"},
        {"from":"n5","to":"n10","label":"défis"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la superficie des États-Unis ?","options":["3,8 M km²","6,5 M km²","9,8 M km²","17 M km²"],"correct":2,"explanation":"Les États-Unis couvrent environ 9,8 millions de km², ce qui en fait le 4e pays du monde par sa superficie (après la Russie, le Canada et la Chine)."},
      {"id":"q2","question":"Quelle est la population des États-Unis ?","options":["150 millions","250 millions","335 millions","500 millions"],"correct":2,"explanation":"Les États-Unis comptent environ 335 millions d''habitants, ce qui en fait le 3e pays le plus peuplé du monde après la Chine et l''Inde."},
      {"id":"q3","question":"Qu''est-ce que la Sun Belt ?","options":["La zone industrielle du nord-est","La ceinture du soleil au sud, en plein essor","Le corridor technologique de Boston","La région agricole des Grandes Plaines"],"correct":1,"explanation":"La Sun Belt est la ceinture du soleil au sud des États-Unis (Californie à Floride), une région dynamique en croissance depuis les années 1970 grâce au climat, la technologie et l''immigration."},
      {"id":"q4","question":"Quel secteur domine l''économie américaine ?","options":["L''agriculture","L''industrie lourde","Les services (75 % du PIB)","L''exploitation minière"],"correct":2,"explanation":"Les services (finance, technologie, commerce, santé) représentent environ 75 % du PIB américain, illustrant une économie post-industrielle."},
      {"id":"q5","question":"Où se situe la Silicon Valley ?","options":["Texas","New York","Californie","Massachusetts"],"correct":2,"explanation":"La Silicon Valley se situe en Californie (sud de la baie de San Francisco). C''est le principal pôle mondial de l''industrie technologique (Apple, Google, Facebook, etc.)."},
      {"id":"q6","question":"Les GAFAM sont :","options":["Des bases militaires américaines","Les grandes entreprises technologiques américaines","Des organisations humanitaires","Des universités prestigieuses"],"correct":1,"explanation":"GAFAM désigne les cinq géants technologiques américains : Google (Alphabet), Apple, Facebook (Meta), Amazon et Microsoft, qui dominent l''économie numérique mondiale."},
      {"id":"q7","question":"Quel est le soft power américain ?","options":["La puissance militaire","L''influence culturelle (cinéma, musique, mode de vie)","La puissance nucléaire","Le nombre de bases militaires"],"correct":1,"explanation":"Le soft power américain est l''influence culturelle : Hollywood, musique, séries TV, mode de vie, fast-food, langue anglaise. Il permet aux États-Unis d''exercer une influence sans recourir à la force."},
      {"id":"q8","question":"Quelle est la monnaie de référence mondiale ?","options":["L''euro","Le yuan","Le dollar américain","La livre sterling"],"correct":2,"explanation":"Le dollar américain est la monnaie de référence mondiale, utilisée dans la majorité des échanges commerciaux et des réserves de change des banques centrales."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 3 : Le Brésil
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'le-bresil', 3, 'Le Brésil', 'Milieu naturel, population, économie, miracle économique', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'le-bresil-fiche', 'Le Brésil', 'Géant d''Amérique latine : territoire, peuple et économie émergente', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelles sont les caractéristiques du territoire brésilien ?","answer":"Le Brésil couvre 8,5 millions de km² (5e mondial), soit la moitié de l''Amérique du Sud. Relief : plaine amazonienne (nord), plateaux et serras (centre et sud-est), Nordeste semi-aride. Climat : équatorial (Amazonie), tropical (centre), subtropical (sud). Hydrographie : Amazone (plus grand fleuve du monde en débit), Paraná, São Francisco. L''Amazonie abrite la plus grande forêt tropicale du monde."},
      {"id":"fc2","category":"Exemple","question":"Quelle est la diversité de la population brésilienne ?","answer":"Le Brésil compte environ 215 millions d''habitants (6e mondial). Population très métissée : Blancs (43 %), Métis/Pardos (47 %), Noirs (8 %), Amérindiens (1 %), Asiatiques (1 %). Ce mélange résulte de la colonisation portugaise, de l''esclavage africain et de l''immigration européenne et japonaise. Urbanisation très forte (87 %). Mégapoles : São Paulo (22 M), Rio de Janeiro (13 M). Fortes inégalités sociales (favelas)."},
      {"id":"fc3","category":"Exemple","question":"Quels sont les secteurs clés de l''économie brésilienne ?","answer":"Économie diversifiée (10e PIB mondial) : 1) Agriculture puissante : 1er producteur mondial de café, sucre, soja, jus d''orange ; élevage bovin (1er exportateur). 2) Industrie : automobile, aéronautique (Embraer), sidérurgie. 3) Mines : fer, bauxite, manganèse, pétrole (pré-sal). 4) Services : banques, tourisme. Le Brésil est membre des BRICS (Brésil, Russie, Inde, Chine, Afrique du Sud)."},
      {"id":"fc4","category":"Définition","question":"Qu''appelle-t-on le miracle économique brésilien ?","answer":"Le miracle économique brésilien désigne la période de forte croissance (1968-1973) avec un taux de croissance annuel de 10-12 %. Facteurs : industrialisation massive, investissements étrangers, grands travaux (Itaipu, Brasília, Transamazonienne). Limites : endettement, aggravation des inégalités, destruction de l''environnement. Depuis 2000, le Brésil est redevenu une puissance émergente (BRICS), mais connaît des crises récurrentes."},
      {"id":"fc5","category":"Distinction","question":"Quelles sont les inégalités au Brésil ?","answer":"Le Brésil est l''un des pays les plus inégalitaires : 1) Inégalités sociales : 10 % des plus riches détiennent 50 % des revenus ; favelas vs quartiers aisés. 2) Inégalités régionales : Sud-Est riche (São Paulo, Rio) vs Nordeste pauvre et aride. 3) Inégalités raciales : les Noirs et Métis sont surreprésentés parmi les pauvres. Le Brésil a tenté des programmes sociaux (Bolsa Família) pour réduire ces écarts."},
      {"id":"fc6","category":"Exemple","question":"Pourquoi l''Amazonie est-elle un enjeu mondial ?","answer":"L''Amazonie est un enjeu mondial car : 1) Plus grande forêt tropicale (5,5 M km², dont 60 % au Brésil). 2) Poumon de la planète (absorption du CO2). 3) Biodiversité exceptionnelle (10 % des espèces mondiales). 4) Menaces : déforestation (agriculture, élevage, exploitation forestière), orpaillage illégal, incendies. 5) Peuples autochtones menacés. La déforestation contribue au changement climatique mondial."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser un pays émergent ?","answer":"Méthode : 1) Identifier les facteurs d''émergence (ressources, démographie, politique économique). 2) Mesurer la croissance (PIB, IDH, taux de croissance). 3) Analyser l''insertion dans la mondialisation (exportations, IDE, organisations). 4) Repérer les fragilités (inégalités, dépendance, environnement). 5) Comparer avec d''autres émergents (BRICS). Un pays émergent a une forte croissance mais conserve des caractéristiques de pays en développement."},
      {"id":"fc8","category":"Exemple","question":"Quelle est la place du Brésil dans le monde ?","answer":"Le Brésil est une puissance émergente : 10e PIB mondial, membre des BRICS et du G20, puissance agricole mondiale, leader régional en Amérique latine (Mercosur). Soft power : football, carnaval, musique (bossa nova, samba). Diplomatie active à l''ONU (revendique un siège permanent au Conseil de sécurité). Limites : instabilité politique, corruption, dépendance aux matières premières."}
    ],
    "schema": {
      "title": "Le Brésil : géant émergent",
      "nodes": [
        {"id":"n1","label":"Brésil","type":"main"},
        {"id":"n2","label":"Territoire","type":"branch"},
        {"id":"n3","label":"Population","type":"branch"},
        {"id":"n4","label":"Économie","type":"branch"},
        {"id":"n5","label":"Amazonie, relief, climat","type":"leaf"},
        {"id":"n6","label":"215 M, métissée, inégale","type":"leaf"},
        {"id":"n7","label":"Agriculture, industrie, BRICS","type":"leaf"},
        {"id":"n8","label":"Miracle économique","type":"leaf"},
        {"id":"n9","label":"Inégalités Nord/Sud","type":"leaf"},
        {"id":"n10","label":"Amazonie : enjeu mondial","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"8,5 M km²"},
        {"from":"n1","to":"n3","label":"diversité"},
        {"from":"n1","to":"n4","label":"émergence"},
        {"from":"n2","to":"n5","label":"milieu"},
        {"from":"n3","to":"n6","label":"caractéristiques"},
        {"from":"n4","to":"n7","label":"secteurs"},
        {"from":"n4","to":"n8","label":"1968-1973"},
        {"from":"n3","to":"n9","label":"fractures"},
        {"from":"n2","to":"n10","label":"environnement"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la superficie du Brésil ?","options":["3,5 M km²","5,5 M km²","8,5 M km²","12 M km²"],"correct":2,"explanation":"Le Brésil couvre environ 8,5 millions de km², ce qui en fait le 5e plus grand pays du monde et le plus grand d''Amérique latine."},
      {"id":"q2","question":"De quel produit le Brésil est-il le 1er producteur mondial ?","options":["Blé","Café","Riz","Cacao"],"correct":1,"explanation":"Le Brésil est le 1er producteur mondial de café, assurant environ un tiers de la production mondiale. Il est aussi premier pour le sucre, le soja et le jus d''orange."},
      {"id":"q3","question":"Qu''est-ce que les BRICS ?","options":["Un accord militaire","Un groupe de pays émergents (Brésil, Russie, Inde, Chine, Afrique du Sud)","Une monnaie commune","Un accord de libre-échange"],"correct":1,"explanation":"Les BRICS regroupent les principales économies émergentes : Brésil, Russie, Inde, Chine et Afrique du Sud. Le groupe s''est élargi en 2024 à d''autres pays."},
      {"id":"q4","question":"Le miracle économique brésilien a eu lieu :","options":["1945-1950","1960-1965","1968-1973","1990-1995"],"correct":2,"explanation":"Le miracle économique brésilien (1968-1973) a été une période de croissance annuelle de 10-12 %, grâce à l''industrialisation et aux investissements étrangers massifs."},
      {"id":"q5","question":"Les favelas sont :","options":["Des quartiers résidentiels aisés","Des bidonvilles urbains marqués par la pauvreté","Des zones industrielles","Des parcs naturels"],"correct":1,"explanation":"Les favelas sont des bidonvilles ou quartiers informels des grandes villes brésiliennes (Rio, São Paulo), marqués par la pauvreté, l''insalubrité et l''insécurité, symboles des fortes inégalités sociales."},
      {"id":"q6","question":"L''Amazonie couvre environ :","options":["1 M km²","3 M km²","5,5 M km²","10 M km²"],"correct":2,"explanation":"La forêt amazonienne couvre environ 5,5 millions de km², dont 60 % se trouvent au Brésil. C''est la plus grande forêt tropicale du monde."},
      {"id":"q7","question":"Quelle est la plus grande ville du Brésil ?","options":["Rio de Janeiro","Brasília","São Paulo","Salvador"],"correct":2,"explanation":"São Paulo est la plus grande ville du Brésil avec environ 22 millions d''habitants dans son agglomération. C''est le principal centre économique et financier du pays."},
      {"id":"q8","question":"Quel grand barrage hydroélectrique se trouve à la frontière Brésil-Paraguay ?","options":["Assouan","Trois Gorges","Itaipu","Hoover"],"correct":2,"explanation":"Le barrage d''Itaipu, sur le fleuve Paraná à la frontière Brésil-Paraguay, est l''un des plus grands barrages hydroélectriques du monde, symbole du développement brésilien."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 4 : L''Union Européenne
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'union-europeenne', 4, 'L''Union Européenne', 'Construction, institutions, intégration, rôle mondial', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'union-europeenne-fiche', 'L''Union Européenne', 'Construction européenne, institutions et place dans le monde', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Comment l''Union Européenne s''est-elle construite ?","answer":"Étapes de la construction : 1) CECA (1951, 6 pays : France, Allemagne, Italie, Benelux). 2) Traité de Rome (1957, CEE et Euratom). 3) Acte unique européen (1986, marché unique). 4) Traité de Maastricht (1992, création de l''UE, citoyenneté européenne). 5) Euro (2002). 6) Élargissements successifs : de 6 à 27 membres. 7) Traité de Lisbonne (2007, réforme des institutions). Brexit (2020, sortie du Royaume-Uni)."},
      {"id":"fc2","category":"Définition","question":"Quelles sont les principales institutions de l''UE ?","answer":"Institutions : 1) Conseil européen (chefs d''État, orientations). 2) Conseil de l''UE (ministres, législation). 3) Commission européenne (exécutif, 27 commissaires, Bruxelles). 4) Parlement européen (705 députés élus, Strasbourg). 5) Cour de justice de l''UE (Luxembourg). 6) Banque centrale européenne (BCE, Francfort, politique monétaire). Principe de subsidiarité : l''UE n''intervient que si elle est plus efficace que les États."},
      {"id":"fc3","category":"Exemple","question":"Quels sont les aspects de l''intégration européenne ?","answer":"Intégration : 1) Économique : marché unique (libre circulation des biens, services, capitaux, personnes), euro (20 pays), PAC (politique agricole commune). 2) Politique : politique étrangère commune (PESC), espace Schengen (libre circulation). 3) Sociale : fonds structurels, Erasmus. 4) Juridique : primauté du droit européen. L''intégration est un processus graduel, du marché commun à l''union politique."},
      {"id":"fc4","category":"Distinction","question":"Quels sont les atouts et les défis de l''UE ?","answer":"Atouts : 2e PIB mondial, 450 millions d''habitants, paix durable depuis 1945, modèle social avancé, puissance commerciale, soft power. Défis : inégalités entre membres (Est/Ouest, Nord/Sud), montée de l''euroscepticisme, Brexit, crise migratoire, politique de défense insuffisante, concurrence de la Chine et des USA, vieillissement démographique, transition écologique."},
      {"id":"fc5","category":"Exemple","question":"Qu''est-ce que l''espace Schengen ?","answer":"L''espace Schengen (1985) supprime les contrôles aux frontières intérieures entre 27 pays européens (dont 23 de l''UE + Norvège, Islande, Suisse, Liechtenstein). Les citoyens peuvent circuler librement. En contrepartie, les frontières extérieures sont renforcées (Frontex). L''espace Schengen est l''une des réalisations les plus concrètes de l''intégration européenne."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que l''euro ?","answer":"L''euro (€) est la monnaie unique européenne, en circulation depuis le 1er janvier 2002. Il est utilisé par 20 des 27 États membres (zone euro). Géré par la BCE (Banque centrale européenne, Francfort). Avantages : suppression des coûts de change, stabilité des prix, facilitation des échanges. Limites : politique monétaire unique pour des économies différentes, perte de souveraineté monétaire."},
      {"id":"fc7","category":"Méthode","question":"Comment étudier une organisation régionale ?","answer":"Méthode : 1) Contexte de création (motivations historiques, géopolitiques). 2) Étapes de construction (traités fondateurs, élargissements). 3) Institutions (fonctionnement, pouvoirs). 4) Réalisations (marché commun, monnaie, libre circulation). 5) Limites et défis (inégalités, souveraineté, élargissement). 6) Place dans le monde (poids économique, diplomatique). Comparer avec d''autres blocs (CEDEAO, ASEAN, Mercosur)."},
      {"id":"fc8","category":"Exemple","question":"Quel est le rôle mondial de l''UE ?","answer":"Rôle mondial : 1) 1re puissance commerciale mondiale. 2) 1er donneur d''aide au développement. 3) Modèle d''intégration régionale. 4) Acteur diplomatique (médiation, sanctions). 5) Normative power : l''UE impose ses normes (environnement, numérique, RGPD). Limites : absence d''armée commune, dépendance aux USA pour la défense (OTAN), difficulté à parler d''une seule voix en politique étrangère."}
    ],
    "schema": {
      "title": "L''Union Européenne",
      "nodes": [
        {"id":"n1","label":"Union Européenne","type":"main"},
        {"id":"n2","label":"Construction","type":"branch"},
        {"id":"n3","label":"Institutions","type":"branch"},
        {"id":"n4","label":"Intégration","type":"branch"},
        {"id":"n5","label":"CECA → Lisbonne","type":"leaf"},
        {"id":"n6","label":"Commission, Parlement, Conseil","type":"leaf"},
        {"id":"n7","label":"Marché unique, euro, Schengen","type":"leaf"},
        {"id":"n8","label":"27 membres","type":"leaf"},
        {"id":"n9","label":"Rôle mondial","type":"leaf"},
        {"id":"n10","label":"Défis : Brexit, euroscepticisme","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"depuis 1951"},
        {"from":"n1","to":"n3","label":"fonctionnement"},
        {"from":"n1","to":"n4","label":"processus"},
        {"from":"n2","to":"n5","label":"traités"},
        {"from":"n3","to":"n6","label":"organes"},
        {"from":"n4","to":"n7","label":"réalisations"},
        {"from":"n2","to":"n8","label":"élargissements"},
        {"from":"n1","to":"n9","label":"puissance"},
        {"from":"n1","to":"n10","label":"limites"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"En quelle année a été créée la CECA ?","options":["1945","1951","1957","1992"],"correct":1,"explanation":"La CECA (Communauté Européenne du Charbon et de l''Acier) a été créée en 1951 par 6 pays (France, Allemagne, Italie, Benelux), première étape de la construction européenne."},
      {"id":"q2","question":"Le traité de Maastricht (1992) a créé :","options":["La CECA","Le marché commun","L''Union Européenne","L''espace Schengen"],"correct":2,"explanation":"Le traité de Maastricht (1992) a créé l''Union Européenne, instaurant la citoyenneté européenne et prévoyant la monnaie unique (euro)."},
      {"id":"q3","question":"Combien d''États membres compte l''UE actuellement ?","options":["15","25","27","28"],"correct":2,"explanation":"L''UE compte 27 États membres depuis le Brexit (sortie du Royaume-Uni en 2020). Elle comptait 28 membres auparavant."},
      {"id":"q4","question":"Depuis quand l''euro est-il en circulation ?","options":["1992","1999","2002","2005"],"correct":2,"explanation":"L''euro est en circulation sous forme de billets et pièces depuis le 1er janvier 2002, bien qu''il ait été introduit comme monnaie scripturale en 1999."},
      {"id":"q5","question":"L''espace Schengen permet :","options":["L''utilisation de l''euro","La libre circulation des personnes sans contrôle aux frontières","Le vote aux élections européennes","L''harmonisation fiscale"],"correct":1,"explanation":"L''espace Schengen supprime les contrôles aux frontières intérieures entre ses 27 pays membres, permettant la libre circulation des personnes."},
      {"id":"q6","question":"Où siège le Parlement européen ?","options":["Bruxelles","Luxembourg","Strasbourg","La Haye"],"correct":2,"explanation":"Le Parlement européen siège principalement à Strasbourg (France), bien qu''il tienne aussi des sessions à Bruxelles (Belgique)."},
      {"id":"q7","question":"Le Brexit désigne :","options":["L''entrée de la Grande-Bretagne dans l''UE","La sortie du Royaume-Uni de l''UE","La création de la livre sterling","L''adhésion à l''euro"],"correct":1,"explanation":"Le Brexit (British Exit) désigne la sortie du Royaume-Uni de l''Union Européenne, effective le 31 janvier 2020, suite au référendum de juin 2016."},
      {"id":"q8","question":"L''UE est la première puissance :","options":["Militaire","Commerciale mondiale","Démographique","Pétrolière"],"correct":1,"explanation":"L''Union Européenne est la première puissance commerciale mondiale, représentant environ 15 % du commerce mondial de biens et services."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 5 : La Chine
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'la-chine', 5, 'La Chine', 'Milieu naturel, population, économie, émergence', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'la-chine-fiche', 'La Chine', 'Géant asiatique : territoire, démographie et puissance émergente', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quelles sont les caractéristiques du territoire chinois ?","answer":"La Chine couvre 9,6 millions de km² (3e mondial). Relief contrasté : ouest montagneux (Himalaya, Tibet, plateau à 4 000 m), est de plaines fertiles (plaine de Chine du Nord, vallée du Yangzi). Climat : continental froid au nord, subtropical au sud-est, aride à l''ouest. Fleuves majeurs : Huang He (fleuve Jaune) et Yangzi Jiang (Chang Jiang, le plus long d''Asie, 6 300 km). Ressources : charbon, terres rares, hydroélectricité."},
      {"id":"fc2","category":"Exemple","question":"Quels sont les défis démographiques de la Chine ?","answer":"La Chine compte 1,4 milliard d''habitants (2e mondial après l''Inde depuis 2023). Politique de l''enfant unique (1979-2015) puis assouplissement (2 enfants en 2015, 3 en 2021). Conséquences : vieillissement rapide, déséquilibre hommes/femmes, baisse de la natalité. Population inégalement répartie : 90 % à l''est sur 40 % du territoire. Urbanisation massive : plus de 60 % d''urbains. Mégapoles : Shanghai (28 M), Pékin (22 M)."},
      {"id":"fc3","category":"Exemple","question":"Comment la Chine est-elle devenue la 2e puissance économique mondiale ?","answer":"Facteurs d''émergence : 1) Réformes de Deng Xiaoping (1978) : ouverture économique, zones économiques spéciales (ZES). 2) Main-d''œuvre abondante et bon marché. 3) Investissements étrangers massifs (IDE). 4) Exportations industrielles (« atelier du monde »). 5) Montée en gamme technologique (Huawei, 5G, IA). 6) Nouvelles Routes de la Soie (BRI). PIB : 2e mondial. La Chine combine économie de marché et régime politique communiste."},
      {"id":"fc4","category":"Définition","question":"Que sont les Zones Économiques Spéciales (ZES) ?","answer":"Les ZES sont des zones créées en 1980 sur le littoral chinois (Shenzhen, Zhuhai, Shantou, Xiamen) pour attirer les investissements étrangers avec des avantages fiscaux et réglementaires. Elles ont été le moteur de l''ouverture économique. Shenzhen est passée de village de pêcheurs à métropole de 17 millions d''habitants. Ce modèle a inspiré d''autres pays en développement."},
      {"id":"fc5","category":"Distinction","question":"Quelles sont les forces et faiblesses de la Chine ?","answer":"Forces : 2e PIB mondial, 1re puissance industrielle, immenses réserves de change, puissance technologique, armée modernisée, membre permanent du Conseil de sécurité. Faiblesses : inégalités régionales (côte riche vs intérieur pauvre), pollution massive, vieillissement, tensions sociales, dépendance énergétique (importateur de pétrole), tensions géopolitiques (Taïwan, mer de Chine, droits de l''homme)."},
      {"id":"fc6","category":"Exemple","question":"Que sont les Nouvelles Routes de la Soie ?","answer":"Les Nouvelles Routes de la Soie (Belt and Road Initiative, BRI), lancées par Xi Jinping en 2013, sont un vaste programme d''infrastructures reliant la Chine à l''Europe, l''Afrique et l''Asie : routes, ports, voies ferrées, câbles numériques. Plus de 140 pays partenaires. Objectifs : étendre l''influence chinoise, sécuriser les approvisionnements, créer des débouchés commerciaux. Critiques : dette-piège pour les pays pauvres."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser l''émergence d''une puissance ?","answer":"Méthode : 1) Identifier les conditions initiales (territoire, population, ressources). 2) Étudier les politiques économiques (réformes, ouverture). 3) Mesurer les résultats (PIB, IDH, exportations). 4) Analyser l''insertion mondiale (organisations, commerce, diplomatie). 5) Repérer les limites (inégalités, environnement, gouvernance). 6) Comparer avec d''autres puissances émergentes."},
      {"id":"fc8","category":"Exemple","question":"Quelle est la place de la Chine en Afrique ?","answer":"La Chine en Afrique : 1er partenaire commercial du continent depuis 2009. Investissements massifs dans les infrastructures (routes, chemins de fer, ports, stades). Exploitation des ressources naturelles (pétrole, minerais). Prêts aux États africains (BRI). Présence au Mali : routes, pont de Bamako, entreprises chinoises. Critiques : dette-piège, concurrence déloyale pour les entreprises locales, néocolonialisme économique."}
    ],
    "schema": {
      "title": "La Chine : puissance émergente",
      "nodes": [
        {"id":"n1","label":"Chine","type":"main"},
        {"id":"n2","label":"Territoire","type":"branch"},
        {"id":"n3","label":"Population","type":"branch"},
        {"id":"n4","label":"Économie","type":"branch"},
        {"id":"n5","label":"Relief, climat, ressources","type":"leaf"},
        {"id":"n6","label":"1,4 Md, vieillissement","type":"leaf"},
        {"id":"n7","label":"2e PIB, atelier du monde","type":"leaf"},
        {"id":"n8","label":"ZES, ouverture 1978","type":"leaf"},
        {"id":"n9","label":"Routes de la Soie (BRI)","type":"leaf"},
        {"id":"n10","label":"Puissance mondiale","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"9,6 M km²"},
        {"from":"n1","to":"n3","label":"démographie"},
        {"from":"n1","to":"n4","label":"émergence"},
        {"from":"n2","to":"n5","label":"milieu"},
        {"from":"n3","to":"n6","label":"défis"},
        {"from":"n4","to":"n7","label":"résultats"},
        {"from":"n4","to":"n8","label":"réformes"},
        {"from":"n4","to":"n9","label":"expansion"},
        {"from":"n1","to":"n10","label":"influence"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la population de la Chine ?","options":["800 millions","1 milliard","1,4 milliard","2 milliards"],"correct":2,"explanation":"La Chine compte environ 1,4 milliard d''habitants. Elle a été dépassée par l''Inde en 2023 comme pays le plus peuplé du monde."},
      {"id":"q2","question":"Les réformes économiques de Deng Xiaoping datent de :","options":["1949","1966","1978","1989"],"correct":2,"explanation":"En 1978, Deng Xiaoping a lancé les réformes d''ouverture économique (« réforme et ouverture »), transformant la Chine d''une économie planifiée en une économie de marché socialiste."},
      {"id":"q3","question":"Qu''est-ce qu''une ZES ?","options":["Une zone militaire","Une zone économique spéciale pour attirer les investissements","Une zone écologique","Une zone éducative"],"correct":1,"explanation":"Les ZES (Zones Économiques Spéciales) sont des zones côtières créées en 1980 pour attirer les investissements étrangers grâce à des avantages fiscaux et réglementaires."},
      {"id":"q4","question":"Quel rang occupe la Chine dans l''économie mondiale ?","options":["1er","2e","3e","5e"],"correct":1,"explanation":"La Chine est la 2e puissance économique mondiale par son PIB nominal (après les États-Unis), et la 1re en parité de pouvoir d''achat."},
      {"id":"q5","question":"La politique de l''enfant unique a été appliquée de :","options":["1949 à 1978","1966 à 2000","1979 à 2015","1990 à 2020"],"correct":2,"explanation":"La politique de l''enfant unique a été appliquée de 1979 à 2015 pour freiner la croissance démographique. Elle a été assouplie à 2 enfants (2015) puis 3 enfants (2021)."},
      {"id":"q6","question":"Les Nouvelles Routes de la Soie (BRI) ont été lancées par :","options":["Mao Zedong","Deng Xiaoping","Xi Jinping","Hu Jintao"],"correct":2,"explanation":"Xi Jinping a lancé les Nouvelles Routes de la Soie (Belt and Road Initiative) en 2013, un vaste programme d''infrastructures reliant la Chine à l''Europe, l''Afrique et l''Asie."},
      {"id":"q7","question":"Quel est le plus long fleuve de Chine ?","options":["Le Huang He","Le Yangzi Jiang","Le Mékong","Le Pearl River"],"correct":1,"explanation":"Le Yangzi Jiang (Chang Jiang) est le plus long fleuve de Chine et d''Asie (6 300 km). Le barrage des Trois Gorges, construit sur ce fleuve, est le plus grand barrage hydroélectrique du monde."},
      {"id":"q8","question":"Quel est le principal partenaire commercial de l''Afrique ?","options":["Les États-Unis","La France","La Chine","Le Japon"],"correct":2,"explanation":"La Chine est le premier partenaire commercial de l''Afrique depuis 2009, avec des échanges dépassant 250 milliards de dollars par an et des investissements massifs en infrastructures."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 6 : Les grands problèmes du monde actuel
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'problemes-monde-actuel', 6, 'Les grands problèmes du monde actuel', 'Problèmes énergétiques et démographiques', 6)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'problemes-monde-actuel-fiche', 'Les grands problèmes du monde actuel', 'Défis énergétiques et démographiques mondiaux', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quels sont les principaux problèmes énergétiques mondiaux ?","answer":"Problèmes énergétiques : 1) Épuisement des énergies fossiles (pétrole, gaz, charbon = 80 % de l''énergie mondiale). 2) Dépendance énergétique de nombreux pays. 3) Pollution et réchauffement climatique (effet de serre). 4) Inégalités d''accès à l''énergie (600 millions d''Africains sans électricité). 5) Conflits géopolitiques liés au pétrole (Moyen-Orient, Russie). 6) Transition énergétique nécessaire mais coûteuse."},
      {"id":"fc2","category":"Exemple","question":"Quelles sont les différentes sources d''énergie ?","answer":"Sources d''énergie : 1) Fossiles (non renouvelables) : pétrole (31 %), charbon (27 %), gaz naturel (24 %). 2) Nucléaire (4 %). 3) Renouvelables : hydroélectricité (7 %), éolien, solaire, biomasse, géothermie (7 % total). Les énergies renouvelables sont en forte croissance mais restent minoritaires. La transition énergétique vise à remplacer les fossiles par les renouvelables."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que la transition démographique ?","answer":"La transition démographique est le passage d''un régime démographique traditionnel (forte natalité, forte mortalité) à un régime moderne (faible natalité, faible mortalité). 4 phases : 1) Pré-transition (taux élevés). 2) Début (mortalité baisse, natalité reste haute → explosion démographique). 3) Fin (natalité baisse). 4) Post-transition (taux bas, stabilisation ou déclin). L''Afrique est en phase 2, l''Europe en phase 4."},
      {"id":"fc4","category":"Exemple","question":"Quels sont les défis de la croissance démographique mondiale ?","answer":"Défis : 1) Population mondiale : 8 milliards (2022), prévision 10 milliards en 2050. 2) Croissance concentrée en Afrique et Asie du Sud. 3) Pression sur les ressources (eau, nourriture, énergie). 4) Urbanisation massive (68 % d''urbains en 2050). 5) Migrations internationales. 6) Chômage des jeunes dans les pays du Sud. 7) Vieillissement dans les pays du Nord (pensions, santé)."},
      {"id":"fc5","category":"Distinction","question":"Quelles différences démographiques entre Nord et Sud ?","answer":"Nord (pays développés) : faible natalité (1,5 enfant/femme), vieillissement (plus de 20 % de plus de 65 ans), croissance quasi nulle ou négative, immigration compensatrice. Sud (pays en développement) : natalité élevée (4-6 enfants/femme en Afrique subsaharienne), population jeune (50 % de moins de 25 ans), forte croissance (2-3 % par an), exode rural massif."},
      {"id":"fc6","category":"Exemple","question":"Qu''est-ce que le réchauffement climatique ?","answer":"Le réchauffement climatique est l''augmentation de la température moyenne de la Terre due à l''effet de serre renforcé par les activités humaines (combustion d''énergies fossiles, déforestation). Conséquences : fonte des glaciers, montée des eaux, événements climatiques extrêmes, sécheresses, perte de biodiversité. Accords : Kyoto (1997), Paris (2015, limiter le réchauffement à 1,5°C). L''Afrique est la plus vulnérable."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser un grand problème mondial ?","answer":"Méthode : 1) Définir le problème (nature, ampleur, échelle). 2) Identifier les causes (naturelles, humaines, économiques). 3) Mesurer les conséquences (sociales, économiques, environnementales). 4) Repérer les inégalités (Nord/Sud, riches/pauvres). 5) Présenter les solutions envisagées (accords internationaux, politiques nationales). 6) Évaluer leur efficacité. Utiliser des données chiffrées et des exemples concrets."},
      {"id":"fc8","category":"Exemple","question":"Quel est l''impact énergétique et démographique au Mali ?","answer":"Au Mali : 1) Énergie : faible accès à l''électricité (moins de 50 % de la population), dépendance au bois (déforestation), potentiel solaire immense mais sous-exploité, barrage de Manantali. 2) Démographie : croissance de 3 % par an, population doublant tous les 23 ans, 7 enfants par femme en moyenne, pression sur l''éducation et la santé, exode rural vers Bamako, émigration vers l''étranger."}
    ],
    "schema": {
      "title": "Problèmes du monde actuel",
      "nodes": [
        {"id":"n1","label":"Défis mondiaux","type":"main"},
        {"id":"n2","label":"Problèmes énergétiques","type":"branch"},
        {"id":"n3","label":"Problèmes démographiques","type":"branch"},
        {"id":"n4","label":"Fossiles : pétrole, gaz, charbon","type":"leaf"},
        {"id":"n5","label":"Renouvelables : solaire, éolien","type":"leaf"},
        {"id":"n6","label":"Réchauffement climatique","type":"leaf"},
        {"id":"n7","label":"Croissance : 8 → 10 Md","type":"leaf"},
        {"id":"n8","label":"Transition démographique","type":"leaf"},
        {"id":"n9","label":"Vieillissement Nord / Jeunesse Sud","type":"leaf"},
        {"id":"n10","label":"Urbanisation massive","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"énergie"},
        {"from":"n1","to":"n3","label":"population"},
        {"from":"n2","to":"n4","label":"80 % mix"},
        {"from":"n2","to":"n5","label":"transition"},
        {"from":"n2","to":"n6","label":"conséquence"},
        {"from":"n3","to":"n7","label":"tendance"},
        {"from":"n3","to":"n8","label":"modèle"},
        {"from":"n3","to":"n9","label":"contrastes"},
        {"from":"n3","to":"n10","label":"68 % en 2050"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle part de l''énergie mondiale provient des énergies fossiles ?","options":["40 %","60 %","80 %","95 %"],"correct":2,"explanation":"Les énergies fossiles (pétrole, charbon, gaz naturel) représentent environ 80 % de la consommation énergétique mondiale, d''où l''urgence de la transition énergétique."},
      {"id":"q2","question":"La population mondiale a atteint 8 milliards en :","options":["2010","2015","2020","2022"],"correct":3,"explanation":"La population mondiale a franchi le cap des 8 milliards d''habitants en novembre 2022, selon les Nations Unies."},
      {"id":"q3","question":"La transition démographique est le passage :","options":["De la paix à la guerre","D''une forte natalité/mortalité à une faible natalité/mortalité","De l''agriculture à l''industrie","De la ville à la campagne"],"correct":1,"explanation":"La transition démographique est le passage d''un régime traditionnel (forte natalité et mortalité) à un régime moderne (faible natalité et mortalité), entraînant une phase d''explosion démographique."},
      {"id":"q4","question":"L''Accord de Paris sur le climat vise à limiter le réchauffement à :","options":["0,5°C","1,5°C","3°C","5°C"],"correct":1,"explanation":"L''Accord de Paris (2015) vise à limiter le réchauffement climatique à 1,5°C au-dessus des niveaux préindustriels, en réduisant les émissions de gaz à effet de serre."},
      {"id":"q5","question":"Quel continent a la plus forte croissance démographique ?","options":["L''Asie","L''Europe","L''Afrique","L''Amérique"],"correct":2,"explanation":"L''Afrique a la plus forte croissance démographique (environ 2,5 % par an). Sa population devrait doubler d''ici 2050, passant de 1,4 à 2,5 milliards d''habitants."},
      {"id":"q6","question":"Quelle énergie renouvelable produit le plus d''électricité dans le monde ?","options":["Le solaire","L''éolien","L''hydroélectricité","La géothermie"],"correct":2,"explanation":"L''hydroélectricité est la première source d''énergie renouvelable dans le monde, représentant environ 16 % de la production électrique mondiale."},
      {"id":"q7","question":"Le vieillissement de la population concerne surtout :","options":["L''Afrique","L''Asie du Sud","Les pays développés du Nord","L''Amérique latine"],"correct":2,"explanation":"Le vieillissement touche surtout les pays développés (Europe, Japon) où la natalité est faible et l''espérance de vie élevée. Plus de 20 % de la population y a plus de 65 ans."},
      {"id":"q8","question":"Quel pourcentage de la population mondiale vivra en ville en 2050 ?","options":["40 %","55 %","68 %","90 %"],"correct":2,"explanation":"Selon l''ONU, 68 % de la population mondiale vivra en zone urbaine en 2050, contre 55 % en 2018, posant d''importants défis d''aménagement et de services."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 7 : Les inégalités de développement
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'inegalites-developpement', 7, 'Les inégalités de développement', 'Nord vs Sud, Suds hétérogènes', 7)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'inegalites-developpement-fiche', 'Les inégalités de développement', 'Fracture Nord-Sud et diversité des Suds', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le développement ?","answer":"Le développement est un processus d''amélioration des conditions de vie d''une population : croissance économique, accès à l''éducation, à la santé, à l''alimentation, aux droits fondamentaux. Il se mesure par : le PIB/habitant (richesse), l''IDH (Indice de Développement Humain : espérance de vie, éducation, revenu), le coefficient de Gini (inégalités). Le développement ne se réduit pas à la croissance économique."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce que la fracture Nord-Sud ?","answer":"La fracture Nord-Sud désigne les inégalités de développement entre les pays développés (Nord : Europe, Amérique du Nord, Japon, Australie) et les pays en développement (Sud : Afrique, Asie du Sud, Amérique latine). Cette ligne imaginaire, proposée par Willy Brandt (1980), est aujourd''hui nuancée car certains pays du Sud émergent (Chine, Inde, Brésil) tandis que des poches de pauvreté existent au Nord."},
      {"id":"fc3","category":"Distinction","question":"Pourquoi parle-t-on de Suds hétérogènes ?","answer":"Les Suds sont hétérogènes car les pays en développement ont des situations très différentes : 1) Pays émergents (BRICS : Chine, Inde, Brésil) à forte croissance. 2) Pays exportateurs de pétrole (Golfe) riches mais peu diversifiés. 3) PMA (Pays les Moins Avancés : Mali, Niger) très pauvres. 4) Pays intermédiaires (Maroc, Sénégal). L''expression « tiers-monde » est obsolète car elle masque cette diversité."},
      {"id":"fc4","category":"Exemple","question":"Quelles sont les causes des inégalités de développement ?","answer":"Causes : 1) Historiques : colonisation, traite négrière, pillage des ressources. 2) Économiques : échanges inégaux, dette, dépendance aux matières premières. 3) Politiques : corruption, instabilité, mauvaise gouvernance. 4) Naturelles : climat, enclavement, catastrophes. 5) Structurelles : faible industrialisation, brain drain (fuite des cerveaux). 6) Mondialisation inégale (marginalisation de l''Afrique)."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que l''IDH ?","answer":"L''IDH (Indice de Développement Humain) est un indicateur créé par le PNUD en 1990 pour mesurer le développement au-delà du PIB. Il combine : 1) Espérance de vie à la naissance (santé). 2) Durée moyenne de scolarisation (éducation). 3) Revenu national brut par habitant (niveau de vie). L''IDH va de 0 à 1 : très élevé (> 0,8), élevé (0,7-0,8), moyen (0,55-0,7), faible (< 0,55). Le Mali : 0,428 (186e/191)."},
      {"id":"fc6","category":"Exemple","question":"Quels sont les Objectifs de Développement Durable (ODD) ?","answer":"Les 17 ODD ont été adoptés par l''ONU en 2015 (Agenda 2030) : 1) Pas de pauvreté. 2) Faim zéro. 3) Bonne santé. 4) Éducation de qualité. 5) Égalité des sexes. 6) Eau propre. 7) Énergie propre. 8) Travail décent. 9) Industrie et innovation. 10) Réduction des inégalités. 13) Action climatique. 16) Paix et justice. Ils succèdent aux Objectifs du Millénaire (OMD, 2000-2015)."},
      {"id":"fc7","category":"Méthode","question":"Comment mesurer les inégalités de développement ?","answer":"Indicateurs : 1) PIB/habitant (richesse, mais masque les inégalités internes). 2) IDH (développement humain global). 3) Coefficient de Gini (mesure des inégalités de revenu, 0 = égalité parfaite, 1 = inégalité totale). 4) Taux de mortalité infantile (santé). 5) Taux d''alphabétisation (éducation). 6) Espérance de vie. Combiner plusieurs indicateurs pour une vision complète."},
      {"id":"fc8","category":"Exemple","question":"Quelle est la situation du Mali en matière de développement ?","answer":"Le Mali est classé parmi les PMA : IDH = 0,428 (186e/191), PIB/habitant faible, espérance de vie 59 ans, taux d''alphabétisation 35 %, mortalité infantile élevée. Causes : enclavement, climat aride, instabilité sécuritaire, faible industrialisation. Atouts : jeunesse, ressources minières (or), potentiel agricole. Programmes : CREDD (Cadre pour la Relance Économique et le Développement Durable)."}
    ],
    "schema": {
      "title": "Inégalités de développement",
      "nodes": [
        {"id":"n1","label":"Inégalités de développement","type":"main"},
        {"id":"n2","label":"Fracture Nord-Sud","type":"branch"},
        {"id":"n3","label":"Suds hétérogènes","type":"branch"},
        {"id":"n4","label":"Causes","type":"branch"},
        {"id":"n5","label":"Nord développé, IDH élevé","type":"leaf"},
        {"id":"n6","label":"Émergents (BRICS)","type":"leaf"},
        {"id":"n7","label":"PMA (Mali, Niger)","type":"leaf"},
        {"id":"n8","label":"Colonisation, échanges inégaux","type":"leaf"},
        {"id":"n9","label":"IDH, PIB, Gini","type":"leaf"},
        {"id":"n10","label":"ODD (Agenda 2030)","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"clivage"},
        {"from":"n1","to":"n3","label":"diversité"},
        {"from":"n1","to":"n4","label":"origines"},
        {"from":"n2","to":"n5","label":"pays riches"},
        {"from":"n3","to":"n6","label":"croissance"},
        {"from":"n3","to":"n7","label":"pauvreté"},
        {"from":"n4","to":"n8","label":"historiques"},
        {"from":"n1","to":"n9","label":"mesure"},
        {"from":"n1","to":"n10","label":"solutions"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''IDH est un indicateur qui mesure :","options":["Uniquement la richesse","Le développement humain (santé, éducation, revenu)","La pollution","La puissance militaire"],"correct":1,"explanation":"L''IDH (Indice de Développement Humain) combine trois dimensions : l''espérance de vie (santé), la scolarisation (éducation) et le revenu par habitant (niveau de vie)."},
      {"id":"q2","question":"Le Mali est classé parmi les :","options":["Pays émergents","Pays développés","PMA (Pays les Moins Avancés)","NPI (Nouveaux Pays Industrialisés)"],"correct":2,"explanation":"Le Mali est classé parmi les PMA (Pays les Moins Avancés) en raison de son faible revenu, de son faible IDH et de sa vulnérabilité économique."},
      {"id":"q3","question":"Les ODD ont été adoptés en :","options":["2000","2005","2015","2020"],"correct":2,"explanation":"Les 17 Objectifs de Développement Durable (ODD) ont été adoptés par l''ONU en 2015 dans le cadre de l''Agenda 2030, succédant aux Objectifs du Millénaire pour le Développement."},
      {"id":"q4","question":"Pourquoi parle-t-on de Suds au pluriel ?","options":["Car il y a plusieurs hémisphères sud","Car les pays du Sud ont des niveaux de développement très différents","Car le Sud est divisé en continents","Car il y a deux pôles Sud"],"correct":1,"explanation":"On parle de « Suds » au pluriel car les pays en développement présentent des situations très différentes : des PMA très pauvres aux pays émergents à forte croissance (BRICS)."},
      {"id":"q5","question":"Le coefficient de Gini mesure :","options":["La richesse d''un pays","Les inégalités de revenus dans un pays","La croissance économique","L''espérance de vie"],"correct":1,"explanation":"Le coefficient de Gini mesure les inégalités de distribution des revenus. Il va de 0 (égalité parfaite) à 1 (un seul individu possède tout)."},
      {"id":"q6","question":"Quelle cause historique explique le sous-développement de l''Afrique ?","options":["Le changement climatique","La colonisation et la traite négrière","L''industrialisation","Le tourisme de masse"],"correct":1,"explanation":"La colonisation et la traite négrière ont durablement affaibli l''Afrique : pillage des ressources, déstructuration des sociétés, frontières artificielles, exploitation des populations."},
      {"id":"q7","question":"Les BRICS sont :","options":["Des pays très pauvres","Des pays émergents à forte croissance","Des pays européens","Des organisations humanitaires"],"correct":1,"explanation":"Les BRICS (Brésil, Russie, Inde, Chine, Afrique du Sud) sont des pays émergents à forte croissance économique qui pèsent de plus en plus dans l''économie mondiale."},
      {"id":"q8","question":"Quel indicateur est le plus complet pour mesurer le développement ?","options":["Le PIB total","Le PIB par habitant","L''IDH","Le taux d''inflation"],"correct":2,"explanation":"L''IDH est plus complet que le PIB car il intègre la santé (espérance de vie) et l''éducation (scolarisation) en plus du revenu, offrant une vision plus globale du développement."}
    ]
  }');

  -- ============================================================
  -- GÉOGRAPHIE - Chapitre 8 : La mondialisation
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (geo_id, 'la-mondialisation', 8, 'La mondialisation', 'Définition, flux, acteurs, lieux', 8)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'la-mondialisation-fiche', 'La mondialisation', 'Processus, flux, acteurs et espaces de la mondialisation', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la mondialisation ?","answer":"La mondialisation est le processus d''intégration croissante des économies, des sociétés et des cultures à l''échelle mondiale. Elle se manifeste par l''intensification des échanges de biens, services, capitaux, informations et personnes. Facteurs : révolution des transports (conteneurs, avions), des télécommunications (Internet), libéralisation du commerce (OMC). Elle a accéléré depuis les années 1980-1990 (chute du mur de Berlin, essor d''Internet)."},
      {"id":"fc2","category":"Exemple","question":"Quels sont les principaux flux de la mondialisation ?","answer":"Flux : 1) Commerciaux : 25 000 milliards $ d''échanges de biens (produits manufacturés, matières premières). 2) Financiers : IDE (investissements directs étrangers), bourses mondiales (Wall Street, Londres, Tokyo). 3) D''informations : Internet, médias, réseaux sociaux. 4) Humains : migrations internationales (280 millions de migrants), tourisme (1,5 milliard). 5) Culturels : diffusion de modes de vie, langues, cuisines."},
      {"id":"fc3","category":"Exemple","question":"Quels sont les acteurs de la mondialisation ?","answer":"Acteurs : 1) États (politiques commerciales, accords). 2) Firmes transnationales/multinationales (GAFAM, Total, Nestlé). 3) Organisations internationales (OMC, FMI, Banque mondiale). 4) Organisations régionales (UE, CEDEAO, ASEAN). 5) ONG (Médecins Sans Frontières, Oxfam). 6) Diasporas (transferts de fonds). 7) Individus (consommateurs, migrants). Les FTN sont les principaux moteurs de la mondialisation."},
      {"id":"fc4","category":"Définition","question":"Quels sont les lieux de la mondialisation ?","answer":"Lieux stratégiques : 1) Métropoles mondiales (villes globales : New York, Londres, Tokyo, Shanghai). 2) Façades maritimes (détroits, ports : Singapour, Rotterdam, Shanghai). 3) Zones franches et ZES. 4) Paradis fiscaux (Îles Caïmans, Luxembourg). 5) Silicon Valley et technopôles. Les périphéries (PMA, zones rurales, régions enclavées) sont marginalisées par la mondialisation."},
      {"id":"fc5","category":"Distinction","question":"Quels sont les avantages et inconvénients de la mondialisation ?","answer":"Avantages : croissance économique mondiale, baisse de la pauvreté (Chine, Inde), accès aux biens et services, diffusion du savoir et de la technologie, développement des pays émergents. Inconvénients : aggravation des inégalités, délocalisations, exploitation des travailleurs, uniformisation culturelle, dégradation de l''environnement, crises financières mondiales (2008), dépendance économique."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce qu''une firme transnationale (FTN) ?","answer":"Une FTN est une entreprise qui possède des filiales dans plusieurs pays. Elle organise sa production à l''échelle mondiale : siège social dans un pays développé, production dans les pays à bas coûts, vente sur tous les marchés. Exemples : Apple (siège : USA, production : Chine, vente : mondiale), Total, Toyota, Nestlé. Les 100 premières FTN réalisent un chiffre d''affaires supérieur au PIB de nombreux pays."},
      {"id":"fc7","category":"Méthode","question":"Comment étudier la mondialisation ?","answer":"Méthode : 1) Définir le concept (mise en relation des territoires). 2) Identifier les flux (commerciaux, financiers, humains, culturels). 3) Analyser les acteurs (États, FTN, OI, ONG). 4) Repérer les lieux (centres, périphéries, interfaces). 5) Évaluer les effets (positifs et négatifs). 6) Situer dans le temps (phases historiques). Utiliser des cartes de flux et des schémas pour illustrer."},
      {"id":"fc8","category":"Exemple","question":"Quelle est la place de l''Afrique dans la mondialisation ?","answer":"L''Afrique est marginalisée dans la mondialisation : 3 % du commerce mondial, faible part des IDE, infrastructures insuffisantes. Mais intégration croissante : ressources naturelles convoitées (pétrole, minerais), croissance du numérique (mobile banking : M-Pesa), diaspora (transferts de fonds), ZLECAf (marché continental). Le Mali exporte de l''or et du coton mais importe la majorité de ses biens manufacturés."}
    ],
    "schema": {
      "title": "La mondialisation",
      "nodes": [
        {"id":"n1","label":"Mondialisation","type":"main"},
        {"id":"n2","label":"Flux","type":"branch"},
        {"id":"n3","label":"Acteurs","type":"branch"},
        {"id":"n4","label":"Lieux","type":"branch"},
        {"id":"n5","label":"Commerce, finance, information","type":"leaf"},
        {"id":"n6","label":"FTN, États, OI","type":"leaf"},
        {"id":"n7","label":"Métropoles, ports, ZES","type":"leaf"},
        {"id":"n8","label":"Avantages : croissance","type":"leaf"},
        {"id":"n9","label":"Limites : inégalités","type":"leaf"},
        {"id":"n10","label":"Afrique marginalisée","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"échanges"},
        {"from":"n1","to":"n3","label":"moteurs"},
        {"from":"n1","to":"n4","label":"espaces"},
        {"from":"n2","to":"n5","label":"types"},
        {"from":"n3","to":"n6","label":"principaux"},
        {"from":"n4","to":"n7","label":"centres"},
        {"from":"n1","to":"n8","label":"positif"},
        {"from":"n1","to":"n9","label":"négatif"},
        {"from":"n4","to":"n10","label":"périphérie"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La mondialisation se définit comme :","options":["La domination d''un seul pays","L''intégration croissante des économies et sociétés à l''échelle mondiale","La fin du commerce international","L''isolement des pays"],"correct":1,"explanation":"La mondialisation est le processus d''intégration croissante des économies, sociétés et cultures à l''échelle planétaire, par l''intensification des échanges."},
      {"id":"q2","question":"Quel est le principal acteur économique de la mondialisation ?","options":["Les ONG","Les États","Les firmes transnationales (FTN)","Les syndicats"],"correct":2,"explanation":"Les firmes transnationales (FTN) sont les principaux moteurs économiques de la mondialisation, organisant la production et le commerce à l''échelle mondiale."},
      {"id":"q3","question":"L''OMC (Organisation Mondiale du Commerce) a pour rôle de :","options":["Financer les pays pauvres","Réguler le commerce mondial et promouvoir le libre-échange","Gérer les conflits armés","Protéger l''environnement"],"correct":1,"explanation":"L''OMC (créée en 1995, succédant au GATT) a pour mission de réguler le commerce mondial, de promouvoir le libre-échange et de régler les différends commerciaux entre États."},
      {"id":"q4","question":"Quelle part du commerce mondial l''Afrique représente-t-elle ?","options":["3 %","10 %","20 %","30 %"],"correct":0,"explanation":"L''Afrique ne représente qu''environ 3 % du commerce mondial, ce qui illustre sa marginalisation dans la mondialisation malgré ses immenses ressources naturelles."},
      {"id":"q5","question":"Les villes globales sont :","options":["Des villes très peuplées","Des métropoles qui concentrent les fonctions de commandement mondial","Des capitales politiques","Des villes touristiques"],"correct":1,"explanation":"Les villes globales (New York, Londres, Tokyo, Shanghai) concentrent les fonctions de commandement : sièges de FTN, bourses, organisations internationales, médias, universités."},
      {"id":"q6","question":"Les conteneurs ont révolutionné :","options":["L''agriculture","Le transport maritime et le commerce mondial","La médecine","L''éducation"],"correct":1,"explanation":"Les conteneurs (inventés dans les années 1950) ont révolutionné le transport maritime en réduisant considérablement les coûts et les délais, accélérant la mondialisation des échanges."},
      {"id":"q7","question":"Un paradis fiscal est :","options":["Un pays très riche","Un territoire à fiscalité très basse attirant les capitaux","Un pays sans impôts sur le revenu","Un pays tropical"],"correct":1,"explanation":"Un paradis fiscal est un territoire offrant une fiscalité très basse et le secret bancaire pour attirer les capitaux étrangers (Îles Caïmans, Luxembourg, Panama). Ils facilitent l''évasion fiscale."},
      {"id":"q8","question":"La ZLECAf vise à :","options":["Fermer les frontières africaines","Créer une zone de libre-échange continentale africaine","Supprimer l''Union Africaine","Interdire les importations"],"correct":1,"explanation":"La ZLECAf (Zone de Libre-Échange Continentale Africaine), entrée en vigueur en 2021, vise à créer un marché unique africain de 1,3 milliard de consommateurs pour stimuler le commerce intra-africain."}
    ]
  }');

  -- ============================================================
  -- MATHÉMATIQUES - Chapitre 1 : La notion de limite
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'notion-de-limite', 1, 'La notion de limite', 'Approche descriptive et graphique, limites de suites et de fonctions', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'notion-de-limite-fiche', 'La notion de limite', 'Limites de suites, limites de fonctions, formes indéterminées', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la limite d''une suite ?","answer":"La limite d''une suite (Un) est la valeur L vers laquelle tendent les termes Un quand n tend vers +∞. On écrit : lim(n→+∞) Un = L. Si L est un nombre réel, la suite est convergente. Si Un tend vers +∞ ou -∞, la suite est divergente. Exemple : Un = 1/n → 0 (convergente). Un = n² → +∞ (divergente)."},
      {"id":"fc2","category":"Définition","question":"Qu''est-ce que la limite d''une fonction en un point ?","answer":"La limite de f(x) quand x tend vers a est le nombre L tel que f(x) s''approche de L quand x s''approche de a. On écrit : lim(x→a) f(x) = L. La limite peut exister même si f(a) n''est pas défini. Exemple : lim(x→0) (sin x)/x = 1. On distingue la limite à gauche (x→a⁻) et la limite à droite (x→a⁺). Si elles sont égales, la limite existe."},
      {"id":"fc3","category":"Exemple","question":"Quelles sont les limites usuelles à connaître ?","answer":"Limites usuelles : lim(x→+∞) 1/x = 0 ; lim(x→0) 1/x² = +∞ ; lim(x→+∞) xⁿ = +∞ (n > 0) ; lim(x→+∞) √x = +∞ ; lim(x→+∞) (ax+b)/(cx+d) = a/c ; lim(x→0) (sin x)/x = 1 ; lim(x→+∞) (1+1/n)ⁿ = e. Ces limites servent de base pour calculer des limites plus complexes."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce qu''une forme indéterminée ?","answer":"Une forme indéterminée est une expression dont la limite ne peut pas être déterminée directement. Les 7 formes indéterminées : 0/0, ∞/∞, ∞-∞, 0×∞, 1^∞, 0^0, ∞^0. Pour lever l''indétermination : factoriser, multiplier par le conjugué, utiliser la règle de L''Hôpital, ou faire un changement de variable. Exemple : lim(x→1) (x²-1)/(x-1) = lim(x→1) (x+1) = 2."},
      {"id":"fc5","category":"Méthode","question":"Comment calculer la limite d''une fraction rationnelle en +∞ ?","answer":"Pour calculer lim(x→+∞) P(x)/Q(x) où P et Q sont des polynômes : factoriser par le terme de plus haut degré au numérateur et au dénominateur. Trois cas : 1) deg(P) < deg(Q) → limite = 0. 2) deg(P) = deg(Q) → limite = coefficient dominant de P / coefficient dominant de Q. 3) deg(P) > deg(Q) → limite = ±∞. Exemple : lim(x→+∞) (3x²+x)/(2x²-1) = 3/2."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce qu''une asymptote ?","answer":"Une asymptote est une droite dont la courbe s''approche indéfiniment. Trois types : 1) Asymptote horizontale y = L si lim(x→±∞) f(x) = L. 2) Asymptote verticale x = a si lim(x→a) f(x) = ±∞. 3) Asymptote oblique y = ax+b si lim(x→±∞) [f(x)-(ax+b)] = 0. Exemple : f(x) = 1/x a une asymptote horizontale y = 0 et une asymptote verticale x = 0."},
      {"id":"fc7","category":"Méthode","question":"Comment lever l''indétermination 0/0 ?","answer":"Pour lever 0/0 : 1) Factoriser le numérateur et le dénominateur. 2) Simplifier le facteur commun. 3) Calculer la nouvelle limite. Autre méthode : multiplier par le conjugué (pour les racines carrées). Exemple : lim(x→2) (x²-4)/(x-2) = lim(x→2) (x-2)(x+2)/(x-2) = lim(x→2) (x+2) = 4. On peut aussi utiliser la dérivation (règle de L''Hôpital) si applicable."},
      {"id":"fc8","category":"Exemple","question":"Comment étudier la convergence d''une suite géométrique ?","answer":"Une suite géométrique (Un) de raison q : Un = U₀ × qⁿ. Convergence selon q : 1) |q| < 1 → lim Un = 0 (convergente). 2) q = 1 → Un = U₀ (constante). 3) q > 1 → lim Un = +∞ si U₀ > 0 (divergente). 4) q ≤ -1 → pas de limite (divergente, oscillante). Exemple : Un = 3×(1/2)ⁿ → 0 car |1/2| < 1."}
    ],
    "schema": {
      "title": "La notion de limite",
      "nodes": [
        {"id":"n1","label":"Limites","type":"main"},
        {"id":"n2","label":"Limites de suites","type":"branch"},
        {"id":"n3","label":"Limites de fonctions","type":"branch"},
        {"id":"n4","label":"Techniques de calcul","type":"branch"},
        {"id":"n5","label":"Convergente / Divergente","type":"leaf"},
        {"id":"n6","label":"En un point / En ±∞","type":"leaf"},
        {"id":"n7","label":"Asymptotes","type":"leaf"},
        {"id":"n8","label":"Formes indéterminées","type":"leaf"},
        {"id":"n9","label":"Factorisation, conjugué","type":"leaf"},
        {"id":"n10","label":"Limites usuelles","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"suites"},
        {"from":"n1","to":"n3","label":"fonctions"},
        {"from":"n1","to":"n4","label":"méthodes"},
        {"from":"n2","to":"n5","label":"comportement"},
        {"from":"n3","to":"n6","label":"types"},
        {"from":"n3","to":"n7","label":"droites limites"},
        {"from":"n4","to":"n8","label":"0/0, ∞/∞"},
        {"from":"n4","to":"n9","label":"levée"},
        {"from":"n1","to":"n10","label":"formules"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Quelle est la limite de 1/n quand n tend vers +∞ ?","options":["1","+∞","0","-∞"],"correct":2,"explanation":"lim(n→+∞) 1/n = 0 car plus n est grand, plus 1/n est proche de 0. C''est l''une des limites usuelles fondamentales."},
      {"id":"q2","question":"La forme 0/0 est :","options":["Égale à 0","Égale à 1","Indéterminée","Impossible"],"correct":2,"explanation":"0/0 est une forme indéterminée : la limite peut être n''importe quel nombre, +∞ ou ne pas exister. Il faut lever l''indétermination par factorisation ou autre technique."},
      {"id":"q3","question":"Si lim(x→+∞) f(x) = 3, alors la courbe admet :","options":["Une asymptote verticale x = 3","Une asymptote horizontale y = 3","Une asymptote oblique","Aucune asymptote"],"correct":1,"explanation":"Si la limite de f(x) en +∞ est un nombre fini L, alors la droite y = L est une asymptote horizontale de la courbe. Ici y = 3."},
      {"id":"q4","question":"lim(x→+∞) (2x³+x)/(5x³-3) = ?","options":["0","2/5","+∞","1"],"correct":1,"explanation":"Pour une fraction de polynômes de même degré, la limite en +∞ est le rapport des coefficients dominants : 2/5."},
      {"id":"q5","question":"Une suite géométrique de raison q = 1/3 est :","options":["Divergente","Convergente vers 0","Constante","Oscillante"],"correct":1,"explanation":"Une suite géométrique de raison q avec |q| < 1 converge vers 0. Ici |1/3| < 1, donc la suite converge vers 0."},
      {"id":"q6","question":"lim(x→2) (x²-4)/(x-2) = ?","options":["0","2","4","Forme indéterminée sans solution"],"correct":2,"explanation":"C''est une forme 0/0. On factorise : (x²-4)/(x-2) = (x-2)(x+2)/(x-2) = x+2. Donc lim(x→2) = 2+2 = 4."},
      {"id":"q7","question":"Si lim(x→a) f(x) = +∞, alors x = a est :","options":["Une asymptote horizontale","Une asymptote oblique","Une asymptote verticale","Un point d''inflexion"],"correct":2,"explanation":"Si f(x) tend vers +∞ (ou -∞) quand x tend vers a, alors la droite x = a est une asymptote verticale de la courbe."},
      {"id":"q8","question":"Combien existe-t-il de formes indéterminées classiques ?","options":["3","5","7","10"],"correct":2,"explanation":"Il existe 7 formes indéterminées classiques : 0/0, ∞/∞, ∞-∞, 0×∞, 1^∞, 0^0 et ∞^0. Chacune nécessite une technique spécifique pour être levée."}
    ]
  }');

  -- ============================================================
  -- MATHÉMATIQUES - Chapitre 2 : Dérivation — compléments et applications
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'derivation-complements', 2, 'Dérivation — compléments et applications', 'Règles de dérivation, fonctions polynomiales et rationnelles', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'derivation-complements-fiche', 'Dérivation — compléments et applications', 'Règles, tableau de variation et optimisation', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la dérivée d''une fonction ?","answer":"La dérivée de f en a, notée f''(a), est la limite du taux d''accroissement : f''(a) = lim(h→0) [f(a+h)-f(a)]/h. Interprétation géométrique : f''(a) est le coefficient directeur de la tangente à la courbe au point d''abscisse a. L''équation de la tangente est : y = f''(a)(x-a) + f(a). La dérivée mesure la vitesse de variation de la fonction."},
      {"id":"fc2","category":"Exemple","question":"Quelles sont les dérivées usuelles ?","answer":"Dérivées usuelles : (c)'' = 0 ; (x)'' = 1 ; (xⁿ)'' = nxⁿ⁻¹ ; (1/x)'' = -1/x² ; (√x)'' = 1/(2√x) ; (sin x)'' = cos x ; (cos x)'' = -sin x ; (eˣ)'' = eˣ ; (ln x)'' = 1/x. Ces formules sont à connaître par cœur pour calculer rapidement les dérivées."},
      {"id":"fc3","category":"Méthode","question":"Quelles sont les règles de dérivation ?","answer":"Règles : 1) (u+v)'' = u'' + v''. 2) (ku)'' = ku'' (k constante). 3) (uv)'' = u''v + uv'' (produit). 4) (u/v)'' = (u''v - uv'')/v² (quotient). 5) (uⁿ)'' = nu''uⁿ⁻¹ (composée). 6) [f(g(x))]'' = g''(x) × f''(g(x)) (chaîne). Application : pour dériver (2x+1)³, on utilise la règle de la composée : 3×2×(2x+1)² = 6(2x+1)²."},
      {"id":"fc4","category":"Méthode","question":"Comment dresser un tableau de variation ?","answer":"Étapes : 1) Calculer f''(x). 2) Résoudre f''(x) = 0 pour trouver les valeurs critiques. 3) Étudier le signe de f''(x) sur chaque intervalle. 4) Si f''(x) > 0, f est croissante (↗). Si f''(x) < 0, f est décroissante (↘). 5) Calculer les valeurs de f aux points critiques et aux bornes. 6) Construire le tableau avec x, f''(x), variations de f."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce qu''un extremum ?","answer":"Un extremum est une valeur maximale ou minimale d''une fonction. Théorème : si f admet un extremum en a et si f est dérivable en a, alors f''(a) = 0. Maximum local : f'' change de signe de + à - en a. Minimum local : f'' change de signe de - à + en a. Un point où f'' = 0 sans changement de signe est un point d''inflexion (ex : x³ en 0)."},
      {"id":"fc6","category":"Exemple","question":"Comment dériver une fonction polynomiale ?","answer":"Pour dériver f(x) = axⁿ + bxᵐ + ... + c : dériver terme par terme. Exemple : f(x) = 3x⁴ - 2x³ + 5x - 7. f''(x) = 12x³ - 6x² + 5. Pour étudier les variations : résoudre f''(x) = 0, étudier le signe de f''(x), dresser le tableau de variation."},
      {"id":"fc7","category":"Exemple","question":"Comment dériver une fonction rationnelle ?","answer":"Une fonction rationnelle est f(x) = P(x)/Q(x). On utilise la règle du quotient : f''(x) = [P''(x)Q(x) - P(x)Q''(x)] / [Q(x)]². Exemple : f(x) = (x+1)/(x-2). f''(x) = [1×(x-2) - (x+1)×1] / (x-2)² = -3/(x-2)². Le signe de f''(x) est toujours négatif, donc f est décroissante sur son domaine."},
      {"id":"fc8","category":"Méthode","question":"Comment résoudre un problème d''optimisation ?","answer":"Méthode : 1) Identifier la grandeur à optimiser (aire, volume, coût). 2) Exprimer cette grandeur comme fonction f(x) d''une variable. 3) Déterminer le domaine de définition (contraintes). 4) Calculer f''(x) et résoudre f''(x) = 0. 5) Vérifier que c''est bien un maximum ou un minimum. 6) Calculer la valeur optimale. Exemple : maximiser l''aire d''un rectangle de périmètre donné → carré."}
    ],
    "schema": {
      "title": "Dérivation : compléments",
      "nodes": [
        {"id":"n1","label":"Dérivation","type":"main"},
        {"id":"n2","label":"Dérivées usuelles","type":"branch"},
        {"id":"n3","label":"Règles de dérivation","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"xⁿ, sin, cos, eˣ, ln","type":"leaf"},
        {"id":"n6","label":"Somme, produit, quotient","type":"leaf"},
        {"id":"n7","label":"Composée (chaîne)","type":"leaf"},
        {"id":"n8","label":"Tableau de variation","type":"leaf"},
        {"id":"n9","label":"Extremums","type":"leaf"},
        {"id":"n10","label":"Optimisation","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"formules"},
        {"from":"n1","to":"n3","label":"calcul"},
        {"from":"n1","to":"n4","label":"usage"},
        {"from":"n2","to":"n5","label":"fonctions"},
        {"from":"n3","to":"n6","label":"opérations"},
        {"from":"n3","to":"n7","label":"composition"},
        {"from":"n4","to":"n8","label":"signe de f''"},
        {"from":"n4","to":"n9","label":"max/min"},
        {"from":"n4","to":"n10","label":"problèmes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La dérivée de x³ est :","options":["x²","3x","3x²","x⁴/4"],"correct":2,"explanation":"La dérivée de xⁿ est nxⁿ⁻¹. Donc (x³)'' = 3x³⁻¹ = 3x²."},
      {"id":"q2","question":"La dérivée de 1/x est :","options":["1/x²","-1/x²","ln x","-1/x"],"correct":1,"explanation":"(1/x)'' = (x⁻¹)'' = -1×x⁻² = -1/x². C''est une dérivée usuelle à connaître."},
      {"id":"q3","question":"La règle de dérivation du produit (uv)'' est :","options":["u''v''","u''v + uv''","u''v - uv''","(u+v)''"],"correct":1,"explanation":"La dérivée d''un produit est (uv)'' = u''v + uv''. C''est la règle de Leibniz pour la dérivation du produit."},
      {"id":"q4","question":"Si f''(x) > 0 sur un intervalle, alors f est :","options":["Décroissante","Constante","Croissante","Nulle"],"correct":2,"explanation":"Si la dérivée f''(x) est strictement positive sur un intervalle, la fonction f est strictement croissante sur cet intervalle."},
      {"id":"q5","question":"Un extremum de f se produit quand :","options":["f(x) = 0","f''(x) = 0 avec changement de signe","f''(x) > 0","f est continue"],"correct":1,"explanation":"Un extremum (maximum ou minimum) se produit en un point où f''(x) = 0 et où f'' change de signe. Sans changement de signe, c''est un point d''inflexion."},
      {"id":"q6","question":"La dérivée de (2x+1)⁴ est :","options":["4(2x+1)³","8(2x+1)³","2(2x+1)³","(2x+1)⁵/5"],"correct":1,"explanation":"Par la règle de la composée : [(2x+1)⁴]'' = 4×(2x+1)³×(2x+1)'' = 4×(2x+1)³×2 = 8(2x+1)³."},
      {"id":"q7","question":"La dérivée de f(x) = (x+1)/(x-2) est :","options":["1/(x-2)","-3/(x-2)²","(x-2)/(x+1)","2/(x-2)"],"correct":1,"explanation":"Par la règle du quotient : f''(x) = [1×(x-2) - (x+1)×1]/(x-2)² = (x-2-x-1)/(x-2)² = -3/(x-2)²."},
      {"id":"q8","question":"L''équation de la tangente en a est :","options":["y = f(a)","y = f''(a)x","y = f''(a)(x-a) + f(a)","y = f(a)(x-a) + f''(a)"],"correct":2,"explanation":"L''équation de la tangente à la courbe de f au point d''abscisse a est : y = f''(a)(x-a) + f(a), où f''(a) est la pente et f(a) l''ordonnée du point de tangence."}
    ]
  }');

  -- ============================================================
  -- MATHÉMATIQUES - Chapitre 3 : Notion de primitive
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'notion-primitive', 3, 'Notion de primitive', 'Définition, tableau des primitives usuelles', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'notion-primitive-fiche', 'Notion de primitive', 'Primitives usuelles et calcul intégral élémentaire', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une primitive ?","answer":"Une primitive de f sur un intervalle I est une fonction F telle que F''(x) = f(x) pour tout x dans I. Si F est une primitive de f, alors toute primitive de f s''écrit F(x) + C (C constante réelle). Exemple : F(x) = x³/3 est une primitive de f(x) = x², car (x³/3)'' = x². La primitive n''est pas unique : x³/3 + 5, x³/3 - 2 sont aussi des primitives de x²."},
      {"id":"fc2","category":"Exemple","question":"Quelles sont les primitives usuelles ?","answer":"Primitives usuelles : f(x) → F(x)+C. 0 → C ; k → kx ; xⁿ (n≠-1) → xⁿ⁺¹/(n+1) ; 1/x → ln|x| ; 1/x² → -1/x ; eˣ → eˣ ; cos x → sin x ; sin x → -cos x ; 1/√x → 2√x ; 1/(1+x²) → arctan x. Ces primitives se déduisent des dérivées usuelles en inversant le processus."},
      {"id":"fc3","category":"Méthode","question":"Comment calculer une primitive de ku(x) ?","answer":"Si F est une primitive de f, alors kF est une primitive de kf (k constante). Primitive d''une somme : la primitive de (f+g) est F+G. Exemple : primitive de 3x² + 2x - 5 = 3×(x³/3) + 2×(x²/2) - 5x + C = x³ + x² - 5x + C. On primitive terme par terme et on ajoute la constante C."},
      {"id":"fc4","category":"Méthode","question":"Comment trouver la primitive passant par un point donné ?","answer":"On cherche la primitive F telle que F(x₀) = y₀. Méthode : 1) Trouver la primitive générale F(x) + C. 2) Utiliser la condition F(x₀) = y₀ pour calculer C. Exemple : primitive de f(x) = 2x telle que F(1) = 3. F(x) = x² + C. F(1) = 1 + C = 3, donc C = 2. Réponse : F(x) = x² + 2."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce qu''une intégrale définie ?","answer":"L''intégrale de f de a à b, notée ∫ₐᵇ f(x)dx, est la différence F(b) - F(a), où F est une primitive de f. Interprétation géométrique : si f ≥ 0, c''est l''aire sous la courbe de f entre a et b. Propriétés : ∫ₐᵇ f(x)dx = -∫ᵇₐ f(x)dx ; ∫ₐᵇ [f+g] = ∫ₐᵇ f + ∫ₐᵇ g ; ∫ₐᵇ kf = k∫ₐᵇ f."},
      {"id":"fc6","category":"Exemple","question":"Comment calculer une intégrale simple ?","answer":"Exemple : ∫₁³ (2x+1)dx. 1) Trouver la primitive : F(x) = x² + x. 2) Calculer F(3) - F(1) = (9+3) - (1+1) = 12 - 2 = 10. Autre exemple : ∫₀¹ x³dx = [x⁴/4]₀¹ = 1/4 - 0 = 1/4. On note [F(x)]ₐᵇ = F(b) - F(a)."},
      {"id":"fc7","category":"Méthode","question":"Comment primitiver u''(x)×[u(x)]ⁿ ?","answer":"La primitive de u''(x)×[u(x)]ⁿ est [u(x)]ⁿ⁺¹/(n+1) + C (pour n ≠ -1). La primitive de u''(x)/u(x) est ln|u(x)| + C. Exemple : primitive de 2x(x²+1)³. Ici u(x) = x²+1, u''(x) = 2x, n = 3. Primitive = (x²+1)⁴/4 + C. Vérification : [(x²+1)⁴/4]'' = 4×2x×(x²+1)³/4 = 2x(x²+1)³. ✓"},
      {"id":"fc8","category":"Distinction","question":"Quelle est la relation entre dérivée et primitive ?","answer":"La dérivation et la primitivation sont des opérations inverses. Si F est une primitive de f, alors F'' = f. Si f'' = g, alors f est une primitive de g. Le théorème fondamental de l''analyse relie les deux : ∫ₐᵇ f(x)dx = F(b) - F(a). La dérivation est unique (f a une seule dérivée), la primitivation ne l''est pas (f a une infinité de primitives, différant d''une constante C)."}
    ],
    "schema": {
      "title": "Notion de primitive",
      "nodes": [
        {"id":"n1","label":"Primitives","type":"main"},
        {"id":"n2","label":"Définition","type":"branch"},
        {"id":"n3","label":"Primitives usuelles","type":"branch"},
        {"id":"n4","label":"Intégrale définie","type":"branch"},
        {"id":"n5","label":"F''(x) = f(x)","type":"leaf"},
        {"id":"n6","label":"F(x) + C (constante)","type":"leaf"},
        {"id":"n7","label":"xⁿ, eˣ, sin, cos, ln","type":"leaf"},
        {"id":"n8","label":"∫ₐᵇ f(x)dx = F(b)-F(a)","type":"leaf"},
        {"id":"n9","label":"Aire sous la courbe","type":"leaf"},
        {"id":"n10","label":"Composée u''uⁿ","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"concept"},
        {"from":"n1","to":"n3","label":"formules"},
        {"from":"n1","to":"n4","label":"application"},
        {"from":"n2","to":"n5","label":"relation"},
        {"from":"n2","to":"n6","label":"unicité"},
        {"from":"n3","to":"n7","label":"tableau"},
        {"from":"n4","to":"n8","label":"calcul"},
        {"from":"n4","to":"n9","label":"géométrie"},
        {"from":"n3","to":"n10","label":"technique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Une primitive de f(x) = 2x est :","options":["2","x","x² + C","2x² + C"],"correct":2,"explanation":"La primitive de 2x est x² + C, car (x²)'' = 2x. On peut vérifier en dérivant x² + C : on retrouve bien 2x."},
      {"id":"q2","question":"Combien de primitives une fonction admet-elle ?","options":["Aucune","Une seule","Deux","Une infinité (différant d''une constante)"],"correct":3,"explanation":"Si F est une primitive de f, alors F + C (pour toute constante C réelle) est aussi une primitive de f. Il y a donc une infinité de primitives."},
      {"id":"q3","question":"La primitive de 1/x est :","options":["x²","ln|x| + C","-1/x² + C","eˣ + C"],"correct":1,"explanation":"La primitive de 1/x est ln|x| + C, car (ln|x|)'' = 1/x. C''est une primitive usuelle fondamentale."},
      {"id":"q4","question":"∫₀² 3x²dx = ?","options":["6","8","12","24"],"correct":1,"explanation":"La primitive de 3x² est x³. Donc ∫₀² 3x²dx = [x³]₀² = 2³ - 0³ = 8 - 0 = 8."},
      {"id":"q5","question":"La primitive de cos x est :","options":["-sin x + C","sin x + C","cos x + C","-cos x + C"],"correct":1,"explanation":"La primitive de cos x est sin x + C, car (sin x)'' = cos x."},
      {"id":"q6","question":"La primitive de eˣ est :","options":["xeˣ + C","eˣ + C","eˣ/x + C","ln(eˣ) + C"],"correct":1,"explanation":"La primitive de eˣ est eˣ + C, car (eˣ)'' = eˣ. La fonction exponentielle est sa propre primitive."},
      {"id":"q7","question":"Si F(x) = x³ + 2x et on cherche F tel que F(0) = 5, alors :","options":["F(x) = x³ + 2x","F(x) = x³ + 2x + 5","F(x) = x³ + 2x - 5","F(x) = 3x² + 2"],"correct":1,"explanation":"F(x) = x³ + 2x + C. F(0) = 0 + 0 + C = 5, donc C = 5. La primitive cherchée est F(x) = x³ + 2x + 5."},
      {"id":"q8","question":"∫ₐᵇ f(x)dx représente géométriquement :","options":["La pente de la tangente","L''aire sous la courbe de f entre a et b","Le maximum de f","La dérivée de f"],"correct":1,"explanation":"L''intégrale ∫ₐᵇ f(x)dx représente l''aire algébrique sous la courbe de f entre les abscisses a et b (positive si f ≥ 0, négative si f ≤ 0)."}
    ]
  }');

  -- ============================================================
  -- MATHÉMATIQUES - Chapitre 4 : Fonctions logarithme et exponentielle
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'log-exp', 4, 'Fonctions logarithme et exponentielle', 'ln, exp, propriétés et applications', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'log-exp-fiche', 'Fonctions logarithme et exponentielle', 'Propriétés de ln et exp, équations et croissances comparées', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la fonction logarithme népérien ?","answer":"La fonction ln (logarithme népérien) est définie sur ]0;+∞[. C''est la primitive de 1/x qui s''annule en 1 : ln(1) = 0. Propriétés : ln est strictement croissante, continue, ln''(x) = 1/x. Limites : lim(x→0⁺) ln x = -∞, lim(x→+∞) ln x = +∞. Valeur particulière : ln(e) = 1, où e ≈ 2,718."},
      {"id":"fc2","category":"Exemple","question":"Quelles sont les propriétés algébriques de ln ?","answer":"Propriétés de ln : ln(ab) = ln a + ln b ; ln(a/b) = ln a - ln b ; ln(aⁿ) = n ln a ; ln(1/a) = -ln a ; ln(√a) = (1/2)ln a. Ces propriétés transforment les produits en sommes, les quotients en différences, les puissances en produits. Elles sont essentielles pour résoudre les équations et simplifier les expressions."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que la fonction exponentielle ?","answer":"La fonction exponentielle (exp ou eˣ) est la réciproque de ln : y = eˣ ⟺ x = ln y. Propriétés : exp est définie sur ℝ, strictement croissante, toujours positive (eˣ > 0). exp''(x) = eˣ (sa propre dérivée). Limites : lim(x→-∞) eˣ = 0, lim(x→+∞) eˣ = +∞. Valeurs : e⁰ = 1, e¹ = e ≈ 2,718."},
      {"id":"fc4","category":"Exemple","question":"Quelles sont les propriétés algébriques de exp ?","answer":"Propriétés de exp : eᵃ⁺ᵇ = eᵃ × eᵇ ; eᵃ⁻ᵇ = eᵃ/eᵇ ; (eᵃ)ⁿ = eⁿᵃ ; e⁻ᵃ = 1/eᵃ ; e⁰ = 1. Relations ln-exp : ln(eˣ) = x (pour tout x réel), e^(ln x) = x (pour x > 0). Ces fonctions sont réciproques l''une de l''autre."},
      {"id":"fc5","category":"Méthode","question":"Comment résoudre une équation avec ln ou exp ?","answer":"Avec ln : ln(f(x)) = a ⟺ f(x) = eᵃ (condition : f(x) > 0). Exemple : ln(2x-1) = 3 ⟺ 2x-1 = e³ ⟺ x = (e³+1)/2. Avec exp : eᶠ⁽ˣ⁾ = a ⟺ f(x) = ln a (condition : a > 0). Exemple : e²ˣ = 5 ⟺ 2x = ln 5 ⟺ x = ln 5/2. Toujours vérifier le domaine de validité."},
      {"id":"fc6","category":"Définition","question":"Que disent les croissances comparées ?","answer":"Les croissances comparées établissent une hiérarchie en +∞ : ln x << xⁿ << eˣ. Formules : lim(x→+∞) ln(x)/x = 0 (exp croît plus vite que ln). lim(x→+∞) xⁿ/eˣ = 0 (exp croît plus vite que tout polynôme). lim(x→0⁺) x ln x = 0. Ces résultats servent à lever des formes indéterminées ∞/∞ ou 0×∞."},
      {"id":"fc7","category":"Exemple","question":"Comment étudier une fonction avec exp ?","answer":"Exemple : f(x) = xe⁻ˣ. 1) Domaine : ℝ. 2) Limites : lim(x→+∞) xe⁻ˣ = 0 (croissance comparée) ; lim(x→-∞) xe⁻ˣ = -∞. 3) Dérivée : f''(x) = e⁻ˣ + x(-e⁻ˣ) = e⁻ˣ(1-x). 4) f''(x) = 0 pour x = 1. f'' > 0 si x < 1, f'' < 0 si x > 1. 5) Maximum en x = 1 : f(1) = e⁻¹ = 1/e. 6) Asymptote y = 0 en +∞."},
      {"id":"fc8","category":"Méthode","question":"Comment dériver les fonctions composées avec ln et exp ?","answer":"Dérivées composées : [ln(u)]'' = u''/u (u > 0) ; [eᵘ]'' = u''eᵘ. Exemples : [ln(x²+1)]'' = 2x/(x²+1) ; [e³ˣ]'' = 3e³ˣ ; [ln(sin x)]'' = cos x/sin x = 1/tan x. Ces formules combinent la dérivée de la fonction extérieure et la dérivée de la fonction intérieure (règle de la chaîne)."}
    ],
    "schema": {
      "title": "Logarithme et exponentielle",
      "nodes": [
        {"id":"n1","label":"ln et exp","type":"main"},
        {"id":"n2","label":"Fonction ln","type":"branch"},
        {"id":"n3","label":"Fonction exp","type":"branch"},
        {"id":"n4","label":"Applications","type":"branch"},
        {"id":"n5","label":"ln(ab)=ln a+ln b","type":"leaf"},
        {"id":"n6","label":"ln''(x)=1/x","type":"leaf"},
        {"id":"n7","label":"eᵃ⁺ᵇ=eᵃ×eᵇ","type":"leaf"},
        {"id":"n8","label":"(eˣ)''=eˣ","type":"leaf"},
        {"id":"n9","label":"Croissances comparées","type":"leaf"},
        {"id":"n10","label":"Équations ln/exp","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"sur ]0;+∞["},
        {"from":"n1","to":"n3","label":"sur ℝ"},
        {"from":"n1","to":"n4","label":"usage"},
        {"from":"n2","to":"n5","label":"propriétés"},
        {"from":"n2","to":"n6","label":"dérivée"},
        {"from":"n3","to":"n7","label":"propriétés"},
        {"from":"n3","to":"n8","label":"dérivée"},
        {"from":"n4","to":"n9","label":"comparaison"},
        {"from":"n4","to":"n10","label":"résolution"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"ln(1) = ?","options":["1","0","e","-1"],"correct":1,"explanation":"ln(1) = 0 par définition. C''est une propriété fondamentale du logarithme népérien."},
      {"id":"q2","question":"ln(ab) = ?","options":["ln a × ln b","ln a + ln b","ln a - ln b","(ln a)ᵇ"],"correct":1,"explanation":"ln(ab) = ln a + ln b. Le logarithme transforme un produit en somme. C''est la propriété fondamentale du logarithme."},
      {"id":"q3","question":"La dérivée de eˣ est :","options":["xeˣ⁻¹","eˣ","eˣ⁺¹","1/eˣ"],"correct":1,"explanation":"La fonction exponentielle est sa propre dérivée : (eˣ)'' = eˣ. C''est la propriété caractéristique de la fonction exponentielle."},
      {"id":"q4","question":"e⁰ = ?","options":["0","1","e","∞"],"correct":1,"explanation":"e⁰ = 1, car pour tout nombre a ≠ 0, a⁰ = 1. C''est aussi cohérent avec ln(1) = 0, donc e^(ln 1) = e⁰ = 1."},
      {"id":"q5","question":"ln(e) = ?","options":["0","1","e","2,718"],"correct":1,"explanation":"ln(e) = 1 par définition. Le nombre e est la base du logarithme népérien, et ln est la réciproque de exp."},
      {"id":"q6","question":"lim(x→+∞) ln(x)/x = ?","options":["1","+∞","0","-∞"],"correct":2,"explanation":"lim(x→+∞) ln(x)/x = 0. C''est un résultat de croissance comparée : la puissance x croît plus vite que ln x."},
      {"id":"q7","question":"Si ln(x) = 2, alors x = ?","options":["2","e²","ln 2","2e"],"correct":1,"explanation":"ln(x) = 2 ⟺ x = e² (par définition de la réciproque). e² ≈ 7,389."},
      {"id":"q8","question":"La dérivée de ln(x²+1) est :","options":["1/(x²+1)","2x/(x²+1)","2x ln(x²+1)","(x²+1)/2x"],"correct":1,"explanation":"Par la règle de la composée : [ln(u)]'' = u''/u. Ici u = x²+1, u'' = 2x. Donc [ln(x²+1)]'' = 2x/(x²+1)."}
    ]
  }');

  -- ============================================================
  -- MATHÉMATIQUES - Chapitre 5 : Statistiques et ajustement
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (maths_id, 'statistiques-ajustement', 5, 'Statistiques et ajustement', 'Caractères, représentations, moyenne/médiane, ajustement linéaire', 5)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'statistiques-ajustement-fiche', 'Statistiques et ajustement', 'Séries statistiques, paramètres et ajustement affine', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quels sont les types de caractères statistiques ?","answer":"Un caractère est la propriété étudiée sur une population. Deux types : 1) Caractère qualitatif : ne se mesure pas par un nombre (couleur, profession, sexe). Modalités : catégories. 2) Caractère quantitatif : se mesure par un nombre. Discret : valeurs isolées (nombre d''enfants : 0, 1, 2...). Continu : valeurs dans un intervalle (taille, poids). L''effectif est le nombre d''individus pour chaque modalité."},
      {"id":"fc2","category":"Définition","question":"Quels sont les principaux paramètres de position ?","answer":"Paramètres de position : 1) Moyenne x̄ = Σ(nᵢxᵢ)/N, où nᵢ est l''effectif et N l''effectif total. 2) Médiane Me : valeur qui partage la série en deux parties égales (50 % au-dessus, 50 % en dessous). 3) Mode Mo : valeur de plus grand effectif. Exemple : notes 8, 10, 10, 12, 15. Moyenne = 11, Médiane = 10, Mode = 10."},
      {"id":"fc3","category":"Définition","question":"Quels sont les paramètres de dispersion ?","answer":"Paramètres de dispersion : 1) Étendue = max - min. 2) Variance V = Σnᵢ(xᵢ-x̄)²/N ou V = (Σnᵢxᵢ²/N) - x̄². 3) Écart-type σ = √V. L''écart-type mesure la dispersion autour de la moyenne : plus il est grand, plus les valeurs sont dispersées. Un écart-type faible signifie des valeurs regroupées autour de la moyenne."},
      {"id":"fc4","category":"Exemple","question":"Quelles sont les représentations graphiques en statistiques ?","answer":"Représentations : 1) Diagramme en bâtons (caractère discret). 2) Histogramme (caractère continu, classes). 3) Diagramme circulaire (pourcentages). 4) Polygone des effectifs (courbe reliant les sommets des bâtons). 5) Courbe des effectifs cumulés (permet de lire la médiane graphiquement). 6) Nuage de points (série double, pour l''ajustement). Le choix dépend du type de caractère."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce qu''un ajustement affine ?","answer":"L''ajustement affine consiste à trouver la droite y = ax + b qui s''ajuste le mieux à un nuage de points (xᵢ, yᵢ). Méthode des moindres carrés : minimise la somme des carrés des écarts entre les valeurs observées et les valeurs de la droite. Formules : a = Σ(xᵢ-x̄)(yᵢ-ȳ) / Σ(xᵢ-x̄)² = Cov(X,Y)/V(X) ; b = ȳ - ax̄. La droite passe par le point moyen G(x̄, ȳ)."},
      {"id":"fc6","category":"Méthode","question":"Comment calculer la moyenne d''une série avec effectifs ?","answer":"Méthode : 1) Multiplier chaque valeur xᵢ par son effectif nᵢ. 2) Additionner tous les produits. 3) Diviser par l''effectif total N. Formule : x̄ = (n₁x₁ + n₂x₂ + ... + nₖxₖ) / N. Pour une série en classes : prendre le centre de chaque classe comme valeur. Exemple : classe [10;20[, centre = 15."},
      {"id":"fc7","category":"Méthode","question":"Comment déterminer la médiane ?","answer":"Méthode : 1) Ordonner les valeurs. 2) Si N est impair : la médiane est la valeur de rang (N+1)/2. 3) Si N est pair : la médiane est la moyenne des valeurs de rang N/2 et N/2+1. Graphiquement : la médiane se lit sur la courbe des effectifs cumulés croissants, en projetant N/2. Pour les séries en classes : interpolation linéaire dans la classe médiane."},
      {"id":"fc8","category":"Exemple","question":"Comment utiliser l''ajustement pour faire des prévisions ?","answer":"L''ajustement affine y = ax + b permet de faire des prévisions en remplaçant x par la valeur souhaitée. Exemple : si les ventes suivent y = 3x + 10 (x en années depuis 2020), les ventes prévues en 2025 (x=5) sont y = 3×5 + 10 = 25. Attention : la prévision n''est fiable que pour des valeurs proches de l''intervalle d''observation (extrapolation limitée)."}
    ],
    "schema": {
      "title": "Statistiques et ajustement",
      "nodes": [
        {"id":"n1","label":"Statistiques","type":"main"},
        {"id":"n2","label":"Caractères","type":"branch"},
        {"id":"n3","label":"Paramètres","type":"branch"},
        {"id":"n4","label":"Ajustement","type":"branch"},
        {"id":"n5","label":"Qualitatif / Quantitatif","type":"leaf"},
        {"id":"n6","label":"Moyenne, médiane, mode","type":"leaf"},
        {"id":"n7","label":"Variance, écart-type","type":"leaf"},
        {"id":"n8","label":"Droite y = ax + b","type":"leaf"},
        {"id":"n9","label":"Moindres carrés","type":"leaf"},
        {"id":"n10","label":"Représentations graphiques","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"types"},
        {"from":"n1","to":"n3","label":"résumés"},
        {"from":"n1","to":"n4","label":"modélisation"},
        {"from":"n2","to":"n5","label":"classification"},
        {"from":"n3","to":"n6","label":"position"},
        {"from":"n3","to":"n7","label":"dispersion"},
        {"from":"n4","to":"n8","label":"droite"},
        {"from":"n4","to":"n9","label":"méthode"},
        {"from":"n1","to":"n10","label":"visualisation"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La moyenne de 5, 10, 15, 20 est :","options":["10","12,5","15","50"],"correct":1,"explanation":"Moyenne = (5+10+15+20)/4 = 50/4 = 12,5. On additionne toutes les valeurs et on divise par le nombre de valeurs."},
      {"id":"q2","question":"La médiane d''une série ordonnée de 7 valeurs est la valeur de rang :","options":["3","4","3,5","7"],"correct":1,"explanation":"Pour N = 7 (impair), la médiane est la valeur de rang (7+1)/2 = 4. C''est la 4e valeur de la série ordonnée."},
      {"id":"q3","question":"L''écart-type mesure :","options":["La valeur centrale","La dispersion autour de la moyenne","Le nombre de valeurs","La valeur la plus fréquente"],"correct":1,"explanation":"L''écart-type (σ = √V) mesure la dispersion des valeurs autour de la moyenne. Plus il est élevé, plus les valeurs sont étalées."},
      {"id":"q4","question":"Un caractère quantitatif discret est :","options":["Un caractère mesuré par des catégories","Un caractère prenant des valeurs isolées","Un caractère prenant des valeurs dans un intervalle","Un caractère non mesurable"],"correct":1,"explanation":"Un caractère quantitatif discret prend des valeurs isolées (nombre d''enfants, nombre de pièces). Un caractère continu prend des valeurs dans un intervalle (taille, poids)."},
      {"id":"q5","question":"La droite d''ajustement passe toujours par :","options":["L''origine (0,0)","Le point moyen G(x̄, ȳ)","Le premier point du nuage","Le dernier point du nuage"],"correct":1,"explanation":"La droite d''ajustement par les moindres carrés passe toujours par le point moyen G(x̄, ȳ), où x̄ et ȳ sont les moyennes des deux variables."},
      {"id":"q6","question":"La variance est :","options":["La racine carrée de l''écart-type","Le carré de l''écart-type","La moyenne des valeurs","L''étendue divisée par 2"],"correct":1,"explanation":"La variance V est le carré de l''écart-type : V = σ². Elle mesure la dispersion autour de la moyenne. L''écart-type σ = √V est plus couramment utilisé car il a la même unité que les données."},
      {"id":"q7","question":"Le mode d''une série est :","options":["La valeur centrale","La plus grande valeur","La valeur la plus fréquente","La moyenne"],"correct":2,"explanation":"Le mode est la valeur de la série qui a le plus grand effectif (la plus fréquente). Une série peut avoir plusieurs modes (bimodale, multimodale)."},
      {"id":"q8","question":"La méthode des moindres carrés vise à :","options":["Maximiser les écarts","Minimiser la somme des carrés des écarts entre valeurs observées et valeurs ajustées","Trouver la médiane","Calculer la variance"],"correct":1,"explanation":"La méthode des moindres carrés détermine la droite d''ajustement en minimisant la somme des carrés des écarts entre les valeurs observées yᵢ et les valeurs prédites par la droite."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - Chapitre 1 : Oral communication
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'oral-communication', 1, 'Oral communication', 'Spoken English, debates, social issues', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'oral-communication-fiche', 'Oral communication', 'Speaking skills, debates and discussion of social issues', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"What are the key elements of oral communication?","answer":"Key elements: 1) Pronunciation: clear articulation of sounds, stress patterns, intonation. 2) Fluency: speaking smoothly without excessive pauses. 3) Vocabulary: using appropriate words for the context. 4) Grammar: correct sentence structures. 5) Body language: gestures, eye contact, posture. 6) Listening: understanding and responding to others. Good oral communication requires practice and confidence."},
      {"id":"fc2","category":"Méthode","question":"How to structure a debate speech?","answer":"Structure: 1) Introduction: greet the audience, state your position clearly (I strongly believe that...). 2) Arguments: present 2-3 main points with examples and evidence. Use linking words (firstly, moreover, furthermore). 3) Counter-arguments: acknowledge the opposing view and refute it (While some may argue... however...). 4) Conclusion: summarize your points and restate your position. Use formal language and persuasive techniques."},
      {"id":"fc3","category":"Exemple","question":"What vocabulary is used to express opinions?","answer":"Expressing opinions: I believe/think that..., In my opinion/view..., As far as I am concerned..., It seems to me that... Agreeing: I totally agree, That is a valid point, I share your view. Disagreeing: I respectfully disagree, I see your point but..., I beg to differ. Adding ideas: Furthermore, Moreover, In addition, Besides. Concluding: In conclusion, To sum up, All things considered."},
      {"id":"fc4","category":"Exemple","question":"What are common social issues discussed in debates?","answer":"Common social issues: 1) Education: access, quality, girl education in Africa. 2) Health: malaria, HIV/AIDS, healthcare access. 3) Environment: deforestation, pollution, climate change. 4) Migration: brain drain, refugees, economic migration. 5) Gender equality: women''s rights, early marriage. 6) Technology: digital divide, social media impact. 7) Poverty: causes, solutions, international aid. These topics are relevant to the Malian baccalaureate."},
      {"id":"fc5","category":"Méthode","question":"How to improve pronunciation in English?","answer":"Tips: 1) Listen to native speakers (BBC, CNN, podcasts). 2) Practice minimal pairs (ship/sheep, live/leave). 3) Learn word stress patterns (PHOtograph vs phoTOGraphy). 4) Master intonation (rising for yes/no questions, falling for statements). 5) Record yourself and compare. 6) Read aloud regularly. 7) Focus on sounds that don''t exist in French/Bambara (/th/, /h/, /r/). Regular practice builds confidence and fluency."},
      {"id":"fc6","category":"Exemple","question":"How to discuss education in Mali in English?","answer":"Key vocabulary: literacy rate, enrollment, dropout rate, school attendance, gender gap, vocational training, curriculum. Sample sentences: Mali faces challenges in education such as low literacy rates and high dropout rates. Girl education remains a priority because educated women contribute to economic development. The government has implemented programs to improve access to quality education in rural areas."},
      {"id":"fc7","category":"Méthode","question":"What are useful linking words for oral presentations?","answer":"Sequencing: First(ly), Second(ly), Then, Next, Finally. Adding: Moreover, Furthermore, In addition, Besides, Also. Contrasting: However, Nevertheless, On the other hand, Although, Despite. Cause/Effect: Therefore, Consequently, As a result, Because, Due to. Examples: For instance, For example, Such as. Concluding: In conclusion, To sum up, Overall, All in all."},
      {"id":"fc8","category":"Distinction","question":"What is the difference between formal and informal English?","answer":"Formal English: used in speeches, academic writing, official settings. Features: complete sentences, no contractions (do not vs don''t), passive voice, polished vocabulary. Informal English: used with friends, casual conversations. Features: contractions (I''m, can''t), slang, phrasal verbs (hang out, figure out), shorter sentences. In the baccalaureate oral exam, use formal or semi-formal English."}
    ],
    "schema": {
      "title": "Oral Communication",
      "nodes": [
        {"id":"n1","label":"Oral Communication","type":"main"},
        {"id":"n2","label":"Speaking Skills","type":"branch"},
        {"id":"n3","label":"Debate Skills","type":"branch"},
        {"id":"n4","label":"Social Issues","type":"branch"},
        {"id":"n5","label":"Pronunciation, fluency","type":"leaf"},
        {"id":"n6","label":"Structure, arguments","type":"leaf"},
        {"id":"n7","label":"Opinion expressions","type":"leaf"},
        {"id":"n8","label":"Education, health, environment","type":"leaf"},
        {"id":"n9","label":"Linking words","type":"leaf"},
        {"id":"n10","label":"Formal vs informal","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"practice"},
        {"from":"n1","to":"n3","label":"argumentation"},
        {"from":"n1","to":"n4","label":"topics"},
        {"from":"n2","to":"n5","label":"elements"},
        {"from":"n3","to":"n6","label":"organization"},
        {"from":"n3","to":"n7","label":"language"},
        {"from":"n4","to":"n8","label":"themes"},
        {"from":"n2","to":"n9","label":"coherence"},
        {"from":"n2","to":"n10","label":"register"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Which phrase is used to express a strong opinion?","options":["I don''t know","I strongly believe that...","Maybe","It doesn''t matter"],"correct":1,"explanation":"\"I strongly believe that...\" is a formal way to express a strong opinion. Other options are too vague or informal for a debate."},
      {"id":"q2","question":"Which linking word shows contrast?","options":["Moreover","However","Furthermore","In addition"],"correct":1,"explanation":"\"However\" introduces a contrasting idea. \"Moreover\", \"Furthermore\", and \"In addition\" are used to add supporting ideas."},
      {"id":"q3","question":"In a debate, what should you do after presenting your arguments?","options":["Stop talking","Acknowledge and refute counter-arguments","Change the topic","Agree with the opponent"],"correct":1,"explanation":"A strong debater acknowledges the opposing view and refutes it with evidence. This shows critical thinking and strengthens your position."},
      {"id":"q4","question":"Which is an example of formal English?","options":["Gonna","I would like to express my viewpoint","What''s up?","Cool!"],"correct":1,"explanation":"\"I would like to express my viewpoint\" is formal. \"Gonna\", \"What''s up?\" and \"Cool!\" are informal expressions."},
      {"id":"q5","question":"What does ''brain drain'' mean?","options":["A disease","The migration of skilled workers to other countries","A type of exercise","A computer problem"],"correct":1,"explanation":"Brain drain refers to the emigration of highly educated or skilled people from developing countries to developed countries, seeking better opportunities."},
      {"id":"q6","question":"Which word means ''taux d''alphabétisation'' in English?","options":["Dropout rate","Enrollment rate","Literacy rate","Birth rate"],"correct":2,"explanation":"Literacy rate means ''taux d''alphabétisation'', the percentage of people who can read and write. Mali''s literacy rate is about 35%."},
      {"id":"q7","question":"To conclude a speech, you can say:","options":["By the way","In conclusion","On the other hand","For example"],"correct":1,"explanation":"\"In conclusion\" is used to signal the end of a speech and introduce a summary. Other options serve different purposes in discourse."},
      {"id":"q8","question":"What is intonation?","options":["Speaking loudly","The rise and fall of voice pitch","Writing neatly","Using big words"],"correct":1,"explanation":"Intonation is the rise and fall of voice pitch when speaking. In English, rising intonation is used for yes/no questions, falling intonation for statements and wh-questions."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - Chapitre 2 : Reading comprehension
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'reading-comprehension', 2, 'Reading comprehension', 'Text types, True/False, inferential questions', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'reading-comprehension-fiche', 'Reading comprehension', 'Strategies for understanding and analyzing texts', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"What is reading comprehension?","answer":"Reading comprehension is the ability to read a text, understand its meaning, and interpret its content. It involves: 1) Understanding vocabulary in context. 2) Identifying main ideas and supporting details. 3) Making inferences (reading between the lines). 4) Distinguishing facts from opinions. 5) Understanding the author''s purpose and tone. In the baccalaureate, students must answer questions based on a text passage."},
      {"id":"fc2","category":"Méthode","question":"What strategies help with reading comprehension?","answer":"Strategies: 1) Skim the text first for general understanding. 2) Read the questions before re-reading carefully. 3) Underline key words in questions and text. 4) Use context clues to guess unknown words. 5) Look for topic sentences (usually first sentence of each paragraph). 6) Identify transition words that show text structure. 7) Distinguish between explicit information (stated) and implicit information (implied). 8) Answer in your own words unless asked to quote."},
      {"id":"fc3","category":"Méthode","question":"How to answer True/False/Not Given questions?","answer":"Method: 1) Read the statement carefully. 2) Find the relevant section in the text. 3) TRUE: the text clearly states the same information. 4) FALSE: the text clearly states the opposite. 5) NOT GIVEN: the text does not mention this information at all. Common mistake: choosing FALSE when the answer is NOT GIVEN. Always justify by quoting or paraphrasing the relevant passage."},
      {"id":"fc4","category":"Exemple","question":"What are common text types in the baccalaureate?","answer":"Text types: 1) Narrative: tells a story (novels, short stories). 2) Descriptive: describes people, places, events. 3) Argumentative: presents and defends a viewpoint (editorials, essays). 4) Informative/Expository: provides facts and information (articles, reports). 5) Dialogue: conversation between characters. Each type has specific features: tone, vocabulary, structure. Identify the text type to better understand the author''s purpose."},
      {"id":"fc5","category":"Méthode","question":"How to answer inferential questions?","answer":"Inferential questions ask what is implied but not directly stated. Method: 1) Look for clues in the text (word choice, tone, context). 2) Use your own knowledge combined with text evidence. 3) Ask: What does the author suggest? What can we conclude? 4) Avoid wild guesses; the answer must be supported by the text. Signal words in questions: infer, suggest, imply, conclude, deduce. Example: ''What does the author imply about...?''"},
      {"id":"fc6","category":"Définition","question":"What are context clues?","answer":"Context clues are hints in the surrounding text that help you understand an unknown word. Types: 1) Definition clue: the word is defined in the sentence. 2) Synonym clue: a similar word is used nearby. 3) Antonym clue: an opposite word with contrast markers (but, however). 4) Example clue: examples clarify the meaning. 5) General context: the overall meaning of the sentence/paragraph helps. Example: ''The arid desert'' — arid means dry (context of desert)."},
      {"id":"fc7","category":"Méthode","question":"How to identify the main idea of a text?","answer":"The main idea is the central message. To find it: 1) Read the title and introduction carefully. 2) Look at the first and last paragraphs. 3) Identify the topic sentence of each paragraph. 4) Ask: What is the text mainly about? 5) Distinguish the main idea from supporting details. 6) Summarize the text in one sentence. The main idea should cover the whole text, not just one paragraph."},
      {"id":"fc8","category":"Exemple","question":"What vocabulary is useful for text analysis?","answer":"Analysis vocabulary: The text deals with / is about... The author argues/claims/suggests that... According to the text... The passage highlights/emphasizes... This sentence implies/suggests... The tone is formal/informal/critical/objective. The author uses examples to illustrate... In the first/second paragraph, the author explains... The text concludes by stating..."}
    ],
    "schema": {
      "title": "Reading Comprehension",
      "nodes": [
        {"id":"n1","label":"Reading Comprehension","type":"main"},
        {"id":"n2","label":"Strategies","type":"branch"},
        {"id":"n3","label":"Question Types","type":"branch"},
        {"id":"n4","label":"Text Analysis","type":"branch"},
        {"id":"n5","label":"Skimming, scanning","type":"leaf"},
        {"id":"n6","label":"Context clues","type":"leaf"},
        {"id":"n7","label":"True/False/Not Given","type":"leaf"},
        {"id":"n8","label":"Inferential questions","type":"leaf"},
        {"id":"n9","label":"Main idea, details","type":"leaf"},
        {"id":"n10","label":"Text types","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"how to read"},
        {"from":"n1","to":"n3","label":"answering"},
        {"from":"n1","to":"n4","label":"understanding"},
        {"from":"n2","to":"n5","label":"techniques"},
        {"from":"n2","to":"n6","label":"vocabulary"},
        {"from":"n3","to":"n7","label":"factual"},
        {"from":"n3","to":"n8","label":"implied"},
        {"from":"n4","to":"n9","label":"structure"},
        {"from":"n4","to":"n10","label":"genres"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Skimming a text means:","options":["Reading every word carefully","Reading quickly for the general idea","Translating into French","Copying the text"],"correct":1,"explanation":"Skimming means reading quickly to get the general idea of the text, without focusing on every detail. It''s the first step in reading comprehension."},
      {"id":"q2","question":"In True/False/Not Given, ''Not Given'' means:","options":["The statement is false","The statement is true","The text does not mention this information","The statement is an opinion"],"correct":2,"explanation":"''Not Given'' means the text does not contain information to confirm or deny the statement. It is neither supported nor contradicted by the text."},
      {"id":"q3","question":"An inferential question asks you to:","options":["Copy from the text","Understand what is implied but not directly stated","Count the words","Translate the text"],"correct":1,"explanation":"Inferential questions require you to read between the lines and understand what the author implies or suggests, using clues from the text."},
      {"id":"q4","question":"A topic sentence is usually found:","options":["At the end of the text","In the middle of a paragraph","At the beginning of a paragraph","In the title only"],"correct":2,"explanation":"The topic sentence, which states the main idea of a paragraph, is usually found at the beginning. The rest of the paragraph provides supporting details."},
      {"id":"q5","question":"Which text type presents and defends a viewpoint?","options":["Narrative","Descriptive","Argumentative","Dialogue"],"correct":2,"explanation":"An argumentative text presents a position on an issue and uses evidence, reasoning, and examples to defend it. Editorials and essays are common examples."},
      {"id":"q6","question":"Context clues help you:","options":["Write better","Guess the meaning of unknown words from surrounding text","Memorize vocabulary","Pronounce words correctly"],"correct":1,"explanation":"Context clues are hints in the surrounding text that help you understand the meaning of an unknown word without using a dictionary."},
      {"id":"q7","question":"''The author suggests that...'' is an example of:","options":["A factual question","An inferential question","A vocabulary question","A grammar question"],"correct":1,"explanation":"When a question uses words like ''suggest'', ''imply'', or ''infer'', it is an inferential question requiring you to understand what is implied rather than explicitly stated."},
      {"id":"q8","question":"To find the main idea of a text, you should:","options":["Read only the first sentence","Look at every paragraph and summarize the central message","Count the paragraphs","Focus on difficult words"],"correct":1,"explanation":"The main idea covers the entire text. You need to consider all paragraphs, identify their topic sentences, and determine the central message that ties everything together."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - Chapitre 3 : Writing skills
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'writing-skills', 3, 'Writing skills', 'Essays, letters, opinion writing', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'writing-skills-fiche', 'Writing skills', 'Essay writing, letter format and opinion paragraphs', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"What are the main types of writing in the baccalaureate?","answer":"Main types: 1) Essay (composition): argumentative or expository writing on a given topic. 2) Letter: formal or informal, to express an opinion, make a request, or apply for something. 3) Opinion paragraph: express and justify your view on an issue. 4) Summary: condense a text into main points. 5) Dialogue writing: create a conversation. Each type has specific conventions for structure, tone, and language."},
      {"id":"fc2","category":"Méthode","question":"How to write a good essay?","answer":"Essay structure: 1) Introduction: hook (question, quote, fact), background context, thesis statement (your main argument). 2) Body paragraphs (2-3): each with a topic sentence, supporting details/examples, explanation. Use linking words. 3) Conclusion: restate thesis, summarize main points, give a final thought or recommendation. Tips: plan before writing, use varied vocabulary, check grammar, stay on topic."},
      {"id":"fc3","category":"Exemple","question":"How to write a formal letter?","answer":"Formal letter format: 1) Your address (top right). 2) Date. 3) Recipient''s address (left). 4) Salutation: Dear Sir/Madam (unknown) or Dear Mr./Mrs. X. 5) Introduction: state the purpose. 6) Body: develop your points. 7) Conclusion: summarize and state expected action. 8) Closing: Yours faithfully (unknown) or Yours sincerely (known name). Use formal language, avoid contractions."},
      {"id":"fc4","category":"Exemple","question":"How to write an informal letter?","answer":"Informal letter format: 1) Date (top right). 2) Greeting: Dear [first name], Hi [name]. 3) Opening: How are you? I hope you are doing well. 4) Body: share news, respond to their letter, discuss topics. 5) Closing: Write back soon, Take care, Looking forward to hearing from you. 6) Sign-off: Love, Best wishes, Yours, + your first name. Use contractions, casual vocabulary, personal tone."},
      {"id":"fc5","category":"Méthode","question":"How to write an opinion paragraph?","answer":"Structure: 1) Topic sentence: state your opinion clearly (In my opinion, I believe that...). 2) Supporting arguments: give 2-3 reasons with examples. Use linking words (Firstly, Moreover, For example). 3) Counter-argument (optional): mention the opposing view and explain why you disagree. 4) Concluding sentence: restate your opinion in different words. Be clear, coherent, and well-organized."},
      {"id":"fc6","category":"Méthode","question":"What are common mistakes to avoid in writing?","answer":"Common mistakes: 1) Run-on sentences (too long without proper punctuation). 2) Subject-verb agreement errors (He go → He goes). 3) Wrong tense usage. 4) Spelling errors (their/there/they''re, its/it''s). 5) No paragraphing. 6) Informal language in formal writing. 7) No linking words. 8) Off-topic content. 9) Repetitive vocabulary. 10) No conclusion. Proofreading is essential before submitting."},
      {"id":"fc7","category":"Exemple","question":"What useful expressions can improve writing?","answer":"Useful expressions: Introducing: The purpose of this essay is to... Giving examples: For instance, A case in point is... Comparing: Similarly, Likewise, In the same way. Contrasting: On the contrary, Whereas, Unlike. Cause/effect: As a result, Consequently, This leads to. Emphasizing: It is important to note that, Indeed, Significantly. Concluding: In summary, To conclude, Taking everything into account."},
      {"id":"fc8","category":"Distinction","question":"What is the difference between argumentative and descriptive writing?","answer":"Argumentative writing: presents a position and defends it with evidence and reasoning. Structure: thesis → arguments → counter-arguments → conclusion. Uses persuasive language. Descriptive writing: paints a picture with words, using sensory details (sight, sound, smell, touch, taste). Uses adjectives, adverbs, and figurative language (metaphors, similes). In the bac, essays are usually argumentative."}
    ],
    "schema": {
      "title": "Writing Skills",
      "nodes": [
        {"id":"n1","label":"Writing Skills","type":"main"},
        {"id":"n2","label":"Essay Writing","type":"branch"},
        {"id":"n3","label":"Letter Writing","type":"branch"},
        {"id":"n4","label":"Techniques","type":"branch"},
        {"id":"n5","label":"Intro, body, conclusion","type":"leaf"},
        {"id":"n6","label":"Formal letter","type":"leaf"},
        {"id":"n7","label":"Informal letter","type":"leaf"},
        {"id":"n8","label":"Opinion paragraph","type":"leaf"},
        {"id":"n9","label":"Linking words","type":"leaf"},
        {"id":"n10","label":"Common mistakes","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"composition"},
        {"from":"n1","to":"n3","label":"correspondence"},
        {"from":"n1","to":"n4","label":"quality"},
        {"from":"n2","to":"n5","label":"structure"},
        {"from":"n3","to":"n6","label":"official"},
        {"from":"n3","to":"n7","label":"personal"},
        {"from":"n2","to":"n8","label":"opinion"},
        {"from":"n4","to":"n9","label":"cohesion"},
        {"from":"n4","to":"n10","label":"avoid"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"An essay introduction should contain:","options":["Only examples","A hook, background, and thesis statement","The conclusion","A list of vocabulary"],"correct":1,"explanation":"A good introduction starts with a hook (to grab attention), provides background context on the topic, and ends with a clear thesis statement (your main argument)."},
      {"id":"q2","question":"In a formal letter to an unknown recipient, you end with:","options":["Love","Best wishes","Yours faithfully","See you soon"],"correct":2,"explanation":"''Yours faithfully'' is used when you don''t know the recipient''s name (Dear Sir/Madam). ''Yours sincerely'' is used when you know the name (Dear Mr. Smith)."},
      {"id":"q3","question":"A topic sentence in a paragraph:","options":["Gives examples","States the main idea of the paragraph","Concludes the paragraph","Lists vocabulary"],"correct":1,"explanation":"The topic sentence states the main idea of the paragraph. The remaining sentences provide supporting details, examples, and explanations."},
      {"id":"q4","question":"Which is a linking word showing cause and effect?","options":["However","Furthermore","As a result","For example"],"correct":2,"explanation":"''As a result'' shows cause and effect (one thing leads to another). ''However'' shows contrast, ''Furthermore'' adds information, and ''For example'' introduces an example."},
      {"id":"q5","question":"It''s vs Its: which is correct in ''The dog wagged ___ tail''?","options":["it''s","its","it is","its''"],"correct":1,"explanation":"''Its'' (without apostrophe) is the possessive form. ''It''s'' is a contraction of ''it is'' or ''it has''. The dog wagged its tail (possessive)."},
      {"id":"q6","question":"In an opinion paragraph, you should:","options":["Only give facts","State your opinion with supporting reasons","Copy from the text","Write in French"],"correct":1,"explanation":"An opinion paragraph requires you to clearly state your opinion and support it with 2-3 reasons and examples, using appropriate linking words."},
      {"id":"q7","question":"What is a thesis statement?","options":["The title of the essay","A question","The main argument stated in the introduction","A bibliography"],"correct":2,"explanation":"A thesis statement is the main argument or position presented in the introduction of an essay. It tells the reader what the essay will argue or discuss."},
      {"id":"q8","question":"Proofreading means:","options":["Writing a first draft","Reading and correcting errors before submitting","Copying someone else''s work","Translating from French"],"correct":1,"explanation":"Proofreading is the final step in writing: carefully reading your work to find and correct spelling, grammar, punctuation, and content errors before submission."}
    ]
  }');

  -- ============================================================
  -- ANGLAIS - Chapitre 4 : Grammar and vocabulary
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (anglais_id, 'grammar-vocabulary', 4, 'Grammar and vocabulary', 'Tenses, conditionals, reported speech, vocabulary', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'grammar-vocabulary-fiche', 'Grammar and vocabulary', 'Essential grammar rules and vocabulary for the baccalaureate', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"What are the main English tenses?","answer":"Key tenses: 1) Present simple (I work) — habits, facts. 2) Present continuous (I am working) — action in progress. 3) Past simple (I worked) — completed past action. 4) Present perfect (I have worked) — past action with present relevance. 5) Past continuous (I was working) — ongoing past action. 6) Future simple (I will work) — prediction/decision. 7) Going to (I am going to work) — planned future. Master these for the bac."},
      {"id":"fc2","category":"Exemple","question":"How do conditional sentences work?","answer":"Conditionals: 1) Zero conditional: If + present, present. (If you heat water, it boils — general truth). 2) First conditional: If + present, will + base verb. (If it rains, I will stay home — real future possibility). 3) Second conditional: If + past simple, would + base verb. (If I were rich, I would travel — unreal/hypothetical). 4) Third conditional: If + past perfect, would have + past participle. (If I had studied, I would have passed — unreal past)."},
      {"id":"fc3","category":"Méthode","question":"How does reported speech work?","answer":"Reported (indirect) speech reports what someone said. Changes: 1) Tense shift: present → past, past → past perfect, will → would. 2) Pronouns change: I → he/she, we → they. 3) Time expressions: today → that day, tomorrow → the next day, yesterday → the day before. Examples: He said, ''I am tired'' → He said that he was tired. She asked, ''Where do you live?'' → She asked where I lived. No question mark in reported questions."},
      {"id":"fc4","category":"Définition","question":"What is the passive voice?","answer":"The passive voice emphasizes the action or object rather than the doer. Formation: subject + be (conjugated) + past participle (+ by agent). Active: The teacher corrects the exams → Passive: The exams are corrected by the teacher. Tenses: Present: is/are + PP. Past: was/were + PP. Future: will be + PP. Present perfect: has/have been + PP. Use passive when the doer is unknown, unimportant, or obvious."},
      {"id":"fc5","category":"Exemple","question":"What are common phrasal verbs?","answer":"Essential phrasal verbs: look for (chercher), look after (s''occuper de), give up (abandonner), carry out (réaliser), bring up (élever/évoquer), turn down (refuser), set up (établir), find out (découvrir), make up (inventer/se réconcilier), break down (tomber en panne). Phrasal verbs are common in English but can be tricky because their meaning is often different from the individual words."},
      {"id":"fc6","category":"Définition","question":"What are relative pronouns and clauses?","answer":"Relative pronouns introduce relative clauses: who (people), which (things), that (people/things), whose (possession), where (place), when (time). Defining clause (essential, no commas): The man who lives next door is a teacher. Non-defining clause (extra info, commas): My brother, who lives in Bamako, is a doctor. Relative clauses add information about a noun in the main clause."},
      {"id":"fc7","category":"Exemple","question":"What vocabulary themes are important for the bac?","answer":"Key themes: 1) Education: school, curriculum, literacy, scholarship. 2) Environment: pollution, deforestation, renewable energy, global warming. 3) Health: disease, vaccination, healthcare, sanitation. 4) Technology: Internet, digital, innovation, artificial intelligence. 5) Society: poverty, inequality, migration, human rights. 6) Culture: tradition, heritage, festival, diversity. 7) Economy: development, trade, employment, GDP."},
      {"id":"fc8","category":"Méthode","question":"How to form comparative and superlative adjectives?","answer":"Short adjectives (1-2 syllables): comparative: adj + -er + than (taller than). Superlative: the + adj + -est (the tallest). Long adjectives (3+ syllables): more/less + adj + than (more beautiful than). Most/least + adj (the most beautiful). Irregular: good → better → the best. Bad → worse → the worst. Far → farther/further → the farthest/furthest. Much/many → more → the most. Little → less → the least."}
    ],
    "schema": {
      "title": "Grammar and Vocabulary",
      "nodes": [
        {"id":"n1","label":"Grammar & Vocabulary","type":"main"},
        {"id":"n2","label":"Tenses","type":"branch"},
        {"id":"n3","label":"Advanced Grammar","type":"branch"},
        {"id":"n4","label":"Vocabulary","type":"branch"},
        {"id":"n5","label":"Present, past, future","type":"leaf"},
        {"id":"n6","label":"Conditionals (0-3)","type":"leaf"},
        {"id":"n7","label":"Reported speech","type":"leaf"},
        {"id":"n8","label":"Passive voice","type":"leaf"},
        {"id":"n9","label":"Phrasal verbs","type":"leaf"},
        {"id":"n10","label":"Thematic vocabulary","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"verb forms"},
        {"from":"n1","to":"n3","label":"structures"},
        {"from":"n1","to":"n4","label":"words"},
        {"from":"n2","to":"n5","label":"simple/continuous"},
        {"from":"n3","to":"n6","label":"if clauses"},
        {"from":"n3","to":"n7","label":"indirect speech"},
        {"from":"n3","to":"n8","label":"be + past participle"},
        {"from":"n4","to":"n9","label":"multi-word verbs"},
        {"from":"n4","to":"n10","label":"bac themes"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Which tense: ''If I were rich, I would travel''?","options":["First conditional","Second conditional","Third conditional","Zero conditional"],"correct":1,"explanation":"This is the second conditional (If + past simple, would + base verb), used for unreal or hypothetical situations in the present/future."},
      {"id":"q2","question":"Convert to reported speech: He said, ''I am happy''","options":["He said that I am happy","He said that he was happy","He said that he is happy","He said that he will be happy"],"correct":1,"explanation":"In reported speech, ''I am'' changes to ''he was'' (pronoun change + tense shift from present to past)."},
      {"id":"q3","question":"The passive of ''They built the school'' is:","options":["The school was built by them","The school built them","They were built by the school","The school is building"],"correct":0,"explanation":"Active: They built the school → Passive: The school was built (by them). The object becomes the subject, the verb becomes was/were + past participle."},
      {"id":"q4","question":"The present perfect is used for:","options":["A habit","A past action with present relevance","A future plan","An ongoing action right now"],"correct":1,"explanation":"The present perfect (have/has + past participle) links a past action to the present: I have finished my homework (it''s done now). It is also used for experiences (I have visited Paris)."},
      {"id":"q5","question":"''Look after'' means:","options":["Regarder derrière","Chercher","S''occuper de","Admirer"],"correct":2,"explanation":"''Look after'' means to take care of (s''occuper de). Example: She looks after her younger siblings. It''s a common phrasal verb in English."},
      {"id":"q6","question":"Which relative pronoun is for people?","options":["Which","Whose","Who","Where"],"correct":2,"explanation":"''Who'' is the relative pronoun for people. ''Which'' is for things. ''Whose'' is for possession. ''Where'' is for places."},
      {"id":"q7","question":"The superlative of ''good'' is:","options":["Gooder","More good","The best","The goodest"],"correct":2,"explanation":"''Good'' is irregular: good → better (comparative) → the best (superlative). These forms must be memorized as they don''t follow regular patterns."},
      {"id":"q8","question":"In the third conditional, the ''if'' clause uses:","options":["Present simple","Past simple","Past perfect","Future"],"correct":2,"explanation":"Third conditional: If + past perfect (had + past participle), would have + past participle. It expresses an unreal condition in the past: If I had studied, I would have passed."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - Chapitre 1 : La dissertation littéraire
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'dissertation-litteraire', 1, 'La dissertation littéraire', 'Méthodologie complète de la dissertation', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'dissertation-litteraire-fiche', 'La dissertation littéraire', 'Méthodologie : analyse du sujet, plan et rédaction', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''une dissertation littéraire ?","answer":"La dissertation littéraire est un exercice argumentatif qui consiste à discuter une opinion, une citation ou une question portant sur la littérature. Elle exige une réflexion personnelle organisée, appuyée sur des connaissances littéraires (œuvres, auteurs, courants). Elle comprend trois parties : introduction, développement (2 ou 3 parties) et conclusion. C''est un exercice central du baccalauréat de français."},
      {"id":"fc2","category":"Méthode","question":"Comment analyser un sujet de dissertation ?","answer":"Étapes d''analyse : 1) Lire attentivement le sujet plusieurs fois. 2) Identifier les mots-clés et les définir. 3) Reformuler le sujet avec vos propres mots. 4) Identifier le type de sujet : citation à discuter, question ouverte, sujet dialectique (thèse/antithèse/synthèse). 5) Dégager la problématique (question centrale à laquelle répondre). 6) Mobiliser des exemples littéraires. Ne jamais commencer à rédiger sans cette analyse préalable."},
      {"id":"fc3","category":"Méthode","question":"Quels sont les types de plans possibles ?","answer":"Plans courants : 1) Plan dialectique (thèse / antithèse / synthèse) : pour les sujets qui invitent à discuter une opinion. 2) Plan thématique : chaque partie aborde un aspect du sujet (pour les questions ouvertes). 3) Plan analytique (constat / causes / solutions) : pour les sujets de réflexion. Chaque partie contient 2-3 sous-parties avec arguments et exemples littéraires. Le plan doit répondre progressivement à la problématique."},
      {"id":"fc4","category":"Méthode","question":"Comment rédiger l''introduction ?","answer":"L''introduction comprend 4 étapes : 1) Accroche (amorce) : citation, fait culturel, contexte littéraire pour introduire le thème. 2) Présentation du sujet : reformuler la citation ou le sujet. 3) Problématique : formuler la question centrale sous forme interrogative. 4) Annonce du plan : présenter brièvement les grandes parties du développement. L''introduction doit être rédigée d''un seul tenant, sans sous-parties. Elle fait environ 10-15 lignes."},
      {"id":"fc5","category":"Méthode","question":"Comment construire un paragraphe argumentatif ?","answer":"Structure d''un paragraphe : 1) Idée directrice (argument principal en une phrase). 2) Explication de l''argument (développer l''idée). 3) Exemple littéraire précis (auteur, œuvre, passage). 4) Analyse de l''exemple (montrer en quoi il illustre l''argument). 5) Transition vers le paragraphe suivant. Chaque paragraphe = un argument + un exemple analysé. Éviter les exemples sans analyse et les arguments sans exemples."},
      {"id":"fc6","category":"Méthode","question":"Comment rédiger la conclusion ?","answer":"La conclusion comprend 3 étapes : 1) Bilan : résumer les principales idées du développement sans répéter mot pour mot. 2) Réponse à la problématique : donner votre position finale de manière nuancée. 3) Ouverture : élargir la réflexion vers une question connexe, un autre domaine ou une perspective nouvelle. La conclusion fait environ 8-10 lignes. Ne jamais introduire de nouvel argument dans la conclusion."},
      {"id":"fc7","category":"Exemple","question":"Quels exemples littéraires utiliser au baccalauréat ?","answer":"Exemples par genre : Roman : Camara Laye (L''Enfant noir), Cheikh Hamidou Kane (L''Aventure ambiguë), Ahmadou Kourouma (Les Soleils des indépendances), Victor Hugo (Les Misérables). Poésie : Senghor (Chants d''ombre), Césaire (Cahier d''un retour au pays natal). Théâtre : Molière, Seydou Badian (La Mort de Chaka). Toujours citer l''auteur, le titre de l''œuvre et le passage pertinent."},
      {"id":"fc8","category":"Distinction","question":"Quelles erreurs éviter dans une dissertation ?","answer":"Erreurs courantes : 1) Hors-sujet : ne pas répondre à la question posée. 2) Absence de problématique. 3) Plan déséquilibré (parties trop courtes ou trop longues). 4) Exemples sans analyse. 5) Paraphrase au lieu d''argumentation. 6) Absence de transitions entre les parties. 7) Introduction ou conclusion bâclée. 8) Fautes d''orthographe et de grammaire. 9) Style familier. 10) Copier le sujet sans le reformuler."}
    ],
    "schema": {
      "title": "La dissertation littéraire",
      "nodes": [
        {"id":"n1","label":"Dissertation littéraire","type":"main"},
        {"id":"n2","label":"Analyse du sujet","type":"branch"},
        {"id":"n3","label":"Plan","type":"branch"},
        {"id":"n4","label":"Rédaction","type":"branch"},
        {"id":"n5","label":"Mots-clés, problématique","type":"leaf"},
        {"id":"n6","label":"Dialectique, thématique","type":"leaf"},
        {"id":"n7","label":"Introduction (4 étapes)","type":"leaf"},
        {"id":"n8","label":"Paragraphe argumentatif","type":"leaf"},
        {"id":"n9","label":"Conclusion (bilan, réponse, ouverture)","type":"leaf"},
        {"id":"n10","label":"Exemples littéraires","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"étape 1"},
        {"from":"n1","to":"n3","label":"étape 2"},
        {"from":"n1","to":"n4","label":"étape 3"},
        {"from":"n2","to":"n5","label":"méthode"},
        {"from":"n3","to":"n6","label":"types"},
        {"from":"n4","to":"n7","label":"début"},
        {"from":"n4","to":"n8","label":"corps"},
        {"from":"n4","to":"n9","label":"fin"},
        {"from":"n4","to":"n10","label":"illustrations"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''introduction d''une dissertation comprend :","options":["Seulement l''annonce du plan","Accroche, sujet, problématique, annonce du plan","La réponse au sujet","Des exemples littéraires détaillés"],"correct":1,"explanation":"L''introduction comporte 4 étapes : accroche (amorce), présentation du sujet, formulation de la problématique et annonce du plan."},
      {"id":"q2","question":"Le plan dialectique comprend :","options":["Introduction et conclusion seulement","Causes, conséquences, solutions","Thèse, antithèse, synthèse","Résumé et commentaire"],"correct":2,"explanation":"Le plan dialectique est structuré en thèse (défendre l''idée), antithèse (la nuancer ou la contester) et synthèse (dépasser l''opposition)."},
      {"id":"q3","question":"Un paragraphe argumentatif doit contenir :","options":["Seulement un exemple","Un argument, un exemple et une analyse","Une liste de dates","Un résumé d''œuvre"],"correct":1,"explanation":"Chaque paragraphe argumentatif doit contenir : une idée directrice (argument), un exemple littéraire précis et une analyse de cet exemple."},
      {"id":"q4","question":"La problématique est :","options":["Le titre du sujet","La question centrale à laquelle la dissertation répond","Le plan détaillé","La conclusion"],"correct":1,"explanation":"La problématique est la question centrale que pose le sujet et à laquelle le développement doit répondre progressivement."},
      {"id":"q5","question":"Dans la conclusion, on ne doit pas :","options":["Résumer les idées principales","Répondre à la problématique","Introduire un nouvel argument","Proposer une ouverture"],"correct":2,"explanation":"La conclusion résume, répond à la problématique et propose une ouverture, mais ne doit jamais introduire un nouvel argument qui n''a pas été développé."},
      {"id":"q6","question":"Quel auteur africain a écrit L''Enfant noir ?","options":["Senghor","Camara Laye","Kourouma","Césaire"],"correct":1,"explanation":"L''Enfant noir est un roman autobiographique de Camara Laye (1953), écrivain guinéen. Il raconte son enfance en Guinée et son départ pour la France."},
      {"id":"q7","question":"L''accroche d''une introduction sert à :","options":["Annoncer le plan","Donner la réponse","Attirer l''attention du lecteur sur le thème","Citer le sujet textuellement"],"correct":2,"explanation":"L''accroche (ou amorce) est la première phrase de l''introduction. Elle sert à attirer l''attention du lecteur et à introduire le thème du sujet de manière originale."},
      {"id":"q8","question":"Quel est le principal défaut d''une dissertation ?","options":["Être trop longue","Le hors-sujet","Avoir trop d''exemples","Utiliser des transitions"],"correct":1,"explanation":"Le hors-sujet est le défaut le plus grave : ne pas répondre à la question posée. Il entraîne une note très basse car il montre une incompréhension du sujet."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - Chapitre 2 : Le commentaire composé
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'commentaire-compose', 2, 'Le commentaire composé', 'Technique et pratique du commentaire', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'commentaire-compose-fiche', 'Le commentaire composé', 'Analyse méthodique d''un texte littéraire', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce qu''un commentaire composé ?","answer":"Le commentaire composé est un exercice d''analyse littéraire qui consiste à étudier un texte de manière organisée selon des axes de lecture (thèmes). Contrairement à l''explication linéaire (ligne par ligne), le commentaire est thématique : on regroupe les observations par centres d''intérêt. Il comprend : introduction (présentation du texte, problématique, annonce des axes), développement (2-3 axes), conclusion (bilan, ouverture)."},
      {"id":"fc2","category":"Méthode","question":"Comment préparer un commentaire composé ?","answer":"Préparation : 1) Lire le texte plusieurs fois. 2) Identifier le genre (poésie, roman, théâtre), l''auteur, l''époque, le courant littéraire. 3) Repérer les procédés littéraires (figures de style, champs lexicaux, rythme, structure). 4) Dégager l''impression générale du texte. 5) Formuler la problématique. 6) Organiser les observations en 2-3 axes de lecture cohérents. 7) Trouver des citations pour chaque argument."},
      {"id":"fc3","category":"Définition","question":"Quels sont les principaux procédés littéraires ?","answer":"Procédés courants : 1) Figures de style : métaphore, comparaison, personnification, hyperbole, antithèse, anaphore, allitération. 2) Champs lexicaux (ensemble de mots liés à un thème). 3) Registres : lyrique, tragique, comique, satirique, épique. 4) Types de phrases : interrogatives, exclamatives, impératives. 5) Temps verbaux et leur valeur. 6) Point de vue narratif (interne, externe, omniscient). 7) Rythme et sonorités (en poésie)."},
      {"id":"fc4","category":"Méthode","question":"Comment formuler les axes de lecture ?","answer":"Les axes sont les grandes idées qui structurent le commentaire. Méthode : 1) Regrouper les observations par thème commun. 2) Chaque axe = une interprétation du texte. 3) Les axes doivent être complémentaires et progressifs (du plus évident au plus subtil). 4) Formuler chaque axe comme une affirmation. Exemples : « Un tableau réaliste de la société malienne », « La dimension symbolique du voyage », « L''engagement de l''auteur »."},
      {"id":"fc5","category":"Méthode","question":"Comment rédiger un paragraphe de commentaire ?","answer":"Structure : 1) Idée directrice (ce que vous voulez montrer). 2) Citation du texte entre guillemets avec indication de la ligne. 3) Identification du procédé littéraire utilisé (métaphore, anaphore...). 4) Interprétation : quel est l''effet produit ? Que signifie ce procédé dans le contexte ? Le commentaire n''est pas un résumé : il ne suffit pas de citer, il faut analyser et interpréter."},
      {"id":"fc6","category":"Exemple","question":"Quelles sont les principales figures de style ?","answer":"Figures de style : 1) Comparaison : rapprochement avec « comme » (fort comme un lion). 2) Métaphore : comparaison sans outil (cet homme est un lion). 3) Personnification : attribuer des qualités humaines à un objet/animal. 4) Hyperbole : exagération (mourir de faim). 5) Antithèse : opposition (le noir et le blanc). 6) Anaphore : répétition en début de phrase. 7) Allitération : répétition de consonnes. 8) Oxymore : termes contradictoires (obscure clarté)."},
      {"id":"fc7","category":"Méthode","question":"Comment rédiger l''introduction du commentaire ?","answer":"Introduction : 1) Amorce : situer le texte dans son contexte (auteur, œuvre, époque, courant). 2) Présentation du texte : genre, thème principal, situation dans l''œuvre. 3) Problématique : question que pose le texte. 4) Annonce des axes de lecture. Exemple : « Ce poème de Senghor, extrait de Chants d''ombre (1945), s''inscrit dans le mouvement de la négritude. Comment le poète célèbre-t-il l''Afrique à travers ses souvenirs d''enfance ? »"},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre commentaire composé et explication linéaire ?","answer":"Commentaire composé : organisation thématique (par axes de lecture), on regroupe les observations par centres d''intérêt, on va d''un axe à l''autre. Explication linéaire : on suit l''ordre du texte, on commente vers par vers ou phrase par phrase. Le commentaire composé est plus synthétique et montre une meilleure capacité d''organisation. Au baccalauréat malien, le commentaire composé est l''exercice privilégié."}
    ],
    "schema": {
      "title": "Le commentaire composé",
      "nodes": [
        {"id":"n1","label":"Commentaire composé","type":"main"},
        {"id":"n2","label":"Préparation","type":"branch"},
        {"id":"n3","label":"Rédaction","type":"branch"},
        {"id":"n4","label":"Outils d''analyse","type":"branch"},
        {"id":"n5","label":"Lecture, repérage","type":"leaf"},
        {"id":"n6","label":"Axes de lecture","type":"leaf"},
        {"id":"n7","label":"Introduction, développement, conclusion","type":"leaf"},
        {"id":"n8","label":"Citation + procédé + interprétation","type":"leaf"},
        {"id":"n9","label":"Figures de style","type":"leaf"},
        {"id":"n10","label":"Champs lexicaux, registres","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"étape 1"},
        {"from":"n1","to":"n3","label":"étape 2"},
        {"from":"n1","to":"n4","label":"moyens"},
        {"from":"n2","to":"n5","label":"observation"},
        {"from":"n2","to":"n6","label":"organisation"},
        {"from":"n3","to":"n7","label":"structure"},
        {"from":"n3","to":"n8","label":"paragraphe"},
        {"from":"n4","to":"n9","label":"stylistique"},
        {"from":"n4","to":"n10","label":"thématique"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le commentaire composé est organisé de manière :","options":["Chronologique","Linéaire (ligne par ligne)","Thématique (par axes de lecture)","Alphabétique"],"correct":2,"explanation":"Le commentaire composé est organisé par axes de lecture (thèmes), contrairement à l''explication linéaire qui suit l''ordre du texte."},
      {"id":"q2","question":"Une métaphore est :","options":["Une comparaison avec « comme »","Une comparaison sans outil de comparaison","Une exagération","Une répétition"],"correct":1,"explanation":"La métaphore est une comparaison implicite, sans outil de comparaison (comme, tel que). Exemple : « cet homme est un lion » (métaphore) vs « fort comme un lion » (comparaison)."},
      {"id":"q3","question":"Un axe de lecture est :","options":["Un résumé du texte","Une grande idée qui organise l''analyse du texte","La biographie de l''auteur","Le titre de l''œuvre"],"correct":1,"explanation":"Un axe de lecture est une interprétation thématique qui regroupe plusieurs observations sur le texte. Le commentaire comprend 2-3 axes progressifs."},
      {"id":"q4","question":"Dans un paragraphe de commentaire, il faut :","options":["Résumer le texte","Citer, identifier le procédé et interpréter","Donner son avis personnel sans justification","Traduire le texte en langue locale"],"correct":1,"explanation":"Chaque paragraphe doit contenir : une citation du texte, l''identification du procédé littéraire utilisé et une interprétation de l''effet produit."},
      {"id":"q5","question":"L''anaphore est :","options":["Une exagération","La répétition d''un mot en début de vers ou de phrase","Un mot de sens contraire","Une comparaison"],"correct":1,"explanation":"L''anaphore est la répétition d''un mot ou d''un groupe de mots en début de vers, de phrase ou de paragraphe. Elle crée un effet d''insistance et de rythme."},
      {"id":"q6","question":"Le registre lyrique exprime :","options":["La colère","Les sentiments personnels du poète","Le comique","La violence"],"correct":1,"explanation":"Le registre lyrique exprime les sentiments personnels (amour, nostalgie, mélancolie, joie). Il est caractéristique de la poésie (Senghor, Lamartine)."},
      {"id":"q7","question":"Un champ lexical est :","options":["Un dictionnaire","Un ensemble de mots liés à un même thème dans un texte","Une figure de style","Un type de phrase"],"correct":1,"explanation":"Un champ lexical est l''ensemble des mots et expressions qui se rapportent à un même thème dans un texte. Par exemple : « soleil, chaleur, sable, sécheresse » = champ lexical de l''aridité."},
      {"id":"q8","question":"L''introduction du commentaire doit présenter :","options":["Seulement la biographie de l''auteur","Le contexte, le texte, la problématique et les axes","Uniquement les figures de style","Le résumé complet du texte"],"correct":1,"explanation":"L''introduction situe le texte dans son contexte (auteur, œuvre, époque), présente le texte, formule la problématique et annonce les axes de lecture."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - Chapitre 3 : Le résumé et la discussion
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'resume-discussion', 3, 'Le résumé et la discussion', 'Techniques du résumé de texte et de la discussion', 3)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'resume-discussion-fiche', 'Le résumé et la discussion', 'Condenser un texte et discuter une thèse', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le résumé de texte ?","answer":"Le résumé consiste à réduire un texte au quart ou au tiers de sa longueur (selon la consigne) en conservant les idées essentielles dans l''ordre du texte. Règles : 1) Reformuler avec ses propres mots (pas de copier-coller). 2) Respecter l''ordre des idées du texte. 3) Ne pas ajouter d''idées personnelles. 4) Éliminer les exemples, détails et répétitions. 5) Respecter le nombre de mots imposé (±10 %)."},
      {"id":"fc2","category":"Méthode","question":"Comment résumer un texte efficacement ?","answer":"Étapes : 1) Lire le texte 2-3 fois. 2) Identifier la thèse (idée principale de l''auteur). 3) Repérer les idées essentielles de chaque paragraphe. 4) Distinguer l''essentiel (idées, arguments) de l''accessoire (exemples, détails, anecdotes). 5) Rédiger en reformulant. 6) Compter les mots et ajuster. 7) Relire pour vérifier la cohérence et la fidélité au texte original. Le résumé doit être autonome (compréhensible sans le texte d''origine)."},
      {"id":"fc3","category":"Méthode","question":"Quelles sont les règles de reformulation ?","answer":"Reformuler c''est exprimer la même idée avec des mots différents. Techniques : 1) Remplacer par des synonymes (problème → difficulté). 2) Changer la construction de la phrase (active → passive). 3) Nominaliser (les gens consomment → la consommation). 4) Généraliser (pommes, oranges, bananes → les fruits). 5) Fusionner deux phrases en une. Interdit : reprendre les phrases du texte textuellement, ajouter des commentaires personnels."},
      {"id":"fc4","category":"Définition","question":"Qu''est-ce que la discussion ?","answer":"La discussion est un exercice argumentatif qui consiste à examiner une thèse (opinion de l''auteur) extraite du texte résumé. On doit : 1) Exposer et défendre la thèse de l''auteur avec des arguments personnels. 2) La nuancer ou la contester avec d''autres arguments. 3) Conclure par une prise de position personnelle. La discussion suit un plan dialectique (thèse/antithèse/synthèse) ou un plan par élargissement."},
      {"id":"fc5","category":"Méthode","question":"Comment structurer une discussion ?","answer":"Structure : 1) Introduction : présenter la thèse de l''auteur et annoncer votre démarche. 2) Première partie : défendre la thèse (arguments en faveur + exemples). 3) Deuxième partie : nuancer ou contester (arguments contre + exemples). 4) Troisième partie (optionnelle) : synthèse ou dépassement. 5) Conclusion : bilan et position personnelle. Utiliser des exemples tirés de l''actualité, de la littérature et de l''expérience personnelle."},
      {"id":"fc6","category":"Distinction","question":"Quelle différence entre résumé et analyse ?","answer":"Le résumé condense le texte en gardant les idées essentielles sans ajout personnel. On reste fidèle à la pensée de l''auteur. L''analyse (ou discussion) évalue, critique et discute les idées du texte avec ses propres arguments. Le résumé est objectif (reformuler la pensée d''un autre), la discussion est subjective (donner son avis argumenté). Au baccalauréat, les deux exercices sont souvent associés."},
      {"id":"fc7","category":"Méthode","question":"Comment compter les mots dans un résumé ?","answer":"Règles de comptage : 1) Chaque mot séparé par un espace compte pour un mot. 2) Les articles (le, la, un) comptent. 3) Les mots composés avec trait d''union comptent pour un seul mot (peut-être = 1 mot). 4) Les nombres en chiffres comptent pour un mot. 5) Les sigles comptent pour un mot (ONU = 1 mot). Tolérance : ±10 % du nombre demandé. Indiquer le nombre de mots à la fin du résumé."},
      {"id":"fc8","category":"Exemple","question":"Quelles erreurs éviter dans le résumé ?","answer":"Erreurs : 1) Recopier des phrases du texte original. 2) Ajouter des idées personnelles. 3) Ne pas respecter l''ordre du texte. 4) Conserver trop d''exemples et de détails. 5) Dépasser le nombre de mots. 6) Commencer par « L''auteur dit que... » ou « Le texte parle de... ». 7) Utiliser des guillemets (car c''est du copier-coller). 8) Modifier la pensée de l''auteur. Le résumé doit être fidèle, concis et reformulé."}
    ],
    "schema": {
      "title": "Résumé et discussion",
      "nodes": [
        {"id":"n1","label":"Résumé et discussion","type":"main"},
        {"id":"n2","label":"Résumé","type":"branch"},
        {"id":"n3","label":"Discussion","type":"branch"},
        {"id":"n4","label":"Techniques","type":"branch"},
        {"id":"n5","label":"Condensation (1/4 ou 1/3)","type":"leaf"},
        {"id":"n6","label":"Reformulation","type":"leaf"},
        {"id":"n7","label":"Thèse / Antithèse / Synthèse","type":"leaf"},
        {"id":"n8","label":"Arguments + exemples","type":"leaf"},
        {"id":"n9","label":"Comptage des mots","type":"leaf"},
        {"id":"n10","label":"Position personnelle","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"1re partie"},
        {"from":"n1","to":"n3","label":"2e partie"},
        {"from":"n1","to":"n4","label":"savoir-faire"},
        {"from":"n2","to":"n5","label":"réduction"},
        {"from":"n2","to":"n6","label":"mots propres"},
        {"from":"n3","to":"n7","label":"plan"},
        {"from":"n3","to":"n8","label":"contenu"},
        {"from":"n4","to":"n9","label":"règle"},
        {"from":"n3","to":"n10","label":"conclusion"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le résumé d''un texte consiste à :","options":["Copier les phrases importantes","Reformuler les idées essentielles en les condensant","Donner son avis sur le texte","Commenter les procédés littéraires"],"correct":1,"explanation":"Le résumé reformule les idées essentielles du texte avec ses propres mots, en les condensant au quart ou au tiers de la longueur originale."},
      {"id":"q2","question":"Dans un résumé, il est interdit de :","options":["Reformuler les idées","Respecter l''ordre du texte","Ajouter des idées personnelles","Condenser le texte"],"correct":2,"explanation":"Le résumé doit être fidèle à la pensée de l''auteur. On ne doit jamais ajouter d''idées personnelles, de commentaires ou de jugements."},
      {"id":"q3","question":"La discussion au baccalauréat suit généralement un plan :","options":["Chronologique","Dialectique (thèse/antithèse/synthèse)","Alphabétique","Descriptif"],"correct":1,"explanation":"La discussion suit généralement un plan dialectique : on défend d''abord la thèse de l''auteur, puis on la nuance ou conteste, avant de proposer une synthèse."},
      {"id":"q4","question":"La tolérance habituelle pour le nombre de mots est :","options":["±1 %","±5 %","±10 %","±25 %"],"correct":2,"explanation":"La tolérance habituelle est de ±10 % par rapport au nombre de mots demandé. Par exemple, pour un résumé de 100 mots, on accepte entre 90 et 110 mots."},
      {"id":"q5","question":"« Peut-être » compte pour combien de mots ?","options":["Deux mots","Un seul mot","Trois mots","Cela dépend"],"correct":1,"explanation":"Les mots composés reliés par un trait d''union comptent pour un seul mot dans le décompte du résumé. « Peut-être » = 1 mot."},
      {"id":"q6","question":"La reformulation consiste à :","options":["Copier le texte original","Exprimer la même idée avec des mots différents","Traduire en une autre langue","Ajouter des exemples"],"correct":1,"explanation":"Reformuler signifie exprimer la même idée avec des mots différents, en utilisant des synonymes, en changeant la structure de la phrase ou en nominalisant."},
      {"id":"q7","question":"Dans la discussion, la conclusion doit :","options":["Reprendre le résumé","Présenter de nouveaux arguments","Donner sa position personnelle","Citer l''auteur"],"correct":2,"explanation":"La conclusion de la discussion doit faire le bilan des arguments et donner la position personnelle du candidat de manière nuancée, sans introduire de nouveaux arguments."},
      {"id":"q8","question":"Quelle formule faut-il éviter au début d''un résumé ?","options":["Selon la thèse développée","En premier lieu","L''auteur dit que...","D''une part"],"correct":2,"explanation":"Il faut éviter « L''auteur dit que... » ou « Le texte parle de... » au début d''un résumé. Le résumé doit reformuler directement les idées comme si elles étaient les vôtres."}
    ]
  }');

  -- ============================================================
  -- FRANÇAIS - Chapitre 4 : Les genres littéraires
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (francais_id, 'genres-litteraires', 4, 'Les genres littéraires', 'Roman, poésie, théâtre, littérature africaine', 4)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'genres-litteraires-fiche', 'Les genres littéraires', 'Roman, poésie, théâtre et littérature africaine francophone', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Quels sont les grands genres littéraires ?","answer":"Les 4 grands genres : 1) Le roman : récit en prose, fiction longue avec personnages, intrigue, cadre spatio-temporel. 2) La poésie : expression des sentiments par le rythme, les sonorités, les images (vers, strophes, rimes ou vers libres). 3) Le théâtre : texte destiné à être joué (dialogue, didascalies). 4) L''essai : réflexion argumentée sur un sujet. Chaque genre a ses sous-genres, ses codes et ses procédés propres."},
      {"id":"fc2","category":"Exemple","question":"Quels sont les types de roman ?","answer":"Types de roman : 1) Roman réaliste : peinture fidèle de la société (Balzac, Zola). 2) Roman autobiographique : l''auteur raconte sa vie (Camara Laye, L''Enfant noir). 3) Roman historique : fiction dans un cadre historique. 4) Roman engagé : dénonce des injustices (Kourouma). 5) Roman d''apprentissage : évolution d''un personnage (L''Aventure ambiguë de Cheikh Hamidou Kane). 6) Nouvelle : récit court avec chute."},
      {"id":"fc3","category":"Définition","question":"Quelles sont les caractéristiques de la poésie ?","answer":"Caractéristiques : 1) Vers (alexandrin = 12 syllabes, octosyllabe = 8). 2) Strophes (quatrain = 4 vers, tercet = 3 vers). 3) Rimes (plates AABB, croisées ABAB, embrassées ABBA). 4) Rythme et musicalité. 5) Figures de style (métaphore, personnification). 6) Vers libre : sans rime ni mètre fixe (poésie moderne). La poésie africaine (Senghor, Césaire) mêle souvent vers libre et rythmes traditionnels."},
      {"id":"fc4","category":"Définition","question":"Quels sont les genres théâtraux ?","answer":"Genres théâtraux : 1) Tragédie : personnages nobles confrontés au destin, fin malheureuse (Racine). 2) Comédie : situations comiques, fin heureuse, critique des mœurs (Molière). 3) Drame : mélange tragique et comique (Hugo). 4) Théâtre africain : Seydou Badian (La Mort de Chaka), Bernard Dadié. Éléments : actes, scènes, dialogue, monologue, aparté, didascalies, tirade, quiproquo."},
      {"id":"fc5","category":"Exemple","question":"Qu''est-ce que la littérature africaine francophone ?","answer":"La littérature africaine francophone naît dans les années 1930-1940 avec la négritude (Senghor, Césaire, Damas). Thèmes : identité africaine, colonisation, tradition vs modernité, exil, engagement politique. Auteurs majeurs : Camara Laye (Guinée), Ousmane Sembène (Sénégal), Ahmadou Kourouma (Côte d''Ivoire), Mongo Beti (Cameroun), Seydou Badian (Mali), Aminata Sow Fall, Mariama Bâ. Elle exprime les réalités et aspirations des peuples africains."},
      {"id":"fc6","category":"Exemple","question":"Quels sont les thèmes de la littérature africaine ?","answer":"Thèmes majeurs : 1) La négritude : valorisation de la culture noire (Senghor). 2) La colonisation et ses méfaits (Mongo Beti, Kourouma). 3) Le conflit tradition/modernité (Cheikh Hamidou Kane). 4) L''indépendance et ses désillusions (Les Soleils des indépendances). 5) La condition de la femme (Mariama Bâ, Une si longue lettre). 6) L''exil et l''immigration. 7) La corruption politique. 8) L''enfance africaine (Camara Laye)."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser un texte selon son genre ?","answer":"Méthode : 1) Identifier le genre (roman, poésie, théâtre, essai). 2) Repérer les caractéristiques du genre (vers, dialogue, narration). 3) Analyser les procédés propres au genre (pour la poésie : rythme, rimes ; pour le roman : narration, personnages ; pour le théâtre : dialogue, mise en scène). 4) Situer l''œuvre dans son courant littéraire. 5) Étudier les thèmes en lien avec le contexte historique et culturel."},
      {"id":"fc8","category":"Distinction","question":"Quelle est la différence entre roman et nouvelle ?","answer":"Le roman est un récit long avec plusieurs personnages, une intrigue complexe, des descriptions détaillées et un développement approfondi des thèmes. La nouvelle est un récit court, centré sur un événement ou un personnage, avec une intrigue resserrée et souvent une chute surprenante. La nouvelle va à l''essentiel, tandis que le roman développe un univers complet. Exemples de nouvelles : Maupassant, Birago Diop (Les Contes d''Amadou Koumba)."}
    ],
    "schema": {
      "title": "Les genres littéraires",
      "nodes": [
        {"id":"n1","label":"Genres littéraires","type":"main"},
        {"id":"n2","label":"Roman","type":"branch"},
        {"id":"n3","label":"Poésie","type":"branch"},
        {"id":"n4","label":"Théâtre","type":"branch"},
        {"id":"n5","label":"Réaliste, autobiographique, engagé","type":"leaf"},
        {"id":"n6","label":"Vers, strophes, rimes","type":"leaf"},
        {"id":"n7","label":"Tragédie, comédie, drame","type":"leaf"},
        {"id":"n8","label":"Littérature africaine","type":"leaf"},
        {"id":"n9","label":"Négritude, Senghor, Césaire","type":"leaf"},
        {"id":"n10","label":"Thèmes : identité, colonisation","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"prose"},
        {"from":"n1","to":"n3","label":"vers"},
        {"from":"n1","to":"n4","label":"scène"},
        {"from":"n2","to":"n5","label":"types"},
        {"from":"n3","to":"n6","label":"formes"},
        {"from":"n4","to":"n7","label":"genres"},
        {"from":"n1","to":"n8","label":"Afrique"},
        {"from":"n8","to":"n9","label":"mouvement"},
        {"from":"n8","to":"n10","label":"contenus"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Un alexandrin est un vers de :","options":["8 syllabes","10 syllabes","12 syllabes","14 syllabes"],"correct":2,"explanation":"L''alexandrin est un vers de 12 syllabes, le plus noble de la poésie française classique. L''octosyllabe a 8 syllabes et le décasyllabe en a 10."},
      {"id":"q2","question":"Le mouvement de la négritude a été fondé par :","options":["Victor Hugo et Balzac","Senghor, Césaire et Damas","Molière et Racine","Camara Laye et Kourouma"],"correct":1,"explanation":"La négritude a été fondée dans les années 1930 par Léopold Sédar Senghor (Sénégal), Aimé Césaire (Martinique) et Léon-Gontran Damas (Guyane), pour valoriser l''identité et la culture noires."},
      {"id":"q3","question":"L''Aventure ambiguë est un roman de :","options":["Camara Laye","Cheikh Hamidou Kane","Ahmadou Kourouma","Ousmane Sembène"],"correct":1,"explanation":"L''Aventure ambiguë (1961) est un roman de Cheikh Hamidou Kane (Sénégal) qui traite du conflit entre tradition africaine et modernité occidentale à travers le personnage de Samba Diallo."},
      {"id":"q4","question":"Les didascalies sont :","options":["Des vers de poésie","Des indications scéniques dans un texte de théâtre","Des chapitres de roman","Des figures de style"],"correct":1,"explanation":"Les didascalies sont les indications scéniques dans un texte de théâtre (en italique) : elles précisent le décor, les gestes, le ton des personnages, les entrées et sorties."},
      {"id":"q5","question":"Les rimes croisées suivent le schéma :","options":["AABB","ABAB","ABBA","AABA"],"correct":1,"explanation":"Les rimes croisées suivent le schéma ABAB (alternance). Les rimes plates sont AABB et les rimes embrassées sont ABBA."},
      {"id":"q6","question":"Qui a écrit Les Soleils des indépendances ?","options":["Senghor","Camara Laye","Ahmadou Kourouma","Mongo Beti"],"correct":2,"explanation":"Les Soleils des indépendances (1968) est un roman d''Ahmadou Kourouma (Côte d''Ivoire) qui dénonce les désillusions de l''indépendance africaine à travers l''histoire de Fama."},
      {"id":"q7","question":"Le genre théâtral qui mêle tragique et comique est :","options":["La tragédie","La comédie","Le drame","La farce"],"correct":2,"explanation":"Le drame (romantique) mêle le tragique et le comique, le sublime et le grotesque. Victor Hugo en est le principal représentant (Hernani, Ruy Blas)."},
      {"id":"q8","question":"Une si longue lettre de Mariama Bâ traite de :","options":["La guerre","La condition de la femme africaine","La colonisation","Le sport"],"correct":1,"explanation":"Une si longue lettre (1979) de Mariama Bâ (Sénégal) est un roman épistolaire qui traite de la condition de la femme africaine face à la polygamie et aux traditions."}
    ]
  }');

  -- ============================================================
  -- ECM - Chapitre 1 : Sécurité et civisme au Mali
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (ecm_id, 'securite-civisme', 1, 'Sécurité et civisme au Mali', 'Sécurité, droits et devoirs du citoyen', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'securite-civisme-fiche', 'Sécurité et civisme au Mali', 'Droits, devoirs, sécurité et engagement citoyen', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que le civisme ?","answer":"Le civisme est l''attitude du citoyen qui remplit ses devoirs envers la collectivité et l''État. Il se manifeste par : le respect des lois et règlements, le paiement des impôts, le vote, le respect des biens publics, la participation à la vie communautaire, le respect du drapeau et de l''hymne national. Le civisme est essentiel au bon fonctionnement de la démocratie et de la société."},
      {"id":"fc2","category":"Définition","question":"Quels sont les droits fondamentaux du citoyen malien ?","answer":"La Constitution du Mali (1992) garantit : 1) Droits civils : liberté d''expression, de presse, de réunion, de circulation, d''association. 2) Droits politiques : droit de vote, droit d''être élu, droit de participer à la gestion des affaires publiques. 3) Droits sociaux : droit à l''éducation, à la santé, au travail, à la protection sociale. 4) Droits juridiques : présomption d''innocence, droit à un procès équitable, interdiction de la torture."},
      {"id":"fc3","category":"Définition","question":"Quels sont les devoirs du citoyen malien ?","answer":"Devoirs du citoyen : 1) Respecter la Constitution et les lois. 2) Payer les impôts et taxes. 3) Défendre la patrie (service militaire). 4) Voter (devoir civique). 5) Respecter les biens publics et l''environnement. 6) Respecter les droits d''autrui. 7) Contribuer à la cohésion sociale et à la paix. 8) S''abstenir de corruption et de fraude. Le citoyen a des droits, mais aussi des obligations envers la société."},
      {"id":"fc4","category":"Exemple","question":"Quels sont les défis sécuritaires du Mali ?","answer":"Défis sécuritaires : 1) Terrorisme au nord et au centre (groupes armés jihadistes : AQMI, JNIM, État islamique). 2) Conflits intercommunautaires (entre éleveurs et agriculteurs). 3) Banditisme et criminalité. 4) Trafic de drogue et d''armes au Sahel. 5) Déplacement de populations (réfugiés internes). 6) Instabilité politique (coups d''État de 2012, 2020, 2021). La sécurité est un préalable au développement."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que la citoyenneté ?","answer":"La citoyenneté est le lien juridique et politique entre un individu et un État. Le citoyen a des droits (civils, politiques, sociaux) et des devoirs (respect des lois, participation à la vie publique). Conditions de la citoyenneté malienne : nationalité malienne (par filiation, mariage ou naturalisation), majorité (18 ans pour voter). La citoyenneté implique un engagement actif dans la vie de la communauté et de la nation."},
      {"id":"fc6","category":"Exemple","question":"Comment le citoyen peut-il contribuer à la sécurité ?","answer":"Contributions du citoyen à la sécurité : 1) Signaler les comportements suspects aux autorités. 2) Refuser de collaborer avec les groupes armés. 3) Participer aux initiatives locales de sécurité (comités de vigilance). 4) Promouvoir le dialogue intercommunautaire. 5) Respecter les lois et règlements. 6) Éduquer les jeunes contre l''extrémisme. 7) Soutenir les forces de défense et de sécurité. La sécurité est l''affaire de tous."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser un problème civique ?","answer":"Méthode : 1) Définir le problème (nature, ampleur). 2) Identifier les causes (politiques, économiques, sociales). 3) Analyser les conséquences sur la société. 4) Repérer les acteurs impliqués (État, citoyens, société civile). 5) Proposer des solutions (lois, éducation, sensibilisation). 6) Évaluer les résultats. Toujours relier l''analyse au contexte malien et aux valeurs de la République."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre droits et devoirs ?","answer":"Les droits sont des libertés et protections garanties au citoyen par la loi (droit de vote, liberté d''expression, droit à l''éducation). Les devoirs sont des obligations du citoyen envers la société (payer ses impôts, respecter les lois, défendre la patrie). Droits et devoirs sont indissociables : on ne peut réclamer ses droits sans remplir ses devoirs. C''est l''équilibre entre les deux qui fonde la citoyenneté responsable."}
    ],
    "schema": {
      "title": "Sécurité et civisme au Mali",
      "nodes": [
        {"id":"n1","label":"Civisme et sécurité","type":"main"},
        {"id":"n2","label":"Droits du citoyen","type":"branch"},
        {"id":"n3","label":"Devoirs du citoyen","type":"branch"},
        {"id":"n4","label":"Sécurité","type":"branch"},
        {"id":"n5","label":"Libertés, vote, éducation","type":"leaf"},
        {"id":"n6","label":"Lois, impôts, défense","type":"leaf"},
        {"id":"n7","label":"Terrorisme, conflits","type":"leaf"},
        {"id":"n8","label":"Citoyenneté","type":"leaf"},
        {"id":"n9","label":"Engagement citoyen","type":"leaf"},
        {"id":"n10","label":"Droits ↔ Devoirs","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"garantis"},
        {"from":"n1","to":"n3","label":"obligations"},
        {"from":"n1","to":"n4","label":"défis"},
        {"from":"n2","to":"n5","label":"types"},
        {"from":"n3","to":"n6","label":"exemples"},
        {"from":"n4","to":"n7","label":"menaces"},
        {"from":"n1","to":"n8","label":"statut"},
        {"from":"n4","to":"n9","label":"rôle citoyen"},
        {"from":"n1","to":"n10","label":"équilibre"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Le civisme est :","options":["Le droit de voter","L''attitude du citoyen qui remplit ses devoirs envers la collectivité","Un parti politique","Une loi"],"correct":1,"explanation":"Le civisme est l''attitude du citoyen conscient de ses devoirs et qui les accomplit volontairement : respect des lois, paiement des impôts, participation à la vie publique."},
      {"id":"q2","question":"À quel âge peut-on voter au Mali ?","options":["16 ans","18 ans","21 ans","25 ans"],"correct":1,"explanation":"Au Mali, le droit de vote est accordé à partir de 18 ans, âge de la majorité civile et politique."},
      {"id":"q3","question":"Quel document fondamental garantit les droits des Maliens ?","options":["Le Code civil","La Constitution de 1992","Le Code pénal","Le règlement intérieur"],"correct":1,"explanation":"La Constitution du 25 février 1992 est la loi fondamentale du Mali. Elle garantit les droits et libertés des citoyens et organise les pouvoirs de l''État."},
      {"id":"q4","question":"Lequel n''est PAS un devoir du citoyen ?","options":["Payer ses impôts","Respecter les lois","Voter","Désobéir aux autorités"],"correct":3,"explanation":"Désobéir aux autorités n''est pas un devoir citoyen. Les devoirs comprennent le respect des lois, le paiement des impôts, le vote et la défense de la patrie."},
      {"id":"q5","question":"Le principal défi sécuritaire du Mali est :","options":["La pollution de l''air","Le terrorisme et les conflits armés","Le tourisme de masse","La surpopulation urbaine"],"correct":1,"explanation":"Le terrorisme (groupes jihadistes au nord et au centre) et les conflits armés constituent le principal défi sécuritaire du Mali depuis 2012."},
      {"id":"q6","question":"La citoyenneté implique :","options":["Seulement des droits","Seulement des devoirs","Des droits et des devoirs","Ni droits ni devoirs"],"correct":2,"explanation":"La citoyenneté implique à la fois des droits (libertés, protections) et des devoirs (obligations). Les deux sont indissociables et fondent la vie en société."},
      {"id":"q7","question":"La liberté d''expression est :","options":["Un devoir","Un droit fondamental","Une obligation militaire","Un impôt"],"correct":1,"explanation":"La liberté d''expression est un droit fondamental garanti par la Constitution. Elle permet à chaque citoyen d''exprimer librement ses opinions, dans le respect de la loi."},
      {"id":"q8","question":"Comment le citoyen contribue-t-il à la sécurité ?","options":["En ignorant les problèmes","En signalant les comportements suspects et en respectant les lois","En quittant le pays","En prenant les armes seul"],"correct":1,"explanation":"Le citoyen contribue à la sécurité en signalant les comportements suspects aux autorités, en respectant les lois, en promouvant le dialogue et en refusant l''extrémisme."}
    ]
  }');

  -- ============================================================
  -- ECM - Chapitre 2 : Démocratie et institutions
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (ecm_id, 'democratie-institutions', 2, 'Démocratie et institutions', 'Institutions de la République du Mali', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'democratie-institutions-fiche', 'Démocratie et institutions', 'Organisation politique et institutions de la République du Mali', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que la démocratie ?","answer":"La démocratie est un régime politique dans lequel le pouvoir appartient au peuple, qui l''exerce directement (démocratie directe) ou par l''intermédiaire de représentants élus (démocratie représentative). Principes : souveraineté populaire, séparation des pouvoirs (législatif, exécutif, judiciaire), pluralisme politique, État de droit, respect des libertés fondamentales, élections libres et transparentes. Le Mali est une démocratie depuis 1992."},
      {"id":"fc2","category":"Définition","question":"Quelles sont les institutions de la République du Mali ?","answer":"Institutions selon la Constitution : 1) Président de la République (chef de l''État, élu au suffrage universel, mandat de 5 ans renouvelable une fois). 2) Gouvernement (Premier ministre et ministres). 3) Assemblée nationale (pouvoir législatif, 147 députés). 4) Cour suprême, Cour constitutionnelle (pouvoir judiciaire). 5) Haut Conseil des Collectivités Territoriales. 6) Conseil Économique, Social et Culturel."},
      {"id":"fc3","category":"Définition","question":"Qu''est-ce que la séparation des pouvoirs ?","answer":"La séparation des pouvoirs (théorisée par Montesquieu) divise le pouvoir en trois branches pour éviter la tyrannie : 1) Pouvoir exécutif (Président, gouvernement) : applique les lois, gouverne. 2) Pouvoir législatif (Assemblée nationale) : vote les lois, contrôle le gouvernement. 3) Pouvoir judiciaire (tribunaux, cours) : rend la justice, interprète les lois. Chaque pouvoir est indépendant et contrôle les autres (checks and balances)."},
      {"id":"fc4","category":"Exemple","question":"Quel est le rôle du Président de la République au Mali ?","answer":"Le Président : 1) Chef de l''État et garant de la Constitution. 2) Nomme le Premier ministre et les membres du gouvernement. 3) Chef suprême des armées. 4) Promulgue les lois. 5) Préside le Conseil des ministres. 6) Représente le Mali à l''étranger. 7) Peut dissoudre l''Assemblée nationale. 8) Nomme aux hauts emplois civils et militaires. Il est élu au suffrage universel direct pour 5 ans, renouvelable une fois."},
      {"id":"fc5","category":"Exemple","question":"Quel est le rôle de l''Assemblée nationale ?","answer":"L''Assemblée nationale : 1) Vote les lois (pouvoir législatif). 2) Vote le budget de l''État. 3) Contrôle l''action du gouvernement (questions orales, commissions d''enquête). 4) Peut renverser le gouvernement par une motion de censure. 5) Ratifie les traités internationaux. Les députés sont élus au suffrage universel direct pour 5 ans. L''Assemblée siège à Bamako et est présidée par un président élu parmi les députés."},
      {"id":"fc6","category":"Définition","question":"Qu''est-ce que la décentralisation au Mali ?","answer":"La décentralisation est le transfert de compétences et de ressources de l''État central vers les collectivités territoriales. Au Mali : communes (703), cercles (49), régions (10 + district de Bamako). Objectifs : rapprocher l''administration des citoyens, développement local, participation populaire. Les collectivités sont dirigées par des élus locaux (maires, conseillers). La décentralisation est un pilier de la démocratie locale au Mali."},
      {"id":"fc7","category":"Méthode","question":"Comment analyser le fonctionnement d''une institution ?","answer":"Méthode : 1) Identifier l''institution (nom, création, base juridique). 2) Composition (membres, mode de désignation). 3) Attributions (pouvoirs, compétences). 4) Fonctionnement (sessions, règles de décision). 5) Relations avec les autres institutions. 6) Bilan (forces et faiblesses). Toujours se référer à la Constitution et aux lois organiques pour une analyse rigoureuse."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre État unitaire et État fédéral ?","answer":"État unitaire (comme le Mali) : un seul centre de décision politique, une seule Constitution, un seul gouvernement. La décentralisation accorde une autonomie administrative aux collectivités. État fédéral (comme les USA, l''Allemagne) : plusieurs États fédérés avec leur propre Constitution, gouvernement et parlement, réunis sous une autorité fédérale. Le Mali est un État unitaire décentralisé, une République laïque et démocratique."}
    ],
    "schema": {
      "title": "Démocratie et institutions",
      "nodes": [
        {"id":"n1","label":"Démocratie au Mali","type":"main"},
        {"id":"n2","label":"Pouvoir exécutif","type":"branch"},
        {"id":"n3","label":"Pouvoir législatif","type":"branch"},
        {"id":"n4","label":"Pouvoir judiciaire","type":"branch"},
        {"id":"n5","label":"Président, gouvernement","type":"leaf"},
        {"id":"n6","label":"Assemblée nationale","type":"leaf"},
        {"id":"n7","label":"Cours et tribunaux","type":"leaf"},
        {"id":"n8","label":"Constitution 1992","type":"leaf"},
        {"id":"n9","label":"Décentralisation","type":"leaf"},
        {"id":"n10","label":"Séparation des pouvoirs","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"gouverner"},
        {"from":"n1","to":"n3","label":"légiférer"},
        {"from":"n1","to":"n4","label":"juger"},
        {"from":"n2","to":"n5","label":"organes"},
        {"from":"n3","to":"n6","label":"organe"},
        {"from":"n4","to":"n7","label":"organes"},
        {"from":"n1","to":"n8","label":"fondement"},
        {"from":"n1","to":"n9","label":"local"},
        {"from":"n1","to":"n10","label":"principe"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"La démocratie signifie :","options":["Le pouvoir d''un seul","Le pouvoir du peuple","Le pouvoir de l''armée","Le pouvoir religieux"],"correct":1,"explanation":"Démocratie vient du grec « demos » (peuple) et « kratos » (pouvoir). C''est le régime politique dans lequel le pouvoir appartient au peuple."},
      {"id":"q2","question":"Le Mali est devenu une démocratie en :","options":["1960","1968","1991-1992","2002"],"correct":2,"explanation":"Le Mali est devenu une démocratie après la révolution du 26 mars 1991 (chute de Moussa Traoré) et l''adoption de la Constitution du 25 février 1992."},
      {"id":"q3","question":"Qui vote les lois au Mali ?","options":["Le Président","L''Assemblée nationale","Les militaires","Les juges"],"correct":1,"explanation":"L''Assemblée nationale est l''organe législatif qui vote les lois au Mali. Les députés examinent, amendent et adoptent les projets et propositions de lois."},
      {"id":"q4","question":"La séparation des pouvoirs a été théorisée par :","options":["Jean-Jacques Rousseau","Montesquieu","Voltaire","Karl Marx"],"correct":1,"explanation":"Montesquieu a théorisé la séparation des pouvoirs (exécutif, législatif, judiciaire) dans De l''esprit des lois (1748), principe fondamental de la démocratie."},
      {"id":"q5","question":"Le mandat présidentiel au Mali est de :","options":["4 ans","5 ans","6 ans","7 ans"],"correct":1,"explanation":"Le Président de la République du Mali est élu pour un mandat de 5 ans, renouvelable une seule fois."},
      {"id":"q6","question":"La décentralisation consiste à :","options":["Concentrer tous les pouvoirs à Bamako","Transférer des compétences aux collectivités locales","Supprimer les régions","Créer un État fédéral"],"correct":1,"explanation":"La décentralisation transfère des compétences et des ressources de l''État central vers les collectivités territoriales (communes, cercles, régions) pour rapprocher l''administration des citoyens."},
      {"id":"q7","question":"Combien de députés siègent à l''Assemblée nationale du Mali ?","options":["100","120","147","200"],"correct":2,"explanation":"L''Assemblée nationale du Mali compte 147 députés élus au suffrage universel direct pour un mandat de 5 ans."},
      {"id":"q8","question":"Le Mali est un État :","options":["Fédéral","Unitaire décentralisé","Monarchique","Théocratique"],"correct":1,"explanation":"Le Mali est un État unitaire décentralisé, une République laïque, démocratique et sociale, selon la Constitution de 1992."}
    ]
  }');

  -- ============================================================
  -- EPS - Chapitre 1 : Pratique sportive
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (eps_id, 'pratique-sportive', 1, 'Pratique sportive', 'Sports collectifs et individuels, socialisation', 1)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'pratique-sportive-fiche', 'Pratique sportive', 'Sports collectifs, individuels et rôle social du sport', true, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''EPS ?","answer":"L''Éducation Physique et Sportive (EPS) est une discipline scolaire qui vise le développement des capacités physiques, motrices et sociales des élèves. Objectifs : 1) Développer les qualités physiques (endurance, vitesse, force, souplesse). 2) Acquérir des techniques sportives. 3) Développer l''esprit d''équipe et le fair-play. 4) Contribuer à la santé et au bien-être. 5) Former des citoyens responsables par le sport."},
      {"id":"fc2","category":"Exemple","question":"Quels sont les principaux sports collectifs ?","answer":"Sports collectifs : 1) Football : 11 joueurs, terrain rectangulaire, but = marquer dans les cages adverses. 2) Basketball : 5 joueurs, panier à 3,05 m, 4 quart-temps de 10 min. 3) Handball : 7 joueurs, but = lancer le ballon dans les buts adverses. 4) Volleyball : 6 joueurs, filet, 3 touches maximum par équipe. Valeurs : coopération, communication, stratégie, esprit d''équipe, respect de l''adversaire et de l''arbitre."},
      {"id":"fc3","category":"Exemple","question":"Quels sont les principaux sports individuels ?","answer":"Sports individuels : 1) Athlétisme : courses (100m, 400m, 800m), sauts (hauteur, longueur), lancers (poids, disque, javelot). 2) Gymnastique : exercices au sol, agrès. 3) Natation : nage libre, dos, brasse, papillon. 4) Arts martiaux : judo, karaté, taekwondo. Ces sports développent l''autonomie, la discipline personnelle, le dépassement de soi et la gestion de l''effort."},
      {"id":"fc4","category":"Définition","question":"Quelles sont les qualités physiques fondamentales ?","answer":"Les 5 qualités physiques : 1) Endurance : capacité à maintenir un effort prolongé (course de fond, vélo). 2) Vitesse : capacité à effectuer un mouvement en un temps minimal (sprint). 3) Force : capacité à vaincre une résistance (musculation, lancers). 4) Souplesse : amplitude des mouvements articulaires (gymnastique, stretching). 5) Coordination : capacité à enchaîner des mouvements précis et harmonieux. Chaque sport mobilise ces qualités différemment."},
      {"id":"fc5","category":"Définition","question":"Qu''est-ce que le fair-play ?","answer":"Le fair-play (jeu loyal) est l''ensemble des comportements éthiques dans le sport : respect des règles du jeu, respect de l''adversaire, respect de l''arbitre, acceptation de la défaite, modestie dans la victoire, refus de la violence et de la tricherie, esprit sportif. Le fair-play est une valeur fondamentale qui dépasse le sport et s''applique à la vie en société (respect, honnêteté, tolérance)."},
      {"id":"fc6","category":"Exemple","question":"Quel est le rôle social du sport ?","answer":"Le sport comme facteur de socialisation : 1) Intégration sociale (créer des liens, appartenance à un groupe). 2) Éducation aux valeurs (respect, discipline, persévérance). 3) Santé publique (lutte contre la sédentarité, l''obésité). 4) Développement économique (emplois, tourisme sportif). 5) Cohésion nationale (équipes nationales, fierté patriotique). 6) Inclusion (sport pour les personnes handicapées). Au Mali, le football est un puissant facteur de cohésion sociale."},
      {"id":"fc7","category":"Méthode","question":"Comment préparer une épreuve d''EPS au baccalauréat ?","answer":"Préparation : 1) S''entraîner régulièrement (au moins 3 fois par semaine). 2) Travailler les techniques spécifiques (gestes sportifs). 3) Développer l''endurance (courses régulières). 4) Connaître les règles des sports au programme. 5) S''échauffer avant chaque séance (éviter les blessures). 6) Bien s''alimenter et s''hydrater. 7) Dormir suffisamment. 8) Gérer le stress le jour de l''épreuve. La régularité est la clé de la réussite."},
      {"id":"fc8","category":"Distinction","question":"Quelle différence entre sport collectif et sport individuel ?","answer":"Sport collectif : pratiqué en équipe, nécessite coopération, communication, stratégie collective, jeu de passes, rôles différenciés (attaquant, défenseur). Développe l''esprit d''équipe. Sport individuel : performance personnelle, autonomie, gestion individuelle de l''effort, confrontation à soi-même. Développe la discipline personnelle et le dépassement de soi. Les deux types sont complémentaires dans la formation de l''élève."}
    ],
    "schema": {
      "title": "Pratique sportive",
      "nodes": [
        {"id":"n1","label":"Pratique sportive","type":"main"},
        {"id":"n2","label":"Sports collectifs","type":"branch"},
        {"id":"n3","label":"Sports individuels","type":"branch"},
        {"id":"n4","label":"Valeurs du sport","type":"branch"},
        {"id":"n5","label":"Football, basket, handball","type":"leaf"},
        {"id":"n6","label":"Athlétisme, gymnastique","type":"leaf"},
        {"id":"n7","label":"Qualités physiques","type":"leaf"},
        {"id":"n8","label":"Fair-play, esprit d''équipe","type":"leaf"},
        {"id":"n9","label":"Socialisation","type":"leaf"},
        {"id":"n10","label":"Santé et bien-être","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"équipe"},
        {"from":"n1","to":"n3","label":"individuel"},
        {"from":"n1","to":"n4","label":"éducation"},
        {"from":"n2","to":"n5","label":"sports"},
        {"from":"n3","to":"n6","label":"sports"},
        {"from":"n1","to":"n7","label":"physique"},
        {"from":"n4","to":"n8","label":"éthique"},
        {"from":"n4","to":"n9","label":"social"},
        {"from":"n1","to":"n10","label":"objectif"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"L''EPS vise principalement à :","options":["Gagner des compétitions","Développer les capacités physiques, motrices et sociales","Former des sportifs professionnels","Remplacer les cours théoriques"],"correct":1,"explanation":"L''EPS a pour objectif principal le développement des capacités physiques, motrices et sociales des élèves, contribuant à leur santé et à leur formation citoyenne."},
      {"id":"q2","question":"Combien de joueurs composent une équipe de basketball ?","options":["5","7","9","11"],"correct":0,"explanation":"Une équipe de basketball est composée de 5 joueurs sur le terrain (plus des remplaçants sur le banc). Le match se joue en 4 quart-temps."},
      {"id":"q3","question":"L''endurance est la capacité à :","options":["Courir très vite","Maintenir un effort prolongé","Soulever des poids lourds","Faire le grand écart"],"correct":1,"explanation":"L''endurance est la capacité à maintenir un effort physique pendant une durée prolongée. Elle se développe par des activités comme la course de fond, le vélo ou la natation."},
      {"id":"q4","question":"Le fair-play signifie :","options":["Tricher pour gagner","Le jeu loyal et le respect des règles","Jouer seul","Refuser de participer"],"correct":1,"explanation":"Le fair-play est le jeu loyal : respect des règles, de l''adversaire, de l''arbitre, acceptation de la défaite et modestie dans la victoire."},
      {"id":"q5","question":"Le sport favorise la socialisation car :","options":["Il isole les individus","Il crée des liens sociaux et enseigne des valeurs","Il est obligatoire","Il remplace l''école"],"correct":1,"explanation":"Le sport favorise la socialisation en créant des liens entre les individus, en enseignant le respect, la coopération et la discipline, valeurs transférables dans la vie en société."},
      {"id":"q6","question":"Quel sport comprend les épreuves de course, saut et lancer ?","options":["Le football","Le basketball","L''athlétisme","Le handball"],"correct":2,"explanation":"L''athlétisme regroupe les épreuves de courses (sprint, fond), de sauts (hauteur, longueur) et de lancers (poids, disque, javelot). C''est le sport olympique par excellence."},
      {"id":"q7","question":"L''échauffement avant le sport sert à :","options":["Perdre du temps","Préparer le corps à l''effort et prévenir les blessures","Fatiguer les muscles","Remplacer l''entraînement"],"correct":1,"explanation":"L''échauffement prépare progressivement le corps à l''effort : il augmente la température musculaire, accélère le rythme cardiaque et prévient les blessures (entorses, claquages)."},
      {"id":"q8","question":"La principale différence entre sport collectif et individuel est :","options":["Le lieu de pratique","La coopération en équipe vs la performance individuelle","La durée du match","Le nombre de spectateurs"],"correct":1,"explanation":"En sport collectif, la performance dépend de la coopération entre coéquipiers. En sport individuel, la performance est personnelle. Les deux développent des compétences complémentaires."}
    ]
  }');

  -- ============================================================
  -- EPS - Chapitre 2 : Hygiène et physiologie
  -- ============================================================
  INSERT INTO chapters (subject_id, slug, number, title, description, display_order)
  VALUES (eps_id, 'hygiene-physiologie', 2, 'Hygiène et physiologie', 'Mode de vie sain, aptitudes physiques', 2)
  RETURNING id INTO v_chapter_id;

  INSERT INTO fiches (chapter_id, slug, title, subtitle, is_free, is_published, display_order, content)
  VALUES (v_chapter_id, 'hygiene-physiologie-fiche', 'Hygiène et physiologie', 'Hygiène de vie, nutrition et fonctionnement du corps', false, true, 1, '{
    "flashcards": [
      {"id":"fc1","category":"Définition","question":"Qu''est-ce que l''hygiène de vie ?","answer":"L''hygiène de vie est l''ensemble des comportements qui contribuent à maintenir et améliorer la santé : 1) Alimentation équilibrée. 2) Activité physique régulière. 3) Sommeil suffisant (8-10h pour un adolescent). 4) Hygiène corporelle (douche quotidienne, lavage des mains). 5) Éviter le tabac, l''alcool et les drogues. 6) Gestion du stress. 7) Hydratation suffisante (1,5-2 L d''eau par jour). Une bonne hygiène de vie prévient de nombreuses maladies."},
      {"id":"fc2","category":"Définition","question":"Quels sont les principes d''une alimentation équilibrée ?","answer":"Alimentation équilibrée : 1) Glucides (céréales, riz, mil, pain) : 50-55 % des apports, source d''énergie. 2) Lipides (huile, beurre, arachide) : 30-35 %, énergie et fonctions cellulaires. 3) Protéines (viande, poisson, légumineuses) : 12-15 %, construction musculaire. 4) Vitamines et minéraux (fruits, légumes). 5) Eau (1,5-2 L/jour). 6) Fibres (céréales complètes, légumes). Manger varié, en quantité adaptée aux besoins."},
      {"id":"fc3","category":"Définition","question":"Comment fonctionne le système musculaire ?","answer":"Le système musculaire comprend environ 600 muscles. Types : 1) Muscles squelettiques (striés, volontaires) : permettent le mouvement. 2) Muscles lisses (involontaires) : organes internes (intestins, vaisseaux). 3) Muscle cardiaque (cœur). La contraction musculaire consomme de l''énergie (ATP provenant du glucose et de l''oxygène). L''entraînement développe la force et l''endurance musculaire (hypertrophie)."},
      {"id":"fc4","category":"Définition","question":"Comment le système cardiovasculaire fonctionne-t-il pendant l''effort ?","answer":"Pendant l''effort : 1) Le cœur bat plus vite (fréquence cardiaque augmente de 60-70 au repos à 180-200 bpm à l''effort maximal). 2) Le débit cardiaque augmente (plus de sang distribué). 3) Les muscles reçoivent plus de sang (oxygène et glucose). 4) La respiration s''accélère (plus d''O₂ absorbé, plus de CO₂ éliminé). 5) La température corporelle augmente (transpiration pour refroidir). L''entraînement améliore l''efficacité cardiovasculaire."},
      {"id":"fc5","category":"Méthode","question":"Comment s''échauffer correctement ?","answer":"L''échauffement (10-15 min) : 1) Phase générale : course légère, montées de genoux, talons-fesses pour augmenter la température corporelle et le rythme cardiaque. 2) Mobilisations articulaires : rotations des chevilles, genoux, hanches, épaules, cou. 3) Étirements dynamiques (pas statiques). 4) Phase spécifique : gestes du sport pratiqué à intensité progressive. Un bon échauffement réduit le risque de blessure de 50 %."},
      {"id":"fc6","category":"Exemple","question":"Quels sont les effets bénéfiques de l''activité physique ?","answer":"Effets bénéfiques : 1) Cardiovasculaire : renforce le cœur, baisse la tension artérielle. 2) Musculaire : développe la force et l''endurance. 3) Osseux : renforce les os (prévention de l''ostéoporose). 4) Mental : réduit le stress, améliore l''humeur (endorphines), favorise le sommeil. 5) Métabolique : contrôle du poids, régulation du sucre sanguin. 6) Social : liens sociaux, confiance en soi. Recommandation OMS : 60 min d''activité modérée par jour pour les jeunes."},
      {"id":"fc7","category":"Distinction","question":"Quelles sont les blessures sportives courantes ?","answer":"Blessures courantes : 1) Entorse : étirement ou déchirure des ligaments (cheville +++). 2) Claquage : déchirure musculaire. 3) Tendinite : inflammation d''un tendon (surutilisation). 4) Fracture : rupture d''un os. 5) Crampe : contraction involontaire et douloureuse du muscle (déshydratation, fatigue). Prévention : échauffement, hydratation, étirements, matériel adapté, progression dans l''entraînement. Traitement immédiat : GREC (Glace, Repos, Élévation, Compression)."},
      {"id":"fc8","category":"Méthode","question":"Comment gérer la récupération après l''effort ?","answer":"Récupération : 1) Retour au calme progressif (marche, trottinage léger). 2) Étirements doux (10 min, sans forcer). 3) Réhydratation (eau, pas de boissons sucrées). 4) Alimentation : glucides et protéines dans les 30 min suivant l''effort. 5) Sommeil suffisant (la récupération musculaire se fait pendant le sommeil). 6) Repos entre les séances (au moins 48h pour le même groupe musculaire). La récupération est aussi importante que l''entraînement."}
    ],
    "schema": {
      "title": "Hygiène et physiologie",
      "nodes": [
        {"id":"n1","label":"Hygiène et physiologie","type":"main"},
        {"id":"n2","label":"Hygiène de vie","type":"branch"},
        {"id":"n3","label":"Physiologie de l''effort","type":"branch"},
        {"id":"n4","label":"Prévention","type":"branch"},
        {"id":"n5","label":"Alimentation, sommeil, hydratation","type":"leaf"},
        {"id":"n6","label":"Système musculaire","type":"leaf"},
        {"id":"n7","label":"Système cardiovasculaire","type":"leaf"},
        {"id":"n8","label":"Échauffement","type":"leaf"},
        {"id":"n9","label":"Blessures et prévention","type":"leaf"},
        {"id":"n10","label":"Récupération","type":"leaf"}
      ],
      "edges": [
        {"from":"n1","to":"n2","label":"mode de vie"},
        {"from":"n1","to":"n3","label":"corps et effort"},
        {"from":"n1","to":"n4","label":"sécurité"},
        {"from":"n2","to":"n5","label":"besoins"},
        {"from":"n3","to":"n6","label":"muscles"},
        {"from":"n3","to":"n7","label":"cœur"},
        {"from":"n4","to":"n8","label":"avant l''effort"},
        {"from":"n4","to":"n9","label":"risques"},
        {"from":"n4","to":"n10","label":"après l''effort"}
      ]
    },
    "quiz": [
      {"id":"q1","question":"Combien de litres d''eau faut-il boire par jour ?","options":["0,5 L","1-1,5 L","1,5-2 L","4 L"],"correct":2,"explanation":"Il est recommandé de boire 1,5 à 2 litres d''eau par jour, davantage en cas d''effort physique ou de chaleur, pour maintenir une bonne hydratation."},
      {"id":"q2","question":"Les glucides sont principalement :","options":["Des sources de protéines","Des sources d''énergie","Des vitamines","Des minéraux"],"correct":1,"explanation":"Les glucides (sucres et amidons : riz, mil, pain, pâtes) sont la principale source d''énergie du corps. Ils doivent représenter 50-55 % des apports alimentaires."},
      {"id":"q3","question":"La fréquence cardiaque au repos est d''environ :","options":["30-40 bpm","60-70 bpm","120-140 bpm","200 bpm"],"correct":1,"explanation":"La fréquence cardiaque au repos est d''environ 60 à 70 battements par minute chez un adulte en bonne santé. Elle peut descendre à 40-50 bpm chez les sportifs entraînés."},
      {"id":"q4","question":"L''échauffement doit durer :","options":["1-2 minutes","5 minutes","10-15 minutes","30 minutes"],"correct":2,"explanation":"Un échauffement efficace dure 10 à 15 minutes. Il comprend une phase générale (course légère), des mobilisations articulaires et une phase spécifique au sport pratiqué."},
      {"id":"q5","question":"Une entorse est :","options":["Une fracture osseuse","Un étirement ou déchirure des ligaments","Une crampe musculaire","Une maladie infectieuse"],"correct":1,"explanation":"L''entorse est un étirement ou une déchirure des ligaments (tissus reliant les os entre eux), le plus souvent au niveau de la cheville. Elle survient lors d''un faux mouvement."},
      {"id":"q6","question":"L''OMS recommande aux jeunes combien de minutes d''activité physique par jour ?","options":["15 minutes","30 minutes","60 minutes","120 minutes"],"correct":2,"explanation":"L''OMS recommande au moins 60 minutes d''activité physique d''intensité modérée à soutenue par jour pour les enfants et adolescents (5-17 ans)."},
      {"id":"q7","question":"Les endorphines libérées par le sport provoquent :","options":["De la douleur","Une sensation de bien-être","De la fatigue extrême","Des crampes"],"correct":1,"explanation":"Les endorphines sont des hormones du bien-être libérées par le cerveau pendant l''effort physique. Elles procurent une sensation de plaisir et réduisent le stress et la douleur."},
      {"id":"q8","question":"Le protocole GREC pour traiter une blessure signifie :","options":["Grand Repos Et Chaleur","Glace, Repos, Élévation, Compression","Gymnastique, Récupération, Exercice, Course","Aucune de ces réponses"],"correct":1,"explanation":"GREC = Glace (réduire l''inflammation), Repos (ne pas forcer), Élévation (surélever le membre blessé), Compression (bandage). C''est le traitement immédiat des blessures sportives bénignes."}
    ]
  }');

END $$;
