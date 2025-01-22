
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

## result directory
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(result_path)

file_list_a <- c(             
                "AndHae_New_REF_AndHae.no_singleton_sfs_234_1500x_sm_genic",
                "AndMar_New_REF_AndMar.no_singleton_sfs_240_1500x_sm_genic",
                "BomPas_New_REF_BomPas.no_singleton_sfs_204_1500x_sm_genic",
                "BomVet_New_REF_BomVet.no_singleton_sfs_174_1500x_sm_genic"               
                )

file_list_b <- c(
                # hae
                expression(paste("Closest Ref: ", italic("A. haemorrhoa"), " | Divergence Time: 0 Mya | Cov: 3X")), 
                # mar
                expression(paste("Closest Ref: ", italic("A. marginata"), " | Divergence Time: 0 Mya | Cov: 3X")), 
                # pas
                expression(paste("Closest Ref: ", italic("B. pascuorum"), " | Divergence Time: 0 Mya | Cov: 3X")),          
                # vet
                expression(paste("Closest Ref: ", italic("B. veteranus"), " | Divergence Time: 0 Mya | Cov: 3X"))
                )

## initialize a list to store plot
#plot_list <- list()

file_path_hae <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[1]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
file_path_hae <- file_path_hae[1]
data_hae <- read.table(file_path_hae,header=TRUE,sep="\t")

# check the number of rows
str(data_hae)
species <- rep("A.haemorrhoa",30401)
data_hae_new <- cbind(species,data_hae)
head(data_hae_new)

file_path_mar <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[2]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
file_path_mar <- file_path_mar[1]
data_mar <- read.table(file_path_mar,header=TRUE,sep="\t")
str(data_mar)
species <- rep("A.marginata",31201)
data_mar_new <- cbind(species,data_mar)
head(data_mar_new)

file_path_pas <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[3]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
file_path_pas <- file_path_pas[1]
data_pas <- read.table(file_path_pas,header=TRUE,sep="\t")
str(data_pas)
species <- rep("B.pascuorum",26401)
data_pas_new <- cbind(species,data_pas)
head(data_pas_new)

file_path_vet <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[4]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
file_path_vet <- file_path_vet[1]
data_vet <- read.table(file_path_vet,header=TRUE,sep="\t")
str(data_vet)
head(data_vet)
species <- rep("B.veteranus",22401)
data_vet_new <- cbind(species,data_vet)
head(data_vet_new)

## merge all data frames
merged_data <- rbind(data_hae_new,data_mar_new,data_pas_new,data_vet_new)

##########  plot #############
p1_initial <- ggplot(data = merged_data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(limits= c(10,150000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(limits= c(1,650000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    geom_line(aes(y = Ne_median, color = factor(species)), linewidth = 0.8) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5., fill = "75%_CI"), alpha = 0.2) +

    ## add legend manually
    scale_color_manual(values = c("red", "blue", "green","orange"), labels = expression(paste(italic("N")["e"]," median"))) +
    scale_fill_manual(values = c("75%_CI" = "blue"), labels = "75% CI") +

    guides(color = guide_legend(title = NULL,order = 1, override.aes = list(linewidth = 1.5)),
    fill = guide_legend(title = NULL, order = 2, byrow = TRUE, override.aes = list(linewidth = 4))) +

    ## frame to select area on the plot
    annotate(geom = "rect", xmin = 10, xmax = 15000, ymin = 1000, ymax = 550000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr( base_size = 10, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 0, hjust=0.5),
    axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
    plot.title = element_text(hjust = 0.5, size = 10),panel.border = element_rect(linewidth = 1.5),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    panel.spacing = unit(1, "cm", data = NULL),
    ## legend line length
    legend.position = c(0.7,0.3), legend.key.width=unit(1,"cm"), legend.text = element_text(size = 12),

    legend.margin =  margin(-14,0,0,0,unit="pt"))

# Convert relevant columns to numeric
merged_data_new <- merged_data %>%
  mutate(across(c(mutation_per_site, theta_per_site_median, theta_per_site_2.5., 
                  theta_per_site_97.5., year, Ne_median, Ne_2.5., Ne_97.5., 
                  Ne_12.5., Ne_87.5.), as.numeric))

## plot and save plot into local
ggplot(merged_data_new, aes(x = year, y = Ne_median, group = species, color = species)) +
  geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5., fill = species), size = 0.1, alpha = 0.1) +  # Ribbon for the range
  geom_line(size = 1, alpha = 0.8) +  # Line for Ne_median

  labs(title = "Ne_median with 75% CI by Species",
       y = "Ne",
       x = "Year") +  # Correct label for the x-axis

  theme_classic() +
  theme(legend.position = c(0.8,0.8),
        legend.text = element_text(size = 14),
        axis.text = element_text(colour = "black",size = 14), axis.text.y = element_text(angle = 0, vjust = 0, hjust=0.5),
        axis.title = element_text(colour = "black",size = 14), axis.ticks = element_line(colour = "black", size = 1.2),
        panel.grid.major = element_line(color = "gray", size = 0.5, linetype = 2),
        panel.grid.minor = element_line(color = "gray", size = 0.5, linetype = 2),
        panel.border = element_rect(linewidth = 2, colour = "black", fill=NA)
) +
  # "#009E73", "#0072B2", "#D55E00", "#CC79A7"
  scale_color_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#0072B2", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom colors for species
  scale_fill_manual(values = c("A.haemorrhoa" = "#009E73", "A.marginata" = "#0072B2", "B.pascuorum" = "#D55E00", "B.veteranus" = "#CC79A7")) +  # Custom fill colors
  scale_x_log10(limits = c(10, 1000000))  # Set x-axis limits between 1 and 100,000

ggsave("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/plot_in_one_3x.new2.pdf",width=6,height=6)
