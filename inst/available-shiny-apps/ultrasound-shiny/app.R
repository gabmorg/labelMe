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
      downloadButton('download',"Download labels.csv"),
      h3("Images"),
      br(),
      br(),
      # Image directory upload:
      # returns dataframe! easy to work with :D
      fileInput(
        inputId = 'imageUpload',
        multiple = TRUE,
        label = 'Upload Images',
        accept = c('image/png', 'image/jpeg', 'image/jpg', 'image/pdf'),
        width = '80%')
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

      # Image display layout:

      # Radio buttons for labeling:
      # may need to change to inputselect for Lauren
      # createImageDisplays() should automate this away
      fluidRow(
        column(3, offset = 1, imageOutput("img1")),
        column(3, offset = 1,
               radioButtons(inputId = "radio1", label = textOutput("imgName"),
                            choices = LABELS, selected = character(0)))
      ),
      textOutput("selected_radio1")

    )


  )

)


# 2. Define server logic required to upload and display our images
server <- function(input, output){

  # Example dataset
  # TO DO: input the labels data here (currently a test dataset)
  # keys <- reactive({input$imageUpload$name})
  data <- data.frame(key = 1, label = 1, row.names = 1, stringsAsFactors = FALSE)

  output$imgName <- renderText({paste(input$imageUpload$name)})

  output$img1 <- renderImage(
                    {list(src = input$imageUpload$datapath)},
                    deleteFile = FALSE)

  # to delete (reroute output to CSV):
  output$selected_radio1 <- renderText({paste("You have selected", input$radio1)})

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


# This call to shinyApp will serve the Shiny app
shinyApp(ui = ui, server = server)

# runApp("shiny", display.mode = "showcase") <-- show the app w the relevant setup code alongside it
