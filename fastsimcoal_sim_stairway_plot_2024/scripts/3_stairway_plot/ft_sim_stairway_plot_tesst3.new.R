
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
```
install.packages("httpgd",dependencies=T)
```

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

********************************* raw sfs data **********************
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

********************************* non-pruned using for loop for replicates ******************************
pdf(paste0("combined.5rep.title.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1,2,3,4,5,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (event in c("00d","01d","05d","09d","05i")){
    #for (rep in c(1,2,3,4,5)){
        #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_",rep,"_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary")))
        #print(file_list00)
        #print(event)
        a1 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_1_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t")
        #print(head(a1,n=2L))
        plot(a1$year,a1$Ne_median,type="l", col="red")
        ## add plot title in each plot
        mtext(side=3,text=paste0("10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
        
        ## add replicate lines
        #par(new=TRUE)
        for (rep in c(2:5)){
            ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
            assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_50G_",event,"_20Chr_15Mb_1_",rep,"_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*50G*MSFS.final.summary"))),header=T,sep="\t"))
            #print(head(get(paste0("a",rep)),n=2L))
            ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
            lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l", col="darkorange")
        }
            #combined_data <- c()
            #table_name <- str_replace_all(rep_sum,c("./ft_sim.*MSFS/"="","_MSFS.final.summary"=""))
            #a <- read.table(rep_sum,header=T,sep="\t")
            #print(head(a,n=2L))
            #combined_data <- cbind(combined_data,a$year,a$Ne_median)
            #print(head(combined_data,n=2L))
    #}
}
dev.off()


******************************* modifying multiply condition ***********************
library(gtools)
library(fs)
library(stringr)

final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3-"
setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_test3")

setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")

pdf(paste0("combined.5rep_non_pruned.title.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){
        #for (rep in c(1,2,3,4,5)){
            #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1_1_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*MSFS.final.summary")))
            #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary")))
            #print(file_list00)

            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.5e5),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)

            a1 <- read.table(file_list00,header=T,sep="\t")
            #print(head(a1,n=2L))
            lines(a1$year,a1$Ne_median,type="l",lwd=2,col = adjustcolor("red", alpha = 0.3))
            
            axis(side=1,at=c(50,100,500,1000,10000,100000,200000),label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
            ##turn scientific notion off
            axis(side=2, at=c(500,1000,10000,50000,100000,1000000),label=c(format(c(500,1000,10000,50000,100000,1000000),scientific=FALSE)))
            #eaxis(2, padj=0.5,cex.axis=1.5)
            
            ## add plot title in each plot
            mtext(side=3,text=paste0("10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
            ## add line to indicate ice-age
            #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

            ## add replicate lines
            #par(new=TRUE)
            for (rep in c(2:5)){
                ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
                assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1_",rep,"_MSFS"), recurse = TRUE, type = "file", glob = "*20hapS*MSFS.final.summary"))),header=T,sep="\t"))
                #print(head(get(paste0("a",rep)),n=2L))
                ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
                lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=0.5,col = adjustcolor("blue", alpha = 0.1))
            }
    }
}
dev.off()


************************ 10000Ne_20hap_5rep_non_pruned *************

pdf(paste0("combined.10000Ne_20hap_5rep_non_pruned-.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){
        ## for ploting median line
        #for (rep in c(1,2,3,4,5)){
            #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary")))
            ##print(file_list00)

            #a1 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a1[,c(6,7)],n=2L))

            #a2 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_2"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a2[,c(6,7)],n=2L))

            #a3 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_3"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a3[,c(6,7)],n=2L))

            #a4 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_4"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a4[,c(6,7)],n=2L))

            #a5 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_5"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a5[,c(6,7)],n=2L))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"), cbind(a1[,c(6,7)],a2[,c(6,7)],a3[,c(6,7)],a4[,c(6,7)],a5[,c(6,7)]))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))))
            ##print(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(1,3,5,7,9)],1,median,na.rm=T))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(2,4,6,8,10)],1,median,na.rm=T))

            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))

            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"),cbind(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median")),get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))))

            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)

            ##a1 <- read.table(file_list00,header=T,sep="\t")
            #print(head(a1,n=2L))
            ##lines(a1$year,a1$Ne_median,type="l",lwd=2,col = adjustcolor("red", alpha = 0.3))
            
            axis(side=1,at=c(50,100,500,1000,10000,100000,200000),label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
            ##turn scientific notion off
            axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
            #eaxis(2, padj=0.5,cex.axis=1.5)
            
            ## add plot title in each plot
            mtext(side=3,text=paste0("10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
            ## add line to indicate ice-age
            #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

            ## add replicate lines
            #par(new=TRUE)
            for (rep in c(1:5)){
                ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
                assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t"))
                ##print(head(get(paste0("a",rep)),n=2L))
                #paste0("data_ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
                #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
                ##print(head(data))
                ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
                lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=1.5,col = adjustcolor("blue", alpha = 0.6))
            }
            
            ## plot median line
            #lines(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,1],get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,2],type="l",lwd=2,col = adjustcolor("red", alpha = 1))

    }
}
dev.off()

