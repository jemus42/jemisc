#' Render a bunch of small .tex files
#'
#' Use case: A bunch of stuff done in LaTeXiT, resulting in some helper calculations
#' or derivations contained in tex files. These are then rendered to PDF using `tex_fun`, per
#' default [tinytex::xelatex], and then optionally converted to `png` using the system `convert`
#' tool via imagemagick.
#' @param path Folder where `.tex` files are.
#' @param cleanup `TRUE`: Whether to cleanup auxilliary files (e.g. `.aux`, `.log`, ...)
#' @param tex_fun Which function to use, default ist [tinytex::xelatex].
#' @param to_png `TRUE`: Whether to use `convert` to convert PDF to png.
#'
#' @return Nothing
#' @export
#'
#' @examples
#' \dontrun{
#' render_tex_files("formulas")
#' }
render_tex_files <- function(path, cleanup = TRUE, tex_fun = tinytex::xelatex, to_png = TRUE) {
  tex_files <- list.files(path, pattern = ".tex$", full.names = TRUE, recursive = TRUE)
  #lapply(tex_files, tex_fun)

  # Rendering PDFs
  for (texfile in tex_files) {
    pdffile <- sub(".tex", ".pdf", texfile)
    pngfile <- sub(".tex", ".png", texfile)

    pdf_exists <- file.exists(pdffile)
    pdf_old <- if (pdf_exists) file.mtime(texfile) > file.mtime(pdffile) else TRUE

    # Render PDF if tex is newer than PDF
    if (all(!pdf_exists, pdf_old)) {
      cat("Converting ", texfile, " to PDF\n")
      tex_fun(texfile)
    }

    # PDF -> png if requested and PDF is newer than png
    if (to_png) {
      png_exists <- file.exists(pngfile)
      png_old <- if (png_exists) file.mtime(texfile) > file.mtime(pngfile) else TRUE

      if (all(!png_exists, png_old)) {
        cat("Converting ", pdffile, " to png\n")
        command <- paste("convert -density 300 -flatten -colorspace RGB",
                         shQuote(pdffile), shQuote(pngfile))
        cat(command, "\n")
        system(command)
      }
    }
  }

  # Cleanup
  if (cleanup) {
    garbage <- list.files(path, pattern = ".aux$|.fls$|.synctex.gz$|.xdv$|.log$", full.names = TRUE)
    dummy <- file.remove(garbage)
  }
}

#' Print a matrix for LaTeX.
#'
#' @param mat A [matrix].
#' @param type `[character(1): "pmatrix"]`: Matrix environment to use, e.g. `bmatrix` for `[]`-enclosed
#'  (brackets) or `pmatrix` for `()` (parentheses).
#' @param round `[integer(1): 3]`
#'
#' @return Nothing, output is `cat`ed.
#' @export
#'
#' @examples
#' mat <- matrix(1:9, ncol = 3)
#' mattex(mat)
mattex <- function(mat, type = "pmatrix", round = 3) {
  mat <- round(mat, round)
  rows <- seq_len(nrow(mat))
  spaced_rows <- sapply(rows, function(row) {
    row <- mat[row, ]
    paste(row, collapse = " & ")
  })
  matrix_rows <- paste(spaced_rows, collapse = " \\\\ \n ")

  cat(paste0("\\[\\begin{", type, "}\n", matrix_rows, "\n\\end{", type, "}\\]"))
}
