#' Return comparisons of statRes object
#' 
#' This function returns comparisons from statRes object
#' 
#' @param statRes is an object of class 'statRes'
#' 
#' @return returns a data frame with comparisons and their indices
#'
#' @examples 
#' dontrun{
#' get_comparisons(statRes_object)
#'
#'}
#' 
#' @rdname get_comparisons
#' @export
#'

get_comparisons<- function(statRes){

  #check that statRes object is of 'statRes' class
  if(class(statRes) != "statRes") stop("object must be of class 'statRes'")
  
  #pull comparisons attribute
  comp = attr(statRes, "comparisons")
  
  result = data.frame("comparisons" = as.character(comp), "index" = 1:length(comp), stringsAsFactors = FALSE)
  
  return(result)
  
}

#' Return check.names attribute of omicsData object
#' 
#' This function returns check.names attribute from omicsData object
#' 
#' @param omicsData an object of the class 'pepData', 'proData', 'metabData', or 'lipidData', usually created by \code{\link{as.pepData}}, \code{\link{as.proData}}, \code{\link{as.metabData}}, or \code{\link{as.lipidData}}, respectively.
#' 
#' @return returns logical, either TRUE or FALSE
#'
#' @examples 
#' dontrun{
#' getchecknames(omicsData)
#'
#'}
#' 
#' @rdname getchecknames
#' @export
#'

getchecknames<- function(omicsData){
  # check that omicsData is of appropriate class #
  if(!class(omicsData) %in% c("pepData", "proData", "metabData", "lipidData")) stop("omicsData must be of class 'pepData', 'proData', 'metabData', or 'lipidData'")
  
  result = attr(omicsData, "check.names")
  
  return(result)
}


#' Set check.names attribute of omicsData object
#' 
#' This function sets the check.names attribute of an omicsData object
#' 
#' @param omicsData an object of the class 'pepData', 'proData', 'metabData', or 'lipidData', usually created by \code{\link{as.pepData}}, \code{\link{as.proData}}, \code{\link{as.metabData}}, or \code{\link{as.lipidData}}, respectively.
#' @param set_to logical indicating what to set check.names attribute to. Defaults to TRUE.
#' 
#' @return updated omicsData object with check.names attribute
#'
#' @examples 
#' dontrun{
#' setchecknames(omicsData, set_to = TRUE)
#'
#'}
#' 
#' @rdname setchecknames
#' @export
#'

setchecknames<- function(omicsData, set_to = TRUE){
  # check that omicsData is of appropriate class #
  if(!class(omicsData) %in% c("pepData", "proData", "metabData", "lipidData")) stop("omicsData must be of class 'pepData', 'proData', 'metabData', or 'lipidData'")
  
  #check that set_to is logical
  if(!is.logical(set_to)) stop ("set_to must be of class 'logical' ")
  
  attr(omicsData, "check.names")<- set_to
  
  return(omicsData)
}

