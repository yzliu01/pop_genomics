
library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)
library(yarrr)
library(plotrix)
library(ggpubr)

library(sp)
library(ggplot2)
library(grid) # for unit
library(gridExtra) # for grid.arrange

##########################  final #####################################

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/pool_shuf_downsample_genome"
setwd(result_path)

file_list_a <- c(     
                #1x
                "AndHae_REF_AndHae.with_singleton.DP_1x.P_10",
                "AndMar_REF_AndMar.with_singleton.DP_1x.P_10",
                "BomPas_REF_BomPas.with_singleton.DP_1x.P_10",
                "BomVet_REF_BomVet.with_singleton.DP_1x.P_10"

                #1x
                #"AndHae_New_REF_AndHae.with_singleton_sfs_234P_10.with_singleton",
                #"AndMar_New_REF_AndMar.with_singleton_sfs_240P_10.with_singleton",
                #"BomPas_New_REF_BomPas.with_singleton_sfs_204P_10.with_singleton",
                #"BomVet_New_REF_BomVet.with_singleton_sfs_174P_10.with_singleton"

                #5X
                #"AndHae_New_REF_AndHae.with_singleton_sfs_390P_10.with_singleton",
                #"AndMar_New_REF_AndMar.with_singleton_sfs_400P_10.with_singleton",
                #"BomPas_New_REF_BomPas.with_singleton_sfs_340P_10.with_singleton",
                #"BomVet_New_REF_BomVet.with_singleton_sfs_290P_10.with_singleton"

                #7X
                #"AndHae_New_REF_AndHae.with_singleton_sfs_546P_10.with_singleton",
                #"AndMar_New_REF_AndMar.with_singleton_sfs_560P_10.with_singleton",
                #"BomPas_New_REF_BomPas.with_singleton_sfs_476P_10.with_singleton",
                #"BomVet_New_REF_BomVet.with_singleton_sfs_416P_10.with_singleton"               
)

file_list_b <- c(
                # hae
                expression(paste("Closest Ref: ", italic("A. haemorrhoa"), " | Divergence Time: 0 Mya | Cov: 1x")), 
                # mar
                expression(paste("Closest Ref: ", italic("A. marginata"), " | Divergence Time: 0 Mya | Cov: 1x")), 
                # pas
                expression(paste("Closest Ref: ", italic("B. pascuorum"), " | Divergence Time: 0 Mya | Cov: 1x")),          
                # vet
                expression(paste("Closest Ref: ", italic("B. veteranus"), " | Divergence Time: 0 Mya | Cov: 1x"))
)


## initialize a list to store plot
#plot_list <- list()

#************************* chatGTP *********************
## plot a zoom inside a plot: https://stackoverflow.com/questions/66409781/how-to-plot-a-zoom-of-the-plot-inside-the-same-plot-area-using-ggplot2
## introduce two variables in for loop: https://stackoverflow.com/questions/59613599/in-r-how-can-loop-multiple-variable-at-the-same
## axis log transform: https://stackoverflow.com/questions/73576715/using-logarithmic-axes-for-graphs-with-very-big-or-very-small-values-ggplot-r
## set axis limit: https://stackoverflow.com/questions/3606697/how-to-set-limits-for-axes-in-ggplot2-r-plots
## set non-scientific format: https://stackoverflow.com/questions/14563989/force-r-to-stop-plotting-abbreviated-axis-labels-scientific-notation-e-g-1e
## get vector index: https://stackoverflow.com/questions/48205370/how-to-get-index-in-a-loop-in-r
## save pdf: https://stackoverflow.com/questions/44711236/set-the-size-of-ggsave-exactly
## format in label: https://www.geeksforgeeks.org/superscript-and-subscript-axis-labels-in-ggplot2-in-r/; 
## https://stackoverflow.com/questions/17334759/subscript-letters-in-ggplot-axis-label; https://stackoverflow.com/questions/67320474/using-subscript-and-italics-in-ggplot2-axis-labels
## https://stackoverflow.com/questions/37825558/how-to-use-superscript-in-axis-labels-with-ggplot2; https://stackoverflow.com/questions/32555531/how-to-italicize-part-one-or-two-words-of-an-axis-title
## add title and adjust position: https://stackoverflow.com/questions/40675778/center-plot-title-in-ggplot2
## add background grid: https://r-charts.com/ggplot2/grid/
## ! add shaded area: https://stackoverflow.com/questions/68770379/how-to-color-shade-the-area-between-two-lines-in-ggplot2

