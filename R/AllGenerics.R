# GENERIC METHODS
NULL

# API ==========================================================================
#' HAL API
#'
#' Initialize a request to the HAL API.
#' @return
#'  An object of class \code{HALQuery}: a \code{\link{list}} containing at
#'  least the following components:
#'  \describe{
#'   \item{q}{(default to "\code{*:*}").}
#'   \item{fl}{default to "\code{docid}" "\code{label_s}").}
#'   \item{fq}{}
#'   \item{sort}{}
#'   \item{rows}{(default to \code{30}).}
#'   \item{start}{(default to \code{0}).}
#'   \item{wt}{(default to "\code{json}").}
#'  }
#' @examples hal_api()
#' @family API
#' @name hal_api
#' @rdname hal_api
NULL

# Filter =======================================================================
#' Filter Results
#'
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param value A \code{\link{character}} string specifying the value to be used
#'  to filter the results.
#' @param field A \code{\link{character}} string specifying the field to filter
#'  along.
#' @param ... Currently not used.
#' @return An object of class \code{\link[=hal_api]{HALQuery}}.
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
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param limit An \code{\link{integer}} giving the maximum number of results.
#'  According to HAL policy, it cannot exceed 10000.
#' @param start An \code{\link{integer}} specifying an absolute offset in the
#'  complete sorted list of matches to be used as the beginning of the current
#'  page. Only used if \code{cursor} is \code{FALSE}.
#' @param progress A \code{\link{logical}} scalar: should a progress bar for
#'  for the request be printed? Only used if \R is being used interactively.
#' @param verbose A \code{\link{logical}} scalar: should extra information be
#'  reported?
#' @param ... Currently not used.
#' @return An (invisible) \code{\link{logical}} scalar, \code{TRUE} for success and
#'  \code{FALSE} if any failure.
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
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param field A \code{\link{character}} string specifying the field to group
#'  by.
#' @param limit An \code{\link{integer}} giving the maximum number of results
#'  per group.
#' @param sort A \code{\link{character}} string specifying the field to be
#'  used to sort the results.
#' @param decreasing A \code{\link{logical}} scalar: should the sort be
#'  increasing or decreasing?
#' @param ... Currently not used.
#' @return An object of class \code{\link[=hal_api]{HALQuery}}.
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
#' @param x,y A \code{\link{character}} vector or an object of class
#'  \code{HALQuery} (typically returned by \code{\link{hal_api}}).
#' @param value A \code{\link{vector}} giving the topics to be searched for
#'  (see details).
#' @param field A \code{\link{character}} string specifying the field to search
#'  within. If \code{NULL} (the default), search within "\code{text}".
#' @param ... Currently not used.
#' @return An object of class \code{\link[=hal_api]{HALQuery}}.
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
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param path A \code{\link{character}} string specifying the url path (see
#'  \code{\link[solrium]{SolrClient}} and details).
#' @param limit An \code{\link{integer}} giving the maximum number of results.
#'  According to HAL policy, it cannot exceed 10000.
#' @param start An \code{\link{integer}} specifying an absolute offset in the
#'  complete sorted list of matches to be used as the beginning of the current
#'  page. Only used if \code{cursor} is \code{FALSE}.
#' @param cursor A \code{\link{logical}} scalar: should a cursor be used for
#'  the pagination of results? If \code{TRUE}, the \code{sort} parameter of the
#'  query will set to "\code{docid asc}".
#' @param type A \code{\link{character}} string specifying the type of the
#'  results. It must be one of "\code{df}" (default) or "\code{list}".
#' @param progress A \code{\link{logical}} scalar: should a progress bar for
#'  for the request be printed? Only used if \R is being used interactively.
#' @param ... Currently not used.
#' @return
#'  \code{hal_count} returns the total number of results.
#'
#'  \code{hal_search} returns a \code{\link{data.frame}} or
#'  \code{\link{list}} (according to \code{type}).
#' @references
#'  \href{https://api.archives-ouvertes.fr/docs/search}{HAL search documentation}.
#'
#'  \href{https://api.archives-ouvertes.fr/docs/ref}{HAL reference frame documentation}.
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
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param ... One or more \code{\link{character}} string separated by commas
#'  giving the fields to be returned.
#' @return An object of class \code{\link[=hal_api]{HALQuery}}.
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
#' @param x An object of class \code{HALQuery} (typically returned by
#'  \code{\link{hal_api}}).
#' @param field A \code{\link{character}} string specifying the field to be
#'  used to sort the results.
#' @param decreasing A \code{\link{logical}} scalar: should the sort be
#'  increasing or decreasing?
#' @param ... Currently not used.
#' @return An object of class \code{\link[=hal_api]{HALQuery}}.
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
