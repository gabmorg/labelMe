context("Label app input type check")
library(labelMe)

test_that("user input is saved to GLOBAL env", {})

test_that("user input is of correct type", {
  labels_duplicates <- list(list("test label1", "test label1", "test label2"),
                            list("test label12", "test label22"))
  labels_short <- list(list("test label1", "test label2"))
  labels_long <- list(list("test label1", "test label2"),
                      list("test label12", "test label22"),
                      list("test label12", "test label22"))
  testthat::expect_error(startLabeling(labels_duplicates),
                         "ERROR: Found repeating label in list 1, please remove duplicates and try again")
  testthat::expect_error(startLabeling(labels_short),
                         "ERROR: Input must be a list of 2 lists, one for each group of radio button options")
  testthat::expect_error(startLabeling(labels_long),
                         "ERROR: Input must be a list of 2 lists, one for each group of radio button options")
})
