library(magrittr)

## Simple filer
hal1 <- hal_api() %>% hal_filter("file", "submitType_s")
hal1$fq

## Advanced filter
hal2 <- hal_api() %>% hal_filter(c("THESE", "HDR"), "docType_s")
hal2$fq

## Multiple filters
hal3 <- hal_api() %>%
  hal_filter("[NOW-1MONTHS/DAY TO NOW/HOUR]", "submittedDate_tdate") %>%
  hal_filter("-notice", "submitType_s")
hal3$fq

## Range filters
hal4 <- hal_api() %>% hal_filter("[2000 TO 2013]", "submittedDateY_i")
hal4$fq

hal5 <- hal_api() %>% hal_filter("[Aa TO Ab]", "city_s")
hal5$fq
