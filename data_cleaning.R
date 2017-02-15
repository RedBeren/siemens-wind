library(chron)

dat <- read.csv('C:/Users/zackt/Documents/GitHub/siemens-wind/Data/Data/All Sites Together encoded.csv')

# Clean up dates
date.clean <- function(d) {
  d <- as.character(d)
  d <- sapply(d, function(x) paste(x, ":00", sep = ''))
  dtparts <- t(as.data.frame(strsplit(d, ' ')))
  row.names(dtparts) <- NULL
  d <- chron(dates. = dtparts[,1], times. = dtparts[,2], format = c('m/d/y','h:m:s'))
  return(d)
}

dat$VisitStartTime <- date.clean(dat$VisitStartTime)
dat$TimeOn <- date.clean(dat$TimeOn)
dat$TimeOff <- date.clean(dat$TimeOff)
