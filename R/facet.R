# FACET RESULTS
#' @include AllGenerics.R
NULL

#' @rdname hal_facet
#' @export
hal_facet.HALQuery <- function(x, field, limit = 5, sort = c("index", "count"),
                               prefix = NULL, contains = NULL, pivot = NULL,
                               range = NULL, ignore_case = FALSE, ...) {
  # Validation
  sort <- match.arg(sort, several.ok = FALSE)
  # Prevent grouping and faceting
  if (!is.null(x$group)) x$group <- "false"
  # Remove useless parameters
  # TODO

  x$facet <- "true"
  x$facet.field <- field
  x$facet.limit <- limit
  x$facet.sort <- sort
  if (!is.null(prefix)) x$facet.prefix <- prefix
  if (!is.null(contains)) {
    x$facet.contains <- contains
    x$facet.contains.ignoreCase <- ifelse(ignore_case, "true", "false")
  }
  if (!is.null(pivot)) x$facet.pivot <- pivot
  if (is.list(range) && length(range) > 0) {
    x$facet.range <- range$range
    x$facet.range.start <- range$start
    x$facet.range.end <- range$end
    x$facet.range.gap <- range$gap
  }
  x
}
