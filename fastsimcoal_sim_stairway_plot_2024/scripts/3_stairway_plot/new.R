x <- 0:100000
        #plot_name <- c("10000Ne_80hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_80hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_80hapS_1E_1000G_1.9i_20Chr_15Mb","10000Ne_80hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
        ## category
        ## 50G "G_2e_d_cons" (r=-0.0139,er=0.9862),"G_2e_i_cons" (r=0.0139,er=1.0140),"G_10e_d_cons" (r=-0.0461,er=0.9549),"G_10e_i_cons" (r=0.0461,er=1.0472) # nolint
        ## 100G "G_2e_d_cons" (r=-0.0069,er=0.9931),"G_2e_i_cons" (r=0.0069,er=1.0069),"G_10e_d_cons" (r=-0.0230,er=0.9773),"G_10e_i_cons" (r=0.0230,er=1.0233)
        ## 500G "G_2e_d_cons" (r=-0.0014,er=0.9986),"G_2e_i_cons" (r=0.0014,er=1.0014),"G_10e_d_cons" (r=-0.0046,er=0.9954),"G_10e_i_cons" (r=0.0046,er=1.0046)
        ## 1000G "G_2e_d_cons" (r=-0.0007,er=0.9993),"G_2e_i_cons" (r=0.0007,er=1.0007),"G_10e_d_cons" (r=-0.0023,er=0.9977),"G_10e_i_cons" (r=0.0023,er=1.0023)

        ## er=λ; (er)t=λt 

