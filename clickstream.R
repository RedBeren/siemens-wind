library(clickstream)

#Clustering (quick)
clusters <- clusterClickstreams(clicks, order = 0, centers = 2)
## Probably don't print them, they're long af
# print(clusters)

#Markov Chain (takes forever)
mc <- fitMarkovChain(clicks)
show(mc)

#Frequencies
frequencyDF <- frequencies(clicks)
