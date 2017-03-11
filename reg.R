library(sqldf)
library(dplyr)
dat2 <- rename(dat, ParkName = X.U.FEFF.Park_Name)

regdat  <- sqldf(
                    'SELECT DISTINCT ParkName,
FactorA,
FactorB,
FactorC,
FactorD,
StationID,	
VisitType,
VisitId,
ManualStop,
VisitDurMinutes

                    FROM dat2
                    ')

regdat$ManualStop <- factor ( with ( regdat, ifelse ( ( ManualStop == 'TRUE' ), 1 , 0 ) ) )

regdat2  <- sqldf(
  'SELECT ParkName,
FactorA,
FactorB,
FactorC,
FactorD,
StationID,	
VisitType,
VisitId,
Sum(ManualStop) as ManStop,
VisitDurMinutes

                    FROM regdat
group by  ParkName,
FactorA,
FactorB,
FactorC,
FactorD,
StationID,	
VisitType,
VisitId,
VisitDurMinutes
                    ')



lm1 <- lm(regdat2$VisitDurMinutes ~ regdat2$FactorA +
          regdat2$FactorB +
          regdat2$FactorC +
          regdat2$FactorD +
          regdat2$StationID +	
          regdat2$VisitType)
lm1

tree1 <- tree(regdat2$VisitDurMinutes ~ regdat2$FactorA +
        regdat2$FactorB +
        regdat2$FactorC +
        regdat2$FactorD, data=regdat2)

lm2 <- lm(regdat2$VisitDurMinutes ~ regdat2$FactorB)
lm2

regmat <- model.matrix( ~ VisitDurMinutes + FactorA +
                         FactorB +
                         FactorC +
                         FactorD +
                         StationID +	
                         VisitType, data = regdat2)
regmat <- regmat[,-1]

n <- names(as.data.frame(regmat))
f <- as.formula(paste("VisitDurMinutes ~", paste(n[!n %in% "VisitDurMinutes"], collapse = " + ")))
library(neuralnet)
nn<-NULL
nn <- neuralnet(f,data=regmat,hidden=c(10,10),linear.output=T)

nnres <- nn$result.matrix
ppnn <- prediction(nn)

pr.nn <- compute(nn, regmat[,-1])
pr.nn_ <- pr.nn$net.result
