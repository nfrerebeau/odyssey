\dontrun{
library(magrittr)

## Most recent publication by journal
hal_api() %>%
  hal_query("archéologie") %>%
  hal_group(field = "journalTitle_s", limit = 1,
            sort = "producedDate_tdate", decreasing = TRUE) %>%
  hal_select("producedDate_tdate", "score") %>%
  hal_filter("docType_s", "ART") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_search(limit = 10)
}
