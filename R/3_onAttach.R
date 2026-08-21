#' @import data.table ggplot2
.onAttach <- function(libname, pkgname) {
  version <- tryCatch(
    utils::packageDescription("csutil", fields = "Version"),
    warning = function(w) {
      1
    }
  )

  packageStartupMessage(paste0(
    "csutil ",
    version,
    "\n",
    "https://niphr.github.io/csutil/"
  ))
}
