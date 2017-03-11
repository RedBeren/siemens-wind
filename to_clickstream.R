# Get codes and visit IDs into clickstream format
# Run data_cleaning script first

require(dplyr)
all_codes <- select(dat, one_of(c("VisitId","Code","TimeOn","StopUrgency","VisitDurMinutes")))

attach(all_codes)

all_codes <- mutate(all_codes, binned_dur = cut(VisitDurMinutes, breaks=c(seq(from=0,to=30,by=5),Inf), labels=c('0-5',
                                                                                                                '6-10',
                                                                                                                '11-15',
                                                                                                                '16-20',
                                                                                                                '21-25',
                                                                                                                '26-30',
                                                                                                                '30+')))
sorted_codes <- all_codes[order(VisitId, TimeOn),]

detach(all_codes)

lvls <- levels(factor(sorted_codes$VisitId))
clicks <- vector('list', length(lvls))
names(clicks) <- lvls

visit.ind <- 1

for (i in 1:nrow(sorted_codes)) {
  if(sorted_codes$VisitId[i] == names(clicks)[visit.ind]) {
    clicks[[visit.ind]] <- append(clicks[[visit.ind]], sorted_codes$Code[i])
  } else {
    clicks[[visit.ind]] <- append(clicks[[visit.ind]], sorted_codes$StopUrgency[i])
    visit.ind <- visit.ind + 1
    clicks[[visit.ind]] <- append(clicks[[visit.ind]], sorted_codes$Code[i])
  }
}
class(clicks) <- "Clickstreams"

clicks_visitduration <- vector('list', length(lvls))
names(clicks_visitduration) <- lvls

visit.ind <- 1

for (i in 1:nrow(sorted_codes)) {
  if(sorted_codes$VisitId[i] == names(clicks_visitduration)[visit.ind]) {
    clicks_visitduration[[visit.ind]] <- append(clicks_visitduration[[visit.ind]], sorted_codes$Code[i])
  } else {
    clicks_visitduration[[visit.ind]] <- append(clicks_visitduration[[visit.ind]], sorted_codes$binned_dur[i])
    visit.ind <- visit.ind + 1
    clicks_visitduration[[visit.ind]] <- append(clicks_visitduration[[visit.ind]], sorted_codes$Code[i])
  }
}
class(clicks_visitduration) <- "Clickstreams"