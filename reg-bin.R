require(dplyr)
all_codes <- select(regdat2, one_of(c("VisitId","VisitDurMinutes")))

attach(all_codes)

all_codes <- mutate(all_codes, binned_dur = as.character(cut(VisitDurMinutes, breaks=c(-1,5,seq(from=6,to=30,by=5),Inf), labels=c(1,
                                                                                                                              2,
                                                                                                                              3,
                                                                                                                              4,
                                                                                                                              5,
                                                                                                                              6,
                                                                                                                              7))))

detach(all_codes)

regdat3 <- left_join(regdat2, all_codes, by = "VisitId")
regdat3 <- select(regdat3, -VisitDurMinutes.x, -VisitDurMinutes.y)
regdat3$binned_dur <- as.numeric(regdat3$binned_dur)

lm2 <- lm(regdat3$binned_dur ~ regdat3$FactorA +
            regdat3$FactorB +
            regdat3$FactorC +
            regdat3$FactorD +
            regdat3$StationID +	
            regdat3$VisitType)
summary(lm2)
library(tree)
tree2 <- tree(regdat3$binned_dur ~ regdat3$FactorA +
                regdat3$FactorB +
                regdat3$FactorC +
                regdat3$FactorD, data=regdat3)
summary(tree2)
lm3 <- lm(regdat3$binned_dur ~ regdat3$FactorB)
summary(lm3)

regmat2 <- model.matrix( ~ binned_dur + FactorA +
                          FactorB +
                          FactorC +
                          FactorD +
                          StationID +	
                          VisitType, data = regdat3)
regmat2 <- regmat2[,-1]

n2 <- names(as.data.frame(regmat2))
f2 <- as.formula(paste("binned_dur ~", paste(n2[!n2 %in% "binned_dur"], collapse = " + ")))
library(neuralnet)
nn2<-NULL
nn2 <- neuralnet(f2,data=regmat2,hidden=c(1),linear.output=T)

nnres2 <- nn2$result.matrix
ppnn2 <- prediction(nn2)

pr.nn2 <- compute(nn2, regmat2[,-1])
pr.nn_2 <- pr.nn2$net.result
