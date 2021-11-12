test_that("empty query can be created", {
  q <- list(
    q = "*:*",
    fl = c("docid", "label_s"),
    fq = NULL,
    sort = NULL,
    rows = 30L,
    start = 0L,
    wt = "json"
  )
  class(q) <- c("list", "HALQuery")
  expect_identical(hal_api(), q)
})
