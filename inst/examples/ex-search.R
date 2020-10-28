\dontrun{
library(magrittr)

## Simple search
topic <- c("japon", "france")
hal_api() %>%
  hal_query(topic, field = "title_t") %>%
  hal_search(limit = 10)

## Advanced search
topic1  <- c("dementia", "vascular", "alzheimer's") # Combined with OR
topic2  <- c("lipids", "statins", "cholesterol")    # Combined with OR
topic <- list(topic1, topic2)                       # Combined with AND
hal_api() %>%
  hal_query(topic, field = "title_t") %>%
  hal_search(limit = 10)

## More complex search
topic <- c("japon", "france")
hal_api() %>%
  hal_query(topic, field = "title_t") %>%
  hal_select("label_s", "submittedDate_tdate", "submitType_s") %>%
  hal_sort("producedDate_tdate", decreasing = TRUE) %>%
  hal_filter("submittedDate_tdate", "[NOW-1MONTHS/DAY TO NOW/HOUR]") %>%
  hal_search(limit = 10)
}
