

library(ggplot2)
setwd("/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/stats")
setwd("E:/LiuYZ/??????/fafu/project/stats")
list.files()
data_DP_EH <- read.table("small_data_DP_EH.txt",header=T)
data <- head(data_DP_EH)
hist(data_DP_EH$ExcessHet,xlim=c(0,100),ylim=c(0,5000))
ggplot(data_DP_EH,aes(DP))  +
  geom_histogram(bins=10)

setwd("/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/stats")
list.files()
data_DP_EH_small <- read.table("small_data_DP_EH.txt",header=T)
data_DP_EH <- read.table("merged_49Atum_1Agla_2Dpon_1Amel.SNP.H_F.DP3_GQ20_BiSNP.vcf.gz.INFO",header=T)
data <- head(data_DP_EH,n=60L)
data
hist(data_DP_EH$ExcessHet,xlim=c(0,150),ylim=c(0,10000))

plot(cut(data_DP_EH$DP,30))
hist(data_DP_EH$DP,xlim=c(0,150000),ylim=c(0,10000))

ggplot(data_DP_EH,aes(ExcessHet))  +
  geom_histogram(bins=10)

xlim(1,500)
xlim(1,3000)

#### PCA ####
setwd("E:/LiuYZ/??????/fafu/project/PCA")
"E:/Share/Sweden_UU/SW_mountain_bee/analysis/pca"
# https://www.biostars.org/p/44735/
# https://bioinformatics.stackexchange.com/questions/16089/pca-plot-in-r-coloured-by-sample-type
# https://stackoverflow.com/questions/15624656/label-points-in-geom-point
# http://rstudio-pubs-static.s3.amazonaws.com/53162_cd16ee63c24747459ccd180f69f07810.html
# https://ggplot2.tidyverse.org/reference/geom_point.html
# shape http://www.sthda.com/english/wiki/ggplot2-point-shapes
# shape https://ggplot2.tidyverse.org/reference/geom_point.html
# remove "a" in legend https://stackoverflow.com/questions/18337653/remove-a-from-legend-when-using-aesthetics-and-geom-text
library(ggplot2)
library(ggrepel) # for function "geom_text_repel"
list.files()
dir()
dfile <- file.info(dir(pattern = "eigenvec$"),extra_cols = F)
dfile[order(dfile$mtime),]

dfile <- dfile[with(dfile,order(as.POSIXct(mtime))),]
files = rownames(dfile)



df <- read.delim("merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.plink.pca.eigenvec",header = F, sep = " ")
head(df$V2)
head(df)
eigen_val <- read.delim("merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.plink.pca.eigenval",header = F,sep = " ")
head(eigen_val)

library(stringr)
library(stringi)
df_rep <- gsub("BF.*","BF",df$V2)
write.csv(df$V2,file = "Atum_sample_ID.txt")
df$V2 <- gsub("BF.*","BF",df$V2)
df$V2 <- gsub("BF_10","Burkina_Faso_1",df$V2)
#### replace string ####
#https://www.statology.org/r-gsub-multiple-patterns/
df$V2 <- stri_replace_all_regex(df$V2,
                                 pattern = c("BF_2","BF_8","BF_11","BF_12",
                                             "BF_1","BF_10","BF_3","BF_4","BF_5","BF_6","BF_7","BF_9",
                                             "GZ.*","LB.*","SA.*","TZ.*"),
                                 replacement = c("Burkina_Faso_2","Burkina_Faso_2","Burkina_Faso_2","Burkina_Faso_2",
                                                 "Burkina_Faso_1","Burkina_Faso_X1","Burkina_Faso_1","Burkina_Faso_1","Burkina_Faso_1","Burkina_Faso_1","Burkina_Faso_1","Burkina_Faso_1",
                                                 "China","Liberia","South_Africa","Tazania"),
                                 vectorize=F)

#### change legend order ####
#https://statisticsglobe.com/change-display-order-of-ggplot2-plot-legend-in-r
df2$V2 <- factor(df2$V2,levels = c("Burkina_Faso_1","Burkina_Faso_2","Liberia",
                                   "South Africa","Tanzania","China"))


