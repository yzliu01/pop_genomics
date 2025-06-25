
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/2025_pools"
setwd(result_path)

library(ggplot2)
library(gridExtra)
library(gtools) # sort
library(stringi) # stri_replace_all_regex
library(stringr)
# Get all summary files (adjust the pattern if needed)
#summary_files <- list.files(path = ".", pattern = "AndMar.*_0_[2-6]\\.no_singleton.*final\\.summary$", recursive = TRUE, full.names = TRUE)

## 3 pools test
#site_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates/Cerryb_50_number_called_sites_across_genome.txt"
#no_called_sites <- read.table(site_file, header = FALSE)
#snp_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates/Cerryb_snp_number.DP_1_3_5_7_10x.txt"
#snp_number <- read.table(snp_file, header = FALSE)

#for species in {AelAcu,AgeAln,AmpSol,EriInt,EriPer,GerLac,LasMor,LepDol,MalBip,MysLon,PhoAtr,RhaFul,TacFer,ThoDec,XesC-n};do

## 16 pools
## for DP_1_1.5x
site_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates/AelAcu_50_number_called_sites_across_genome.txt"
no_called_sites <- read.table(site_file, header = FALSE)
snp_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates/AelAcu_snp_number.DP_1_1.5x.txt"
snp_number <- read.table(snp_file, header = FALSE)

#head(no_called_sites)
#str(no_called_sites)
#print(no_called_sites[1,])
#nrow(no_called_sites)

## ./AelAcu_REF_AelAcu.DP_1x/AelAcu_REF_AelAcu.DP_1x.final.summary
summary_files <- list.files(path = ".", pattern = "AelAcu_REF_AelAcu.*DP_.*x.*final\\.summary$", recursive = TRUE, full.names = TRUE)

## Extract P value (digits after "AndHae." and before "P")
#p_values <- as.numeric(str_extract(summary_files, "(?<=AndMar\\.)\\d+(?=P)"))

## Extract DP value (digits after "DP_" and before "x")
#dp_values <- as.numeric(str_extract(summary_files, "(?<=DP_)\\d+(?=x)"))

## Order by DP descending, then P ascending
#sorted_order <- order(dp_values, p_values)
#sorted_files <- summary_files[sorted_order]

## old sorting
#summary_files <- list.files(path = ".", pattern = "AndMar.*_0_[2]\\.no_singleton.*final\\.summary$", recursive = TRUE, full.names = TRUE)
#sorted_files <- mixedsort(summary_files,decreasing=F)

## first to get the last three files
sorted_files <- tail(mixedsort(summary_files,decreasing=F),5)

## then to first three
#sorted_files <- head(tail(mixedsort(summary_files,decreasing=F),5),3)
#[1] "./AelAcu_REF_AelAcu.DP_1x/AelAcu_REF_AelAcu.DP_1x.final.summary"
#[2] "./AelAcu_REF_AelAcu.DP_1.5x/AelAcu_REF_AelAcu.DP_1.5x.final.summary"
#[3] "./AelAcu_REF_AelAcu.DP_2x/AelAcu_REF_AelAcu.DP_2x.final.summary" 

# Function to read and process each file
read_summary <- function(file, index) {
  data <- read.table(file,sep="\t",header=T)  # Adjust column names if needed
  data$no_called_sites <- no_called_sites[index,1] # assign the corresponding number
  data$snp_number <- snp_number[index,1] # assign the corresponding number
  data$file <- basename(file)  # Add filename for labeling
  data$file <- stri_replace_all_regex(
    data$file,
    #pattern=c("AndMar_New_REF_",".no_singleton_sfs","_sm_genic.final.summary"),
    #replacement=c("","P.DP",""),
    pattern=c("AelAcu_REF_AelAcu",".final.summary"),
    replacement=c("AelAcu",""),
    vectorize=F
  )
  # "AndMar_New_REF_AndMar_0_2.no_singleton_sfs_117_1500x_sm_genic.final.summary"
  return(data)
}


