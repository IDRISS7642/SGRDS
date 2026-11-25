-- SGRDS — Schéma de la base de données
-- Basé sur les différentes consignes reçues jusqu'ici
-- ============================================================

-- 1. Table des utilisateurs (Conseil Scientifique)
CREATE TABLE IF NOT EXISTS utilisateurs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    email TEXT UNIQUE,
    role TEXT CHECK(role IN ('admin', 'membre')) NOT NULL,
    mot_de_passe_hash TEXT NOT NULL,
    date_creation DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 2. Table des impétrants (étudiants et doctorants)
CREATE TABLE IF NOT EXISTS impetrants (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    matricule TEXT UNIQUE NOT NULL,
    nom TEXT NOT NULL,
    prenom TEXT NOT NULL,
    date_naissance DATE,
    contact TEXT,
    genre TEXT CHECK(genre IN ('M', 'F')),
    filiere TEXT NOT NULL,
    niveau TEXT CHECK(niveau IN ('Master', 'Doctorat')) NOT NULL,
    annee_inscription INTEGER NOT NULL,
    date_creation DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 3. Table des notes semestrielles
CREATE TABLE IF NOT EXISTS notes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    impetrant_id INTEGER NOT NULL REFERENCES impetrants(id),
    semestre TEXT CHECK(semestre IN ('M1S1','M1S2','M2S1','M2S2')) NOT NULL,
    ue TEXT NOT NULL,
    note REAL CHECK(note >= 0 AND note <= 20),
    credits INTEGER,
    coefficient REAL,
    date_saisie DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 4. Table des soutenances
CREATE TABLE IF NOT EXISTS soutenances (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    impetrant_id INTEGER NOT NULL REFERENCES impetrants(id),
    date_soutenance DATE,
    numero_ordre TEXT UNIQUE,
    note_finale REAL CHECK(note_finale >= 0 AND note_finale <= 20),
    mention TEXT,
    deliberation TEXT,
    decision_finale TEXT,
    date_enregistrement DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 5. Table du jury
CREATE TABLE IF NOT EXISTS jury (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    soutenance_id INTEGER NOT NULL REFERENCES soutenances(id),
    nom_membre TEXT NOT NULL,
    qualite TEXT,
    affiliation TEXT,
    role_jury TEXT CHECK(role_jury IN ('président','rapporteur','examinateur','directeur'))
);

-- 6. Table des avis rapporteurs
CREATE TABLE IF NOT EXISTS avis_rapporteurs (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    soutenance_id INTEGER NOT NULL REFERENCES soutenances(id),
    rapporteur TEXT NOT NULL,
    avis TEXT,
    date_avis DATE
);

-- 7. Table de journalisation (traçabilité)
CREATE TABLE IF NOT EXISTS journal (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    utilisateur_id INTEGER REFERENCES utilisateurs(id),
    action TEXT NOT NULL,
    table_cible TEXT,
    enregistrement_id INTEGER,
    details TEXT,
    date_action DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- 8. Table des photos
CREATE TABLE IF NOT EXISTS photos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    impetrant_id INTEGER NOT NULL REFERENCES impetrants(id),
    chemin_fichier TEXT NOT NULL,
    description TEXT,
    date_ajout DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Index pour accélérer les requêtes
CREATE INDEX IF NOT EXISTS idx_notes_impetrant ON notes(impetrant_id);
CREATE INDEX IF NOT EXISTS idx_soutenances_impetrant ON soutenances(impetrant_id);
CREATE INDEX IF NOT EXISTS idx_journal_utilisateur ON journal(utilisateur_id);
CREATE INDEX IF NOT EXISTS idx_photos_impetrant ON photos(impetrant_id);
