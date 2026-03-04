-- À exécuter dans Supabase SQL Editor (Dashboard > SQL Editor > coller et exécuter)
-- Cette migration corrige :
-- 1. Les champs color et icon des matières (pour les couleurs et icônes)
-- 2. Les accents manquants dans les noms de matières et chapitres

-- ============================================================
-- 1. COULEURS ET ICÔNES DES MATIÈRES
-- ============================================================

-- Économie
UPDATE subjects SET color = 'eco', icon = 'TrendingUp'
WHERE slug = 'eco';

-- Comptabilité et Commerce
UPDATE subjects SET color = 'compta', icon = 'Calculator'
WHERE slug = 'compta';

-- Philosophie
UPDATE subjects SET color = 'philo', icon = 'Brain'
WHERE slug = 'philo';

-- Droit
UPDATE subjects SET color = 'droit', icon = 'Scale'
WHERE slug = 'droit';

-- Maths Financières
UPDATE subjects SET color = 'maths', icon = 'Sigma'
WHERE slug = 'maths';

-- Français
UPDATE subjects SET color = 'francais', icon = 'BookOpen'
WHERE slug = 'francais';

-- Histoire-Géo
UPDATE subjects SET color = 'histgeo', icon = 'Globe'
WHERE slug = 'histgeo';

-- Anglais
UPDATE subjects SET color = 'anglais', icon = 'Languages'
WHERE slug = 'anglais';

-- ============================================================
-- 2. ACCENTS DES MATIÈRES
-- ============================================================

UPDATE subjects SET name = 'Économie'
WHERE name = 'Economie';

UPDATE subjects SET name = 'Comptabilité et Commerce'
WHERE name = 'Comptabilite et Commerce';

UPDATE subjects SET name = 'Maths Financières'
WHERE name = 'Maths Financieres';

UPDATE subjects SET name = 'Français'
WHERE name = 'Francais';

UPDATE subjects SET name = 'Histoire-Géo'
WHERE name = 'Histoire-Geo';

-- ============================================================
-- 3. ACCENTS DES SÉRIES
-- ============================================================

UPDATE series SET name = 'Terminale Sciences Économiques'
WHERE name = 'Terminale Sciences Economiques';

-- ============================================================
-- 4. ACCENTS DES CHAPITRES
-- ============================================================

-- Économie
UPDATE chapters SET title = 'Croissance économique et développement'
WHERE title = 'Croissance economique et developpement';

UPDATE chapters SET description = 'Définition, IDH, développement durable'
WHERE description = 'Definition, IDH, developpement durable';

UPDATE chapters SET title = 'Technique de la dissertation économique'
WHERE title = 'Technique de la dissertation economique';

UPDATE chapters SET description = 'Méthodologie de la dissertation en économie'
WHERE description = 'Methodologie de la dissertation en economie';

UPDATE chapters SET title = 'La croissance démographique et ses conséquences'
WHERE title = 'La croissance demographique et ses consequences';

UPDATE chapters SET description = 'Transition démographique, politiques de population'
WHERE description = 'Transition demographique, politiques de population';

UPDATE chapters SET title = 'Les pays industrialisés capitalistes'
WHERE title = 'Les pays industrialises capitalistes';

UPDATE chapters SET description = 'Économies de marché, modèles de développement'
WHERE description = 'Economies de marche, modeles de developpement';

UPDATE chapters SET title = 'Les pays en développement'
WHERE title = 'Les pays en developpement';

UPDATE chapters SET description = 'Caractéristiques, défis, stratégies de développement'
WHERE description = 'Caracteristiques, defis, strategies de developpement';

UPDATE chapters SET title = 'Les échanges internationaux'
WHERE title = 'Les echanges internationaux';

UPDATE chapters SET description = 'Commerce international, mondialisation, protectionnisme'
WHERE description = 'Commerce international, mondialisation, protectionnisme';

UPDATE chapters SET title = 'Le système monétaire international'
WHERE title = 'Le systeme monetaire international';

UPDATE chapters SET description = 'Taux de change, FMI, Banque Mondiale'
WHERE description = 'Taux de change, FMI, Banque Mondiale';

-- Comptabilité
UPDATE chapters SET title = 'Les opérations courantes'
WHERE title = 'Les operations courantes';

UPDATE chapters SET description = 'Achats, ventes, règlements, TVA'
WHERE description = 'Achats, ventes, reglements, TVA';

UPDATE chapters SET title = 'Les opérations d''investissement'
WHERE title = 'Les operations d''investissement';

UPDATE chapters SET description = 'Immobilisations, amortissements, cessions'
WHERE description = 'Immobilisations, amortissements, cessions';

UPDATE chapters SET title = 'Les opérations de financement'
WHERE title = 'Les operations de financement';