# Read all files into a list of dataframes
summary_list <- lapply(seq_along(sorted_files), function(i) read_summary(sorted_files[i],i))

#valid_summaries <- summary_list[sapply(summary_list, function(x) is.data.frame(x) && nrow(x) > 0)]

library(dplyr) # for label_data to label x = 100

# Function to plot data
plot_summary_legend <- function(data) {

# Find the y-value where x ≈ 100 (adjust tolerance if needed)
    #label_data <- data %>% 
    #    filter(abs(year - 100) == min(abs(year - 100)))  # Nearest x to 100
    # got two value label
    #print(label_data)

## obtain only one label
    label_data <- data %>%
    mutate(distance = abs(year - 100)) %>%
    filter(distance == min(distance)) %>%
    slice_sample(n = 1)
    print(label_data)

  ggplot(data, aes(x = year)) +  # Adjust column names
    #scale_x_continuous(limits= c(10,500000),labels = function(year) format(year, scientific = FALSE)) +
    scale_x_log10(limits= c(10,500000),labels = function(year) format(year, scientific = FALSE)) +
#    scale_y_continuous(limits= c(1,2500000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    scale_y_log10(limits= c(100,2500000),breaks = c(1000, 10000,100000,1000000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +

    # fill color should be in the aesthetics
    geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5., fill = "95% CI"), alpha = 0.3) +
    geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5., fill = "75% CI"), alpha = 0.3) +
    # without showing legend
    geom_line(aes(y = Ne_median, color = "Median Ne"), linewidth = 1, alpha = 1) +
    
    geom_vline(aes(xintercept = 12000, linetype = "Ice Age"), color = "black", size=0.5) +

    # manually define fill color for the legend 
    
    # ATTENTION: in reverse order
    scale_fill_manual(name = NULL, values = c("75% CI" = "blue", "95% CI" = "darkorange"), labels = c("75% CI", "95% CI")
    #,                guide = guide_legend(order = 1, byrow = TRUE, override.aes = list(alpha = c(0.3, 0.3), keywidth =2, keyheight = 0.5))
    ) +

    scale_color_manual(name = NULL, values = c("red"), labels = c(expression(paste("Median ", italic("N")["e"])))) +

    scale_linetype_manual(name = NULL, values = c("Ice Age" = "dotted"), labels = c("12000 Years Ago")) +

    ## add legend manually
    #scale_fill_manual(values = c("blue", "orange"), labels = c("95% CI", "75% CI")) +
    #scale_color_manual(values = c("red"), labels = expression(paste(italic("N")["e"]," median"))) +
    ## legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
    ## revise legend line width: https://stackoverflow.com/questions/28872875/ggplot2-applying-width-of-line-to-the-legend-key
    guides(
        fill = guide_legend(order = 1, reverse = TRUE, byrow = TRUE, override.aes = list(alpha = c(0.3, 0.3)), keywidth = 1, keyheight = 0.5), # orange, blue order , keywidth =2, keyheight = 0.5
        color = guide_legend(order = 2, override.aes = list(linetype = 1, linewidth = 1), keywidth = 1, keyheight = 0.5),
        linetype = guide_legend(order = 3, override.aes = list(linewidth = 0.5), keywidth = 1, keyheight = 1)  # Ensure the event legend is last
        ) +

    ggtitle(unique(data$file)) +  # Title as filename

    # Add annotation for `no_called_sites`
    annotate("text", x = 10, y = 2000000, label = paste("Site No: ", unique(data$no_called_sites)),
    size = 3, hjust = 0, fontface = "plain", color = "black") +
    annotate("text", x = 10, y = 1000000, label = paste("SNP No: ", unique(data$snp_number)),
    size = 3, hjust = 0, fontface = "plain", color = "black") +

    theme(
        axis.text.y = element_text(angle = 60, vjust = 1, hjust=0.5),
        panel.border = element_rect(linewidth = 1.5, color = "black", fill=NA),

## customise panel grid
        #panel.grid.major.y = element_line(color = "blue", linewidth = 0.1),
        #panel.grid.minor.y = element_line(color = "blue", linewidth = 0.1),
        #panel.grid.minor.x = element_line(color = "blue", linewidth = 0.1),

        plot.title = element_text(size=10),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10),
        axis.ticks = element_line(colour = "black", size = 0.5),
        legend.position = "none",
        ## non_log
        #legend.position = c(0.65, 0.75), 
        ## log
        #legend.position = c(0.35, 0.9),         
        legend.key.width=unit(1, "cm"), 
        legend.text = element_text(size = 10),
        legend.background = element_rect(fill = "transparent"),
        ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
        legend.margin =  margin(-12,0,0,0,unit="pt")
        ) +

    labs(x = "Years ago", y = expression(paste(italic("N")["e"]))) +
      
