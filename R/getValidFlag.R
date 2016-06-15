##' The function returns the flag combination which are valid
##'
##' @export
##'


getValidFlag = function(){
    validFlagData = flagValidTable[flagValidTable$Valid, ]
    combineFlag(validFlagData, "flagObservationStatus", "flagMethod")
}
