
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jemisc

This is a personal package for various, i.e. *misc* things.

## Installation

You can install the current version of jemisc from GitHub with:

``` r
remotes::install_github("jemus42/jemisc")
```

## Example

``` r
library(rmarkdown)
library(knitr)
library(jemisc)

cite_loaded_pkgs() %>%
  kable()
```

| Package   | Version | Source         | Attribution                                                                                                                                                                                                                                                                         |
| :-------- | :------ | :------------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| knitr     | 1.22    | CRAN (R 3.5.2) | Yihui Xie (2019). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.22.                                                                                                                                                                      |
| rmarkdown | 1.12    | CRAN (R 3.5.2) | JJ Allaire and Yihui Xie and Jonathan McPherson and Javier Luraschi and Kevin Ushey and Aron Atkins and Hadley Wickham and Joe Cheng and Winston Chang and Richard Iannone (2019). rmarkdown: Dynamic Documents for R. R package version 1.12. URL <https://rmarkdown.rstudio.com>. |
