
<!-- README.md is generated from README.Rmd. Please edit that file -->

# odyssey

<!-- badges: start -->

[![R-CMD-check](https://github.com/nfrerebeau/odyssey/workflows/R-CMD-check/badge.svg)](https://github.com/nfrerebeau/odyssey/actions)
[![codecov](https://codecov.io/gh/nfrerebeau/odyssey/branch/master/graph/badge.svg)](https://codecov.io/gh/nfrerebeau/odyssey)

<a href="https://nfrerebeau.r-universe.dev" class="pkgdown-devel"><img
src="https://nfrerebeau.r-universe.dev/badges/odyssey"
alt="r-universe" /></a>

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
<!-- badges: end -->

Access data and download documents from the [Open Archive
HAL](https://hal.archives-ouvertes.fr/). This package provides a
programmatic access to the [HAL
API](https://api.archives-ouvertes.fr/docs).

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("nfrerebeau/odyssey")
```

## Usage

The use of **odyssey** involves three steps. First, a standard query is
created using `hal_api()`. Then, a set of functions allows to customize
this query (see below). Finally, `hal_search()` and `hal_download()`
allow to collect data and to download documents.

The following functions allow you to customize a query. They must be
applied to the object returned by `hal_api()` and can be called in any
order. `hal_filter` can be used several times to add multiple search
filters. See the HAL search API documentation for a [list of available
fields](https://api.archives-ouvertes.fr/docs/search/?schema=fields#fields).

-   `hal_query()` allows to choose the fields to query and to define the
    query terms using boolean logic (`q` parameter). For a simple
    search, grouping terms in a list allows to combine them with AND,
    while grouping terms in a vector allows to combine all the terms
    with OR. If needed, the infix functions `%AND%`, `%OR%`, `%NOT%`,
    `%IN%`, `%TO%` allow to build more complex queries (remember that
    infix operators are composed left to right).
-   `hal_select()` is used to select the fields to be returned in the
    results (`fl` parameter).
-   `hal_filter()` is used to [retain all results that satisfy a
    conditions](https://api.archives-ouvertes.fr/docs/search/?#fq) (`fq`
    parameter).
-   `hal_sort()` [orders the
    results](https://api.archives-ouvertes.fr/docs/search/?#sort) by the
    value of the select field (`sort` parameter). According to the HAL
    API documentation, you should avoid text fields and multi-valued
    fields which will produce unpredictable results.
-   `hal_group()` is used to [group search
    results](https://api.archives-ouvertes.fr/docs/search/?#group)
    (`group.*` parameters).
-   `hal_facet()` is used to [facet search
    results](https://api.archives-ouvertes.fr/docs/search/?#facet)
    (`facet.*` parameters).

``` r
## Load packages
library(odyssey)
library(magrittr) # pipes
```

Get the 10 most recent documents about archaeology of Celts in France:

``` r
## Topic selection
## Will be combined with AND
topic <- list("archéologie", "Celtes", "France")

## Search publications
hal_api() %>%
  hal_query(topic) %>%
  hal_select("title_s", "producedDate_tdate") %>%
  hal_filter("notice" %IN% "submitType_s") %>% 
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_search(limit = 10)
#> 10 documents out of a maximum of 55 were returned.
#> # A tibble: 10 × 2
#>    title_s                                                      producedDate_td…
#>    <chr>                                                        <chr>           
#>  1 Du contenu et de l’apparence                                 2021-01-01T00:0…
#>  2 L'or des Gaulois                                             2019-09-01T00:0…
#>  3 Les établissements de hauteur fortifiés en France (XXII<sup… 2019-05-29T00:0…
#>  4 Une autre ‘note auxerroise’. La statuette étrusque d’Appoig… 2019-01-01T00:0…
#>  5 Archaeological continuum around the sanctuary of Mars Mullo  2018-06-04T00:0…
#>  6 Vaisselle de tous les jours et vaisselle de banquet : produ… 2018-01-01T00:0…
#>  7 Études géoarchéologiques et archéobotaniques du comblement … 2017-03-23T00:0…
#>  8 Production et proto-industrialisation aux Âges du fer : per… 2017-01-01T00:0…
#>  9 De l’Égée à la Gaule, aux sources de la monnaie d’or celte … 2017-01-01T00:0…
#> 10 Comparison between thermal airborne remote sensing, multi-d… 2016-01-01T00:0…
```

Get the most recent archaeological publication (in French) by journal:

``` r
hal_api() %>%
  hal_query("archéologie") %>%
  hal_select("producedDate_tdate") %>%
  hal_filter("ART" %IN% "docType_s") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_group(
    field = "journalTitle_s",
    sort = "producedDate_tdate", 
    decreasing = TRUE
  ) %>%
  hal_search(limit = 10)
#> 
#>                                     groupValue numFound start
#> 1                                  Vita Latina        5     0
#> 2                  Revue d'histoire des textes        3     0
#> 3  Archaeological and Anthropological Sciences       20     0
#> 4   Journal of Archaeological Science: Reports       93     0
#> 5                        Earth-Science Reviews        2     0
#> 6                         Bulletin de l'AMARAI       29     0
#> 7   Revue Archéologique du Centre de la France       56     0
#> 8                                Data in Brief        3     0
#> 9            Journal of Archaeological Science       86     0
#> 10             Archaeological Research in Asia        2     0
#>      producedDate_tdate
#> 1  2023-01-01T00:00:00Z
#> 2  2023-01-01T00:00:00Z
#> 3  2022-04-01T00:00:00Z
#> 4  2022-04-01T00:00:00Z
#> 5  2022-04-01T00:00:00Z
#> 6  2022-03-14T00:00:00Z
#> 7  2022-03-08T00:00:00Z
#> 8  2022-03-03T00:00:00Z
#> 9  2022-03-01T00:00:00Z
#> 10 2022-03-01T00:00:00Z
```

## Code of Conduct

Please note that the **odyssey** project is released with a [Contributor
Code of
Conduct](https://contributor-covenant.org/version/2/0/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