sum_eigen_val <- sum(eigen_val$V1)
sum_eigen_vals <- lapply(eigen_val$V1,function(x){
  rt <- (x/sum_eigen_val)*100
  rt <- round(rt)
  return(rt)
})

pca_pas <- ggplot(df, aes(V3,V4,color=V2))+
  geom_point(size=0.5,alpha = 3/4)+
  theme_bw()+
  theme(legend.position = "none")+
  xlab(paste0("PC1: ",sum_eigen_vals[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals[[2]],"% variance"))+
  geom_text_repel(aes(label=V2),size=2,
                  segment.size=0.05,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

ggsave(pca_pas,filename= "Atum_pac_PC1_PC2.pdf",width = 6,height = 4)

####################################################################

pca_pas1 <- ggplot(df, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = c(0.45,0.8),legend.text = element_text(size=8),
        legend.title = element_text(size=8),
        legend.key.size = unit(0.2, 'cm'),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Samples of (",italic("Aethina tumida"),")")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals[[2]],"% variance"))+
  scale_colour_manual(values =c("black", "blue", "#BCBD22","#9632B8","#008280","red"))+
  
  geom_text_repel(aes(label=ifelse(V4 < -0.5,as.character(V1),'')),size=2.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))


************************************************* worked
#  https://stackoverflow.com/questions/41362895/r-ggplot2-change-the-spacing-between-the-legend-and-the-panel
PCA_Atum_1 <- ggplot(df, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 3/4)+
  theme_bw()+
  theme(legend.position = "none",
        legend.direction = "vertical",
        legend.title = element_text(size = 6),
        legend.text = element_text(size = 6),
        legend.key.size = unit(0.5, "cm"),
        legend.box.spacing = unit(0.8,"pt"),
        legend.margin=margin(0,0,0,0),
        #legend.justification = c("left", "top"),
        panel.grid = element_blank(),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals[[2]],"% variance"))
  #scale_colour_manual(values =c("black", "orange", "cyan","chartreuse","red","blue"))+
  
  #geom_text_repel(aes(label=ifelse(V4>0.1 | V3 > 0.23,as.character(V1),'')),size=2,
                segment.size=0.1,
                segment.color = "grey50",
                alpha=0.5,
                show.legend=FALSE,
                max.overlaps = getOption("ggrepel.max.overlaps", 200))

PCA_Atum_2 <- ggplot(df, aes(V3,V5,color=V2))+
  geom_point(size=2,alpha = 3/4)+
  theme_bw()+
  theme(legend.position = "right",
        legend.direction = "vertical",
        legend.title = element_text(size = 6),
        legend.text = element_text(size = 6),
        legend.key.size = unit(0.5, "cm"),
        legend.box.spacing = unit(0.8,"pt"),
        legend.margin=margin(0,0,0,0),
        #legend.justification = c("left", "top"),
        panel.grid = element_blank(),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals[[1]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals[[3]],"% variance"))

#library(gridExtra)
library(cowplot)
ggsave(PCA_Atum_1,filename= "PCA_1_2_Atum.pdf",width = 4,height = 3)
ggsave(PCA_Atum_2,filename= "PCA_1_3_Atum.pdf",width = 4,height = 3)
library(cowplot)
# adjust legend of PCA_Atum_1
merge1 <- plot_grid(PCA_Atum_1,PCA_Atum_2,ncol=2,nrow=1,rel_widths = c(2,2.5),align="v")
ggsave(merge1,filename= "PCA_1_2_1_3_Atum.pdf",width = 6,height = 3)


####################################### Admixture ############################################
# Admixture & CV plot
# https://speciationgenomics.github.io/ADMIXTURE/

setwd("E:/LiuYZ/??????/fafu/project/Admixture")
list.files()
library("scales")
library("devtools") # download addTextLabels
install_github("JosephCrispell/addTextLabels")
library(addTextLabels)

