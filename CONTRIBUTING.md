Règles de contribution — Projet SGRDS

1. Branches

- "main" : version stable et protégée. Aucune modification directe n'est autorisée.
- "feature/nom-fonctionnalite" : une branche par fonctionnalité ou tâche.
- "fix/nom-bug" : une branche par correction de bug.

2. Commits

Format obligatoire : "type(module): description courte"

Types :

- "feat" : nouvelle fonctionnalité.
- "fix" : correction de bug.
- "docs" : documentation.
- "test" : tests.
- "refactor" : réorganisation.

Exemples :

- "feat(database): ajout de la table soutenances"
- "fix(pv): correction de la mise en page du PV"
- "docs(readme): mise à jour des rôles"

3. Pull Requests

- Toute modification doit passer par une Pull Request (PR).
- Chaque PR doit être relue par au moins un autre membre (revue croisée).
- La PR doit décrire ce qui a été fait et pourquoi.
- Aucune fusion sans validation.

4. Revue croisée

- Chaque membre relit le code des autres.
- Les commentaires doivent être constructifs et respectueux.
- Les suggestions sont discutées avant modification.

5. Règle des 48h

- Tout blocage non résolu en 48h est signalé au chef de projet et au Dr Dalié.
- Le blocage, les démarches entreprises et la solution retenue sont documentés.

6. Réunions

- Réunion hebdomadaire : vendredi à 22h30 (en ligne).
- Le compte rendu est rédigé à tour de rôle et déposé dans "docs/reunions/".
- Toute absence doit être signalée à l'avance au chef de projet.

7. Qualité du code

- Aucune fonction ne doit être livrée sans documentation ("roxygen2").
- Aucun code ne doit être livré sans test ("testthat").
- Le code doit être lisible, commenté et correctement formaté.

8. Communication

- Groupe WhatsApp : échanges rapides.
- GitHub Issues : suivi des tâches et signalement des bugs.
- Les décisions importantes doivent être communiquées sur les canaux officiels du projet.
