
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

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/related_species"
setwd(result_path)

file_list_a <- c(

                "AndHae_REF_AndHae.DP234", 
                "AndHae_REF_AndHat.DP234",
                "AndHae_REF_AndFul.DP234",
                "AndHae_REF_BomPas.DP234",

                "AndMar_REF_AndMar.DP240", 
                "AndMar_REF_AndBic.DP240",
                "AndMar_REF_AndHat.DP240",
                "AndMar_REF_AndHae.DP240",
                "AndMar_REF_BomPas.DP240",

                "BomPas_REF_BomPas.DP204", 
                "BomPas_REF_BomMus.DP204",
                "BomPas_REF_BomHor.DP204",
                "BomPas_REF_BomCon.DP204",
                "BomPas_REF_ApisMel.DP204",

                "BomVet_REF_BomVet.DP174", 
                "BomVet_REF_BomPas.DP174", 
                "BomVet_REF_BomHor.DP174",
                "BomVet_REF_BomCon.DP174",
                "BomVet_REF_ApisMel.DP174"
                )

file_list_b <- c(

                expression(paste("Ref1: ", italic("A. haemorrhoa"), " | d", italic("S"), ":  0")), 
                expression(paste("Ref2: ", italic("A. hattorfiana"), " | d", italic("S"), ":  (0.1507, 0.1510)")),
                expression(paste("Ref3: ", italic("A. fulva"), " | d", italic("S"), ":  (0.1527, 0.1531)")),
                expression(paste("Ref4: ", italic("B. pascuorum"), " | d", italic("S"), ":  (1.1801, 1.1831)")),

                expression(paste("Ref1: ", italic("A. marginata"), " | d", italic("S"), ":  0")), 
                expression(paste("Ref2: ", italic("A. bicolor"), " | d", italic("S"), ":  (0.0930, 0.0932)")),
                expression(paste("Ref3: ", italic("A. hattorfiana"), " | d", italic("S"), ":  (0.1157, 0.1159)")),
                expression(paste("Ref4: ", italic("A. haemorrhoa"), " | d", italic("S"), ":  (0.1562, 0.1566)")),
                expression(paste("Ref5: ", italic("B. pascuorum"), " | d", italic("S"), ":  (1.1684, 1.1714)")),

                expression(paste("Ref1: ", italic("B. pascuorum"), " | d", italic("S"), ":  0")), 
                expression(paste("Ref2: ", italic("B. muscorum"), " | d", italic("S"), ": (0.0200, 0.0201)")),
                expression(paste("Ref3: ", italic("B. hortorum"), " | d", italic("S"), ": (0.0648, 0.0652)")),
                expression(paste("Ref4: ", italic("B. confusus"), " | d", italic("S"), ": (0.1092, 0.1095)")),
                expression(paste("Ref5: ", italic("A. mellifera"), " | d", italic("S"), ": (0.5943, 0.5962)")),


                expression(paste("Ref1: ", italic("B. veteranus"), " | d", italic("S"), ": 0")), 
                expression(paste("Ref2: ", italic("B. pascuorum"), " | d", italic("S"), ": (0.0199, 0.0200)")), 
                expression(paste("Ref3: ", italic("B. hortorum"), " | d", italic("S"), ": (0.0637, 0.0641)")),
                expression(paste("Ref4: ", italic("B. confusus"), " | d", italic("S"), ": (0.1081, 0.1084)")),
                expression(paste("Ref5: ", italic("A. mellifera"), " | d", italic("S"), ": (0.5946, 0.5964)"))

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
    print(file_path)
    data <- read.table(file_path,header=TRUE,sep="\t")
    #print(head(data))
    ## Determine which titles to show based on the plot position
    #y_axis_title <- ifelse(i %in% c(1, 4, 7), expression(paste(bolditalic("N")["e"])), NULL)
    #x_axis_title <- ifelse(i %in% c(7, 8, 9), "Years ago", NULL)

    ## Determine which titles to show based on the plot position, column
    print(i) # Add this line to see the value of i
#}
    #if (i %in% c(1,2,3)) {
    if (i %in% c(1)) {
        y_axis_title <- expression(paste(italic("N")["e"]," ","(",italic("A. haemorrhoa"),")"))
    } else if (i %in% c(5)) {
       y_axis_title <- expression(paste(italic("N")["e"]," ","(",italic("A. marginata"),")"))
    } else if (i %in% c(10)) {
       y_axis_title <- expression(paste(italic("N")["e"]," ","(",italic("B. pascuorum"),")"))
    } else if (i %in% c(15)) {
       y_axis_title <- expression(paste(italic("N")["e"]," ","(",italic("B. veteranus"),")"))
    } else {
        y_axis_title <- NULL
    }
    #print(y_axis_title) # Add this line to see the value of y_axis_title
    
    x_axis_title <- if (i %in% c(15,16,17,18,19)) "Years ago" else NULL
    #x_axis_title <- if (i %in% c(3,6,9,12,15)) "Years ago" else NULL
    ##print(x_axis_title) # Add this line to see the value of x_axis_title

    if (i == 1){
p1_initial <- ggplot(data = data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(limits= c(10,85000),labels = function(year) format(year, scientific = FALSE)) +
    
    # the limit can affect the ribbon plot if its values exceed the limits and lead to blanks
    scale_y_continuous(limits= c(1,250000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +

    #geom_line(aes(y = Ne_median, color = "Ne_median"), linewidth = 0.7) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5., fill = "75%_CI"), alpha = 0.3) +
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
    annotate(geom = "rect",xmin = 10, xmax = 15000, ymin = 1000, ymax = 180000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr(base_size = 10, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 0, hjust=0.5),
    axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
    plot.title = element_text(hjust = 0.5, size = 12),panel.border = element_rect(linewidth = 1.5),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    panel.spacing = unit(0.5, "cm", data = NULL),
    ## legend line length
    legend.position = c(0.7,0.15), legend.key.width=unit(1,"cm"), legend.text = element_text(size = 12),
    ## space between two legends: https://stackoverflow.com/questions/73235117/vertical-gap-between-2-legends-in-ggplot2-vertical-gap-between-2-keys-in-the-sa
    legend.margin =  margin(-14,0,0,0,unit="pt")) +
    #labs(title = file_list_b[i], x="Years ago (log transformed)",y=expression(paste(bolditalic("N")["e"])))
    labs(title = file_list_b[i], x = x_axis_title, y = y_axis_title)
    #ggtitle(group)
    #ylab(bquote(N[e]))

} else {

p1_initial <- ggplot(data = data, aes(x = year)) +
    #xlim(1,150000)+
    #ylim(1,650000)+
    scale_x_continuous(limits= c(10,85000),labels = function(year) format(year, scientific = FALSE)) +

    # the limit can affect the ribbon plot if its values exceed the limits and lead to blanks
    scale_y_continuous(limits= c(1,250000),labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    
    #geom_line(aes(y = Ne_median), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.), fill = "blue", alpha = 0.3) +
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.7, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +

    ## frame to select area on the plot
    annotate(geom = "rect", xmin = 10, xmax = 15000, ymin = 1000, ymax = 180000, color = "black", linetype='dashed', linewidth = 0.5, alpha = 0.1) +
    theme_pubr(base_size = 10, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 12), axis.text.y = element_text(angle = 90, vjust = 1, hjust=0.5),
    axis.title = element_text(colour = "black",size = 12), axis.ticks = element_line(colour = "black", size = 1.2),
    plot.title = element_text(hjust = 0.5, size = 12), panel.border = element_rect(linewidth = 1.5),
    panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    panel.spacing = unit(0.5, "cm", data = NULL)) +
    #labs(title = file_list_b[i], x="Years ago (log transformed)",y=expression(paste(bolditalic("N")["e"])))
    labs(title = file_list_b[i], x = x_axis_title, y = y_axis_title)
    #ggtitle(group)
    #ylab(bquote(N[e]))
}
    # axis of select area for zoom
p1_zoom <- ggplot(data = data, aes(x = year)) +
    #ylim(1,180000)+
    #scale_x_log10(lim= c(10,15000),labels = function(year) format(year, scientific = FALSE)) +
    #geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.3) +
    geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.7, alpha = 0.8) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 9.5,border = TRUE) +
    # align x axis title to the left, hjust=1
    theme(axis.text = element_text(colour = "black",size = 9), axis.title = element_text(colour = "black",size = 9.5),
    axis.title.x=element_text(hjust=1),
    panel.border = element_rect(linewidth = 1.2), panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2),
    axis.ticks = element_line(colour = "black", size = 1)) +
    labs(x="Years ago (log transformed)",y=expression(paste(bolditalic("N")["e"]))) +
    
    scale_x_log10(limits= c(10,15000),labels = function(year) format(year, scientific = FALSE)) +
#    scale_y_continuous(limits = c(1000,1500000), labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    scale_y_log10(limits = c(1000,1500000), labels = function(Ne_median) format(Ne_median, scientific = FALSE)) +
    
    ## add log ticks on x axis
    annotation_logticks(
        sides = "bl",
        short = unit(0.1, "cm"),  # Adjust size of short ticks
        mid = unit(0.15, "cm"),     # Adjust size of medium ticks
        long = unit(0.2, "cm")       # Adjust size of long ticks)  # log ticks only on  bottom
        )


p1_final <- p1_initial + 
    ## position of zoom plot, the y axis title affect the plot area
    annotation_custom(ggplotGrob(p1_zoom), xmin = 30000, xmax = 85000, ymin = 150000, ymax = 250000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 30000, xmax = 85000, ymin = 150000, ymax = 250000), color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(15000,30000), y=c(180000,250000),grp=c(1,1,2,2)),
                linewidth=0.5,linetype='dashed')
    
    ## add plot to the list
    plot_list[[file_list_a[i]]] <- p1_final

}

