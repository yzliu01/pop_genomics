#!/usr/bin/env Rscript

# from https://linkinghub.elsevier.com/retrieve/pii/S2666166722003860

# Please specify your working directory using setwd 
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Panurgus_banksianus")
library(ggplot2)
library(dplyr)
library(cowplot)

library()
## check installed packages

# Import the read-length distribution table 
read_length_df <- read.csv("length.csv")
# Organize the imported read-length table 
# You can replace the level arguments for your platform, species, or strains
read_length_df$platform <- as.factor(read_length_df$platform)
str(read_length_df)
read_length_df$platform <- factor(read_length_df$platform,level = c("PacBio_CLR", "PacBio_HiFi","ONT"))
# Calculate the average read-lengths for each platform 
## (issue) summary_df <- dplyr(read_length_df, "platform", summarise, grp.mean=mean(length)) 
summary_df <- read_length_df %>% group_by(platform) %>% summarise(grp.mean = mean(length))
print(summary_df)
# A tibble: 1 × 2
  platform    grp.men
  <fct>         <dbl>
1 PacBio_HiFi  11647.


# Draw a read-length distribution plot for all reads 
library(scales) # load comma funcation
total.length.plot <- ggplot(read_length_df, aes(x=length, fill=platform, color=platform)) + 
    geom_histogram(binwidth=100, alpha=0.5, position="identity") + # position="dodge" # Use "identity" for overlapping histograms
    geom_vline(data=summary_df, aes(xintercept=grp.mean, color=platform), linetype="dashed", size =0.5) + # xintercept=grp.mean, 
    scale_x_continuous(labels = comma) + # format x-axis labels with commas
    scale_y_continuous(labels = comma) + # format y-axis labels with commas
    labs(x="Readlength (bp)", y="Count", title ="Distribution of Read Lengths by Platform") + 
    theme_bw()
# Draw a read-length distribution plot for reads % 20 kb in length 
20 kb.length.plot <- ggplot(read_length_df, aes(x=length, fill=platform, color=platform)) + geom_histogram(binwidth=50, alpha=0.5, position="dodge") + 
    geom_vline(data=summary_df, aes(xintercept=grp.mean, color=platform), linetype= "dashed", size=0.5) + 
    scale_x_continuous(labels = comma, limit = c(0,20000)) + 
    scale_y_continuous(labels = comma) + labs(x="Readlength(bp)",y="Count")+ theme_bw() 
    
# Merge both the read-length distribution plots 
plot <- plot_grid(total.length.plot, 20 kb.length.plot, ncol = 1)
# Save the figure using the file name, ‘‘read.length.pdf’’ 
pdf("read.length.pdf",width=6,height=8,paper='special') 
print(plot)
dev.off()