UPDATE chapters SET description = 'Emprunts, crédit-bail, augmentation de capital'
WHERE description = 'Emprunts, credit-bail, augmentation de capital';

UPDATE chapters SET title = 'Les travaux d''inventaire'
WHERE title = 'Les travaux d''inventaire';

UPDATE chapters SET description = 'Régularisations, provisions, états financiers'
WHERE description = 'Regularisations, provisions, etats financiers';

-- Maths Financières
UPDATE chapters SET title = 'Les intérêts simples'
WHERE title = 'Les interets simples';

UPDATE chapters SET description = 'Calcul d''intérêts, escompte, taux effectif'
WHERE description = 'Calcul d''interets, escompte, taux effectif';

UPDATE chapters SET title = 'Les intérêts composés'
WHERE title = 'Les interets composes';

UPDATE chapters SET description = 'Capitalisation, actualisation, taux équivalent'
WHERE description = 'Capitalisation, actualisation, taux equivalent';

UPDATE chapters SET title = 'Les annuités'
WHERE title = 'Les annuites';

UPDATE chapters SET description = 'Annuités constantes, valeur acquise, valeur actuelle'
WHERE description = 'Annuites constantes, valeur acquise, valeur actuelle';

UPDATE chapters SET title = 'Les emprunts indivis'
WHERE title = 'Les emprunts indivis';

UPDATE chapters SET description = 'Tableau d''amortissement, annuités constantes'
WHERE description = 'Tableau d''amortissement, annuites constantes';

UPDATE chapters SET title = 'Espérance mathématique et probabilités'
WHERE title = 'Esperance mathematique et probabilites';

UPDATE chapters SET description = 'Variable aléatoire, loi de probabilité, espérance'
WHERE description = 'Variable aleatoire, loi de probabilite, esperance';

-- Philosophie
UPDATE chapters SET title = 'La conscience et l''inconscient'
WHERE title = 'La conscience et l''inconscient';

UPDATE chapters SET description = 'Descartes, Freud, liberté et déterminisme'
WHERE description = 'Descartes, Freud, liberte et determinisme';

UPDATE chapters SET title = 'La liberté et le déterminisme'
WHERE title = 'La liberte et le determinisme';

UPDATE chapters SET description = 'Libre arbitre, nécessité, responsabilité'
WHERE description = 'Libre arbitre, necessite, responsabilite';

UPDATE chapters SET title = 'La vérité'
WHERE title = 'La verite';

UPDATE chapters SET description = 'Critères de vérité, opinion, science'
WHERE description = 'Criteres de verite, opinion, science';

-- Droit
UPDATE chapters SET title = 'L''organisation juridictionnelle'
WHERE title = 'L''organisation juridictionnelle';

UPDATE chapters SET title = 'Le droit des sociétés commerciales'
WHERE title = 'Le droit des societes commerciales';

UPDATE chapters SET description = 'Création, fonctionnement, dissolution des sociétés'
WHERE description = 'Creation, fonctionnement, dissolution des societes';

UPDATE chapters SET title = 'Le droit du travail'
WHERE title = 'Le droit du travail';

UPDATE chapters SET description = 'Contrat de travail, licenciement, syndicats'
WHERE description = 'Contrat de travail, licenciement, syndicats';

-- Français
UPDATE chapters SET title = 'La dissertation littéraire'
WHERE title = 'La dissertation litteraire';

UPDATE chapters SET description = 'Méthodologie, argumentation, rédaction'
WHERE description = 'Methodologie, argumentation, redaction';

UPDATE chapters SET title = 'Le commentaire composé'
WHERE title = 'Le commentaire compose';

UPDATE chapters SET description = 'Analyse littéraire, plan, rédaction'
WHERE description = 'Analyse litteraire, plan, redaction';

UPDATE chapters SET title = 'Le résumé et la discussion'
WHERE title = 'Le resume et la discussion';

UPDATE chapters SET description = 'Techniques de résumé, contraction de texte'
WHERE description = 'Techniques de resume, contraction de texte';

UPDATE chapters SET title = 'Étude d''œuvres au programme'
WHERE title = 'Etude d''oeuvres au programme';

UPDATE chapters SET description = 'Analyse des œuvres littéraires prescrites'
WHERE description = 'Analyse des oeuvres litteraires prescrites';

-- Histoire-Géo
UPDATE chapters SET title = 'La Seconde Guerre mondiale et ses conséquences'
WHERE title = 'La Seconde Guerre mondiale et ses consequences';

UPDATE chapters SET description = 'Causes, déroulement, bilan, conséquences'
WHERE description = 'Causes, deroulement, bilan, consequences';

UPDATE chapters SET title = 'La décolonisation en Afrique'
WHERE title = 'La decolonisation en Afrique';

