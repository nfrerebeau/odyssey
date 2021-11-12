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
                                start = 0, cursor = FALSE,
                                parse = "df", concat = ",",
                                progress = getOption("odyssey.progress"),
                                verbose = getOption("odyssey.verbose"), ...) {
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
      x$cursorMark <- old_mark <- mark # Update cursor
      hal_temp <- hal_get(x, path = path, parse = parse, concat = concat,
                          progress = progress)
      if (parse == "df") hal_docs <- rbind(hal_docs, hal_temp)
      else hal_docs <- c(hal_docs, hal_temp)
      mark <- attr(hal_temp, "nextCursorMark") # Get new cursor
      end <- identical(mark, old_mark) # Compare cursors

      if (verbose) message(sprintf("Cursor mark: %s", mark))
    }
  } else {
    # Pagination of results
    x$start <- start
    # Get documents from HAL
    hal_docs <- hal_get(x, path = path, parse = parse, concat = concat,
                        progress = progress)
  }

  if (verbose) {
    n_max <- attr(hal_docs,"numFound")
    n_limit <- ifelse(limit > n_max, n_max, limit)
    message(
      sprintf("%d documents out of a maximum of %s were returned.",
              n_limit, n_max)
    )
  }

  hal_docs
}

hal_get <- function(x, path, parse = "df", concat = ",", raw = FALSE,
                    progress = getOption("odyssey.progress")) {
  # Progress bar
  bar <- if (progress) httr::progress() else NULL

  # Search
  no_facet <- is.null(x$facet) || x$facet == "false"
  no_group <- is.null(x$group) || x$group == "false"

  hal_endpoint$path <- path
  if (no_group && no_facet) {
    hal_do <- hal_endpoint$search
  } else if (no_group && !no_facet) {
    parse <- "list"
    hal_do <- hal_endpoint$facet
  } else if (!no_group && no_facet) {
    hal_do <- hal_endpoint$group
  } else {
    stop("Don't know what to do...", call. = FALSE)
  }

  hal_params <- list(params = x, parsetype = parse, concat = concat,
                     progress = bar, raw = raw)
  do.call(hal_do, hal_params)
}
