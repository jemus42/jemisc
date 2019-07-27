#' Tabularize tidily
#'
#' Use [janitor::tabyl] and various `adorn_`-functions to create a tidy crosstab.
#' @param data A `data.frame`.
#' @param x The row-variable
#' @param y The column-variable
#' @param row_name,col_name Passed to [janitor::adorn_title].
#'
#' @return A [janitor::tabyl]
#' @export
#' @import janitor
#' @importFrom rlang enquo
#' @importFrom rlang !!
#' @examples
#' tidyxtab(mtcars, carb, gear)
tidyxtab <- function(data, x, y, row_name = deparse(x), col_name = deparse(y)) {
  x <- enquo(x)
  y <- enquo(y)

  data %>%
    tabyl(!!x, !!y) %>%
    adorn_totals(where = c("row", "col")) %>%
    adorn_percentages(denominator = "all") %>%
    adorn_pct_formatting(rounding = "half up") %>%
    adorn_ns(position = "front") %>%
    adorn_title(row_name = row_name, col_name = col_name)
}