UPDATE chapters SET description = 'Mouvements nationalistes, indépendances'
WHERE description = 'Mouvements nationalistes, independances';

UPDATE chapters SET title = 'Les organisations internationales'
WHERE title = 'Les organisations internationales';

UPDATE chapters SET title = 'La géographie du Mali'
WHERE title = 'La geographie du Mali';

UPDATE chapters SET description = 'Relief, climat, population, économie'
WHERE description = 'Relief, climat, population, economie';

UPDATE chapters SET title = 'La géographie de l''Afrique'
WHERE title = 'La geographie de l''Afrique';

UPDATE chapters SET description = 'Ressources naturelles, développement, intégration régionale'
WHERE description = 'Ressources naturelles, developpement, integration regionale';

UPDATE chapters SET title = 'La géographie du monde contemporain'
WHERE title = 'La geographie du monde contemporain';

UPDATE chapters SET description = 'Mondialisation, inégalités, enjeux environnementaux'
WHERE description = 'Mondialisation, inegalites, enjeux environnementaux';

UPDATE chapters SET title = 'L''histoire du Mali indépendant'
WHERE title = 'L''histoire du Mali independant';

UPDATE chapters SET description = 'De l''indépendance à aujourd''hui'
WHERE description = 'De l''independance a aujourd''hui';

-- Fiches: corriger aussi les titres des fiches si nécessaire
UPDATE fiches SET title = 'Croissance économique et développement'
WHERE title = 'Croissance economique et developpement';

UPDATE fiches SET title = 'Technique de la dissertation économique'
WHERE title = 'Technique de la dissertation economique';

UPDATE fiches SET title = 'La croissance démographique et ses conséquences'
WHERE title = 'La croissance demographique et ses consequences';

UPDATE fiches SET title = 'Les pays industrialisés capitalistes'
WHERE title = 'Les pays industrialises capitalistes';

UPDATE fiches SET title = 'Les pays en développement'
WHERE title = 'Les pays en developpement';

UPDATE fiches SET title = 'Les échanges internationaux'
WHERE title = 'Les echanges internationaux';

UPDATE fiches SET title = 'Le système monétaire international'
WHERE title = 'Le systeme monetaire international';

UPDATE fiches SET title = 'Les opérations courantes'
WHERE title = 'Les operations courantes';

UPDATE fiches SET title = 'Les opérations d''investissement'
WHERE title = 'Les operations d''investissement';

UPDATE fiches SET title = 'Les opérations de financement'
WHERE title = 'Les operations de financement';

UPDATE fiches SET title = 'Les travaux d''inventaire'
WHERE title = 'Les travaux d''inventaire';

UPDATE fiches SET title = 'Les intérêts simples'
WHERE title = 'Les interets simples';

UPDATE fiches SET title = 'Les intérêts composés'
WHERE title = 'Les interets composes';

UPDATE fiches SET title = 'Les annuités'
WHERE title = 'Les annuites';

UPDATE fiches SET title = 'Les emprunts indivis'
WHERE title = 'Les emprunts indivis';

UPDATE fiches SET title = 'Espérance mathématique et probabilités'
WHERE title = 'Esperance mathematique et probabilites';

UPDATE fiches SET title = 'La conscience et l''inconscient'
WHERE title = 'La conscience et l''inconscient';

UPDATE fiches SET title = 'La liberté et le déterminisme'
WHERE title = 'La liberte et le determinisme';

UPDATE fiches SET title = 'La vérité'
WHERE title = 'La verite';

UPDATE fiches SET title = 'Le droit des sociétés commerciales'
WHERE title = 'Le droit des societes commerciales';

UPDATE fiches SET title = 'La dissertation littéraire'
WHERE title = 'La dissertation litteraire';

UPDATE fiches SET title = 'Le commentaire composé'
WHERE title = 'Le commentaire compose';

UPDATE fiches SET title = 'Le résumé et la discussion'
WHERE title = 'Le resume et la discussion';

UPDATE fiches SET title = 'Étude d''œuvres au programme'
WHERE title = 'Etude d''oeuvres au programme';

UPDATE fiches SET title = 'La Seconde Guerre mondiale et ses conséquences'
WHERE title = 'La Seconde Guerre mondiale et ses consequences';

UPDATE fiches SET title = 'La décolonisation en Afrique'
WHERE title = 'La decolonisation en Afrique';

UPDATE fiches SET title = 'La géographie du Mali'
WHERE title = 'La geographie du Mali';

UPDATE fiches SET title = 'La géographie de l''Afrique'
WHERE title = 'La geographie de l''Afrique';

UPDATE fiches SET title = 'La géographie du monde contemporain'
WHERE title = 'La geographie du monde contemporain';

UPDATE fiches SET title = 'L''histoire du Mali indépendant'
WHERE title = 'L''histoire du Mali independant';
