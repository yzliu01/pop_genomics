

library(scales)
library(ggplot2)


data_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100KNe_swp/ft_sim_100000Ne_80hapS_1E_100G_05i_20Chr_15Mb_3/ft_sim_100000Ne_80hapS_1E_100G_05i_20Chr_15Mb_3.final.summary"
data <- read.table(data_file,header=T,sep="\t")
head(data$year)
new_data <- data[,c("year","Ne_median","Ne_12.5.","Ne_87.5.")]
head(new_data)

#p <-

ggplot() +
    ## Ribbon with fill legend
    geom_ribbon(data = new_data, 
            #aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., fill = "95% CI"),
            aes(x = year, ymin = Ne_12.5., ymax = Ne_87.5., fill = "75% CI"),
            alpha = 0.3) +

    # Line with color legend
    #geom_line(data = new_data, 
    #        aes(x = year, y = Ne_median), 
    #        alpha = 0.5, size = 0.7) +

    # Step for Model with color legend
    geom_step(data = new_data, 
            aes(x = year, y = Ne_median, color = "Model"), 
            size = 1, alpha = 0.8) +
    scale_x_continuous(limits = c(0, 10000),breaks = c(0,10, 1000, 10000),labels = label_number(big.mark = "")) +
    #scale_x_log10(limits = c(1.372404573E-315, 10000),breaks = c(10, 100, 1000, 10000),labels = label_number(big.mark = "")) +
    #limits = c(0, 10000),
    
    #scale_x_continuous(trans = "log10",limits = c(1, 10000), labels = label_number(big.mark = "")) +
    #scale_y_continuous(limits = c(10, 125000), labels = label_number()) +
    scale_y_continuous(limits = c(0, 1000000), labels = label_number(big.mark = "")) +

    # Color and fill scales to generate legend entries
    scale_color_manual(name = NULL, 
                    values = c("Model" = "red"),
                    breaks = c("Model")  # Desired order
                    #labels = c("Each median Ne" = expression(paste("Each median ", italic(N)[e])), "Model" = "Model")
                    ) +

    scale_fill_manual(name = NULL, values = c("75% CI" = "orange")) +
    theme_bw()


 # Sample data
    data <- data.frame(
      x = c(0.000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
    00000000000000000000000000001, 100),
      y = c(10, 6000)
    )
 
    # Create the plot with log-scaled x-axis
    ggplot(data, aes(x = x, y = y)) +
      geom_step() +
      scale_x_continuous(limits = c(30, 10000))



    #geom_ribbon(data = new_data, aes(x = year, ymin = Ne_2.5., ymax = Ne_97.5., group = replicate),
    #            fill = "orange", alpha = 0.3) +
    #geom_line(data = new_data, aes(x = year, y = Ne_median, group = replicate),
    #          color = "blue", alpha = 0.5, size = 0.7) +
    #geom_step(data = true_df, aes(x = year, y = Ne_true, color = "Model"),
    #          size = 1, alpha = 0.8) +

    scale_x_continuous(limits = c(0, 100000), labels = label_number(big.mark = "")) +
    #scale_y_continuous(limits = c(10, 200000), labels = label_number()) +
    #scale_x_continuous(trans = "log10",limits = x_limits, labels = label_number(big.mark = "")) +
    #scale_y_continuous(limits = c(10, 125000), labels = label_number()) +
    scale_y_continuous(limits = c(0, 10000), labels = label_number(big.mark = "")) +

    labs(title = paste0(event),
         x = "Generations ago",
         y = "Effective population size") +

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

print(p)
