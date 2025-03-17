
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
bootstrap_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output")

list.files(pattern = "msmc.*out_non_empty.20bootstrap_chrall")

mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr*final.txt")))
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr2.final.txt
assign(paste0("a1"), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt"))),header=T,sep="\t"))
head(a1)
plot(1,1, type="n", xlim=c(1,5e7), ylim=c(1,1.5e6),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
lines(get(paste0("a","1"))$left_time_boundary/mu*gen,(1/get(paste0("a","1"))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))

>>>>>>>>>>>>>>>>>> below checked <<<<<<<<<<<<<<<<<<

pdf(paste0("MSMC_pas_vet_hae_mar.bootstrap.grid.new1.pdf"),width = 15, height = 20)
## set number of plot in a figure
#par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

par(mfcol=c(4,3),mar=c(4,4.8,3.8,1)+0.2,cex.lab=2.0, cex.axis=1.6,lwd=2.5)
layout(matrix(c(1,2,0,3,4,5:11),nrow=4,ncol=3,byrow=T),width=c(1,1),height=c(1,1))

#for (group in c("pas_REF_pas","vet_REF_pas","hae_REF_hae","mar_REF_hae")){
    ## single vector in for loop

for (group in c("pas_REF_pas", "vet_REF_pas", "hae_REF_hae", "mar_REF_mar")){
    mu <- 3.6e-9
    gen <- 1
    ## key step
    ## conditional axis name plot
    #plot_name <- paste0("MSMC_",group)
    #print(plot_name)

    ## plot a frame
    #pas_REF_pas_Dat <- read.table("msmc.pas_REF_pas_out_non_empty.20bootstrap_chrall.final.txt", header=TRUE)
    assign(paste0(group,"_Dat"), read.table(paste0("msmc.",group,"_out_non_empty.20bootstrap_chrall.final.txt"),header=TRUE,sep="\t"))
    print(head(paste0(group,"_Dat")))
    #plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1e3,5e7), ylim=c(1e5,1e6),log="x", xlab="Years ago", ylab="Effective population size")
    if (group %in% c("pas_REF_pas")) {
        ## axis label format: https://stackoverflow.com/questions/15480082/mathematical-expression-in-axis-label
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1.0e+4,8.0e+5),log="x", xlab="", ylab=expression(paste(italic("N")["e"])),xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)        
        y_label <- c(1e4,2e5,4e5,6e5,8e5)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))         
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        ## add plot title in each plot
        #mtext(side=3,text=paste0("MSMC_BomPas",substr(group,4,8),"BomPas"),cex=1.2,line=2)
        mtext(side=3,text=expression(paste("MSMC: ", italic("B. pascuorum"), " mapped to ", italic("B. pascuorum"))),cex=1.2,line=2)

    } else if (group %in% c("vet_REF_pas")) {
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1000,4.5e+6),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)        
        y_label <- c(1000,500000,2000000,3000000,4000000)
        ## format axis label in desired scientific notation
        ## https://stackoverflow.com/questions/39623636/forcing-r-output-to-be-scientific-notation-with-at-most-two-decimals
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))         
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))
        
        ## add plot title in each plot
        mtext(side=3,text=expression(paste("MSMC: ", italic("B. veteraunus"), " mapped to ", italic("B. pascuorum"))),cex=1.2,line=2)

    } else if (group %in% c("hae_REF_hae")) {
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1000,4.5e+6),log="x", xlab="Years ago", ylab=expression(paste(italic("N")["e"])),xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)        
        y_label <- c(1000,500000,2000000,3000000,4000000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))         
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        ## add plot title in each plot
        mtext(side=3,text=expression(paste("MSMC: ", italic("A. haemorrhoa"), " mapped to ", italic("A. haemorrhoa"))),cex=1.2,line=2)

    } else if (group %in% c( "mar_REF_mar")) {
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1.0e+4,8.0e+5),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)        
        y_label <- c(1e4,2e5,4e5,6e5,8e5)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))         
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        ## add plot title in each plot
        mtext(side=3,text=expression(paste("MSMC: ", italic("A. marginata"), " mapped to ", italic("A. marginata"))),cex=1.2,line=2)

    } else if (group %in% c( "mar_REF_hat")) {
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1.0e+4,8.0e+5),log="x", xlab="Years ago", ylab=expression(paste(italic("N")["e"])),xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)        
        y_label <- c(1e4,2e5,4e5,6e5,8e5)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))         
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))

        ## add plot title in each plot
        mtext(side=3,text=expression(paste("MSMC: ", italic("A. marginata"), " mapped to ", italic("A. hattorfiana"))),cex=1.2,line=2)

    } else if (group %in% c( "mar_REF_hae")) {
        plot(get(paste0(group,"_Dat"))$left_time_boundary/mu,(1/get(paste0(group,"_Dat"))$lambda/(2*mu)), type="n", xlim=c(1.0e+3,1.0e+7), ylim=c(1000,4.5e+7),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
        x_label <- c(1000,10000,100000,1000000,10000000)
        y_label <- c(1000,1000000,5000000,10000000,20000000,40000000)
        axis(side=1, at=x_label,label=c(formatC(x_label,format="f",digits=0)))        
        axis(side=2, at=y_label,label=c(formatC(y_label,format="f",digits=0)))
        #axis(side=2, at=c(1000,250000,1000000,3000000,4000000,10000000),label=c(format(c(1000,250000,1000000,3000000,4000000,10000000),scientific=TRUE)))

        ## add plot title in each plot
        mtext(side=3,text=expression(paste("MSMC: ", italic("A. marginata"), " mapped to ", italic("A. haemorrhoa"))),cex=1.2,line=2)
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
    abline(v=11700,col="darkorange",lwd=1)
    #lines(c(1:100),rep(100,100), type="s", col="red")
    ## add replicate lines
    #par(new=TRUE)

    ## plot single run and 20 bootstrap runs
    for (rep in c("all",1:20)){
        ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
        ## assign variable to read_data
        #file_list <- fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = get(paste0("msmc.",group,"_out_non_empty.20bootstrap_chr",rep,".final.txt")))
        assign(paste0("a",rep), read.table(paste0("msmc.",group,"_out_non_empty.20bootstrap_chr",rep,".final.txt"),header=T,sep="\t"))
        #assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*vet_REF_pas*out_non_empty.20bootstrap_chr*.final.txt")))),header=T,sep="\t")
        print(group)
        print(rep)
        print(head(get(paste0("a",rep)),n=2L))
        ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
        lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a",rep))$lambda)/(2*mu),type="s",lwd=2,col = adjustcolor("blue", alpha = 0.6))
        ## add the main plot over bootstrap
        lines(get(paste0("a","all"))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=2.5,col = adjustcolor("red", alpha = 1))

    }
    
    ## add legend in specific plot
    if (all(sapply(c("pas_REF_pas"), grepl, group))) {
    legend("topleft",c("whole-genome","bootstrap","LGP"),col = adjustcolor(c("red","blue","darkorange"), alpha = 0.8),cex=1.5,lty=c(1,1),lwd=c(2.5,2,2),bty="n")
    } else {
        NULL
    }
}

## end plot
dev.off()


********************************************************************
