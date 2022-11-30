#' Loads libraries for this package
#'
#' Set up for the package. Required in UI
#' @param API \code{chr} The API key string. See `tinymce_key` for setup instructions. **Optional**
#' @param API \code{lgl} If you wish to specifically use the API, set this to `TRUE`
#' @return JS Files
#' @export

use_editor <- function(API = Sys.getenv("TINYMCE_KEY"), use_api = FALSE) {
  if (UU::zchar(API) && use_api) {
    UU::gwarn("No API Key provided. See {.code tinymce_key} to set one up.")
  }

  shiny::singleton(shiny::tagList(
    htmltools::attachDependencies(
      shiny::tags$head(
        shinyjs::useShinyjs(),
        # shiny::tags$script(src = "OpenMCE-assets/OpenMCE.js"),
        shiny::tags$script(
          "Shiny.addCustomMessageHandler('HTMLText', function(data) {
       eval(data.jscode)
      });"
        ),
      shiny::tags$script(
        "Shiny.addCustomMessageHandler('UpdateOpenMCE', function(data) {
        tinyMCE.get(data.id).setContent(data.content);
        $('#'+data.id).trigger('change');});"
      )
      ),
      tiny_mce_dependency(API = ifelse(use_api, API, ""))
    )
  ))

}

#' Include the tinyMCE javascript dependencies
#'
#' @return \code{html_dependency}
#' @export
#'

tiny_mce_dependency <- function(API = "") {
  src = if (nzchar(API))
    c(href = paste0("https://cdn.tiny.cloud/1/",
                    API,
                    "/tinymce/5"))
  else
    c(file = "node_modules/tinymce")
  htmltools::htmlDependency(
    name = "tinyMCE",
    version = "6.3.0",
    package = "OpenMCE",
    src = src,
    script = "tinymce.min.js"
  )
}