pdf("Admixture_run1_15_CV.pdf",width = 4,height = 3)
CV <- read.table("run1_15.CV.error.txt",header = F)
plot(CV$V1,CV$V2,type = "p",cex=1,pch=20,col=alpha("blue",alpha = 0.4))
addTextLabels(CV$V1,CV$V2,labels = CV$V2,cex=0.2)
dev.off()
text(CV$V1-0.4,CV$V2+0.01,labels = CV$V2,cex = 0.5)
# https://statisticsglobe.com/transparent-scatterplot-points-in-r
# make point transparency using scales package
# col = alpha(data$group, 0.5)
# add label without overlapping
# https://rdrr.io/github/JosephCrispell/basicPlotteR/man/addTextLabels.html

####################################### Fst Dxy ##############################################
library(ggplot2)
require(scales)
setwd("E:/Share/Sweden_UU/Roc_Se_bumblebee/analysis_NJ_Ne_fst_time/NJ_syl")
setwd("E:/LiuYZ/??????/fafu/project/Fst_Dxy")
list.files(pattern = "geno_csv")
fst_syl_lap <- read.csv("Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.geno_csv",header = T,na.strings = "0.00")
head(fst_syl_lap,n=1L)
fst_atum <- read.csv("merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno_csv",header = T)
#grep nan merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno_csv
#awk -F ',' '{print NF;exit}' merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno_csv

fst_atum_Na <- read.csv("merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno_csv",header = T,na.strings = "0.00")

head(fst_atum_Na,n=1L)
write.table((head(fst_atum_Na,n=2L)),"Atum_fst_Dxy_pi.2lines.txt",row.names = F,col.names = T,quote = F)
str(fst_atum_Na)

View(fst_atum_Na) # open in a file
# Fst plot distribution
a <- ggplot(fst_atum_Na,aes(x=Fst_BF_1_SA)) 
plot <- a + geom_histogram(bins=200,aes(y=stat(count)/sum(count)))+
  scale_y_continuous(labels=scales::percent)+
  labs(title="Fst distribution",x="BF1_SA, Fst per window (30Kb)",y="Frequency")+
  theme(plot.title=element_text(hjust = 0.5,vjust = 0.5))

ggsave(plot,filename = "BF1_SA Fst per window (30Kb).pdf",width = 4,height = 3)

a + geom_density()
a + geom_histogram(bins=60,aes(y=..density..))+
  geom_density(alpha=0.1,fill="green")
#  stat_count(mapping = aes(x=Fst_BF_2_GZ,y=..prop..,group=1))
#  geom_bar(aes(y = (..count..)/tapply(..count..,..PANEL..,sum)[..PANEL..]))+
  geom_bar(aes(y = (..count..)/sum(..count..)))+
  scale_y_continuous(labels = scales::percent)+
  labs(title="Fst distribution",x="Fst per window (30Kb)",y="Frequency")

# examples
set.seed(1234)
data <- data.frame(
  sex=factor(rep(c("M","F"),each=100)),
  weight=c(rnorm(200,55),rnorm(200,58))
)
head(data,4)

ggplot(data,aes(weight))+
  geom_histogram(bins=50,aes(y = ..density..), 
                 colour="black", fill="white") +
  geom_density(alpha = 0.2, fill = "#FF6666")

#### alternative ways to deal with nan ####
# https://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame
# https://www.tutorialkart.com/r-tutorial/r-dataframe-replace-na-with-0/
is.na(fst_atum$Fst_SA_TZ)
fst_atum$Fst_SA_TZ[is.na(fst_atum$Fst_SA_TZ)]=0
getOption("max.print")
options(max.print = 10000)

rm(list=ls())
getwd()
list.dirs()
dir.create("test")
file.create("test.txt")
fst_syl_lap_Na20 <- gsub("NaN",0,fst_syl_lap)

