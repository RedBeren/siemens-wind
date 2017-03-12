library(clickstream)
library(igraph)
library(forcats)

#Markov Chain (takes forever)
mc <- clickstream::fitMarkovChain(clicks)
show(mc)
end_probs <- mc@end

# Get the absorbing states
abs_states <- absorbingStates(mc)

#Markov Chain for visit duration (also takes forever)
mc_dur <- clickstream::fitMarkovChain(clicks_visitduration)
show(mc_dur)
end_probs_dur <- mc_dur@end

# Get the absorbing states
abs_states_dur <- absorbingStates(mc_dur)

# Use igraph package to plot chain
net <- graph_from_adjacency_matrix(as.matrix(mc@transitions$`1`), mode = 'directed', weighted = TRUE)
net <- delete.edges(net, which(E(net)$weight <= 0.4))
net <- delete.vertices(net,which(degree(net)<1))
net <- simplify(net, remove.loops = T)
E(net)$arrow.size <- 0.2
deg <- degree(net, mode = 'all')
colrs <- ifelse(deg > 3, 'red','blue')
plot(net, vertex.shape = 'none',
     vertex.label.color = colrs)

# Two main absorbing states, so try splitting into two clusters
clusters <- clusterClickstreams(clicks, order = 0, centers = 2)
summary(clusters)

# Build Markov Chain off each cluster and check absorbing states
mc1 <- fitMarkovChain(clusters$clusters[1])
mc2 <- fitMarkovChain(clusters$clusters[2])
show(mc1) # Code 10105 Stop Urgency5
show(mc2) # Code 14001 Warning NoStop

#Frequencies
frequencyDF <- frequencies(clicks)

# Take first few codes from a visit and try using markov chain to predict rest of it
# Also try clustering them
click_test <- clicks$`100312`
click_test.fragment <- new('Pattern', sequence = click_test[1:5])
click_test.pred <- predict(mc, click_test.fragment, dist = 3)
predict(clusters, click_test.fragment)


click_test2 <- clicks$`1000863`
click_test2.fragment <- new('Pattern', sequence = click_test2[1:6])
click_test2.pred <- predict(mc, click_test2.fragment, dist = 1)
predict(clusters, click_test2.fragment)

# Now try to figure out clustering performance
end_states <- sapply(clicks, function(x) tail(x,1))
end_states <- factor(end_states)
end_states <- fct_collapse(end_states, Stop = c('8000','Stop1','Stop2','Stop3','Stop4','Stop5'))
start_patterns <- lapply(clicks, function(x) head(x,-1))
clus_patterns <- lapply(start_patterns, function(x) {
  new('Pattern', sequence = x)
})
clus_predictions <- sapply(clus_patterns, function(x) predict(clusters,x))
length(clus_predictions)
pred_vec <- unlist(unname(clus_predictions), recursive = TRUE)
length(pred_vec)
pred_vec <- factor(pred_vec, labels = c('Stop',"NoStop"))
