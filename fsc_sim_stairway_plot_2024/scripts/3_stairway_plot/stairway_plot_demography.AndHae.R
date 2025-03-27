
install.packages("scales")  
library("scales", help, pos = 2, lib.loc = NULL)


## stairway_plot output final: example data
mutation_per_site	n_estimation	theta_per_site_median	theta_per_site_2.5%	theta_per_site_97.5%	year	Ne_median	Ne_2.5%	Ne_97.5%	Ne_12.5%	Ne_87.5%
4.9E-324	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.372404573E-315	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918
6.546688913863476E-9	200	0.0012739056349883714	5.180433762967911E-4	0.003462709012129418	1.81852469829541	88465.66909641468	35975.234465054935	240465.90362009848	49338.45553111763	140003.81808431918

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")
mu <- 3.6e-9
gen <- 1
pas_REF_pas_Dat<-read.table("pas_REF_pas_out_non_empty_20bootstrap_chr20.final.txt", header=TRUE)
vet_REF_pas_Dat<-read.table("vet_REF_pas_out_non_empty.final.txt", header=TRUE)

class(pas_REF_pas_Dat$left_time_boundary/mu*gen)

pdf("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/pas_vet_REF_pas.msmc_1.pdf")
plot(pas_REF_pas_Dat$left_time_boundary/mu*gen, (1/pas_REF_pas_Dat$lambda)/(2*mu), log="x",xlim=c(1000,10000000),ylim=c(0,7000000),
     type="n", xlab="Years ago", ylab="effective population size")
lines(pas_REF_pas_Dat$left_time_boundary/mu*gen, (1/pas_REF_pas_Dat$lambda)/(2*mu), type="s", col="red")
lines(vet_REF_pas_Dat$left_time_boundary/mu*gen, (1/vet_REF_pas_Dat$lambda)/(2*mu), type="s", col="blue")
legend("topright",legend=c("pas_REF_pas", "vet_REF_pas"), col=c("red", "blue"), lty=c(1,1))

dev.off()

************************************** some bash codes ***************************************
cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3
## move stairway results (200hapS) from systematic_ft_test3 to systematic_ft_non_pruned
[yzliu@fe-open-01 systematic_ft_test3]$ mv *200hapS*e_[id]_cons*_[1-5] ../systematic_ft_non_pruned/

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/10000Ne_new
for par in `ls *cons* `;do rename G_10e_ G_01e_ $par;done
for par in `ls *cons* `;do rename G_2e_ G_05e_ $par;done

for par in `ls *cons* `;do rename G_05e_ G_2e_ $par;done
for par in `ls *cons* `;do rename G_01e_ G_10e_ $par;done

find -maxdepth 2 | grep final.summary$ | egrep *200hapS.*[014]\{1,2\}e_[id]_[014]\{1,2\}[di]* | sort -V | wc -l

library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)

## test
result_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")

list.files(pattern = "AndMar_New_REF_BomPas.no_singleton_sfs_*_1500x_sm_genic.final.summary")

mixedsort(sort(fs::dir_ls(path=result_path, recurse = 1, fail=TRUE, type = "file", glob = "*AndHae_New_REF_*.no_singleton_sfs_*_1500x_sm_genic.final.summary")))
mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "AndHae_New_REF_AndHae.no_singleton_sfs_234_1500x_sm_genic.final.summary")))
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr2.final.txt
assign(paste0("a1"), read.table(mixedsort(sort(fs::dir_ls(path=result_path, recurse = 2, fail=TRUE, type = "file", glob = "*AndHae_New_REF_AndHae.no_singleton_sfs_234_1500x_sm_genic.final.summary"))),header=T,sep="\t"))
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

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## plot stairway plot results in R
#=============Plot stairway plot including confidence intervals for a population (using R)
#Population ACHT
pops <- c("ACHT","XCD","SDF")
cols <- c("#B2182B","#B218OB","#B21823")
r$> cols
     ACHT       XCD       SDF 
"#B2182B" "#B218OB" "#B21823"

