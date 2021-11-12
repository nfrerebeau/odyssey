\dontrun{
library(magrittr)

## Download the 10 most recent archaeological publication
## (if any files)
hal_api() %>%
  hal_query("archéologie") %>%
  hal_filter("ART" %IN% "docType_s") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_download(limit = 10)
}