#### subset data
fst_syl_lap_inc <- fst_syl_lap[,c(1,18,19,21,22)]
fst_bal_Roc_Se <- fst_bal[,c(1,23)]
head(fst_inc_syl)
tail(fst_inc_syl)
#### reshape data ####
library(reshape2)
fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ <- fst_atum_Na[,c(1:4,7:42)]
head(fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ)
# melt data into a column
fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ_reshape <- melt(fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ,id.var=c("windowID","scaffold","start","end"))
head(fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ)
# change variable order
re_order_stats_atum <- factor(fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ$variable)
str(re_order_stats_atum)
class(re_order_stats_atum)
levels(re_order_stats_atum)
#
re_order_stats_atum <- factor(re_order_stats_atum,levels(re_order_stats_atum)[c(22:36,1:6,7:21)])
unique(re_order_stats_atum)
head(fst_atum_Na,n=1L)
#
fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ$variable <- re_order_stats_atum
levels(fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ$variable)
## ggplot facet
library(ggplot2)
# exclude some variable in facet_grid
# https://stackoverflow.com/questions/10608133/plot-only-a-select-few-facets-in-facet-grid
# facet_strip 
# https://www.datanovia.com/en/blog/how-to-change-ggplot-facet-labels/

# atum ########################
head(fst_atum_Na,n=1L)
ggplot(fst_atum_Na,aes(dxy_BF_1_GZ))+
  geom_histogram(bins=400)
## obtain mean stats
# https://www.statology.org/calculate-mean-multiple-columns-in-r/
stats <- summary(fst_atum_Na)
colMeans(fst_atum_Na[,c(7:16)])
colMeans(fst_atum_Na[sapply(fst_atum_Na, is.numeric)])

fst_pi_dxy_atum_Na_BF1_BF2_LB_GZ_SA_TZ
# p_atum_BF1_BF2
p_atum_BF1_BF2 <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                             c("pi_BF_1","pi_BF_2","dxy_BF_1_BF_2","Fst_BF_1_BF_2")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))

ggsave(p_atum_BF1_BF2,filename = "Fst_pi_Dxy_BF1_BF2.pdf",width = 6,height = 3.5)
# p_atum_BF1_GZ
p_atum_BF1_GZ <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                  c("pi_BF_1","pi_GZ","dxy_BF_1_GZ","Fst_BF_1_GZ")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF1_GZ,filename = "Fst_pi_Dxy_BF1_GZ.pdf",width = 6,height = 3.5)
# p_atum_BF1_SA
p_atum_BF1_SA <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_BF_1","pi_SA","dxy_BF_1_SA","Fst_BF_1_SA")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF1_SA,filename = "Fst_pi_Dxy_BF1_SA.pdf",width = 6,height = 3.5)

# p_atum_BF1_TZ
p_atum_BF1_TZ <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_BF_1","pi_TZ","dxy_BF_1_TZ","Fst_BF_1_TZ")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF1_TZ,filename = "Fst_pi_Dxy_BF1_TZ.pdf",width = 6,height = 3.5)
# p_atum_BF1_LB
p_atum_BF1_LB <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_BF_1","pi_LB","dxy_BF_1_LB","Fst_BF_1_LB")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF1_LB,filename = "Fst_pi_Dxy_BF1_LB.pdf",width = 6,height = 3.5)
# p_atum_BF2_LB
p_atum_BF2_LB <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_BF_2","pi_LB","dxy_BF_2_LB","Fst_BF_2_LB")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF2_LB,filename = "Fst_pi_Dxy_BF2_LB.pdf",width = 6,height = 3.5)

# p_atum_BF2_GZ
p_atum_BF2_GZ <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_BF_2","pi_GZ","dxy_BF_2_GZ","Fst_BF_2_GZ")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_BF2_GZ,filename = "Fst_pi_Dxy_BF2_GZ.pdf",width = 6,height = 3.5)

# p_atum_GZ_SA
p_atum_GZ_SA <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                 c("pi_GZ","pi_SA","dxy_GZ_SA","Fst_GZ_SA")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_GZ_SA,filename = "Fst_pi_Dxy_GZ_SA.pdf",width = 6,height = 3.5)
# p_atum_GZ_TZ
p_atum_GZ_TZ <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                c("pi_GZ","pi_TZ","dxy_GZ_TZ","Fst_GZ_TZ")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_GZ_TZ,filename = "Fst_pi_Dxy_GZ_TZ.pdf",width = 6,height = 3.5)

# p_atum_SA_TZ
p_atum_SA_TZ <- ggplot(subset(fst_pi_dxy_atum_Na_BF1_BF2_reshape,variable %in% 
                                c("pi_SA","pi_TZ","dxy_SA_TZ","Fst_SA_TZ")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.2)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))
