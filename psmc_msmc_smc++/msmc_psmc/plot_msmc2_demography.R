## msmc output final
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

*****************************************************************************************************
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
bootstrap_path="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output"
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output")
mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr*final.txt")))
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap_output/pas_REF_pas_out_non_empty_20bootstrap_chr2.final.txt
assign(paste0("a1"), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = "*pas_REF_pas_out_non_empty_20bootstrap_chr1.final.txt"))),header=T,sep="\t"))
head(a1)
plot(1,1, type="n", xlim=c(1,5e7), ylim=c(1,1.5e6),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
lines(get(paste0("a","1"))$left_time_boundary/mu*gen,(1/get(paste0("a","1"))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))


setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/10KNe_swp")
final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned"
mixedsort(sort(fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*G_*e_*_cons*200hapS*15Mb_*.final.summary")))
## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*200hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

## checked
pdf(paste0("MSMC_pas_hae.pdf"),width = 20, height = 25)
## set number of plot in a figure
par(mfcol=c(3,3),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:9),nrow=3,ncol=3,byrow=T),width=c(1,1),height=c(1,1))

#for (group in c("pas_REF_pas","vet_REF_pas","hae_REF_hae","mar_REF_hae")){
    ## single vector in for loop
for (group in "pas_REF_pas"){
    ## key step
    ## conditional axis name plot
    #plot_name <- paste0("MSMC_",group)
    #print(plot_name)

    ## plot a frame
    pas_REF_pas_Dat<-read.table("pas_REF_pas_out_non_empty_20bootstrap_chr20.final.txt", header=TRUE)
    plot(pas_REF_pas_Dat$left_time_boundary/mu,(1/pas_REF_pas_Dat$lambda/(2*mu)), type="n", xlim=c(1e3,5e7), ylim=c(1e5,1e6),log="x", xlab="Years ago", ylab="Effective population size")
    title(line=4)
    #plot(1,1, type="n", xlim=c(1,5e7), ylim=c(1,1.5e6),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
    #title(line=4)

    ## add plot title in each plot
    mtext(side=3,text=paste0("MSMC_",group),cex=0.8,line=1.2)
    ## add line to indicate ice-age
    #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction
    #lines(c(1:100),rep(100,100), type="s", col="red")
    ## add replicate lines
    #par(new=TRUE)
    mu <- 3.6e-9
    gen <- 1

    ## plot bootstrap  
    for (rep in c("all",1:20)){
        ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
        ## assign variable to read_data
        assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=bootstrap_path, recurse = 1, fail=TRUE, type = "file", glob = paste0("*",group,"*_chr",rep,".final.txt")))),header=T,sep="\t"))
        print(rep)
        print(head(get(paste0("a",rep)),n=2L))
        #paste0("data_ft_sim_10000Ne_200hapS_1E_",generation,"_",event,"_20Chr_15Mb")
        #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
        #print(head(data,n=2L))
        ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
        lines(get(paste0("a",rep))$left_time_boundary/mu*gen,(1/get(paste0("a",rep))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))
        
        ## add the main plot over bootstrap
        lines(get(paste0("a","all"))$left_time_boundary/mu*gen,(1/get(paste0("a","all"))$lambda)/(2*mu),type="s",lwd=1.6,col = adjustcolor("red", alpha = 1))
        #lines(pas_REF_pas_Dat$left_time_boundary/mu*gen, (1/pas_REF_pas_Dat$lambda)/(2*mu), type="s", col="red")
        #print(head(get(paste0("a",rep))$left_time_boundary/mu*gen))
        #print(head((1/get(paste0("a",rep))$lambda)/(2*mu)))
    }
}

## end plot
dev.off()

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

