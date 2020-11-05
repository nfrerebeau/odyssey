# DOWNLOAD
#' @include AllGenerics.R
NULL

#' @rdname hal_download
#' @export
hal_download.HALQuery <- function(x, limit = 30, start = 0,
                                  progress = getOption("odyssey.progress"),
                                  verbose = getOption("odyssey.verbose"), ...) {
  # Set parameters
  x$rows <- ifelse(limit > 10000, 10000, limit)
  x$fl <- c("halId_s", "files_s", "version_i")

  # Set search path
  hal_endpoint$path <- "search"

  hal_docs <- hal_endpoint$search(params = x)
  if (verbose) {
    n_docs <- attr(hal_docs,"numFound")
    n_files <- sum(!is.na(hal_docs$files_s))
    message(
      sprintf("%d notices out of %d (over %d found) include a downloadable file.",
              n_files, limit, n_docs)
    )
  }

  hal_files <- stats::na.omit(hal_docs$files_s)
  hal_get <- vapply(
    X = hal_files,
    FUN = function(x) {
      utils::download.file(x, destfile = basename(x))
    },
    FUN.VALUE = integer(1)
  )

  if (any(hal_get != 0)) {
    warning(
      sprintf("%d files failed to download.", sum(hal_files != 0)),
      call. = FALSE
    )
    invisible(FALSE)
  }
  invisible(TRUE)
}
