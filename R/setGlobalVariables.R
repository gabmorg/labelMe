#' Bind global variables used by Shiny webapp
#'
#' A file used to bind the global variables needed to pass user parameters
#' to the Shiny webapp build by startLabeling(). Not user-facing and the global vars
#' are used only internally and deleted on Shiny session exit.
#' Inspiration for this approach to global variable binding was found from user jennybc in this
#' statistics course discussion on github: https://github.com/STAT545-UBC/Discussion/issues/451
if(getRversion() >= "3.5.0")  utils::globalVariables(c("LABELS"))
