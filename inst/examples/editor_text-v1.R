library(OpenMCE)
devtools::load_all(pkgload::pkg_path())
# UI
ui <- fluidPage(# Setup
  use_editor(),
  titlePanel("An Editor Text example"),

  # Text Input 1
  fluidRow(
    column(
      width = 6,
      editor_ui('textcontent'),
      br(),
      actionButton(
        "generatehtml",
        "Render Input as HTML",
        icon = icon("code"),
        class = "btn-primary"
      )
    ),

    column(width = 6,
           uiOutput("rawText"))
  ))

# Server
server <- function(input, output, session) {
  # Generate HTML
  content <- reactiveVal()
  editor_server("textcontent")

  observeEvent(input$generatehtml, {
    editor_text("textcontent", inputId = "mytext")
    output$rawText <- renderUI({
      req(input$mytext)
      shiny::HTML(input$mytext)
    })
  })

}

# Run App
shinyApp(ui = ui, server = server)