## add a blank plot at 5th position
# create blank plot: theme_void (control all non-data display)
blank_plot <- ggplot() + theme_void()
plot_list_final <- append(plot_list, list(blank_plot), after = 4)
# order the plot list to arrange them in row instead of column
# Reorder to match column-wise filling of marrangeGrob
plot_list_final <- plot_list_final[matrix(seq_along(plot_list_final), nrow = 4, byrow = TRUE)]
## now a total of 20 plots
combined_plot <- marrangeGrob(grobs = plot_list_final,
                            ncol = 5, nrow = 4, byrow = TRUE)


pdf_file <- file.path(result_path,"all_related_species_combined_3x_plot.dS.pdf")
ggsave(pdf_file,combined_plot,width = 22.5, height = 18,limitsize = FALSE)

# get the first three plots in the first column
#combined_plot4 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,13)],ncol = 5, nrow = 1, top=NULL,
#                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))

dev.off()



# combine multiple pdf
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fastsimcoal_sim_stairway_plot_2024/scripts/3_stairway_plot/stairway_plot_main_figure_2.combine_pdf.R
#install.packages("qpdf")
library(qpdf)

# Vector of input PDF filenames
input_pdfs <- c(
    "AndHae_combined_added_plot.dS.pdf", 
    "AndMar_combined_added_plot.dS.pdf",
    "BomPas_combined_added_plot.dS.pdf",
    "BomVet_combined_added_plot.dS.pdf"
    )  

