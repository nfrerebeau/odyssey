% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/AllGenerics.R, R/query.R
\docType{methods}
\name{hal_sort}
\alias{hal_sort}
\title{Sort Results}
\usage{
hal_sort(x, field, decreasing = FALSE, ...)

hal_sort(x, field, decreasing = FALSE, ...)
}
\arguments{
\item{x}{An object of class \code{HALQuery} (typically returned by \code{\link[=hal_api]{hal_api()}}).}

\item{field}{A \code{\link{character}} string specifying the field to be used to sort
the results.}

\item{decreasing}{A \code{\link{logical}} scalar: should the sort be increasing or
decreasing?}

\item{...}{Currently not used.}
}
\value{
An object of class \code{\link[=hal_api]{HALQuery}}.
}
\description{
Sort Results
}
\examples{
library(magrittr)

## Select fields
hal1 <- hal_api() \%>\% hal_sort("docid")
hal1$sort

## Update query
hal2 <- hal_sort(hal1, "producedDate_tdate", decreasing = TRUE)
hal2$sort
}
\seealso{
Other query tools: 
\code{\link{hal_facet}()},
\code{\link{hal_filter}()},
\code{\link{hal_group}()},
\code{\link{hal_query}()},
\code{\link{hal_select}()}
}
\author{
N. Frerebeau
}
\concept{query tools}
