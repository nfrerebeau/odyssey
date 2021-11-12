\dontrun{
library(magrittr)

## Simple search
topic <- list("archéologie", "Celtes", "France") # Combined with AND
hal_api() %>%
  hal_query(topic) %>%
  hal_search(limit = 10)

## Get a list of archaeological journals
topic <- c("archéologie", "archaeology", "archäologie") # Combined with OR
hal_api() %>%
  hal_query(topic) %>%
  hal_select("title_s", "issn_s") %>%
  hal_filter("" %TO% "*" %IN% "issn_s") %>%
  hal_sort("title_s") %>%
  hal_search(path = "ref/journal")

## Get the most recent archaeological publication (in French) by journal
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

## Get a list of archaeological laboratories
## (only joint laboratories of the CNRS and a French university)
topic <- list("archéologie" %IN% "text", "UMR" %IN% "code_t")
hal_api() %>%
  hal_query(topic) %>%
  hal_select("name_s", "acronym_s", "code_s") %>%
  hal_filter("VALID" %IN% "valid_s") %>%
  hal_sort("acronym_s", decreasing = TRUE) %>%
  hal_search(path = "ref/structure", limit = 15)
}
