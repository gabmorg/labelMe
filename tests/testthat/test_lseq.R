#test_lseq.R
# Author: Boris Steipe <https://orcid.org/0000-0002-1134-6758>
#
context("lseq")

# ==== BEGIN SETUP AND PREPARE =================================================
#
# load comparison data from a file in ./inst/exdata using pkgName which
# was defined in helper-functions.R

tmp <- as.numeric(readLines(system.file("extdata",
                                        "test_lseq.dat",
                                        package = pkgName,
                                        mustWork = TRUE)))
# Note: this demonstrates how to keep a file in ./inst/extdata and properly
#       access it after the package has been installed
#
# ==== END SETUP AND PREPARE ===================================================

test_that("corrupt input generates errors",  {
  expect_error(lseq())
  expect_error(lseq(0,10), "'from' must be a finite number")
  expect_error(lseq(10,0), "'to' must be a finite number")
})

test_that("a sample input produces the expected output",  {
  expect_equal(lseq(1,10, length.out = 5), tmp)
})


# ==== BEGIN TEARDOWN AND RESTORE ==============================================
# Remove every persistent construct that the test has created, except for
# stuff in tempdir().
#
# ==== END  TEARDOWN AND RESTORE ===============================================

# [END]