file_path_hae <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[1]), recurse = 2, fail=TRUE, type = "file", glob = "*with_singleton.*P_10.final.summary")
file_path_hae <- file_path_hae[1]
data_hae <- read.table(file_path_hae,header=TRUE,sep="\t")
#head(data_hae)
# check the number of rows
str(data_hae)
species <- rep("A.haemorrhoa",30401)
data_hae_new <- cbind(species,data_hae)
#head(data_hae_new)
#merged_data[30400:30405, ]
#str(merged_data)
#unique(merged_data$species)

file_path_mar <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[2]), recurse = 2, fail=TRUE, type = "file", glob = "*with_singleton.*P_10.final.summary")
file_path_mar <- file_path_mar[1]
data_mar <- read.table(file_path_mar,header=TRUE,sep="\t")
str(data_mar)
species <- rep("A.marginata",31201)
data_mar_new <- cbind(species,data_mar)
#head(data_mar_new)

file_path_pas <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[3]), recurse = 2, fail=TRUE, type = "file", glob = "*with_singleton.*P_10.final.summary")
file_path_pas <- file_path_pas[1]
data_pas <- read.table(file_path_pas,header=TRUE,sep="\t")
str(data_pas)
species <- rep("B.pascuorum",26401)
data_pas_new <- cbind(species,data_pas)
#head(data_pas_new)

file_path_vet <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[4]), recurse = 2, fail=TRUE, type = "file", glob = "*with_singleton.*P_10.final.summary")
file_path_vet <- file_path_vet[1]
data_vet <- read.table(file_path_vet,header=TRUE,sep="\t")
str(data_vet)
#head(data_vet)
species <- rep("B.veteranus",22401)
data_vet_new <- cbind(species,data_vet)
#head(data_vet_new)

## merge all data frames
merged_data <- rbind(data_hae_new,data_mar_new,data_pas_new,data_vet_new)


## Convert relevant columns to numeric
merged_data_new <- merged_data %>%
  mutate(across(c(mutation_per_site, theta_per_site_median, theta_per_site_2.5., 
                  theta_per_site_97.5., year, Ne_median, Ne_2.5., Ne_97.5., 
                  Ne_12.5., Ne_87.5.), as.numeric))

## Display the plot
#print(plot)

#install.packages("scales")
library(scales)

## final
p1_initial <- ggplot(merged_data_new, aes(x = year, y = Ne_median, group = species, color = species)) +
  geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5., fill = species), size = 0.1, alpha = 0.1) +  # Ribbon for the range
  geom_line(size = 1, alpha = 0.8) +  # Line for Ne_median
    ## add legend manually
    #scale_color_manual(values = c("Ne_median" = "red"), labels = expression(paste(italic("N")["e"]," median"))) +
    #scale_fill_manual(values = c("75%_CI" = "blue"), labels = "75% CI") +
    ## legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
    ## revise legend line width: https://stackoverflow.com/questions/28872875/ggplot2-applying-width-of-line-to-the-legend-key
    #guides(color = guide_legend(title = NULL,order = 1, override.aes = list(linewidth = 1.5)),
    #fill = guide_legend(title = NULL, order = 2, byrow = TRUE, override.aes = list(linewidth = 4))) +

  labs(#title = "Median Ne Over Years by Species (1x)",
        title = "1x",
       y=expression(paste(italic("N")["e"])),
       x = "Years ago") +  # Correct label for the x-axis
  #theme_minimal() +
  theme_classic() +
  #guides(color = guide_legend(title = NULL,order = 1, override.aes = list(linewidth = 1.5))) +
  theme(#legend.position = c(0.8,0.8),
        #legend.text = element_text(size = 14),
        legend.position = "none",
        axis.text = element_text(colour = "black",size = 14), axis.text.y = element_text(angle = 90, hjust=0.5),
        ## set angle for axis labels and align them in the middle
        axis.text.x = element_text(angle = 0, hjust = 0.5),
        axis.title = element_text(colour = "black",size = 14), axis.ticks = element_line(colour = "black", size = 1.2),
        panel.grid.major = element_line(color = "gray", size = 0.5, linetype = 2),
        panel.grid.minor = element_line(color = "gray", size = 0.5, linetype = 2),
        panel.border = element_rect(linewidth = 1.5, colour = "black", fill=NA)
) +
  # "#009E73", "#0072B2", "#D55E00", "#CC79A7"
    scale_color_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#332288", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom colors for species
    # "A.marginata" = "#0072B2"
    scale_fill_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#332288", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom fill colors
  
  ## display specific labels to show time periods
  scale_y_continuous(limits = c(1, 3000000), labels = label_number(big.mark = "")) +
  scale_x_continuous(limits = c(10, 180000), labels = label_number(big.mark = "")) + # Set x-axis limits between 1 and 100,000
  ## add comma
  #scale_y_continuous(limits = c(1, 3000000), labels = label_number(big.mark = ",")) + # Adding commas as thousand separators without scientific notation
  #scale_x_continuous(limits = c(10, 180000), labels = label_number(big.mark = ",")) + # Set x-axis limits between 1 and 100,000

  ## frame to select area on the plot
  annotate(geom = "rect", xmin = 10, xmax = 25000, ymin = 1000, ymax = 3000000, 
           color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1)
        #theme_pubr( base_size = 10, border = TRUE) +
        #theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 0, hjust=0.5),
        #axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
        #plot.title = element_text(hjust = 0.5, size = 10),panel.border = element_rect(linewidth = 1.5),
        #panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
        #panel.spacing = unit(1, "cm", data = NULL),
        ## legend line length
        #legend.position = c(0.7,0.3), legend.key.width=unit(1,"cm"), legend.text = element_text(size = 12),
        ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
        #legend.margin =  margin(-14,0,0,0,unit="pt"))
        ##labs(title = file_list_b[i], x="Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
        ##labs(title = file_list_b[i], x = x_axis_title, y = y_axis_title)

