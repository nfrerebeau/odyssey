test_that("grouping terms works", {
  expect_identical(build_query(c("A", "B")), "(A OR B)")
  expect_identical(build_query(list("A", "B")), "(A AND B)")
})
test_that("infix operators work", {
  expect_identical("A" %OR% "B", "A OR B")
  expect_identical("A" %AND% "B", "A AND B")

  a <- "Paris" %AND% "France" %AND% "history"
  b <- list("Texas", "history")
  z <- "Paris AND France AND history NOT (Texas AND history)"
  expect_identical(a %NOT% b, z)

  expect_identical("aluminium" %BY% 1, "aluminium~1")
  expect_identical(c("aluminium", "fer") %BY% 3, '"aluminium fer"~3')

  expect_identical(c("japon", "france") %IN% "title_t", "title_t:(japon OR france)")
  expect_identical("Aa" %TO% "Ab" %IN% "city_s", "city_s:[Aa TO Ab]")
  expect_identical(2000 %TO% 2013, "[2000 TO 2013]")
  expect_identical("" %TO% "", '["" TO *]')
})
test_that("query", {
  api <- hal_api()

  hal1 <- hal_query(api, "asie")
  expect_identical(hal1$q, "asie")

  term <- list("japon", "france")
  hal2 <- hal_query(api, term, field = "title_t")
  expect_identical(hal2$q, "title_t:(japon AND france)")

  hal4 <- hal_query(hal1, "agricol?")
  expect_identical(hal4$q, "agricol?")
})
test_that("select", {
  api <- hal_api()

  hal1 <- hal_select(api, "halId_s", "uri_s")
  expect_identical(hal1$fl, c("halId_s", "uri_s"))

  hal2 <- hal_select(hal1, "docType_s")
  expect_identical(hal2$fl, "docType_s")
})
test_that("filter", {
  api <- hal_api()

  hal1 <- hal_filter(api, "file" %IN% "submitType_s")
  expect_identical(hal1$fq, "submitType_s:file")

  hal2 <- hal_filter(api, c("THESE", "HDR"), "docType_s")
  expect_identical(hal2$fq, "docType_s:(THESE OR HDR)")

  h <- hal_filter(api, "[NOW-1MONTHS/DAY TO NOW/HOUR]", "submittedDate_tdate")
  hal3 <- hal_filter(h, "-notice", "submitType_s")
  expect_identical(hal3$fq, c("submittedDate_tdate:[NOW-1MONTHS/DAY TO NOW/HOUR]",
                              "submitType_s:-notice"))

  hal4 <- hal_filter(api, "[2000 TO 2013]", "submittedDateY_i")
  expect_identical(hal4$fq, "submittedDateY_i:[2000 TO 2013]")

  hal5 <- hal_filter(api, "[Aa TO Ab]", "city_s")
  expect_identical(hal5$fq, "city_s:[Aa TO Ab]")
})
test_that("sort", {
  api <- hal_api()

  hal1 <- hal_sort(api, "docid")
  expect_identical(hal1$sort, "docid asc")

  ## Update query
  hal2 <- hal_sort(hal1, "producedDate_tdate", decreasing = TRUE)
  expect_identical(hal2$sort, "producedDate_tdate desc")
})