pops <- c("sim_100000Ne")
cols <- c("#B2182B")
names(cols) <- pops


tiff("ACHT_stairway.tiff",units="cm", width = 16, height = 10, res=200)

par(mar=c(5,4,2,2)+0.1)
plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5), log="x", xlab="Years ago", ylab="Effective population size",xaxt='n')
axis(side=1, at=c(10,100,1000,10000,100000,1000000,10000000),label=c(format(c(10,100,1000,10000,100000,1000000,10000000),scientific=FALSE)))
abline(v=13000,col="grey",lwd=3)  # add a vertical line at 13,000 years ago to indicate end of last glaction

for (pop in pops)
{
#    a <- read.table("ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.final.summary",header=T,sep="\t")
    a <- read.table("ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS.final.summary",header=T,sep="\t")
#    a <- read.table(sprintf("%s/%s_fold.final.summary",pop,pop),header=T,sep="\t")
    lines(a$year,a$Ne_median,col=cols[pop],lwd=5)  # plot trajectory
    lines(a$year,a$Ne_2.5.,col=cols[pop],lty=3)  # plot lower CI boundary
    lines(a$year,a$Ne_97.5.,col=cols[pop],lty=3)  # plot upper CI boundary
}
legend("topright",pops,col=cols,lty=1,lwd=3,bty="n")
## lty=1 solid line, bty="n" supress box
dev.off()
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>




setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/10KNe_swp")
final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned"
mixedsort(sort(fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*G_*e_*_cons*200hapS*15Mb_*.final.summary")))
## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*200hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")


>>>>>>>>>>>>>>>>>> below checked <<<<<<<<<<<<<<<<<<
group <- "vet_REF_pas"
rep <- "all"

pdf(paste0("StairwayPlot_AndHae.Median_75CI_95CI.pdf"),width = 20, height = 20)
## set number of plot in a figure
#par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

par(mfcol=c(3,3),mar=c(4.0,4.5,5.8,1)+0.6,cex.lab=2.2, cex.axis=1.8,lwd=2.5)
layout(matrix(c(1:9),nrow=3,ncol=3,byrow=F),width=c(1,1),height=c(1,1))

## single vector in for loop
for (group in c(
                "AndHae_New_REF_AndHae.no_singleton_sfs_234_1500x_sm_genic", 
                "AndHae_New_REF_AndHae.no_singleton_sfs_390_1500x_sm_genic",
                "AndHae_New_REF_AndHae.no_singleton_sfs_546_1500x_sm_genic",
                "AndHae_New_REF_AndHat.no_singleton_sfs_234_1500x_sm_genic",
                "AndHae_New_REF_AndHat.no_singleton_sfs_390_1500x_sm_genic",
                "AndHae_New_REF_AndHat.no_singleton_sfs_546_1500x_sm_genic",
                "AndHae_New_REF_BomPas.no_singleton_sfs_234_1500x_sm_genic",
                "AndHae_New_REF_BomPas.no_singleton_sfs_390_1500x_sm_genic",
                "AndHae_New_REF_BomPas.no_singleton_sfs_546_1500x_sm_genic"
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
    if (group %in% c("AndHae_New_REF_AndHae.no_singleton_sfs_234_1500x_sm_genic", 
                    "AndHae_New_REF_AndHae.no_singleton_sfs_390_1500x_sm_genic"
                    )) {
        plot(1,1, type="n", xlim=c(10,1e6), ylim=c(1e3,8e5),log="x", xlab="", ylab="Effective population size",yaxt='n')
        ## ,xaxt='n',yaxt='n'
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,2e5,4e5,6e5,8e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("AndHae_New_REF_AndHae.no_singleton_sfs_546_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,1e6), ylim=c(1e3,8e5),log="x",xlab="Years ago", ylab="Effective population size",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,2e5,4e5,6e5,8e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("AndHae_New_REF_AndHat.no_singleton_sfs_234_1500x_sm_genic",
                            "AndHae_New_REF_AndHat.no_singleton_sfs_390_1500x_sm_genic"
                            #"AndHae_New_REF_AndHat.no_singleton_sfs_546_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,1e6), ylim=c(1e3,8e5),log="x",xlab="", ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,2e5,4e5,6e5,8e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    } else if (group %in% c("AndHae_New_REF_BomPas.no_singleton_sfs_234_1500x_sm_genic",
                            "AndHae_New_REF_BomPas.no_singleton_sfs_390_1500x_sm_genic"
                            )) {
        plot(1,1, type="n", xlim=c(10,1e6), ylim=c(1e3,8e5),log="x",xlab="", ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,2e5,4e5,6e5,8e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
        #axis(side=2, at=c(1000,250000,1000000,3000000,4000000,10000000),label=c(format(c(1000,250000,1000000,3000000,4000000,10000000),scientific=TRUE)))
    } else {
        plot(1,1, type="n", xlim=c(10,1e6), ylim=c(1e3,8e5),log="x",xlab="Years ago",ylab="",yaxt='n')
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_median,col=adjustcolor("red", alpha = 1),lty=1,lwd=3)  # plot trajectory
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_2.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_97.5.,col=adjustcolor("blue", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_12.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot lower CI boundary
        lines(get(paste0(group,"_Dat"))$year,get(paste0(group,"_Dat"))$Ne_87.5.,col=adjustcolor("goldenrod", alpha = 0.8),lty=5,lwd=2.5)  # plot upper CI boundary
        y_label <- c(1e3,2e5,4e5,6e5,8e5)
        axis(side=2, at=y_label,label=c(formatC(y_label,format="e",digits=0)))
    }
    ## without showing ticks xaxt='n',yaxt='n'
    title(cex=2.0,line=6)

    ## add plot title in each plot
    mtext(side=3,text=paste0(substr(group,1,7),substr(group,12,21),"_DP_",substr(group,40,48)),cex=1.5,line=4)
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
    if (all(sapply(c("AndHae_New_REF_AndHae"), grepl, group))) {
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



pas_REF_pas_Dat<-read.table("pas_REF_pas_out_non_empty_20bootstrap_chr20.final.txt", header=TRUE)
plot(pas_REF_pas_Dat$left_time_boundary/mu,(1/pas_REF_pas_Dat$lambda/(2*mu)), type="n", xlim=c(1,5e7), ylim=c(1,5e6),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
title(line=4)

## add plot title in each plot
mtext(side=3,text=paste0("MSMC_pas_REF_pas"),cex=0.8,line=1.2)
## add line to indicate ice-age
#abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction
#lines(c(1:100),rep(100,100), type="s", col="red")
## add replicate lines
#par(new=TRUE)
mu <- 3.6e-9
gen <- 1
for (rep in c(1:20)){
    ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
    ## assign variable to read_data
    assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = paste0("*pas_REF_pas*_chr",rep,".final.txt")))),header=T,sep="\t"))
    print(rep)
    print(head(get(paste0("a",rep)),n=2L))
    #paste0("data_ft_sim_10000Ne_200hapS_1E_",generation,"_",event,"_20Chr_15Mb")
    #print(head(data,n=2L))
    ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
    lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a",rep))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))
    #print(head(get(paste0("a",rep))$left_time_boundary/mu*gen))
    print(head((1/get(paste0("a",rep))$lambda)/(2*mu)))
}

#for (group in c("pas_REF_pas","vet_REF_pas","hae_REF_hae","mar_REF_hae")){
for (group in c("pas_REF_pas","")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    #for (event in c("2e_d_cons","10e_d_cons","2e_i_cons","10e_i_cons")){
        ## solo axis name plot
        #plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        ##log="xy",xlab="Years ago", ylab="Effective population size"
        #title(line=2)

        ## key step
        ## conditional axis name plot
        plot_name <- paste0("MSMC_",group)
        #print(plot_name)
        
        plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.5e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        #log="xy",xlab="Years ago", ylab="Effective population size"
        title(line=2)
        #if (plot_name %in% c("10000Ne_200hapS_1E_50G_2e_d_cons_20Chr_15Mb", "10000Ne_200hapS_1E_100G_2e_d_cons_20Chr_15Mb", "10000Ne_200hapS_1E_500G_2e_d_cons_20Chr_15Mb")){
        #    plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.5e4),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
        #    #log="xy",xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        #} else if (plot_name %in% c("10000Ne_200hapS_1E_1000G_2e_d_cons_20Chr_15Mb")){
        #    plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.5e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        #    #xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        #} else if (plot_name %in% c("10000Ne_200hapS_1E_1000G_10e_d_cons_20Chr_15Mb","10000Ne_200hapS_1E_1000G_2e_i_cons_20Chr_15Mb")){
        #    plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,2.0e4),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
        #    #xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        #    
        #    ## high Ne (attention to duplicate)

        #} else if (plot_name %in% c("10000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb","10000Ne_200hapS_1E_100G_10e_i_cons_20Chr_15Mb","10000Ne_200hapS_1E_500G_10e_i_cons_20Chr_15Mb")){
        #    plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,7.0e4),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
        #    #xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        #} else if (plot_name %in% c("10000Ne_200hapS_1E_1000G_10e_i_cons_20Chr_15Mb")){
        #    plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,7.0e4),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        
        #} else {
        #    plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,2.0e4),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
        #    title(line=2)
        #}
        ##turn scientific notion off
        ##axis(side=1,at=c(50,100,500,1000,10000,100000,200000),las=0,label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=TRUE)))
        #axis(side=2, at=c(500,1000,5000,7000,10000,20000,40000,50000,55000),label=c(format(c(500,1000,5000,7000,10000,20000,40000,50000,55000),scientific=FALSE)))
        ##eaxis(2, padj=0.5,cex.axis=1.5)
        
        ## rotating x axis labels
        #lablist.x <- as.vector(c(50,100,500,1000,10000,100000,200000))
        #axis(side=1,at=c(50,100,500,1000,10000,100000,200000),labels=FALSE)
        
        #text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 1300,srt = 38,pos = 3, xpd = TRUE)
        
        #10000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb
        #if (plot_name %in% c("10000Ne_200hapS_1E_50G_10e_i_cons_20Chr_15Mb","10000Ne_200hapS_1E_100G_10e_i_cons_20Chr_15Mb","10000Ne_200hapS_1E_500G_10e_i_cons_20Chr_15Mb","10000Ne_200hapS_1E_1000G_10e_i_cons_20Chr_15Mb")){
        #    text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 4800,srt = 38,pos = 3, xpd = TRUE)
        #} else {
        #    text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 1300,srt = 38,pos = 3, xpd = TRUE)
        #}

        ## add plot title in each plot
        mtext(side=3,text=paste0("MSMC_",group),cex=0.8,line=1.2)
        ## add line to indicate ice-age
        #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

        ## add replicate lines
        #par(new=TRUE)
        mu <- 3.6e-9
        gen <- 1
        for (rep in c(1:20)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            ## assign variable to read_data
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = paste0("*",group,"*_chr",rep,".final.txt")))),header=T,sep="\t"))
            #print(head(get(paste0("a",rep)),n=2L))
            #paste0("data_ft_sim_10000Ne_200hapS_1E_",generation,"_",event,"_20Chr_15Mb")
            #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
            #print(head(data,n=2L))
            ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
            lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a",rep))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))
            #lines(pas_REF_pas_Dat$left_time_boundary/mu*gen, (1/pas_REF_pas_Dat$lambda)/(2*mu), type="s", col="red")
            print(head(get(paste0("a",rep))$left_time_boundary/mu*gen))
            print(head((get(paste0("a",rep)))$lambda/(2*mu)))

        }
    # error check: Error in file(file, "rt") : invalid 'description' argument
    #}
}

        ## plot real demography

        ## piecewise function
        ## https://stackoverflow.com/questions/61157263/define-and-plot-a-piecewise-function-in-r
        ## https://stackoverflow.com/questions/65068196/how-to-plot-a-piecewise-function-in-r
        
        ## check if multiple patterns exist in string
        ## https://stackoverflow.com/questions/30180281/how-can-i-check-if-multiple-strings-exist-in-another-string

        x <- 0:100000
        #plot_name <- c("10000Ne_200hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_200hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_200hapS_1E_1000G_1.9i_20Chr_15Mb","10000Ne_200hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
        ## category
        ## 50G "G_2e_d_cons" (r=-0.0139,er=0.9862),"G_2e_i_cons" (r=0.0139,er=1.0140),"G_10e_d_cons" (r=-0.0461,er=0.9549),"G_10e_i_cons" (r=0.0461,er=1.0472) # nolint
        ## 100G "G_2e_d_cons" (r=-0.0069,er=0.9931),"G_2e_i_cons" (r=0.0069,er=1.0069),"G_10e_d_cons" (r=-0.0230,er=0.9773),"G_10e_i_cons" (r=0.0230,er=1.0233)
        ## 500G "G_2e_d_cons" (r=-0.0014,er=0.9986),"G_2e_i_cons" (r=0.0014,er=1.0014),"G_10e_d_cons" (r=-0.0046,er=0.9954),"G_10e_i_cons" (r=0.0046,er=1.0046)
        ## 1000G "G_2e_d_cons" (r=-0.0007,er=0.9993),"G_2e_i_cons" (r=0.0007,er=1.0007),"G_10e_d_cons" (r=-0.0023,er=0.9977),"G_10e_i_cons" (r=0.0023,er=1.0023)

        ## er=λ; (er)t=λt 

        fx <- function(x) {
            if (all(sapply(c("G_cons_cons"), grepl, plot_name))) {
                ## constant Ne
                return(5000)
            
            ## gen_100
            } else if (all(sapply(c("50G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(5000*(0.9862^x))
                } else {
                    return(5000*(0.9862^50))
                }
            } else if (all(sapply(c("50G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(1.0140^x))
                } else {
                    return(5000*(1.0140^50))
                }
            } else if (all(sapply(c("50G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(0.9549^x))
                } else {
                    return(5000*(0.9549^50))
                }
            } else if (all(sapply(c("50G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(1.0472^x))
                } else {
                    return(5000*(1.0472^50))
                }
            
            ## gen_100
            } else if (all(sapply(c("100G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(0.9931^x))
                } else {
                    return(5000*(0.9931^100))
                }
            } else if (all(sapply(c("100G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(1.0069^x))
                } else {
                    return(5000*(1.0069^100))
                }
            } else if (all(sapply(c("100G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(0.9773^x))
                } else {
                    return(5000*(0.9773^100))
                }
            } else if (all(sapply(c("100G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(1.0233^x))
                } else {
                    return(5000*(1.0233^100))
                }
            
            ## gen_500
            } else if (all(sapply(c("500G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(5000*(0.9986^x))
                } else {
                    return(5000*(0.9986^500))
                }
            } else if (all(sapply(c("500G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(1.0014^x))
                } else {
                    return(5000*(1.0014^500))
                }
            } else if (all(sapply(c("500G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(0.9954^x))
                } else {
                    return(5000*(0.9954^500))
                }
            } else if (all(sapply(c("500G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(1.0046^x))
                } else {
                    return(5000*(1.0046^500))
                }
            
            ## gen_1000
            } else if (all(sapply(c("1000G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000*(0.9993^x))
                } else {
                    return(5000*(0.9993^1000))
                }
            } else if (all(sapply(c("1000G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                     return(5000*(1.0007^x))
                } else {
                    return(5000*(1.0007^1000))
                }
            } else if (all(sapply(c("1000G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000*(0.9977^x))
                } else {
                    return(5000*(0.9977^1000))
                }
            # } else if (all(sapply(c("1000G","G_0.5e_d_1.5i"), grepl, plot_name))) {
            } else {
                if (x <= 1000) {
                    return(5000*(1.0023^x))
                } else {
                    return(5000*(1.0023^1000))
                }
            #} else {
            #    ## return empty value
            #    NULL
            #    #return(NULL)
            }
        }
        lines(x,sapply(x,fx),type="s",lwd=2.5,col = adjustcolor("red", alpha = 0.8))
        ## add legend in specific plot
        if (all(sapply(c("_2e_d_cons"), grepl, plot_name))) {
        legend("topright",c("Simulation","True model"),col = adjustcolor(c("blue","red"), alpha = 0.8),lty=1,lwd=c(2,3),bty="n")
        } else {
            NULL
        }
    }
}

dev.off()

****************************************** regular plot ********************************************
setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")
#pdf("exp_cons_plot_test_50000y.new.pdf")
par(new=TRUE)
#plot(1,1,type="n", xlim=c(1,6000), ylim=c(1,1.0e5),log="x", xlab="x", ylab="y",xaxt='n',yaxt='n')
plot(1,1,type="n", ylim=c(1,6000), xlim=c(1,1.0e5),log="x", xlab="x", ylab="y")

x <- 0:100000
y <- 5000*(0.9993^x)
lines(x,y,type="s")

dev.off()

plot(x,y,type="s")
plot(x,y,type="l")

*************************************************************************************************************
## plot more obvious
pdf("exp_cons_plot_test_50000y.pdf")
x <- 0:100000
y <- function(x) {
    if (x <= 50000) {
    return(5000*(0.9993^x))
} else {
    return(5000*(0.9993^1000)*1.5)
}
}
plot(x,sapply(x,y),type="s")
dev.off()

****************************************** piewise plot function log ***********************************
x <- 0:100000
#pdf("exp_cons_plot_test_50000y.piewise_fun_log.pdf")
#plot(1,1,type="n", ylim=c(1,6000), xlim=c(1,1.0e5),log="x", xlab="x", ylab="y")
#plot(1,1,type="n", ylim=c(1,6000), xlim=c(1,1.0e5),log="x", xlab="x", ylab="y")
#par(new=TRUE)
y <- function(x) {
    if (x <= 50000) {
    return(5000*(0.9993^x))
} else {
    return(5000*(0.9993^1000)*1.5)
}
}
#lines(x,sapply(x,y),type="s")
plot(x,sapply(x,y),type="s",xaxt='n')
#axis(1,at=c(50,100,500,1000,10000,100000,200000),labels=FALSE)
lablist.x <- as.vector(c(50,100,500,1000,10000,100000,200000))
text(x=c(50,100,500,1000,10000,100000,200000),labels = format(lablist.x,scientific=TRUE),par("usr")[3] - 405,srt = 30,pos = 3, xpd = TRUE)
dev.off()

***************************************** piewise plot function without log *****************************
x <- 0:100000
#pdf("exp_cons_plot_test_50000y.new.pdf")
#plot(1,1,type="n", ylim=c(1,6000), xlim=c(1,1.0e5),log="x", xlab="x", ylab="y")
#par(new=TRUE)
y <- function(x) {
    if (x <= 50000) {
    return(5000*(2.3^x))
} else {
    return(5000*(2.3^1000)*1.5)
}
}
#lines(x,sapply(x,y),type="s")
plot(x,sapply(x,y),type="s",ylim=c(1,6000), xlim=c(1,1.0e5))
dev.off()

**************************************************************************************************
x <- 0:100000
#pdf("exp_cons_plot_test_50000y.new.pdf")
plot(1,1,type="n", ylim=c(1,6000), xlim=c(1,1.0e5),log="x", xlab="x", ylab="y")
par(new=TRUE)
y <- function(x) {
    if (x <= 50000) {
    return(5000*(4.3^x))
} else {
    return(5000*(4.3^1000)*1.5)
}
}
lines(x,sapply(x,y),type="s")
#plot(x,sapply(x,y),type="s")
dev.off()

