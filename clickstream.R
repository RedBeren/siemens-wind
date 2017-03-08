library(clickstream)
library(igraph)

#Markov Chain (takes forever)
mc <- fitMarkovChain(clicks)
show(mc)
end_probs <- mc@end

# Get the absorbing states
abs_states <- absorbingStates(mc)

# Two main absorbing states, so try splitting into two clusters
clusters <- clusterClickstreams(clicks, order = 0, centers = 2)
summary(clusters)

# Build Markov Chain off each cluster and check absorbing states
mc1 <- fitMarkovChain(clusters$clusters[1])
mc2 <- fitMarkovChain(clusters$clusters[2])
show(mc1) # Code 15001 Warning NoStop
show(mc2) # Code 10105 Stop Urgency5

#Frequencies
frequencyDF <- frequencies(clicks)
