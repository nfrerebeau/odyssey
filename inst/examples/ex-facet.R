\donttest{
library(magrittr)

## Most recent publication by journal
hal_api() %>%
  hal_query("archéologie") %>%
  hal_facet(
    field = "docType_s",
    limit = 100,
    sort = "count",
    range = list(
      range = "producedDateY_i",
      start = 2000,
      end = 2020,
      gap = 1
    )
  ) %>%
  hal_search(limit = 10)
}
