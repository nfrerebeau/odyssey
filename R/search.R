# SEARCH
#' @include AllGenerics.R
NULL

#' @rdname search
#' @export
hal_count.HALQuery <- function(x, path = "search", ...) {
  # Set parameters
  x$rows <- 0

  # Set search path
  hal_endpoint$path <- path

  hal_docs <- hal_endpoint$search(params = x)
  attr(hal_docs,"numFound")
}

#' @rdname search
#' @export
hal_search.HALQuery <- function(x, path = "search", limit = 30,
                                start = 0, cursor = FALSE, type = "df",
                                progress = getOption("odyssey.progress"), ...) {
  # Set parameters
  x$rows <- ifelse(limit > 10000, 10000, limit)

  if (cursor) {
    # Pagination of results
    x$sort <- "docid asc"
    x$cursorMark <- mark <- "*"
    # Get documents from HAL
    end <- FALSE
    hal_docs <- list()
    while (!end) {
      old_mark <- mark
      hal_temp <- hal_get(x, path = path, type = type, progress = progress)
      hal_docs <- c(hal_docs, hal_temp)
      mark <- attr(hal_temp,"nextCursorMark")
      end <- identical(mark, old_mark)
    }
  } else {
    # Pagination of results
    x$start <- start
    # Get documents from HAL
    hal_docs <- hal_get(x, path = path, type = type, progress = progress)
  }

  hal_docs
}

hal_get <- function(x, path, type = "df", progress = TRUE) {
  # Progress bar
  bar <- if (progress && interactive()) httr::progress() else NULL
  # Search
  hal_endpoint$path <- path
  if (is.null(x$group) || x$group == "false") {
    hal_endpoint$search(params = x, parsetype = type, progress = bar)
  } else if (x$group == "true") {
    hal_endpoint$group(params = x, parsetype = type, progress = bar)
  } else {
    stop("Don't know what to do...", call. = FALSE)
  }
}
