
install.packages("scales")  
library("scales", help, pos = 2, lib.loc = NULL)

## stairway_plot output final: example data
mutation_per_site	n_estimation	theta_per_site_median	theta_per_site_2.5%	theta_per_site_97.5%	year	Ne_median	Ne_2.5%	Ne_97.5%	Ne_12.5%	Ne_87.5%
4.9E-324	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.372404573E-315	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918
6.546688913863476E-9	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.81852469829541	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918

## load libraries
install.packages("yarrr")
install.packages("plotrix")
library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)
library(yarrr)
library(plotrix)
## test
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")

list.files(pattern = "BomVet_New_REF_BomPas.no_singleton_sfs_*_1500x_sm_genic.final.summary")

mixedsort(sort(fs::dir_ls(path=result_path, recurse = 1, fail=TRUE, type = "file", glob = "*AndMar_New_REF_*.no_singleton_sfs_*_1500x_sm_genic.final.summary")))
mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "AndMar_New_REF_AndHae.no_singleton_sfs_240_1500x_sm_genic.final.summary")))
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr2.final.txt
assign(paste0("a1"), read.table(mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "*AndMar_New_REF_AndHae.no_singleton_sfs_240_1500x_sm_genic.final.summary"))),header=T,sep="\t"))
head(a1)
plot(1,1, type="n", xlim=c(1,1e6), ylim=c(1,7e5), xlab="Year agos ago", ylab="Effective population size")
## ,xaxt='n',yaxt='n'
## specific line color
## https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf
lines(a1$year,a1$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
lines(a1$year,a1$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=2)  # plot lower CI boundary
lines(a1$year,a1$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=2)  # plot upper CI boundary
lines(a1$year,a1$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=2)  # plot lower CI boundary
lines(a1$year,a1$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=2)  # plot upper CI boundary

>>>>>>>>>>>>>>>>>> below checked <<<<<<<<<<<<<<<<<<

pdf(paste0("StairwayPlot_BomVet.Median_75CI_zoom_out.pdf"),width = 20, height = 20)
## set number of plot in a figure
#par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

par(mfcol=c(3,3),mar=c(4.0,4.5,5.8,1)+0.6,cex.lab=2.2, cex.axis=1.8,lwd=3)
layout(matrix(c(1:9),nrow=3,ncol=3,byrow=F),width=c(1,1),height=c(1,1))

## single vector in for loop
for (group in c(
                "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"
                )){

    ## key step
    ## conditional axis name plot
    ## plot a frame
    #pas_REF_pas_Dat <- read.table("msmc.pas_REF_pas_out_non_empty.20bootstrap_chrall.final.txt", header=TRUE)
    assign(paste0(group,"_Dat"), read.table(fs::dir_ls(path=paste0(result_path,"/",group), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary"),header=TRUE,sep="\t"))
    print(paste0(group,"_Dat"))
    #plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1e3,5e7), ylim=c(1e5,1e6), xlab="Year agos ago", ylab="Effective population size")
    if (group %in% c("BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                    "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic"
                    )) {

        plot(1,1, type="n", xlim=c(1,1e5), ylim=c(1,1e5), xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
        
        ## shade area between two lines
        polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
        lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

        x_label <- c(10,100,500,1000,5000,10000,50000,100000,200000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))
#        tck = 1, lty = 2, col = "gray")
        ## change label direction
        # , las = 2
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))
#        tck = 1, lty = 2, col = "gray")

#        grid(nx = NULL, ny = NULL,
#            lty = 2,      # Grid line type
#            col = "gray", # Grid line color
#            lwd = 1)      # Grid line width

        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary

        zoomInPlot(get(paste0(group,"_Dat"))$year, get(paste0(group,"_Dat"))$Ne_87.5,                # Data
           rxlim = c(10, 15000), # X-axis limits
           rylim = c(1000, 100000)) # Y-axis limits

    } else if (group %in% c("BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(1,1e5), ylim=c(1e3,1e5),xlab="Year agos ago", ylab="Effective population size",xaxt='n',yaxt='n')
        
        ## shade area between two lines
        polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
        lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

        x_label <- c(10,100,500,1000,5000,10000,50000,100000,200000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))

        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

#        grid(nx = NULL, ny = NULL,
#            lty = 2,      # Grid line type
#            col = "gray", # Grid line color
#            lwd = 1)      # Grid line width

        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        
    } else if (group %in% c("BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                            "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic"
                            #"BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(1,1e5), ylim=c(1e3,1e5),xlab="", ylab="",xaxt='n',yaxt='n')

        #abline(v=c(1e3,2e4,4e4,6e4,1e5),lwd=1,col=adjustcolor("blue", alpha = 0.5))
        
        ## shade area between two lines
        polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
        lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

        x_label <- c(10,100,500,1000,5000,10000,50000,100000,200000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))

        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary

    } else if (group %in% c("BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                            "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(1,1e5), ylim=c(1e3,1e5),xlab="", ylab="",xaxt='n',yaxt='n')

        ## shade area between two lines
        polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
        lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

        x_label <- c(10,100,500,1000,5000,10000,50000,100000,200000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))

        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary

    } else {
        plot(1,1, type="n", xlim=c(1,1e5), ylim=c(1e3,1e5),xlab="Year agos ago",ylab="",xaxt='n',yaxt='n')

        ## shade area between two lines
        polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
        lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

        x_label <- c(10,100,500,1000,5000,10000,50000,100000,200000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))

        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lty=1,lwd=3)  # plot trajectory
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        #lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5,col=adjustcolor("blue", alpha = 0.8),lty=1,lwd=1)  # plot upper CI boundary

    }
    ## without showing ticks xaxt='n',yaxt='n'
    title(cex=1.5,line=6)

    ## shade area between two lines
    #polygon(c(get(paste0(group,"_Dat"))$year, rev(get(paste0(group,"_Dat"))$year)), c(get(paste0(group,"_Dat"))$Ne_12.5, rev(get(paste0(group,"_Dat"))$Ne_87.5)),
    #    lwd = 0.01, lty = 1,col = yarrr::transparent("blue", trans.val = 0.9))

    ## add line to indicate ice-age [11550-12800], Wiki
    abline(v=11550,lwd=2.5,col=adjustcolor("orange", alpha = 0.7))
    
    ## add grid
    grid(nx = NULL, ny = NULL,
        lty = 2,      # Grid line type
        col = "gray", # Grid line color
        lwd = 1)      # Grid line width

    ## add plot title in each plot
    mtext(side=3,text=paste0(substr(group,1,7),substr(group,12,21),"_DP_",substr(group,40,48)),cex=1.2,line=4)
    ## add line to indicate ice-age [11550-12800], Wiki
    #abline(h=500, v=12800,lwd=1,col=adjustcolor("grey", alpha = 0.5))  # add a vertical line at 13,000 years ago to indicate end of last glaction
    #abline(v=11550,lwd=2.5,col=adjustcolor("orange", alpha = 0.7))
    #lines(c(1:100),rep(100,100), type="s", col="red")
    ## add replicate lines
    #par(new=TRUE)

    ## plot single run and 20 bootstrap runs
    #for (rep in c("all",1:20)){
        ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
        ## assign variable to read_data
        ##file_list <- fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = get(paste0("msmc.",group,"_out_non_empty.20bootstrap_chr",rep,".final.txt")))
        #assign(paste0("a",rep), read.table(paste0("msmc.",group,"_out_non_empty.20bootstrap_chr",rep,".final.txt"),header=T,sep="\t"))
        #assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*vet_REF_pas*out_non_empty.20bootstrap_chr*.final.txt")))),header=T,sep="\t")
        #print(group)
        #print(rep)
        #print(head(get(paste0("a",rep)),n=2L))
        ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
        #lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a",rep))$lambda)/(2*mu),type="s",lwd=2,col = adjustcolor("blue", alpha = 0.6))
        ## add the main plot over bootstrap
        #lines(get(paste0("a","all"))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=1,col = adjustcolor("red", alpha = 1))

    #}

    ## add legend in specific plot
    if (all(sapply(c("BomVet_New_REF_BomPas"), grepl, group))) {
    legend("topright",c("Median","75% CI","LGM"),col = adjustcolor(c("red","blue","orange"), alpha = 0.9),cex=1.5,lty=c(1,1),lwd=c(3,2.5,2.5),bty="n")
    } else {
        NULL
    }
    ## single for all plots
    ##legend("topright",c("Median","75% CI","95% CI"),col = adjustcolor(c("red","blue","blue"), alpha = 0.8),lty=c(1,5,5),lwd=c(3,2,2),bty="n")
}


