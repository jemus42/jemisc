#' Get a color palette from a coolors.co URL
#'
#' @param url The link to a coolors.co palette, e.g.
#' `"https://coolors.co/29adb2-182326-2a3a3f-69818c-8ea4b2"`
#' @note It's only the URL that's parsed, there's no need for an internet connection.
#' @return `character(5)` with RGB color codes, e.g.
#' `c("#29adb2", "#182326", "#2a3a3f", "#69818c", "#8ea4b2")` for the example `url`.
#' @importFrom stringr str_extract_all str_pad
#' @export
#' @examples
#' coolors_pal("https://coolors.co/29adb2-182326-2a3a3f-69818c-8ea4b2")
coolors_pal <- function(url) {
  url %>%
    str_extract_all("([a-f0-9]){6}", simplify = TRUE) %>%
    str_pad(7, "left", "#")
}
