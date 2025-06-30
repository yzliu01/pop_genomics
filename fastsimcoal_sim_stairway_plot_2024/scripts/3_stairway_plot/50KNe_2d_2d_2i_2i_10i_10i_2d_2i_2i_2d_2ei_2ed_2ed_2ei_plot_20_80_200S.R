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
# instant increase and decrease
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

## exponential increase and decrease
## 50G
    } else if (grepl("50G_2e_d_cons", plot_name)) {
      if (xx <= 50) 50000*(0.9862^xx) else 50000*(0.9862^50)
    } else if (grepl("50G_10e_d_cons", plot_name)) {
      if (xx <= 50) 50000*(0.9549^xx) else 50000*(0.9549^50)
    } else if (grepl("50G_2e_i_cons", plot_name)) {
      if (xx <= 50) 50000*(1.0140^xx) else 50000*(1.0140^50)
    } else if (grepl("50G_10e_i_cons", plot_name)) {
      if (xx <= 50) 50000*(1.0472^xx) else 50000*(1.0472^50)
## 100G
    } else if (grepl("100G_2e_d_cons", plot_name)) {
      if (xx <= 100) 50000*(0.9931^xx) else 50000*(0.9931^100)
    } else if (grepl("100G_10e_d_cons", plot_name)) {
      if (xx <= 100) 50000*(0.9773^xx) else 50000*(0.9773^100)
    } else if (grepl("100G_2e_i_cons", plot_name)) {
      if (xx <= 100) 50000*(1.0069^xx) else 50000*(1.0069^100)
    } else if (grepl("100G_10e_i_cons", plot_name)) {
      if (xx <= 100) 50000*(1.0233^xx) else 50000*(1.0233^100)
## 500G
    } else if (grepl("500G_2e_d_cons", plot_name)) {
      if (xx <= 500) 50000*(0.9986^xx) else 50000*(0.9986^500)
    } else if (grepl("500G_10e_d_cons", plot_name)) {
      if (xx <= 500) 50000*(0.9954^xx) else 50000*(0.9954^500)
    } else if (grepl("500G_2e_i_cons", plot_name)) {
      if (xx <= 500) 50000*(1.0014^xx) else 50000*(1.0014^500)
    } else if (grepl("500G_10e_i_cons", plot_name)) {
      if (xx <= 500) 50000*(1.0046^xx) else 50000*(1.0046^500)
## 1000G
    } else if (grepl("1000G_2e_d_cons", plot_name)) {
      if (xx <= 1000) 50000*(0.9993^xx) else 50000*(0.9993^1000)
    } else if (grepl("1000G_10e_d_cons", plot_name)) {
      if (xx <= 1000) 50000*(0.9977^xx) else 50000*(0.9977^1000)
    } else if (grepl("1000G_2e_i_cons", plot_name)) {
      if (xx <= 1000) 50000*(1.0007^xx) else 50000*(1.0007^1000)
    } else if (grepl("1000G_10e_i_cons", plot_name)) {
      if (xx <= 1000) 50000*(1.0023^xx) else 50000*(1.0023^1000)

## two pop size change event at 500_100G
    } else if (grepl("100_500G_2i_2i", plot_name)) {
      if (xx <= 100) 50000 else if (100 < xx & xx <= 500) 2*50000 else 2*2*50000
    } else if (grepl("100_500G_2d_2i", plot_name)) {
      if (xx <= 100) 50000 else if (100 < xx & xx <= 500) 1/2*50000 else 1/2*2*50000
    } else if (grepl("100_500G_2i_2d", plot_name)) {
      if (xx <= 100) 50000 else if (100 < xx & xx <= 500) 2*50000 else 2*1/2*50000
    } else if (grepl("100_500G_2d_2d", plot_name)) {
      if (xx <= 100) 50000 else if (100 < xx & xx <= 500) 1/2*50000 else 1/2*1/2*50000
    } else if (grepl("100_500G_10d_10d", plot_name)) {
      if (xx <= 100) 50000 else if (100 < xx & xx <= 500) 1/10*50000 else 1/10*1/10*50000
    } else if (grepl("100_500G_2e_i_2e_d", plot_name)) {
      if (xx <= 100) 50000*(exp(log(2)/100*xx)) else if (xx <= 500) 50000*(exp(log(2)/100*100))*(exp(log(1/2)/400*(xx-100))) else 50000*(exp(log(2)/100*100))*(exp(log(1/2)/400*400))
    } else if (grepl("100_500G_2e_d_2e_i", plot_name)) {
      if (xx <= 100) 50000*(exp(log(1/2)/100*xx)) else if (xx <= 500) 50000*(exp(log(1/2)/100*100))*(exp(log(2)/400*(xx-100))) else 50000*(exp(log(1/2)/100*100))*(exp(log(2)/400*400))
## else
    } else {
      if (xx <= 100) 50000 else 50000 * 0
    }
  })
}

