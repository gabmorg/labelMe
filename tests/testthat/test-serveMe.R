# The following code for testing Shiny app was borrowed from a Shinytest
# tutorial by Ferand Dalatieh
# (Unit) Testing Shiny apps using testthat
# (https://www.r-bloggers.com/unit-testing-shiny-apps-using-testthat/)
# Note: this is currently all extremely broken (the actual testing functions are hard
# to adapt for shinytest/testthant integration, the code loads)

# context("Shiny app test")
#
# # open Shiny app and PhantomJS
# app <- ShinyDriver$new("./inst/available-shiny-apps/ultrasound-shiny")


# test_that("labels set as radioButtons match visual confirmation text", {
#   # set value of radioButtons to 1st choice
#   app$setValue(radio1 = "test label1")
#   # get text_out
#   output <- app$getValue(name = "radio1")
#   # test
#   expect_equal(output, "test label1")
# })

# test_that("naming of radioButtons group matches filename uploaded", {
#   # upload file
#   app$uploadFile(name = 'imageUpload', value = "./inst/extdata/pt1234_12.jpg")
#   # get visual confirmation placeholder text
#   visualConf <- app$getValue(name = "imgName", iotype = "output")
#   #test
#   expect_equal(output, "pt1234_12.jpg")
# })

# stop the Shiny app
# app$stop()