************* 00_modify_plot_axis_names_conditionally *****************
************* 20hap_5rep_non_pruned ************

library(gtools)
library(fs)
library(stringr)

setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")
final_summary <- "/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned"

## attention to refer to only one file name
#file_list0 <- fs::dir_ls(path=final_summary, recurse = 1, fail=TRUE, type = "file", glob = "*20hapS*15Mb_1.final.summary")
#file_list <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*final.summary")
#file_list0 <- fs::dir_ls(path=final_summary, recurse = TRUE, type = "file", glob = "*.summary")

pdf(paste0("combined.10000Ne_20hap_5rep_non_pruned.real_sim_2.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){
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
        } else if (plot_name %in% c("10000Ne_20hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.9i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")){
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
        } else {
            plot(1,1, type="n", xlim=c(1,5e6), ylim=c(1,1.0e4),log="x", xlab="", ylab="",xaxt='n',yaxt='n')
            #xlab="Years ago", ylab="Effective population size"
            title(line=2)
        }

        ##turn scientific notion off
        #axis(side=1,at=c(50,100,500,1000,10000,100000,200000),las=0,label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
        axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
        #eaxis(2, padj=0.5,cex.axis=1.5)
        
        ## rotating x axis labels
        lablist.x <- as.vector(c(50,100,500,1000,10000,100000,200000))
        axis(side=1,at=c(50,100,500,1000,10000,100000,200000),labels=FALSE)
        text(x=c(50,100,500,1000,10000,100000,200000),labels = c(format(lablist.x,scientific=FALSE)),par("usr")[3] - 900,srt = 45,pos = 3, xpd = TRUE)
  
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
            lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=2.5,col = adjustcolor("blue", alpha = 0.6))
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
            if (all(sapply(c("cons"), grepl, plot_name))) {
                ## constant Ne
                return(5000)
            } else if (all(sapply(c("50G","1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("50G","1.5i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("50G","1.9i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("50G","0.5e_d_1.5i"), grepl, plot_name))) {
                if (x <= 50) {
                    return(5000*(0.9868^x))
                } else {
                    return(5000*(0.9868^50)*1.5)
                }
            } else if (all(sapply(c("100G","1.1i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("100G","1.5i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("100G","1.9i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("100G","0.5e_d_1.5i"), grepl, plot_name))) {
                if (x <= 100) {
                    return(5000*(0.9933^x))
                } else {
                    return(5000*(0.9933^100)*1.5)
                }
            } else if (all(sapply(c("500G","1.1i"), grepl, plot_name))) {
                ## piewise 
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("500G","1.5i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("500G","1.9i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("500G","0.5e_d_1.5i"), grepl, plot_name))) {
                if (x <= 500) {
                    return(5000*(0.9987^x))
                } else {
                    return(5000*(0.9987^500)*1.5)
                }
            } else if (all(sapply(c("1000G","1.1i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.1)
                }
            } else if (all(sapply(c("1000G","1.5i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.5)
                }
            } else if (all(sapply(c("1000G","1.9i"), grepl, plot_name))) {
                if (x <= 1000) {
                    return(5000)
                } else {
                    return(5000*1.9)
                }
            } else if (all(sapply(c("1000G","0.5e_d_1.5i"), grepl, plot_name))) {
            #} else {
                if (x <= 1000) {
                    return(5000*(0.9993^x))
                } else {
                    return(5000*(0.9993^1000)*1.5)
                }
            } else {
                ## return empty value
                NULL
            #    #return(NULL)
            }
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

**********************************************************************
gen <- c("50G","100G","500G","1000G")
event <- c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")

gen <- seq(0,1000,10)
gen <- c(50,100,500,1000,5000,10000,50000)

for (generation in c("50G","100G","500G","1000G")){
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){

}
******************************************************************

#x > 0
lambda <- 0.665
## lambda <- e^r
#Nt <- Ne*e^(rx)
x <- 0:40000
N <- 10000*lambda^t
#N <- sapply(lambda, function(lambda) 10000*lambda^x)
round(N,0)

pdf(paste0("combined.10000Ne_xx_5rep_non_pruned.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))
*************************** 00_test *********************************

setwd("/home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned")

x <- 0:100000
## plot not obvious
pdf("exp_cons_plot_test_1000y.pdf")
y <- function(x) {
    if (x <= 1000) {
    return(5000*(0.9993^x))
} else {
    return(5000*(0.9993^1000)*1.5)
}
}
plot(x,sapply(x,y),type="s")
dev.off()
## plot more obvious
x <- 0:100000
pdf("exp_cons_plot_test_50000y.pdf")
y <- function(x) {
    if (x <= 50000) {
    return(5000*(0.9993^x))
} else {
    return(5000*(0.9993^1000)*1.5)
}
}

x <- 0:100000
pdf("exp_cons_plot_test_50000y.else_null.pdf")
y <- function(x) {
    if (x <= 50000) {
    return(5000*(0.9993^x))
} else if (x <= 100000) {
    return(5000*(0.9993^1000)*1.5)
} else {
    return(NULL)
}
}

plot(x,sapply(x,y),type="s")
dev.off()

****************************
x <- 0:100000
plot_name <- c("10000Ne_20hapS_1E_1000G_1.1i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.5i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_1.9i_20Chr_15Mb","10000Ne_20hapS_1E_1000G_0.5e_d_1.5i_20Chr_15Mb")
fx <- function(x) {
    if (all(sapply(c("cons"), grepl, plot_name))) {
        ## constant Ne
        return(10000)
    } else if (all(sapply(c("50G","1.1i"), grepl, plot_name))) {
        ## piewise 
        if (x <= 50) {
            return(10000)
        } else {
            return(10000*1.1)
        }
    } else if (all(sapply(c("50G","1.5i"), grepl, plot_name))) {
        if (x <= 50) {
            return(10000)
        } else {
            return(10000*1.5)
        }
    } else if (all(sapply(c("50G","1.9i"), grepl, plot_name))) {
        if (x <= 50) {
            return(10000)
        } else {
            return(10000*1.9)
        }
    } else if (all(sapply(c("50G","0.5e_d_1.5i"), grepl, plot_name))) {
        if (x <= 50) {
            return(5000)
        } else {
            return(5000*1.5)
        }
    } else if (all(sapply(c("100G","1.1i"), grepl, plot_name))) {
        if (x <= 100) {
            return(10000)
        } else {
            return(10000*1.1)
        }
    } else if (all(sapply(c("100G","1.5i"), grepl, plot_name))) {
        if (x <= 100) {
            return(10000)
        } else {
            return(10000*1.5)
        }
    } else if (all(sapply(c("100G","1.9i"), grepl, plot_name))) {
        if (x <= 100) {
            return(10000)
        } else {
            return(10000*1.9)
        }
    } else if (all(sapply(c("100G","0.5e_d_1.5i"), grepl, plot_name))) {
        if (x <= 100) {
            return(5000*(0.9933^x))
        } else {
            return(5000*(0.9933^100)*1.5)
        }
    } else if (all(sapply(c("500G","1.1i"), grepl, plot_name))) {
        ## piewise 
        if (x <= 500) {
            return(10000)
        } else {
            return(10000*1.1)
        }
    } else if (all(sapply(c("500G","1.5i"), grepl, plot_name))) {
        if (x <= 500) {
            return(10000)
        } else {
            return(10000*1.5)
        }
    } else if (all(sapply(c("500G","1.9i"), grepl, plot_name))) {
        if (x <= 500) {
            return(10000)
        } else {
            return(10000*1.9)
        }
    } else if (all(sapply(c("500G","0.5e_d_1.5i"), grepl, plot_name))) {
            if (x <= 1000) {
                return(5000*(0.9993^x))
            } else {
                return(5000*(0.9993^1000)*1.5)
            }
    } else if (all(sapply(c("1000G","1.1i"), grepl, plot_name))) {
        if (x <= 1000) {
            return(10000)
        } else {
            return(10000*1.1)
        }
    } else if (all(sapply(c("1000G","1.5i"), grepl, plot_name))) {
        if (x <= 1000) {
            return(10000)
        } else {
            return(10000*1.5)
        }
    } else if (all(sapply(c("1000G","1.9i"), grepl, plot_name))) {
        if (x <= 1000) {
            return(10000)
        } else {
            return(10000*1.9)
        }
    } else {
    #} else if (all(sapply(c("1000G","0.5e_d_1.5i"), grepl, plot_name))) {
        if (x <= 1000) {
            return(5000*(0.9993^x))
        } else {
        return(5000*(0.9993^1000)*1.5)
        }
    }
}
#lines(x,sapply(x,fx),type="s")
plot(x,sapply(x,fx),type="s")
dev.off()



fx <- function(gen) {
    if (gen <= 50) {
        return(1000)
    } else if (gen >=50 & gen < 10000) {
        return(1000*3)
    } else {
        return(1000*0.5)
    }
}
plot(gen,sapply(gen,fx),type="s")

library(stringr)
myStr_0 <- "geeksforgeeks"
str_0 <- c("ee","ks")
str_0 <- c("ee","kk")
all(str_detect(str_0,myStr_0))
all(sapply(str_0, grepl, myStr_0))

if (all(sapply(c("ee","ks"), grepl, "geeksforgeeks"))) {
    cat("Alphabets present\n")
} else  {
    cat("Alphabets not present\n")
}



myStr <- "I am very beautiful btw"
myStrings <- c("I am very beautiful btw", "I am not beautiful btw")
str <- c("very","beauti","bt")
sapply(str, grepl, myStr)
all(sapply(str, grepl, myStr))
apply(sapply(str, grepl, myStrings), 1, all)

str_detect(myStr, str)
all(str_detect(myStr,str))


*************   80hap_5rep_non_pruned *************

pdf(paste0("combined.5000Ne_80hap_5rep_non_pruned.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){
        ## for ploting median line
        #for (rep in c(1,2,3,4,5)){
            #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary")))
            ##print(file_list00)

            #a1 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a1[,c(6,7)],n=2L))

            #a2 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_2"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a2[,c(6,7)],n=2L))

            #a3 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_3"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a3[,c(6,7)],n=2L))

            #a4 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_4"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a4[,c(6,7)],n=2L))

            #a5 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_5"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a5[,c(6,7)],n=2L))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"), cbind(a1[,c(6,7)],a2[,c(6,7)],a3[,c(6,7)],a4[,c(6,7)],a5[,c(6,7)]))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))))
            ##print(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(1,3,5,7,9)],1,median,na.rm=T))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(2,4,6,8,10)],1,median,na.rm=T))

            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))

            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"),cbind(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median")),get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))))

            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)

            ##a1 <- read.table(file_list00,header=T,sep="\t")
            #print(head(a1,n=2L))
            ##lines(a1$year,a1$Ne_median,type="l",lwd=2,col = adjustcolor("red", alpha = 0.3))
            
            axis(side=1,at=c(50,100,500,1000,10000,100000,200000),label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
            ##turn scientific notion off
            axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
            #eaxis(2, padj=0.5,cex.axis=1.5)
            
            ## add plot title in each plot
            mtext(side=3,text=paste0("5000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
            ## add line to indicate ice-age
            #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

            ## add replicate lines
            #par(new=TRUE)
            for (rep in c(1:5)){
                ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
                assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_5000Ne_80hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = TRUE, type = "file", glob = "*80hapS*.final.summary"))),header=T,sep="\t"))
                ##print(head(get(paste0("a",rep)),n=2L))
                #paste0("data_ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
                #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
                ##print(head(data))
                ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
                lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=1.5,col = adjustcolor("blue", alpha = 0.6))
            }
            
            ## plot median line
            #lines(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,1],get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,2],type="l",lwd=2,col = adjustcolor("red", alpha = 1))

    }
}
dev.off()


*************   200hap_5rep_non_pruned *************

pdf(paste0("combined.5000Ne_200hap_5rep_non_pruned.pdf"),width = 20, height = 25)
par(mfcol=c(5,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1:25),nrow=5,ncol=5,byrow=T),width=c(1,1),height=c(1,1))

