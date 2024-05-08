
install.packages("scales")  
library("scales", help, pos = 2, lib.loc = NULL)

## stairway_plot output final: example data
mutation_per_site	n_estimation	theta_per_site_median	theta_per_site_2.5%	theta_per_site_97.5%	year	Ne_median	Ne_2.5%	Ne_97.5%	Ne_12.5%	Ne_87.5%
4.9E-324	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.372404573E-315	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918
6.546688913863476E-9	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.81852469829541	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918

## load libraries
library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)

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
plot(1,1, type="n", xlim=c(1,1e6), ylim=c(1,7e5),log="x", xlab="Years ago", ylab="Effective population size")
## ,xaxt='n',yaxt='n'
## specific line color
## https://www.nceas.ucsb.edu/sites/default/files/2020-04/colorPaletteCheatsheet.pdf
lines(a1$year,a1$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
lines(a1$year,a1$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2)  # plot lower CI boundary
lines(a1$year,a1$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2)  # plot upper CI boundary
lines(a1$year,a1$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2)  # plot lower CI boundary
lines(a1$year,a1$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2)  # plot upper CI boundary

>>>>>>>>>>>>>>>>>> below checked <<<<<<<<<<<<<<<<<<

pdf(paste0("StairwayPlot_BomVet.Median_75CI_95CI.pdf"),width = 20, height = 20)
## set number of plot in a figure
#par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

par(mfcol=c(3,3),mar=c(4.0,4.5,5.8,1)+0.6,cex.lab=2.2, cex.axis=1.8,lwd=2.5)
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
    mu <- 3.6e-9
    gen <- 1
    ## key step
    ## conditional axis name plot
    ## plot a frame
    #pas_REF_pas_Dat <- read.table("msmc.pas_REF_pas_out_non_empty.20bootstrap_chrall.final.txt", header=TRUE)
    assign(paste0(group,"_Dat"), read.table(fs::dir_ls(path=paste0(result_path,"/",group), recurse = 2, fail=TRUE, type = "file", glob = "*_1500x_sm_genic.final.summary"),header=TRUE,sep="\t"))
    print(paste0(group,"_Dat"))
    #plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1e3,5e7), ylim=c(1e5,1e6),log="x", xlab="Years ago", ylab="Effective population size")
    if (group %in% c("BomVet_New_REF_BomPas.no_singleton_sfs_174_1500x_sm_genic", 
                    "BomVet_New_REF_BomPas.no_singleton_sfs_290_1500x_sm_genic"
                    )) {
        plot(1,1, type="n", xlim=c(10,2e5), ylim=c(1e3,2e5),log="x", xlab="", ylab="Effective population size",yaxt='n')
        ## ,xaxt='n',yaxt='n'
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("BomVet_New_REF_BomPas.no_singleton_sfs_416_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,2e5), ylim=c(1e3,2e5),log="x",xlab="Years ago", ylab="Effective population size",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("BomVet_New_REF_BomHyp.no_singleton_sfs_174_1500x_sm_genic",
                            "BomVet_New_REF_BomHyp.no_singleton_sfs_290_1500x_sm_genic"
                            #"BomVet_New_REF_BomHyp.no_singleton_sfs_416_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,2e5), ylim=c(1e3,2e5),log="x",xlab="", ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("BomVet_New_REF_ApisMel.no_singleton_sfs_174_1500x_sm_genic",
                            "BomVet_New_REF_ApisMel.no_singleton_sfs_290_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,2e5), ylim=c(1e3,2e5),log="x",xlab="", ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
        #axis(side=2, at=c(1000,250000,1000000,3000000,4000000,10000000),label=c(format(c(1000,250000,1000000,3000000,4000000,10000000),scientific=TRUE)))
    } else {
        plot(1,1, type="n", xlim=c(10,2e5), ylim=c(1e3,2e5),log="x",xlab="Years ago",ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lty=1,lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,1e4,2e4,4e4,6e4,8e4,1e5,2e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    }
    ## without showing ticks xaxt='n',yaxt='n'
    title(cex=1.5,line=6)

    ## add plot title in each plot
    mtext(side=3,text=paste0(substr(group,1,7),substr(group,12,21),"_DP_",substr(group,40,48)),cex=1.2,line=4)
    ## add line to indicate ice-age [11550-12800], Wiki
    abline(h=500, v=12800,lwd=2.5,col=adjustcolor("grey", alpha = 0.5))  # add a vertical line at 13,000 years ago to indicate end of last glaction
    abline(v=11550,lwd=2.5,col=adjustcolor("grey", alpha = 0.5))
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
        #lines(get(paste0("a","all"))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=2.5,col = adjustcolor("red", alpha = 1))

    #}

    ## add legend in specific plot
    if (all(sapply(c("BomVet_New_REF_BomPas"), grepl, group))) {
    legend("topright",c("Median","75% CI","95% CI"),col = adjustcolor(c("red","goldenrod","blue"), alpha = 0.8),cex=1.5,lty=c(1,5,5),lwd=c(3,2.5,2.5),bty="n")
    } else {
        NULL
    }
    ## single for all plots
    ##legend("topright",c("Median","75% CI","95% CI"),col = adjustcolor(c("red","goldenrod","blue"), alpha = 0.8),lty=c(1,5,5),lwd=c(3,2,2),bty="n")
}

## end plot
dev.off()



*******************************************************************************************************