fx <- function(x) {
            if (all(sapply(c("G_cons_cons"), grepl, plot_name))) {
                ## constant Ne
                return(5000)
            
            ## gen_100
            } else if (all(sapply(c("50G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(5000*(0.9862^x))
                } else {
                    return(5000*(0.9862^50))
                }
            } else if (all(sapply(c("50G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(1.0140^x))
                } else {
                    return(5000*(1.0140^50))
                }
            } else if (all(sapply(c("50G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(0.9549^x))
                } else {
                    return(5000*(0.9549^50))
                }
            } else if (all(sapply(c("50G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(1.0472^x))
                } else {
                    return(5000*(1.0472^50))
                }
            
            ## gen_100
            } else if (all(sapply(c("100G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(0.9931^x))
                } else {
                    return(5000*(0.9931^100))
                }
            } else if (all(sapply(c("100G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(1.0069^x))
                } else {
                    return(5000*(1.0069^100))
                }
            } else if (all(sapply(c("100G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(0.9773^x))
                } else {
                    return(5000*(0.9773^100))
                }
            } else if (all(sapply(c("100G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(1.0233^x))
                } else {
                    return(5000*(1.0233^100))
                }
            
            ## gen_500
            } else if (all(sapply(c("500G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(5000*(0.9986^x))
                } else {
                    return(5000*(0.9986^500))
                }
            } else if (all(sapply(c("500G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(1.0014^x))
                } else {
                    return(5000*(1.0014^500))
                }
            } else if (all(sapply(c("500G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(0.9954^x))
                } else {
                    return(5000*(0.9954^500))
                }
            } else if (all(sapply(c("500G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(1.0046^x))
                } else {
                    return(5000*(1.0046^500))
                }
            
            ## gen_1000
            } else if (all(sapply(c("1000G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000*(0.9993^x))
                } else {
                    return(5000*(0.9993^1000))
                }
            } else if (all(sapply(c("1000G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                     return(5000*(1.0007^x))
                } else {
                    return(5000*(1.0007^1000))
                }
            } else if (all(sapply(c("1000G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000*(0.9977^x))
                } else {
                    return(5000*(0.9977^1000))
                }
            # } else if (all(sapply(c("1000G","G_0.5e_d_1.5i"), grepl, plot_name))) {
            } else {
                if (x <= 1000) {
                    return(5000*(1.0023^x))
                } else {
                    return(5000*(1.0023^1000))
                }
            #} else {
            #    ## return empty value
            #    NULL
            #    #return(NULL)
            }
        }
lines(x,sapply(x,fx),type="s",lwd=2.5,col = adjustcolor("red", alpha = 0.8))














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

library(scales)

# Custom tick positions
#x_ticks <- c(50, 100, 500, 1000, 10000, 100000)
#y_ticks <- c(5000, 10000, 20000)


events <- c("50G_1.5i", "1000G_1.9i")
#n_reps <- 5
n_reps <- 2
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

  long_df <- do.call(rbind, all_reps)

  # Filter only where year > 0 for plotting with log10
  long_df <- long_df[long_df$year > 0, ]

  # True model
  true_Ne <- fx(long_df$year, event)
  true_df <- data.frame(year = long_df$year, Ne_true = true_Ne)

  # Plot
  p <- ggplot() +
    geom_ribbon(data = long_df, 
                aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate, fill = "95% CI"),
                alpha = 0.3) +

    geom_line(data = long_df, 
              aes(x = year, y = Ne_median, group = replicate, color = "Each replicate"), 
              alpha = 0.5, size = 0.7) +

    geom_step(data = true_df, 
              aes(x = year, y = Ne_true, color = "True model"), 
              size = 1, alpha = 0.8) +

    #scale_x_continuous(limits = c(10, 100000), breaks = x_ticks, labels = label_number(big.mark = "")) +

      scale_x_log10(limits = c(0.001, 5e5), 
                    breaks = c(0.001, 50, 100, 500, 1000, 10000, 100000),
                    labels = format(c(0.001, 50, 100, 500, 1000, 10000, 100000), scientific = FALSE)) +
      scale_y_continuous(limits = c(30000, 1.0e5),
                        breaks = c(50000, 75000, 100000),
                        labels = format(c(50000, 75000, 100000), scientific = FALSE)) +

    #scale_x_continuous(trans = "log10", limits = c(1, 100000), labels = label_number(big.mark = "")) +
    #scale_y_continuous(limits = c(1, 200000), breaks = y_ticks, labels = label_number(big.mark = "")) +

    labs(title = paste0("50000Ne_with_singleton_", event),
         x = "Generations ago",
         y = "Effective population size") +

    scale_color_manual(name = NULL, 
                       values = c("True model" = "red", "Each replicate" = "blue"),
                       breaks = c("True model", "Each replicate")) +

    scale_fill_manual(name = NULL, 
                      values = c("95% CI" = "orange"),
                      breaks = c("95% CI")) +

    guides(
      color = guide_legend(order = 1),
      fill = guide_legend(order = 2)
    ) +

    theme_bw() +
    theme(
      plot.title = element_text(hjust = 0.5, size = 10, face = "plain"),
      axis.title = element_text(size = 10),
      axis.text = element_text(size = 10),
      legend.position = if (i == 1) c(0.72, 0.8) else "none",
      legend.background = element_rect(fill = alpha("white", 0), color = NA),
      legend.key = element_rect(fill = "white"),
      legend.text = element_text(size = 10),
      legend.margin =  margin(-14,0,0,0,unit="pt"),
      axis.ticks.length.x = unit(0, "pt")
    ) +

    annotation_logticks(
      sides = "b",
      short = unit(0.1, "cm"),
      mid = unit(0.15, "cm"),
      long = unit(0.2, "cm")
    )

  plot_list[[event]] <- p
}

# Combine plots
combined_plot_95CI_with_singleton <- plot_list[[events[1]]] | plot_list[[events[2]]]
print(combined_plot_95CI_with_singleton)

# Save to PDF
ggsave(filename = "./combined_plot_40S_50G_05d_1000G_09d_5_replicates_with_95CI_with_singleton.2-new1.pdf",
       plot = combined_plot_95CI_with_singleton, width = 12, height = 6)





mutation_per_site	n_estimation	theta_per_site_median	theta_per_site_2.5%	theta_per_site_97.5%	year	Ne_median	Ne_2.5%	Ne_97.5%	Ne_12.5%	Ne_87.5%
4.9E-324	200	0.0010643	0.0010437489583333334	0.001302165625	1.372404573E-315	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.607643893493371E-7	200	0.0010643	0.0010437489583333334	0.001302165625	44.656774819260306	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.6278208688954855E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.21724635820793	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.6278208688954855E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.21724635820793	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.6376840150897025E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.491222641380624	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.6376840150897025E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.491222641380624	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.643437564792826E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.65104346646739	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.643437564792826E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.65104346646739	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964
1.6475390050026632E-7	200	0.0010643	0.0010437489583333334	0.001302165625	45.76497236118509	73909.72222222222	72482.56655092593	90428.16840277778	73394.88570601851	79921.81712962964

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal_sim_stairway_plot_2024/scripts/3_stairway_plot")
df <- read.table("data.txt",header = T, sep = "\t")
head(df$year)
head(df$Ne_97.5.)

summary(df[["Ne_2.5%"]])
summary(df[["Ne_97.5%"]])

# Assuming your data is in a dataframe called 'df'
plot(df$year, df$Ne_median, type = "s", pch = 19, col = "blue",
     #ylim = range(c(df[["Ne_2.5%"]], df[["Ne_97.5%"]])),
     ylim = range(c(df$Ne_2.5., df$Ne_97.5.)),
     xlab = "Year (log scale)", ylab = "Effective Population Size (Ne)",
     main = "Median Ne with 95% CI over Time",
     log = "x")  # Set log scale for x-axis

lines(df$year, df$Ne_median, type="l",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))

# Add confidence intervals
arrows(df$year, df$Ne_2.5., df$year, df$Ne_97.5., 
       length = 0.05, angle = 90, code = 3, col = "gray")


library(ggplot2)

ggplot(df, aes(x = year, y = Ne_median)) +
  geom_line(color = "blue") +
  geom_point(color = "blue") +
  geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.), alpha = 0.2, fill = "blue") +
  scale_x_log10() +  # Set log10 scale for x-axis
  labs(x = "Year (log scale)", y = "Effective Population Size (Ne)",
       title = "Median Ne with 95% CI over Time") +
  theme_minimal()

