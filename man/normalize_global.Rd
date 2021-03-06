% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/normalize_global.R
\name{normalize_global}
\alias{normalize_global}
\title{Calculate Normalization Parameters}
\usage{
normalize_global(omicsData, subset_fn, norm_fn, params = NULL,
  apply_norm = FALSE, backtransform = FALSE, min_prop = NULL)
}
\arguments{
\item{omicsData}{an object of the class 'pepData', 'proData', 'metabData', or 'lipidData', created by \code{\link{as.pepData}}, \code{\link{as.proData}}, \code{\link{as.metabData}}, or \code{\link{as.lipidData}}, respectively. The function \code{\link{group_designation}} must have been run on omicsData to use several of the subset functions (i.e. rip and ppp_rip).}

\item{subset_fn}{character string indicating the subset function to use for normalization. See details for the current offerings.}

\item{norm_fn}{character string indicating the normalization function to use for normalization. See details for the current offerings.}

\item{params}{additional arguments passed to the chosen subset functions. See details for parameter specification and default values.}

\item{apply_norm}{logical argument indicating if the normalization should be applied to the data. Defaults to FALSE. If TRUE, the normalization is applied to the data and an S3 object of the same class as \code{omicsData} (e.g. 'pepData') with normalized values in \code{e_data} is returned.}

\item{backtransform}{logical argument indicating if parameters for back transforming the data, after normalization, should be calculated.  Defaults to FALSE. If TRUE, the parameters for back transforming the data after normalization will be calculated, and subsequently included in the data normalization if \code{apply_norm} is TRUE or \code{\link{apply.normRes}} is used downstream. See details for an explanation of how these factors are calculated.}

\item{min_prop}{numeric threshold between 0 and 1 giving the minimum value for the proportion of features subset (rows of \code{e_data})}
}
\value{
If apply_norm is FALSE, an S3 object of type 'normRes' is returned. This object contains a list with: subset method, normalization method, normalization parameters, number of features used in normalization, and proportion of features used in normalization. plot() and summary() methods are available for this object. If apply_norm is TRUE, then the normalized data is returned in an object of the appropriate S3 class (e.g. pepData).
}
\description{
Calculates normalization parameters based on the data using the specified subset and normalization functions with possibility of apply the normalization to the data.
}
\details{
Below are details for specifying function and parameter options.
}
\section{Subset Functions}{

Specifying a subset function indicates the subset of features (rows of \code{e_data}) that should be used for computing normalization factors. The following are valid options: "all", "los", "ppp", "rip", and "ppp_rip". The option "all" is the subset that includes all features (i.e. no subsetting is done). The option "los" identifies the subset of the features associated with the top \code{L}, where \code{L} is a proportion between 0 and 1, order statistics. Specifically, the features with the top \code{L} proportion of highest absolute abundance are retained for each sample, and the union of these features is taken as the subset identified (Wang et al., 2006). The option "ppp" (orignally stands for percentage of peptides present) identifies the subset of features that are present/non-missing for a minimum \code{proportion} of samples (Karpievitch et al., 2009; Kultima et al., 2009). The option "rip" identifies features with complete data that have a p-value greater than a defined threshold \code{alpha} (common values include 0.1 or 0.25) when subjected to a Kruskal-Wallis test based (non-parametric one-way ANOVA) on group membership (Webb-Robertson et al., 2011). The option "ppp_rip" is equivalent to "rip" however rather than requiring features with complete data, features with at least a \code{proportion} of non-missing values are subject to the Kruskal-Wallis test.
}

\section{Normalization Functions}{

Specifying a normalization function indicates how normalization scale and location parameters should be calculated. The following are valid options: "median", "mean", "zscore", and "mad". Parameters for median centering are calculated if "median" is specified. The location estimates are the sample-wise medians of the subset data. There are no scale estimates for median centering. Parameters for mean centering are calculated if "mean" is specified. The location estimates are the sample-wise means of the subset data. There are no scale estimates for median centering. Parameters for z-score transformation are calculated if "zscore" is specified. The location estimates are the subset means for each sample. The scale estimates are the subset standard deviations for each sample. Parameters for median absolute deviation (MAD) transformation are calculated if "mad" is specified.
}

\section{Specifying Subset Parameters Using the \code{params} Argument}{

Parameters for the chosen subset function should be specified in a list with the function specification followed by an equal sign and the desired parameter value. For example, if LOS with 0.1 is desired, one should use \code{params = list(los = 0.1)}. ppp_rip can be specified in one of two ways: specify the parameters with each separate function or combine using a nested list (e.g. \code{params = list(ppp_rip = list(ppp = 0.5, rip = 0.2))}).

The following functions have parameters that can be specified:
\tabular{ll}{
los \tab a value between 0 and 1 indicating the top proportion of order statistics. Defaults to 0.05 if unspecified. \cr
\tab \cr
ppp \tab a value between 0 and 1 specifying the proportion of samples that must have non-missing values for a feature to be retained. Defaults to 0.5 if unspecified. \cr
\tab \cr
rip \tab a value between 0 and 1 specifying the p-value threshold for determining rank invariance. Defaults to 0.2 if unspecified. \cr
\tab \cr
ppp_rip \tab two values corresponding to the RIP and PPP parameters above. Defaults to 0.5 and 0.2, respectively.
\cr
}
}

\section{Backtransform}{

The purpose of back transforming data is to ensure values are on a scale similar to their raw values before normaliztion. The following values are calculated and/or applied for backtransformation purposes:
\tabular{ll}{
\code{median} \tab scale is NULL and location parameter is a global median across all samples \cr
\tab \cr
\code{mean} \tab scale is NULL and location parameter is a global median across all samples \cr
\tab \cr
\code{zscore} \tab scale is pooled standard deviation and location is global mean across all samples \cr
\tab \cr
\code{mad} \tab scale is pooled median absolute deviation and location is global median across all samples
\cr
}
}

\examples{
dontrun{
library(pmartRdata)
data(lipid_object)
lipid_object <- edata_transform(omicsData = lipid_object, data_scale="log2")
lipid_object <- group_designation(omicsData = lipid_object, main_effects = "Condition")
norm_object <- normalize_global(omicsData = lipid_object, subset_fn = "all", norm_fn = "median")
norm_object <- normalize_global(omicsData = lipid_object, subset_fn = "all", norm_fn = "median", apply_norm = FALSE, backtransform = TRUE)
norm_data <- normalize_global(omicsData = lipid_object, subset_fn = "all", norm_fn = "median", apply_norm = TRUE, backtransform = TRUE)
}

}
\references{

}
\author{
Lisa Bramer
}
