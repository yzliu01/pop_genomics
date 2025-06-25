library(ggplot2)
library(fs)
library(gtools)
library(patchwork)
library(scales)

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100_replicates"
setwd(result_path)

# True Ne function based on event name
fx <- function(x, plot_name) {
  sapply(x, function(xx) {
    if (grepl("G_cons", plot_name)) {
      50000
    } else if (grepl("50G.*1.1i", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 1.1
    } else if (grepl("50G.*05d", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 1.5
    } else if (grepl("50G.*09d", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 1.9
    } else if (grepl("50G.*05i", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 0.5
    } else if (grepl("100G.*1.1i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.1
    } else if (grepl("100G.*1.5i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.5
    } else if (grepl("100G.*1.9i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.9
    } else if (grepl("100G.*05i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 0.5
    } else if (grepl("500G.*1.1i", plot_name)) {
      if (xx <= 500) 50000 else 50000 * 1.1
    } else if (grepl("500G.*1.5i", plot_name)) {
      if (xx <= 500) 50000 else 50000 * 1.5
    } else if (grepl("500G.*1.9i", plot_name)) {
      if (xx <= 500) 50000 else 50000 * 1.9
    } else if (grepl("500G.*05i", plot_name)) {
      if (xx <= 500) 50000 else 50000 * 0.5
    } else if (grepl("1000G.*1.1i", plot_name)) {
      if (xx <= 1000) 50000 else 50000 * 1.1
    } else if (grepl("1000G.*05i", plot_name)) {
      if (xx <= 1000) 50000 else 50000 * 0.5
    } else if (grepl("1000G.*1.5i", plot_name)) {
      if (xx <= 1000) 50000 else 50000 * 1.5
    } else {
      if (xx <= 1000) 50000 else 50000 * 1.9
    }
  })
}

events <- c("50G_05d", "1000G_09d")
n_reps <- 100

plot_list <- list()

for (i in seq_along(events)) {
  event <- events[i]
  all_reps <- list()
  
  for (rep in 1:n_reps) {
    rep_path <- paste0("./ft_sim_100000Ne_80hapS_1E_", event, "_20Chr_15Mb_", rep)
    files <- mixedsort(sort(fs::dir_ls(path = rep_path, recurse = TRUE, fail = TRUE, type = "file", glob = "*80hapS*.final.summary")))
    
    if (length(files) == 0) next
    
    df <- tryCatch(read.table(files[1], header = TRUE, sep = "\t"), error = function(e) NULL)
    if (is.null(df)) next
    
    all_reps[[rep]] <- df[, c("year", "Ne_median")]
  }
  
  # Remove NULLs
  all_reps <- all_reps[!sapply(all_reps, is.null)]
  if (length(all_reps) == 0) next
  
  # Check years consistent
  years <- all_reps[[1]]$year
  
  # Combine Ne_median from all replicates
  mat <- sapply(all_reps, function(x) x$Ne_median)
  
  # Summary stats
  summary_df <- data.frame(
    year = years,
    Ne_median = apply(mat, 1, median, na.rm = TRUE),
    Ne_2.5 = apply(mat, 1, quantile, probs = 0.025, na.rm = TRUE),
    Ne_97.5 = apply(mat, 1, quantile, probs = 0.975, na.rm = TRUE)
  )
  
  # Prepare true Ne trajectory (remove zero or negative years for log scale)
  true_years <- summary_df$year[summary_df$year > 0]
  true_Ne <- fx(true_years, event)
  true_df <- data.frame(year = true_years, Ne_true = true_Ne)
  
  # Legend show only for first plot
  show_legend <- ifelse(i == 1, TRUE, FALSE)
  
  p <- ggplot(summary_df, aes(x = year)) +
    geom_line(aes(y = Ne_median, color = "Median Ne (100 replicates)"), size = 1) +
    geom_ribbon(aes(ymin = Ne_2.5, ymax = Ne_97.5, fill = "95% CI"), alpha = 0.3) +
    geom_step(data = true_df, aes(x = year, y = Ne_true, color = "True model"), size = 1.2, alpha = 0.6) +
    scale_x_continuous(limits = c(1, 100000), trans = "log10", labels = scales::label_number()) +
    scale_y_continuous(limits = c(0, 200000), labels = scales::label_number()) +
    labs(title = paste0("50000Ne_", event),
         x = "Generations ago",
         y = "Effective population size") +
    scale_color_manual(name = NULL,
                       values = c("Median Ne (100 replicates)" = "red", "True model" = "blue"),
                       breaks = c("Median Ne (100 replicates)", "True model")) +
    scale_fill_manual(name = NULL,
                      values = c("95% CI" = "orange"),
                      breaks = "95% CI") +
    theme_bw() +
    theme(
      panel.grid.major = element_line(color = "gray", size = 0.5, linetype = 2),
      panel.grid.minor = element_line(color = "gray", size = 0.5, linetype = 2),
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      
      legend.position = if (show_legend) c(0.85, 0.9) else "none",
      legend.justification = c("right", "top"),
      legend.background = element_rect(fill = alpha("white", 0), color = NA),
      #legend.background = element_rect(fill = "transparent", color = NA), # Transparent background
      #legend.box.background = element_rect(fill = "transparent", color = NA), # Optional for legend box
      legend.key = element_rect(fill = "white"),
      #legend.key.width=unit(0.2, "cm"), # control width
      legend.spacing.y = unit(0, "cm"),  # smaller value = tighter rows
      legend.margin =  margin(-2,0,0,0,unit="pt"),
      legend.text = element_text(size = 10)
    )
  
  plot_list[[event]] <- p
}

# Combine plots side-by-side
combined_plot <- plot_list[[events[1]]] | plot_list[[events[2]]]

print(combined_plot)

# Save to PDF
ggsave(filename = "./combined_plot_100_replicates.new1.pdf", plot = combined_plot, width = 12, height = 6)



****************************** without true models ********************************




library(ggplot2)
library(dplyr)
library(fs)
library(gtools)
library(patchwork)

library(ggplot2)
library(fs)
library(gtools)
library(patchwork)  # for combining plots

events <- c("50G_05d", "1000G_09d")
n_reps <- 100

plot_list <- list()

for (event in events) {
  all_reps <- list()
  
  for (rep in 1:n_reps) {
    rep_path <- paste0("./ft_sim_100000Ne_80hapS_1E_", event, "_20Chr_15Mb_", rep)
    files <- mixedsort(sort(fs::dir_ls(path = rep_path, recurse = TRUE, fail = TRUE, type = "file", glob = "*80hapS*.final.summary")))
    
    if (length(files) == 0) next
    
    df <- tryCatch(read.table(files[1], header = TRUE, sep = "\t"), error = function(e) NULL)
    if (is.null(df)) next
    
    all_reps[[rep]] <- df[, c("year", "Ne_median")]
  }
  
  all_reps <- all_reps[!sapply(all_reps, is.null)]
  
  if (length(all_reps) == 0) next  # skip if no valid replicates
  
  years <- all_reps[[1]]$year
  
  mat <- sapply(all_reps, function(x) x$Ne_median)
  
  summary_df <- data.frame(
    year = years,
    Ne_median = apply(mat, 1, median, na.rm = TRUE),
    Ne_2.5 = apply(mat, 1, quantile, probs = 0.025, na.rm = TRUE),
    Ne_97.5 = apply(mat, 1, quantile, probs = 0.975, na.rm = TRUE)
  )
  
    # Filter out zero or negative years before plotting, to avoid log10(0)
    summary_df <- summary_df[summary_df$year > 0, ]

    p <- ggplot(summary_df, aes(x = year)) +
    geom_line(aes(y = Ne_median), color = "red") +
    geom_ribbon(aes(ymin = Ne_2.5, ymax = Ne_97.5), alpha = 0.3, fill = "orange") +
    scale_x_continuous(limits = c(1, 100000), trans = "log10") +  # start from 1, not zero
    scale_y_continuous(limits = c(0, 200000)) +
    labs(title = paste0("50000Ne_", event),
        x = "Generations ago",
        y = "Effective population size") +
    theme_bw() +
    theme(
        plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
        axis.title = element_text(size = 12),
        axis.text = element_text(size = 10)
    )
  
  plot_list[[event]] <- p
}

combined_plot <- plot_list[[events[1]]] | plot_list[[events[2]]]

print(combined_plot)

## save a pdf file
ggsave(filename = "./combined_plot.pdf", plot = combined_plot, width = 12, height = 6)

ggsave(filename = paste0("Median_Ne_", event, ".pdf"), plot = p, width = 8, height = 5)

## Base R
pdf("combined_plot.pdf", width = 12, height = 6)
print(combined_plot)
dev.off()



#x and xx serve different roles:

    x is the input argument to the function fx. It’s typically a vector of values (e.g., years).

    Inside sapply(x, function(xx) {...}), sapply loops over each element of x, and passes each individual element to xx — so xx is a single scalar value from the vector x.

#In other words:

    x = the whole vector you want to apply the function to (e.g., c(1,2,3,4,...))

    xx = one single element of that vector during each iteration of the sapply loop
