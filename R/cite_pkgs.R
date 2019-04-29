#' Cite Used Packages
#'
#' @return A tbl
#' @export
#' @importFrom sessioninfo session_info
#' @importFrom magrittr extract2
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

  text_cite <- function(package) {
    utils::citation(package = package) %>%
      unclass %>%
      magrittr::extract2(1) %>%
      attr("textVersion") %>%
      trimws()
  }

  tibble::as_tibble(sess$packages) %>%
    dplyr::filter(attached, source != "local") %>%
    dplyr::select(Package = package, Version = loadedversion, Source = source) %>%
    dplyr::mutate(Attribution = purrr::map_chr(Package, text_cite))
}
