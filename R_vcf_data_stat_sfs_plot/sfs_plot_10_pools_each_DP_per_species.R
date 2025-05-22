
************************** form sfs plot ********************
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data")
list.files(".",pattern = "SteMel")
# check sfs distribution

library(ggplot2)
library(gridExtra)

sfs_DP <- c(
"1x",
"1.5x",
"2x",
"2.5x",
"3x"
)

# show data lines directly in the terminal
#file.show("concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs")
#print(readLines("concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs", warn = F))

plot_list <- list()

## To make the species names in your plot titles italic in R, you can use bquote() or expression() in combination with italic(). 
## However, expression() does not directly evaluate variables, so you'll need to use bquote() to achieve this.
for (DP in sfs_DP){
## test
print(DP)
#}

species_list <- c(

"AphSti",
"BomMaj",
"CerRyb",
"EphDan",
"MegLea",
"NotGla",
"OchPle",
"PhrFul",
"RutMac",
"SteMel"
)

sfs_x <- c(
paste0("AphSti_REF_AphSti.DP_",DP,".equal_self.sfs"),
paste0("BomMaj_REF_BomMaj.DP_",DP,".equal_self.sfs"),
paste0("CerRyb_REF_CerRyb.DP_",DP,".equal_self.sfs"),
paste0("EphDan_REF_EphDan.DP_",DP,".equal_self.sfs"),
paste0("MegLea_REF_MegLea.DP_",DP,".equal_self.sfs"),
paste0("NotGla_REF_NotGla.DP_",DP,".equal_self.sfs"),
paste0("OchPle_REF_OchPle.DP_",DP,".equal_self.sfs"),
paste0("PhrFul_REF_PhrFul.DP_",DP,".equal_self.sfs"),
paste0("RutMac_REF_RutMac.DP_",DP,".equal_self.sfs"),
paste0("SteMel_REF_SteMel.DP_",DP,".equal_self.sfs")

)


for (i in 1:length(sfs_x)){
    ## sfs col for proportion
    #sfs_dt2 <- (read.table(sfs_x[i], header=F, sep =" "))

    ## sfs lines with NA col
    #i <- 1
    print(sfs_x[i])
    sfs_dt <- suppressWarnings(read.table(sfs_x[i], header=F, sep =" "))
    sfs_dt1 <- sfs_dt[,!is.na(sfs_dt[1,])]
    sfs_dt2 <- as.data.frame(t(sfs_dt1))
    #print(sfs_dt2)
    #print(head(sfs_dt2))
    plot_list[[i]] <- #ggplot(data = sfs_dt2, aes(x = 1:nrow(sfs_dt2), y = V1))+
                    ggplot(data = sfs_dt2, aes(x = factor(seq_along(V1)),y = V1))+
                    geom_col(fill = "gray")+
                    #labs(title = paste0("Bar Plot of SFS: ", species_list[i]), x = "Index", y = "Value")+
                    ## The bquote() function allows you to mix text and evaluated expressions. The .(species_list[i]) syntax inside bquote() evaluates species_list[i] and wraps it in italic() to display it in italics.
                    
                    ## sfs lines
                    #labs(title = bquote("Bar Plot of SFS: " *italic(.(species_list[i]))), x = "Index", y = "Value")+
                    
                    ## sfs col for proportion
                    #labs(title = bquote("Bar Plot of SFS Prop: " *italic(.(species_list[i]))), x = "Index", y = "Value")+
                    ## for each DP
                    labs(title = bquote("SFS distribution: " ~ italic(.(species_list[i])) ~ .(DP)), x = "Index", y = "Value")+
                    ## for each species
                    #labs(title = bquote("SFS distribution: " ~ .(species) ~ italic(.(sfs_DP[i]))), x = "Index", y = "Value")+
                    theme_bw(base_size = 8)+
                    theme(plot.title = element_text(size = 6),
                        axis.title = element_text(size =6),
                        axis.text = element_text(size = 4), 
                        axis.text.x = element_text(angle = 60),
                        axis.text.y = element_text(angle = 45))
}

## for different species
#}


plot_list <- unname(plot_list)
for (i in 1:length(plot_list)) {
  print(plot_list[[i]])
}


## add plot to the list
#print(plot_list[[1]])
#plot_list[[2]]
#plot_list[[3]]
#print(plot_list[[1]])

#library(gridExtra)

# remake plot list since it got issues
#for (i in 1:length(plot_list)) {
#    print(plot_list[[i]])
#}

## for all species
## for each DP per species
pdf(paste0("./sfs_plot/combined_sfs_plots_10_species_",DP,".pdf"), width = 15, height = 5)  # Adjust width and height as needed
## for each species at different depth
#pdf(paste0("./sfs_plot/combined_sfs_plots_10_",species,".pdf"), width = 20, height = 5)  # Adjust width and height as needed

# Combine plots and save to PDF
#gridExtra::grid.arrange(grobs = plot_list, ncol = 2)
gridExtra::grid.arrange(grobs = plot_list, ncol = 5)

# Close the PDF device
dev.off()
}

*************************************************************************************************
