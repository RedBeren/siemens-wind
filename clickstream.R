# dat <- read.csv('C:/Users/Harazahn/Desktop/Wind/Data/All Sites Together encoded.csv')

# clickstreams <- read.csv('C:/Users/Harazahn/Desktop/Wind/Data/clickstream_fixed.csv') ##Broken again. See SQL file.

#Clustering
csf <- tempfile()
writeLines(clickstreams, csf)
cls <- readClickstreams(csf, header = TRUE)
clusters <- clusterClickstreams(cls, order = 0, centers = 2)
print(clusters)

#Markov Chain
csf <- tempfile()
writeLines(clickstreams, csf)
cls <- readClickstreams(csf, header = TRUE)
mc <- fitMarkovChain(cls)
show(mc)

#Frequencies
csf <- tempfile()
writeLines(clickstreams, csf)
cls <- readClickstreams(csf, header = TRUE)
frequencyDF <- frequencies(cls)