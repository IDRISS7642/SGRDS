library(testthat)
library(DBI)
library(RSQLite)
if (!exists("initialiser_base_sgrds")) {
  source("R/fct_database.R")
}


# Fonction utillitaire
setup_db_test <- function(){
  tmp_db <- tempfile(fileext = ".sqlite")
  con <- initialiser_base_sgrds(tmp_db)

  list(con = con, chemin = tmp_db)

}

# Fonction auxiliaire de l'insertion d'un impC)trant

ins_imp_test <- function(con, matricule = "CI0523401081") {

  DBI::dbExecute(con, "
    INSERT INTO impetrants (
      matricule,
      nom,
      prenom,
      date_naissance,
      contact,
      genre,
      filiere,
      niveau,
      annee_inscription
    )
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
  ", params = list(
    matricule,
    "OUATTARA",
    "Mamadou",
    "2002-05-15",
    "0566273941",
    "M",
    "MathC)matiques",
    "Master",
    2026
  ))
}

##TESTS DE LA CONNEXION A LA BASE

test_that("La connexion C  la base de donnC)es fonctionne", {
  env <- setup_db_test()
  con <- env$con

  expect_true(DBI::dbIsValid(con))

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})
#VC)rification des tables
test_that("Toutes les tables sont crC)C)es", {

  env <- setup_db_test()
  con <- env$con

  tables <- DBI::dbListTables(con)

  tables_attendues <- c(
    "utilisateurs",
    "impetrants",
    "notes",
    "soutenances",
    "jury",
    "avis_rapporteurs",
    "journal"
  )

  expect_true(all(tables_attendues %in% tables))

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})
# Type d'utilisateur
test_that("Les rC4les admin et membre sont acceptC)s", {
env <- setup_db_test()
  con <- env$con

  expect_no_error(
    DBI::dbExecute(con, "
      INSERT INTO utilisateurs
      (nom, prenom, email, role)
      VALUES ('ADMIN', 'Test', 'admin@test.com', 'admin')
    ")
  )

  expect_no_error(
    DBI::dbExecute(con, "
      INSERT INTO utilisateurs
      (nom, prenom, email, role)
      VALUES ('MEMBRE', 'Test', 'membre@test.com', 'membre')
    ")
  )

  utilisateurs <- DBI::dbReadTable(con, "utilisateurs")

  expect_equal(nrow(utilisateurs), 2)

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})

## TEST DE L'INSERTION D'UN IMPETRANT
test_that("Un impC)trant peut C*tre enregistrC)", {

  env <- setup_db_test()
  con <- env$con

  ins_imp_test(con)

  resultat <- DBI::dbGetQuery(
    con,
    "SELECT * FROM impetrants WHERE matricule = 'CI0523401081'"
  )

  expect_equal(nrow(resultat), 1)
  expect_equal(resultat$nom, "OUATTARA")
  expect_equal(resultat$prenom, "Mamadou")

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})

## TEST DE LA LECTURE DES TABLES

test_that("Les donnC)es enregistrC)es peuvent C*tre lues", {

  env <- setup_db_test()
  con <- env$con

  ins_imp_test(con)

  donnees <- DBI::dbReadTable(con, "impetrants")

  expect_equal(nrow(donnees), 1)
  expect_true("matricule" %in% names(donnees))
  expect_true("nom" %in% names(donnees))
  expect_true("prenom" %in% names(donnees))

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})

## TEST DES CONTRAINTES D'INTEGRITES
# L'unicitC) du matricule

test_that("Un matricule ne peut pas C*tre utilisC) deux fois", {

  env <- setup_db_test()
  con <- env$con

  ins_imp_test(con, "CI0523401081")

  expect_error(
    ins_imp_test(con, "CI0523401081")
  )

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})

# IntC)gritC) rC)fC)rentielle

test_that("Les clC)s C)trangC(res sont respectC)es", {

  env <- setup_db_test()
  con <- env$con

  resultat <- DBI::dbGetQuery(
    con,
    "PRAGMA foreign_keys;"
  )

  expect_equal(resultat$foreign_keys, 1L)

  expect_error(
    DBI::dbExecute(con, "
      INSERT INTO notes (
        impetrant_id, semestre, ue, note
      )
      VALUES (9999, 'M1S1', 'Analyse', 15)
    ")
  )

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})

# vC)rification des contraintes CHECK
test_that("Les contraintes CHECK sont respectC)es", {

  env <- setup_db_test()
  con <- env$con

  expect_error(
    DBI::dbExecute(con, "
      INSERT INTO utilisateurs (nom, prenom, role)
      VALUES ('TEST', 'USER', 'invitC)')
    ")
  )

  expect_error(
    DBI::dbExecute(con, "
      INSERT INTO impetrants
      (matricule, nom, prenom, filiere, genre)
      VALUES ('M002', 'TEST', 'USER', 'Maths', 'X')
    ")
  )

  ins_imp_test(con)

  id <- DBI::dbGetQuery(
    con,
    "SELECT id FROM impetrants WHERE matricule = 'M003'"
  )$id[1]

  expect_error(
    DBI::dbExecute(con, "
      INSERT INTO notes
      (impetrant_id, semestre, ue, note)
      VALUES (?, 'M1S1', 'Analyse', 25)
    ", params = list(id))
  )

  DBI::dbDisconnect(con)
  unlink(env$chemin)
})