# Output merged PDF filename
output_pdf <- "combined_related_species_plot.pdf"

# Combine PDFs
pdf_combine(input = input_pdfs, output = output_pdf)



*************** test of interleved ribbon plot **************

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(result_path)

file_list_a <- c(   
                #"BomVet_New_REF_BomVet.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomVet.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomVet.no_singleton_sfs_416_1500x_sm_genic"
)

file_path <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[2]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
#file_path <- file_path[1]
data <- read.table(file_path,header=TRUE,sep="\t")
head(data)

summary(data$year)
summary(data$Ne_median)
summary(data$Ne_12.5.)
summary(data$Ne_87.5.)

all(data$Ne_12.5. <= data$Ne_87.5.)

plot_test <- ggplot(data = data, aes(x = year)) +
    geom_line(data = data, aes(y = Ne_median, color = "Ne_median"), linewidth = 0.7) +
    geom_ribbon(data = data, aes(ymin = Ne_12.5.,ymax = Ne_87.5., fill = "75%_CI"), alpha = 0.2) +
    theme()
    
print(plot_test)

p <- ggplot(data = data, aes(x = year)) +
    geom_line(aes(y = Ne_median, color = "Ne_median"), linewidth = 0.7) +
    geom_ribbon(aes(ymin = Ne_12.5., ymax = Ne_87.5., fill = "75%_CI"), alpha = 0.2) +
    scale_color_manual(values = c("Ne_median" = "red"), labels = "Ne median") +
    scale_fill_manual(values = c("75%_CI" = "blue"), labels = "75% CI") +
    theme_minimal()

