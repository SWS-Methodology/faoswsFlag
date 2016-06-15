##' Function to create a combined flag
##'
##' @param data The dataset
##' @param flagObservationStatusVar The column corresponds to the observation
##'     status flag.
##' @param flagMethodVar The column corresponds to the method flag.
##'
##' @return a vector of string with the flags concatenated.
##'
##' @export
##'

combineFlag = function(data, flagObservationStatusVar, flagMethodVar){
    paste0("(", data[[flagObservationStatusVar]], ", ", data[[flagMethodVar]], ")")
}
