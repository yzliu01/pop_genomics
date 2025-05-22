
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp")
final_summary <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp"

## attention to refer to only one file name
file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*200hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

library(gtools)
library(fs)
library(stringr)

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp")

## check the files
#mixedsort(sort(fs::dir_ls(path=".", recurse = 1, fail=TRUE, type = "file", glob = "*100_200G*200hapS*.final.summary")))

pdf(paste0("combined.1MNe_2E_100_200G_200hapS_5rep_10d_10d_2i_2i_2ei_2ed_2ed_2ei.rotated_x_lab_final.test_fun.pdf"),width = 20, height = 25)
#pdf(paste0("combined.1000000Ne_200hapS_5rep.real_sim.rotated_x_lab-.pdf"),width = 20, height = 25)
#par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
#par(mfcol=c(5,5),mar=c(4,4,3,1)+0.1,cex.lab=1.6, cex.axis=1.3,lwd=2)

par(mfcol=c(4,4),mar=c(4,4.4,3,1)+0.4,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:16),nrow=4,ncol=4,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("100_200G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("10d_10d","2i_2i","2e_i_2e_d","2e_d_2e_i")){
        ## solo axis name plot
        #plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        ##log="xy",xlab="Years ago", ylab="Effective population size"
        #title(line=2)

        ## key step
        ## conditional axis name plot
        plot_name <- paste0("1000000Ne_200hapS_2E_",generation,"_",event,"_20Chr_15Mb")
        #print(plot_name)
        ## print names with newline 
        cat("\n",plot_name,"\n\n")
        
        if (plot_name %in% c("xx_1000000Ne_200hapS_2E_100_200G_10d_10d_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,3.0e5),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(20000,50000,65000,125000,250000,300000),label=c(format(c(20000,50000,65000,125000,250000,300000),scientific=FALSE)))

        } else if (plot_name %in% c("1000000Ne_200hapS_2E_100_200G_10d_10d_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.5e5),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(100000,125000,150000,250000,300000,400000,500000),label=c(format(c(100000,125000,150000,250000,300000,400000,500000),scientific=FALSE)))

        } else if (plot_name %in% c("1000000Ne_200hapS_2E_100_200G_2i_2i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,2.1e6),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(250000,500000,700000,1000000,1500000,2000000),label=c(format(c(250000,500000,700000,1000000,1500000,2000000),scientific=FALSE)))

        } else {
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.2e6),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,250000,400000,500000,800000,10000000,1200000),label=c(format(c(150000,250000,400000,500000,800000,10000000,1200000),scientific=FALSE)))

        }
        ##turn scientific notion off
        #axis(side=1,at=c(50,100,500,1000,10000,100000,200000),las=0,label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=TRUE)))
        #axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
        #eaxis(2, padj=0.5,cex.axis=1.5)
        
        ## rotating x axis labels
        lablist.x <- as.vector(c(50,100,500,1000,10000,100000,200000))
        axis(side=1,at=c(50,100,500,1000,10000,100000,200000),labels=FALSE)
        #text(x=c(50,100,500,1000,10000,100000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 13000,srt = 38,pos = 3, xpd = TRUE)
        
        ## distance to x axis
        if (plot_name %in% c("1000000Ne_200hapS_2E_100_200G_10d_10d_20Chr_15Mb")){
            text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 32000,srt = 38,pos = 3, xpd = TRUE)
        } else if (plot_name %in% c("1000000Ne_200hapS_2E_100_200G_2i_2i_20Chr_15Mb")) {
            text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 120000,srt = 38,pos = 3, xpd = TRUE)
        } else {
            #,"1000000Ne_200hapS_2E_100_200G_2e_i_2e_d_20Chr_15Mb","1000000Ne_200hapS_2E_100_200G_2e_d_2e_i_20Chr_15Mb"
            text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 70000,srt = 38,pos = 3, xpd = TRUE)
        }

        ## add plot title in each plot
        mtext(side=3,text=paste0("1000000Ne_200hapS_2E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        ## add line to indicate ice-age
        #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

        ## add replicate lines
        #par(new=TRUE)
        for (rep in c(1:5)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_1000000Ne_200hapS_2E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = 1, fail=TRUE, type = "file", glob = "*200hapS*.final.summary"))),header=T,sep="\t"))
            print(head(get(paste0("a",rep)),n=2L))
            #paste0("data_ft_sim_1000000Ne_200hapS_2E_",generation,"_",event,"_20Chr_15Mb")
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
        #plot_name <- c("1000000Ne_200hapS_2E_1000G_1.1i_20Chr_15Mb","1000000Ne_200hapS_2E_1000G_1.5i_20Chr_15Mb","1000000Ne_200hapS_2E_1000G_1.9i_20Chr_15Mb","1000000Ne_200hapS_2E_1000G_0.5e_d_1.5i_20Chr_15Mb")

        ## category
        ## correct
        #"2e_d_2e_i" (2e_d:N0=500000,r1=-0.006931471,t1=100,λ1=e^r1=0.993093,Nt1=λ^t1;2e_i:t2=400,r2=0.00173275,λ2=e^r2=1.0017343,Nt2=Nt1*λ^t2)
        #"2e_i_2e_d" (2e_i:N0=500000,r1=0.00693147,t1=100,λ1=e^r1=1.006955,Nt1=λ^t1;2e_d:t2=400,r2=-0.00173275,λ2=e^r2=0.5,Nt2=Nt1*λ^t2)
        #"10d_10d" (r1=0.1,Ne1=r1*Ne=0.1*5000;r2=0.1),"2i_2i" (r1=2;r2=2) # nolint
        
        ## "4e_d_4i","10e_d_10i","4e_i_4d","10e_i_10d"
        ## 100G "2e_i_2e_d" (r=0.0069,t=100,λ=e^r=1.0069),
           
        ## 500G "2e_i_2e_d" (r=-0.006931,t=500,λ=e^r=0.9931),"2e_d_2e_i" (r=0.0069,λ=e^r=1.0069),"10d_10d" (r1=0.1,r2=0.1),"2i_2i" (r1=2;r2=2)
        ## 500G "2e_i_2e_d" (r=-0.0017,t=400,rt=-0.17,λ=e^rt=0.8437),"2e_d_2e_i" (r=0.0017,t=100,rt=0.17,λ=e^rt=1.1853),"10d_10d" (r1=0.1,r2=0.1),"2i_2i" (r1=2;r2=2)
 
        ## r -> rate; λ=e^r; (e^r)^t=λ^t
        ## lambda <- e^r
        ## Nt <- Ne*e^(rx)
        ## x <- 0:40000
        ## N <- 10000*lambda^t

        fx <- function(x) {
            if (all(sapply(c("xxxx"), grepl, plot_name))) {
                ## constant Ne
                return(500000)
            } else if (all(sapply(c("100_200G","2i_2i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 100) {
                    return(500000)
                } else if (100 < x & x <= 500) {
                    return(2*500000)
                } else {
                    return(2*2*500000)
                }
            } else if (all(sapply(c("100_200G","10d_10d"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000)
                } else if (100 < x & x <= 500) {
                    return(0.1*500000)
                } else {
                    return(0.1*0.1*500000)
                }
            } else if (all(sapply(c("100_200G","2e_i_2e_d"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(exp(log(2)/100*x)))
                } else if (100 < x & x <=500) {
                    return(500000*(exp(log(2)/100*100))*(exp(log(1/2)/400*(x-100))))
                } else {
                    return(500000*(exp(log(2)/100*100))*(exp(log(1/2)/400*400)))
                }
            } else if (all(sapply(c("100_200G","2e_d_2e_i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(exp(log(0.5)/100*x)))
                } else if (100 < x & x <=500) {
                    return(500000*(exp(log(0.5)/100*100))*(exp(log(2)/400*(x-100))))
                } else {
                    return(500000*(exp(log(0.5)/100*100))*(exp(log(2)/400*400)))
                }
            } else {
            #    ## return empty value
            #    NULL
                return()
            }
        }
        lines(x,sapply(x,fx),type="s",lwd=2.5,col = adjustcolor("red", alpha = 0.8))
        ## add legend in specific plot
        if (all(sapply(c("10d_10d"), grepl, plot_name))) {
        legend("topright",c("Simulation","True model"),col = adjustcolor(c("blue","red"), alpha = 0.8),lty=1,lwd=c(2,3),bty="n")
        } else {
            NULL
        }
    }
}

dev.off()
