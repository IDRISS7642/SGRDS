#' Connecter a la base de donnees SQLite SGRDS
#'
#' @param db_path Chemin vers le fichier de base SQLite (par defaut "data/sgrds.sqlite").
#' @return Un objet de connexion DBI actif avec les cles etrangeres activees.
#' @export
connecter_bdd <- function(db_path = "data/sgrds.sqlite") {
  if (!requireNamespace("DBI", quietly = TRUE) || !requireNamespace("RSQLite", quietly = TRUE)) {
    stop("Les packages 'DBI' et 'RSQLite' doivent etre installes.")
  }

  dir.create(dirname(db_path), showWarnings = FALSE, recursive = TRUE)
  con <- DBI::dbConnect(RSQLite::SQLite(), dbname = db_path)
  DBI::dbExecute(con, "PRAGMA foreign_keys = ON;")
  return(con)
}

#' Deconnecter proprement de la base de donnees
#'
#' @param con Objet de connexion DBI retourne par connecter_bdd().
#' @return Invisible TRUE si la deconnexion s'est bien deroulee.
#' @export
deconnecter_bdd <- function(con) {
  if (missing(con) || is.null(con)) {
    stop("Veuillez fournir une connexion valide 'con'.")
  }
  if (!DBI::dbIsValid(con)) {
    warning("La connexion est deja fermee ou invalide.")
    return(invisible(FALSE))
  }
  DBI::dbDisconnect(con)
  return(invisible(TRUE))
}

#' Executer une requete SQL (DDL, INSERT, UPDATE, DELETE)
#'
#' @param con Objet de connexion DBI actif.
#' @param query Chaine de caracteres contenant la requete SQL a executer.
#' @return Le nombre de lignes affectees (retourne par DBI::dbExecute).
#' @export
executer_requete <- function(con, query) {
  if (missing(con) || is.null(con) || !DBI::dbIsValid(con)) {
    stop("Connexion invalide ou fermee. Appelez connecter_bdd() d'abord.")
  }
  if (!is.character(query) || length(query) != 1 || nchar(trimws(query)) == 0) {
    stop("La requete 'query' doit etre une chaine de caracteres non vide.")
  }
  DBI::dbExecute(con, query)
}

#' Lire l'integralite d'une table sous forme de data.frame
#'
#' @param con Objet de connexion DBI actif.
#' @param nom_table Nom de la table SQLite a lire.
#' @return Un data.frame contenant les enregistrements de la table.
#' @export
lire_table <- function(con, nom_table) {
  if (missing(con) || is.null(con) || !DBI::dbIsValid(con)) {
    stop("Connexion invalide ou fermee. Appelez connecter_bdd() d'abord.")
  }
  if (!is.character(nom_table) || length(nom_table) != 1 || nchar(trimws(nom_table)) == 0) {
    stop("Le parametre 'nom_table' doit etre une chaine de caracteres non vide.")
  }
  tables_existantes <- DBI::dbListTables(con)
  if (!nom_table %in% tables_existantes) {
    stop("La table '", nom_table, "' n'existe pas dans la base.")
  }
  requete <- paste0("SELECT * FROM ", DBI::dbQuoteIdentifier(con, nom_table), ";")
  DBI::dbGetQuery(con, requete)

  initialiser_base_sgrds <- function(db_path = "data/sgrds.sqlite", schema_path = "data/schema.sql") {
    con <- connecter_bdd(db_path = db_path)
    sql_texte <- paste(readLines(schema_path, warn = FALSE), collapse = "\n")
    requetes <- unlist(strsplit(sql_texte, ";"))
    for (req in requetes) {
      req_propre <- trimws(req)
      if (nchar(req_propre) > 0) {
        executer_requete(con, paste0(req_propre, ";"))
      }
    }
    message("Base de donnees SGRDS initialisee avec succes.")
    return(con)
  }
}
