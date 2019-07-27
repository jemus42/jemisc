#' Roll some d6 for Shadowrun
#'
#' @param n Number of d6 to roll
#'
#' @return A `list` of additional class `"sr_d6"`.
#' @export
#'
#' @examples
#' sr_d6(10)
sr_d6 <- function(n) {
  throw <- sort(sample(1:6, size = n, replace = TRUE))

  glitches <- sum(throw == 1)
  successes <- sum(throw >= 5)

  ret <- list(n = n, throw = throw, glitches = glitches, successes = successes)
  class(ret) <- c("sr_d6", "list")
  ret
}

#' Colorize a diceroll
#'
#' @param throw Integer vector, like `sr_d6(5)$throw`
#' @param collapse Logical. Whether to concatenate the integers.
#'
#' @return Integer vector or `character(1)` depending on `collapse`.
#' @keywords internal
#' @import cli
colorize_d6 <- function(throw, collapse = TRUE) {
  res <- ifelse(
    throw == 1,
    cli::bg_red(throw),
    ifelse(
      throw >= 5,
      cli::bg_green(throw),
      cli::bg_black(cli::col_grey(throw))
    )
  )

  if (collapse) {
    res <- paste(res, collapse = ' ')
  }

  res
}

#' Print diceroll
#'
#' @param x Object of class `sr_d6`, like from [sr_d6].
#' @param ... Ignored
#'
#' @return Nothing
#' @export
#' @import cli
#' @importFrom glue glue
#' @examples
#' sr_d6(5)
print.sr_d6 <- function(x, ...) {
  warns <- col_black(bg_red(style_bold(paste0(rep(symbol$warning, 3), collapse = ""))))
  fail_indicator <- ifelse(x$glitches > x$n/2, warns, "     ")

  cat(glue::glue(
    "{style_underline(style_bold(col_cyan(x$n)), 'd6')} \\
    {symbol$pointer} {colorize_d6(x$throw, TRUE)}
    {fail_indicator} --- {style_bold(x$glitches)} {col_red(symbol$checkbox_circle_on)} - \\
    {style_bold(x$successes)} {col_green(symbol$tick)} ---"
  ))
}