print(p)



***********************
# before there were 
# get the first three plots in the first column
## select the first row (related species by 3x; original plots are arranged by columns)
combined_plot4 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,13)],ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))

combined_plot3 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,13)],ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))
                            
combined_plot2 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,13)],ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))

combined_plot1 <- marrangeGrob(grobs = plot_list[c(1,4,7,10,0)],ncol = 5, nrow = 1, top=NULL,
                            layout_matrix = matrix(seq_len(5), nrow = 1, byrow = TRUE))

print(combined_plot4)

************************ from plot directly ******************
# Convert each marrangeGrob object to a single grob
combined_plot1_grob <- grid.arrange(grobs = combined_plot1, "null")
combined_plot2_grob <- grid.arrange(grobs = combined_plot2, "null")
combined_plot3_grob <- grid.arrange(grobs = combined_plot3, "null")
combined_plot4_grob <- grid.arrange(grobs = combined_plot4, "null")

#combined_plot1_grob <- grid.arrange(grobs = combined_plot1, widths = unit(c(0.4,0.4,0.4,0.4), "null"), heights = unit(c(0.4,0.4,0.4,0.4), "null"))
#combined_plot2_grob <- grid.arrange(grobs = combined_plot2, widths = unit(c(0.4,0.4,0.4,0.4), "null"), heights = unit(c(0.4,0.4,0.4,0.4), "null"))
#combined_plot3_grob <- grid.arrange(grobs = combined_plot3, widths = unit(c(0.4,0.4,0.4,0.4), "null"), heights = unit(c(0.4,0.4,0.4,0.4), "null"))
#combined_plot4_grob <- grid.arrange(grobs = combined_plot4, widths = unit(c(0.4,0.4,0.4,0.4), "null"), heights = unit(c(0.4,0.4,0.4,0.4), "null"))

# Combine all the grobs into one layout
all_combined_plots <- arrangeGrob(combined_plot1_grob, 
                                    combined_plot2_grob, 
                                    combined_plot3_grob, 
                                    combined_plot4_grob, ncol = 1)

# test combine
#all_combined_plots <- arrangeGrob(combined_plot3_grob, combined_plot4_grob, ncol = 1)

# Add margin to the combined grob (example: 5 units of margin)
#library(gridExtra)
library(gtable)

all_combined_plots_padded <- gtable_add_padding(all_combined_plots, padding = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))

# To display the combined plots with padding
#grid.draw(all_combined_plots_padded)



# Save the combined plots to a PDF
#pdf("all_combined_plots.pdf", width = 18, height = 26) # Adjust the width and height as needed
#pdf("all_combined_plots.pdf", width = 15, height = 20) # Adjust the width and height as needed
pdf("all_combined_plots.dS_3x.pdf", width = 20, height = 16)
grid.draw(all_combined_plots_padded)

#grid.draw(all_combined_plots)
dev.off()

#print(combined_plot4)




library(gridExtra)
#install.packages("patchwork")
library(patchwork)

p <- grid.arrange(combined_plot1, combined_plot2, combined_plot3, combined_plot4, ncol=1)

combined_plot <- combined_plot1 + combined_plot2 + combined_plot3 + combined_plot4 + plot_layout(ncol = 1)



