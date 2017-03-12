require(dplyr)
vis.dur <- select(dat, VisitDurMinutes, VisitId)
vis.dur <- distinct(vis.dur)
rownam <- rownames(frequencyDF)
freq <- cbind(frequencyDF,rownam)
colnames(freq)[649] <- "VisitId"
freq$VisitId <- as.character(freq$VisitId)
vis.dur$VisitId <- as.character(vis.dur$VisitId)
codemat <- NULL
colnames(codemat)<- NULL
codemat <- left_join(vis.dur,freq, by = 'VisitId')
codemat <- select(codemat, -VisitId)
colnames(codemat) <- paste("code",colnames(codemat))
library(caret)
codemat2 <-NULL
zeros <- nearZeroVar(codemat)
codemat2 <- select(codemat, -`3`)
library(MASS)
lm.1 <- lm(f3, data = codemat)

library(tree)
n3 <- as.data.frame(names(codemat))
f3 <- as.formula(paste("code VisitDurMinutes ~", paste(n3[!n3 %in% "code VisitDurMinutes"], collapse = " + ")))
t2<- tree(f3,codemat,na.action=na.exclude)
codemat<-codemat[complete.cases(codemat),]
###############
## EVTREE (Evoluationary Learning)
library(evtree)

ev.codemat = evtree(f3, data=codemat2)
plot(ev.codemat2)
table(predict(ev.codemat2), codemat2$Metal)
1-mean(predict(ev.codemat2) == codemat2$Metal)






##############################
library(neuralnet)
nn3<-NULL
nn3 <- neuralnet(f3,data=codemat,hidden=c(5,5),linear.output=T)

nnres3 <- nn3$result.matrix
ppnn3 <- prediction(nn3)

pr.nn3 <- compute(nn3, codemat[,-1])
pr.nn_3 <- pr.nn$net.result