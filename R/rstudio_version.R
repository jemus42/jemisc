#' Get Current RStudio Version
#'
#' @return A `character` of length 1
#' @export
#' @examples
#' \dontrun{
#' rs_version()
#' }
rs_version <- function() {
  .rs.api.versionInfo()$version
}

#' Get Current RStudio Daily Version
#'
#' @return A `character` of length 1
#' @export
#' @importFrom xml2 read_html
#' @importFrom rvest html_node
#' @importFrom rvest html_attr
#' @importFrom stringr str_extract
#' @examples
#' rs_daily()
rs_daily <- function() {
  xml2::read_html("https://dailies.rstudio.com") %>%
    rvest::html_node("#ql-rstudio-oss-mac") %>%
    rvest::html_attr("href") %>%
    stringr::str_extract("\\d\\.\\d\\.\\d+") %>% as.package_version()
}