ggsave(p_atum_SA_TZ,filename = "Fst_pi_Dxy_SA_TZ.pdf",width = 6,height = 3.5)

library(cowplot)
help(cowplot)
# adjust legend of PCA_Atum_1
merge_fst_pi_dxy <- plot_grid(p_atum_BF1_BF2,p_atum_BF1_LB,p_atum_BF1_GZ,p_atum_BF1_SA,
                    p_atum_BF2_LB,p_atum_BF2_GZ,
                    p_atum_GZ_SA,p_atum_GZ_TZ,
                    p_atum_SA_TZ,
                    ncol=1,nrow=9,align="hv")
ggsave(merge_fst_pi_dxy,filename= "merge_fst_pi_dxy_Atum_BF1_BF2_LB_GZ_SA_TZ.pdf",width = 6,height = 25)

###### false discovery rate ####
help(p.adjust)
p.adjust(c(0.003, 0.005, 0.012,0.001, 0.04, 0.058), method = 'fdr')


## 
install.packages("https://github.com/carolindahms/TreeMix/blob/main/TreeMix_functions.R",repos = NULL,type = "source")
library(RColorBrewer)
install.packages("R.utils")
library(R.utils)
source("E:/LiuYZ/??????/fafu/project/treemix/treemix-1.13/treemix-1.13/src/plotting_funcs.R")
getwd()
setwd("E:/LiuYZ/??????/fafu/project/treemix/treemix_test_files/Atum")
setwd("E:/Share/Sweden_UU/Roc_Se_bumblebee/treemix/")
plot_tree('syl_inc_lap_mon.out.0',cex=0.8)
plot_tree(paste0("syl_inc_lap_mon.out.",0),cex=0.8)
plot_tree('out_stem_root_boot_mig6',cex=0.8)

par(mfrow=c(2:3))
#dev.off()
for (edge in 0:5){
  plot_tree(paste0("syl_inc_lap_mon.N08_plinkLD01.",edge),disp = 0.001,plus = 0.01, cex=0.9,font = 0.9,ybar = 0.1,arrow = 0.06)
  title(paste0("syl_inc_lap_mon.N08_plinkLD01.",edge))
}

for (edge in 0:5){
  plot_resid(stem=paste0("syl_inc_lap_mon.N08_plinkLD01.",edge),pop_order = "pop_order.list",
             cex=0.6)
}

"pop_order.list"
sylvicola
incognitus
lapponicus
monticola

for (edge in 0:5){
  plot_resid(stem=paste0("syl_inc_lap_mon.out.",edge),pop_order = "pop_order.list")
}



# msmc2
setwd("E:/Share/Sweden_UU/Roc_Se_bumblebee/msmc/results")
list.files(pattern = "^cross.*contig_001_592*")
list.files(pattern = "^mon.*final.txt")

mu <- 3.60e-9
gen <- 1
monDat1<-read.table("mon_12hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592.final.txt", header=TRUE)
monDat2<-read.table("mon_4hap_out_prefix.final.txt", header=TRUE)
monDat3<-read.table("mon_12hap_out_prefix.mon6_lap6_inc5_syl4.final.txt", header=TRUE)

## combine bootstrap data and get median data
monData_combined <- rbind(monDat1,monDat2,monDat3)
print("ni hao")
class(monData_combined)
str(monData_combined)
monData_combined[monData_combined$time_index >= 1 & monData_combined$time_index <= 4,]

# https://stackoverflow.com/questions/4737753/calculate-average-over-multiple-data-frames
library(plyr); library(dplyr)
monData_combined_median <- ddply(monData_combined,.(time_index),colwise(median,.(left_time_boundary,right_time_boundary,lambda)))
head(monData_combined_median)

#
install.packages("abind")
x <- matrix(1:12,3,4)
y <- x+100; z= y-50
apply(abind::abind(x,y,z, along=3),  1:2, mean)

