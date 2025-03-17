# Load necessary libraries
library(ggplot2)
library(gridExtra)
library(gtools) # For mixedsort
library(stringi) # For stri_replace_all_regex

# Set working directory
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/pool_downsample_genome-")

# Get all summary files (adjust the pattern if needed)
summary_files <- list.files(path = ".", pattern = "AndHae_REF.*DP_.*x.P_.*final\\.summary$", recursive = TRUE, full.names = TRUE)
sorted_files <- mixedsort(summary_files, decreasing = FALSE)

# Function to read and process each file
read_summary <- function(file) {
  data <- read.table(file, sep = "\t", header = TRUE)  # Adjust column names if needed
  data$file <- basename(file)  # Add filename for labeling
  data$file <- stri_replace_all_regex(
    data$file,
    pattern = c("final.summary"),
    replacement = c(""),
    vectorize = FALSE
  )
  return(data)
}

# Read all files into a list of dataframes
summary_list <- lapply(sorted_files, read_summary)

# Function to plot data
plot_summary <- function(data) {
  ggplot(data, aes(x = year, y = Ne_median)) +  # Define aesthetics
    scale_x_continuous(
      limits = c(10, 200000),
      labels = function(year) format(year, scientific = FALSE)  # Format x-axis labels
    ) +
    scale_y_continuous(
      limits = c(1, 500000),
      labels = function(Ne_median) format(Ne_median, scientific = FALSE)  # Format y-axis labels
    ) +
    geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.), fill = "blue", alpha = 0.3) +  # Confidence interval
    geom_line(color = "red", linewidth = 0.7, alpha = 0.8) +  # Median line
    ggtitle(unique(data$file)) +  # Title as filename
    theme_minimal() +  # Use a minimal theme
    theme(
      panel.border = element_rect(linewidth = 1.5, fill = NA),  # Add a border around the plot
      axis.title.x = element_blank(),  # Remove x-axis title
      axis.title.y = element_blank(),  # Remove y-axis title
      axis.text.x = element_blank(),   # Remove x-axis labels
      axis.text.y = element_blank(),   # Remove y-axis labels
      axis.ticks = element_blank()     # Remove axis ticks
    )
}

# Generate a list of plots
plot_list <- lapply(summary_list, plot_summary)

# Add axis titles and labels back to the left and bottom plots
n_rows <- 5
n_cols <- ceiling(length(plot_list) / n_rows)

for (i in seq_along(plot_list)) {
  # Add y-axis title and labels to the leftmost plots
  if (i %% n_cols == 1) {  # Left column
    plot_list[[i]] <- plot_list[[i]] +
      theme(
        axis.title.y = element_text(),  # Add y-axis title
        axis.text.y = element_text(),   # Add y-axis labels
        axis.ticks.y = element_line()   # Add y-axis ticks
      ) +
      ylab("Ne_median")  # Set y-axis title
  }
  
  # Add x-axis title and labels to the bottom plots
  if (i > (n_rows - 1) * n_cols) {  # Bottom row
    plot_list[[i]] <- plot_list[[i]] +
      theme(
        axis.title.x = element_text(),  # Add x-axis title
        axis.text.x = element_text(),   # Add x-axis labels
        axis.ticks.x = element_line()   # Add x-axis ticks
      ) +
      xlab("year")  # Set x-axis title
  }
}

# Arrange all plots in a grid
pdf("Hae_multi_stairway_plots.pdf", width = 60, height = 40)
grid.arrange(
  grobs = plot_list,
  nrow = n_rows,
  left = textGrob("Ne_median", rot = 90, gp = gpar(fontsize = 14)),  # Shared y-axis title
  bottom = textGrob("year", gp = gpar(fontsize = 14))               # Shared x-axis title
)
dev.off()