events <- c(
  "100_500G_2i_2i","100_500G_2d_2d","100_500G_10d_10d","100_500G_2d_2i","100_500G_2i_2d","100_500G_2e_i_2e_d","100_500G_2e_d_2e_i"
)
n_reps <- 5

# Set per-event x-axis limits
x_limits_list <- list(
  "100_500G_2i_2i"   = c(1, 1000000),
  "100_500G_2d_2d"   = c(1, 1000000),
  "100_500G_10d_10d"   = c(1, 1000000),
  "100_500G_2d_2i"   = c(1, 1000000),
  "100_500G_2i_2d"   = c(1, 1000000),
  "100_500G_2e_i_2e_d"   = c(1, 1000000),
  "100_500G_2e_d_2e_i"   = c(1, 1000000)
)

# Set per-event y-axis limits
y_limits_list <- list(
  "100_500G_2i_2i"   = c(1, 250000),
  "100_500G_2d_2d"   = c(1, 150000),
  "100_500G_10d_10d"   = c(1, 150000),
  "100_500G_2d_2i"   = c(1, 150000),
  "100_500G_2i_2d"   = c(1, 150000),
  "100_500G_2e_i_2e_d"   = c(1, 150000),
  "100_500G_2e_d_2e_i"   = c(1, 150000)
)

#x_limits_list <- setNames(
#  replicate(length(events), c(1, 1000000), simplify = FALSE),
#  events
#)

#y_limits_list <- setNames(
#  replicate(length(events), c(1, 200000), simplify = FALSE),
#  events
#)

