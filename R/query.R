# QUERY
#' @include AllGenerics.R
NULL

# Build query ==================================================================
#' @rdname hal_query
#' @export
hal_query.HALQuery <- function(x, value, field = NULL, ...) {
  term <- build_query(value)
  x$q <- ifelse(is.null(field), term, sprintf("%s:%s", field, term))
  x
}

# Operators --------------------------------------------------------------------
#' @rdname hal_query
#' @export
`%OR%` <- function(x, y) {
  x <- build_query(x)
  y <- build_query(y)
  sprintf("(%s OR %s)", x, y)
}

#' @rdname hal_query
#' @export
`%AND%` <- function(x, y) {
  x <- build_query(x)
  y <- build_query(y)
  sprintf("(%s AND %s)", x, y)
}

#' @rdname hal_query
#' @export
`%NOT%` <- function(x, y) {
  x <- build_query(x)
  y <- build_query(y)
  sprintf("(%s NOT %s)", x, y)
}

#' @rdname hal_query
#' @export
`%BY%` <- function(x, y) {
  x <- paste(x, collapse = " ")
  sprintf("\"%s\"~%s", x, y)
}

#' @rdname hal_query
#' @export
`%IN%` <- function(x, y) {
  x <- build_query(x)
  y <- build_query(y)
  sprintf("%s:%s", x, y)
}

#' @rdname hal_query
#' @export
`%TO%` <- function(x, y) {
  if (x == "" || length(x) == 0 || is.null(x)) x <- "\"\""
  if (y == "" || length(y) == 0 || is.null(y)) y <- "*"
  sprintf("[%s TO %s]", x, y)
}

# Helpers ----------------------------------------------------------------------
build_query <- function(x) {
  if (is.atomic(x)) {
    term <- paste(as.character(x), collapse = " OR ")
    term <- ifelse(length(x) == 1, term, sprintf("(%s)", term))
    return(term)
  } else if (is.recursive(x)) {
    term <- vapply(x, FUN = build_query, FUN.VALUE = character(1))
    term <- paste(term, collapse = " AND ")
    term <- sprintf("(%s)", term)
    return(term)
  } else {
    # TODO: error
  }
}

# Select fields ================================================================
#' @rdname hal_select
#' @export
hal_select.HALQuery <- function(x, ...) {
  fields <- as.character(c(...))
  x$fl <- fields
  x
}

# Filter results ===============================================================
#' @rdname hal_filter
#' @export
hal_filter.HALQuery <- function(x, value, field = NULL, ...) {
  if (!is.null(field)) {
    value <- if (length(value) > 1) build_query(value) else value
    value <- value %IN% field
  }
  x$fq = c(x$fq, value)
  x
}

# Sort results =================================================================
#' @rdname hal_sort
#' @export
hal_sort <- function(x, field, decreasing = FALSE, ...) {
  param <- ifelse(decreasing, "desc", "asc")
  x$sort <- sprintf("%s %s", field, param)
  x
}
