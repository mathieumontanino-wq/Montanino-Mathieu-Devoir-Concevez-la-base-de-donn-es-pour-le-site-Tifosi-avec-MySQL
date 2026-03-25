-- ============================================================
--  TIFOSI - Script 2 : Peuplement de la base de données
--  Source  : marque.csv | boisson.csv | focaccia.csv | ingredient.csv
-- ============================================================

USE tifosi;

-- ============================================================
--  MARQUES (4 enregistrements)
-- ============================================================
INSERT INTO marque (id_marque, nom) VALUES
    (1, 'Coca-cola'),
    (2, 'Cristalline'),
    (3, 'Monster'),
    (4, 'Pepsico');

-- ============================================================
--  INGRÉDIENTS (25 enregistrements)
-- ============================================================
INSERT INTO ingredient (id_ingredient, nom) VALUES
    (1,  'Ail'),
    (2,  'Ananas'),
    (3,  'Artichaut'),
    (4,  'Bacon'),
    (5,  'Base Tomate'),
    (6,  'Base crème'),
    (7,  'Champignon'),
    (8,  'Chèvre'),
    (9,  'Cresson'),
    (10, 'Emmental'),
    (11, 'Gorgonzola'),
    (12, 'Jambon cuit'),
    (13, 'Jambon fumé'),
    (14, 'Oeuf'),
    (15, 'Oignon'),
    (16, 'Olive noire'),
    (17, 'Olive verte'),
    (18, 'Parmesan'),
    (19, 'Piment'),
    (20, 'Poivre'),
    (21, 'Pomme de terre'),
    (22, 'Raclette'),
    (23, 'Salami'),
    (24, 'Tomate cerise'),
    (25, 'Mozarella');

-- ============================================================
--  BOISSONS (12 enregistrements)
-- ============================================================
INSERT INTO boisson (id_boisson, nom, id_marque) VALUES
    (1,  'Coca-cola zéro',           1),
    (2,  'Coca-cola original',        1),
    (3,  'Fanta citron',              1),
    (4,  'Fanta orange',              1),
    (5,  'Capri-sun',                 1),
    (6,  'Pepsi',                     4),
    (7,  'Pepsi Max Zéro',            4),
    (8,  'Lipton zéro citron',        4),
    (9,  'Lipton Peach',              4),
    (10, 'Monster energy ultra gold', 3),
    (11, 'Monster energy ultra blue', 3),
    (12, 'Eau de source',             2);

-- ============================================================
--  FOCACCIAS (8 enregistrements)
-- ============================================================
INSERT INTO focaccia (id_focaccia, nom, prix) VALUES
    (1, 'Mozaccia',        9.80),
    (2, 'Gorgonzollaccia', 10.80),
    (3, 'Raclaccia',        8.90),
    (4, 'Emmentalaccia',    9.80),
    (5, 'Tradizione',       8.90),
    (6, 'Hawaienne',       11.20),
    (7, 'Américaine',      10.80),
    (8, 'Paysanne',        12.80);

-- ============================================================
--  FOCACCIA_INGREDIENT
--  Quantités par défaut (g) issues du fichier focaccia.csv :
--    Ail:2 | Ananas:40 | Artichaut:20 | Bacon:80 | Base Tomate:200
--    Base crème:200 | Champignon:40 | Chèvre:50 | Cresson:20
--    Emmental:50 | Gorgonzola:50 | Jambon cuit:80 | Jambon fumé:80
--    Oeuf:50 | Oignon:20 | Olive noire:20 | Olive verte:20
--    Parmesan:50 | Piment:2 | Poivre:1 | Pomme de terre:80
--    Raclette:50 | Mozarella:50
--  Les quantités spécifiques sont notées entre parenthèses dans le CSV.
-- ============================================================

-- --- 1. Mozaccia ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (1,  5,  200),   -- Base Tomate
    (1,  25,  50),   -- Mozarella
    (1,  9,   20),   -- Cresson
    (1,  13,  80),   -- Jambon fumé
    (1,  1,    2),   -- Ail
    (1,  3,   20),   -- Artichaut
    (1,  7,   40),   -- Champignon
    (1,  18,  50),   -- Parmesan
    (1,  20,   1),   -- Poivre
    (1,  16,  20);   -- Olive noire

-- --- 2. Gorgonzollaccia ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (2,  5,  200),   -- Base Tomate
    (2,  11,  50),   -- Gorgonzola
    (2,  9,   20),   -- Cresson
    (2,  1,    2),   -- Ail
    (2,  7,   40),   -- Champignon
    (2,  18,  50),   -- Parmesan
    (2,  20,   1),   -- Poivre
    (2,  16,  20);   -- Olive noire

