#' Bind global variables used by Shiny webapp
#'
#' A file used to bind the global variables needed to pass user parameters
#' to the Shiny webapp build by startLabeling(). Not user-facing and the
#' global variable is used only internally, and deleted on Shiny session exit.
#'
#' @return Returns a 2D list of lists that serves as the radio button labels
#' in the Shiny app found in ~/inst/available-shiny-apps/ultrasound-shiny/app.R
#'
#' @references
#' jennybc. (2016 December 2). Writing R Packages: no visible binding for
#' global variable [Github page]. Retrieved from
#' \href{https://github.com/STAT545-UBC/Discussion/issues/451}{Link}
#'
if(getRversion() >= "3.5.0")  utils::globalVariables(c("LABELS", "label_1", "label_2"))