## add y value when x = 100 years
    geom_point(data = label_data, aes(y = Ne_median), color = "blue") +  # Optional: Add a point
    geom_text(
    data = label_data,
    aes(y = Ne_median, label = paste0("italic(N)[e]==", round(Ne_median, 0))),
    parse = TRUE,  # This is key for math expressions
    color = "blue", hjust = 0,vjust = -1, size = 3
    ## vjust=0.5 center; -0.3 upper; 0.6 down; hjust = -1 to the right
    ) +
  
    ## add log ticks on x axis
    annotation_logticks(
        sides = "bl",
        short = unit(0.1, "cm"),  # Adjust size of short ticks
        mid = unit(0.15, "cm"),     # Adjust size of medium ticks
        long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
        )

}

plot_summary <- function(data) {
  ggplot(data, aes(x = year, y = Ne_median)) +  # Adjust column names
    #scale_x_continuous(limits= c(10, 300000),labels = function(year) format(year, scientific = FALSE)) +
    #scale_x_log10(limits= c(10,30000),labels = function(year) format(year, scientific = FALSE)) +
    #scale_y_continuous(limits= c(1, 60000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +

    scale_x_log10(limits= c(10,500000),labels = function(year) format(year, scientific = FALSE)) +
#    scale_y_continuous(limits= c(1,2500000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    scale_y_log10(limits= c(100,2500000),breaks = c(1000, 10000,100000,1000000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +

    geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.), fill = "darkorange", alpha = 0.3) +
    geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.), fill = "blue", alpha = 0.3) +
    # without showing legend
    geom_line(color = "red", linewidth = 1, alpha = 1) +

    geom_vline(xintercept = 12000, color = "black", linetype = "dotted", size=0.5) +

    ggtitle(unique(data$file)) +  # Title as filename

    # Add annotation for `no_called_sites`
    #annotate("text", x = 100, y = 40000, label = paste("Site No: ", unique(data$no_called_sites)),
    #size = 2.7, hjust = 0, fontface = "plain", color = "black") +
    #annotate("text", x = 100, y = 35000, label = paste("SNP No: ", unique(data$snp_number)),
    #size = 2.7, hjust = 0, fontface = "plain", color = "black") +

    annotate("text", x = 10, y = 2000000, label = paste("Site No: ", unique(data$no_called_sites)),
    size = 3, hjust = 0, fontface = "plain", color = "black") +
    annotate("text", x = 10, y = 1000000, label = paste("SNP No: ", unique(data$snp_number)),
    size = 3, hjust = 0, fontface = "plain", color = "black") +

    theme(
        plot.title = element_text(size=10),
        axis.text.y = element_text(angle = 60, vjust = 1, hjust=0.5),
        panel.border = element_rect(linewidth = 1.5, fill=NA),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10),
        axis.ticks = element_line(colour = "black", size = 0.5)
        ) +
      labs(x = "Years ago", y = expression(paste(italic("N")["e"]))) +

      ## add log ticks on x axis
      annotation_logticks(
        sides = "bl",
        short = unit(0.1, "cm"),  # Adjust size of short ticks
        mid = unit(0.15, "cm"),     # Adjust size of medium ticks
        long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
        )

}

# Generate a list of plots
#plot_list11 <- lapply(summary_list, plot_summary)

