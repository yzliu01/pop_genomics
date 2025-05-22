
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

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(result_path)

file_list_a <- c(             
                "AndMar_New_REF_AndMar.no_singleton_sfs_240_1500x_sm_genic", 
                "AndMar_New_REF_AndMar.no_singleton_sfs_400_1500x_sm_genic",
                "AndMar_New_REF_AndMar.no_singleton_sfs_560_1500x_sm_genic",
                "AndMar_New_REF_AndHat.no_singleton_sfs_240_1500x_sm_genic",
                "AndMar_New_REF_AndHat.no_singleton_sfs_400_1500x_sm_genic",
                "AndMar_New_REF_AndHat.no_singleton_sfs_560_1500x_sm_genic",
                "AndMar_New_REF_AndHae.no_singleton_sfs_240_1500x_sm_genic",
                "AndMar_New_REF_AndHae.no_singleton_sfs_400_1500x_sm_genic",
                "AndMar_New_REF_AndHae.no_singleton_sfs_560_1500x_sm_genic",
                "AndMar_New_REF_BomPas.no_singleton_sfs_240_1500x_sm_genic",
                "AndMar_New_REF_BomPas.no_singleton_sfs_400_1500x_sm_genic",
                "AndMar_New_REF_BomPas.no_singleton_sfs_560_1500x_sm_genic"
                )

file_list_b <- c(             
                "AndMar_REF_AndMar.no_singleton_240_1500x", 
                "AndMar_REF_AndMar.no_singleton_400_1500x",
                "AndMar_REF_AndMar.no_singleton_560_1500x",
                "AndMar_REF_AndHat.no_singleton_240_1500x",
                "AndMar_REF_AndHat.no_singleton_400_1500x",
                "AndMar_REF_AndHat.no_singleton_560_1500x",
                "AndMar_REF_AndHae.no_singleton_240_1500x",
                "AndMar_REF_AndHae.no_singleton_400_1500x",
                "AndMar_REF_AndHae.no_singleton_560_1500x",
                "AndMar_REF_BomPas.no_singleton_240_1500x",
                "AndMar_REF_BomPas.no_singleton_400_1500x",
                "AndMar_REF_BomPas.no_singleton_560_1500x"
                )

## initialize a list to store plot
plot_list <- list()

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

for (i in 1:length(file_list_a)){
#for (group in file_list){

    ## key step
    ## conditional axis name plot
    ## plot a frame
    file_path <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[i]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
    data <- read.table(file_path,header=TRUE,sep="\t")

p1_initial <- ggplot(data = data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(lim= c(1,110000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(lim= c(1,100000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +

    ## frame to select area on the plot
    annotate(geom = "rect",xmin = 1, xmax = 15000, ymin = 1000, ymax = 90000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr( base_size = 12, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12),axis.title = element_text(colour = "black",size = 13), 
    plot.title = element_text(hjust = 0.5, size=13),panel.border = element_rect(linewidth = 1),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2))+
    labs(title = file_list_b[i], x="Year ago",y=expression(paste(italic("N")["e"])))
    #ggtitle(group)
    #ylab(bquote(N[e]))

    # axis of select area for zoom
p1_zoom <- ggplot(data = data, aes(x = year)) +
    #ylim(1,100000)+
    geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 11,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 11),axis.title = element_text(colour = "black",size = 12),
    panel.border = element_rect(linewidth = 0.5),panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2))+
    labs(x="Year ago (log transformed)",y=expression(paste(italic("N")["e"]))) +
    scale_x_log10(lim= c(1,15000),labels = function(year) format(year, scientific = FALSE)) +
    scale_y_continuous(labels = function(Ne_median) format(Ne_median, scientific = FALSE))

p1_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 35000, xmax = 110000, ymin = 65000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 35000, xmax = 110000, ymin = 65000, ymax = 100000), color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(15000,35000), y=c(90000,100000),grp=c(1,1,2,2)),
                linewidth=0.5,linetype='dashed')
    
    ## add plot to the list
    plot_list[[file_list_a[i]]] <- p1_final

}


#***************************

combined_plot <- marrangeGrob(grobs = plot_list,ncol = 4, nrow = 3)
pdf_file <- file.path(result_path,"AndMar_combined_plot.pdf")
ggsave(pdf_file,combined_plot,width = 26, height = 20)


*************************** test codes *************

## test codes
dev.off()

group <- c(1:5)
## get letters: https://stackoverflow.com/questions/1439513/creating-a-sequential-list-of-letters-with-r; https://www.datanovia.com/en/blog/how-to-save-a-ggplot/
group <- letters[1:5]
for (i in group){
    order <- which(i == group)
  print(paste0("p",which(i == group)))

}
