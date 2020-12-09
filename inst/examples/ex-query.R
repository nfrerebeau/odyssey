library(magrittr)

## Select fields
hal1 <- hal_api() %>% hal_query("asie")
hal1$q

term <- list("japon", "france")
hal2 <- hal_api() %>% hal_query(term, field = "title_t")
hal2$q

term <- list("Journal", c("Histoire", "History"))
hal3 <- hal_api() %>% hal_query(term, field = "title_t")
hal3$q

## Update query
hal4 <- hal_query(hal1, "agricol?")
hal4$q

## Operators
term <- list("Paris", "France", "history") %NOT% list("Texas", "history")
hal5 <- hal_api() %>% hal_query("text" %IN% term)
hal5$q

term <- "title_t" %IN% c("aluminium", "fer") %BY% 3
hal6 <- hal_api() %>% hal_query(term)
hal6$q

term <- list("title_t" %IN% "ecology", "text" %IN% "cell")
hal7 <- hal_api() %>% hal_query(term)
hal7$q
