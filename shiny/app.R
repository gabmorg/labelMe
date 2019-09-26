# This file contains the 3 core components of a Shiny app:
# a user interface object
#
# a server function
#
# a call to the shinyApp function

library(shiny)


# Define UI for app that stores image labels ----
ui <- fluidPage(

  # TO DO:
  # You can use navbarPage to give your app a multi-page user
  # interface that includes a navigation bar.

  # App title ----
  titlePanel("labelMe: Manual Labelling for Clinical Imaging"),
  sidebarLayout(
    position = "right",
    sidebarPanel("Images"),
    mainPanel(
      h1("Labeling Task"),
      p("Label each of the images below using one of the provided lables.
        Please note that each image must have a different label, unless
        both of those are *UNKNOWN*")
      # TO ADD IMAGES, WRITE A LOOP FOR THE www DIRECTORY HERE:
      # The img function looks for your image file in a specific place.
      # Your file must be in a folder named www in the same directory as the app.R
    )
  )
)

# Define server logic required to upload and display our images
server <- function(input, output){



}


# This call to shinyApp will serve the Shiny app
shinyApp(ui = ui, server = server)

# runApp("shiny", display.mode = "showcase") <-- show the app w the relevant setup code alongside it
