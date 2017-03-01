# Exploration of abrupt automatic stops

# Codes where: 
#   EventWarningStop = Stop
#   IsManualStop = FALSE
#   StopUrgency = 6

# Which codes are they?

library(dplyr)

codes <- read.csv('C:/Users/zackt/Documents/GitHub/siemens-wind/Data/Data/Codes and Event Warning Stop classification.csv')

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

