

mytr <- read.tree(text="((Pan:5,Homo:5):2,Gorilla:7);")
mytr <- read.tree(text="(((Pan:5,Homo:5):2,Gorilla:7),Dog:10);")
mytr <- read.tree(text="(((((((B._pascuorum:6,B._veternus:6):6,B._hortorum:21.2),B._hypnorum:23.7),B._confusus:30.8),A._mellifera:54),((A._haemorrhoa:12.5,A._fulva:12.5):5,((A._trimmerana:12.5,A._marginata:12.5):1,A._hattofiana:13.5):4):88.5):106,Philanthus_triangulum:128);")

# Install BiocManager
install.packages("BiocManager")

# Load BiocManager
library(BiocManager)

# Install ggtree
install.packages("ggtree",dependancies = TRUE)
BiocManager::install("ggtree")

library(ape)
library(ggplot2)
library(ggtree)

mytr <- read.tree(text="(((((((Bombus_pascuorum:6,Bombus_veteranus:6):6,Bombus_hortorum:21.2),Bombus_hypnorum:23.7),Bombus_confusus:30.8),Apis_mellifera:54),((Andrena_haemorrhoa:12.5,Andrena_fulva:12.5):5,((Andrena_trimmerana:12.5,Andrena_marginata:12.5):1,Andrena_hattofiana:13.5):4):88.5):106,Philanthus_triangulum:128);")
# Example usage
branch_length <- c(22,52,23.2,7.1,2.5,15.2,6,6,21.2,23.7,30.8,54,88.5,5,12.5,12.5,4,1,12.5,12.5,13.5,128)

#branch_length <- c(3,2,5,5,7,10)
mytr$edge.length <- branch_length

if (any(is.na(mytr$edge.length))) {
      stop("The tree contains NA values in edge lengths.")
    }

# define genus name for the tips
genus_names <- c("Thorachbombus","Thoracobombus","Megabombus","Pyrobombus","Confusibombus","Apis","Thachandrena","Andrena","Hoplandrena","Margandrena","Charitandrena","Philanthus(digger_wasp)")
## convert tree to ggtree object
ggtree_obj <- ggtree(mytr)
## create a data frame for the genus labels and their corresponding tip numbers
tip_labels <- mytr$tip.label
tip_data <- data.frame(tip=tip_labels,genus = genus_names,stringAsFactors=FALSE)
## merge the genus labels with the ggtree object
ggtree_obj <- ggtree_obj %<+% tip_data

# Define colors for the genus bars
#genus_colors <- setNames(rainbow(length(unique(genus_names))), unique(genus_names))

# Add tip labels and genus bars
genus_bar_plot <- ggtree_obj + 
  geom_tiplab(size = 6) +  # Use aes() to map correctly
  geom_label(aes(label = genus, x = branch + 40),
              fill = "white",
              color = "red", size = 3,
              hjust = 1, vjust = 0.5, nudge_x = 1)
# Print the plot
print(genus_bar_plot)


# Add clade labels for each genus
unique_genus <- unique(genus_names)
for (genus in unique_genus) {
  tips <- which(genus_names == genus)
  if (length(tips) > 1) {
    MRCA_node <- MRCA(mytr,tips)
    genus_bar_plot <- genus_bar_plot + geom_cladelabel(node = MRCA(mytr, tips), label = genus, 
                                                       offset = 0.5, barsize = 1, 
                                                       fontsize = 3, color = genus_colors[genus])
  }
}

# Print the plot
print(genus_bar_plot)




************************************************
# Convert the tree to a ggtree object
ggtree_obj <- ggtree(mytr)

# Create a data frame for the genus labels and their corresponding tip numbers
tip_data <- data.frame(tip = mytr$tip.label, genus = genus_names, stringsAsFactors = FALSE)
tip_data$tip
************************************************


## build a frame to show the frame around the plot
foo <- function () {
    col <- "green"
    for (i in 1:2)
        axis(i, col = col, col.ticks = col, col.axis = col, las = 1)
    box(lty = "19")
}

