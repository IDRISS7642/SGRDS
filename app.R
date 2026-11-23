
# SGRDS - SYSTEME DE GESTION DES RESULTATS ET DES SOUTENANCES
# Universite Peleforo GON COULIBALY (UPGC)

library(shiny)
library(bslib)
library(DT)
library(shinydashboard)
# ---------------------------
# THEME ET STYLE GENERAL
# ---------------------------

theme_sgrds <- bs_theme(
  version = 5,
  bootswatch = "flatly",
  primary = "#174A72",
  secondary = "#6C8498",
  success = "#198754",
  info = "#0DCAF0",
  base_font = font_google("Roboto"),
  heading_font = font_google("Roboto")
)

style_sgrds <- "
  body {
    background-color: #F3F6F9;
    color: #263746;
    font-family: 'Roboto', sans-serif;
  }

  .entete {
    background: linear-gradient(115deg, #123B5D, #1E668A);
    color: white;
    padding: 22px 28px;
    border-radius: 12px;
    margin-bottom: 22px;
    display: flex;
    align-items: center;
    gap: 22px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.10);
  }

  .entete img {
    width: 105px;
    max-height: 105px;
    object-fit: contain;
    background: white;
    padding: 7px;
    border-radius: 10px;
  }

  .entete-texte {
    flex: 1;
    text-align: center;
  }

  .entete h2 {
    font-size: 22px;
    font-weight: 800;
    margin: 0 0 5px 0;
  }

  .entete h4 {
    font-size: 16px;
    margin: 4px 0;
  }

  .entete h3 {
    font-size: 17px;
    margin: 9px 0 0 0;
    font-weight: 700;
  }

  .connexion {
    max-width: 470px;
    margin: 35px auto;
    padding: 30px;
    background: white;
    border-radius: 14px;
    box-shadow: 0 5px 22px rgba(0,0,0,0.09);
  }

  .connexion h3 {
    color: #174A72;
    text-align: center;
    font-weight: 800;
    margin-bottom: 8px;
  }

  .connexion .btn {
    width: 100%;
    margin-top: 10px;
  }

  .sidebar {
    background: white;
    padding: 16px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
  }
/* NOUVEAU CODE POUR LE MENU */
.shiny-input-radiogroup .radio input[type='radio'] {
  display: none !important; /* Fait disparaître les cercles */
}

.shiny-input-radiogroup .radio label {
  display: flex;
  align-items: center;
  padding: 12px 10px;
  margin-bottom: 10px; /* Espace entre les icônes */
  font-size: 14px; /* Écriture plus petite */
  border-radius: 6px;
  cursor: pointer;
}

.shiny-input-radiogroup .radio label:hover {
  background-color: #f0f4f8; /* Effet au survol */
  color: #174A72;
}

.shiny-input-radiogroup .radio label i {
  margin-right: 12px; /* Espace entre l'icône et le texte */
  width: 20px;
  text-align: center;
}
.shiny-input-radiogroup .radio label:has(input[type='radio']:checked) {
  background-color: #E3F2FD;
  color: #174A72;
  font-weight: bold;
}

  .bloc-principal {
    background: white;
    padding: 22px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
    margin-bottom: 18px;
  }

  .titre-section {
    color: #174A72;
    font-weight: 800;
    border-bottom: 2px solid #DCE7EF;
    padding-bottom: 10px;
    margin-bottom: 18px;
  }

  .carte-indicateur {
    background: white;
    border-left: 5px solid #1E668A;
    padding: 18px;
    border-radius: 10px;
    min-height: 112px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
    margin-bottom: 15px;
  }

  .carte-indicateur .libelle {
    color: #617587;
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
  }

  .carte-indicateur .valeur {
    color: #174A72;
    font-size: 29px;
    font-weight: 800;
    margin-top: 8px;
  }

  /* Cartes des calculs de délibération */
  .carte-calcul {
    background: #FFFFFF;
    border: 1px solid #DCE7EF;
    border-left: 5px solid #1E668A;
    border-radius: 10px;
    padding: 16px 18px;
    min-height: 126px;
    margin-bottom: 15px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.05);
  }

  .carte-calcul .calcul-libelle {
    color: #617587;
    font-size: 12px;
    font-weight: 800;
    text-transform: uppercase;
    line-height: 1.4;
    min-height: 34px;
  }

  .carte-calcul .calcul-valeur {
    color: #174A72;
    font-size: 27px;
    font-weight: 800;
    margin-top: 8px;
  }

  .carte-calcul .calcul-detail {
    color: #718096;
    font-size: 11px;
    margin-top: 4px;
  }

  .carte-calcul-finale {
    background: #EAF6EF;
    border: 2px solid #198754;
    border-left: 7px solid #198754;
  }

  .carte-calcul-finale .calcul-libelle,
  .carte-calcul-finale .calcul-valeur {
    color: #146C43;
  }

  .carte-calcul-finale .calcul-valeur {
    font-size: 32px;
  }

  .etiquette-finale {
    display: inline-block;
    background: #198754;
    color: #FFFFFF;
    border-radius: 20px;
    padding: 4px 10px;
    font-size: 10px;
    font-weight: 800;
    letter-spacing: .4px;
    margin-bottom: 8px;
  }

  .pied {
    color: #718096;
    text-align: center;
    font-size: 12px;
    margin: 22px 0 8px 0;
  }

  .aide {
    color: #66788A;
    font-size: 12px;
    font-style: italic;
  }

  .btn-espace {
    margin: 4px;
  }

  @media (max-width: 700px) {
    .entete {
      display: block;
      text-align: center;
    }
    .entete img {
      margin-bottom: 12px;
    }
    .entete h2 {
      font-size: 18px;
    }
  }
