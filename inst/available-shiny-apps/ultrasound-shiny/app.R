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
#' @references
#' Laurent, S. (2019 September 11). Render images for interactive display from folder loaded with shinyDirChoose [StackOverflow page]
#' Retrieved from
#' \href{https://stackoverflow.com/questions/57891201/render-images-for-interactive-display-from-folder-loaded-with-shinydirchoose}{Link}
#'
#' @import shiny
#' @import htmltools
#' @import plotly
#' @source "helpers.R"
#' @source "setGlobalVariables.R"
#' @source "getLabelProportions.R"
ui <- fluidPage(
  titlePanel("labelMe: Manual Labelling for Clinical Imaging"),
  # Arrow navigation between images (Javascript):
  tags$script(
    '
    $(document).on("keydown", function(e) {
    key = e.which;
    if(key === 39) {
    Shiny.onInputChange("rightArrow", [e.which, e.timeStamp]);
    }
    else if(key === 37) {
    Shiny.onInputChange("leftArrow", [e.which, e.timeStamp]);
    }
    });
    '
  ),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      h3("Image Upload"),
      uiOutput('fileInputs'),
      fluidRow(
        actionButton("flushData", "Flush Data"),
        downloadButton("download", "Download DATE-labels.csv")
      )
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
                  tabPanel("Labeling",
                           uiOutput('images'),
                           textOutput("radioSelection"),
                           uiOutput('radios')),
                  tabPanel("Uploaded Files",
                           tableOutput('fileTable'))
      )
    )
  )
)

