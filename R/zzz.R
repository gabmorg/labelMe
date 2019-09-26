# zzz.R
#
# Package startup and unload functions




.onLoad <- function(libname, pkgname) {

    # # Make list of package parameters and add to global options
    # Example:
    #
    # # filepath of logfile
    # optRpt <- list(rpt.logfile = logFileName() )
    #
    # # add more options ...
    # optRpt[["nameOfOption"]] <- value
    #
    # optionsToSet <- !(names(optRpt) %in% names(options()))
    #
    # if(any(optionsToSet)) {
    #     options(optRpt[optionsToSet])
    # }

    invisible()
}


.onAttach <- function(libname, pkgname) {
#  Startup message
#  This works, but only once per session since there seems to be a bug in
#  RStudio. cf. https://github.com/r-lib/devtools/issues/1442
  m <- sprintf("\nWelcome: this is the %s package.\n", pkgname)
  m <- c(m, sprintf("Author(s):\n  %s\n",
                    utils::packageDescription(pkgname)$Author))
  m <- c(m, sprintf("Maintainer:\n  %s\n",
                    utils::packageDescription(pkgname)$Maintainer))

  packageStartupMessage(paste(m, collapse=""))
}


# .onUnload <- function(libname, pkgname) {
#
# }



# [END]
