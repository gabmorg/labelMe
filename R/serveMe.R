library(shiny)
#' Run the labelMe webapp - user facing function
#'
#' A function that allows a user to set their desired webapp parameters
#' and serves a shiny web application. The structure of this function was
#' inspired by code snippet found at Dean Attali's blog post titled
#' "Supplementing your R package with a Shiny app"
#' (https://deanattali.com/2015/04/21/r-package-shiny-app/)
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
   imagesPathOutput <- list("img1", "img2", "img3" )# test code only, or keep as an "example serve"
   appDir <- system.file("available-shiny-apps", "ultrasound-shiny", package = "labelMe")
   if (appDir == "") {
     stop("Could not find example directory. Try re-installing `labelMe`.", call. = FALSE)
   }

   shiny::runApp(appDir, display.mode = "normal")
   return(as.data.frame(row.names = imagesPathOutput))
}

