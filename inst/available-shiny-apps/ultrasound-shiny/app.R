#' Build the labelMe webapp - backend script (not exported)
#'
#'# This script contains the 3 core components of a Shiny app:
#'a user interface object
#'a server function
#'a call to the shinyApp function
#'
#' @return None. Side effect of calling the function is the running of the
#' Shiny webapp defined in inst/available-shiny-apps/ultrasound-shiny/app.R
#'
#' @import shiny
#' @import htmltools
#' @import shinyFiles
#' @source "helpers.R"
#' @source "setGlobalVariables.R"

# Global variable default set here for testthat purposes only:
LABELS <- list("test label1", "test label2", "unknown")

# 1. Define UI for app that stores image labels
ui <- fluidPage(

  # TO DO:
  # You can use navbarPage to give your app a multi-page user
  # interface that includes a navigation bar.

  # App title ----
  titlePanel("labelMe: Manual Labelling for Clinical Imaging"),

  sidebarLayout(
    position = "right",

    sidebarPanel(
      h3("Images"),
      br(),
      p("The list of uploaded images will go here"),
      br(),
      # Image directory upload:
      fileInput(
        inputId = 'imageUpload',
        multiple = TRUE,
        label = 'Upload Images',
        accept = c('image/png', 'image/jpeg', 'image/jpg', 'image/pdf'),
        width = '80%'),
      fluidRow(
        actionButton("saveLabels", "Save selected labels"),
        downloadButton('download',"Download labels.csv")
      )
    ),


    mainPanel(

      # Instructions for user:
      h3("Labeling Task"),
      p("Label each of the images below by selecting one of the provided lables."),
      em("Note that, unless you're selecting the option ",
        strong("unknown,"), "each image should have a different label, as each image represents
        a different view of the same ultrasound object (ex. the same kidney)"),
      br(),
      br(),

      # Radio buttons for labeling:
      fluidRow(
        column(3, offset = 1, imageOutput("img1")),
        column(3, offset = 1,
               radioButtons(inputId = "radio1",
                            label = textOutput("imgName"),
                            choices = LABELS, selected = character(0)))
      ),
      textOutput("selected_radio1")
    )


  )

)


# 2. Define server logic required to upload and display images
server <- function(input, output){
  data <- data.frame(matrix(nrow=1,ncol=2))
  colnames(data) <- c("key", "label")

  output$imgName <- renderText({paste(input$imageUpload$name)})

  output$img1 <- renderImage(
                    {list(src = input$imageUpload$datapath,
                          alt = "Please upload an image using the file browser
                          to your right")},
                    deleteFile = FALSE)

  # Visually validate the selection:
  output$selected_radio1 <- renderText({paste("You have selected", input$radio1)})

  # The following of the observeEvent function was taken from Data Input in R/Shiny
  # by Lisa DeBruine
  # https://gupsych.github.io/tquant/data-input.html
  observeEvent(input$saveLabels, {
    var <- input$radio1
    if (length(var) > 1 ) {
      data[input$imageUpload$name] <- list(var)
    }
  })

  # Download a file with the name labels-DATE.csv
  output$download <- downloadHandler(
                            filename = function(){
                              paste("labels-", Sys.Date(), ".csv", sep="")
                            },
                            content = function(fname){
                              write.csv(data, fname)
                            },
                            contentType = "text/csv"
                      )
}


# Serve the Shiny app
shinyApp(ui = ui, server = server)
