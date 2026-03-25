-- ============================================================
--  TIFOSI - Script 3 : Requêtes de vérification (10 requêtes)
-- ============================================================

USE tifosi;

-- ============================================================
--  REQUÊTE 1
--  But     : Afficher la liste des noms des focaccias
--            par ordre alphabétique croissant
--  Résultat attendu : 8 lignes triées de A à Z
-- ============================================================
SELECT nom
FROM   focaccia
ORDER BY nom ASC;

-- Résultat attendu :
-- Américaine
-- Emmentalaccia
-- Gorgonzollaccia
-- Hawaienne
-- Mozaccia
-- Paysanne
-- Raclaccia
-- Tradizione

-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 2
--  But     : Afficher le nombre total d'ingrédients
--  Résultat attendu : 25
-- ============================================================
SELECT COUNT(*) AS nombre_total_ingredients
FROM   ingredient;

-- Résultat attendu : 25
-- Résultat obtenu : 25 ✔


-- ============================================================
--  REQUÊTE 3
--  But     : Afficher le prix moyen des focaccias
--  Résultat attendu : (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8
--                   = 83.00 / 8 = 10.375 → 10.38 (arrondi 2 décimales)
-- ============================================================
SELECT ROUND(AVG(prix), 2) AS prix_moyen_focaccia
FROM   focaccia;

-- Résultat attendu : 10.38
-- Résultat obtenu : 10.38 ✔


-- ============================================================
--  REQUÊTE 4
--  But     : Afficher la liste des boissons avec leur marque,
--            triée par nom de boisson
--  Résultat attendu : 12 lignes avec nom boisson + nom marque
-- ============================================================
SELECT b.nom  AS boisson,
       m.nom  AS marque
FROM   boisson b
JOIN   marque  m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;

-- Résultat attendu :
-- Capri-sun            | Coca-cola
-- Coca-cola original   | Coca-cola
-- Coca-cola zéro       | Coca-cola
-- Eau de source        | Cristalline
-- Fanta citron         | Coca-cola
-- Fanta orange         | Coca-cola
-- Lipton Peach         | Pepsico
-- Lipton zéro citron   | Pepsico
-- Monster energy ultra blue | Monster
-- Monster energy ultra gold | Monster
-- Pepsi                | Pepsico
-- Pepsi Max Zéro       | Pepsico
-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 5
--  But     : Afficher la liste des ingrédients pour une Raclaccia
--            (id_focaccia = 3)
--  Résultat attendu : 7 ingrédients
-- ============================================================
SELECT i.nom        AS ingredient,
       fi.quantite  AS quantite_g
FROM   focaccia_ingredient fi
JOIN   ingredient          i  ON i.id_ingredient = fi.id_ingredient
JOIN   focaccia            f  ON f.id_focaccia   = fi.id_focaccia
WHERE  f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- Résultat attendu :
-- Ail          | 2
-- Base Tomate  | 200
-- Champignon   | 40
-- Cresson      | 20
-- Parmesan     | 50
-- Poivre       | 1
-- Raclette     | 50
-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 6
--  But     : Afficher le nom et le nombre d'ingrédients
--            pour chaque focaccia
--  Résultat attendu : 8 lignes
-- ============================================================
SELECT f.nom                    AS focaccia,
       COUNT(fi.id_ingredient)  AS nb_ingredients
FROM   focaccia            f
JOIN   focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- Résultat attendu :
-- Américaine      | 8
-- Emmentalaccia   | 7
-- Gorgonzollaccia | 8
-- Hawaienne       | 9
-- Mozaccia        | 10
-- Paysanne        | 12
-- Raclaccia       | 7
-- Tradizione      | 9
-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 7
--  But     : Afficher le nom de la focaccia qui a le plus
--            d'ingrédients
--  Résultat attendu : Paysanne (12 ingrédients)
-- ============================================================
SELECT f.nom                    AS focaccia,
       COUNT(fi.id_ingredient)  AS nb_ingredients
FROM   focaccia            f
JOIN   focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- Résultat attendu : Paysanne | 12
-- Résultat obtenu : Paysanne | 12 ✔


-- ============================================================
--  REQUÊTE 8
--  But     : Afficher la liste des focaccias qui contiennent
--            de l'ail (id_ingredient = 1)
--  Résultat attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne
-- ============================================================
SELECT f.nom AS focaccia
FROM   focaccia            f
JOIN   focaccia_ingredient fi ON fi.id_focaccia   = f.id_focaccia
JOIN   ingredient          i  ON i.id_ingredient  = fi.id_ingredient
WHERE  i.nom = 'Ail'
ORDER BY f.nom ASC;

-- Résultat attendu :
-- Gorgonzollaccia
-- Mozaccia
-- Paysanne
-- Raclaccia
-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 9
--  But     : Afficher la liste des ingrédients inutilisés
--            (présents dans la table ingredient mais dans
--            aucune focaccia)
--  Résultat attendu : Salami, Tomate cerise (non utilisés dans le menu)
-- ============================================================
SELECT i.nom AS ingredient_inutilise
FROM   ingredient i
WHERE  i.id_ingredient NOT IN (
    SELECT DISTINCT fi.id_ingredient
    FROM   focaccia_ingredient fi
)
ORDER BY i.nom ASC;

-- Résultat attendu :
-- Salami
-- Tomate cerise
-- Résultat obtenu : conforme ✔


-- ============================================================
--  REQUÊTE 10
--  But     : Afficher la liste des focaccias qui n'ont pas
--            de champignons (id_ingredient = 7)
--  Résultat attendu : Hawaienne, Paysanne... → non, voyons :
--    Champignons dans : Mozaccia(1), Gorgonzollaccia(2),
--    Raclaccia(3), Emmentalaccia(4), Tradizione(5), Paysanne(8)
--    Sans champignons : Hawaienne(6), Américaine(7)
-- ============================================================
SELECT f.nom AS focaccia_sans_champignon
FROM   focaccia f
WHERE  f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM   focaccia_ingredient fi
    JOIN   ingredient          i ON i.id_ingredient = fi.id_ingredient
    WHERE  i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

-- Résultat attendu :
-- Américaine
-- Hawaienne
-- Résultat obtenu : conforme ✔

-- ============================================================
--  FIN DU SCRIPT 3
-- ============================================================
