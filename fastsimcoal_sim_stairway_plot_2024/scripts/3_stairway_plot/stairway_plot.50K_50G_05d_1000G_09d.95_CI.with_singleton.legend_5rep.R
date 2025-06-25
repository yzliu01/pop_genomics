library(ggplot2)
library(fs)
library(gtools)
library(patchwork)
library(scales)

result_path <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100KNe_swp"
setwd(result_path)

# Function to generate true Ne trajectory
fx <- function(x, plot_name) {
  sapply(x, function(xx) {
    if (grepl("G_cons", plot_name)) {
      50000
    } else if (grepl("50G.*1.1i", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 1.1
    } else if (grepl("50G.*1.5i", plot_name)) {
      if (xx <= 50) 50000 else 50000 * 1.5
    } else if (grepl("50G.*1.9i", plot_name)) {
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

events <- c("50G_1.5i", "1000G_1.9i")
n_reps <- 5
plot_list <- list()

#x_limits <- if (event == "50G_1.5i") {
#  c(10, 200)
#} else if (event == "1000G_1.9i") {
#  c(10, 1500)
#} else {
#  c(10, 100000)  # default fallback
#}

# Set per-event x-axis limits
x_limits_list <- list(
  "50G_1.5i"   = c(1, 200),
  "1000G_1.9i" = c(1, 1500)
)



for (i in seq_along(events)) {
  event <- events[i]
  # Determine x-limits for this event
  x_limits <- x_limits_list[[event]]  # or use if/switch

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

  # Model
  true_Ne <- fx(long_df$year, event)
  true_df <- data.frame(year = long_df$year, Ne_true = true_Ne)

  # Get x-limits per event
  x_limits <- x_limits_list[[event]]
  if (is.null(x_limits)) x_limits <- c(10, 10000)

  # Plot
p <- ggplot() +

    # Ribbon with fill legend
    #geom_ribbon(data = long_df, 
    #        aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate, fill = "95% CI"),
    #        alpha = 0.3) +
  
    # Line with color legend
    geom_line(data = long_df, 
            aes(x = year, y = Ne_median, group = replicate, color = "Each replicate"), 
            alpha = 0.5, size = 0.7) +

    # Step for Model with color legend
    geom_step(data = true_df, 
            aes(x = year, y = Ne_true, color = "Model"), 
            size = 1, alpha = 0.8) +

    #geom_ribbon(data = long_df, aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate),
    #            fill = "orange", alpha = 0.3) +
    #geom_line(data = long_df, aes(x = year, y = Ne_median, group = replicate),
    #          color = "blue", alpha = 0.5, size = 0.7) +
    #geom_step(data = true_df, aes(x = year, y = Ne_true, color = "Model"),
    #          size = 1, alpha = 0.8) +

    #scale_x_continuous(trans = "log10", limits = c(10, 100000), labels = label_number()) +
    #scale_y_continuous(limits = c(10, 200000), labels = label_number()) +
    scale_x_continuous(limits = x_limits, labels = label_number()) +
    scale_y_continuous(limits = c(10, 200000), labels = label_number()) +

    labs(title = paste0("50000Ne_with_singleton_", event),
         x = "Generations ago",
         y = "Effective population size") +

    # Color and fill scales to generate legend entries
    scale_color_manual(name = NULL, 
                    values = c("Model" = "red", "Each replicate" = "blue"),
                    breaks = c("Model", "Each replicate")  # Desired order
                    #labels = c("Each median Ne" = expression(paste("Each median ", italic(N)[e])), "Model" = "Model")
                    ) + # cannot apply expression Ne directly

    scale_fill_manual(name = NULL, 
                    values = c("95% CI" = "orange"),
                    breaks = c("95% CI")
                    ) +

    # Control legend order (color first, fill last)
    guides(
        color = guide_legend(order = 1),  # Color legends appear first
        fill = guide_legend(order = 2)    # Fill legend appears after
        ) +

    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 9, face = "plain"),
      axis.title = element_text(size = 9),
      axis.text = element_text(size = 9),
      axis.text.y = element_text(angle = 90, hjust=0.5),
      #legend.position = if (i == 1) c(0.7, 0.7) else "none",
      legend.position = if (i %in% c(1,2)) c(0.7, 0.7) else "none",
      legend.background = element_rect(fill = alpha("white", 0), color = NA),
      legend.key = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
      legend.margin =  margin(-14,0,0,0,unit="pt"),
      axis.ticks.length.x = unit(0, "pt") # Hide default x-axis ticks
    )
    # +

    ##coord_cartesian(clip = "off") +  # Allows ticks to extend outside plot

    ## Log tick marks on bottom axis
    #annotation_logticks(
    #    sides = "b",
    #    #outside = TRUE,
    #    short = unit(0.1, "cm"),  # Adjust size of short ticks
    #    mid = unit(0.15, "cm"),     # Adjust size of medium ticks
    #    long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
    #)

  plot_list[[event]] <- p
}

# Combine plots
combined_plot_95CI_with_singleton <- plot_list[[events[1]]] | plot_list[[events[2]]]
print(combined_plot_95CI_with_singleton)

# Save to PDF
ggsave(filename = "./combined_plot_40S_50G_05d_1000G_09d_5_replicates_with_95CI_with_singleton.no_log.pdf",
       plot = combined_plot_95CI_with_singleton, width = 12, height = 6)
