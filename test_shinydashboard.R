# Test shinydashboard (données fictives)
library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "Test shinydashboard"),
  dashboardSidebar(sidebarMenu(
    menuItem("Accueil", tabName = "accueil", icon = icon("home")),
    menuItem("Candidats", tabName = "candidats", icon = icon("users")),
    menuItem("Statistiques", tabName = "stats", icon = icon("chart-bar"))
  )),
  dashboardBody(tabItems(
    tabItem("accueil", h2("Bienvenue dans le projet test")),
    tabItem("candidats", h2("Liste de démonstration"),
            tableOutput("liste")),
    tabItem("stats", h2("Indicateurs fictifs"),
            fluidRow(
              valueBox(120, "Candidats fictifs", icon = icon("users"), color = "aqua"),
              valueBox(35, "Soutenances fictives", icon = icon("graduation-cap"), color = "green")
            ))
  ))
)
server <- function(input, output, session) {
  output$liste <- renderTable(data.frame(
    Matricule = c("TEST001", "TEST002"),
    Nom = c("KONE", "YAO"),
    Filiere = c("Biologie", "Biochimie")
  ))
}
shinyApp(ui, server)