getwd()
# E:/Share/Sweden_UU/Roc_Se_bumblebee/msmc/bootstrap/out_dir_prefix_1/
setwd("../bootstrap/out_dir_prefix_1/")
setwd("../../results")
file_list <- list.files(pattern = "*chr[0-9]?[0-9].txt")
file_list <- list.files(pattern = "*chr[0-3].txt")
file_list <- list.files(pattern = ".*combined.msmc2.contig_001_592.final.txt")
# read multiple files
# https://stackoverflow.com/questions/2104483/how-to-read-table-multiple-files-into-a-single-table-in-r
# https://stackoverflow.com/questions/31169247/read-table-to-read-multiple-files-from-the-directory-in-r
library(tidyverse)
df <- list.files(pattern = "*chr[0-3].txt") %>% 
  map(read.table) %>%
  bind_rows()

frames <- list.files(pattern = "*chr[0-3].txt",full.names = T)
combined_frames <- do.call(rbind,lapply(frames,read.table,sep="\t"))
tail(combined_frames)

DF <- NULL
for (file in file_list){
  dat <- read.table(file,header = T,sep = "\t")
  DF <- rbind(DF,dat)
}
DF
DF$group <- rep(1:3,each=32)
# change order of columns
# https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame
DF[,c(1,2,3,4,5,6,7)]
new_DF <- DF[,c(7,1,2,3,4,5,6)]
library(ggplot2)
head(new_DF$group)
str(new_DF$group)
# https://stackoverflow.com/questions/31165015/how-to-convert-integer-to-factor
# http://www.sthda.com/english/wiki/ggplot2-line-plot-quick-start-guide-r-software-and-data-visualization
# https://stackoverflow.com/questions/43754928/multiple-lines-plot-using-multiple-groups-in-data 
new_DF[,'group'] <- factor(new_DF[,'group'])
# new_DF[,left_time_boundary := factor(rowid(group))]
ggplot(new_DF,aes(left_time_boundary/mu*gen, (1/lambda_00)/(2*mu),group=group))+
  geom_step(aes(color=group))

###
plot(new_DF$left_time_boundary/mu*gen, (1/new_DF$lambda00)/(2*mu), log="x",ylim=c(0,700000),
     type="n", col = factor(new_DF$group),xlab="Years ago", ylab="Effective population size (Ne)")
lines(new_DF$left_time_boundary/mu*gen, (1/new_DF$lambda00)/(2*mu), type="s", col="#CC6677")


#########
# msmc2
setwd("E:/Share/Sweden_UU/Roc_Se_bumblebee/msmc/results")
mu <- 3.60e-9
gen <- 1
monDat<-read.table("mon_12hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592.final.txt", header=TRUE)
lapDat<-read.table("lap_12hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592.final.txt", header=TRUE)
sylDat<-read.table("syl_8hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592.final.txt", header=TRUE)
incDat<-read.table("inc_10hap_out_prefix.mon6_lap6_inc5_syl4.contig_001_592.final.txt", header=TRUE)
cross_12lap_8syl<-read.table("cross_12lap_8syl_96hap_out_prefix.mon6_lap6_inc5_syl4.final.txt", header=TRUE)
cross_10inc_8syl_80hap<-read.table("cross_10inc_8syl_80hap_out_prefix.mon6_lap6_inc5_syl4.final.txt", header=TRUE)
cross_12lap_10inc_80hap<-read.table("cross_12lap_10inc_120hap_out_prefix.mon6_lap6_inc5_syl4.final.txt", header=TRUE)

# combined cross pop
combined_inc_syl<-read.table("inc_syl.combined.msmc2.final.txt", header=TRUE)
# all contigs
combined_inc_syl<-read.table("inc_syl.combined.msmc2.contig_001_592.final.txt", header=TRUE)
combined_lap_syl<-read.table("lap_syl.combined.msmc2.contig_001_592.final.txt", header=TRUE)
combined_lap_inc<-read.table("lap_inc.combined.msmc2.contig_001_592.final.txt", header=TRUE)

plot(monDat$left_time_boundary/mu*gen, (1/monDat$lambda)/(2*mu), log="x",ylim=c(1,700000),xlim = c(100,10000000),
     type="n", xlab="Years ago", ylab="Effective population size (Ne)")