server <- shinyServer(function(input, output) {
  imagePages <- reactiveValues(page = 1)

  # pagination navigation helper:
  navigate <- function(direction, toStart = FALSE) {
    if (toStart) {
      imagePages$page <- 1
    }
    else {
      imagePages$page <- imagePages$page + direction
    }

  }

  # access with files()
  files <- reactive({
    input$flushData
    files <- input$files
    files$image_key <- c(1:nrow(input$files))
    files$datapath <- gsub("\\\\", "/", files$datapath)
    files$label <- c("Unknown")
    files
  })

  # Initialize dataframe built dynamically upon each labeling event
  # Serves as the session's data store to create the output CSV
  # This runs once per session
  selectiondf <- reactiveValues()
  selectiondf$df <- data.frame(
    image_key = integer(),
    image_name = character(),
    label_1 = character(),
    label_2 = character(),
    stringsAsFactors = FALSE
  )

  # Display uploaded file info
  output$fileTable <- renderTable({
    input$flushData
    if (is.null(input$files))
      return(NULL)
    else {
      return(files())
    }
  })

  # File input browser server-side setup
  output$fileInputs <- renderUI({
    input$flushData
    fileInput(
      inputId = 'files',
      label = 'Upload labeling images here',
      multiple = TRUE,
      accept = c(
        'image/png',
        'image/jpeg',
        'image/jpg',
        'pdf',
        'image/dicom-rle',
        'image/jls'
      )
    )
  })

  # Paginated images setup for uiOutput('images')
  output$images <- renderUI({
    input$flushData
    if (is.null(input$files))
      return(NULL)
    else {
      imageId <- paste0("image", imagePages$page)
      fluidRow(column(10, offset = 2, imageOutput(imageId)))
    }
  })

  # Paginated radio button setup for uiOutput('radios')
  output$imgName <- renderText({
    files()$name[imagePages$page]
  })
  output$radios <- renderUI({
    input$flushData

    if (is.null(input$files)) {
      return(NULL)
    }
    else {
      radioIdA <- paste0("radioA", imagePages$page)
      radioIdB <- paste0("radioB", imagePages$page)

      fluidRow(
        column(
          3,
          offset = 2,
          radioButtons(
            inputId = radioIdA,
            label = textOutput("imgName"),
            choices = unlist(.GlobalEnv$LABELS[1]),
            selected = selectiondf$df[imagePages$page, "label_1"]
          )
        ),
        column(
          3,
          offset = 2,
          radioButtons(
            inputId = radioIdB,
            label = "View type",
            choices =  unlist(.GlobalEnv$LABELS[2]),
            selected = selectiondf$df[imagePages$page, "label_2"]
          )
        )
      )}
  })

  # Records selections in selectiondf
  # which is updated whenever a radio button option is selected at
  # the row corresponding to the image page
  # i.e. this expression is reactive on:
  # input[[radioIdA]], input[[radioIdB]], imagePages$page
  selectedOption <- reactive({
    radioIdA <- paste0("radioA", imagePages$page)
    radioIdB <- paste0("radioB", imagePages$page)

    selectiondf$df[imagePages$page, "image_key"] <- imagePages$page
    selectiondf$df[imagePages$page, "image_name"] <- files()$name[imagePages$page]
    selectiondf$df[imagePages$page, "label_1"] <- input[[radioIdA]]
    selectiondf$df[imagePages$page, "label_2"] <- input[[radioIdB]]

    # Debug print (to console):
    print(paste0("Image label: ", input[[radioIdA]], ", ", input[[radioIdB]]))

    return(
      c(selectiondf$df[imagePages$page, "label_1"],
        selectiondf$df[imagePages$page, "label_2"]))
  }
  )


  # Triggers code above; when confirmation is on screen,
  # that data has been entered into selectiondf
  # Visual confirmation of selected radio button option (default is Unknown)
  # this code also attaches the label to selectiondf
  output$radioSelection <- renderText({
    input$flushData
    radioIdA <- paste0("radioA", imagePages$page)
    radioIdB <- paste0("radioB", imagePages$page)

    req(input[[radioIdA]])
    req(input[[radioIdB]])

    paste0("This image has been labeled: ",
           selectedOption()[1],
           ", ",
           selectedOption()[2])
  })

  # Paginated image rendering - (Laurent, 2019)
  observeEvent(input$files, {
    if (is.null(input$files))
      return(NULL)
    for (i in 0:nrow(files())) {
      local({
        local_i <- i
        imageIndex <- paste0("image", local_i)
        output[[imageIndex]] <-
          renderImage({
            list(
              src = files()$datapath[local_i],
              width = "400",
              height = "400",
              alt = "Image upload failed!"
            )
          }, deleteFile = FALSE)

      })
      selectiondf$df[i, "image_key"] <- i
      selectiondf$df[i, "image_name"] <- files()$name[i]
      selectiondf$df[i, "label_1"] <- NA
      selectiondf$df[i, "label_2"] <- NA
    }
  })

  # Arrow navigation between pages:
  observeEvent(input$rightArrow, {
    if (imagePages$page < nrow(files())) {
      navigate(1)
    }
    else
      navigate(0)
  })

  observeEvent(input$leftArrow, {
    if (imagePages$page >= 2) {
      navigate(-1)
    }
    else
      navigate(0)
  })

  # Download a file with the name labels-DATE.csv
  # the contents are equal to the contents of the data table
  # displayed on the user interface
  output$download <- downloadHandler(
    filename = function() {
      paste(Sys.Date(), "-labels", ".csv", sep = "")
    },
    content = function(fname) {
      write.csv(selectiondf$df, fname)
    },
    contentType = "text/csv"
  )

  # Clean saved data from session
  # Affects pagination, selectiondf, files()
  observeEvent(input$flushData, {
    for (i in 0:nrow(files())) {
      local({
        local_i <- i
        imageIndex <- paste0("image", local_i)
        output[[imageIndex]] <- NULL
      })
    }

    selectiondf$df <- selectiondf$df <- data.frame(
      image_key = integer(),
      image_name = character(),
      label_1 = character(),
      label_2 = character(),
      stringsAsFactors = FALSE
    )

    files <- NULL
    navigate(0, toStart = TRUE)
  })
})



shinyApp(ui = ui, server = server)
