% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PlotMsMs.R
\name{PlotMsMs}
\alias{PlotMsMs}
\title{Comparison of the MS/MS submitted and identified in each sample.}
\usage{
PlotMsMs(
  MQCombined,
  long_names = FALSE,
  sep_names = NULL,
  position_dodge_width = 1,
  palette = "Set2"
)
}
\arguments{
\item{MQCombined}{Object list containing all the files from the MaxQuant
output. It is the result from using \code{make_MQCombined}.}

\item{long_names}{If TRUE, samples having long names will be considered, and
the name will be split by sep_names. By default = FALSE.}

\item{sep_names}{If long_names is TRUE, sep_names has to be selected. Samples
names will be split. By default is NULL.}

\item{position_dodge_width}{Position of the columns within each others.}

\item{palette}{The palette from the Package RColorBrewer. By default is
'Set2'.}
}
\value{
Plots the MS/MS submitted and Identified in each sample.
}
\description{
Comparison of the MS/MS submitted and identified in each sample.
}
\examples{
MQPathCombined <- system.file("extdata/combined/", package = "MQmetrics")
MQCombined <- make_MQCombined(MQPathCombined)
PlotMsMs(MQCombined)
}