plot_list11 <- list() # intialize empty list

for (i in 1:length(sorted_files)){
    #print(sorted_files[i])
    #if (i == 1){
    if (i == 2){
    #if (i %in% c(1, 2)){

    #plot_list112 <- list(plot_summary_legend(summary_list[[i]])) # use [[i]]
    plot_list11 <- append(plot_list11,list(plot_summary_legend(summary_list[[i]]))) # use [[i]]

    } else {
    
    plot_list11 <- append(plot_list11,list(plot_summary(summary_list[[i]])))
    
    }

}

# Arrange all plots in a single row
#pdf("AelAcu_stairway_plot.called_sites_snps.pdf", width = 20, height = 6)
## 3 pools test
#pdf("AelAcu_stairway_plot.called_sites_snps.x_log.pdf", width = 20, height = 6)
#grid.arrange(grobs = plot_list11, nrow = 1)

## 10 pools
pdf("AelAcu_stairway_plot.called_sites_snps.final.xy_log.label.pdf", width = 20, height = 4)
grid.arrange(grobs = plot_list11, nrow = 1)
dev.off()



# Combine plots with patchwork
combined_plot11 <- marrangeGrob(grobs = plot_list11,ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = FALSE))


## 5 rows (1x, 1.5x, 2x, 2.5x, 3x)
combined_plot11 <- marrangeGrob(grobs = plot_list11,ncol = 1, nrow = 5, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 5, byrow = TRUE))


## 2 rows (1x, 1.5x)
combined_plot11_new <- marrangeGrob(grobs = plot_list11[1:2],ncol = 1, nrow = 2, top=NULL,
                            layout_matrix = matrix(seq_len(2), nrow = 2, byrow = TRUE))


## Verify ggplot objects: Ensure that combined_plot1, combined_plot2, and combined_plot3 are all valid ggplot objects
class(combined_plot1)
class(combined_plot2)
class(combined_plot3)
## Make sure that the plots are not empty. If any of these returns 0, it means the plot is empty or not created properly.
length(combined_plot1)
length(combined_plot2)
length(combined_plot3)


library(patchwork)

pdf_file <- file.path(result_path,"all_16_pools_combined_1_1.5x.final.pdf")
#combined_plot <- combined_plot1 + combined_plot2 + combined_plot3 + plot_layout(ncol = 1, nrow = 3)
#ggsave(pdf_file,combined_plot,width = 18, height = 15, limitsize = FALSE)
# Error in combined_plot1 + combined_plot2 : 
# non-numeric argument to binary operator

***************************************************
# Ensure combined_plot1, combined_plot2, and combined_plot3 are not empty
# and contain the correct plots. If they are lists of plots, we need to wrap them.
combined_plot <- wrap_plots(c(combined_plot1, combined_plot9, combined_plot11, 
                            combined_plot3, combined_plot5,
                            combined_plot2,
                            combined_plot6,
                            combined_plot7,combined_plot8,
                            combined_plot4)) + plot_layout(ncol = 10, nrow = 1)

# Save the combined plot as a PDF
ggsave(pdf_file, combined_plot, width = 36, height = 18, limitsize = FALSE)




***************************************************
pdf_file <- file.path(result_path,"all_16_pools_combined_1_1.5x.xy_log.pdf")

# Ensure combined_plot1, combined_plot2, and combined_plot3 are not empty
# and contain the correct plots. If they are lists of plots, we need to wrap them.
combined_plot <- wrap_plots(c(combined_plot12_new,combined_plot13_new,combined_plot19_new,combined_plot21_new,combined_plot23_new, 
                            combined_plot17_new,
                            combined_plot14_new,combined_plot15_new,combined_plot24_new,
                            combined_plot11_new,combined_plot16_new,combined_plot18_new,
                            combined_plot24_new,combined_plot25_new,
                            combined_plot20_new
                            )) + plot_layout(ncol = 5, nrow = 3)

# Save the combined plot as a PDF
ggsave(pdf_file, combined_plot, width = 15, height = 18, limitsize = FALSE)

