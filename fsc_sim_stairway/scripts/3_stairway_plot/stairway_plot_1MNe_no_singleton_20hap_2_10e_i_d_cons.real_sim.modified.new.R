
#setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned/")
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp")
#final_summary <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/100KNe_swp"
#mixedsort(sort(fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*G_*e_*_cons*20hapS*15Mb_*.final.summary")))
## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*20hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

library(gtools)
library(fs)
library(stringr)

pdf(paste0("combined.1MNe_no_singleton_20hapS_5rep_2_10_i_d_cons.rotated_x_lab.pdf"),width = 20, height = 25)
#pdf(paste0("combined.1000000Ne_20hapS_5rep_non_pruned.real_sim.rotated_x_lab-.pdf"),width = 20, height = 25)
#par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
#par(mfcol=c(5,5),mar=c(4,4,3,1)+0.1,cex.lab=1.6, cex.axis=1.3,lwd=2)
par(mfcol=c(5,4),mar=c(4,4.4,3,1)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)

layout(matrix(c(1:20),nrow=5,ncol=4,byrow=T),width=c(1,1),height=c(1,1))
#layout(matrix(c(1,2,3,0,4,5,6,0,7,8,9,0,10:17),nrow=5,ncol=4,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    
    ## difficult to simulate
    for (event in c("2e_d_cons","10e_d_cons","2e_i_cons","10e_i_cons")){
    #for (event in c("2e_d_cons","10e_d_cons","2e_i_cons")){
        ## solo axis name plot
        #plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
        ##log="xy",xlab="Years ago", ylab="Effective population size"
        #title(line=2)

        ## key step
        ## conditional axis name plot
        plot_name <- paste0("1MNe_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
        #print(plot_name)
        
        if (plot_name %in% c("1MNe_20hapS_1E_50G_2e_d_cons_20Chr_15Mb", "1MNe_20hapS_1E_100G_2e_d_cons_20Chr_15Mb", "1MNe_20hapS_1E_500G_2e_d_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,5.5e5),log="x", xlab="", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,250000,500000,550000),label=c(format(c(150000,250000,500000,550000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_1000G_2e_d_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.5e5),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,250000,500000,550000),label=c(format(c(150000,250000,500000,550000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_1000G_2e_i_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.2e6),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,250000,500000,750000,1000000,1200000),label=c(format(c(150000,250000,500000,750000,1000000,1200000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_50G_2e_i_cons_20Chr_15Mb","1MNe_20hapS_1E_100G_2e_i_cons_20Chr_15Mb","1MNe_20hapS_1E_500G_2e_i_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.2e6),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,500000,750000,1000000,1500000,2000000,3000000,400000,5000000),label=c(format(c(150000,500000,750000,1000000,1500000,2000000,5000000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_50G_10e_i_cons_20Chr_15Mb","1MNe_20hapS_1E_100G_10e_i_cons_20Chr_15Mb","1MNe_20hapS_1E_500G_10e_i_cons_20Chr_15Mb")){
            
            ## high Ne (attention to duplicate)

            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.2e6),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,500000,750000,1000000,1500000,2000000,5000000),label=c(format(c(150000,500000,750000,1000000,1500000,2000000,5000000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_1000G_10e_i_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.2e6),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(150000,500000,750000,1000000,1500000,2000000,5000000),label=c(format(c(150000,500000,750000,1000000,1500000,2000000,5000000),scientific=FALSE)))

        } else if (plot_name %in% c("1MNe_20hapS_1E_1000G_10e_d_cons_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.5e5),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(20000,50000,80000,100000,150000,250000,500000,550000),label=c(format(c(20000,50000,80000,100000,150000,250000,500000,550000),scientific=FALSE)))

        } else {#50G_100G_500G_10e_d_cons
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,5.5e5),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
            axis(side=2, at=c(20000,50000,80000,100000,150000,250000,500000,550000),label=c(format(c(20000,50000,80000,100000,150000,250000,500000,550000),scientific=FALSE)))

        }

        ## add plot title in each plot
        mtext(side=3,text=paste0("1MNe_no_singleton_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        ## add line to indicate ice-age
        #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

        ## add replicate lines
        #par(new=TRUE)
        for (rep in c(1:5)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            ## assign variable to read_data
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_1MNe_no_singleton_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = 1, fail=TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t"))
            #print(head(get(paste0("a",rep)),n=2L))
            #paste0("data_ft_sim_1000000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
            #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
            #print(head(data,n=2L))
            ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
            lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=1.6,col = adjustcolor("blue", alpha = 0.6))
        }
# error check: Error in file(file, "rt") : invalid 'description' argument
#    }
#}
        ## plot real demography

        ## piewise function
        ## https://stackoverflow.com/questions/61157263/define-and-plot-a-piecewise-function-in-r
        ## https://stackoverflow.com/questions/65068196/how-to-plot-a-piecewise-function-in-r
        
        ## check if multiple patterns exist in string
        ## https://stackoverflow.com/questions/30180281/how-can-i-check-if-multiple-strings-exist-in-another-string

        x <- 0:100000
        #plot_name <- c("1MNe_20hapS_1E_1000G_1.1i_20Chr_15Mb","1MNe_20hapS_1E_1000G_1.5i_20Chr_15Mb","1MNe_20hapS_1E_1000G_1.9i_20Chr_15Mb","1MNe_20hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
        ## category
        ## 50G "G_2e_d_cons" (r=-0.0139,er=0.9862),"G_2e_i_cons" (r=0.0139,er=1.0140),"G_10e_d_cons" (r=-0.0461,er=0.9549),"G_10e_i_cons" (r=0.0461,er=1.0472) # nolint
        ## 100G "G_2e_d_cons" (r=-0.0069,er=0.9931),"G_2e_i_cons" (r=0.0069,er=1.0069),"G_10e_d_cons" (r=-0.0230,er=0.9773),"G_10e_i_cons" (r=0.0230,er=1.0233)
        ## 500G "G_2e_d_cons" (r=-0.0014,er=0.9986),"G_2e_i_cons" (r=0.0014,er=1.0014),"G_10e_d_cons" (r=-0.0046,er=0.9954),"G_10e_i_cons" (r=0.0046,er=1.0046)
        ## 1000G "G_2e_d_cons" (r=-0.0007,er=0.9993),"G_2e_i_cons" (r=0.0007,er=1.0007),"G_10e_d_cons" (r=-0.0023,er=0.9977),"G_10e_i_cons" (r=0.0023,er=1.0023)

        ## er=λ; (er)t=λt 

        fx <- function(x) {
            if (all(sapply(c("G_cons_cons"), grepl, plot_name))) {
                ## constant Ne
                return(500000)
            
            ## gen_100
            } else if (all(sapply(c("50G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(500000*(0.9862^x))
                } else {
                    return(500000*(0.9862^50))
                }
            } else if (all(sapply(c("50G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(500000*(1.0140^x))
                } else {
                    return(500000*(1.0140^50))
                }
            } else if (all(sapply(c("50G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(500000*(0.9549^x))
                } else {
                    return(500000*(0.9549^50))
                }
            } else if (all(sapply(c("50G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 50) {
                    return(500000*(1.0472^x))
                } else {
                    return(500000*(1.0472^50))
                }
            
            ## gen_100
            } else if (all(sapply(c("100G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(0.9931^x))
                } else {
                    return(500000*(0.9931^100))
                }
            } else if (all(sapply(c("100G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(1.0069^x))
                } else {
                    return(500000*(1.0069^100))
                }
            } else if (all(sapply(c("100G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(0.9773^x))
                } else {
                    return(500000*(0.9773^100))
                }
            } else if (all(sapply(c("100G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 100) {
                    return(500000*(1.0233^x))
                } else {
                    return(500000*(1.0233^100))
                }
            
            ## gen_500
            } else if (all(sapply(c("500G","G_2e_d_cons"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(500000*(0.9986^x))
                } else {
                    return(500000*(0.9986^500))
                }
            } else if (all(sapply(c("500G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(500000*(1.0014^x))
                } else {
                    return(500000*(1.0014^500))
                }
            } else if (all(sapply(c("500G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(500000*(0.9954^x))
                } else {
                    return(500000*(0.9954^500))
                }
            } else if (all(sapply(c("500G","G_10e_i_cons"), grepl, plot_name))) {
                if (x <= 500) {
                    return(500000*(1.0046^x))
                } else {
                    return(500000*(1.0046^500))
                }
            
            ## gen_1000
            } else if (all(sapply(c("1000G","G_2e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(500000*(0.9993^x))
                } else {
                    return(500000*(0.9993^1000))
                }
            } else if (all(sapply(c("1000G","G_2e_i_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                     return(500000*(1.0007^x))
                } else {
                    return(500000*(1.0007^1000))
                }
            } else if (all(sapply(c("1000G","G_10e_d_cons"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(500000*(0.9977^x))
                } else {
                    return(500000*(0.9977^1000))
                }
            # } else if (all(sapply(c("1000G","G_0.5e_d_1.5i"), grepl, plot_name))) {
            } else {#G_10e_i_cons
                if (x <= 1000) {
                    return(500000*(1.0023^x))
                } else {
                    return(500000*(1.0023^1000))
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

