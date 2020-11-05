.onAttach <- function(libname, pkgname){
  op <- options()
  op.odyssey <- list(
    odyssey.progress = TRUE,
    odyssey.verbose = TRUE
  )
  toset <- !(names(op.odyssey) %in% names(op))
  if(any(toset)) options(op.odyssey[toset])

  invisible()
}
