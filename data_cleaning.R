library(RCurl)
library(chron)
library(dplyr)

dat.url <- getURL('https://raw.githubusercontent.com/RedBeren/siemens-wind/master/Data/Data/All%20Sites%20Together%20encoded.csv')
dat <- read.csv(text = dat.url)

dat.url <- getURL('https://raw.githubusercontent.com/RedBeren/siemens-wind/master/Data/Data/Codes%20and%20Event%20Warning%20Stop%20classification.csv')
codes <- read.csv(text = dat.url)

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

# Park_Name is a little messed up
names(dat)[1] <- 'Park_Name'

# Discretize FactorA so it can be used in association analysis
dat$FactorA <- as.factor(dat$FactorA)

# StationID, VisitID, Code should be strings
dat$StationID <- as.character(dat$StationID)
dat$VisitId <- as.character(dat$VisitId)
dat$Code <- as.character(dat$Code)

# Join code classification info onto full data set
dat <- left_join(dat, codes, by = 'Code')

# Recode stop urgency to make it a little clearer
dat$StopUrgency <- factor(dat$StopUrgency, labels = c('NoStop','Urgency1','Urgency2','Urgency3','Urgency4','Urgency5','Urgency6'))
