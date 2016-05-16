##' This function checks whether the flags in the data are valid according to
##' the flagValidTable.
##'
##' @param data The data to be checked
##' @param flagObservationVar The column name corresponding to the observation
##'     status flag.
##' @param flagMethodVar The column name corresponding to the method flag.
##' @param flagTable The table containing valid/invalid flag combination.
##'     See \data{flagValidTable} in \pkg{faoswsFlag}
##'
##' @return The original data is returned if all flags are valid, otherwise an
##'     error.
##'
##' @export

checkFlagValidity = function(data,
                             flagObservationVar = "flagObservationStatus",
                             flagMethodVar = "flagMethod",
                             flagTable = flagValidTable){

    if(!all(c(flagObservationVar, flagMethodVar) %in% colnames(data)))
        stop("Flag columns are not in the data")

    dataFlagCombination =
        unique(paste0("(", data[[flagObservationVar]], ", ",
                      data[[flagMethodVar]], ")"))

    tableFlagCombination =
        with(flagTable[flagTable$Valid, ],
             paste0("(", flagObservationStatus, ", ", flagMethod, ")"))

    invalidFlagCombinations = setdiff(dataFlagCombination, tableFlagCombination)

    if(length(invalidFlagCombinations) > 1){
        print(invalidFlagCombinations)
        stop("Invalid Combination flag exist, please provide correct combination")
    }
    data
}
