# HAL API
#' @include AllGenerics.R
NULL

hal_endpoint <- solrium::SolrClient$new(
  host = "api.archives-ouvertes.fr",
  path = "search",
  port = NULL,
  scheme = "http",
  errors = "simple"
)

#' @rdname hal_api
#' @export
hal_api <- function() {
  params <- list(
    q = "*:*",
    fl = c("docid", "label_s"),
    fq = NULL,
    sort = NULL,
    rows = 30L,
    start = 0L,
    wt = "json"
  )
  structure(params, class = c("list", "HALQuery"))
}
