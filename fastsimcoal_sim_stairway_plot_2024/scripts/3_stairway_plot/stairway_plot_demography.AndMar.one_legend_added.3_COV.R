
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
                "AndMar_REF_AndMar.DP240", 
                "AndMar_REF_AndMar.DP400",
                "AndMar_REF_AndMar.DP560",
## exclude A. bicolor due to weird 
                "AndMar_REF_AndBic.DP240",
                "AndMar_REF_AndBic.DP400",
                "AndMar_REF_AndBic.DP560",
## just for calculating dS
                #"AndMar_REF_AndTri.DP240",
                #"AndMar_REF_AndTri.DP400",
                #"AndMar_REF_AndTri.DP560",

                "AndMar_REF_AndHat.DP240",
                "AndMar_REF_AndHat.DP400",
                "AndMar_REF_AndHat.DP560",

                "AndMar_REF_AndHae.DP240",
                "AndMar_REF_AndHae.DP400",
                "AndMar_REF_AndHae.DP560",

                "AndMar_REF_BomPas.DP240",
                "AndMar_REF_BomPas.DP400",
                "AndMar_REF_BomPas.DP560"
                )

file_list_b <- c(      
                expression(paste("Ref1: ", italic("A. marginata"), " | d", italic("S"), ":  0 | Cov: 3X")), 
                expression(paste("Ref1: ", italic("A. marginata"), " | d", italic("S"), ":  0 | Cov: 5X")),
                expression(paste("Ref1: ", italic("A. marginata"), " | d", italic("S"), ":  0 | Cov: 7X")),

                expression(paste("Ref2: ", italic("A. bicolor"), " | d", italic("S"), ":  (0.0930, 0.0932) | Cov: 3X")),
                expression(paste("Ref2: ", italic("A. bicolor"), " | d", italic("S"), ":  (0.0930, 0.0932) | Cov: 5X")),
                expression(paste("Ref2: ", italic("A. bicolor"), " | d", italic("S"), ":  (0.0930, 0.0932) | Cov: 7X")),

                #expression(paste("Closer Ref1: ", italic("A. trimmerana"), " | d", italic("S"), ":  12.5 Mya | Cov: 3X")),
                #expression(paste("Closer Ref1: ", italic("A. trimmerana"), " | d", italic("S"), ":  12.5 Mya | Cov: 5X")),
                #expression(paste("Closer Ref1: ", italic("A. trimmerana"), " | d", italic("S"), ":  12.5 Mya | Cov: 7X")),

                expression(paste("Ref3: ", italic("A. hattorfiana"), " | d", italic("S"), ":  (0.1157, 0.1159) | Cov: 3X")),
                expression(paste("Ref3: ", italic("A. hattorfiana"), " | d", italic("S"), ":  (0.1157, 0.1159) | Cov: 5X")),
                expression(paste("Ref3: ", italic("A. hattorfiana"), " | d", italic("S"), ":  (0.1157, 0.1159) | Cov: 7X")),

                expression(paste("Ref4: ", italic("A. haemorrhoa"), " | d", italic("S"), ":  (0.1562, 0.1566) | Cov: 3X")),
                expression(paste("Ref4: ", italic("A. haemorrhoa"), " | d", italic("S"), ":  (0.1562, 0.1566) | Cov: 5X")),
                expression(paste("Ref4: ", italic("A. haemorrhoa"), " | d", italic("S"), ":  (0.1562, 0.1566) | Cov: 7X")),

                expression(paste("Ref5: ", italic("B. pascuorum"), " | d", italic("S"), ":  (1.1684, 1.1714) | Cov: 3X")),
                expression(paste("Ref5: ", italic("B. pascuorum"), " | d", italic("S"), ":  (1.1684, 1.1714) | Cov: 5X")),
                expression(paste("Ref5: ", italic("B. pascuorum"), " | d", italic("S"), ":  (1.1684, 1.1714) | Cov: 7X"))
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
    file_path <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[i]), recurse = 2, fail=TRUE, type = "file", glob = "*.final.summary")
    file_path <- file_path[1]
    data <- read.table(file_path,header=TRUE,sep="\t")

    ## Determine which titles to show based on the plot position
    #y_axis_title <- ifelse(i %in% c(1, 4, 7), expression(paste(italic("N")["e"])), NULL)
    #x_axis_title <- ifelse(i %in% c(7, 8, 9), "Year ago", NULL)

    ## Determine which titles to show based on the plot position
    #print(i) # Add this line to see the value of i
    #if (i %in% c(1,2,3)) {
    if (i %in% c(1,2,3)) {
        y_axis_title <- expression(paste(italic("N")["e"]," ", "(", italic("A. marginata"), ")"))
    } else {
        y_axis_title <- NULL
    }
    #print(y_axis_title) # Add this line to see the value of y_axis_title
    
    #x_axis_title <- if (i %in% c(1,2,3,4,5,6,7,8,9)) "Year ago" else NULL
    x_axis_title <- if (i %in% c(3,6,9,12,15)) "Year ago" else NULL
    ##print(x_axis_title) # Add this line to see the value of x_axis_title

    #plot_title <- if (i == 2) file_list_b[2] 
    #                else if (i == 5) file_list_b[5]
    #                else if (i == 8) file_list_b[8]
    #                else if (i == 12) file_list_b[12]
    #                else if (i == 15) file_list_b[15]
    #                else NULL
                #if (i %in% c(2, 5, 8, 12, 15)) "Year ago" else NULL

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

    ## frame to select area on the plot
    annotate(geom = "rect",xmin = 10, xmax = 15000, ymin = 1, ymax = 150000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr( base_size = 10, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 0, hjust=0.5),
    axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
    plot.title = element_text(hjust = 0.5, size = 12),panel.border = element_rect(linewidth = 1.5),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    panel.spacing = unit(1, "cm", data = NULL),
    ## legend line length
    legend.position = c(0.7,0.4), legend.key.width=unit(1,"cm"), legend.text = element_text(size = 12),
    ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
    legend.margin =  margin(-14,0,0,0,unit="pt")) +
    #labs(title = file_list_b[i], x="Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    labs(title = file_list_b[i], x = x_axis_title, y = y_axis_title)
    #ggtitle(group)
    #ylab(bquote(N[e]))

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

    ## frame to select area on the plot
    annotate(geom = "rect", xmin = 10, xmax = 15000, ymin = 1, ymax = 150000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr( base_size = 10, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 1, hjust=0.5),
    axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
    plot.title = element_text(hjust = 0.5, size = 12),panel.border = element_rect(linewidth = 1.5),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    panel.spacing = unit(0.5, "cm", data = NULL)) +
    #labs(title = file_list_b[i], x="Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    labs(title = file_list_b[i], x = x_axis_title, y = y_axis_title)
    #ggtitle(group)
    #ylab(bquote(N[e]))
}
    # axis of select area for zoom
