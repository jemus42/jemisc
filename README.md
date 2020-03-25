
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jemisc

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/jemisc)](https://CRAN.R-project.org/package=jemisc)
[![R build
status](https://github.com/jemus42/jemisc/workflows/R-CMD-check/badge.svg)](https://github.com/jemus42/jemisc/actions)
<!-- badges: end -->

This is just a personal package for various, i.e. *misc* things.

## Installation

You can install the current version of jemisc from GitHub with:

``` r
remotes::install_github("jemus42/jemisc")
```

…but there’s no reason to, really.

## Example

``` r
library(rmarkdown)
library(knitr)
library(jemisc)

cite_loaded_pkgs() %>%
  kable()
```

| Package   | Version | Source         | Attribution                                                                                                                                                                                                                                                                        |
| :-------- | :------ | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| knitr     | 1.28    | CRAN (R 3.6.2) | Yihui Xie (2020). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.28.                                                                                                                                                                     |
| rmarkdown | 2.1     | CRAN (R 3.6.0) | JJ Allaire and Yihui Xie and Jonathan McPherson and Javier Luraschi and Kevin Ushey and Aron Atkins and Hadley Wickham and Joe Cheng and Winston Chang and Richard Iannone (2020). rmarkdown: Dynamic Documents for R. R package version 2.1. URL <https://rmarkdown.rstudio.com>. |
