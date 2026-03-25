USE tifosi;

-- REQUÊTE 1 : Liste des focaccias par ordre alphabétique
SELECT nom FROM focaccia ORDER BY nom ASC;

-- REQUÊTE 2 : Nombre total d'ingrédients
SELECT COUNT(*) AS nombre_total_ingredients FROM ingredient;

-- REQUÊTE 3 : Prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) AS prix_moyen_focaccia FROM focaccia;

-- REQUÊTE 4 : Liste des boissons avec leur marque, triée par boisson
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom ASC;

-- REQUÊTE 5 : Ingrédients de la Raclaccia
SELECT i.nom AS ingredient, fi.quantite AS quantite_g
FROM focaccia_ingredient fi
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
JOIN focaccia f ON f.id_focaccia = fi.id_focaccia
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom ASC;

-- REQUÊTE 6 : Nom et nombre d'ingrédients pour chaque focaccia
SELECT f.nom AS focaccia, COUNT(fi.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY f.nom ASC;

-- REQUÊTE 7 : Focaccia qui a le plus d'ingrédients
SELECT f.nom AS focaccia, COUNT(fi.id_ingredient) AS nb_ingredients
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
GROUP BY f.id_focaccia, f.nom
ORDER BY nb_ingredients DESC
LIMIT 1;

-- REQUÊTE 8 : Focaccias qui contiennent de l'ail
SELECT f.nom AS focaccia
FROM focaccia f
JOIN focaccia_ingredient fi ON fi.id_focaccia = f.id_focaccia
JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom ASC;

-- REQUÊTE 9 : Ingrédients inutilisés
SELECT i.nom AS ingredient_inutilise
FROM ingredient i
WHERE i.id_ingredient NOT IN (
    SELECT DISTINCT fi.id_ingredient FROM focaccia_ingredient fi
)
ORDER BY i.nom ASC;

-- REQUÊTE 10 : Focaccias sans champignons
SELECT f.nom AS focaccia_sans_champignon
FROM focaccia f
WHERE f.id_focaccia NOT IN (
    SELECT fi.id_focaccia
    FROM focaccia_ingredient fi
    JOIN ingredient i ON i.id_ingredient = fi.id_ingredient
    WHERE i.nom = 'Champignon'
)
ORDER BY f.nom ASC;