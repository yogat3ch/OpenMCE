
<!-- README.md is generated from README.Rmd. Please edit that file -->
<!-- README.md is generated from README.Rmd. Please edit that file -->

# OpenMCE : The TinyMCE Rich Text Editor for Shiny

<!-- badges: start -->
<!-- badges: end -->

Looking to add a Rich Text editing field to your Shiny app? Look no
further than TinyMCE, as they indicate on their site:

> TinyMCE gives you total control over your rich text editing.

## Deployment Details

This package can use the [Tiny Cloud](https://www.tiny.cloud/) if you
have a subscription and set up the `TINYMCE_KEY` *.Renviron* variable
(see `?tinymce_key` for setup instructions). If you don’t have a
subscription, TinyMCE v6.3.0 open source is bundled with this package
and will be used in the absence of an API key. The bundled dependencies
will include a small Upgrade button on the top right of the editor.

## Installation

``` r
require("remotes")
remotes::install_github("yogat3ch/OpenMCE")
```

### Setting up an API Key (Optional)

Register at [tiny.cloud](https://www.tiny.cloud/) and on your
[dashboard](https://www.tiny.cloud/my-account/dashboard/) you’ll find
the Tiny API Key. The API key is a trial version with \~80 free loads of
the editor. You can authorize domains with which you wish to use the key
by clicking `Add domain`. See the [setup
guide](https://www.tiny.cloud/blog/how-to-get-tinymce-cloud-up-in-less-than-5-minutes/)
for more details.

## Examples

### A Minimal Example

This example uses the TinyMCE editor with basic features.

``` r
library(OpenMCE)
# UI
ui <- fluidPage(# Setup
  use_editor(use_api = TRUE),
  titlePanel("A Simple Example"),

  # Text Input 1
  fluidRow(
    column(
      width = 6,
      editor_ui('textcontent'),
      br(),
      actionButton(
        "generatehtml",
        "Generate HTML Code",
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
  editor_server("textcontent", inputId = "mytext")
  output$rawText <- renderUI({
    req(content())
    shiny::HTML(content())
  })
  observeEvent(input$generatehtml, {
    content(input$mytext)
  })

}

# Run App
shinyApp(ui = ui, server = server)
```

### A Feature-rich Editor Example

This example highlights some of the many features of the TinyMCE editor.

``` r
library(OpenMCE)

# UI
ui <- fluidPage(

  # Setup
  use_editor(),
  titlePanel("HTML Generator"),

  # Text Input 1
  fluidRow(
    column(
      width = 6,
      editor_ui('textcontent', init_text = "Sample Text"),
      br(),
      actionButton(
        "generatehtml",
        "Generate HTML Code",
        icon = icon("code"),
        class = "btn-primary"
      )),

    column(
      width = 6,
      uiOutput("rawText")
    )
  )

)

# Server
server <- function(input, output, session) {

  # Generate HTML
  content <- reactiveVal()
  editor_server("textcontent", inputId = "mytext", options = list(
    branding = FALSE,
    plugins = c('lists', 'table', 'link', 'image', 'code'),
    toolbar1 = 'bold italic forecolor backcolor | formatselect fontselect fontsizeselect | alignleft aligncenter alignright alignjustify',
    toolbar2 = 'undo redo removeformat bullist numlist table blockquote code superscript  subscript strikethrough link image'
  ))
  output$rawText <- renderUI({
    req(content())
    shiny::HTML(content())
  })
  observeEvent(input$generatehtml, {
    content(input$mytext)
  })

}

# Run App
shinyApp(ui = ui, server = server)
```

### How to use `editor_update`

This example demonstrates how to use the `editor_update` function for
dynamic updating of the editor from the server.

``` r
library(OpenMCE)
 # UI
 ui <- fluidPage(

   # Setup
   use_editor(),
   titlePanel("Editor Update Example"),

   # Text Input 1
   fluidRow(
     column(
       width = 6,
       editor_ui('textcontent'),
       br(),
       actionButton(
         "generatehtml",
         "Generate HTML Code",
         icon = icon("code"),
         class = "btn-primary"
       ), actionButton("updatedata", "Update Editor", icon = icon("edit"))),

     column(
       width = 6,
       uiOutput("rawText")
     )
   )

 )

 # Server
 server <- function(input, output, session) {

   # Generate HTML
   content <- reactiveVal()
   editor_server("textcontent", inputId = "mytext")
   output$rawText <- renderUI({
     req(content())
     shiny::HTML(content())
   })
   observeEvent(input$generatehtml, {
     content(input$mytext)
   })

   observeEvent(input$updatedata, {
    editor_update(inputId = "textcontent",
                  text = "<b>Sample Text</b>")

  })

 }

 # Run App
 shinyApp(ui = ui, server = server)
```

### How to use `editor_text`

This example demonstrates how to manually retrieve the rich text entered
in the editor as character encoded HTML

``` r
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
        "Generate HTML Code",
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
```

<hr>

This package was inspired by ShinyEditor
[deepanshu88/ShinyEditor](https://github.com/deepanshu88/ShinyEditor)
