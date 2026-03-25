-- ============================================================
--  TIFOSI - Script 1 : Création du schéma de la base de données
--  Auteur  : Devoir Appliqué - Formation Développeur Web
--  SGBD    : MySQL 8.x (MySQL Workbench)
-- ============================================================

-- ------------------------------
-- 1. Création de la base
-- ------------------------------
DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE tifosi;

-- ------------------------------
-- 2. Création de l'utilisateur
-- ------------------------------
-- (À exécuter en tant que root)
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'Tifosi@2024!';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';
FLUSH PRIVILEGES;

-- ============================================================
--  TABLES
-- ============================================================

-- ------------------------------
-- Table : marque
-- ------------------------------
CREATE TABLE marque (
    id_marque   INT          NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(50)  NOT NULL,
    CONSTRAINT pk_marque  PRIMARY KEY (id_marque),
    CONSTRAINT uq_marque_nom UNIQUE (nom)
) ENGINE=InnoDB;

-- ------------------------------
-- Table : boisson
-- ------------------------------
CREATE TABLE boisson (
    id_boisson  INT          NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(100) NOT NULL,
    id_marque   INT          NOT NULL,
    CONSTRAINT pk_boisson        PRIMARY KEY (id_boisson),
    CONSTRAINT uq_boisson_nom    UNIQUE (nom),
    CONSTRAINT fk_boisson_marque FOREIGN KEY (id_marque)
        REFERENCES marque (id_marque)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------
-- Table : ingredient
-- ------------------------------
CREATE TABLE ingredient (
    id_ingredient INT         NOT NULL AUTO_INCREMENT,
    nom           VARCHAR(50) NOT NULL,
    CONSTRAINT pk_ingredient     PRIMARY KEY (id_ingredient),
    CONSTRAINT uq_ingredient_nom UNIQUE (nom)
) ENGINE=InnoDB;

-- ------------------------------
-- Table : focaccia
-- ------------------------------
CREATE TABLE focaccia (
    id_focaccia INT            NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(100)   NOT NULL,
    prix        DECIMAL(5, 2)  NOT NULL CHECK (prix > 0),
    CONSTRAINT pk_focaccia     PRIMARY KEY (id_focaccia),
    CONSTRAINT uq_focaccia_nom UNIQUE (nom)
) ENGINE=InnoDB;

-- ------------------------------
-- Table de liaison : focaccia_ingredient
-- (relation « comprend » du MCD)
-- ------------------------------
CREATE TABLE focaccia_ingredient (
    id_focaccia   INT NOT NULL,
    id_ingredient INT NOT NULL,
    quantite      INT NOT NULL CHECK (quantite > 0),   -- en grammes
    CONSTRAINT pk_focaccia_ingredient
        PRIMARY KEY (id_focaccia, id_ingredient),
    CONSTRAINT fk_fi_focaccia
        FOREIGN KEY (id_focaccia)   REFERENCES focaccia   (id_focaccia)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_fi_ingredient
        FOREIGN KEY (id_ingredient) REFERENCES ingredient (id_ingredient)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------
-- Table : client
-- ------------------------------
CREATE TABLE client (
    id_client   INT          NOT NULL AUTO_INCREMENT,
    nom         VARCHAR(100) NOT NULL,
    email       VARCHAR(150) NOT NULL,
    code_postal VARCHAR(10)  NOT NULL,
    CONSTRAINT pk_client       PRIMARY KEY (id_client),
    CONSTRAINT uq_client_email UNIQUE (email)
) ENGINE=InnoDB;

-- ------------------------------
-- Table : menu
-- ------------------------------
CREATE TABLE menu (
    id_menu INT           NOT NULL AUTO_INCREMENT,
    nom     VARCHAR(100)  NOT NULL,
    prix    DECIMAL(5, 2) NOT NULL CHECK (prix > 0),
    CONSTRAINT pk_menu PRIMARY KEY (id_menu)
) ENGINE=InnoDB;

-- ------------------------------
-- Table de liaison : menu_focaccia
-- (relation « est constitué » du MCD — 0,5 focaccias par menu)
-- ------------------------------
CREATE TABLE menu_focaccia (
    id_menu     INT NOT NULL,
    id_focaccia INT NOT NULL,
    CONSTRAINT pk_menu_focaccia PRIMARY KEY (id_menu, id_focaccia),
    CONSTRAINT fk_mf_menu
        FOREIGN KEY (id_menu)     REFERENCES menu     (id_menu)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_mf_focaccia
        FOREIGN KEY (id_focaccia) REFERENCES focaccia (id_focaccia)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------
-- Table de liaison : menu_boisson
-- (relation « contient » du MCD)
-- ------------------------------
CREATE TABLE menu_boisson (
    id_menu    INT NOT NULL,
    id_boisson INT NOT NULL,
    CONSTRAINT pk_menu_boisson PRIMARY KEY (id_menu, id_boisson),
    CONSTRAINT fk_mb_menu
        FOREIGN KEY (id_menu)    REFERENCES menu    (id_menu)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_mb_boisson
        FOREIGN KEY (id_boisson) REFERENCES boisson (id_boisson)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ------------------------------
-- Table de liaison : achat
-- (relation « achète » du MCD — client achète menu)
-- ------------------------------
CREATE TABLE achat (
    id_client  INT  NOT NULL,
    id_menu    INT  NOT NULL,
    date_achat DATE NOT NULL,
    CONSTRAINT pk_achat PRIMARY KEY (id_client, id_menu, date_achat),
    CONSTRAINT fk_achat_client
        FOREIGN KEY (id_client) REFERENCES client (id_client)
        ON UPDATE CASCADE ON DELETE CASCADE,
    CONSTRAINT fk_achat_menu
        FOREIGN KEY (id_menu)   REFERENCES menu   (id_menu)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- ============================================================
--  FIN DU SCRIPT 1
-- ============================================================
