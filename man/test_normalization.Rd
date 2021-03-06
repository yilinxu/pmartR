% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/test_normalization.R
\name{test_normalization}
\alias{test_normalization}
\title{Test normalization}
\usage{
test_normalization(normRes_object, parametric = TRUE)
}
\arguments{
\item{normRes_object}{an object of class normRes, produced by normalize function}

\item{parametric}{logical indicating what test to use (anova test or Mann-Whitney U test), defaults to TRUE(anova test is used).}
}
\value{
an object of class normRes, but with an additional list item 'test'
}
\description{
Tests normalization results of a normRes object
}
\examples{
dontrun{
library(pmartRdata)
data(lipid_object)
lipid_object<- edata_transform(omicsData = lipid_object, data_scale="log2")
lipid_object<- group_designation(omicsData = lipid_object, main_effects = "Condition")
norm_object<- normalize(omicsData = lipid_object, subset_fn = "all", norm_fn = "median")

test_result<- test_normalization(normRes_object = norm_object, parametric = TRUE)
}

 @export  
 
}
