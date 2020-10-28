# SEARCH
#' @include AllGenerics.R
NULL

#' @rdname hal_group
#' @export
hal_group.HALQuery <- function(x, field, limit = 1, sort = "score",
                               decreasing = FALSE, ...) {
  x$group <- "true"
  x$group.field <- field
  x$group.limit <- limit
  param <- ifelse(decreasing, "desc", "asc")
  x$group.sort <- sprintf("%s %s", sort, param)
  x
}