"

# ---------------------------
# DONNEES DE DEMONSTRATION
# ---------------------------
# Ces tableaux sont temporaires. Ils seront remplaces ou alimentes
# par la base de donnees du projet lors de l'integration.

candidats_demo <- data.frame(
  Matricule = character(),
  Nom = character(),
  Prenom = character(),
  Nationalite = character(),
  Date_naissance = character(),
  Lieu_naissance = character(),
  Contact = character(),
  Email = character(),
  Genre = character(),
  Niveau = character(),
  Filiere = character(),
  Master_de = character(),
  Option = character(),
  Theme_memoire = character(),
  Structure_accueil_stage = character(),
  Annee = character(),
  stringsAsFactors = FALSE
)

notes_demo <- data.frame(
  Matricule = character(),
  M1S1 = numeric(),
  M1S2 = numeric(),
  M2S1 = numeric(),
  Note_stage_sur_20 = numeric(),
  Note_soutenance_sur_40 = numeric(),
  TSS_sur_60 = numeric(),
  MSS_sur_20 = numeric(),
  MT_sur_60 = numeric(),
  MD_sur_20 = numeric(),
  stringsAsFactors = FALSE
)

soutenances_demo <- data.frame(
  Matricule = character(),
  Date = character(),
  Lieu = character(),
  Numero_ordre = character(),
  Statut = character(),
  stringsAsFactors = FALSE
)

resultats_demo <- data.frame(
  Matricule = character(),
  Note_finale = numeric(),
  Mention = character(),
  Deliberation = character(),
  Decision_finale = character(),
  stringsAsFactors = FALSE
)

# ---------------------------
# INTERFACE UTILISATEUR
# ---------------------------

ui <- fluidPage(
  theme = theme_sgrds,

  tags$head(
    tags$meta(charset = "UTF-8"),
    tags$style(HTML(style_sgrds))
  ),

  uiOutput("page")
)

# ---------------------------
# SERVEUR
# ---------------------------

