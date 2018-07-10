
<!-- README.md is generated from README.Rmd. Please edit that file -->

# jemisc

This is a personal package for various, i.e. *misc* things.

## Installation

You can install the released version of jemisc from GitHub with:

``` r
remotes::install_github("jemus42/jemisc")
```

## Example

``` r
library(dplyr)
library(ggplot2)
library(rmarkdown)
library(knitr)

library(jemisc)
cite_loaded_pkgs() %>%
  kable()
```

| Package   | Version | Date       | Source         | Attribution                                                                                                                                                                                                                                          |
| :-------- | :------ | :--------- | :------------- | :--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| dplyr     | 0.7.6   | 2018-06-29 | CRAN (R 3.5.1) | Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2018). dplyr: A Grammar of Data Manipulation. R package version 0.7.6. <https://CRAN.R-project.org/package=dplyr>                                                                   |
| ggplot2   | 3.0.0   | 2018-07-03 | CRAN (R 3.5.0) | H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.                                                                                                                                                             |
| knitr     | 1.20    | 2018-02-20 | CRAN (R 3.5.0) | Yihui Xie (2018). knitr: A General-Purpose Package for Dynamic Report Generation in R. R package version 1.20.                                                                                                                                       |
| rmarkdown | 1.10    | 2018-06-11 | CRAN (R 3.5.0) | JJ Allaire, Yihui Xie, Jonathan McPherson, Javier Luraschi, Kevin Ushey, Aron Atkins, Hadley Wickham, Joe Cheng and Winston Chang (2018). rmarkdown: Dynamic Documents for R. R package version 1.10. <https://CRAN.R-project.org/package=rmarkdown> |
