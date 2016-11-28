library(magrittr)

copyFlagWeightTable <- faoswsFlag::flagWeightTable

## X: observations from international organizations, e.g. Eurostat or UNSD
newFlagWeights <- data.frame(flagObservationStatus = c("X"),
                             flagObservationWeights = c(0.90))

## class(copyFlagWeightTable$flagObservationWeights)

flagWeightTable <-
  rbind.data.frame(copyFlagWeightTable,
                   newFlagWeights) %>%
  .[order(-.$flagObservationWeights), ]

save(flagWeightTable, file = "../data/flagWeightTable.RData")
