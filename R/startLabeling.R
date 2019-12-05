#' Launch the labelMe webapp - user facing function
#'
#' A function that allows a user to set their desired webapp parameters
#' and serves a shiny web application.
#'
#' @param labelingList A 2D list of strings denoting the labels that
#' the user would like to have as options for the image labeling task
#'
#' @return None. Side effect of calling the function is the running of the
#' Shiny webapp defined in inst/available-shiny-apps/ultrasound-shiny/app.R
#'
#' @examples
#' \dontrun{
#' labels <- list(list("test label1", "test label2"), list("test label12", "test label22"))
#' startLabeling(labels)
#' }
#'
#' @export
#' @importFrom shiny runApp
#' @source "setGlobalVariables.R"
#'
#'@references
#' Attali, D. (2015 April 21). Supplementing your R package with a Shiny app. Retrieved from
#' \href{https://deanattali.com/2015/04/21/r-package-shiny-app/}{Link}
#'

startLabeling <- function(labelingList) {
  appDir <- system.file("available-shiny-apps",
                        "ultrasound-shiny",
                        package = "labelMe")
  if (appDir == "") {
    stop("ERROR: Could not find the ultrasound-shiny app. Try re-installing `labelMe`.",
         call. = FALSE)
  }

  else {
    # Checking that input is a list
    if(!is.list(labelingList)) {
      stop("ERROR: Input must be a list of 2 lists, one for each group of radio button options")
    }

    # Checking input list is the right length
    else if(!length(labelingList) == 2) {
      stop("ERROR: Input must be a list of 2 lists, one for each group of radio button options")
    }

    # Checking that all the labels are unique
    if(length(unique(unlist(labelingList[1]))) !=
       length(unlist(labelingList[1]))) {
      stop("ERROR: Found repeating label in list 1, please remove duplicates and try again")
    }

    else if(length(unique(unlist(labelingList[2]))) !=
            length(unlist(labelingList[2]))) {
      stop("ERROR: Found repeating label in list 2, please remove duplicates and try again")
    }

    # Pass the input variable (the desired labels for images) to labelMe
    .GlobalEnv$LABELS <- labelingList
    shiny::runApp(appDir, display.mode = "normal")
  }

  # Clear global environment after exiting app window
  on.exit(rm(LABELS, envir=.GlobalEnv))
}

