library(shiny)
#' Run the labelMe webapp - user facing function
#'
#' A function that allows a user to set their desired webapp parameters
#' and serves a shiny web application
#'
#' @param labelingList A list of strings denoting the labels that
#' the user would like to have as options for the image labeling task
#' @param imagesPath A string of the filepath on the local machine where
#' the directory of images to label can be found. Some restrictions exist
#' in terms of the structuring of the images
#'
#' @return Returns a dataframe containing the modified list of image file names
#' which represent the labeling of the user
#'
#'
#' @export
#' @import shiny

 serveMe <- function(labelingList, imagesPath) {
   imagesPathOutput <- list("img1", "img2", "img3")
   appDir <- system.file("shiny-examples", "shiny", package = "labelMe")
   if (appDir == "") {
     stop("Could not find example directory. Try re-installing `labelMe`.", call. = FALSE)
   }

   shiny::runApp(appDir, display.mode = "normal")
   return(as.data.frame(row.names = imagesPathOutput))
}