lines(monDat$left_time_boundary/mu*gen, (1/monDat$lambda)/(2*mu), type="s", col="#CC6677")
lines(lapDat$left_time_boundary/mu*gen, (1/lapDat$lambda)/(2*mu), type="s", col="blue")
lines(sylDat$left_time_boundary/mu*gen, (1/sylDat$lambda)/(2*mu), type="s", col="#009988")
lines(incDat$left_time_boundary/mu*gen, (1/incDat$lambda)/(2*mu), type="s", col="magenta")

#lines(cross_12lap_8syl$left_time_boundary/mu*gen, (1/cross_12lap_8syl$lambda)/(2*mu), type="s", col="orange")
#lines(cross_10inc_8syl_80hap$left_time_boundary/mu*gen, (1/cross_10inc_8syl_80hap$lambda)/(2*mu), type="s", col="#DDCC77")
#lines(cross_12lap_10inc_80hap$left_time_boundary/mu*gen, (1/cross_12lap_10inc_80hap$lambda)/(2*mu), type="s", col="#999933")

legend("topright",cex = 0.8,legend=c("monticola", "lapponica","sylvicola","incognitus"), 
       col=c("#CC6677", "blue","#009988","magenta"), lty=c(1,1))

#legend("topright",cex = 0.5,legend=c("monticola", "lapponica","sylvicola","incognitus","lap_syl","inc_syl","lap_inc"), 
#       col=c("#CC6677", "blue","#009988","magenta","orange","#DDCC77","#999933"), lty=c(1,1))

# combined cross pop
# xlim=c(100,5000000)
plot(combined_inc_syl$left_time_boundary/mu*gen, 2 * combined_inc_syl$lambda_01 / (combined_inc_syl$lambda_00 + combined_inc_syl$lambda_11),
     xlim=c(100,6000000),ylim=c(0,1), type="n", xlab="Years ago", ylab="relative cross-coalescence rate")
lines(combined_inc_syl$left_time_boundary/mu*gen, 2 * combined_inc_syl$lambda_01 / (combined_inc_syl$lambda_00 + combined_inc_syl$lambda_11), type="s",col="orange")
lines(combined_lap_syl$left_time_boundary/mu*gen, 2 * combined_lap_syl$lambda_01 / (combined_lap_syl$lambda_00 + combined_lap_syl$lambda_11), type="s",col="blue")
lines(combined_lap_inc$left_time_boundary/mu*gen, 2 * combined_lap_inc$lambda_01 / (combined_lap_inc$lambda_00 + combined_lap_inc$lambda_11), type="s",col="red")
legend("topright",cex = 0.8,legend=c("inc_syl", "lap_syl","lap_inc"), 
#       col=c("orange","#117733","882255"), lty=c(1,1))
        col=c("orange","blue","red"), lty=c(1,1))
abline(h=0.5,col='black',lty=c(2,1))

## combine two plot for two dataset in ggplot
# https://www.geeksforgeeks.org/combine-two-ggplot2-plots-from-different-dataframe-in-r/
data1 <- data.frame(xdf1 = rnorm(50),
                    ydf1 = rnorm(50))
data2 <- data.frame(xdf2 = rnorm(50),
                    ydf2 = rnorm(50))

library(ggplot2)
# https://stackoverflow.com/questions/63332415/manually-create-ggplot-legend-when-plot-built-from-two-data-frames
#*key*#
#*# https://stackoverflow.com/questions/71771135/adding-a-legend-in-ggplot-with-multiple-datasets
## colors <- c("df1"="orange","df2"="red")
# https://community.rstudio.com/t/adding-manual-legend-to-ggplot2/41651/3
ggplot()+
  geom_point(data = data1,aes(xdf1,ydf1,color="df1"),fill="orange",
             size=3,shape=21)+
  geom_point(data = data2,aes(xdf2,ydf2,color="df2"),fill="red",
             size=3,shape=21)+
  labs(x="X-Data",y="Y-Data")+
  ggtitle("Combined Plot")+
##  scale_colour_manual(values = c("data1"="orange", "data2"="red"))
  scale_color_manual(name="DataSet", values = c("black","black")) +
  guides(colour = guide_legend(override.aes = list(pch = 21, fill = c('orange','red'))))


