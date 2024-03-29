\dontrun{
library(magrittr)

## Most recent publication by journal
hal_api() %>%
  hal_query("archéologie") %>%
  hal_select("producedDate_tdate") %>%
  hal_filter("ART" %IN% "docType_s") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_group(field = "journalTitle_s", limit = 1,
            sort = "producedDate_tdate", decreasing = TRUE) %>%
  hal_search(limit = 10)
}