p1_zoom <- ggplot(data = data, aes(x = year)) +
    #ylim(1,100000)+
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.3) +
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.7, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 9.5,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 9), axis.title = element_text(colour = "black",size = 9.5),
    panel.border = element_rect(linewidth = 1.2),panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    axis.ticks = element_line(colour = "black", size = 1))+
    labs(x="Year ago (log transformed)",y=expression(paste(italic("N")["e"]))) +
    scale_x_log10(lim= c(10,15000),labels = function(year) format(year, scientific = FALSE)) +
    #scale_y_continuous(limits = c(1,200000), labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    scale_y_log10(limits = c(1,200000), labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    # breaks = seq(0, 150000, by = 25000), 
    
    ## add log ticks on x axis
    annotation_logticks(
        sides = "bl",
        short = unit(0.1, "cm"),  # Adjust size of short ticks
        mid = unit(0.15, "cm"),     # Adjust size of medium ticks
        long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
        )

    
p1_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 20000, xmax = 100000, ymin = 100000, ymax = 200000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 20000, xmax = 100000, ymin = 100000, ymax = 200000), color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(15000,20000), y=c(150000,200000),grp=c(1,1,2,2)),
                linewidth=0.5,linetype='dashed')
    
    ## add plot to the list
    plot_list[[file_list_a[i]]] <- p1_final

}

#***************************

combined_plot <- marrangeGrob(grobs = plot_list,ncol = 5, nrow = 3, 
                            layout_matrix = matrix(seq_len(15), nrow = 3, byrow = FALSE))
pdf_file <- file.path(result_path,"AndMar_combined_added_plot.dS.pdf")
ggsave(pdf_file,combined_plot,width = 22.5, height = 13.5, limitsize = FALSE)

## 4.5/width/height

combined_plot2 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,13)],ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))

print(combined_plot2)
