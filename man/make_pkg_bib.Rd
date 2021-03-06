% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/make_pkg_bib.R
\name{make_pkg_bib}
\alias{make_pkg_bib}
\title{Create a .bib for Your Installed Packages}
\usage{
make_pkg_bib(output = "~/Documents/BibTex/rstats.bib", fresh = TRUE)
}
\arguments{
\item{output}{Location of the output \code{.bib}.}

\item{fresh}{Whether to overwrite \code{output}.}
}
\value{
Nothing
}
\description{
Create a .bib for Your Installed Packages
}
\examples{
\dontrun{
make_pkg_bib(output = "~/packages.bib")
}
}
