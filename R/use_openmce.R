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

  shiny::singleton(htmltools::attachDependencies(shiny::tagList(
    htmltools::htmlDependency(
      name = "OpenMCE",
      version = utils::packageVersion("OpenMCE"),
      package = "OpenMCE",
      src = "srcjs",
      script = list(src = "OpenMCE-deps.js", defer = NA)
    ),
    shinyjs::useShinyjs()
    ),
    tiny_mce_dependency(API = ifelse(use_api, API, ""))
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
    script = list(src = "tinymce.min.js", defer = NA)
  )
}
