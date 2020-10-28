library(magrittr)

## Select fields
hal1 <- hal_api() %>% hal_select("label_s")
hal1$fl

hal2 <- hal_api() %>% hal_select("halId_s", "uri_s")
hal2$fl

## Update query
hal3 <- hal_select(hal1, "docType_s")
hal3$fl
