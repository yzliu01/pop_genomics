# number of lines

30402 ./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic.final.summary

test_data <- read.table("./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic.final.summary",sep="\t",header=T)
head(test_data,2)
./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_117_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_156_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_156_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_3.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_3.no_singleton_sfs_78_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_3.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_3.no_singleton_sfs_117_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_3.no_singleton_sfs_156_1500x_sm_genic/AndHae_New_REF_AndHae_0_3.no_singleton_sfs_156_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_4.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_4.no_singleton_sfs_78_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_4.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_4.no_singleton_sfs_117_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_4.no_singleton_sfs_156_1500x_sm_genic/AndHae_New_REF_AndHae_0_4.no_singleton_sfs_156_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_5.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_5.no_singleton_sfs_78_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_5.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_5.no_singleton_sfs_117_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_5.no_singleton_sfs_156_1500x_sm_genic/AndHae_New_REF_AndHae_0_5.no_singleton_sfs_156_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_6.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_6.no_singleton_sfs_78_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_6.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_6.no_singleton_sfs_117_1500x_sm_genic.final.summary
./AndHae_New_REF_AndHae_0_6.no_singleton_sfs_156_1500x_sm_genic/AndHae_New_REF_AndHae_0_6.no_singleton_sfs_156_1500x_sm_genic.final.summary

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")

library(ggplot2)
library(gridExtra)
library(gtools)
# Get all summary files (adjust the pattern if needed)
summary_files <- list.files(path = ".", pattern = "AndHae.*_0_[2-6]\\.no_singleton.*final\\.summary$", recursive = TRUE, full.names = TRUE)
sorted_files <- mixedsort(summary_files,decreasing=F)

# Function to read and process each file
read_summary <- function(file) {
  data <- read.table(file, header = TRUE)  # Adjust column names if needed
  data$file <- basename(file)  # Add filename for labeling
  return(data)
}

# Read all files into a list of dataframes
summary_list <- lapply(sorted_files, read_summary)

#valid_summaries <- summary_list[sapply(summary_list, function(x) is.data.frame(x) && nrow(x) > 0)]



# Function to plot data
plot_summary <- function(data) {
  ggplot(data, aes(x = year, y = Ne_median)) +  # Adjust column names
    geom_line() +
    ggtitle(unique(data$file)) +  # Title as filename
    theme_minimal()
}

# Generate a list of plots
plot_list <- lapply(summary_list, plot_summary)


# Arrange all plots in a single row
grid.arrange(grobs = plot_list, nrow = 1)
