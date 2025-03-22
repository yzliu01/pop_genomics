# number of lines

test_data <- read.table("./AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_78_1500x_sm_genic.final.summary",sep="\t",header=T)
head(test_data,2)
str(test_data)
'data.frame':   30401 obs. of  11 variables:
 $ mutation_per_site    : num  4.94e-324 1.42e-06 1.93e-06 1.93e-06 2.29e-06 ...
 $ n_estimation         : int  200 200 200 200 200 200 200 200 200 200 ...
 $ theta_per_site_median: num  0.0808 0.0808 0.0808 0.0808 0.0808 ...
 $ theta_per_site_2.5.  : num  0.0167 0.0167 0.0167 0.0167 0.0167 ...
 $ theta_per_site_97.5. : num  0.2 0.2 0.2 0.2 0.2 ...
 $ year                 : num  1.37e-315 3.94e+02 5.35e+02 5.35e+02 6.35e+02 ...
 $ Ne_median            : num  5614060 5614060 5614060 5614060 5614060 ...
 $ Ne_2.5.              : num  1156728 1156728 1156728 1156728 1156728 ...
 $ Ne_97.5.             : num  13888889 13888889 13888889 13888889 13888889 ...
 $ Ne_12.5.             : num  2039716 2039716 2039716 2039716 2039716 ...
 $ Ne_87.5.             : num  11923266 11923266 11923266 11923266 11923266 ...

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

#setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/pool_downsample_genome")

library(ggplot2)
library(gridExtra)
library(gtools) # sort
library(stringi) # stri_replace_all_regex

# Get all summary files (adjust the pattern if needed)
#summary_files <- list.files(path = ".", pattern = "AndHae.*_0_[2-6]\\.no_singleton.*final\\.summary$", recursive = TRUE, full.names = TRUE)

site_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates/Hae_39_number_called_sites_across_genome.txt"
no_called_sites <- read.table(site_file, header = FALSE)
snp_file <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates/AndHae_snp_number.P_genome_01_02_03_04_05_06_07_08_09_10.DP_1_3_5_7_10x.txt"
snp_number <- read.table(snp_file, header = FALSE)
#head(no_called_sites)
#str(no_called_sites)
#print(no_called_sites[1,])
#nrow(no_called_sites)

summary_files <- list.files(path = ".", pattern = "AndHae_REF.*DP_.*x.P_.*final\\.summary$", recursive = TRUE, full.names = TRUE)

#summary_files <- list.files(path = ".", pattern = "AndHae.*_0_[2]\\.no_singleton.*final\\.summary$", recursive = TRUE, full.names = TRUE)
sorted_files <- mixedsort(summary_files,decreasing=F)

# Function to read and process each file
read_summary <- function(file, index) {
  data <- read.table(file,sep="\t",header=T)  # Adjust column names if needed
  data$no_called_sites <- no_called_sites[index,1] # assign the corresponding number
  data$snp_number <- snp_number[index,1] # assign the corresponding number
  data$file <- basename(file)  # Add filename for labeling
  data$file <- stri_replace_all_regex(
    data$file,
    #pattern=c("AndHae_New_REF_",".no_singleton_sfs","_sm_genic.final.summary"),
    #replacement=c("","P.DP",""),
    pattern=c(".final.summary"),
    replacement=c(""),
    vectorize=F
  )
  # "AndHae_New_REF_AndHae_0_2.no_singleton_sfs_117_1500x_sm_genic.final.summary"
  return(data)
}


# Read all files into a list of dataframes
summary_list <- lapply(seq_along(sorted_files), function(i) read_summary(sorted_files[i],i))

#valid_summaries <- summary_list[sapply(summary_list, function(x) is.data.frame(x) && nrow(x) > 0)]

