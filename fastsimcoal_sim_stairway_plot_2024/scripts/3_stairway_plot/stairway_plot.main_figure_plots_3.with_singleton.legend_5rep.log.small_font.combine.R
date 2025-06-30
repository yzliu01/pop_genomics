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
      5000
    } else if (grepl("10000Ne_20hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 5000 else 5000 * 1.5
    } else if (grepl("10000Ne_80hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 5000 else 5000 * 1.5
    } else if (grepl("10000Ne_200hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 5000 else 5000 * 1.5
    } else if (grepl("100000Ne_20hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.5
# 100KNe
    } else if (grepl("100000Ne_80hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.5
    } else if (grepl("100000Ne_200hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 1.5
    } else if (grepl("1000000Ne_20hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 500000 else 500000 * 1.5
    } else if (grepl("1000000Ne_80hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 500000 else 500000 * 1.5
    } else if (grepl("1000000Ne_200hapS_1E_100G.*1.5i", plot_name)) {
      if (xx <= 100) 500000 else 500000 * 1.5
# 100KNe
    } else if (grepl("ft_sim_100000Ne_80hapS_1E_100G_05i", plot_name)) {
      if (xx <= 100) 50000 else 50000 * 0.5
# 100KNe
    } else if (grepl("ft_sim_100000Ne_80hapS_1E_100G_2e_i_cons", plot_name)) {
      if (xx <= 100) 50000 * (1.0069^xx) else 50000 * (1.0069^100)
# 100KNe
    } else if (grepl("ft_sim_100000Ne_80hapS_1E_100G_2e_d_cons", plot_name)) {
      if (xx <= 100) 50000 * (0.9931^xx) else 50000 * (0.9931^100)

    } else {
      if (xx <= 1000) 5000000 else 5000000 * 1.5
    }
  })
}


events <- c(
            "ft_sim_100000Ne_80hapS_1E_100G_1.5i","ft_sim_100000Ne_80hapS_1E_100G_05i", "ft_sim_100000Ne_80hapS_1E_100G_2e_i_cons","ft_sim_100000Ne_80hapS_1E_100G_2e_d_cons"
            )
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
  "50G_1.1i"   = c(1, 100000),
  "50G_1.5i"   = c(1, 100000),
  "50G_1.9i"   = c(1, 100000),
  "100G_1.1i"   = c(1, 100000),
  "100G_1.5i"   = c(1, 100000),
  "100G_1.9i"   = c(1, 100000),
  "500G_1.1i"   = c(1, 100000),
  "500G_1.5i"   = c(1, 100000),
  "500G_1.9i"   = c(1, 100000),
  "1000G_1.1i"   = c(1, 100000),
  "1000G_1.5i"   = c(1, 100000),
  "1000G_1.9i" = c(1, 100000),
"ft_sim_10000Ne_20hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_100000Ne_20hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_20hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_10000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_100000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_10000Ne_200hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_100000Ne_200hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_200hapS_1E_100G_1.5i" = c(1, 100000),
##
"ft_sim_100000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_100000Ne_80hapS_1E_100G_05i" = c(1, 100000), 
"ft_sim_100000Ne_80hapS_1E_100G_2e_i_cons" = c(1, 100000),
"ft_sim_100000Ne_80hapS_1E_100G_2e_d_cons" = c(1, 100000)

)

# Set per-event y-axis limits
y_limits_list <- list(
  "50G_1.1i"   = c(20000, 80000),
  "50G_1.5i"   = c(1, 125000),
  "50G_1.9i"   = c(1, 125000),
  "100G_1.1i"   = c(20000, 80000),
  "100G_1.5i"   = c(1, 125000),
  "100G_1.9i"   = c(1, 125000),
  "500G_1.1i"   = c(20000, 80000),
  "500G_1.5i"   = c(1, 125000),
  "500G_1.9i"   = c(1, 125000),
  "1000G_1.1i"   = c(20000, 80000),
  "1000G_1.5i"   = c(1, 125000),
  "1000G_1.9i" = c(1, 125000),
"ft_sim_10000Ne_20hapS_1E_100G_1.5i" = c(1, 20000),
"ft_sim_100000Ne_20hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_20hapS_1E_100G_1.5i" = c(1, 800000),
"ft_sim_10000Ne_80hapS_1E_100G_1.5i" = c(1, 20000),
"ft_sim_100000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_80hapS_1E_100G_1.5i" = c(1, 800000),
"ft_sim_10000Ne_200hapS_1E_100G_1.5i" = c(1, 20000),
"ft_sim_100000Ne_200hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_1000000Ne_200hapS_1E_100G_1.5i" = c(1, 800000),
##
"ft_sim_100000Ne_80hapS_1E_100G_1.5i" = c(1, 100000),
"ft_sim_100000Ne_80hapS_1E_100G_05i" = c(1, 100000), 
"ft_sim_100000Ne_80hapS_1E_100G_2e_i_cons" = c(1, 200000),
"ft_sim_100000Ne_80hapS_1E_100G_2e_d_cons" = c(1, 200000)
)




for (i in seq_along(events)) {
  event <- events[i]
  # Determine x-limits for this event
  x_limits <- x_limits_list[[event]]  # or use if/switch

  all_reps <- list()
  
  for (rep in 1:n_reps) {
    rep_path <- paste0("./", event, "_20Chr_15Mb_", rep)
    files <- mixedsort(sort(fs::dir_ls(path = rep_path, recurse = TRUE, fail = TRUE, type = "file", glob = "*0hapS*.final.summary")))
    
    if (length(files) == 0) next
    df <- tryCatch(read.table(files[1], header = TRUE, sep = "\t"), error = function(e) NULL)
    if (is.null(df)) next
    df$replicate <- rep
    #all_reps[[rep]] <- df[, c("year", "Ne_median", "Ne_2.5.", "Ne_97.5.", "replicate")]
    all_reps[[rep]] <- df[, c("year", "Ne_median", "Ne_12.5.", "Ne_87.5.", "replicate")]
  }

  all_reps <- all_reps[!sapply(all_reps, is.null)]
  if (length(all_reps) == 0) next

  # Combine data
  long_df <- do.call(rbind, all_reps)
  long_df <- long_df[long_df$year > 0, ]

  # Model
  #true_Ne <- fx(long_df$year, event)
  #true_df <- data.frame(year = long_df$year, Ne_true = true_Ne)

  model_years <- 1:100000
  true_Ne <- fx(model_years, event)
  true_df <- data.frame(year = model_years, Ne_true = true_Ne)

  # Get x-limits per event
  x_limits <- x_limits_list[[event]]
  if (is.null(x_limits)) x_limits <- c(1, 10000)

  # Get y-limits per event
  y_limits <- y_limits_list[[event]]
  if (is.null(y_limits)) y_limits <- c(1, 200000)

  # Plot
p <- ggplot() +

    ## Ribbon with fill legend
    geom_ribbon(data = long_df, 
            #aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate, fill = "95% CI"),
            aes(x = year, ymin = Ne_12.5., ymax = Ne_87.5., group = replicate, fill = "75% CI"),
            alpha = 0.3) +
  
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
    scale_x_continuous(trans = "log10",limits = x_limits, labels = label_number(big.mark = "")) +
    #scale_y_continuous(limits = c(10, 125000), labels = label_number()) +
    scale_y_continuous(limits = y_limits, labels = label_number(big.mark = "")) +

    labs(title = paste0(event),
         x = "Generations ago",
         y = expression(italic(N[e]))) +

    # Color and fill scales to generate legend entries
    scale_color_manual(name = NULL, 
                    values = c("Model" = "red", "Each replicate" = "blue"),
                    breaks = c("Model", "Each replicate")  # Desired order
                    #labels = c("Each median Ne" = expression(paste("Each median ", italic(N)[e])), "Model" = "Model")
                    ) + # cannot apply expression Ne directly

    #scale_fill_manual(name = NULL, 
    #                values = c("95% CI" = "orange"),
    #                breaks = c("95% CI")
    #                ) +

    scale_fill_manual(name = NULL, 
                    values = c("75% CI" = "orange"),
                    breaks = c("75% CI")
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
      axis.text = element_text(size = 7),
      axis.text.y = element_text(angle = 90, hjust=0.5),
      legend.position = if (i == 1) c(0.3, 0.8) else "none",
      #legend.position = if (i %in% c(1,2)) c(0.7, 0.7) else "none",
      legend.background = element_rect(fill = alpha("white", 0), color = NA),
      legend.key = element_rect(fill = "white"),
      legend.text = element_text(size = 8),
      ## space between two separate legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
      #legend.margin =  margin(-14,0,0,0,unit="pt"),
      legend.margin =  margin(-10,0,0,0,unit="pt"),
      #legend.spacing.y = unit(0,"cm"),
      legend.key.height=unit(0.5,"line"),
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
library(gridExtra)

# Create an empty plot (placeholder for empty spaces)
empty_plot <- ggplot() + 
  theme_void()

# Arrange plots in 3x4 grid with empty last column
combined_plot_3_75CI_with_singleton <- grid.arrange(
        plot_list[[1]], plot_list[[2]], plot_list[[3]], plot_list[[4]],
        #plot_list[[4]], plot_list[[5]], plot_list[[6]], empty_plot,
        #plot_list[[7]], plot_list[[8]], plot_list[[9]], empty_plot,
        nrow = 3,
        ncol = 4
)


# Save to PDF
ggsave(filename = "./combined_plot_40S_100G_05i_2e_di_5_replicates_with_75CI_with_singleton.small_font.log.3.pdf",
       plot = combined_plot_3_75CI_with_singleton, width = 10, height = 6)



## final combine
all_plots <- list(
  combined_plot_1_75CI_with_singleton,
  combined_plot_2_75CI_with_singleton,
  combined_plot_3_75CI_with_singleton
)

# Remove any NULL entries
valid_plots <- Filter(Negate(is.null), all_plots)
# Combine all plots vertically (1 column)
final_combined_plot <- do.call(grid.arrange, c(valid_plots, ncol = 1))

#pdf_file <- file.path(result_path,"combined_plot_40S_50G_05d_1000G_09d_5_replicates_with_95_75CI_with_and_no_singleton.new2.pdf")
# Save to PDF
ggsave(filename = "./combined_plot_main_figure_1_2_3_75CI_with_singleton.small_font.log_x.new.pdf",
        final_combined_plot, width = 10, height = 10 * ceiling(length(valid_plots) / 2), limitsize = FALSE)
