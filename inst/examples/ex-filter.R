library(magrittr)

## Simple filer
hal1 <- hal_api() %>% hal_filter("submitType_s", "file")
hal1$fq

## Advanced filter
hal2 <- hal_api() %>% hal_filter("docType_s", c("THESE", "HDR"))
hal2$fq

## Multiple filters
hal3 <- hal_api() %>%
  hal_filter("submittedDate_tdate", "[NOW-1MONTHS/DAY TO NOW/HOUR]") %>%
  hal_filter("submitType_s", "-notice")
hal3$fq

## Range filters
hal4 <- hal_api() %>% hal_filter("submittedDateY_i", "[2000 TO 2013]")
hal4$fq

hal5 <- hal_api() %>% hal_filter("city_s", "[Aa TO Ab]")
hal5$fq
