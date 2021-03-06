% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/itis.R
\name{getacceptednamesfromtsn}
\alias{getacceptednamesfromtsn}
\title{Get accepted names from tsn}
\usage{
getacceptednamesfromtsn(tsn, ...)
}
\arguments{
\item{tsn}{TSN for a taxonomic group (numeric)}

\item{...}{optional additional curl options (debugging tools mostly)}
}
\description{
Get accepted names from tsn
}
\examples{
\dontrun{
# TSN accepted - good name
getacceptednamesfromtsn(tsn='208527')

# TSN not accepted - input TSN is old name
getacceptednamesfromtsn('504239')

# TSN not accepted - input TSN is old name
getacceptednamesfromtsn('504239')
}
}
\keyword{internal}