#ggsave("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/plot_in_one_1x.new_non_log.pdf",width=6,height=6)


    # axis of select area for zoom
p1_zoom <- ggplot(merged_data_new, aes(x = year, y = Ne_median, group = species, color = species)) +
    #ylim(1,100000)+
    geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5., fill = species), size = 0.1, alpha = 0.1) +  # Ribbon for the range
    geom_line(size = 1, alpha = 0.8) +  # Line for Ne_median
    ##geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),alpha = 0.1) +
    ##geom_line(aes(y = Ne_median), color = "red", linewidth = 1, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    scale_color_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#332288", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom colors for species
    # "A.marginata" = "#0072B2"
    scale_fill_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#332288", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom fill colors
    
    theme_pubr( base_size = 9.5,border = TRUE) +

    guides(color = guide_legend(nrow = 1)) +  # Set the legend to two rows

    theme(axis.text = element_text(colour = "black",size = 9), 
        axis.title = element_text(colour = "black",size = 9.5),
        panel.border = element_rect(linewidth = 1.2),
        legend.position = "none",

# single plot new
        #legend.position = c(0.5,0.05),
# single plot old
        #legend.position = c(0.4,-0.1),
        legend.text = element_text(size = 9),
        legend.title = element_text(size = 9.5),
        legend.background = element_rect(fill = "transparent", color = NA), # Transparent background
        legend.box.background = element_rect(fill = "transparent", color = NA), # Optional for legend box

        #panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),

        panel.grid.major = element_line(color = "gray", size = 0.5, linetype = 2),
        panel.grid.minor = element_line(color = "gray", size = 0.5, linetype = 2),

        axis.ticks = element_line(colour = "black", size = 0.5)
        ) +
    labs(x="Years ago (log transformed)",
         y=expression(paste(italic("N")["e"]))) +
    scale_x_log10(
        limits= c(10,25000),
        breaks = c(10, 100, 1000, 10000),  # Explicitly define breaks to avoid values below 10
        #labels = label_number(big.mark = ",") # Adding commas as thousand separators without scientific notation
        labels = label_number(big.mark = "")
        #labels = function(year) format(year, scientific = FALSE)
        ) +
    #scale_y_continuous(
    scale_y_log10(
        limits = c(100,3000000),
        breaks = c(1000, 10000,100000,1000000,10000000),
        labels = label_number(big.mark = "")
        #labels = function(Ne_median) format(Ne_median, scientific = FALSE)
        ) +

    annotation_logticks(
        sides = "bl",
        short = unit(0.1, "cm"),  # Adjust size of short ticks
        mid = unit(0.15, "cm"),     # Adjust size of medium ticks
        long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
    )
    
## combine:
p1x_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 50000, xmax = 180000, ymin = 250000, ymax = 3000000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 50000, xmax = 180000, ymin = 250000, ymax = 3000000),
              color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(25000,50000),
                                y = c(3000000,3000000),
                                grp = c(1,1,2,2)),
                color = "black",
                linewidth = 0.5,
                linetype = 'dashed')

# Save the plot
ggsave("plot_all_1x.with_singleton.tick_xy_log.pdf", p1x_final, width = 10, height = 8)

print(p1x_final)
