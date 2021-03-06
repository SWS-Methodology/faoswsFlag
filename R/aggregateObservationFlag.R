##' This function performs aggregation of flags
##'
##' The aggregation is based on the weight of the flag as designated
##' by the table. Official sources have high weight while data from
##' unreliable sources have low weight.
##'
##' @param ... Vectors of flags, each of the same length.  See details.
##' @param flagTable The table which maps the relationship between the
##' flag and its information weight. see data{flagWeightTable}
##'
##' @details This function works in a similar way to base::sum.  The first
##' argument is ..., and this allows the user to pass multiple vectors of
##' flags which should all be aggregated.
##'
##' @examples
##' aggregateObservationFlag("T", "E")
##' # Passing multiple flags aggregates them all together:
##' aggregateObservationFlag("", "T", "E", "I", "M")
##' # You can also pass vectors:
##' aggregateObservationFlag(c("T", "T"), c("M", ""))
##' # And more than 2 vectors:
##' aggregateObservationFlag(c("T", "T"), c("M", ""), c("I", ""))
##'
##' @seealso \code{\link{sum}}
##'
##' @return A character vector containing the aggregated flags.
##'
##' @export
##'

aggregateObservationFlag = function(..., flagTable = flagWeightTable){
  
    oneVector = FALSE
    flags = list(...)
    if (length(flags) == 1){
      oneVector = TRUE
      flags = unlist(flags)
    }

    ## Data Quality Checks
    flagLengths = lapply(flags, length)
    if(any(flagLengths != flagLengths[[1]]))
        stop("All input flag vectors must be of the same length.")
    
    if (oneVector){
      allFlags = flags
    } else {
      allFlags = do.call("c", flags)
    }
    if(any(!allFlags %in% flagTable$flagObservationStatus))
        stop("Some flags are not in the flagTable.")

    ## Convert flags to numeric information weight as determined by
    ## the table.
    weights = lapply(X = flags, FUN = flag2weight, flagTable = flagTable)

    ## Aggregate the weight by taking the lowest weight
    aggregatedWeights = do.call(pmin, weights)

    ## Convert weight back to flag
    aggregatedFlag = weight2flag(aggregatedWeights, flagTable)
    aggregatedFlag
}