par(mar=c(2,2,2,2))
layout(matrix(1:4, 2, 2, byrow = TRUE))
#args(axisPhylo)
mycol <- c("black","blue","red")
mycol <- rainbow(8)
plot(mytr, tip.color = mycol, show.tip.label = TRUE, lwd = 2, cex = 2)
plot(mytr, show.tip.label = TRUE, lwd = 2, cex = 2)
plot(tree, show.tip.label = TRUE, lwd = 2, cex = 2)

(i <- which.edge(mytr,c("Homo","Pan")))

## add branch label
#args(edgelabels)
edgelabels(cex = 1,bg = "lightgreen")
#args(add.scale.bar)
add.scale.bar(lwd=2,cex = 1.5)
#args(axisPhylo)
axisPhylo(side=1,cex.axis=2)
axisPhylo(side=3,cex.axis=2,backward=TRUE)
#axis(3)
dev.off()


# Define a function to add divergence times to each node
add_divergence_times <- function(tree, times) {
  # Get node labels
  node_labels <- round(times, 2)
  
  # Plot the tree
  #plot(tree, show.tip.label = TRUE)
  plot(mytr, tip.color = mycol, show.tip.label = TRUE, lwd = 2, cex = 2)
  
  # Add node labels
  nodelabels(node_labels, tree$node.label, adj = c(0, 0.5))
}


********************** correct one ************************

# Example usage
branch_length <- c(22,52,23.2,7.1,2.5,15.2,6,6,21.2,23.7,30.8,54,88.5,5,12.5,12.5,4,1,12.5,12.5,13.5,128)

#branch_length <- c(3,2,5,5,7,10)
mytr$edge.length <- branch_length
divergence_times <- branching.times(mytr)
add_divergence_times(mytr, divergence_times)

(i <- which.edge(mytr,c("A._hattofiana","A._marginata","B._pascuorum","B._veteruns")))
## check the index of specie on the tree
which.edge(mytr,"A._fulva")

# Function to add node labels (divergence times) to the tree plot
add_divergence_times <- function(tree, times) {
    internal_nodes <- as.numeric(names(times)) # Extract internal node numbers
    node_labels <- round(times, 2) # Round the divergence times to two decimal places
    
    # Plot the tree
    #(i <- which.edge(tree,c("A._hattofiana","A._marginata","B._pascuorum","B._veteruns")))
    #(i <- which.edge(tree,))
    #co <- rep("darkorange",Nedge(tree))
    #co[i] <- "black"
    #tip_col <- c("black",rep("darkorange",2),rep("black",2),"darkorange",rep("black",4),rep("darkorange",2))
    ## an order from lower number to higher number
    tip_col <- c("darkorange","darkorange","black","black","black","black","black","black","black","darkorange","darkorange","blue")
    par(mar=c(4,1,4,15)+2)
    par(xpd = TRUE)
    #plot(tree, type = "c", x.lim = c(0,130), show.tip.label = TRUE, tip.color = rainbow(4), lwd = 2, cex = 1.5)
    plot(tree, type = "p", x.lim = c(0,130), show.tip.label = TRUE, tip.color = tip_col, lwd = 4, cex = 1.2)    
    ## add label near the nodes
    #args(edgelabels)
    #edgelabels(cex = 0.8,bg = "lightgreen")
    ## pch = 16
    #args(add.scale.bar)
    #add.scale.bar(lwd=1,cex = 1.2)
    #args(axisPhylo)
    axisPhylo(side=1,cex.axis=1.2)
    axisPhylo(side=3,cex.axis=1.2,backward=TRUE)

    # Add node labels with divergence times
    nodelabels(node_labels, node = internal_nodes, adj = c(1.2, -0.8), frame = "none", cex = 1, col = "darkviolet")
    ## main = "Phylogenetic Tree with Divergence Times", 
    mtext("Divergence Time (Mya)", side = 1, line = 3, cex = 1.5)
}

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/phylogeny_tree_ape")
## save plot as pdf in a directory
pdf("tree_divergence_time.new.pdf", width = 10, height = 8)
# Add node labels with divergence times to the tree plot
add_divergence_times(mytr, divergence_times)
dev.off()
# Add a scale bar with specified text size
#add.scale.bar(cex = 0.8)

