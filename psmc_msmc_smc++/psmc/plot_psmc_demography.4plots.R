
install.packages("scales")  
library("scales", help, pos = 2, lib.loc = NULL)


## msmc output final: example data
time_index	left_time_boundary	right_time_boundary	lambda
0	0	5.76176e-05	490.86
1	5.76176e-05	0.000125016	490.86
2	0.000125016	0.000203855	477.892
3	0.000203855	0.000296077	306.669

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output")
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

*******************************************************************************************

library(gtools) # function "mixedsort"
library(fs) # function "fs"
library(stringr)

## test
bootstrap_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output/bootstrap"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output/bootstrap")

list.files(pattern = "msmc.*out_non_empty.20bootstrap_chrall")

mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr*final.txt")))
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr2.final.txt
assign(paste0("a1"), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt"))),header=T,sep="\t"))
head(a1)
plot(1,1, type="n", xlim=c(1,5e7), ylim=c(1,1.5e6),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
lines(get(paste0("a","1"))$left_time_boundary/mu*gen,(1/get(paste0("a","1"))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))

>>>>>>>>>>>>>>>>>> below checked <<<<<<<<<<<<<<<<<<

#data (xx.0.txt) can be obtained with -R parameter in psmc
#psmc_plot.pl -pY100 -u 3.6e-09 -g 1 -R AndHae_hifi_asm.aligned.bam.fq.combined.psmc AndHae_hifi_asm.aligned.bam.fq.combined.psmc


data <- read.table("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output/bootstrap/AndHae_hifi_asm.aligned.bam.fq.combined.psmc.0.txt")
head(data)
dim(data)
time <- data$V1  # first column year
ne <- data$V2 * 1e4  # second column effective pop size Ne - times 10,000

plot(time, ne, type="s", log="xy", col="blue", lwd=2,
     xlab="Time (years ago)", ylab="Effective population size (Ne)",
     main="PSMC Plot")
grid()



## test
bootstrap_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output/bootstrap"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output/bootstrap")

pdf(paste0("PSMC_pas_vet_hae_mar.bootstrap.grid.pdf"),width = 15, height = 8)
## set number of plot in a figure
#par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

#par(mfcol=c(4,3),mar=c(4,4.8,3.8,1)+0.2,cex.lab=2.0, cex.axis=1.6,lwd=2.5)
#layout(matrix(c(1,2,0,3,4,5:11),nrow=4,ncol=3,byrow=T),width=c(1,1),height=c(1,1))

par(mfcol=c(2,2),mar=c(4,4.8,3.8,1)+0.2,cex.lab=2.0, cex.axis=1.6,lwd=2.5)
layout(matrix(c(1,2,3,4),nrow=2,ncol=2,byrow=T),width=c(1,1),height=c(1,1))

#for (group in c("pas_REF_pas","vet_REF_pas","hae_REF_hae","mar_REF_hae")){
    ## single vector in for loop

for (group in c("AndHae", "AndMar", "BomPas", "BomVet")){
    #mu <- 3.6e-9
    #gen <- 1
    ## key step
    ## conditional axis name plot
    #plot_name <- paste0("MSMC_",group)
    #print(plot_name)

    ## plot a frame
    #group <- "AndHae"
    assign(paste0(group,"_Dat"), read.table(paste0(group,"_hifi_asm.aligned.bam.fq.combined.psmc.0.txt"),header=FALSE,sep="\t"))
    print(head(paste0(group,"_Dat")))
    if (group %in% c("AndHae")) {
        ## axis label format: https://stackoverflow.com/questions/15480082/mathematical-expression-in-axis-label
        plot(get(paste0(group,"_Dat"))$V1/1000, (get(paste0(group,"_Dat"))$V2), type="n",log="x", xlab="", ylab=expression(paste(italic("N")["e"]," (x10"^4,")")))
        #,xaxt='n',yaxt='n'
        #x_label <- c(1e3,1e4,1e5,1e6,1e7)
        #y_label <- c(0,1,10,20,30,40,50,60,70,80,900,100)
        # 10³
        #x_labels_expr <- parse(text = paste0("10^", log10(x_label)))
        #y_labels_expr <- parse(text = paste0("10^", log10(y_label))) 
        #axis(side=1, at=x_label, labels=x_labels_expr, cex.axis=1.2)
        #axis(side=1, at=y_label, labels=y_labels_expr, cex.axis=1.2)
        #axis(side=1, at=x_label, labels=expression(10^3, 10^4, 10^5, 10^6, 10^7), cex.axis=1.2)
        #axis(side=2, at=y_label, labels=expression(10^0, 10^3, 10^4, 10^5, 5 %*% 10^5, 10^6), cex.axis=1.2)

        
        
        # 1e3
        #axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)), cex.axis=0.8)
        #axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)), cex.axis=0.8)         
        #axis(side=1, at=x_label,label=c(format(x_label,scientific=TRUE,digits=2)), cex.axis=0.8)         
        #axis(side=2, at=y_label,label=c(format(y_label,scientific=TRUE,digits=2)), cex.axis=0.8)
        #cex.lab = 1

        ## add plot title in each plot
        #mtext(side=3,text=paste0("MSMC_BomPas",substr(group,4,8),"BomPas"),cex=1.2,line=2)
        #mtext(side=3,text=expression(paste("PSMC: ", italic("A. haemorrhoa"), " mapped to ", italic("A. haemorrhoa"))),cex=1.2,line=2)
        mtext(side=3,text=expression(paste(italic("A. haemorrhoa")),cex=1.2,line=2))

    } else if (group %in% c("AndMar")) {
        plot(get(paste0(group,"_Dat"))$V1, (get(paste0(group,"_Dat"))$V2*1e4), type="n", xlim=c(1.0e+3,2.0e+6), ylim=c(1.0e+3,1.5e+6),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
        x_label <- c(1e3,1e4,1e5,1e6,5e6)
        y_label <- c(1e4,1e5,5e5,1e6,1e7)
        axis(side=1, at=x_label,label=c(format(x_label,scientific=TRUE,digits=2)), cex.axis=0.8)         
        axis(side=2, at=y_label,label=c(format(y_label,scientific=TRUE,digits=2)), cex.axis=0.8)
        cex.lab = 1

        ## add plot title in each plot
        #mtext(side=3,text=paste0("MSMC_BomPas",substr(group,4,8),"BomPas"),cex=1.2,line=2)
        #mtext(side=3,text=expression(paste("PSMC: ", italic("A. marginata"), " mapped to ", italic("A. marginata"))),cex=1.2,line=2)
        mtext(side=3,text=expression(paste(italic("A. marginata")),cex=1.2,line=2))

    } else if (group %in% c("BomPas")) {
        plot(get(paste0(group,"_Dat"))$V1, (get(paste0(group,"_Dat"))$V2*1e4), type="n", xlim=c(1.0e+3,3.0e+7), ylim=c(1.0e+3,3.5e+6),log="x", xlab="Years", ylab=expression(paste(italic("N")["e"])),xaxt='n',yaxt='n')
        x_label <- c(1e3,1e4,1e5,1e6,1e7)
        y_label <- c(1e4,1e5,5e5,1e6,1e7)
        axis(side=1, at=x_label,label=c(format(x_label,scientific=TRUE,digits=2)), cex.axis=0.8)         
        axis(side=2, at=y_label,label=c(format(y_label,scientific=TRUE,digits=2)), cex.axis=0.8)
        cex.lab = 1

        ## add plot title in each plot
        #mtext(side=3,text=paste0("MSMC_BomPas",substr(group,4,8),"BomPas"),cex=1.2,line=2)
        #mtext(side=3,text=expression(paste("PSMC: ", italic("B. pascuorum"), " mapped to ", italic("B. pascuorum"))),cex=1.2,line=2)
        mtext(side=3,text=expression(paste(italic("B. pascuorum")),cex=1.2,line=2))

    } else if (group %in% c("BomVet")) {
        plot(get(paste0(group,"_Dat"))$V1, (get(paste0(group,"_Dat"))$V2*1e4), type="n", xlim=c(1.0e+3,1.5e+6), ylim=c(1.0e+3,1e+6),log="x", xlab="Years", ylab="",xaxt='n',yaxt='n')
        x_label <- c(1e3,1e4,1e5,1e6,1e7)
        y_label <- c(1e4,1e5,5e5,1e6,1e7)
        axis(side=1, at=x_label,label=c(format(x_label,scientific=TRUE,digits=2)), cex.axis=0.8)         
        axis(side=2, at=y_label,label=c(format(y_label,scientific=TRUE,digits=2)), cex.axis=0.8)
        cex.lab = 1

        ## add plot title in each plot
        #mtext(side=3,text=paste0("MSMC_BomPas",substr(group,4,8),"BomPas"),cex=1.2,line=2)
        #mtext(side=3,text=expression(paste("PSMC: ", italic("B. veteranus"), " mapped to ", italic("B. veteranus"))),cex=1.2,line=2)
        mtext(side=3,text=expression(paste(italic("B. veteranus")),cex=1.2,line=2))
    } else {
        NULL
    }

    ## without showing ticks xaxt='n',yaxt='n'
    title(line=4)

    ## add grid
    grid(nx = NULL, ny = NULL,
        lty = 2,      # Grid line type
        col = "gray", # Grid line color
        lwd = 0.5)      # Grid line width

    ## add plot title in each plot
    #mtext(side=3,text=paste0("MSMC_",substr(group,)),cex=1.2,line=2)

    ## add line to indicate ice-age [11550-12800], Wiki
    #abline(v=12800,col="darkorange",lwd=1)  # add a vertical line at 13,000 years ago to indicate end of last glaction
    abline(v=12,col="black",lwd=1)
    #lines(c(1:100),rep(100,100), type="s", col="red")
    ## add replicate lines
    #par(new=TRUE)

    ## plot single run and 20 bootstrap runs
    #for (rep in c("all",1:20)){
    for (rep in c(0:20)){
        ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
        ## assign variable to read_data
        assign(paste0("a",rep), read.table(paste0(group, "_hifi_asm.aligned.bam.fq.combined.psmc.", rep, ".txt"),header=FALSE,sep="\t"))
        print(group)
        print(rep)
        print(head(get(paste0("a",rep)),n=2L))
        ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
        #lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=2.5,col = adjustcolor("red", alpha = 1))
        lines(get(paste0("a",rep))$V1/1000, (get(paste0("a",rep))$V2), type="s", lwd=2, col = adjustcolor("blue", alpha = 0.5))
        ## add the main plot over bootstrap
        lines(get(paste0("a","0"))$V1/1000, (get(paste0("a","0"))$V2), type="s", lwd=2, col = adjustcolor("red", alpha = 0.6))
        #lines(get(paste0("a","all"))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=2.5,col = adjustcolor("red", alpha = 1))

    }
    
    ## add legend in specific plot
    if (all(sapply(c("AndHae"), grepl, group))) {
    legend("topleft",c("whole-genome","bootstrap","12000 Year Ago"),col = adjustcolor(c("red","blue","black"), alpha = 0.8),cex=1.5,lty=c(1,1),lwd=c(2.5,2,2),bty="n")
    } else {
        NULL
    }
}

## end plot
dev.off()


********************************************************************