-- --- 3. Raclaccia ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (3,  5,  200),   -- Base Tomate
    (3,  22,  50),   -- Raclette
    (3,  9,   20),   -- Cresson
    (3,  1,    2),   -- Ail
    (3,  7,   40),   -- Champignon
    (3,  18,  50),   -- Parmesan
    (3,  20,   1);   -- Poivre

-- --- 4. Emmentalaccia ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (4,  6,  200),   -- Base crème
    (4,  10,  50),   -- Emmental
    (4,  9,   20),   -- Cresson
    (4,  7,   40),   -- Champignon
    (4,  18,  50),   -- Parmesan
    (4,  20,   1),   -- Poivre
    (4,  15,  20);   -- Oignon

-- --- 5. Tradizione ---
-- Champignon: 80g (spécifié), Olive noire: 10g (spécifié), Olive verte: 10g (spécifié)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (5,  5,  200),   -- Base Tomate
    (5,  25,  50),   -- Mozarella
    (5,  9,   20),   -- Cresson
    (5,  12,  80),   -- Jambon cuit
    (5,  7,   80),   -- Champignon (80g spécifié)
    (5,  18,  50),   -- Parmesan
    (5,  20,   1),   -- Poivre
    (5,  16,  10),   -- Olive noire (10g spécifié)
    (5,  17,  10);   -- Olive verte (10g spécifié)

-- --- 6. Hawaienne ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (6,  5,  200),   -- Base Tomate
    (6,  25,  50),   -- Mozarella
    (6,  9,   20),   -- Cresson
    (6,  4,   80),   -- Bacon
    (6,  2,   40),   -- Ananas
    (6,  19,   2),   -- Piment
    (6,  18,  50),   -- Parmesan
    (6,  20,   1),   -- Poivre
    (6,  16,  20);   -- Olive noire

-- --- 7. Américaine ---
-- Pomme de terre: 40g (spécifié)
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (7,  5,  200),   -- Base Tomate
    (7,  25,  50),   -- Mozarella
    (7,  9,   20),   -- Cresson
    (7,  4,   80),   -- Bacon
    (7,  21,  40),   -- Pomme de terre (40g spécifié)
    (7,  18,  50),   -- Parmesan
    (7,  20,   1),   -- Poivre
    (7,  16,  20);   -- Olive noire

-- --- 8. Paysanne ---
INSERT INTO focaccia_ingredient (id_focaccia, id_ingredient, quantite) VALUES
    (8,  6,  200),   -- Base crème
    (8,  8,   50),   -- Chèvre
    (8,  9,   20),   -- Cresson
    (8,  21,  80),   -- Pomme de terre
    (8,  13,  80),   -- Jambon fumé
    (8,  1,    2),   -- Ail
    (8,  3,   20),   -- Artichaut
    (8,  7,   40),   -- Champignon
    (8,  18,  50),   -- Parmesan
    (8,  20,   1),   -- Poivre
    (8,  16,  20),   -- Olive noire
    (8,  14,  50);   -- Oeuf

-- ============================================================
--  CLIENTS (données de test)
-- ============================================================
INSERT INTO client (id_client, nom, email, code_postal) VALUES
    (1, 'Alice Martin',   'alice.martin@email.fr',   '75001'),
    (2, 'Bruno Dupont',   'bruno.dupont@email.fr',   '69002'),
    (3, 'Clara Leroy',    'clara.leroy@email.fr',    '13001'),
    (4, 'David Bernard',  'david.bernard@email.fr',  '33000'),
    (5, 'Emma Moreau',    'emma.moreau@email.fr',    '59000');

-- ============================================================
--  MENUS (données de test)
-- ============================================================
INSERT INTO menu (id_menu, nom, prix) VALUES
    (1, 'Menu Classique',   13.90),
    (2, 'Menu Gourmand',    16.50),
    (3, 'Menu Découverte',  15.00);

-- Focaccias associées aux menus
INSERT INTO menu_focaccia (id_menu, id_focaccia) VALUES
    (1, 3),   -- Menu Classique   → Raclaccia
    (2, 1),   -- Menu Gourmand    → Mozaccia
    (2, 8),   -- Menu Gourmand    → Paysanne
    (3, 6);   -- Menu Découverte  → Hawaienne

-- Boissons associées aux menus
INSERT INTO menu_boisson (id_menu, id_boisson) VALUES
    (1, 12),  -- Menu Classique   → Eau de source
    (2,  1),  -- Menu Gourmand    → Coca-cola zéro
    (3,  6);  -- Menu Découverte  → Pepsi

-- ============================================================
--  ACHATS (données de test)
-- ============================================================
INSERT INTO achat (id_client, id_menu, date_achat) VALUES
    (1, 1, '2024-11-01'),
    (2, 2, '2024-11-02'),
    (3, 3, '2024-11-03'),
    (1, 3, '2024-11-05'),
    (4, 1, '2024-11-06'),
    (5, 2, '2024-11-07');

-- ============================================================
--  FIN DU SCRIPT 2
-- ============================================================
