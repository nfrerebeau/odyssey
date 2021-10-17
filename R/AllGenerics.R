# GENERIC METHODS
NULL

# API ==========================================================================
#' HAL API
#'
#' Initialize a request to the HAL API.
#' @return
#'  An object of class `HALQuery`: a [`list`] containing at least the following
#'  components:
#'
#'  \describe{
#'   \item{`q`}{(default to "`*:*`").}
#'   \item{`fl`}{default to "`docid`" "`label_s`").}
#'   \item{`fq`}{}
#'   \item{`sort`}{}
#'   \item{`rows`}{(default to `30`).}
#'   \item{`start`}{(default to `0`).}
#'   \item{`wt`}{(default to "`json`").}
#'  }
#' @examples
#' hal_api()
#' @family API
#' @name hal_api
#' @rdname hal_api
NULL

# Faceting =====================================================================
#' Facet Search
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param field A [`character`] string specifying the field to group by.
#' @param limit An [`integer`] giving the maximum number of results per group.
#' @param sort A [`character`] string specifying the field to be used to sort
#'  the results.
#' @param prefix A [`character`] string.
#' @param contains A [`character`] string.
#' @param pivot A [`character`] string.
#' @param range A [`list`] containing the following components: "`range`",
#'  "`start`", "`end`", "`gap`".
#' @param ignore_case A [`logical`] scalar: should character case be ignored?
#' @param ... Currently not used.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-facet.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_facet
#' @rdname hal_facet
NULL

#' @rdname hal_facet
#' @export
hal_facet <- function(x, ...) UseMethod("hal_facet")

# Filter =======================================================================
#' Filter Results
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param value A [`character`] string specifying the value to be used to filter
#'  the results.
#' @param field A [`character`] string specifying the field to filter along.
#' @param ... Currently not used.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-filter.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_filter
#' @rdname hal_filter
NULL

#' @rdname hal_filter
#' @export
hal_filter <- function(x, ...) UseMethod("hal_filter")

# Download =====================================================================
#' Download Documents
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param limit An [`integer`] giving the maximum number of results.
#'  According to HAL policy, it cannot exceed 10000.
#' @param start An [`integer`] specifying an absolute offset in the complete
#'  sorted list of matches to be used as the beginning of the current page.
#'  Only used if `cursor` is `FALSE`.
#' @param progress A [`logical`] scalar: should a progress bar for for the
#'  request be printed? Only used if \R is being used interactively.
#' @param verbose A [`logical`] scalar: should extra information be reported?
#' @param ... Currently not used.
#' @return An (invisible) [`logical`] scalar, `TRUE` for success and `FALSE` if
#'  any failure.
#' @example inst/examples/ex-download.R
#' @author N. Frerebeau
#' @docType methods
#' @family search tools
#' @name hal_download
#' @rdname hal_download
NULL

#' @rdname hal_download
#' @export
hal_download <- function(x, ...) UseMethod("hal_download")

# Group ========================================================================
#' Group Results
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param field A [`character`] string specifying the field to group by.
#' @param limit An [`integer`] giving the maximum number of results per group.
#' @param sort A [`character`] string specifying the field to be used to sort
#'  the results.
#' @param decreasing A [`logical`] scalar: should the sort be increasing or
#'  decreasing?
#' @param ... Currently not used.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-group.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_group
#' @rdname hal_group
NULL

#' @rdname hal_group
#' @export
hal_group <- function(x, ...) UseMethod("hal_group")

# Query ========================================================================
#' Build Query
#'
#' @param x,y A [`character`] vector or an object of class `HALQuery` (typically
#'  returned by [hal_api()]).
#' @param value A [`vector`] giving the topics to be searched for (see details).
#' @param field A [`character`] string specifying the field to search within.
#'  If `NULL` (the default), search within "`text`".
#' @param ... Currently not used.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-query.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_query
#' @rdname hal_query
NULL

#' @rdname hal_query
#' @export
hal_query <- function(x, ...) UseMethod("hal_query")

# Search =======================================================================
#' Search
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param path A [`character`] string specifying the url path (see details).
#' @param limit An [`integer`] giving the maximum number of results.
#'  According to HAL policy, it cannot exceed 10000.
#' @param start An [`integer`] specifying an absolute offset in the complete
#'  sorted list of matches to be used as the beginning of the current page.
#'  Only used if `cursor` is `FALSE`.
#' @param cursor A [`logical`] scalar: should a cursor be used for
#'  the pagination of results? If `TRUE`, the \code{sort} parameter of the
#'  query will set to "\code{docid asc}".
#' @param parse A [`character`] string specifying the type of the results.
#'  It must be one of "`df`" (default) or "`list`" (see
#'  [solrium::SolrClient()]).
#' @param concat A [`character`] string specifying the character to
#'  concatenate elements of longer than length \eqn{1}.
#' @param progress A [`logical`] scalar: should a progress bar for
#'  for the request be printed? Only used if \R is being used interactively.
#' @param verbose A [`logical`] scalar: should extra information be reported?
#' @param ... Currently not used.
#' @return
#'  * `hal_count()` returns the total number of results.
#'  * `hal_search()` returns a [`data.frame`] or [`list`] (according to `type`).
#' @references
#'  [Apache Solr documentation](https://cwiki.apache.org/confluence/display/solr/Common+Query+Parameters).
#'
#'  [HAL search documentation](https://api.archives-ouvertes.fr/docs/search).
#'
#'  [HAL reference frame documentation](https://api.archives-ouvertes.fr/docs/ref).
#' @example inst/examples/ex-search.R
#' @author N. Frerebeau
#' @family search tools
#' @name search
#' @rdname search
NULL

#' @rdname search
#' @export
hal_count <- function(x, ...) UseMethod("hal_count")

#' @rdname search
#' @export
hal_search <- function(x, ...) UseMethod("hal_search")

# Select =======================================================================
#' Select Fields
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param ... One or more [`character`] string separated by commas giving the
#'  fields to be returned.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-select.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_select
#' @rdname hal_select
NULL

#' @rdname hal_select
#' @export
hal_select <- function(x, ...) UseMethod("hal_select")

# Sort =========================================================================
#' Sort Results
#'
#' @param x An object of class `HALQuery` (typically returned by [hal_api()]).
#' @param field A [`character`] string specifying the field to be used to sort
#'  the results.
#' @param decreasing A [`logical`] scalar: should the sort be increasing or
#'  decreasing?
#' @param ... Currently not used.
#' @return An object of class [`HALQuery`][hal_api()].
#' @example inst/examples/ex-sort.R
#' @author N. Frerebeau
#' @docType methods
#' @family query tools
#' @name hal_sort
#' @rdname hal_sort
NULL

#' @rdname hal_sort
#' @export
hal_sort <- function(x, ...) UseMethod("hal_sort")
