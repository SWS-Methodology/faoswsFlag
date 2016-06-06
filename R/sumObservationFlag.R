##' This function performs sum over flags
##'
##' The sum is based on the weight of the flag as designated
##' by the table. Official sources have high weight while data from
##' unreliable sources have low weight.
##'
##' @param Vector of flags
##' @param flagTable The table which maps the relationship between the
##' flag and its information weight. see data{flagWeightTable}
##'
##'
##' @examples
##' sumObservationFlag(c("T", "E"))
##' # Passing multiple flags aggregates them all together:
##' sumObservationFlag(c("", "T", "E", "I", "M"))
##'
##' @seealso Similar function \code{\link{aggregateObservationFlag}}
##'
##' @return A character vector containing the aggregated flags.
##'
##' @export
##'

sumObservationFlag = function(flags, flagTable = flagWeightTable){
  flags = as.character(flags)
  ## Data Quality Checks
  flagLengths = lapply(flags, length)
  if(any(flagLengths != flagLengths[[1]]))
    stop("All input flag vectors must be of the same length.")
  if(any(!flags %in% flagTable$flagObservationStatus))
    stop("Some flags are not in the flagTable.")
  
  ## Convert flags to numeric information weight as determined by
  ## the table.
  weights = lapply(X = flags, FUN = flag2weight, flagTable = flagTable)
  
  ## Aggregate the weight by taking the lowest weight
  aggregatedWeights = do.call(pmin, weights)
  
  ## Convert weight back to flag
  sumFlag = weight2flag(aggregatedWeights, flagTable)
  sumFlag
}
