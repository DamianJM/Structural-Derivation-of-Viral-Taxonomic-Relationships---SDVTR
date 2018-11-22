#Protein Structure Viral Taxonomy - Script for generation of dendrograms and cluster diagrams in R

#Required Libraries

library(ggplot2, vegan, factoextra)

#Setting working directory

setwd("/user/user") #Change to current working directory

#Data input from TM-Align all vs all comparisons

data <- read.csv("output.txt", header=T) #Output file from "Extract_TM_results.py"

# Multiple plot function for permitting mutliple ggplot objects to be plotted in a single window

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}


#Data must be converted to matrix format: simple conversion to matrix format in R may not work and will almost certainly introduce NAs 

mx <- with(data, sort(unique(c(as.character(model1),as.character(model2)))))
M <- array(0, c(length(mx), length(mx)), list(mx, mx))
i <- match(data$model1, mx)
j <- match(data$model2, mx)
M[cbind(i,j)] <- M[cbind(j,i)] <- data$score

#Optimal choice of clusters using elbow method (check output of this and adjust number of clusters for below)

set.seed(123)
k.max <- 15
wss <- sapply(1:k.max, 
              function(k){kmeans(M, k, nstart=50,iter.max = 15 )$tot.withinss})
wss
elbow <- plot(1:k.max, wss, type="b", pch = 19, frame = FALSE, xlab="K Number of clusters", ylab="Total within-clusters sum of squares")

png("Elbow_Plot_Optimum_Clusters.png", res=300, height=12, width=8, units="in")
elbow
dev.off()

#Hierarchical K-Means Clustering of input data following conversion to matrix: can be modified if different clustering method is required

hk <- hkmeans(M, 14, hc.metric = "euclidean", hc.method = "ward.D2",	#Number of clusters will vary and optimum should be determined beforehand
              iter.max = 10, km.algorithm = "Hartigan-Wong")

#Generation and output of plots (Cluster plots drawn for first three dimensions which encompass most of the variance. By changing "axes=c(x,y)" different plots can be generated)

rainbowcols=rainbow(14) #Change according to number of clusters

p1 <- fviz_dend(hk, cex = 0.5, k = 9, main="Protein Dendrogram of T4 Terminase Large Subunits", cex.main=2, color_labels_by_k = TRUE) + 
  theme(plot.title = element_text(hjust = 0.5))

p2 <- fviz_cluster(hk, data=m, main="Protein Structure Clusters of T4 Terminase Large Subunits (Dim 1/2)", axes=c(1,2)) + theme(plot.title = element_text(hjust = 0.5))

p3 <- fviz_cluster(hk, data=m, color_labels_by_k = TRUE, main="Protein Structure Clusters of T4 Terminase Large Subunits (Dim 2/3)", axes=c(2,3)) + theme(plot.title = element_text(hjust = 0.5))

#Plot and output

png("Heirarchical Clustering of Protein Structure COmparisons.png", res=300, height=24, width=16, units="in")
multiplot(p1, p2, p3 cols=3)
dev.off()

