% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/fars_functions.R
\name{make_filename}
\alias{make_filename}
\title{Make CSV Filename}
\usage{
make_filename(year)
}
\arguments{
\item{year}{A numeric. The year of the accident data.}
}
\value{
This function returns a character vector of the accident data CSV filename
   with the specified \code{year}.
}
\description{
This function generates an appropriate accident data CSV filename according to the
specified year.
}
\examples{
\dontrun{make_filename(2015)}

}
