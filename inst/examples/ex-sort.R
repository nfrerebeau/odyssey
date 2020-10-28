library(magrittr)

## Select fields
hal1 <- hal_api() %>% hal_sort("docid")
hal1$sort

## Update query
hal2 <- hal_sort(hal1, "producedDate_tdate", decreasing = TRUE)
hal2$sort
