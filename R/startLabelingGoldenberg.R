#' Run the labelMe webapp - user facing function
#'
#' A function that allows a user to set their desired webapp parameters
#' and serves a shiny web application. The structure of this function was
#' inspired by code snippet found at Dean Attali's blog post titled
#' "Supplementing your R package with a Shiny app"
#' (https://deanattali.com/2015/04/21/r-package-shiny-app/)
#'
#' No parameters. these are currently hardcoded values
#'
#' @return None. Side effect of calling the function is the running of the
#' Shiny webapp defined in inst/available-shiny-apps/ultrasound-shiny/app.R
#'
#'
#' @export
#' @import shiny

startLabelingGoldenberg <- function() {
  appDir <- system.file("available-shiny-apps",
                        "testing-app",
                        package = "labelMe")
  if (appDir == "") {
    stop("Could not find the ultrasound-shiny app. Try re-installing `labelMe`.", call. = FALSE)
  }

  else {
    shiny::runApp(appDir, display.mode = "normal")
  }

  # Clear global environment after exiting app window
  # on.exit(rm(LABELS, envir=.GlobalEnv))
}