# Function to plot data
plot_summary_legend <- function(data) {
  ggplot(data, aes(x = year)) +  # Adjust column names
    scale_x_continuous(limits= c(10,200000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(limits= c(1,500000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
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
    annotate("text", x = 98000, y = 300000, label = paste("Site No: ", unique(data$no_called_sites)),
    size = 2.7, hjust = 0, fondface = "plain", color = "black") +
    annotate("text", x = 98000, y = 250000, label = paste("SNP No: ", unique(data$snp_number)),
    size = 2.7, hjust = 0, fondface = "plain", color = "black") +

    theme(
        axis.text.y = element_text(angle = 60, vjust = 1, hjust=0.5),
        panel.border = element_rect(linewidth = 1.5, color = "black", fill=NA),
        plot.title = element_text(size=10),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10),
        axis.ticks = element_line(colour = "black", size = 1.5),
        #legend.position = "top",
        legend.position = c(0.65, 0.75), 
        legend.key.width=unit(1, "cm"), 
        legend.text = element_text(size = 10),
        legend.background = element_rect(fill = "transparent"),
        ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
        legend.margin =  margin(-12,0,0,0,unit="pt")
      ) +
      labs(x = "Years ago", y = expression(paste(italic("N")["e"])))

}

plot_summary <- function(data) {
  ggplot(data, aes(x = year, y = Ne_median)) +  # Adjust column names
    scale_x_continuous(limits= c(10, 200000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(limits= c(1, 500000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    geom_ribbon(aes(ymin = Ne_2.5., ymax = Ne_97.5.), fill = "darkorange", alpha = 0.3) +
    geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5.), fill = "blue", alpha = 0.3) +
    # without showing legend
    geom_line(color = "red", linewidth = 1, alpha = 1) +

    geom_vline(xintercept = 12000, color = "black", linetype = "dotted", size=0.5) +

    ggtitle(unique(data$file)) +  # Title as filename

    # Add annotation for `no_called_sites`
    annotate("text", x = 98000, y = 300000, label = paste("Site No: ", unique(data$no_called_sites)),
    size = 2.7, hjust = 0, fondface = "plain", color = "black") +
    annotate("text", x = 98000, y = 250000, label = paste("SNP No: ", unique(data$snp_number)),
    size = 2.7, hjust = 0, fondface = "plain", color = "black") +

    theme(
        plot.title = element_text(size=10),
        axis.text.y = element_text(angle = 60, vjust = 1, hjust=0.5),
        panel.border = element_rect(linewidth = 1.5, fill=NA),
        axis.text = element_text(size=8),
        axis.title = element_text(size=10),
        axis.ticks = element_line(colour = "black", size = 1.5)
      ) +
      labs(x = "Years ago", y = expression(paste(italic("N")["e"])))

}

# Generate a list of plots
#plot_list <- lapply(summary_list, plot_summary)

plot_list <- list() # intialize empty list

for (i in 1:length(sorted_files)){
    #print(sorted_files[i])
    if (i == 1){

    plot_list <- list(plot_summary_legend(summary_list[[i]])) # use [[i]]

    } else {
    
    plot_list <- append(plot_list,list(plot_summary(summary_list[[i]])))
    
    }

}

# Arrange all plots in a single row
pdf("AndHae_downsample_stairway_plot.called_sites_snps.pdf", width = 30, height = 15)
grid.arrange(grobs = plot_list, nrow = 5)
dev.off()




********************* test **************

for (i in 1:length(file_list_a)){
#for (group in file_list){

    ## key step
    ## conditional axis name plot
    ## plot a frame
    file_path <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[i]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
    file_path <- file_path[1]
    data <- read.table(file_path,header=TRUE,sep="\t")

    ## Determine which titles to show based on the plot position
    #y_axis_title <- ifelse(i %in% c(1, 4, 7), expression(paste(italic("N")["e"])), NULL)
    #x_axis_title <- ifelse(i %in% c(7, 8, 9), "Year ago", NULL)

    ## Determine which titles to show based on the plot position
    print(i) # Add this line to see the value of i
    #if (i %in% c(1,2,3)) {
    if (i %in% c(1,2,3)) {
        y_axis_title <- expression(paste(italic("N")["e"]," ", "(", italic("A. marginata"), ")"))
    } else {
        y_axis_title <- NULL
    }
    print(y_axis_title) # Add this line to see the value of y_axis_title
    
    #x_axis_title <- if (i %in% c(1,2,3,4,5,6,7,8,9)) "Year ago" else NULL
    x_axis_title <- if (i %in% c(3,6,9,12,15)) "Year ago" else NULL
    ##print(x_axis_title) # Add this line to see the value of x_axis_title

    if (i == 1){
p1_initial <- ggplot(data = data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(limits= c(10,100000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(limits= c(1,200000), labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    # add labels on y axis: breaks = seq(0, 150000, by = 25000),
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5., fill = "75%_CI"), alpha = 0.3) +
    # showing legend
    geom_line(aes(y = Ne_median, color = "Ne_median"), linewidth = 0.7, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +

    ## add legend manually
    scale_color_manual(values = c("Ne_median" = "red"), labels = expression(paste(italic("N")["e"]," median"))) +
    scale_fill_manual(values = c("75%_CI" = "blue"), labels = "75% CI") +
    ## legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
    ## revise legend line width: https://stackoverflow.com/questions/28872875/ggplot2-applying-width-of-line-to-the-legend-key
    guides(color = guide_legend(title = NULL,order = 1, override.aes = list(linewidth = 1.5)),
    fill = guide_legend(title = NULL, order = 2, byrow = TRUE, override.aes = list(linewidth = 4))) +

} else {

p1_initial <- ggplot(data = data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(limits= c(10,100000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(limits= c(1,200000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    # breaks = seq(0, 150000, by = 25000),
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.), fill = "blue", alpha = 0.3) +
    # without showing legend
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.7, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +

}
}


file <- "AndHae_New_REF_AndHae_0_2.no_singleton_sfs_117_1500x_sm_genic/AndHae_New_REF_AndHae_0_2.no_singleton_sfs_117_1500x_sm_genic.final.summary"
test_data$file <- basename(file)
head(test_data)
ggplot(test_data, aes(x = year, y = Ne_median)) +  # Adjust column names
    geom_line() +
    ggtitle(unique(test_data$file)) +  # Title as filename
    theme_minimal()


library(stringr)  # Make sure stringr is loaded

data$title <- str_replace_all(
  data$title,
  c("AndHae_New_REF_" = "", "no_singleton_sfs" = "DP_", "_sm_genic.final.summary" = "")
)