plot_list <- list()
for (sample_size in c(20,80,200)) {
#for (sample_size in c(20)) {
  for (singleton in c("_", "_no_singleton_")) {
    for (event in events) {

      x_limits <- x_limits_list[[event]]
      y_limits <- y_limits_list[[event]]

      all_reps <- list()

      for (rep in 1:n_reps) {
        rep_path <- paste0("./ft_sim_100000Ne", singleton, sample_size, "hapS_2E_", event, "_20Chr_15Mb_", rep)
        files <- mixedsort(sort(fs::dir_ls(path = rep_path, recurse = TRUE, fail = TRUE, type = "file", glob = "*hapS*.final.summary")))
        if (length(files) == 0) next
        df <- tryCatch(read.table(files[1], header = TRUE, sep = "\t"), error = function(e) NULL)
        if (is.null(df)) next
        df$replicate <- rep
        all_reps[[rep]] <- df[, c("year", "Ne_median", "Ne_12.5.", "Ne_87.5.", "replicate")]
      }

      all_reps <- all_reps[!sapply(all_reps, is.null)]
      if (length(all_reps) == 0) next

      long_df <- do.call(rbind, all_reps)
      long_df <- long_df[long_df$year > 0, ]

      model_years <- 1:100000
      true_Ne <- fx(model_years, event)
      true_df <- data.frame(year = model_years, Ne_true = true_Ne)

      p <- ggplot() +
        geom_ribbon(data = long_df, aes(x = year, ymin = Ne_12.5., ymax = Ne_87.5., group = replicate, fill = "75% CI"), alpha = 0.3) +
        geom_line(data = long_df, aes(x = year, y = Ne_median, group = replicate, color = "Each replicate"), alpha = 0.5, size = 0.7) +
        geom_step(data = true_df, aes(x = year, y = Ne_true, color = "Model"), size = 1, alpha = 0.7) +
        scale_x_continuous(trans = "log10", limits = x_limits, labels = label_number(big.mark = "")) +
        scale_y_continuous(limits = y_limits, labels = label_number(big.mark = "")) +
        labs(title = paste0("50kNe", singleton, sample_size,"S_" , event),
             x = "Generations ago",
             y = expression(italic(N[e]))) +
        scale_color_manual(name = NULL, values = c("Model" = "red", "Each replicate" = "blue"), breaks = c("Model", "Each replicate")) +
        scale_fill_manual(name = NULL, values = c("75% CI" = "orange"), breaks = c("75% CI")) +
        guides(color = guide_legend(order = 1), fill = guide_legend(order = 2)) +
        theme_bw() +
        theme(
          plot.title = element_text(hjust = 0.5, size = 7, face = "plain"),
          axis.title = element_text(size = 7),
          axis.text.x = element_text(size = 7),
          axis.text.y = element_text(angle = 90, hjust = 0.5, size = 7),
          legend.position = if (event == "100_500G_2i_2i" && singleton == "_") c(0.3, 0.8) else "none",
          legend.background = element_rect(fill = alpha("white", 0), color = NA),
          legend.key = element_rect(fill = "white"),
          legend.text = element_text(size = 8),
          legend.margin = margin(-10, 0, 0, 0, unit = "pt"),
          legend.key.height = unit(0.5, "line"),
          axis.ticks.length.x = unit(0, "pt")
        ) +
        annotation_logticks(sides = "", short = unit(0.1, "cm"), mid = unit(0.15, "cm"), long = unit(0.2, "cm"))

      key <- paste0(sample_size, singleton, event)
      plot_list[[key]] <- p
    }
  }
}

# ----- Arrange plots in matrix layout ----- #
demographic_models <- c("2i_2i","2d_2d","10d_10d","2d_2i","2i_2d","2e_i_2e_d","2e_d_2e_i")
event_sizes <- c("100_500G")
singleton_types <- c("_", "_no_singleton_")

# Assemble final panels grouped by sample_size
plot_rows <- list()

for (sample_size in c(20, 80, 200)) {
  # Create separate rows for each singleton type
  for (singleton in singleton_types) {
    row_plots <- list()  # This will store all models for current sample_size/singleton
    
    for (event_size in event_sizes) {
      for (model in demographic_models) {
        key <- paste0(sample_size, singleton, event_size, "_", model)
        row_plots[[paste0(event_size, "_", model)]] <- if (!is.null(plot_list[[key]])) plot_list[[key]] else ggplot() + theme_void()
      }
    }
    
    # Store the complete row for this sample_size and singleton
    plot_rows[[paste0(sample_size, singleton)]] <- wrap_plots(row_plots, nrow = 1)
  }
}

# Stack sample panels vertically
final_plot <- wrap_plots(plot_rows, ncol = 1)
print(final_plot)

ggsave("50KNe_2d_2d_2i_2i_10i_10i_2d_2i_2i_2d_2ei_2ed_2ed_2ei_plot_20_80_200S.new1.pdf", final_plot, width = 17.5, height = 13.5, limitsize = FALSE) # 3 * 2 rows

# srun --mem=20g -c 10 --time=01:00:00 --pty bash
# conda activate R
# R_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal_sim_stairway_plot_2024/scripts/
# cd $R_dir
# Rscript 3_stairway_plot/50KNe_2e_i_d_10e_i_d_plot_20_80_200S.R

## 22m
