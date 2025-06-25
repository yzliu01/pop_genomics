library(ggplot2)
library(fs)
library(gtools)
library(patchwork)
library(scales)

result_path <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100_replicates"
setwd(result_path)

# Function to generate true Ne trajectory
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
n_reps <- 5
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
    df$replicate <- rep
    all_reps[[rep]] <- df[, c("year", "Ne_median", "Ne_2.5.", "Ne_97.5.", "replicate")]
  }

  all_reps <- all_reps[!sapply(all_reps, is.null)]
  if (length(all_reps) == 0) next

  # Combine data
  long_df <- do.call(rbind, all_reps)
  long_df <- long_df[long_df$year > 0, ]

  # True model
  true_Ne <- fx(long_df$year, event)
  true_df <- data.frame(year = long_df$year, Ne_true = true_Ne)

  # Plot
  p <- ggplot() +
    geom_ribbon(data = long_df, aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate),
                fill = "orange", alpha = 0.3) +
    geom_line(data = long_df, aes(x = year, y = Ne_median, group = replicate),
              color = "blue", alpha = 0.5, size = 0.7) +
    geom_step(data = true_df, aes(x = year, y = Ne_true, color = "True model"),
              size = 1, alpha = 0.8) +

    scale_x_continuous(trans = "log10", limits = c(1, 100000), labels = label_number()) +
    scale_y_continuous(limits = c(0, 200000), labels = label_number()) +

    labs(title = paste0("50000Ne_", event),
         x = "Generations ago",
         y = "Effective population size") +

    scale_color_manual(name = NULL,
                       values = c("True model" = "red")) +

    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
      axis.title = element_text(size = 12),
      axis.text = element_text(size = 10),
      legend.position = if (i == 1) c(0.85, 0.9) else "none",
      legend.background = element_rect(fill = alpha("white", 0), color = NA),
      legend.key = element_rect(fill = "white"),
      legend.text = element_text(size = 10)
    )

  plot_list[[event]] <- p
}

# Combine plots
combined_plot <- plot_list[[events[1]]] | plot_list[[events[2]]]
print(combined_plot)

# Save to PDF
ggsave(filename = "./combined_plot_5_replicates_with_95CI.pdf",
       plot = combined_plot, width = 12, height = 6)
