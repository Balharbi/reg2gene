% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/downstreamFunctions.R
\name{selectEP}
\alias{selectEP}
\title{Returns N TOP/BOTTOM/RANDOM associations per 
cohort/method/algorithm/voting/metaA}
\usage{
selectEP(indexTable, topN = "all", select = "top", success = TRUE,
  typeSuccess = "pval", thresholdSuccess = 0.05, method = "H3K4me1",
  algorithm = "pearson", cohort = "Roadmap", metaA = FALSE)
}
\arguments{
\item{indexTable}{an output of the makeIndexTable() for given combination of
methods/algorithms/cohorts; a table should contain the following columns: 
path - paths to .rds files; methods - a method type used for the analysis: 
eg. H3K4me1; 
algorithms -  algorithm used for the analysis: eg. dcor, cohorts - cohort
used for the analysis: eg. Roadmap; type - define whether results are 
produced by voting, meta-analysis,from individual modelling or a result of
regActivityAroundTSS()[OPTIONAL]}

\item{topN}{"all" (default) or integer. Defines how many EP associations to 
report. If topN=="all" then all associations with predefined statistics
[typeSuccess<thresholdSuccess],  eg pval<0.05 are reported. If topN is an
integer then corresponding number of EP associations 
(as defined by select and success arguments) is reported.}

\item{select}{"top" (default). Other options "bottom" and "random". Indicates
whether to select top N genes [topN], bottom N genes [topN] or randomly 
select N genes [topN]}

\item{success}{TRUE (default). Whether to select statistically significant EP 
associations (succes==TRUE), or those that were found to be statistically
not significant EP associations (succes==FALSE).}

\item{typeSuccess}{"pval" (default) Other options "qval". Which statistics to
threshold to assess a statistical significance.}

\item{thresholdSuccess}{0.05 (default, numeric). A threshold useD to 
assess a statistical significance.}

\item{method}{"H3K4me1" (default; character). For which method to 
extract Enh~Promoter pairs. Common options: "H3K4me1","H3K27ac",
"Methylation","DNase"}

\item{algorithm}{"pearson" (default; character). For which algorithm to
extract Enh~Promoter pairs. Common options:"pearson","spearman",
"elasticnet","dcor","randomForest"}

\item{cohort}{"Roadmap" (default; character). For which cohort  to extract
Enh~Promoter pairs. Common options:"Roadmap","Blueprint",
"CEMT","McGill"}

\item{metaA}{FALSE (default). Whether to perform this analysis on results of
meta-analysis or not. This argument overwrites cohort argument.}
}
\value{
returns a \code{\link[InteractionSet]{GInteractions}} object filtered 
for N (or retained all) enhancer-promoter interactions. Corresponding 
statistics from either modelling analysis \code{\link{associateReg2Gene}} or 
meta-analysis \code{\link{metaInteractions}} is retained.
}
\description{
The function returns GInteractions object with selected N TOP/BOTTOM/RANDOM 
associations per cohort/method/algorithm/voting/metaA. It can return
N random statistically not significant associations as well.
}
\details{
This function allows easy export of TOPN gene~enhancer pairs per method,
cohort and algorithm combination of modelling results or meta-analysis.
It can return all statistically significant/unsignificant genes or 
select top, bottom or random N of genes. Which statistics to filter can be
choosen by user (typeSuccess), as well as a threshold value for it 
(thresholdSuccess).
}
\examples{

\dontrun{

require(stringr)
library(InteractionSet)

# ONE .rds file will need to be added into package!!!

IndexTable <- readRDS("/data/akalin/Projects/AAkalin_Catalog_RI/Results/Validation/Fishillevic/VoteD//CohortVoting_McGillH3K4me1.rds")


TOPgenes <- selectEP(IndexTable,
topN=16, #change argument "all" not all
select="top", #"bottom","random",
success=TRUE,
typeSuccess="pval",
thresholdSuccess=0.05,
method="H3K4me1",
algorithm="dcor",
cohort="Roadmap",
metaA=FALSE)

saveRDS(TOPgenes,"/data/akalin/Projects/AAkalin_Catalog_RI/Results/Validation/Fishillevich/TOPgenesH3K4me1dcorRoadmap.rds")
}



}
\author{
Inga Patarcic
}
\keyword{internal}
