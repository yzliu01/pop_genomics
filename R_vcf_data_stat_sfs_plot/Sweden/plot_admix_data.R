rm(list=ls())
library(scales)
data_K2 <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/run5/vcf_filt_maxmiss_per_pop_hetz_excl_or_missing_concat.vcf_plink_recode_thin_ibmale.2.Q",header=FALSE)
data_K3 <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/run5/vcf_filt_maxmiss_per_pop_hetz_excl_or_missing_concat.vcf_plink_recode_thin_ibmale.3.Q",header=FALSE)
data_K4 <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/run5/vcf_filt_maxmiss_per_pop_hetz_excl_or_missing_concat.vcf_plink_recode_thin_ibmale.4.Q",header=FALSE)
data_K5 <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/run5/vcf_filt_maxmiss_per_pop_hetz_excl_or_missing_concat.vcf_plink_recode_thin_ibmale.5.Q",header=FALSE)

# cv_errors <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/unsup_CV_errors_for_plot.txt",header=FALSE)
# par(mfrow=c(2,3))
# cv_run1 <- subset(cv_errors,V1=="run1")
# cv_run2 <- subset(cv_errors,V1=="run2")
# cv_run3 <- subset(cv_errors,V1=="run3")
# cv_run4 <- subset(cv_errors,V1=="run4")
# cv_run5 <- subset(cv_errors,V1=="run5")

# plot(cv_run1$V2,cv_run1$V3,type="b",lty=2,lwd=2,pch=15,cex=2,col="slateblue",ylab="CV=10",xlab="K",main="Run 1",ylim=c(0.08,0.14))
# plot(cv_run2$V2,cv_run2$V3,type="b",lty=2,lwd=2,pch=15,cex=2,col="slateblue",ylab="CV=10",xlab="K",main="Run 2",ylim=c(0.08,0.14))
# plot(cv_run3$V2,cv_run3$V3,type="b",lty=2,lwd=2,pch=15,cex=2,col="slateblue",ylab="CV=10",xlab="K",main="Run 3",ylim=c(0.08,0.14))
# plot(cv_run4$V2,cv_run4$V3,type="b",lty=2,lwd=2,pch=15,cex=2,col="slateblue",ylab="CV=10",xlab="K",main="Run 4",ylim=c(0.08,0.14))
# plot(cv_run5$V2,cv_run5$V3,type="b",lty=2,lwd=2,pch=15,cex=2,col="slateblue",ylab="CV=10",xlab="K",main="Run 5",ylim=c(0.08,0.14))

samp_names <- read.table("/home/turid/Documents/HoneyBees/colombian_admixture/groupC/admixture/samp_names_simple_v4.txt",header=FALSE)

samp_order <- sort.list(samp_names$V1)
samp_names_sorted <- samp_names$V1[samp_order]

data_K2_sort <- data_K2[samp_order,]
data_K3_sort <- data_K3[samp_order,]
data_K4_sort <- data_K4[samp_order,]
data_K5_sort <- data_K5[samp_order,]

data_K2_t <- t(data_K2_sort)
data_K3_t <- t(data_K3_sort)
data_K4_t <- t(data_K4_sort)
data_K5_t <- t(data_K5_sort)

name_size <- 0.8

par(mfrow=c(4,1))
par(mar=c(1.6, 4.6, 2.1, 2.1))

col_list <- c(alpha("salmon3",0.75),"rosybrown4") 
barplot(data_K2_t,axisnames=FALSE,col=col_list,cex.names=name_size,las=2,space=0,ylab="K=2")
col_list <- c("gray","rosybrown4",alpha("salmon3",0.75)) 
barplot(data_K3_t,axisnames=FALSE,col=col_list,cex.names=name_size,las=2,space=0,ylab="K=3")
col_list <- c(alpha("darkkhaki",0.75),"gray",alpha("salmon3",0.75),"rosybrown4") 
barplot(data_K4_t,axisnames=FALSE,col=col_list,cex.names=name_size,las=2,space=0,ylab="K=4")
par(mar=c(8.1, 4.6, 2.1, 2.1))
col_list <- c("rosybrown4","gray",alpha("salmon3",0.75),alpha("olivedrab4",0.8),alpha("darkkhaki",0.75)) 
barplot(data_K5_t,names.arg=samp_names_sorted,col=col_list,cex.names=name_size,las=2,space=0,ylab="K=5")

par(mar=c(5.1, 4.1, 4.1, 2.1)) # default
