
<!-- README.md is generated from README.Rmd. Please edit that file -->

# odyssey

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
<!-- badges: end -->

Access references and download documents from the [Open Archive
HAL](https://hal.archives-ouvertes.fr/) using the [search
API](https://api.archives-ouvertes.fr/docs/search/).

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

### HAL Search

``` r
## Topic selection
## Will be combined with AND
topic <- list("archéologie", "Celtes", "France")

## Search publications
hal_api() %>%
  hal_query(topic) %>%
  hal_select("title_s", "producedDate_tdate", "submitType_s") %>%
  hal_filter("submitType_s", "notice") %>% 
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_search(limit = 10)
#> # A tibble: 10 x 3
#>    title_s                                       submitType_s producedDate_tdate
#>    <chr>                                         <chr>        <chr>             
#>  1 "L'or des Gaulois"                            notice       2019-09-01T00:00:…
#>  2 "Les établissements de hauteur fortifiés en … notice       2019-05-29T00:00:…
#>  3 "Une autre ‘note auxerroise’. La statuette é… notice       2019-01-01T00:00:…
#>  4 "Archaeological continuum around the sanctua… notice       2018-06-04T00:00:…
#>  5 "Vaisselle de tous les jours et vaisselle de… notice       2018-01-01T00:00:…
#>  6 "“Déesses-Mères” et “Vénus” chez les Celtes … notice       2017-09-01T00:00:…
#>  7 "Études géoarchéologiques et archéobotanique… notice       2017-03-23T00:00:…
#>  8 "Production et proto-industrialisation aux Â… notice       2017-01-01T00:00:…
#>  9 "Comparison between thermal airborne remote … notice       2016-01-01T00:00:…
#> 10 "Première campagne de fouilles franco-italie… notice       2015-01-01T00:00:…
```

Get the most recent archaeological publication (in French) by journal:

``` r
hal_api() %>%
  hal_query("archéologie") %>%
  hal_select("producedDate_tdate") %>%
  hal_filter("docType_s", "ART") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_group(field = "journalTitle_s", sort = "producedDate_tdate", 
            decreasing = TRUE) %>%
  hal_search(limit = 10)
#>                                    groupValue numFound start
#> 1                          Scientific Reports       12     0
#> 2                            Heritage Science        7     0
#> 3      Journal of Anthropological Archaeology       11     0
#> 4               Dialogues d'histoire ancienne       34     0
#> 5                Journal of Roman Archaeology       17     0
#> 6                  Quaternary Science Reviews       30     0
#> 7                           médecine/sciences        2     0
#> 8  Journal of Archaeological Science: Reports       70     0
#> 9                             L'anthropologie       30     0
#> 10                               Archaeometry       34     0
#>      producedDate_tdate
#> 1  2020-12-01T00:00:00Z
#> 2  2020-12-01T00:00:00Z
#> 3  2020-12-01T00:00:00Z
#> 4  2020-10-31T00:00:00Z
#> 5  2020-10-05T00:00:00Z
#> 6  2020-10-01T00:00:00Z
#> 7  2020-10-01T00:00:00Z
#> 8  2020-10-01T00:00:00Z
#> 9  2020-10-01T00:00:00Z
#> 10 2020-09-24T00:00:00Z
```

### HAL Reference Frame

Get a list of archaeological journals:

``` r
## Topic selection
## Will be combined with OR
topic <- c("archéologie", "archaeology", "archäologie")

## Search
hal_api() %>% 
  hal_query(topic) %>% 
  hal_select("title_s", "issn_s") %>%
  hal_filter("issn_s", "[\"\" TO *]") %>%
  hal_sort("title_s") %>%
  hal_search(path = "ref/journal") 
#> # A tibble: 30 x 2
#>    title_s                                                            issn_s   
#>    <chr>                                                              <chr>    
#>  1 ACUA. Underwater Archaeology Proceedings                           1074-3421
#>  2 ADLFI. Archéologie de la France - Informations [En ligne]          2114-0502
#>  3 AIMA Newsletter                                                    1446-8948
#>  4 Afrique : archéologie et arts                                      1634-3123
#>  5 Afrique: Archéologie & Arts                                        2431-2045
#>  6 Agri centuriati. An International Journal of Landscape Archaeology 1825-1277
#>  7 Americae. European Journal of Americanist Archaeology              2497-1510
#>  8 American Antiquity                                                 0002-7316
#>  9 American Journal of Archaeology                                    0002-9114
#> 10 Anglo-Saxon Studies in Archaeology and History                     02645254 
#> # … with 20 more rows
```

Get a list of archaeological laboratories (only joint laboratories of
the CNRS and a French university):

``` r
## Topic selection
topic <- list("archéologie" %IN% "text", "UMR" %IN% "code_t")

## Search
hal_api() %>% 
  hal_query(topic) %>% 
  hal_select("name_s", "acronym_s", "code_s") %>%
  hal_filter("valid_s", "VALID") %>%
  hal_sort("acronym_s", decreasing = TRUE) %>%
  hal_search(path = "ref/structure", limit = 15) 
#> # A tibble: 15 x 3
#>    name_s                                             acronym_s code_s          
#>    <chr>                                              <chr>     <chr>           
#>  1 ORIENT ET MÉDITERRANÉE : Textes, Archéologie, His… OM        UMR8167         
#>  2 Laboratoire Archéologie et Territoires             LAT       UMR6575         
#>  3 Laboratoire d'Archéologie Moléculaire et Structur… LAMS      UMR8220         
#>  4 Laboratoire de Médiévistique Occidentale de Paris  LAMOP     UMR8589         
#>  5 Laboratoire d'Archéologie Médiévale et Moderne en… LA3M      UMR7298         
#>  6 Histoire Archéologie Littérature des Mondes Ancie… HALMA     UMR8164         
#>  7 Centre de Recherche en Archéologie, Archéoscience… CReAAH    EA,EA,UMR6566   
#>  8 Histoire, Archéologie et Littératures des mondes … CIHAM     UMR5648         
#>  9 Centre Camille Jullian - Histoire et archéologie … CCJ       UMR7299,UMR7299…
#> 10 Archéologie des Amériques                          ArchAm    UMR8096         
#> 11 Archéologie et Archéométrie                        ArAr      UMR5138         
#> 12 Archéologie des Sociétés Méditerranéennes          ASM       UMR5140         
#> 13 Archéologie, Terre, Histoire, Sociétés [Dijon]     ARTeHiS   UMR6298         
#> 14 Archéologie et histoire ancienne : Méditerranée -… ARCHIMEDE UMR7044         
#> 15 Archéologie et Philologie d'Orient et d'Occident   AOROC     UMR8546
```

## Contributing

Please note that the **odyssey** project is released with a [Contributor
Code of
Conduct](https://github.com/nfrerebeau/odyssey/blob/master/.github/CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.
