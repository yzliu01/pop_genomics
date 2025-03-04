library(ggplot2)
library(reshape2)
library(readr)

# Plot CV errors
cv_errors <- read_delim("cv_errors.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

cv_err_plot <- ggplot(data=cv_errors, aes(x=K, y=cv_err)) +
  geom_point() +
  ylab("CV error") +
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10)) +
  theme_bw() +
  theme(panel.border = element_blank(), panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(), axis.line = element_line(colour = "black"))

cv_err_plot 

#Import data for K=2

k2_results <- read_delim("k2_results.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

k2_results$Ind <- factor(k2_results$Ind, levels = k2_results$Ind[order(k2_results$Pop)])

# Put into long format
k2_long <- melt(k2_results)
k2_long$Cluster = k2_long$variable

# Plot

K2_plot <- ggplot(data=k2_long, aes(x=Ind, y=value,fill = Cluster)) +
  geom_bar(stat='identity') +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  facet_grid(.~Mount,space = 'free_x', scales = 'free_x', switch = 'x') + # For arranging by population
  labs(x = "Sample location", y="Proportion assignment") +
  theme_classic(base_size = 14, base_family = 'sans') +
  theme(panel.grid.minor.x = element_blank()) + 
  #theme(panel.spacing.x = unit(0,"line")) +   # remove facet spacing on x-direction
  theme(strip.placement = 'outside', strip.background.x = element_blank()) +   # switch the facet strip label to outside,remove background color
  theme(axis.text.x = element_blank(), legend.position = "none")
K2_plot

#Import data for K=3

k3_results <- read_delim("k3_results.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

k3_results$Ind <- factor(k3_results$Ind, levels = k3_results$Ind[order(k3_results$Pop)])

# Put into long format
k3_long <- melt(k3_results)
k3_long$Cluster = k3_long$variable

# Plot

k3_plot <- ggplot(data=k3_long, aes(x=Ind, y=value,fill = Cluster)) +
  geom_bar(stat='identity') +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  facet_grid(.~Mount,space = 'free_x', scales = 'free_x', switch = 'x') + # For arranging by population
  labs(x = "Sample location", y="Proportion assignment") +
  theme_classic(base_size = 14, base_family = 'sans') +
  theme(panel.grid.minor.x = element_blank()) + 
  #theme(panel.spacing.x = unit(0,"line")) +   # remove facet spacing on x-direction
  theme(strip.placement = 'outside', strip.background.x = element_blank()) +   # switch the facet strip label to outside,remove background color
  theme(axis.text.x = element_blank(), legend.position = "none") # remove sample names
k3_plot


#Import data for K=7

k7_results <- read_delim("k7_results.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

k7_results$Ind <- factor(k7_results$Ind, levels = k7_results$Ind[order(k7_results$Pop)])

# Put into long format
k7_long <- melt(k7_results)
k7_long$Cluster = k7_long$variable

# Plot

k7_plot <- ggplot(data=k7_long, aes(x=Ind, y=value,fill = Cluster)) +
  geom_bar(stat='identity') +
  scale_x_discrete(expand = c(0, 0)) +
  scale_y_continuous(expand = c(0, 0)) +
  facet_grid(.~Mount,space = 'free_x', scales = 'free_x', switch = 'x') + # For arranging by population
  labs(x = "Sample location", y="Proportion assignment") +
  theme_classic(base_size = 14, base_family = 'sans') +
  theme(panel.grid.minor.x = element_blank()) + 
  #theme(panel.spacing.x = unit(0,"line")) +   # remove facet spacing on x-direction
  theme(strip.placement = 'outside', strip.background.x = element_blank()) +   # switch the facet strip label to outside,remove background color
  theme(axis.text.x = element_blank())
k7_plot
