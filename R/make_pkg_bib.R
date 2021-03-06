#' Create a .bib for Your Installed Packages
#'
#' @param output Location of the output `.bib`.
#' @param fresh Whether to overwrite `output`.
#'
#' @return Nothing
#' @export
#' @importFrom tibble as_tibble
#' @importFrom utils installed.packages
#' @importFrom utils toBibtex
#' @importFrom stringr str_replace
#' @examples
#' \dontrun{
#' make_pkg_bib(output = "~/packages.bib")
#' }
make_pkg_bib <- function(output = "~/Documents/BibTex/rstats.bib", fresh = TRUE) {

  if (fresh) file.remove(output)

  pkgs <- tibble::as_tibble(utils::installed.packages())$Package

  for (p in pkgs) {
    entry <- utils::toBibtex(utils::citation(p))
    entry <- stringr::str_replace(entry, pattern = "\\{,", paste0("{r_", p, ","))
    readr::write_lines(entry, path = output, append = TRUE)
  }
}