for (generation in c("50G","100G","500G","1000G")){
    ## old naming format
    #for (event in c("00d","01d","05d","09d","05i")){
    ## modified naming format
    for (event in c("cons","1.1i","1.5i","1.9i","0.5e_d_1.5i")){
        ## for ploting median line
        #for (rep in c(1,2,3,4,5)){
            #file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary")))
            ##print(file_list00)

            #a1 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a1[,c(6,7)],n=2L))

            #a2 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_2"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a2[,c(6,7)],n=2L))

            #a3 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_3"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a3[,c(6,7)],n=2L))

            #a4 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_4"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a4[,c(6,7)],n=2L))

            #a5 <- read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_5"), recurse = TRUE, type = "file", glob = "*20hapS*.final.summary"))),header=T,sep="\t")
            ##print(head(a5[,c(6,7)],n=2L))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"), cbind(a1[,c(6,7)],a2[,c(6,7)],a3[,c(6,7)],a4[,c(6,7)],a5[,c(6,7)]))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))))
            ##print(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(1,3,5,7,9)],1,median,na.rm=T))
            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"),apply(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb"))[,c(2,4,6,8,10)],1,median,na.rm=T))

            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))

            #assign(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"),cbind(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_median")),get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_Ne_median"))))
            ##print(head(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))))

            plot(1,1, type="n", xlim=c(1,5e5), ylim=c(1,1.0e4),log="x", xlab="Years ago", ylab="Effective population size",xaxt='n',yaxt='n')
            #log="xy",xlab="Years ago", ylab="Effective population size"
            title(line=2)

            ##a1 <- read.table(file_list00,header=T,sep="\t")
            #print(head(a1,n=2L))
            ##lines(a1$year,a1$Ne_median,type="l",lwd=2,col = adjustcolor("red", alpha = 0.3))
            
            axis(side=1,at=c(50,100,500,1000,10000,100000,200000),label=c(format(c(50,100,500,1000,10000,100000,200000),scientific=FALSE)))
            ##turn scientific notion off
            axis(side=2, at=c(500,1000,5000,7000,10000),label=c(format(c(500,1000,5000,7000,10000),scientific=FALSE)))
            #eaxis(2, padj=0.5,cex.axis=1.5)
            
            ## add plot title in each plot
            mtext(side=3,text=paste0("5000Ne_200hapS_1E_",generation,"_",event,"_20Chr_15Mb"),cex=0.8,line=1.2)
            ## add line to indicate ice-age
            #abline(v=13000,col="grey",lwd=1.8)  # add a vertical line at 13,000 years ago to indicate end of last glaction

            ## add replicate lines
            #par(new=TRUE)
            for (rep in c(1:5)){
                ## https://stackoverflow.com/questions/27662162/error-in-my-code-target-of-assignment-expands-to-non-language-object
                assign(paste0("a",rep), read.table(mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_5000Ne_200hapS_1E_",generation,"_",event,"_20Chr_15Mb_",rep), recurse = TRUE, type = "file", glob = "*200hapS*.final.summary"))),header=T,sep="\t"))
                ##print(head(get(paste0("a",rep)),n=2L))
                #paste0("data_ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb")
                #data <- data.frame(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median)
                ##print(head(data))
                ## https://stackoverflow.com/questions/77616764/how-to-use-paste0-to-get-the-column-of-a-table-in-r
                lines(get(paste0("a",rep))$year,get(paste0("a",rep))$Ne_median,type="l",lwd=1.5,col = adjustcolor("blue", alpha = 0.6))
            }
            
            ## plot median line
            #lines(get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,1],get(paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_year_Ne_median"))[,2],type="l",lwd=2,col = adjustcolor("red", alpha = 1))

    }
}
dev.off()

