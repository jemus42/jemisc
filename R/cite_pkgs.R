#' Cite Used Packages
#'
#' @return A tbl
#' @export
#'
#' @examples
#' cite_loaded_pkgs()
cite_loaded_pkgs <- function() {
  sess <- devtools::session_info()

  text_cite <- function(Package) {
    citation(package = Package) %>%
      unclass %>%
      magrittr::extract2(1) %>%
      attr("textVersion") %>%
      trimws()
  }

  sess$packages %>% unclass %>% as.data.frame %>%
    magrittr::set_names(c("Package", "Loaded", "Version", "Date", "Source")) %>%
    dplyr::filter(Loaded == "*", Source != "local") %>%
    dplyr::select(-Loaded) %>%
    dplyr::mutate(Attribution = purrr::map_chr(Package, text_cite))
}
