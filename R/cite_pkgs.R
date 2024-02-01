#' Cite Used Packages
#'
#' @return A tbl
#' @export
#' @importFrom sessioninfo session_info
#' @importFrom utils citation
#' @importFrom dplyr filter
#' @importFrom dplyr select
#' @importFrom dplyr mutate
#' @importFrom purrr map_chr
#' @examples
#' cite_loaded_pkgs()
cite_loaded_pkgs <- function() {

  Loaded <- Source <- Package <- NULL

  sess <- sessioninfo::session_info()

  bibtexify <- function(package) {
    cit <- utils::citation(package = package)

    bibtex <- toBibtex(cit)

    paste0(as.character(bibtex), collapse = "\n")

  }

  tibble::as_tibble(sess$packages) |>
    dplyr::filter(attached, source != "local") |>
    dplyr::select(Package = package, Version = loadedversion, Source = source) |>
    dplyr::mutate(
      bibtex = purrr::map_chr(Package, bibtexify)
    )
}