**********************************************************************
example_data <- read.table("./ft_sim_10000Ne_20hapS_1E_50G_09d_20Chr_15Mb_5/ft_sim_10000Ne_20hapS_1E_50G_09d_20Chr_15Mb_5.final.summary",header=T,sep="\t")

*************** bash script to modify folder/file names under certain conditions **************
for event in {"00d","01d","05d","09d","05i"};do
    if [ $event == "00d" ];then
        ## -maxdepth 2 final.summary file
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename $event "cons" $file
    elif [ $event == "01d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename $event "1.1i" $file
    elif [ $event == "05d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename $event "1.5i" $file
    elif [ $event == "09d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename $event "1.9i" $file
    else
        # 05i (two events)
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename $event "0.5e_d_1.5d" $file
    fi
done

************** correct renaming "final.summary" files due to the previous error ***************
for event in {"cons","1.1i","1.5i","1.9i","0.5e_d_1.5i"};do
    if [ $event == "00d" ];then
        ## -maxdepth 2 final.summary file
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename "cons" "cons" $file
    elif [ $event == "01d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename "cons" "1.1i" $file
    elif [ $event == "05d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename "cons" "1.5i" $file
    elif [ $event == "09d" ];then
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename "cons" "1.9i" $file
    else
        # 05i (two events)
        file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "$event" | grep final.summary$`
        rename "cons" "0.5e_d_1.5i" $file
    fi
done

*************************  -maxdepth 1 folder level ****************
#### caution to the space before and after " == "
for event in {"00d","01d","05d","09d","05i"};do
    if [ $event == "00d" ];then
        ## -maxdepth 1 folder level
        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
#        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
        rename $event "cons" $folder
    elif [ $event == "01d" ];then
        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
        rename $event "1.1i" $folder
    elif [ $event == "05d" ];then
        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
        rename -v $event "1.5i" $folder
    elif [ $event == "09d" ];then
        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
        rename -v $event "1.9i" $folder
    else
        # 05i (two events)
        folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "$event"`
        rename -v $event "0.5e_d_1.5i" $folder
    fi
done
## change folder names
folder=`find -maxdepth 1 -print | grep 10000Ne | grep 1E | grep "_20Chr_15Mb_[1-5]"`
for Ne in $folder;do
    rename 10000Ne 5000Ne $Ne
done
## change back folder names
folder=`find -maxdepth 1 -print | grep 5000Ne | grep 1E | grep "_20Chr_15Mb_[1-5]"`
for Ne in $folder;do
    rename 5000Ne 10000Ne $Ne
done
## change file names
final_summary_file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "_20Chr_15Mb_[1-5]" | grep "final.summary$"`
for Ne in $final_summary_file;do
    rename 10000Ne 5000Ne $Ne
done

## change back file names
final_summary_file=`find -maxdepth 2 -print | grep 10000Ne | grep 1E | grep "_20Chr_15Mb_[1-5]" | grep "final.summary$"`
for Ne in $final_summary_file;do
    rename 5000Ne 10000Ne $Ne
done


******************************************************************
for (generation in c("50G","100G","500G","1000G")){
    for (event in c("00d","01d","05d","09d","05i")){
        #for (rep in c(1,2,3,4,5)){
            file_list00 <- mixedsort(sort(fs::dir_ls(path=paste0("./ft_sim_10000Ne_20hapS_1E_",generation,"_",event,"_20Chr_15Mb_1"), recurse = TRUE, type = "file", glob = "*20hapS*MSFS.final.summary")))
            print(file_list00)
    }
}
Nt=N0ert,1000=10000er*100













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
**************************************************************************
## error when run in interactive window in R script

****************************** non-pruned ********************************

pdf(paste0("combined_raw_sfs.pdf"),width = 20, height = 25)
par(mfcol=c(4,5),mar=c(5,5,4,2)+0.2,cex.lab=1.6, cex.axis=1.3,lwd=2)
layout(matrix(c(1,2,3,4,5,6,7,8,9,10,0,0,0,0,0,0,0,0,0,0),nrow=4,ncol=5,byrow=T),width=c(1,1),height=c(1,1))
for (final in file_list){
    ## plot names
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
