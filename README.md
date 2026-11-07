SGRDS – Système de Gestion des Résultats et Données de Soutenance

"Statut" (https://img.shields.io/badge/Statut-En%20développement-blue)
"Langage" (https://img.shields.io/badge/Langage-R-blue)
"Base de données" (https://img.shields.io/badge/Base-SQLite-green)
"Interface" (https://img.shields.io/badge/Interface-Shiny-orange)

1. Présentation du projet

Le SGRDS (Système de Gestion des Résultats et Données de Soutenance) est une application informatique destinée à faciliter la gestion, le traitement, l'archivage et la consultation des données académiques et des informations relatives aux soutenances.

Ce projet est réalisé dans le cadre des activités universitaires de l'Université Peleforo GON COULIBALY, UPR Mathématiques, Département MPC.

2. Objectif général

Concevoir et développer une application permettant de centraliser et de gérer efficacement les résultats académiques et les données de soutenance.

Objectifs spécifiques

- Enregistrer et gérer les informations des étudiants et doctorants.
- Enregistrer et consulter les notes et résultats.
- Gérer les informations relatives aux jurys et aux soutenances.
- Générer automatiquement les procès-verbaux et les fiches individuelles en PDF.
- Produire des statistiques et des tableaux de bord.
- Exporter les données aux formats Excel et CSV.
- Sécuriser l'accès aux informations.

3. Technologies utilisées

Le projet respecte la contrainte d'utilisation exclusive du langage R.

Technologie| Utilisation
R| Langage de programmation
Shiny| Développement de l'application
SQLite| Gestion de la base de données
DBI / RSQLite| Connexion à la base
dplyr / tidyr| Traitement des données
readxl / writexl| Importation et exportation Excel
ggplot2 / plotly| Statistiques et graphiques
rmarkdown / knitr| Génération de documents
tinytex| Production de PDF
DT / reactable| Tableaux interactifs
shinymanager| Authentification
testthat| Tests logiciels
roxygen2 / pkgdown| Documentation du package

4. Organisation de l'équipe

L'équipe de développement est composée de six membres.

Code| Nom et prénom| Responsabilité
E1| Ouattara Idrissa| Chef de projet
E2| Glan Zranseu Kouakou Néhémie| Base de données
E3| Bamba Mohamed Cheick| Shiny Backend
E4| Keita Sadio| Shiny Frontend
E5| Amidou Silué| Générateur de documents
E6| Ouattara Mamadou| Statistiques et tests

Règle de collaboration

Chaque membre est responsable de son module. Tous les membres participent obligatoirement à la revue croisée du code avant son intégration définitive.

5. Les neuf étapes du projet

1. M1 : Analyse des besoins et conception de la base de données.
2. M2 : Importation et nettoyage des données.
3. M3 : Calculs et traitement des résultats.
4. M4 : Développement de l'interface Shiny.
5. M5 : Génération des documents PDF.
6. M6 : Statistiques et tableaux de bord.
7. M7 : Authentification et sécurité.
8. M8 : Tests, documentation et déploiement.
9. M9 : Présentation interne du projet.

6. Organisation du dépôt GitHub

SGRDS/
│
├── R/
│   └── Fonctions du projet
│
├── inst/
│   └── Ressources de l'application
│
├── data/
│   └── Données fictives
│
├── tests/
│   └── Tests automatisés
│
├── docs/
│   └── reunions/
│       └── modele_reunion.Rmd
│
├── README.md
├── CONTRIBUTING.md
├── DESCRIPTION
└── NAMESPACE

7. Collaboration et gestion du code

Le développement est organisé à travers GitHub.

Les règles de collaboration sont les suivantes :

- Utilisation de branches pour les développements.
- Création de Pull Requests.
- Revue croisée obligatoire du code.
- Utilisation de messages de commit clairs.
- Signalement immédiat de tout blocage non résolu dans un délai de 48 heures.

8. Livrables attendus

- Application SGRDS fonctionnelle.
- Code source documenté.
- Base de données SQLite avec données fictives.
- Manuel utilisateur au format PDF.
- Rapport technique au format PDF.
- Documentation technique.
- Formation et présentation du logiciel.

9. Encadrement du projet

Encadreur : Dr Dalié

Référent pédagogique : Dr SORO Brahima

Chef de projet : Ouattara Idrissa (E1)

10. Calendrier du projet

Date de démarrage : Novembre 2026.

Date prévisionnelle de livraison : Fin février 2027.

---

SGRDS – Université Peleforo GON COULIBALY

Une gestion efficace, centralisée et sécurisée des résultats et des données de soutenance.
