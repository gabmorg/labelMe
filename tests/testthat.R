library(shinytest)
library(testthat)

# The following code for testing Shiny app was borrowed from a Shinytest
# tutorial by Ferand Dalatieh
# (Unit) Testing Shiny apps using testthat
# (https://www.r-bloggers.com/unit-testing-shiny-apps-using-testthat/)

context("Shiny app test")

# open Shiny app and PhantomJS
# app <- ShinyDriver$new("")


# The code below to setup the testing process comes from Dr. Steipe's rpt package
# (https://github.com/hyginn/rpt):

# parse the package name from the parent directory path (necessary because
# normal tests and R CMD Check tests are run from different directories)
# x <- unlist(strsplit(gsub("(\\.Rcheck/tests)?$", "", getwd()), "/"))
# pkgName <- x[length(x)]
#
# library(pkgName, character.only = TRUE)
#
# test_check(pkgName)
# [END]
