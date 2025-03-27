#!/bin/bash
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
##SBATCH --mem 20g
##SBATCH --mem-per-cpu=8G
#SBATCH --array=1-300%20
#SBATCH --time=06:06:00
#SBATCH --error=swp_ft_sim_10000Ne_20_80_200hapS_1E_50G_00d_20Chr_15Mb_5rep_MSFS.parallel.%A.e.txt
#SBATCH --output=swp_ft_sim_10000Ne_20_80_200hapS_1E_50G_00d_20Chr_15Mb_5rep_MSFS.parallel.%A.o.txt
#SBATCH --job-name=swp_test3_ft
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## parallel job
## This function is to run the job in parallel, submitting each task to a core for up to $1q tasks at a $2 time
function pwait() {
    while [ $(jobs -p | wc -l) -ge $1 ]; do
    sleep $2
    done
    }
## generate blueprint.sh batch files
cd /home/yzliu/bin/stairway_plot_v2.1.2
## e.g. ft_sim_10000Ne_20hapS_1E_50G_05d_20Chr_15Mb_1_5_MSFS.blueprint
blueprint_file=`ls ft_sim_10000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V`
#blueprint_file=$(ls ft_sim_10000Ne*20Chr_15Mb_*MSFS.blueprint | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
## create a function to run blueprint file
## attention to nrand as integer
## blueprint files and program are in the same folder
create_batch_files(){
    for file in $blueprint_file; do
    time java -cp stairway_plot_es Stairbuilder ./stairway_plot_blueprint/$file
    done
}
## run the function and output **blueprint.sh files
#create_batch_files


## run batch files
blueprint_sh=`ls ./stairway_plot_blueprint/ft_sim_10000Ne*20Chr_15Mb*MSFS.blueprint.sh | sort -V | head -2`

run_batch_file(){
    for file in $blueprint_sh; do
    pwait 2 10
    print $file
    time bash $file
    done
    wait
}
## execute the function
#run_batch_file


## run batch files in array jobs
## to plot
#ls ./stairway_plot_blueprint/ft_sim_10000Ne*20Chr_15Mb*MSFS.blueprint.sh | sort -V | wc -l
#300
cd /home/yzliu/bin/stairway_plot_v2.1.2
## current dir
#blueprint_folder=.
## test blueprint_plot.sh
#plot_blueprint_file=$blueprint_folder/fsc_fold_1KNe_4E_60S_1_10_50_90d_5Chr_1000Kb.blueprint.sh
run_blueprint_plot_sh=$(ls ./stairway_plot_blueprint/ft_sim_10000Ne*20Chr_15Mb*MSFS.blueprint.sh | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
time bash $run_blueprint_plot_sh

exit

stairway_plot(){
    for file in $blueprint_sh; do
    time bash $file
    done
}
## execute the function
#stairway_plot


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



install.packages("gtools")
library(gtools)
#library(stringi)
install.packages("stringr",dependancies=T)
library(stringr) ## more convient for multiple replacements than gsub
#https://stackoverflow.com/questions/63585270/r-stringr-mutate-i-think-multiple-partial-string-replacements-in-multiple
## make transparent plot
install.packages("scales")                                         # Install scales package
library("scales")
print(gsub("\\/home.*MSFS\\/","",file_list))
install.packages("sfsmisc") ## for exponential axis labels

library(gtools)
library(stringr)
library(sfsmisc)

final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3-"
file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")
file_list <- mixedsort(sort(file_list0))

pdf(paste0("combined.test10.pdf"),width = 20, height = 25)
par(mfcol=c(4,5),mar=c(5,5,4,2)+0.2,cex.lab=1.8, cex.axis=1.8,lwd=2)
nf <- layout(matrix(c(1,2,3,4,5,6,7,8,9,10,0,0,0,0,0,0,0,0,0,0),nrow=4,ncol=5,byrow=T),width=c(1,1),height=c(1,1))
for (final in file_list){
    #print(gsub("/home*MSFS/","",file_list))
    plot_name <- str_replace_all(final,c("/home.*MSFS/"="","_MSFS.final.summary"=""))
    #tiff(paste0(final,".test.tiff"),units="cm", width = 16, height = 20, res=200)
    #par(mfcol=c(2,1),mar=c(5,4,2,2)+0.1)
    if(plot_name %in% c("ft_sim_100000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1_1MSFS.final.summary")){
        plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else if (plot_name %in% c("ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1")) {
        plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else if (plot_name %in% c("ft_sim_100000Ne_80hapS_1E_1000G_05i_20Chr_15Mb_1_1_MSFS.rand20.summary")){
        plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    } else {
        plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="", ylab="",xaxt='n',yaxt='n')
        #xlab="Years ago", ylab="Effective population size"
        title(line=2)
    }
    #plot(1,1, type="n", xlim=c(5,5e6), ylim=c(5,1.5e5),log="xy", xlab="", ylab="",xaxt='n',yaxt='n')
    ##xlab="Years ago", ylab="Effective population size"
    #title(line=2)
    #axis(side=1,at=c(10,100,1000,10000,100000,1000000,10000000))
    #axis(side=1,at=c(10,100,1000,10000,100000,1000000,10000000),label=c(format(c(10,100,1000,10000,100000,1000000,10000000),scientific=FALSE)))
    ##turn scientific notion off
    ##https://stackoverflow.com/questions/41992434/turning-scientific-notation-off-for-only-axis-in-r-plot
    eaxis(1, padj=0.5,cex.axis=1.5)
    ##https://stackoverflow.com/questions/5963047/do-not-want-scientific-notation-on-plot-axis
    #axis(side=2, lwd=3)
    eaxis(2, padj=0.5,cex.axis=1.5)
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


###################
###################
*******************


cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3

for event in {"00d","05i"};do
    for change in $event;do
        #file_list=`ls -d ft_sim_10000Ne_20hapS_1E_50G_$event* | cut "\t" -f 1`
        echo $change
        file_list=`find -print | grep '10000Ne_20hapS' | grep "50G_$change" | grep 'final.summary$' | sort -V`
        #echo $file_list
        for each_rep_summary in $file_list;do
            cut -f 6,7 $each_rep_summary | head -3
            #awk -F "\t" -v OFS="\t" '{print $6,$7}' $each_rep_summary | head -3 >> ./$each_rep_summary.txt

        done
    done
done

## check the number of columns
awk -F ' ' '{print NF;exit}' file
