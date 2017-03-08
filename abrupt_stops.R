# Exploration of abrupt automatic stops

# Codes where: 
#   EventWarningStop = Stop
#   IsManualStop = FALSE
#   StopUrgency = 6

# Which codes are they?

library(dplyr)
library(RCurl)

dat.url <- getURL('https://raw.githubusercontent.com/RedBeren/siemens-wind/master/Data/Data/Codes%20and%20Event%20Warning%20Stop%20classification.csv')
codes <- read.csv(text = dat.url)

# Code and IsManualStop field headers a little messed up
names(codes)[1] <- 'Code'
names(codes)[3] <- 'IsManualStop'

# Make codes into strings instead of ints
codes$Code <- as.character(codes$Code)

# Get stop codes and codes where the turbine had to make
# an abrupt automatic stop
codes %>% filter(EventWarningStop == 'Stop') -> stop_codes

codes %>% filter(EventWarningStop == 'Stop') %>%
  filter(IsManualStop == FALSE) %>%
  filter(StopUrgency == '6') -> abrupt_stop_codes

stop_urgency_tbl <- table(stop_codes$StopUrgency)
barplot(stop_urgency_tbl)

# Vast majority are urgency = 5

