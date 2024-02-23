
library(gtools)
library(fs)
library(stringr)

setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")
final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned"

## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*20hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

pdf(paste0("combined.10000Ne_20hapS_5rep_cons_1_1i_1_5i_1_9i_non_pruned.rotated_x_lab_final.pdf"),width = 20, height = 25)
#pdf(paste0("combined.10000Ne_20hapS_5rep_non_pruned.real_sim.rotated_x_lab-.pdf"),width = 20, height = 25)
#par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
#par(mfcol=c(5,5),mar=c(4,4,3,1)+0.1,cex.lab=1.6, cex.axis=1.3,lwd=2)
par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.4,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:20),nrow=5,ncol=4,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i")){
        ## solo axis name plot
        #plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        ##log="xy",xlab="Years ago", ylab="Effective population size"
        #title(line=2)

        ## key step
        ## conditional axis name plot
        plot_name <- paste0("10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
        #print(plot_name)
        
        if (plot_name %in% c("10000Ne_20hapS_1E_50G_cons_20Chr_15Mb", "10000Ne_20hapS_1E_100G_cons_20Chr_15Mb", "10000Ne_20hapS_1E_500G_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)
        } else if (plot_name %in% c("10000Ne_20hapS_1E_1000G_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
        } else if (plot_name %in% c("10000Ne_20hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.9i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
        } else {
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.0e4),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
        }
        ##turn scientific notion off
        #axis(side=1,at=c(50,100,500,1000,10000,100000,200000),las=0,label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=TRUE)))
        axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
        #eaxis(2, padj=0.5,cex.axis=1.5)
        
        ## rotating x axis labels
        lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
        axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
        text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 900,srt = 38,pos = 3, xpd = TRUE)

        ## add plot title in each plot
        mtext(side=3,text=paste0("10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        ## add line to indicate ice-age
        #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

        ## add replicate lines
        #par(new=TRUE)
        for (rep in c(1:5)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = 1, fail=TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t"))
            ##print(head(get(paste0("a",rep)),n=2L))
            #paste0("data_ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
            #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
            ##print(head(data))
            ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
            lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))
        }

        ## plot real demography

        ## piewise function
        ## https://stackoverflow.com/questions/61157263/define-and-plot-a-piecewise-function-in-r
        ## https://stackoverflow.com/questions/65068196/how-to-plot-a-piecewise-function-in-r
        
        ## check if multiple patterns exist in string
        ## https://stackoverflow.com/questions/30180281/how-can-i-check-if-multiple-strings-exist-in-another-string

        x <- 0:100000
        #plot_name <- c("10000Ne_20hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.9i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
        fx <- function(x) {
            if (all(sapply(c("G_cons"), grepl, plot_name))) {
                ## constant Ne
                return(5000)
            } else if (all(sapply(c("50G","G_1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("50G","G_1.5i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("50G","G_1.9i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("100G","G_1.1i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("100G","G_1.5i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("100G","G_1.9i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("500G","G_1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("500G","G_1.5i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("500G","G_1.9i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("1000G","G_1.1i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("1000G","G_1.5i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } # else {
            #    ## return empty value
            #    NULL
            #    #return(NULL)
            #}
        }
        lines(x,sapply(x,fx),type="s",lwd=2.5,col = adjustcolor("red", alpha = 0.8))
        ## add legend in specific plot
        if (all(sapply(c("G_cons"), grepl, plot_name))) {
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

