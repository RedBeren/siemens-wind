# Get codes and visit IDs into clickstream format
# Run data_cleaning script first

codes <- select(dat, one_of(c("VisitId","Code","TimeOn")))

attach(codes)

sorted_codes <- codes[order(VisitId, TimeOn),]

detach(codes)

lvls <- levels(factor(sorted_codes$VisitId))
clicks <- vector('list', length(lvls))
names(clicks) <- lvls

visit.ind <- 1

for (i in 1:nrow(sorted_codes)) {
  if(sorted_codes$VisitId[i] == names(clicks)[visit.ind]) {
    clicks[[visit.ind]] <- append(clicks[[visit.ind]], sorted_codes$Code[i])
  } else {
    visit.ind <- visit.ind + 1
    clicks[[visit.ind]] <- append(clicks[[visit.ind]], sorted_codes$Code[i])
  }
}
