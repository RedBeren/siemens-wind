# Run data_cleaning.R first

library(arules)
require(dplyr)

dat %>% select(one_of(c("VisitId","Code"))) -> codes_by_visit

codes_by_visit$VisitId <- factor(codes_by_visit$VisitId)
codes_by_visit$Code <- factor(codes_by_visit$Code)

trans <- as(split(codes_by_visit[,"Code"], codes_by_visit[,"VisitId"]), "transactions")
inspect(trans[1:5])

rules <- apriori(trans)
inspect(rules[1:5])
