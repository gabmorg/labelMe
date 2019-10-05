#' Bind global variables used by Shiny webapp
#'
#' A file used to bind the global variables needed to pass user parameters
#' to the Shiny webapp build by serveMe(). Not user-facing and the global vars
#' are used only internally
if(getRversion() >= "3.5.0")  utils::globalVariables(c("LABELS"))
