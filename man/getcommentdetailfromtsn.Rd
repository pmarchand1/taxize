% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/itis.R
\name{getcommentdetailfromtsn}
\alias{getcommentdetailfromtsn}
\title{Get comment detail from TSN}
\usage{
getcommentdetailfromtsn(tsn, ...)
}
\arguments{
\item{tsn}{TSN for a taxonomic group (numeric)}

\item{...}{optional additional curl options (debugging tools mostly)}
}
\value{
A data.frame with results.
}
\description{
Get comment detail from TSN
}
\examples{
\dontrun{
getcommentdetailfromtsn(tsn=180543)
}
}
\keyword{internal}

