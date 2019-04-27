#' Export installed packages for somehwat functional reinstallation
#'
#' @export
#'
#' @examples
#' \dontrun{
#' pkg_export()
#' }
pkg_export <- function() {
  pkgs  <- installed.packages(lib.loc = .libPaths()[[1]]) # Get packages

  pkgs_vec <- rownames(pkgs)
  scrpt <- glue::glue("if (!('[pkgs_vec]' %in% installed.packages())) ",
                      "install.packages('[pkgs_vec]')",
                      .open = "[", .close = "]") # Assemble script

  saveRDS(pkgs, "pkgs.rds")
  writeLines(scrpt, con = "pkg-reimport.R")
}
