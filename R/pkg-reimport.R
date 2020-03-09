#' Export installed packages for somehwat functional reinstallation
#'
#' @param old_lib `character`: The location of your previous package library.
#' @export
#' @importFrom tibble as_tibble
#' @importFrom glue glue_data
#' @importFrom dplyr select
#' @importFrom dplyr filter
#' @examples
#' \dontrun{
#' pkg_export()
#' }
pkg_export <- function(old_lib = "~/Library/R/shared_bak/") {
  pak::lib_status(lib = old_lib) %>%
    as_tibble() %>%
    select(package, title, version, repository, remotetype, remoterepo, remoteusername) %>%
    glue_data("if (!'{package}' %in% installed.packages()) remotes::install_cran('{package}')") %>%
    writeLines("cran-reinstall.R")

  pak::lib_status(lib = old_lib) %>%
    as_tibble() %>%
    select(package, title, version, repository, remotetype, remoterepo, remoteusername) %>%
    filter(remotetype == "github") %>%
    glue_data("if (!'{package}' %in% installed.packages()) remotes::install_github('{remoteusername}/{remoterepo}')") %>%
    writeLines("github-reinstall.R")
}

globalVariables(c(
  "package", "title", "version", "repository", "remotetype", "remoterepo",
  "remoteusername"
))
