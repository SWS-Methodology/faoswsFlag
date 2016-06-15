##' The function obtains the flag combinations which are considered protected.
##'
##' @export

getProtectedFlag = function(){
    protectedData = flagValidTable[flagValidTable$Protected, ]
    combineFlag(protectedData, "flagObservationStatus", "flagMethod")
}
