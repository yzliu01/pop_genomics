



setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data")

library(ggplot2)
library(reshape2)
list.files()

prop_data <- read.table("test_1x_to_3x.prop",sep="\t",header=F)
head(prop_data)
str(prop_data)

colnames(prop_data) <- c(paste0("",c("1x","1.5x","2x","2.5x","3x")))
# convert row names to a column
#prop_data$Allele <- rownames(prop_data)
prop_data$Allele <- paste0("Allele",1:50)

# Convert 'Allele' character to a factor with correct numerical order
prop_data$Allele <- factor(prop_data$Allele, levels = paste0("Allele", 1:50))
str(prop_data)

# reshape the data to long format for ggplot2
data_long <- melt(prop_data,id.vars="Allele", variable.name="Depth",value.name="Prop")
head(data_long)

# plot the data

# Plot the data
plot_sfs_prop <- ggplot(data_long, aes(x = Depth, y = Prop, fill = Depth)) +
  geom_bar(stat = "identity") +
  facet_wrap(~ Allele, ncol = 15) +  # Arrange plots in a grid
  labs(x = "Depth", y = "Proportion", title = "Proportion of Alleles Across Depths") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 11, angle = 45, hjust = 1),
        axis.text.y = element_text(size = 11),
        plot.title = element_text(size = 13),
        plot.subtitle = element_text(size = 13),
        legend.title = element_text(size = 13, face = "plain")) # face = "bold"
  
ggsave("plot_sfs_prop.pdf",width=12,height=6)

*********

# Convert 'Allele' to a factor with correct order (hass issue like allele1 allele10 allele2)
#prop_data$Allele <- factor(prop_data$Allele, levels = paste0("Allele", 1:50))

# Extract the numerical part of the Allele names
prop_data$AlleleNumber <- as.numeric(gsub("Allele", "", prop_data$Allele))

# correct Depth levels
data_long$Depth <- factor(data_long$Depth, levels = c("P_1x", "P_1.5x", "P_2x", "P_2.5x", "P_3x"))
levels(data_long$Depth)
levels(data_long$Allele)
levels(data_long$Prop)

# Sort the data by the numerical part of the Allele names
prop_data <- prop_data[order(prop_data$AlleleNumber), ]

# Convert 'Allele' to a factor with correct order
prop_data$Allele <- factor(prop_data$Allele, levels = prop_data$Allele)
