
<!-- README.md is generated from README.Rmd. Please edit that file -->

# odyssey

<!-- badges: start -->

[![Build
Status](https://travis-ci.org/nfrerebeau/odyssey.svg?branch=master)](https://travis-ci.org/nfrerebeau/odyssey)

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
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

``` r
library(odyssey)
library(magrittr)
```

The use of **odyssey** involves three steps. First, a standard query is
created using `hal_api()`. Then, a set of functions allows to customize
this query (see below). Finally, `hal_search()` and `hal_download()`
allow to collect data and to download documents.

The following functions allow you to customize a query. They must be
applied to the object returned by `hal_api()` and can be called in any
order. `hal_filter` can be used several times to add multiple search
filters. See the HAL search API documentation for a [list of available
fields](https://api.archives-ouvertes.fr/docs/search/?schema=fields#fields).

  - `hal_query()` allows to choose the fields to query and to define the
    query terms using boolean logic (`q` parameter). For a simple
    search, grouping terms in a list allows to combine them with AND,
    while grouping terms in a vector allows to combine all the terms
    with OR. If needed, the infix functions `%AND%`, `%OR%`, `%NOT%`,
    `%IN%`, `%TO%` allow to build more complex queries (remember that
    infix operators are composed left to right).
  - `hal_select()` is used to select the fields to be returned in the
    results (`fl` parameter).
  - `hal_filter()` is used to [retain all results that satisfy a
    conditions](https://api.archives-ouvertes.fr/docs/search/?#fq) (`fq`
    parameter).
  - `hal_sort()` [orders the
    results](https://api.archives-ouvertes.fr/docs/search/?#sort) by the
    value of the select field (`sort` parameter). According to the HAL
    API documentation, you should avoid text fields and multi-valued
    fields which will produce unpredictable results.
  - `hal_group()` is used to [group search
    results](https://api.archives-ouvertes.fr/docs/search/?#group)
    (`group.*` parameters).
  - `hal_facet()` is used to [facet search
    results](https://api.archives-ouvertes.fr/docs/search/?#facet)
    (`facet.*` parameters).

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
#> 10 documents out of a maximum of 52 were returned.
#> # A tibble: 10 x 2
#>    title_s                                                    producedDate_tdate
#>    <chr>                                                      <chr>             
#>  1 "L'or des Gaulois"                                         2019-09-01T00:00:…
#>  2 "Les établissements de hauteur fortifiés en France (XXII<… 2019-05-29T00:00:…
#>  3 "Une autre ‘note auxerroise’. La statuette étrusque d’App… 2019-01-01T00:00:…
#>  4 "Archaeological continuum around the sanctuary of Mars Mu… 2018-06-04T00:00:…
#>  5 "Vaisselle de tous les jours et vaisselle de banquet : pr… 2018-01-01T00:00:…
#>  6 "“Déesses-Mères” et “Vénus” chez les Celtes aux premiers … 2017-09-01T00:00:…
#>  7 "Études géoarchéologiques et archéobotaniques du combleme… 2017-03-23T00:00:…
#>  8 "Production et proto-industrialisation aux Âges du fer : … 2017-01-01T00:00:…
#>  9 "Comparison between thermal airborne remote sensing, mult… 2016-01-01T00:00:…
#> 10 "Les « lacs » des Celtes : évolution paléogéographique et… 2015-01-01T00:00:…
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
#>                                        groupValue numFound start
#> 1                             Ardèche archéologie       52     0
#> 2               Journal of African Earth Sciences        1     0
#> 3  Bulletin de la Société française d'égyptologie       20     0
#> 4      Journal of Archaeological Science: Reports       72     0
#> 5                              Scientific Reports       13     0
#> 6                                Heritage Science        7     0
#> 7    Physics of the Earth and Planetary Interiors        6     0
#> 8          Journal of Anthropological Archaeology       11     0
#> 9   Journal of Data Mining and Digital Humanities        3     0
#> 10       Geoarchaeology: An International Journal        6     0
#>      producedDate_tdate
#> 1  2021-01-01T00:00:00Z
#> 2  2020-12-01T00:00:00Z
#> 3  2020-12-01T00:00:00Z
#> 4  2020-12-01T00:00:00Z
#> 5  2020-12-01T00:00:00Z
#> 6  2020-12-01T00:00:00Z
#> 7  2020-12-01T00:00:00Z
#> 8  2020-12-01T00:00:00Z
#> 9  2020-11-14T00:00:00Z
#> 10 2020-11-12T00:00:00Z
```

## Contributing

Please note that the **odyssey** project is released with a [Contributor
Code of
Conduct](https://github.com/nfrerebeau/odyssey/blob/master/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
