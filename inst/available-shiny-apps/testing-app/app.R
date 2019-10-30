# ui <- fluidPage(
#   titlePanel("Multiple file uploads"),
#   # sidebarLayout(
#   #   sidebarPanel(
#   #     fileInput("csvs",
#   #               label="Upload CSVs here",
#   #               multiple = TRUE)
#   #   ),
#     mainPanel(
#       shinyDirButton('folder', 'Folder select', 'Please select a folder', FALSE)
#     )
#   )
# # )
#
# server <- function(input, output) {
#   shinyDirChoose(input, 'folder', roots=c(home = "~"), filetypes=c('pdf', 'png', 'jpeg', 'jpg'))
#
# }
#
# shinyApp(ui = ui, server = server)

# TO DO: add DICOM files support
ui <- fluidPage(

  titlePanel("labelMe: Manual Labelling for Clinical Imaging"),
  # Arrow navigation between images:
  tags$script('
              $(document).on("keydown", function(e) {
                key = e.which;
                if(key === 39) {
                  Shiny.onInputChange("rightArrow", [e.which, e.timeStamp]);
                }
                else if(key === 37) {
                  Shiny.onInputChange("leftArrow", [e.which, e.timeStamp]);
                }

              });
              '),
  sidebarLayout(
    position = "right",
    sidebarPanel(
      h3("Images"),
      fileInput(inputId = 'files',
                label = 'Upload labeling images here',
                multiple = TRUE,
                accept=c('image/png', 'image/jpeg', 'image/jpg', 'image/pdf', 'image/dicom-rle', 'image/jls')),
      fluidRow(
        actionButton("saveLabels", "Save labels"),
        downloadButton('download',"Download labels.csv")
      )
    ),
    mainPanel(
      uiOutput('images'),
      uiOutput('radios'),
      textOutput("radioSelection"),
      br(),
      h3("Images Uploaded"),
      br(),
      tableOutput('fileTable')
    )
  )
)

server <- shinyServer(function(input, output) {
  imagePages <- reactiveValues(page = 1)
  output$fileTable <- renderTable(input$files)

  # pagination navigation helper:
  navigate <- function(direction) {
    imagePages$page <- imagePages$page + direction
  }

  # access via files()
  files <- reactive({
    files <- input$files
    files$image_key <- c(1:nrow(input$files))
    files$datapath <- gsub("\\\\", "/", files$datapath)
    files$label <- selectedOption()
    files
  })


  # paginated images setup for uiOutput('images')
  output$images <- renderUI({
    if(is.null(input$files)) return(NULL)
    else {
      imageId <- paste0("image", imagePages$page)
      imageOutput(imageId)
    }
  })

  # paginated radio button setup for uiOutput('radios')
  output$imgName <- renderText({files()$name[imagePages$page]})
  output$radios <- renderUI({
    if(is.null(input$files)) return(NULL)
    else {
    radioId <- paste0("radio", imagePages$page)
    radioButtons(inputId = radioId,
                 label = textOutput("imgName"),
                 choices = c("Saggital", "Transverse", "Unknown"), selected = "Unknown")
    }
  })

  # visual confirmation of selected radio button option (default is Unknown)
  selectedOption <- reactive({
    if(is.null(input$files)) {
      return("NULL")
    }
    else {
      radioId <- paste0("radio", imagePages$page)
      print(input$radioId)
      input$radioId
    }
  })


  output$radioSelection <- renderText({paste0("Image label: ", selectedOption())})

  # Paginated image rendering - From SO post: [LINK]
  observe({
    if(is.null(input$files)) return(NULL)
    for (i in 1:nrow(files())) {
      local({
        my_i <- i
        imageIndex <- paste0("image", my_i)
        output[[imageIndex]] <-
          renderImage({
            list(
              src = files()$datapath[my_i],
              width = 400,
              height = 400,
              alt = "Image upload failed!"
            )
          }, deleteFile = FALSE)

      })
    }
  })

  # Arrow navigation between pages:
  observeEvent(input$rightArrow,{
    if(imagePages$page < nrow(files())){
      navigate(1)
    }
    else navigate(0)

    # TO DELETE: bug tracking
    # print(imagePages$page)
  })

  observeEvent(input$leftArrow,{
    if(imagePages$page >= 2){
      navigate(-1)
    }
    else navigate(0)

    # TO DELETE: bug tracking
    # print(imagePages$page)
  })

  # Download a file with the name labels-DATE.csv
  # the contents are equal to the contents of the data table
  # displayed on the user interface
  output$download <- downloadHandler(
    filename = function(){
      paste(Sys.Date(),"-labels", ".csv", sep="")
    },
    content = function(fname){
      write.csv(files(), fname)
    },
    contentType = "text/csv"
  )

})


shinyApp(ui=ui,server=server)
