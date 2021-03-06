% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/associateReg2Gene.R
\name{dcorResample}
\alias{dcorResample}
\title{Distance correlation with resampling based p-values}
\usage{
dcorResample(mat, scaleData = scaleData, col = 1, B = B)
}
\arguments{
\item{mat}{matrix of response and predictor variables}

\item{col}{column number of response variable}

\item{B}{number of random samples (shuffling) of given column}
}
\description{
private function that calculates distance correlation of given
column matrix with a vector and assigns significance to
correlation coefficents based on resampling
}
\keyword{internal}
