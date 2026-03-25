-- ============================================================
--  TIFOSI - Script 3 : Requêtes de vérification
--  Contient : numéro, but, code SQL, résultat attendu,
--             résultat obtenu, commentaires sur les écarts
-- ============================================================

USE tifosi;

-- ============================================================
--  REQUÊTE 1
--  But : Afficher la liste des noms des focaccias
--        par ordre alphabétique croissant
-- ============================================================
SELECT nom
FROM focaccia
ORDER BY nom ASC;

/*
  Résultat attendu :
  +------------------+
  | nom              |
  +------------------+
  | Américaine       |
  | Emmentalaccia    |
  | Gorgonzollaccia  |
  | Hawaienne        |
  | Mozaccia         |
  | Paysanne         |
  | Raclaccia        |
  | Tradizione       |
  +------------------+
  8 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 2
--  But : Afficher le nombre total d'ingrédients
-- ============================================================
SELECT COUNT(*) AS nombre_total_ingredients
FROM ingredient;

/*
  Résultat attendu :
  +---------------------------+
  | nombre_total_ingredients  |
  +---------------------------+
  | 25                        |
  +---------------------------+
  1 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 3
--  But : Afficher le prix moyen des focaccias
-- ============================================================
SELECT ROUND(AVG(prix), 2) AS prix_moyen_focaccia
FROM focaccia;

/*
  Résultat attendu :
  Calcul : (9.80 + 10.80 + 8.90 + 9.80 + 8.90 + 11.20 + 10.80 + 12.80) / 8
         = 83.00 / 8 = 10.375 -> arrondi à 10.38

  +---------------------+
  | prix_moyen_focaccia |
  +---------------------+
  | 10.38               |
  +---------------------+
  1 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 4
--  But : Afficher la liste des boissons avec leur marque,
--        triée par nom de boisson
-- ============================================================
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;

/*
  Résultat attendu :
  +---------------------------+-------------+
  | boisson                   | marque      |
  +---------------------------+-------------+
  | Capri-sun                 | Coca-cola   |
  | Coca-cola original        | Coca-cola   |
  | Coca-cola zero            | Coca-cola   |
  | Eau de source             | Cristalline |
  | Fanta citron              | Coca-cola   |
  | Fanta orange              | Coca-cola   |
  | Lipton Peach              | Pepsico     |
  | Lipton zero citron        | Pepsico     |
  | Monster energy ultra blue | Monster     |
  | Monster energy ultra gold | Monster     |
  | Pepsi                     | Pepsico     |
  | Pepsi Max Zero            | Pepsico     |
  +---------------------------+-------------+
  12 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 5
--  But : Afficher la liste des ingrédients pour une Raclaccia
-- ============================================================
SELECT i.nom AS ingredient, fi.quantite AS quantite_g
FROM focaccia_ingredient fi
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
JOIN focaccia f ON f.id_focaccia = fi.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

/*
  Résultat attendu :
  +-------------+------------+
  | ingredient  | quantite_g |
  +-------------+------------+
  | Ail         | 2          |
  | Base Tomate | 200        |
  | Champignon  | 40         |
  | Cresson     | 20         |
  | Parmesan    | 50         |
  | Poivre      | 1          |
  | Raclette    | 50         |
  +-------------+------------+
  7 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 6
--  But : Afficher le nom et le nombre d'ingrédients
--        pour chaque focaccia
-- ============================================================
SELECT f.nom AS focaccia, COUNT(fi.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

/*
  Résultat attendu :
  +------------------+----------------+
  | focaccia         | nb_ingredients |
  +------------------+----------------+
  | Américaine       | 8              |
  | Emmentalaccia    | 7              |
  | Gorgonzollaccia  | 8              |
  | Hawaienne        | 9              |
  | Mozaccia         | 10             |
  | Paysanne         | 12             |
  | Raclaccia        | 7              |
  | Tradizione       | 9              |
  +------------------+----------------+
  8 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 7
--  But : Afficher le nom de la focaccia qui a le plus
--        d'ingrédients
-- ============================================================
SELECT f.nom AS focaccia, COUNT(fi.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

/*
  Résultat attendu :
  +----------+----------------+
  | focaccia | nb_ingredients |
  +----------+----------------+
  | Paysanne | 12             |
  +----------+----------------+
  1 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 8
--  But : Afficher la liste des focaccias qui contiennent
--        de l'ail
-- ============================================================
SELECT f.nom AS focaccia
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

/*
  Résultat attendu :
  +------------------+
  | focaccia         |
  +------------------+
  | Gorgonzollaccia  |
  | Mozaccia         |
  | Paysanne         |
  | Raclaccia        |
  +------------------+
  4 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 9
--  But : Afficher la liste des ingrédients inutilisés
--        (présents dans la table ingredient mais dans
--        aucune focaccia)
-- ============================================================
SELECT i.nom AS ingredient_inutilise
FROM ingredient i
WHERE i.id_ingredient NOT IN (
    SELECT DISTINCT fi.id_ingredient FROM focaccia_ingredient fi
)
ORDER BY i.nom ASC;

/*
  Résultat attendu :
  +----------------------+
  | ingredient_inutilise |
  +----------------------+
  | Salami               |
  | Tomate cerise        |
  +----------------------+
  2 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/


-- ============================================================
--  REQUÊTE 10
--  But : Afficher la liste des focaccias qui n'ont pas
--        de champignons
-- ============================================================
SELECT f.nom AS focaccia_sans_champignon
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM focaccia_ingredient fi
    JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;

/*
  Résultat attendu :
  +--------------------------+
  | focaccia_sans_champignon |
  +--------------------------+
  | Américaine               |
  | Hawaienne                |
  +--------------------------+
  2 ligne(s) retournée(s)

  Résultat obtenu : conforme au résultat attendu.
  Aucun écart constaté.
*/

-- ============================================================
--  FIN DU SCRIPT 3
-- ============================================================
