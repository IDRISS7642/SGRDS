# Dictionnaire des Données — Projet SGRDS

Ce document décrit l'architecture relationnelle de la base de données SQLite (`data/sgrds.sqlite`) du Système de Gestion et de Reporting des Soutenances (SGRDS), définie à partir de `data/schema.sql`.

---

## 1. Table `utilisateurs`
Gestion des comptes et des rôles des membres du Conseil Scientifique.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de l'utilisateur. |
| `nom` | `TEXT` | `NOT NULL` | Nom de famille de l'utilisateur. |
| `prenom` | `TEXT` | `NOT NULL` | Prénom de l'utilisateur. |
| `email` | `TEXT` | `UNIQUE` | Adresse e-mail institutionnelle ou de contact (unique). |
| `role` | `TEXT` | `CHECK(role IN ('admin', 'membre'))`, `NOT NULL` | Rôle dans le système (`admin` ou `membre`). |
| `mot_de_passe_hash` | `TEXT` | `NOT NULL` | Empreinte (hash) sécurisée du mot de passe. |
| `date_creation` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure de création du compte. |

---

## 2. Table `impetrants`
Informations relatives aux candidats (étudiants de Master et doctorants).

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de l'impétrant. |
| `matricule` | `TEXT` | `UNIQUE`, `NOT NULL` | Numéro matricule unique du candidat (chaîne de caractères). |
| `nom` | `TEXT` | `NOT NULL` | Nom de famille du candidat. |
| `prenom` | `TEXT` | `NOT NULL` | Prénom du candidat. |
| `date_naissance` | `DATE` | — | Date de naissance du candidat. |
| `contact` | `TEXT` | — | Numéro de téléphone ou coordonnée de contact. |
| `genre` | `TEXT` | `CHECK(genre IN ('M', 'F'))` | Genre du candidat (`M` ou `F`). |
| `filiere` | `TEXT` | `NOT NULL` | Filière ou spécialité de formation. |
| `niveau` | `TEXT` | `CHECK(niveau IN ('Master', 'Doctorat'))`, `NOT NULL` | Cycle d'études (`Master` ou `Doctorat`). |
| `annee_inscription` | `INTEGER` | `NOT NULL` | Année académique d'inscription. |
| `date_creation` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure d'enregistrement de la fiche. |

---

## 3. Table `notes`
Résultats académiques semestriels des impétrants.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de l'enregistrement de note. |
| `impetrant_id` | `INTEGER` | `NOT NULL`, `REFERENCES impetrants(id)` | Référence vers l'impétrant concerné. |
| `semestre` | `TEXT` | `CHECK(semestre IN ('M1S1','M1S2','M2S1','M2S2'))`, `NOT NULL` | Semestre concerné (`M1S1`, `M1S2`, `M2S1` ou `M2S2`). |
| `ue` | `TEXT` | `NOT NULL` | Intitulé ou code de l'Unité d'Enseignement (UE). |
| `note` | `REAL` | `CHECK(note >= 0 AND note <= 20)` | Note obtenue sur 20. |
| `credits` | `INTEGER` | — | Nombre de crédits associés à l'UE. |
| `coefficient` | `REAL` | — | Coefficient de pondération. |
| `date_saisie` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure de saisie de la note. |

---

## 4. Table `soutenances`
Suivi des soutenances, délibérations et résultats finaux.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de la soutenance. |
| `impetrant_id` | `INTEGER` | `NOT NULL`, `REFERENCES impetrants(id)` | Référence vers l'impétrant qui soutient. |
| `date_soutenance` | `DATE` | — | Date prévue ou effective de la soutenance. |
| `numero_ordre` | `TEXT` | `UNIQUE` | Numéro d'ordre unique de la soutenance. |
| `note_finale` | `REAL` | `CHECK(note_finale >= 0 AND note_finale <= 20)` | Note finale attribuée sur 20. |
| `mention` | `TEXT` | — | Mention obtenue (ex. : Passable, Bien, Très Bien). |
| `deliberation` | `TEXT` | — | Synthèse ou procès-verbal de délibération. |
| `decision_finale` | `TEXT` | — | Décision finale du jury / du Conseil. |
| `date_enregistrement` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure d'enregistrement de la soutenance. |

---

## 5. Table `jury`
Composition des jurys associés à chaque soutenance.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique du membre dans le jury. |
| `soutenance_id` | `INTEGER` | `NOT NULL`, `REFERENCES soutenances(id)` | Référence vers la soutenance concernée. |
| `nom_membre` | `TEXT` | `NOT NULL` | Nom complet du membre du jury. |
| `qualite` | `TEXT` | — | Grade ou qualité académique / professionnelle. |
| `affiliation` | `TEXT` | — | Université, laboratoire ou institution d'appartenance. |
| `role_jury` | `TEXT` | `CHECK(role_jury IN ('président','rapporteur','examinateur','directeur'))` | Rôle occupé au sein du jury. |

---

## 6. Table `avis_rapporteurs`
Rapports et avis rendus par les rapporteurs sur les dossiers de soutenance.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de l'avis. |
| `soutenance_id` | `INTEGER` | `NOT NULL`, `REFERENCES soutenances(id)` | Référence vers la soutenance concernée. |
| `rapporteur` | `TEXT` | `NOT NULL` | Nom ou identité du rapporteur. |
| `avis` | `TEXT` | — | Contenu de l'avis ou commentaire du rapporteur. |
| `date_avis` | `DATE` | — | Date de remise de l'avis. |

---

## 7. Table `journal`
Journalisation et traçabilité des opérations réalisées dans le système.

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de l'entrée de journal. |
| `utilisateur_id` | `INTEGER` | `REFERENCES utilisateurs(id)` | Référence vers l'utilisateur à l'origine de l'action (si applicable). |
| `action` | `TEXT` | `NOT NULL` | Nature de l'action effectuée (création, modification, suppression, connexion, etc.). |
| `table_cible` | `TEXT` | — | Nom de la table impactée par l'action. |
| `enregistrement_id` | `INTEGER` | — | Identifiant de l'enregistrement concerné dans la table cible. |
| `details` | `TEXT` | — | Détails complémentaires sur l'opération. |
| `date_action` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure de l'action. |

---

## 8. Table `photos`
Gestion des photos et fichiers visuels associés aux impétrants (stockés dans `data/photos/`).

| Colonne | Type SQLite | Contraintes / Règles | Description |
| :--- | :--- | :--- | :--- |
| `id` | `INTEGER` | `PRIMARY KEY AUTOINCREMENT` | Identifiant unique de la photo. |
| `impetrant_id` | `INTEGER` | `NOT NULL`, `REFERENCES impetrants(id)` | Référence vers l'impétrant associé. |
| `chemin_fichier` | `TEXT` | `NOT NULL` | Chemin relatif vers le fichier image (ex. : `data/photos/...`). |
| `description` | `TEXT` | — | Légende ou description de la photo/document. |
| `date_ajout` | `DATETIME` | `DEFAULT CURRENT_TIMESTAMP` | Date et heure d'ajout de la photo. |

---

## Index d'optimisation
* `idx_notes_impetrant` sur `notes(impetrant_id)`
* `idx_soutenances_impetrant` sur `soutenances(impetrant_id)`
* `idx_journal_utilisateur` sur `journal(utilisateur_id)`
* `idx_photos_impetrant` sur `photos(impetrant_id)`
