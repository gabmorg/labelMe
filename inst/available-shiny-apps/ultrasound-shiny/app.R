# This script contains the 3 core components of a Shiny app:
# a user interface object
#
# a server function
#
# a call to the shinyApp function

# TO REMOVE BEFORE SUBMISSION:
if (!require(shiny, quietly = TRUE)) {
  install.packages("shiny")
  library(shiny)
}

if (!require(shinyFiles, quietly = TRUE)) {
  install.packages("shinyFiles")
  library(shinyFiles)
}

if (!require(htmltools, quietly = TRUE)) {
  install.packages("htmltools")
  library(htmltools)
}


# Define UI for app that stores image labels ----
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
      br()
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

      # Image directory upload:
      # INSERT HERE

      # Image display layout:
      fluidRow(
        column(3, offset = 1, imageOutput("img1")),
        column(3, offset = 1, imageOutput("img2"))

      ),


      # Radio buttons for labeling:
      fluidRow(
        column(3, offset = 1,
               radioButtons("radio1", h5("Label"),
                            choices = list("Label 1" = 1, "Label 1" = 2,
                                           "Unknown" = 3), selected = character(0))),
        column(3, offset = 1,
               radioButtons("radio2", h5("Label"),
                            choices = list("Label 2" = 1, "Label 2" = 2,
                                           "Unknown" = 3), selected = character(0)))
      )
    )
  ),
  br(),
  downloadButton('download',"Download image labels CSV")
)


# Define server logic required to upload and display our images
server <- function(input, output){

  # Example dataset
  # TO DO: input the labels data here (currently a test dataset)
  data <- mtcars

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