dev.off()


*******************************************************************************************
library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)
library(yarrr)
library(plotrix)
## test
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new/BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic")

list.files(pattern = "BomVet_New_REF_BomPas.no_singleton_sfs_*_1500x_sm_genic.final.summary")

mixedsort(sort(fs::dir_ls(path=result_path, recurse = 1, fail=TRUE, type = "file", glob = "*AndMar_New_REF_*.no_singleton_sfs_*_1500x_sm_genic.final.summary")))
mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "AndMar_New_REF_AndHae.no_singleton_sfs_240_1500x_sm_genic.final.summary")))

path1 <- "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic"
df1 <- read.table("BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
head(df1)

## https://stackoverflow.com/questions/66409781/how-to-plot-a-zoom-of-the-plot-inside-the-same-plot-area-using-ggplot2

                        p1 = ggplot(data = df1, aes(x = year)) +
                        xlim(1,100000)+
                        geom_line(aes(y = Ne_median), color = "red") +
                        geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
                        #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
                        #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
                        ## selected area frame
                        #geom_rect(aes(xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000), color = "green", alpha = 0.3) +
                        annotate(geom = "rect",xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000, color = "black", alpha = 0.1) +
                        theme_pubr( base_size = 10, border = TRUE)

                        # axis of select area for zoom
                        p2 = ggplot(data = df1, aes(x = year)) +
                        scale_x_log10(lim= c(1,100000),labels = function(year) format(year, scientific = FALSE)) +
                        geom_line(aes(y = (Ne_median)), color = "red") +
                        geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
                        #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
                        #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
                        #xlim (1, 200000) +
                        #ylim (0, 70000) +
                        theme_pubr( base_size = 10,border = TRUE)
                        #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))


                        p1 + 
                        ## position of zoom plot
                        annotation_custom(ggplotGrob(p2), xmin = 50000, xmax = 100000, ymin = 70000, ymax = 100000) +
                        ## position of annotation frame
                        geom_rect(aes(xmin = 50000, xmax = 100000, ymin = 70000, ymax = 100000), color='black', linetype='dashed', alpha=0) +
                        ## conncetion line to one side of the frame [geom_rect]
                        geom_path(aes(x,y,group=grp), 
                                    #[selected-annotation:left-right]
                                    data=data.frame(x = c(10,50000,20000,50000), y=c(55000,100000,55000,70000),grp=c(1,1,2,2)),
                                    linetype='dashed')


p1 = ggplot(data = df, aes(x = time)) +
  geom_line(aes(y = line_2), color = "red", position = position_nudge(x = 0.5, y = 1000)) +
  geom_line(aes(y = line_1),color = "blue") +
  geom_rect(aes(xmin = 1, xmax = 5, ymin = 0, ymax = 1500), color = "black", alpha = 0) +
  theme_pubr( base_size = 6, border = TRUE)

#The plot with a zoom
p2 = ggplot(data = df, aes(x = time, y = line_1)) +
  geom_line(color = "blue") +
  xlim (1, 5) +
  ylim (0, 1500) +
  theme_pubr( base_size = 8,border = TRUE)

p1 + 
  annotation_custom(ggplotGrob(p2), xmin = 7.5, xmax = 10, ymin = 10000, ymax = 20000) +
  geom_rect(aes(xmin = 7.5, xmax = 10, ymin = 10000, ymax = 20000), color='black', linetype='dashed', alpha=0) +
  geom_path(aes(x,y,group=grp), 
            data=data.frame(x = c(1,7.5,5,10), y=c(1500,10000,1500,10000),grp=c(1,1,2,2)),
            linetype='dashed')


## second layer of plot
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")

file_list <- c(             
                "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"
                )

for (group in file_list){

    ## key step
    ## conditional axis name plot
    ## plot a frame
    #pas_REF_pas_Dat <- read.table("msmc.pas_REF_pas_out_non_empty.20bootstrap_chrall.final.txt", header=TRUE)
    assign(paste0(group,"_Dat"), read.table(fs::dir_ls(path=paste0(result_path,"/",group), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary"),header=TRUE,sep="\t"))
    print(paste0(group,"_Dat"))
    print(which(group == file_list))
    print(head(get(paste0(group,"_Dat")),n=2L))
    print(paste0("p",which(group == file_list)))
    print(which(group == file_list))
#}
    p <- list()
    p[[group]] <- ggplot(data = get(paste0(group,"_Dat")), aes(x = year))
    #p[[print(which(group == file_list))]] <- ggplot(data = get(paste0(group,"_Dat")), aes(x = year))
    
}

do.call(grid.arrange,p)

#### chatGTP assistance
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(result_path)

file_list <- c(             
                "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"
                )

for (group in file_list){
 
    ## key step
    ## conditional axis name plot
    ## plot a frame
    file_path <- fs::dir_ls(path=paste0(result_path,"/",group), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
    data <- read.table(file_path,header=TRUE,sep="\t")
 
p1_initial <- ggplot(data = data, aes(x = year)) +
    xlim(1,100000)+
    ylim(1,90000)+
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
    labs(title = group, x="Year ago",y=expression(paste(italic("N")["e"])))
    #ggtitle(group)
    #ylab(bquote(N[e]))
 
    # axis of select area for zoom
p1_zoom <- ggplot(data = data, aes(x = year)) +
    ylim(1,100000)+
    scale_x_log10(lim= c(1,15000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 11,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 11),axis.title = element_text(colour = "black",size = 12),
    panel.border = element_rect(linewidth = 0.5),panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2))+
    labs(x="Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))
 
p1_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 40000, xmax = 100000, ymin = 70000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 40000, xmax = 100000, ymin = 60000, ymax = 100000), color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(15000,40000), y=c(90000,100000),grp=c(1,1,2,2)),
                linewidth=0.5,linetype='dashed')
    
    ## add plot to the list
    plot_list[[group]] <- p1_final
 
}
 
 
#***************************
 
combined_plot <- marrangeGrob(grobs = plot_list,ncol = 3, nrow = 3)
pdf_file <- file.path(result_path,"combined_plot.pdf")
ggsave(pdf_file,combined_plot,width = 20, height = 20)

##########################  final #####################################

result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(result_path)

file_list_a <- c(             
                "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"
                )

file_list_b <- c(             
                "BomVet_REF_BomPas.no_singleton_174_1500x", 
                "BomVet_REF_BomPas.no_singleton_290_1500x",
                "BomVet_REF_BomPas.no_singleton_416_1500x",
                "BomVet_REF_BomHyp.no_singleton_174_1500x",
                "BomVet_REF_BomHyp.no_singleton_290_1500x",
                "BomVet_REF_BomHyp.no_singleton_416_1500x",
                "BomVet_REF_ApisMel.no_singleton_174_1500x",
                "BomVet_REF_ApisMel.no_singleton_290_1500x",
                "BomVet_REF_ApisMel.no_singleton_416_1500x"
                )

## initialize a list to store plot
plot_list <- list()

for (i in 1:length(file_list_a)){
#for (group in file_list){

    ## key step
    ## conditional axis name plot
    ## plot a frame
    file_path <- fs::dir_ls(path=paste0(result_path,"/",file_list_a[i]), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary")
    data <- read.table(file_path,header=TRUE,sep="\t")
    p <- ggplot(data = data, aes(x = year)) +
    scale_x_log10(lim= c(1,100000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red") +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    ggtitle(file_list_a[i])
    
    ## add plot to the list
    plot_list[[file_list_a[i]]] <- p
}

************************* chatGTP *********************
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
    xlim(1,85000)+
    ylim(1,100000)+
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
    scale_x_log10(lim= c(1,15000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 11,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 11),axis.title = element_text(colour = "black",size = 12),
    panel.border = element_rect(linewidth = 0.5),panel.grid.major = element_line(color = "gray", size = 0.25, linetype = 2))+
    labs(x="Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))

p1_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 35000, xmax = 85000, ymin = 60000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 35000, xmax = 85000, ymin = 60000, ymax = 100000), color='black', linetype='dashed', linewidth=0.5, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(15000,35000), y=c(90000,100000),grp=c(1,1,2,2)),
                linewidth=0.5,linetype='dashed')
    
    ## add plot to the list
    plot_list[[file_list_a[i]]] <- p1_final

}


#***************************

combined_plot <- marrangeGrob(grobs = plot_list,ncol = 3, nrow = 3)
pdf_file <- file.path(result_path,"combined_plot.pdf")
ggsave(pdf_file,combined_plot,width = 20, height = 20)


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


********************************** old method *******************************************************
file_list <- c(             
                "BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic",
                "BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"
                )

library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)
library(yarrr)
library(plotrix)
library(ggplot2)
library(ggpubr)

library(sp)
library(ggplot2)
library(grid) # for unit
library(gridExtra) # for grid.arrange

## test
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd(paste0(result_path,"/BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic"))

list.files(pattern = "BomVet_New_REF_BomPas.no_singleton_sfs_*_1500x_sm_genic.final.summary")

mixedsort(sort(fs::dir_ls(path=result_path, recurse = 1, fail=TRUE, type = "file", glob = "*AndMar_New_REF_*.no_singleton_sfs_*_1500x_sm_genic.final.summary")))
mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "AndMar_New_REF_AndHae.no_singleton_sfs_240_1500x_sm_genic.final.summary")))
##
#1
setwd(paste0(result_path,"/BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic"))
df1 <- read.table("BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
head(df1)
#2
setwd(paste0(result_path,"/BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic"))
df2 <- read.table("BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#3
setwd(paste0(result_path,"/BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic"))
df3 <- read.table("BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#4
setwd(paste0(result_path,"/BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic"))
df4 <- read.table("BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#5
setwd(paste0(result_path,"/BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic"))
df5 <- read.table("BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#6
setwd(paste0(result_path,"/BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic"))
df6 <- read.table("BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#7
setwd(paste0(result_path,"/BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic"))
df7 <- read.table("BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#8
setwd(paste0(result_path,"/BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic"))
df8 <- read.table("BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic.final.summary",header=TRUE,sep="\t")
#9
setwd(paste0(result_path,"/BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic"))
df9 <- read.table("BomVet_New_REF_ApisMel.no_singleton_sfs_416_1500x_sm_genic.final.summary",header=TRUE,sep="\t")


## https://stackoverflow.com/questions/66409781/how-to-plot-a-zoom-of-the-plot-inside-the-same-plot-area-using-ggplot2
zoom_plot <- function(df){
p1_initial <- ggplot(data = df, aes(x = year)) +
    xlim(1,100000)+
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.4) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    ## frame to selected area on the plot
    #geom_rect(aes(xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000), color = "green", alpha = 0.3) +
    annotate(geom = "rect",xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000, color = "black", linewidth = 0.2, alpha = 0.1) +
    theme_pubr( base_size = 5, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 5),axis.title = element_text(colour = "black",size = 5), plot.title = element_text(hjust = 0.5, size=5),panel.border = element_rect(linewidth = 0.5))+
    labs(title = "BomVet_REF_BomPas.no_singleton_174_1500x", x="Year ago",y=expression(paste(italic("N")["e"])))
    #ylab(bquote(N[e]))

    # axis of select area for zoom
p1_zoom <- ggplot(data = df, aes(x = year)) +
    scale_x_log10(lim= c(1,100000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red", linewidth = 0.4) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 4,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 4),axis.title = element_text(colour = "black",size = 5),panel.border = element_rect(linewidth = 0.5))+
    labs(x="Time/Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))

p1_final <- p1_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p1_zoom), xmin = 30000, xmax = 100000, ymin = 70000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 30000, xmax = 100000, ymin = 60000, ymax = 100000), color='black', linetype='dashed', linewidth=0.2, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(10,30000,20000,30000), y=c(55000,100000,55000,60000),grp=c(1,1,2,2)),
                linewidth=0.2,linetype='dashed')

}

zoom_plot(df1)
zoom_plot(df2)
zoom_plot(df3)

combined_plot_BomVet <- grid.arrange(p1_final,p2_final,p3_final,ncol=3,nrow=3)
ggsave("BomVet_REF_BomPas_BomHyp_ApisMel_combined-.pdf",plot = combined_plot_BomVet,width=20,height=20,unit="cm")


##

p2_initial <- ggplot(data = df2, aes(x = year)) +
    xlim(1,100000)+
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    ## frame to selected area on the plot
    #geom_rect(aes(xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000), color = "green", alpha = 0.3) +
    annotate(geom = "rect",xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000, color = "black", linewidth = 0.2, alpha = 0.1) +
    theme_pubr( base_size = 5, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 5),axis.title = element_text(colour = "black",size = 5), plot.title = element_text(size=5),panel.border = element_rect(linewidth = 0.5))+
    labs(title = "BomVet_REF_BomPas.no_singleton_174_1500x", x="Year ago",y=expression(paste(italic("N")["e"])))
    #ylab(bquote(N[e]))

    # axis of select area for zoom
p2_zoom <- ggplot(data = df2, aes(x = year)) +
    scale_x_log10(lim= c(1,100000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red") +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 4,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 4),axis.title = element_text(colour = "black",size = 5),panel.border = element_rect(linewidth = 0.5))+
    labs(x="Time/Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))

p2_final <- p2_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p2_zoom), xmin = 30000, xmax = 100000, ymin = 70000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 30000, xmax = 100000, ymin = 60000, ymax = 100000), color='black', linetype='dashed', linewidth=0.2, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(10,30000,20000,30000), y=c(55000,100000,55000,60000),grp=c(1,1,2,2)),
                linewidth=0.2,linetype='dashed')

##

p3_initial <- ggplot(data = df3, aes(x = year)) +
    xlim(1,100000)+
    geom_line(aes(y = Ne_median), color = "red", linewidth = 0.5) +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    ## frame to selected area on the plot
    #geom_rect(aes(xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000), color = "green", alpha = 0.3) +
    annotate(geom = "rect",xmin = 10, xmax = 20000, ymin = 30000, ymax = 55000, color = "black", linewidth = 0.2, alpha = 0.1) +
    theme_pubr( base_size = 5, border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 5),axis.title = element_text(colour = "black",size = 5), plot.title = element_text(size=5),panel.border = element_rect(linewidth = 0.5))+
    labs(title = "BomVet_REF_BomPas.no_singleton_174_1500x", x="Year ago",y=expression(paste(italic("N")["e"])))
    #ylab(bquote(N[e]))

    # axis of select area for zoom
p3_zoom <- ggplot(data = df3, aes(x = year)) +
    scale_x_log10(lim= c(1,100000),labels = function(year) format(year, scientific = FALSE)) +
    geom_line(aes(y = (Ne_median)), color = "red") +
    geom_ribbon(aes(ymin = Ne_12.5.,ymax = Ne_87.5.),fill = "blue",alpha = 0.2) +
    #geom_line(aes(y = df1$Ne_12.5),color = "blue") +                        
    #geom_line(aes(y = df1$Ne_87.5),color = "blue") +
    #xlim (1, 200000) +
    #ylim (0, 70000) +
    theme_pubr( base_size = 4,border = TRUE) +
    theme(axis.text = element_text(colour = "black",size = 4),axis.title = element_text(colour = "black",size = 5),panel.border = element_rect(linewidth = 0.5))+
    labs(x="Time/Year ago (log transformed)",y=expression(paste(italic("N")["e"])))
    #scale_x_continuous(labels = function(year) format(year, scientific = FALSE))

p3_final <- p3_initial + 
    ## position of zoom plot
    annotation_custom(ggplotGrob(p3_zoom), xmin = 30000, xmax = 100000, ymin = 70000, ymax = 100000) +
    ## position of annotation frame
    geom_rect(aes(xmin = 30000, xmax = 100000, ymin = 60000, ymax = 100000), color='black', linetype='dashed', linewidth=0.2, alpha=0) +
    ## conncetion line to one side of the frame [geom_rect]
    geom_path(aes(x,y,group=grp), 
                #[selected-annotation:left-right]
                data=data.frame(x = c(10,30000,20000,30000), y=c(55000,100000,55000,60000),grp=c(1,1,2,2)),
                linewidth=0.2,linetype='dashed')
##

combined_plot_BomVet <- grid.arrange(p1_final,p2_final,p3_final,ncol=3,nrow=3)
ggsave("BomVet_REF_BomPas_BomHyp_ApisMel_combined.pdf",plot = combined_plot_BomVet,width=20,height=20,unit="cm")

