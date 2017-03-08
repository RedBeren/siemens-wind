# Get codes and visit IDs into clickstream format
# Run data_cleaning script first

require(dplyr)
all_codes <- select(dat, one_of(c("VisitId","Code","TimeOn","StopUrgency")))

attach(all_codes)

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
