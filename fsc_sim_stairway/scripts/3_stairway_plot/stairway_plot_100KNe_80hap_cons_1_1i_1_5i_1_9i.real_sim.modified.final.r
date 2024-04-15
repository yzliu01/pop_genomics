library(gtools)
library(fs)
library(stringr)

setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")
final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned"

## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*80hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100KNe_swp")

pdf(paste0("combined.100000Ne_80hapS_5rep_cons_1_1i_1_5i_1_9i_non_pruned.rotated_x_lab_final.pdf"),width = 20, height = 25)
#pdf(paste0("combined.100000Ne_80hapS_5rep_non_pruned.real_sim.rotated_x_lab-.pdf"),width = 20, height = 25)
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
        plot_name <- paste0("100000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb")
        #print(plot_name)
        
        if (plot_name %in% c("100000Ne_80hapS_1E_50G_cons_20Chr_15Mb", "100000Ne_80hapS_1E_100G_cons_20Chr_15Mb", "100000Ne_80hapS_1E_500G_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(40000,7e4),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(40000,45000,50000,55000,60000,70000),label=c(format(c(40000,45000,50000,55000,60000,70000),scientific=FALSE)))
            
            ## rotating x axis labels
            lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
            axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
            text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 2100,srt = 38,pos = 3, xpd = TRUE)
            ## negative to go down

        } else if (plot_name %in% c("100000Ne_80hapS_1E_1000G_cons_20Chr_15Mb","100000Ne_80hapS_1E_1000G_1.1i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(40000,7e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(40000,45000,50000,55000,60000,70000),label=c(format(c(40000,45000,50000,55000,60000,70000),scientific=FALSE)))
            
            ## rotating x axis labels
            lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
            axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
            text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 2100,srt = 38,pos = 3, xpd = TRUE)

        } else if (plot_name %in% c("100000Ne_80hapS_1E_50G_1.1i_20Chr_15Mb","100000Ne_80hapS_1E_100G_1.1i_20Chr_15Mb","100000Ne_80hapS_1E_500G_1.1i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(40000,7e4),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(40000,45000,50000,55000,60000,70000),label=c(format(c(40000,45000,50000,55000,60000,70000),scientific=FALSE)))
            
            ## rotating x axis labels
            lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
            axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
            text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 2100,srt = 38,pos = 3, xpd = TRUE)

            ## bigger Ne

        } else if (plot_name %in% c("100000Ne_80hapS_1E_1000G_1.5i_20Chr_15Mb","100000Ne_80hapS_1E_1000G_1.9i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(30000,1.0e5),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(30000,50000,55000,75000,100000),label=c(format(c(30000,50000,55000,75000,100000),scientific=FALSE)))
            
            ## rotating x axis labels
            lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
            axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
            text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 5000,srt = 38,pos = 3, xpd = TRUE)

        } else if (plot_name %in% c("100000Ne_80hapS_1E_50G_1.5i_20Chr_15Mb","100000Ne_80hapS_1E_100G_1.5i_20Chr_15Mb","100000Ne_80hapS_1E_500G_1.5i_20Chr_15Mb",
                                    "100000Ne_80hapS_1E_50G_1.9i_20Chr_15Mb","100000Ne_80hapS_1E_100G_1.9i_20Chr_15Mb","100000Ne_80hapS_1E_500G_1.9i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(30000,1.0e5),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(30000,50000,55000,75000,100000),label=c(format(c(30000,50000,55000,75000,100000),scientific=FALSE)))
            
            ## rotating x axis labels
            lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
            axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
            text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 5000,srt = 38,pos = 3, xpd = TRUE)

        }
        else {
            NULL
            #plot(1,1, type="n", xlim=c(1,5e6), ylim=c(10000,1.0e5),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            ##xlab="Years ago", ylab="Effective population size"
            #title(line=2)
        }
        ##turn scientific notion off
        #axis(side=1,at=c(50,100,500,1000,10000,100000,200000),las=0,label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=TRUE)))
        #axis(side=2, at=c(10000,30000,50000,55000,75000,100000),label=c(format(c(10000,30000,50000,55000,75000,100000),scientific=FALSE)))
        #eaxis(2, padj=0.5,cex.axis=1.5)
        
        ## rotating x axis labels
        #lablist.x <- as.vector(c(50,100,500,1000,10000,100000))
        #axis(side=1,at=c(50,100,500,1000,10000,100000),labels=FALSE)
        #text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 5000,srt = 38,pos = 3, xpd = TRUE)

        ## add plot title in each plot
        mtext(side=3,text=paste0("100000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        ## add line to indicate ice-age
        #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

        ## add replicate lines
        #par(new=TRUE)
        for (rep in c(1:5)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_100000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = 1, fail=TRUE, type = "file", glob = "*80hapS*.final.summary"))),header=T,sep="\t"))
            ##print(head(get(paste0("a",rep)),n=2L))
            #paste0("data_ft_sim_100000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb")
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
        #plot_name <- c("100000Ne_80hapS_1E_1000G_1.1i_20Chr_15Mb","100000Ne_80hapS_1E_1000G_1.5i_20Chr_15Mb","100000Ne_80hapS_1E_1000G_1.9i_20Chr_15Mb","100000Ne_80hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
        fx <- function(x) {
            if (all(sapply(c("G_cons"), grepl, plot_name))) {
                ## constant Ne
                return(50000)
            } else if (all(sapply(c("50G","G_1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(50000)
                } else {
                    return(50000*1.1)
                }
            } else if (all(sapply(c("50G","G_1.5i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(50000)
                } else {
                    return(50000*1.5)
                }
            } else if (all(sapply(c("50G","G_1.9i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(50000)
                } else {
                    return(50000*1.9)
                }
            } else if (all(sapply(c("100G","G_1.1i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(50000)
                } else {
                    return(50000*1.1)
                }
            } else if (all(sapply(c("100G","G_1.5i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(50000)
                } else {
                    return(50000*1.5)
                }
            } else if (all(sapply(c("100G","G_1.9i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(50000)
                } else {
                    return(50000*1.9)
                }
            } else if (all(sapply(c("500G","G_1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(50000)
                } else {
                    return(50000*1.1)
                }
            } else if (all(sapply(c("500G","G_1.5i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(50000)
                } else {
                    return(50000*1.5)
                }
            } else if (all(sapply(c("500G","G_1.9i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(50000)
                } else {
                    return(50000*1.9)
                }
            } else if (all(sapply(c("1000G","G_1.1i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(50000)
                } else {
                    return(50000*1.1)
                }
            } else if (all(sapply(c("1000G","G_1.5i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(50000)
                } else {
                    return(50000*1.5)
                }
            } else {
                if (x <= 1000) {
                    return(50000)
                } else {
                    return(50000*1.9)
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
