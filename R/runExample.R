#' Run the labelMe webapp
#'
#' A function that serves a shiny web application
#'
#'
#' @return Returns no data object, but a side effect of running
#' this function is the serving of an shiny app for the labeling tasks
#'
#'
#' @import shiny
runExample <- function() {
  appDir <- system.file("shiny-examples", "shiny", package = "labelMe")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `labelMe`.", call. = FALSE)
  }

  shiny::runApp(appDir, display.mode = "normal")
}
