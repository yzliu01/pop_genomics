
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
######################################################################################
## prepare combined data file



setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3-/ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS")
#setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3-/ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS")
## navigate to the parental folder
setwd("..")
getwd()
install.packages("fs")
library(fs)
list.files(path=summary,pattern="20hapS")
list.files(path=final_summary,include.dirs = T,pattern = "final.summary",full.names = T)

## https://stackoverflow.com/questions/15944844/list-files-in-ascending-order
## sort files ------ fs::dir_ls
## ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.final.summary
install.packages("gtools") # sort 
library(gtools)
#library(stringi)
library(stringr) ## more convient for multiple replacements than gsub
#https://stackoverflow.com/questions/63585270/r-stringr-mutate-i-think-multiple-partial-string-replacements-in-multiple
## make transparent plot
install.packages("scales")                                         # Install scales package
library("scales")
print(gsub("\\/home.*MSFS\\/","",file_list))
install.packages("sfsmisc") ## for exponential axis labels
library(sfsmisc)

final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3-"
setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3")

file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")
file_list <- mixedsort(sort(file_list0))

00d - 04d
file_list00 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "directory", glob = "*20hapS*50G*MSFS$")

pdf(paste0("combined.5rep.title.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1,2,3,4,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (event in c("00d","01d","05d","09d","05i")){
    #for (rep in c(1,2,3,4,5)){
        #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_",rep,"_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary")))
        #print(file_list00)
        #print(event)
        a1 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_1_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        print(head(a1,n=2L))
        plot(a1$year,a1$Ne_median,type="l", col="red")
        mtext(side=3,text=paste0("10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        #par(new=TRUE)
        a2 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_2_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        print(head(a2,n=2L))
        lines(a2$year,a2$Ne_median,type="l", col="red")

        a3 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_3_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        lines(a3$year,a3$Ne_median,type="l", col="red")

        a4 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_4_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        lines(a4$year,a4$Ne_median,type="l", col="red")

        a5 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_5_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        lines(a5$year,a5$Ne_median,type="l", col="red")
            #combined_data <- c()
            #table_name <- str_replace_all(rep_sum,c("./ft_sim.*MSFS/"="","_MSFS.final.summary"=""))
            #a <- read.table(rep_sum,header=T,sep="\t")
            #print(head(a,n=2L))
            #combined_data <- cbind(combined_data,a$year,a$Ne_median)
            #print(head(combined_data,n=2L))
    #}
}
dev.off()

library(reshape2)
require(plyr)
newdat <- cast(combined_data, year ~ Ne_median)


for event in {"04d","03i"};do
    file_list=`ls -d ft_sim_10000Ne_20hapS_1E_50G_$event*`
    echo $file_list
done

    for (rep in c(1,2)){
        file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_",rep,"_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary")))





## https://stackoverflow.com/questions/70948644/r-for-loop-over-all-files-in-directory-and-in-all-subdirectories
#tiff(paste0("combined.test3.tiff"),units="cm", width = 20, height = 20, res=300)
pdf(paste0("combined.test15.pdf"),width = 20, height = 25)
par(mfcol=c(4,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1,2,3,4,5,6,7,8,9,10,0,0,0,0,0,0,0,0,0,0),nrow=4,ncol=5,byrow=T),width=c(1,1),height=c(1,1))
for (final in file_list){
    #print(gsub("/home*MSFS/","",file_list))
    plot_name <- str_replace_all(final,c("/home.*MSFS/"="","_MSFS.final.summary"=""))
    #tiff(paste0(final,".test.tiff"),units="cm", width = 16, height = 20, res=200)
    #par(mfcol=c(2,1),mar=c(5,4,2,2)+0.1)
    if (plot_name %in% c("ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS.final.summary")){
        plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.5e5),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
        #log="xy",xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else if (plot_name %in% c("ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1")){
        plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.5e5),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else if (plot_name %in% c("ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.rand20.summary")){
        plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.5e5),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else {
        plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.5e5),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    }
    #plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="", ylab="",xaxt='n',yaxt='n')
    ##xlab="Years ago", ylab="Effective population size"
    #title(line=2)
    #axis(side=1,at=c(10,100,1000,10000,100000,1000000,10000000))
    axis(side=1,at=c(50,100,500,1000,10000,100000,200000),label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
    ##turn scientific notion off
    ##https://stackoverflow.com/questions/41992434/turning-scientific-notation-off-for-only-axis-in-r-plot
    #eaxis(1, padj=0.5,cex.axis=1.5)
    ##https://stackoverflow.com/questions/5963047/do-not-want-scientific-notation-on-plot-axis
    axis(side=2, at=c(500,1000,10000,50000,100000,1000000),label=c(format(c(500,1000,10000,50000,100000,1000000),scientific=FALSE)))
    #eaxis(2, padj=0.5,cex.axis=1.5)
    mtext(side=3,text=plot_name,cex=0.5,line=1.2)
    abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

    #print(file_list[final])
    a <- read.table(final,header=T,sep="\t")
    #print(head(a,n=2L))
    lines(a$year,a$Ne_median,col="red",lwd=2)  # plot trajectory
    lines(a$year,a$Ne_2.5.,col="blue",lty=1,lwd=0.5)  # plot lower CI boundary
    lines(a$year,a$Ne_97.5.,col="blue",lty=1,lwd=0.5)  # plot upper CI boundary
}
dev.off()
## error when run in interactive window in R script



x1 <- "GeeksforGeeks"
x2 <- 100
x3 <- "success"
sprintf("%s gives %.0f percent %s",x1,x2,x3)
paste(x1,"gives",x2,"percent",x3,sep="**")
## https://www.geeksforgeeks.org/print-a-formatted-string-in-r-programming-sprintf-function/
## https://www.statology.org/sprintf-function-r/
mean_value <- 35.68
standard_deviation <- 7.42
formatted_string <- sprintf("The padding mean is %10.2f,the mean is %.4f, the rounded mean is %.0f, the scientific notion of mean is %e, and the standard deviation is %.2f",mean_value,mean_value,mean_value,mean_value,standard_deviation)
## %10.2f -> 10 digits before decimal place, %.4f -> 4 digits after the decimal point
cat(formatted_string)