server <- function(input, output, session) {
  `%||%` <- function(x, y) if (is.null(x) || length(x) == 0) y else x


  # Etat temporaire de connexion
  authentifie <- reactiveVal(FALSE)

  # Journal d'activites de demonstration
  activites <- reactiveVal(character(0))

  ajouter_activite <- function(message) {
    ancienne_liste <- activites()
    heure <- format(Sys.time(), "%d/%m/%Y %H:%M")
    activites(c(paste0(heure, " - ", message), ancienne_liste))
  }


  # Calculs suivant la fiche officielle de PV de délibération.
  valeurs_notes <- reactive({
    m1s1 <- input$note_m1s1
    m1s2 <- input$note_m1s2
    m2s1 <- input$note_m2s1
    stage <- input$note_stage
    soutenance <- input$note_soutenance

    valeurs_semestres <- c(m1s1, m1s2, m2s1)
    valeurs_soutenance <- c(stage, soutenance)

    mt <- if (length(valeurs_semestres) == 3 && all(is.finite(valeurs_semestres))) {
      sum(valeurs_semestres)
    } else NA_real_

    tss <- if (length(valeurs_soutenance) == 2 && all(is.finite(valeurs_soutenance))) {
      sum(valeurs_soutenance)
    } else NA_real_

    mss <- if (is.finite(tss)) tss / 3 else NA_real_
    md <- if (all(is.finite(c(mt, mss)))) (mt + mss) / 4 else NA_real_

    list(mt = mt, tss = tss, mss = mss, md = md)
  })

  calculs_enregistres <- reactiveVal(NULL)

  calcul_resultat <- reactive({
    if (is.null(calculs_enregistres())) valeurs_notes() else calculs_enregistres()
  })

  format_note <- function(x, bareme) {
    if (length(x) == 0 || !is.finite(x)) "À renseigner" else
      paste0(format(round(x, 2), nsmall = 2), " / ", bareme)
  }

  output$calc_tss <- renderText(format_note(valeurs_notes()$tss, 60))
  output$calc_mss <- renderText(format_note(valeurs_notes()$mss, 20))
  output$calc_mt  <- renderText(format_note(valeurs_notes()$mt, 60))
  output$calc_md  <- renderText(format_note(valeurs_notes()$md, 20))
  output$resultat_md <- renderText(format_note(calcul_resultat()$md, 20))

  # ---------------------------
  # ENTETE DE L'APPLICATION
  # ---------------------------

  entete_application <- function() {
    div(
      class = "entete",
      
      # Logo de l'université à gauche
      img(
        src = "logo_upgc.png",
        alt = "Logo UPGC",
        class = "logo-entete"
      ),
      
      # Texte au centre
      div(
        class = "entete-texte",
        h2("UNIVERSITE PELEFORO GON COULIBALY"),
        h4("UFR SCIENCES BIOLOGIQUES"),
        h3("SYSTEME DE GESTION DES RESULTATS ET DES SOUTENANCES"),
        p("CONSEIL SCIENTIFIQUE")
      ),
      
      # Logo de l'UFR à droite
      img(
        src = "logo_ufr",
        alt = "Logo UFR Sciences Biologiques",
        class = "logo-entete"
      )
    )
  }
  

  # ---------------------------
  # PAGE DE CONNEXION
  # ---------------------------

  page_connexion <- function() {
    tagList(
      entete_application(),

      div(
        class = "connexion",
        h3("Bienvenue"),
        p(
          "Veuillez vous identifier pour accèder a votre espace.",
          style = "text-align:center; color:#66788A;"
        ),

        textInput(
          "identifiant",
          "Identifiant",
          placeholder = "Saisissez votre identifiant"
        ),

        passwordInput(
          "motdepasse",
          "Mot de passe",
          placeholder = "Saisissez votre mot de passe"
        ),

        actionButton(
          "connexion",
          "Se connecter",
          icon = icon("right-to-bracket"),
          class = "btn-primary"
        ),

        p(
          "Accès reservé aux utilisateurs autorisés.",
          class = "pied"
        )
      ),

      p(
        "© 2026 - UPGC | UFR Sciences Biologiques",
        class = "pied"
      )
    )
  }

  # ---------------------------
  # STRUCTURE DE L'APPLICATION
  # ---------------------------

  page_principale <- function() {
    tagList(
      entete_application(),

      sidebarLayout(
        sidebarPanel(
          width = 3,

          div(
            class = "sidebar",

            h4("MENU PRINCIPAL", class = "titre-section"),

            radioButtons(
              "menu",
              label = NULL,

              choiceNames = list(
                tagList(icon("house"), " Accueil"),
                tagList(icon("users"), " Gestion des candidats"),
                tagList(icon("book-open"), " Saisie des notes"),
                tagList(icon("calendar-check"), " Gestion des soutenances"),
                tagList(icon("clipboard-check"), " Résultats et délibérations"),
                tagList(icon("file-pdf"), " Procès-verbaux et fiches"),
                tagList(icon("chart-column"), " Statistiques")
              ),

              choiceValues = c(
                "accueil",
                "candidats",
                "notes",
                "soutenances",
                "resultats",
                "documents",
                "statistiques"
              ),

              selected = "accueil"
            ),

            tags$hr(),

            actionButton(
              "deconnexion",
              "Se déconnecter",
              icon = icon("right-from-bracket"),
              class = "btn-outline-danger",
              width = "100%"
            )
          )
        ),

        mainPanel(
          width = 9,
          uiOutput("contenu")
        )
      ),

      p(
        "© 2026 - UPGC | SGRDS | UFR Sciences Biologiques",
        class = "pied"
      )
    )
  }

  # ---------------------------
  # AFFICHAGE CONNEXION / APPLICATION
  # ---------------------------

  output$page <- renderUI({
    if (!authentifie()) {
      page_connexion()
    } else {
      page_principale()
    }
  })

  # ---------------------------
  # TABLEAU DE BORD
  # ---------------------------

  page_accueil <- function() {
    tagList(
      h3("Tableau de bord", class = "titre-section"),

      fluidRow(
        column(
          4,
          div(
            class = "carte-indicateur",
            div(class = "libelle", "Candidats enregistrés"),
            div(class = "valeur", nrow(candidats_demo))
          )
        ),

        column(
          4,
          div(
            class = "carte-indicateur",
            div(class = "libelle", "Soutenances enregistrées"),
            div(class = "valeur", nrow(soutenances_demo))
          )
        ),

        column(
          4,
          div(
            class = "carte-indicateur",
            div(class = "libelle", "Résultats renseignés"),
            div(class = "valeur", nrow(resultats_demo))
          )
        )
      ),

      div(
        class = "bloc-principal",
        h4("Accès rapide", class = "titre-section"),

        actionButton(
          "aller_candidats",
          "Enregistrer un candidat",
          icon = icon("user-plus"),
          class = "btn-primary btn-espace"
        ),

        actionButton(
          "aller_notes",
          "Saisir des notes",
          icon = icon("book"),
          class = "btn-primary btn-espace"
        ),

        actionButton(
          "aller_soutenances",
          "Programmer une soutenance",
          icon = icon("calendar-plus"),
          class = "btn-primary btn-espace"
        ),

        actionButton(
          "aller_resultats",
          "Renseigner les délibérations",
          icon = icon("clipboard-check"),
          class = "btn-primary btn-espace"
        )
      ),

      div(
        class = "bloc-principal",
        h4("Activités récentes", class = "titre-section"),
        uiOutput("liste_activites")
      ),

      div(
        class = "bloc-principal",
        h4("Informations académiques", class = "titre-section"),
        p("Année universitaire : 2026 - 2027"),
        p("Structure : UFR Sciences Biologiques"),
        p("Institution : Université Peleforo GON COULIBALY"),
        p(class = "aide",
          "Les indicateurs seront alimentés automatiquement après connexion à la base de données.")
      )
    )
  }

  # ---------------------------
  # GESTION DES CANDIDATS
  # ---------------------------

  page_candidats <- function() {
    tagList(
      h3("Gestion des candidats / impétrants", class = "titre-section"),

      div(
        class = "bloc-principal",
        h4("Informations du candidat"),

        fluidRow(
          column(6, textInput("cand_matricule", "Matricule")),
          column(6, textInput("cand_nom", "Nom"))
        ),

        fluidRow(
          column(6, textInput("cand_prenom", "Prénom")),
          column(6, textInput("cand_nationalite", "Nationalité", placeholder = "Ex. : Ivoirienne"))
        ),

        fluidRow(
          column(6, dateInput(
            "cand_naissance",
            "Date de naissance",
            language = "fr",
            format = "dd/mm/yyyy"
          )),
          column(6, textInput("cand_lieu_naissance", "Lieu de naissance", placeholder = "Ville et pays de naissance"))
        ),

        fluidRow(
          column(6, textInput("cand_contact", "Contact téléphonique")),
          column(6, textInput(
            "cand_email",
            "Adresse e-mail",
            placeholder = "exemple@gmail.com"
          ))
        ),

        fluidRow(
          column(6, selectInput(
            "cand_genre",
            "Genre",
            choices = c("Choisir..." = "", "Féminin" = "F", "Masculin" = "M")
          ))
        ),

        fluidRow(
          column(6, selectInput(
            "cand_niveau",
            "Niveau",
            choices = c("Choisir..." = "", "Master" = "Master", "Doctorat" = "Doctorat")
          )),
          column(6, textInput("cand_filiere", "Filière"))
        ),

        fluidRow(
          column(6, numericInput(
            "cand_annee",
            "Année d'inscription",
            value = 2026,
            min = 2000,
            max = 2100,
            step = 1
          )),
          column(6, fileInput(
            "cand_photo",
            "Photo du candidat",
            accept = c("image/png", "image/jpeg")
          ))
        ),

        tags$hr(),
        h4("Informations du mémoire et du stage"),

        fluidRow(
          column(6, textInput(
            "cand_master_de",
            "Master de",
            value = "",
            placeholder = "Ex. : Master 2"
          )),
          column(6, textInput(
            "cand_option",
            "Option / spécialité",
            value = "",
            placeholder = "Préciser l'option ou la spécialité"
          ))
        ),

        fluidRow(
          column(6, textInput(
            "cand_structure_stage",
            "Structure d'accueil du stage",
            value = "",
            placeholder = "Nom de l'entreprise, du laboratoire ou de l'établissement"
          ))
        ),

        textAreaInput(
          "cand_theme_memoire",
          "Thème du mémoire",
          value = "",
          rows = 3,
          placeholder = "Saisir l'intitulé complet du mémoire"
        ),

        actionButton(
          "enregistrer_candidat",
          "Enregistrer le candidat",
          icon = icon("floppy-disk"),
          class = "btn-success"
        ),

        p(
          class = "aide",
          "Interface de saisie : l'enregistrement définitif sera relié au module base de données."
        )
      ),

      div(
        class = "bloc-principal",
        h4("Liste des candidats"),
        DTOutput("table_candidats")
      )
    )
  }

  # ---------------------------
  # SAISIE DES MOYENNES ET DES NOTES DE SOUTENANCE
  # ---------------------------

  page_notes <- function() {
    tagList(
      h3("Saisie des notes", class = "titre-section"),

      div(
        class = "bloc-principal",
        h4("Informations académiques"),

        fluidRow(
          column(6, textInput("note_matricule", "Matricule du candidat")),
          column(6, numericInput(
            "note_m1s1", "Moyenne M1 - Semestre 1 (/20)",
            value = NA, min = 0, max = 20, step = 0.25
          ))
        ),

        fluidRow(
          column(6, numericInput(
            "note_m1s2", "Moyenne M1 - Semestre 2 (/20)",
            value = NA, min = 0, max = 20, step = 0.25
          )),
          column(6, numericInput(
            "note_m2s1", "Moyenne M2 - Semestre 1 (/20)",
            value = NA, min = 0, max = 20, step = 0.25
          ))
        ),

        tags$hr(),
        h4("Notes de stage et de soutenance"),

        fluidRow(
          column(6, numericInput(
            "note_stage", "Note de stage - Maître de stage (/20)",
            value = NA, min = 0, max = 20, step = 0.25
          )),
          column(6, numericInput(
            "note_soutenance", "Note de soutenance - Jury (/40)",
            value = NA, min = 0, max = 40, step = 0.25
          ))
        ),

        tags$hr(),
        h4("Calculs automatiques"),

        fluidRow(
          column(6, div(
            class = "carte-calcul",
            div(class = "calcul-libelle", "Total stage + soutenance (TSS)"),
            div(class = "calcul-valeur", textOutput("calc_tss", inline = TRUE)),
            div(class = "calcul-detail", "Note de stage (/20) + note de soutenance (/40) — résultat sur 60")
          )),
          column(6, div(
            class = "carte-calcul",
            div(class = "calcul-libelle", "Moyenne stage + soutenance (MSS)"),
            div(class = "calcul-valeur", textOutput("calc_mss", inline = TRUE)),
            div(class = "calcul-detail", "TSS divisé par 3 — résultat sur 20")
          ))
        ),
        fluidRow(
          column(6, div(
            class = "carte-calcul",
            div(class = "calcul-libelle", "Moyenne théorique (MT)"),
            div(class = "calcul-valeur", textOutput("calc_mt", inline = TRUE)),
            div(class = "calcul-detail", "M1S1 + M1S2 + M2S1 — résultat sur 60")
          )),
          column(6, div(
            class = "carte-calcul carte-calcul-finale",
            div(class = "etiquette-finale", "MOYENNE FINALE"),
            div(class = "calcul-libelle", "Moyenne délibérative (MD)"),
            div(class = "calcul-valeur", textOutput("calc_md", inline = TRUE)),
            div(class = "calcul-detail", "(MT + MSS) divisé par 4 — résultat final sur 20")
          ))
        ),

        actionButton(
          "enregistrer_note",
          "Enregistrer les moyennes et les notes",
          icon = icon("floppy-disk"),
          class = "btn-success"
        ),

        p(
          class = "aide",
          "Les moyennes semestrielles sont saisies directement. Les totaux et moyennes de délibération sont calculés automatiquement selon la fiche officielle de PV."
        )
      ),

      div(
        class = "bloc-principal",
        h4("Moyennes et notes enregistrées"),
        DTOutput("table_notes")
      )
    )
  }

  # ---------------------------
  # GESTION DES SOUTENANCES
  # ---------------------------

  page_soutenances <- function() {
    tagList(
      h3("Gestion des soutenances", class = "titre-section"),

      div(
        class = "bloc-principal",
        h4("Informations générales"),

        fluidRow(
          column(6, textInput("sout_matricule", "Matricule du candidat")),
          column(6, dateInput(
            "sout_date",
            "Date de soutenance",
            language = "fr",
            format = "dd/mm/yyyy"
          ))
        ),

        textInput(
          "sout_lieu",
          "Lieu de la soutenance",
          placeholder = "Ex. : Salle de conférence de l'UFR Sciences Biologiques"
        ),

        fluidRow(
          column(6, textInput("sout_numero", "Numéro d'ordre")),
          column(6, selectInput(
            "sout_statut",
            "Statut de la soutenance",
            choices = c(
              "Programmée" = "Programmée",
              "Effectuée" = "Effectuée",
              "Validée" = "Validée"
            )
          ))
        )
      ),

      div(
        class = "bloc-principal",
        h4("Composition du jury"),

        h5("Président"),
        fluidRow(
          column(4, textInput("jury_president_nom", "Nom et prénoms")),
          column(4, textInput("jury_president_qualite", "Qualité")),
          column(4, textInput("jury_president_affiliation", "Affiliation"))
        ),

        tags$hr(),

        h5("Superviseur"),
        fluidRow(
          column(4, textInput("jury_superviseur_nom", "Nom et prénoms")),
          column(4, textInput("jury_superviseur_qualite", "Qualité")),
          column(4, textInput("jury_superviseur_affiliation", "Affiliation"))
        ),

        tags$hr(),

        h5("Co-encadrant"),
        fluidRow(
          column(4, textInput("jury_coencadrant_nom", "Nom et prénoms")),
          column(4, textInput("jury_coencadrant_qualite", "Qualité")),
          column(4, textInput("jury_coencadrant_affiliation", "Affiliation"))
        ),

        tags$hr(),

        h5("Examinateur / Instructeur"),
        fluidRow(
          column(4, textInput("jury_examinateur_nom", "Nom et prénoms")),
          column(4, textInput("jury_examinateur_qualite", "Qualité")),
          column(4, textInput("jury_examinateur_affiliation", "Affiliation"))
        ),

        actionButton(
          "enregistrer_soutenance",
          "Enregistrer les informations de soutenance",
          icon = icon("floppy-disk"),
          class = "btn-success"
        ),

        p(
          class = "aide",
          "Les fonctions des membres du jury correspondent aux rubriques de la fiche officielle de PV."
        )
      ),

      div(
        class = "bloc-principal",
        h4("Suivi des soutenances"),
        DTOutput("table_soutenances")
      )
    )
  }

  # ---------------------------
  # RESULTATS ET DELIBERATIONS
  # ---------------------------

  page_resultats <- function() {
    tagList(
      h3("Résultats et délibérations", class = "titre-section"),

      div(
        class = "bloc-principal",
        h4("Décision du jury"),

        textInput("res_matricule", "Matricule du candidat"),

        fluidRow(
          column(6, div(
            strong("Moyenne délibérative calculée (/20) : "),
            textOutput("resultat_md", inline = TRUE)
          )),
          column(6, selectInput(
            "res_mention",
            "Mention",
            choices = c(
              "Non renseignée" = "",
              "Passable" = "Passable",
              "Assez bien" = "Assez bien",
              "Bien" = "Bien",
              "Très bien" = "Très bien",
              "Excellent" = "Excellent"
            )
          ))
        ),

        selectInput(
          "res_deliberation",
          "Délibération",
          choices = c(
            "Choisir..." = "",
            "Admis" = "Admis",
            "Ajourné" = "Ajourné",
            "Admis sous réserve" = "Admis sous réserve",
            "Délibération en attente" = "En attente"
          )
        ),

        selectInput(
          "res_decision",
          "Décision finale",
          choices = c(
            "Choisir..." = "",
            "Autorisé à soutenir" = "Autorisé à soutenir",
            "Diplôme validé" = "Diplôme validé",
            "Reprise / complément demandé" = "Reprise / complément demandé",
            "Décision en attente" = "Décision en attente"
          )
        ),

        textAreaInput(
          "res_observation",
          "Observations du Conseil scientifique",
          rows = 3,
          placeholder = "Saisir une observation éventuelle..."
        ),

        actionButton(
          "enregistrer_resultat",
          "Enregistrer la délibération",
          icon = icon("check-circle"),
          class = "btn-success"
        ),

        p(
          class = "aide",
          "Les valeurs proposées sont des choix d'interface à valider avec le Conseil scientifique avant la mise en production."
        )
      ),

      div(
        class = "bloc-principal",
        h4("Tableau des résultats et décisions"),
        DTOutput("table_resultats")
      )
    )
  }

  # ---------------------------
  # DOCUMENTS ET EXPORTS
  # ---------------------------

  page_documents <- function() {
    tagList(
      h3("Procès-verbaux et fiches individuelles", class = "titre-section"),

      div(
        class = "bloc-principal",
        tabsetPanel(
          type = "tabs",

          tabPanel(
            title = tagList(icon("file-pdf"), " Procès-verbal"),
            br(),
            h4("Génération du procès-verbal"),
            textInput("doc_matricule_pv", "Matricule pour le procès-verbal"),
            actionButton(
              "generer_pv",
              "Générer le procès-verbal (PDF)",
              icon = icon("file-pdf"),
              class = "btn-primary"
            )
          ),

          tabPanel(
            title = tagList(icon("file-lines"), " Fiche individuelle"),
            br(),
            h4("Génération de la fiche individuelle"),
            textInput("doc_matricule_fiche", "Matricule pour la fiche individuelle"),
            actionButton(
              "generer_fiche",
              "Générer la fiche individuelle (PDF)",
              icon = icon("file-lines"),
              class = "btn-primary"
            )
          ),

          tabPanel(
            title = tagList(icon("bullhorn"), " Avis de soutenance"),
            br(),
            h4("Génération de l'avis de soutenance"),
            p(class = "aide", "Saisir le matricule du candidat. Le Master, l'option, le thème, l'auteur, le lieu et la date sont récupérés depuis Gestion des candidats et Gestion des soutenances."),
            textInput(
              "avis_matricule",
              "Matricule du candidat",
              placeholder = "Saisir le matricule de l'étudiant"
            ),
            downloadButton(
              "telecharger_avis",
              "Télécharger l'avis de soutenance (PDF)",
              class = "btn-primary"
            ),
            p(class = "aide", "Le lieu et la date sont repris automatiquement depuis Gestion des soutenances. Aucune autre saisie n'est nécessaire.")
          )
        )
      ),

      div(
        class = "bloc-principal",
        h4("Exports des données"),
        actionButton(
          "export_excel",
          "Exporter vers Excel",
          icon = icon("file-excel"),
          class = "btn-outline-success btn-espace"
        ),
        actionButton(
          "export_csv",
          "Exporter vers CSV",
          icon = icon("file-csv"),
          class = "btn-outline-primary btn-espace"
        ),
        p(class = "aide", "Les exports seront connectés aux modules de données concernés.")
      )
    )
  }

  # ---------------------------
  # STATISTIQUES
  # ---------------------------

  page_statistiques <- function() {
    tagList(
      h3("Tableau statistique", class = "titre-section"),

      fluidRow(
        column(
          6,
          div(
            class = "bloc-principal",
            h4("Résultats par filière"),
            plotOutput("graphique_filiere", height = "250px")
          )
        ),

        column(
          6,
          div(
            class = "bloc-principal",
            h4("Répartition par genre"),
            plotOutput("graphique_genre", height = "250px")
          )
        )
      ),

      fluidRow(
        column(
          6,
          div(
            class = "bloc-principal",
            h4("Taux de réussite"),
            plotOutput("graphique_reussite", height = "250px")
          )
        ),

        column(
          6,
          div(
            class = "bloc-principal",
            h4("Évolution par promotion"),
            plotOutput("graphique_promotion", height = "250px")
          )
        )
      ),

      p(
        class = "aide",
        "Les graphiques seront alimentés par les données réelles et les indicateurs calculés dans le module statistiques."
      )
    )
  }

  # ---------------------------
  # NAVIGATION ENTRE LES PAGES
  # ---------------------------

  output$contenu <- renderUI({
    req(authentifie())
    req(input$menu)

    switch(
      input$menu,
      accueil = page_accueil(),
      candidats = page_candidats(),
      notes = page_notes(),
      soutenances = page_soutenances(),
      resultats = page_resultats(),
      documents = page_documents(),
      statistiques = page_statistiques()
    )
  })

  # ---------------------------
  # TABLEAUX INTERACTIFS DT
  # ---------------------------

  output$table_candidats <- renderDT({
    datatable(
      candidats_demo,
      rownames = FALSE,
      options = list(
        pageLength = 5,
        scrollX = TRUE,
        language = list(url = "//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json")
      )
    )
  })

  output$table_notes <- renderDT({
    datatable(
      notes_demo,
      rownames = FALSE,
      options = list(
        pageLength = 5,
        scrollX = TRUE,
        language = list(url = "//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json")
      )
    )
  })

  output$table_soutenances <- renderDT({
    datatable(
      soutenances_demo,
      rownames = FALSE,
      options = list(
        pageLength = 5,
        scrollX = TRUE,
        language = list(url = "//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json")
      )
    )
  })

  output$table_resultats <- renderDT({
    datatable(
      resultats_demo,
      rownames = FALSE,
      options = list(
        pageLength = 5,
        scrollX = TRUE,
        language = list(url = "//cdn.datatables.net/plug-ins/1.13.6/i18n/fr-FR.json")
      )
    )
  })

  # ---------------------------
  # JOURNAL D'ACTIVITES
  # ---------------------------

  output$liste_activites <- renderUI({
    if (length(activites()) == 0) {
      p("Aucune activité enregistrée pour le moment.")
    } else {
      tags$ul(
        lapply(head(activites(), 8), tags$li)
      )
    }
  })

  # ---------------------------
  # CONNEXION PROVISOIRE
  # ---------------------------

  observeEvent(input$connexion, {
    req(input$identifiant, input$motdepasse)

    # Identifiants de demonstration uniquement.
    # A remplacer par l'authentification securisee du projet.
    if (
      identical(input$identifiant, "conseil") &&
      identical(input$motdepasse, "UPGC2026!")
    ) {
      authentifie(TRUE)
      ajouter_activite("Connexion à l'application.")
      showNotification(
        "Connexion réussie.",
        type = "message"
      )
    } else {
      showNotification(
        "Identifiant ou mot de passe incorrect.",
        type = "error"
      )
    }
  })

  observeEvent(input$deconnexion, {
    ajouter_activite("Déconnexion de l'application.")
    authentifie(FALSE)
  })

  # ---------------------------
  # BOUTONS D'ACCES RAPIDE
  # ---------------------------

  observeEvent(input$aller_candidats, {
    updateRadioButtons(session, "menu", selected = "candidats")
  })

  observeEvent(input$aller_notes, {
    updateRadioButtons(session, "menu", selected = "notes")
  })

  observeEvent(input$aller_soutenances, {
    updateRadioButtons(session, "menu", selected = "soutenances")
  })

  observeEvent(input$aller_resultats, {
    updateRadioButtons(session, "menu", selected = "resultats")
  })

  # ---------------------------
  # ACTIONS DE LA MAQUETTE
  # ---------------------------
  # Les notifications ci-dessous confirment uniquement le clic.
  # Elles ne signifient pas que les donnees sont deja sauvegardees.

  observeEvent(input$enregistrer_candidat, {
    showNotification(
      "Formulaire candidat prêt : connexion à la base de données à réaliser.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$enregistrer_note, {
    calculs_enregistres(valeurs_notes())
    showNotification(
      "Calculs des moyennes prêts. La connexion au module de données reste à réaliser.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$enregistrer_soutenance, {
    showNotification(
      "Formulaire de soutenance prêt : enregistrement à connecter au module de données.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$enregistrer_resultat, {
    showNotification(
      "Formulaire de délibération prêt : enregistrement à connecter au module de données.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$generer_pv, {
    showNotification(
      "Le bouton de génération du procès-verbal est prêt pour l'intégration du module PDF.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$generer_fiche, {
    showNotification(
      "Le bouton de génération de la fiche individuelle est prêt pour l'intégration du module PDF.",
      type = "message",
      duration = 5
    )
  })

  output$telecharger_avis <- downloadHandler(
    filename = function() {
      matricule <- gsub("[^A-Za-z0-9_-]", "_", input$avis_matricule %||% "Candidat")
      paste0("Avis_de_soutenance_", matricule, ".pdf")
    },
    content = function(file) {
      matricule <- trimws(input$avis_matricule %||% "")

      if (!nzchar(matricule)) {
        stop("Veuillez saisir le matricule du candidat.")
      }

      candidat <- candidats_demo[candidats_demo$Matricule == matricule, , drop = FALSE]
      soutenance <- soutenances_demo[soutenances_demo$Matricule == matricule, , drop = FALSE]

      if (nrow(candidat) == 0) {
        stop("Aucun candidat correspondant à ce matricule n'est disponible. Vérifiez son enregistrement dans Gestion des candidats.")
      }
      if (nrow(soutenance) == 0) {
        stop("Aucune soutenance enregistrée pour ce candidat. Enregistrez d'abord sa date dans Gestion des soutenances.")
      }

      master <- if ("Master_de" %in% names(candidat)) candidat$Master_de[1] else ""
      option <- if ("Option" %in% names(candidat)) candidat$Option[1] else ""
      theme <- if ("Theme_memoire" %in% names(candidat)) candidat$Theme_memoire[1] else ""
      auteur <- paste(trimws(candidat$Prenom[1]), trimws(candidat$Nom[1]))
      lieu <- trimws(as.character(soutenance$Lieu[1]))
      date_soutenance <- as.character(soutenance$Date[1])

      champs <- c(master, option, theme, auteur, lieu, date_soutenance)
      if (any(is.na(champs)) || any(!nzchar(trimws(champs)))) {
        stop("Certaines informations du candidat ou de sa soutenance sont manquantes. Vérifiez Gestion des candidats et Gestion des soutenances, notamment le lieu de soutenance.")
      }

      grDevices::pdf(file, width = 8.27, height = 11.69, paper = "a4")
      on.exit(grDevices::dev.off(), add = TRUE)
      par(mar = c(0.5, 0.6, 0.5, 0.6), family = "serif")
      plot.new()
      plot.window(xlim = c(0, 1), ylim = c(0, 1))

      text(0.25, 0.94, "Ministère de l'Enseignement Supérieur et", cex = 0.88, font = 2)
      text(0.25, 0.91, "de la Recherche Scientifique", cex = 0.88, font = 2)
      text(0.75, 0.94, "REPUBLIQUE DE COTE D'IVOIRE", cex = 0.88, font = 2)
      text(0.75, 0.91, "Union-Discipline-Travail", cex = 0.82, font = 2)
      text(0.5, 0.80, "UNIVERSITE PELEFORO GON COULIBALY", cex = 0.85, font = 2)
      text(0.5, 0.77, "UFR SCIENCES BIOLOGIQUES", cex = 0.85, font = 2)
      text(0.5, 0.65, "AVIS DE SOUTENANCE", cex = 1.65, font = 4)

      text(0.12, 0.54, "Le public est cordialement invité à la soutenance de", adj = 0, cex = 0.95, font = 2)
      text(0.12, 0.505, paste("Mémoire de MASTER de", master), adj = 0, cex = 0.95, font = 2)
      text(0.12, 0.465, paste("Option :", option), adj = 0, cex = 0.95, font = 2)

      text(0.12, 0.38, "THEME :", adj = 0, cex = 1.0, font = 2)
      theme_lines <- strwrap(theme, width = 75)
      y_theme <- 0.345
      for (ligne in theme_lines) {
        text(0.12, y_theme, ligne, adj = 0, cex = 0.88)
        y_theme <- y_theme - 0.035
      }

      y_infos <- y_theme - 0.055
      text(0.12, y_infos, paste("LIEU :", lieu), adj = 0, cex = 0.95, font = 2)
      text(0.12, y_infos - 0.055, paste("DATE :", date_soutenance), adj = 0, cex = 0.95, font = 2)
      text(0.12, y_infos - 0.11, paste("AUTEUR(E) :", auteur), adj = 0, cex = 0.95, font = 2)
      box()
    }
  )

  observeEvent(input$export_excel, {
    showNotification(
      "Le bouton d'export Excel est prêt pour l'intégration.",
      type = "message",
      duration = 5
    )
  })

  observeEvent(input$export_csv, {
    showNotification(
      "Le bouton d'export CSV est prêt pour l'intégration.",
      type = "message",
      duration = 5
    )
  })
}

# ---------------------------
# LANCEMENT DE L'APPLICATION
# ---------------------------

shinyApp(ui = ui, server = server)
