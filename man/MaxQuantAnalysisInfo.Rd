% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/MaxQuantAnalysisInfo.R
\name{MaxQuantAnalysisInfo}
\alias{MaxQuantAnalysisInfo}
\title{Experiment Information}
\usage{
MaxQuantAnalysisInfo(MQCombined)
}
\arguments{
\item{MQCombined}{Object list containing all the files from the MaxQuant
output. It is the result from using \code{make_MQCombined}.}
}
\value{
Returns the time in hours:minutes that lasted the whole Experiment.
}
\description{
Experiment Information
}
\examples{
MQPathCombined <- system.file("extdata/combined/", package = "MQmetrics")
MQCombined <- make_MQCombined(MQPathCombined)
MaxQuantAnalysisInfo(MQCombined)

}
