#' Loads libraries for this package
#'
#' Set up for the package. Required in UI
#'
#' @return JS Files
#' @export

use_editor <- function(API = Sys.getenv("TINYMCE_KEY"), path = system.file("node_modules/tinymce/tinymce.min.js", package = "ShinyEditor")) {
  if (UU::zchar(API)) {
    UU::gwarn("No API Key provided. See {.code tinymce_key} to set one up.")
  }

  shiny::tagList(shiny::singleton(
    htmltools::attachDependencies(shiny::tags$head(
      shinyjs::useShinyjs(),
      # shiny::tags$script(src = "ShinyEditor-assets/ShinyEditor.js"),
      shiny::tags$script(
      "Shiny.addCustomMessageHandler('HTMLText', function(data) {
       eval(data.jscode)
      });"
      ),
      shiny::tags$script(
        "Shiny.addCustomMessageHandler('UpdateshinyEditor', function(data) {
        tinyMCE.get(data.id).setContent(data.content);
        $('#'+data.id).trigger('change');});")
    ), tiny_mce_dependency())
  ))

}

#' Include the tinyMCE javascript dependencies
#'
#' @return \code{html_dependency}
#' @export
#'

tiny_mce_dependency <- function() {
  shiny::addResourcePath("tinymce-6.3.0", system.file("node_modules/tinymce", package = "ShinyEditor"))
  htmltools::htmlDependency(
    name = "tinyMCE",
    version = "6.3.0",
    package = "ShinyEditor",
    src = c(
      file = "node_modules"
    ),
    script = "tinymce/tinymce.min.js"
  )
}
