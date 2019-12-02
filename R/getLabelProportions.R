#' Get Label Proportions
#'
#' A function that generates an interactiev pie chart that describes
#' the balance in labels of the dataset that's provided to it
#'
#' @param labelDF A dataframe with at least the columns: image_key, label_1, label_2
#'
#' @return Returns a list with 2 embedded objects: the pie chart,
#' and a table that calculates the proportions of each factor,
#' identifying overrepresented labels in labelDF
#'
#' @examples
#' \dontrun{
#'   exampleDF <- data.frame (
#'     image_key = c(1,2,3,4),
#'     label_1 = c("Saggital", "Saggital", "Transverse", "Bladder"),
#'     label_2 = c("Right", "Right", "Left", "NA")
#'   )
#'   getLabelProportions(exampleDF$chart)
#' }
#'
#'
#' @export
#' @import plotly
#' @import dplyr
#'

getLabelProportions <- function(labelDF) {
  labelDF <- dplyr::select(labelDF, c("label_1", "label_2"))

  # Using the pipe operator, plot 2 pie charts that group rows
  # in labelDF by one of the labels in the specified group (label_1, label_2)
  # domain field refers to its grid layout location when displayed
  proportionPie <- plot_ly() %>%
    add_pie(data = dplyr::count(labelDF, label_1), labels = ~label_1, values = ~n,
            name = "Labeling Proportions by Group 1",
            domain = list(row = 0, column = 0)) %>%
    add_pie(data = dplyr::count(labelDF, label_2), labels = ~label_2, values = ~n,
            name = "Labeling Proportions by Group 2",
            domain = list(row = 0, column = 1)) %>%
    layout(title = "Labeling Proportions by Radio Group", showlegend = T,
           grid=list(rows=1, columns=2),
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))

  # Calculate the frequency of each label combination in labelDF
  # Identify potentially overrepresented labels by the top 1/3 of frequencies
  # Identify potentially underrepresented labels by the bottom 1/3 of frequencies
  # Combine label columns into 1 labeling group, then order them by frequency
  labelFrequencies <- as.data.frame(table(labelDF))
  labelFrequencies$label_group <- paste(labelFrequencies$label_1,
                                        labelFrequencies$label_2,
                                        sep = "-")
  labelFrequencies <- dplyr::select(labelFrequencies, c("label_group", "Freq"))
  lengthLF <- nrow(labelFrequencies)
  topThird <- floor(lengthLF/3)
  bottomThird <- lengthLF - floor(lengthLF/3)
  labelFrequencies <- labelFrequencies[order(-labelFrequencies$Freq),]
  overFreq <- labelFrequencies[1:topThird,]
  underFreq <- labelFrequencies[bottomThird:lengthLF,]

  # Create a visualization of the labeling distribution
  freqHist <- plot_ly(x = labelFrequencies$label_group,
                      y = labelFrequencies$Freq,
                      type = "histogram")

  # Identify underrepresented labels
  resultsDF <- list("pie_chart" = proportionPie, "proportions" = labelFrequencies,
                    "overrep" = overFreq, "underrep" = underFreq,
                    "freq_chart" = freqHist)
  return(resultsDF)
}


# you did a lot of stuff in the process of making this work: changed a print() to message(), added the rendering code to app.R
# first make sure you can use the factors thing to create the diff types of proportions, may need a helper fn

