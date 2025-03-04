
################# import Fst data ###############
sylv_inco_20kb_fst <- read.table("sylv_inco_20kb.windowed.weir.fst.genome_coords.txt", header = TRUE, sep = "\t")
bifa_vanco_20kb_fst <- read.table("bifa_vanco_20kb.windowed.weir.fst.genome_coords.txt", header = TRUE, sep = "\t")

head(sylv_inco_20kb_fst)
tail(sylv_inco_20kb_fst)

head(bifa_vanco_20kb_fst)

barplot(sylv_inco_20kb_fst$MEAN_FST)

library(ggplot2)
p_density <- ggplot(sylv_inco_20kb_fst,aes(x=WEIGHTED_FST)) +
  geom_density() +
  geom_vline(aes(xintercept=median(WEIGHTED_FST)),
             color="blue",linetype="dashed", size=1) # use median or mean
p_density

#### sylv_inco histogram ####################### better
# sylv_inco mean Fst
sylv_inco_20kb_fst_histogram <- ggplot(sylv_inco_20kb_fst,aes(x=WEIGHTED_FST)) +
  geom_histogram(aes(y=stat(count)/sum(count)),fill="darkcyan", color="darkcyan", size=0.01, bins = 600,show.legend = FALSE)+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(labels = scales::percent,expand = c(0,0))+
  coord_cartesian(xlim = c(0,1))+
  scale_color_manual(values = "darkorchid")+
  labs(x="WEIGHTED_FST",y="Frequency",
       title="Distributtion of WEIGHTED_FST",
       subtitle = "Bombus sylvicola_Bombus incognitus")+
  theme_classic()+
  theme(title = element_text(size = 11, family = "sans"),
        plot.title = element_text(hjust = 0.8, vjust = -20),
        plot.subtitle = element_text(hjust = 0.8, vjust = -24),
        axis.text= element_text(size=10, colour = "black"),
        axis.title = element_text(size=11, colour = "black", face = "bold"),
        axis.line = element_line(colour = "black", size = 0.5, linetype = "solid"),
        axis.ticks = element_line(colour = "black",size = 1))+
  theme(plot.margin = unit(c(1,1,1,1),"cm"))
sylv_inco_20kb_fst_histogram
# change title and subtitle: https://www.datanovia.com/en/blog/ggplot-title-subtitle-and-caption/

################################################################
##### geom_histogram: bifa_vanco_20kb_fst mean Fst #### axis without expand
bifa_vanco_20kb_fst_histogram <- ggplot(bifa_vanco_20kb_fst,aes(x=WEIGHTED_FST)) +
  geom_histogram(aes(y=stat(count)/sum(count)),fill="darkorange", color="darkorange", size=0.01, bins = 300,show.legend = FALSE)+
  scale_x_continuous(expand = c(0,0))+
  scale_y_continuous(labels = scales::percent,expand = c(0,0))+
  coord_cartesian(xlim = c(0,1))+
  scale_color_manual(values = "darkorchid")+
  labs(x="WEIGHTED_FST",y="Frequency",
       title="Distributtion of bifa_vanco_20kb_WEIGHTED_FST")+
  theme_classic()+
  theme(title = element_text(size = 8, family = "Impact"), 
        plot.title = element_text(hjust = 0.5, vjust = -20), axis.text= element_text(size=10, colour = "black"),
        axis.title = element_text(size=11, colour = "black", face = "bold"),
        axis.line = element_line(colour = "black", size = 0.5, linetype = "solid"),
        axis.ticks = element_line(colour = "black",size = 1))+
  theme(plot.margin = unit(c(1,1,1,1),"cm"))
bifa_vanco_20kb_fst_histogram

pdf("bifa_vanco_20kb_fst_histogram.pdf", file = "E:/Share", width = 6, height = 6, family = "Times") # Apply pdf function
pdf()
bifa_vanco_20kb_fst_histogram
dev.off()
###############################################
# format tick mark label (scientific notation, percentage...) # http://www.sthda.com/english/wiki/ggplot2-axis-ticks-a-guide-to-customize-tick-marks-and-labels
library(scales)
### theme(axis.title.x = element_text(color = 'blue', family = 'Arial',
face = 'bold', size = 8, hjust = 0.5, angle = 15),legend.title=element_text(size=30))
# change default font
# https://stackoverflow.com/questions/34636079/change-default-font-in-ggplot2
theme_gray(base_family = "serif")

# weighted Fst
p_histogram <- ggplot(sylv_inco_20kb_fst,aes(x=WEIGHTED_FST)) +
  geom_histogram(aes(y=stat(count)/sum(count)),bins = 300)+
  scale_y_continuous(labels = scales::percent)
  
  geom_vline(aes(xintercept=median(WEIGHTED_FST)),
             color="blue",linetype="dashed", size=1) # that paper used WEIGHTED_FST values
p_histogram


p_freqpoly <- ggplot(sylv_inco_20kb_fst,aes(x=WEIGHTED_FST)) +
  geom_freqpoly()
   # that paper used WEIGHTED_FST values

############################ z_score #########################
Z_score_fst <- (sylv_inco_20kb_fst$WEIGHTED_FST-median(sylv_inco_20kb_fst$WEIGHTED_FST))/sd(sylv_inco_20kb_fst$WEIGHTED_FST)
head(Z_score_fst,n=20)

#### change row name
colnames(Z_score_fst) <- c(Zfst)
names(Z_score_fst)[1] <- paste("Zfst")
Z_score_fst_frame <- data.frame(Z_score_fst)
names(Z_score_fst_frame)[1] <- paste("Zfst") # c("Zfst")
test <- head(Z_score_fst_frame)
test
names(test)[names(test)=="Zfst"] <- "Gen_mid"
names(test)[1] <- "__Gen_mid"
colnames(test) <- "gen_mid"
rownames(test) <- c("a", "b", "c", "d", "e", "f")
test


sylv_inco_20kb_fst_zfst <- cbind(sylv_inco_20kb_fst, Z_score_fst_frame)
head(sylv_inco_20kb_fst_zfst)
tail(sylv_inco_20kb_fst_zfst)

Bs_Bi_high_FST <- sylv_inco_20kb_fst_zfst$Zfst >= 2
head(Bs_Bi_high_FST)


Bs_Bi_high_fst <- Z_score_fst >= 2
str(Bs_Bi_high_fst)
head(Bs_Bi_high_fst, n=20)

BsBi_fst_outliers <- subset(Z_score_fst, Z_score_fst >= 2)
head(BsBi_fst_outliers, n=20)

sylv_inco_20kb_fst_zscore <- cbind(sylv_inco_20kb_fst,Z_score_fst)
head(sylv_inco_20kb_fst_zscore)

barplot(sylv_inco_20kb_fst_zscore$Z_score_fst)

# density plot
p <- ggplot(sylv_inco_20kb_fst_zscore,aes(x=Z_score_fst)) +
  geom_histogram(aes(y=..density..),fill="orchid",bins = 500)+
  geom_density() +
  geom_vline(aes(xintercept=median(Z_score_fst)),
             color="blue",linetype="dashed", size=1) # use median or mean
p
# point plot
p <- ggplot(sylv_inco_20kb_fst_zscore,aes(x=GEN_START, y=Z_score_fst)) +
  geom_point(size=0.2) +
  geom_hline(yintercept = 2)
p

##### variants_high_fst_rm_nan_contig_069_240001_260000.txt
##### variants_high_fst_contig_069_620001_640000.txt

contig_069_fst <- read.table("variants_high_fst_contig_069_620001_640000.txt", header = F, sep = "\t")
head(contig_069_fst)
plot_069_fst <- ggplot(contig_069_fst, aes(x=V3, y=V4))+
  geom_point(size=0.1)+
  labs(x = "Genome position (Mbp)", y = "FST (B. sylvicola_B. incognitus)")+
  scale_x_continuous(labels=c("212130000"="212.130", "212135000"="212.135", "212140000"="212.140", "212145000"="212.145", "212150000"="212.150"))+
  theme_bw()+
  theme(axis.title.x = element_text(vjust = -1),
        axis.title.y = element_text(vjust = 3),
        plot.margin = unit(c(1,1,1,1), "cm"))
# labels=c("211750000"="211.75", "211755000"="211.755", "211760000"="211.76", "211765000"="211.765", "211770000"="211.77")
plot_069_fst

#### 
ggplot(contig_069_fst, aes(x=V4))+
  geom_histogram(bins = 40)+
  labs(x = "FST (B. sylvicola_B. incognitus)", y = "Count")+
  theme_bw()+
  theme(plot.margin = unit(c(1,1,1,1),"cm"))


setwd("E:/Share/Sweden_UU")
getwd()

df1 = data.frame(CustomerId = c(1:6), Product = c(rep("Toaster", 3), rep("Radio", 3)))
df2 = data.frame(CustomerId = c(2, 4, 6), State = c(rep("Alabama", 2), rep("Ohio", 1)))
d <- merge(x=df1, y=df2, by= "CustomerId", all.y = TRUE)
d


library(ggplot2)
library(reshape2)
library(tidyverse) # creat index
merged_fst_gc_repeat_mappability <- read.table("20kb_window_fst_gc_repeat_mappability_merge_new_sorted_header_1.txt", header = T)
#View(merged_fst_gc_repeat_mappability)
head(merged_fst_gc_repeat_mappability)
str(merged_fst_gc_repeat_mappability)

d_merged = merged_fst_gc_repeat_mappability
head(d_merged)
str(d_merged)
summary(d_merged)
fst <- as.numeric(d_merged$WEIGHTED_FST_D)
str(fst)
summary(fst)
mean(fst, na.rm = T) # 0.4073483
median(fst, na.rm = T) # 0.286907
summary(fst) # 1st Qu. = 0.2119

gc <- as.numeric(d_merged$GC_prop_A)
mean(gc, na.rm = T) # 0.382601
median(gc, na.rm = T) # 0.3811
summary(gc) # 1st Qu. = 0.3512

repeat_content <- as.numeric(d_merged$Prop_repeat_A)
mean(repeat_content, na.rm = T) # 0.1688578
median(repeat_content, na.rm = T) # 0.0941
summary(repeat_content) # 1st Qu. = 0.0523

mappability <- as.numeric(d_merged$Mappability_D)
mean(mappability, na.rm = T) # 0.953436
median(mappability, na.rm = T) # 1
summary(mappability) # 1st Qu. = 0.9925734

d_merged <- tibble::rowid_to_column(d_merged, "index") # creat and add index column to dataframe
# https://www.statology.org/add-index-column-to-data-frame-r/

#Basic R plot
# https://r-coder.com/plot-r/#R_plot_color
plot(d_merged$index, d_merged$WEIGHTED_FST_D, type = "p", col="red", pch = 20, cex = 0.001, xlab = "20kb_window_FST_order_index", ylab = "Factors")
lines(d_merged$index, d_merged$GC_prop_A, type = "l", col = "orange", lwd = 0.2)
lines(d_merged$index, d_merged$Prop_repeat_A, type = "l", col = "black", lwd = 0.2)
lines(d_merged$index, d_merged$Mappability_D, type = "l", col = "green", lwd = 0.2)
legend("top", legend = c("FST", "GC", "Repeat", "Mappability"),
       lwd = 0.1, cex = 0.3, col = c("red", "orange","black","green"))
#lines(d_merged$index, d_merged$Mappability_D, type = "l", col = "green", lwd = 0.2)
#points(d_merged$index, d_merged$GC_prop_A, type = "p", col = "orange", pch = 20, cex = 0.001)
#points(d_merged$index, d_merged$Prop_repeat_A, type = "p", col = "black", pch = 20, cex = 0.001)
#points(d_merged$index, d_merged$Mappability_D, type = "p", col = "green", pch = 20, cex = 0.001)

# ggpolt: https://statisticsglobe.com/plot-all-columns-of-data-frame-in-r

d_merged <- melt(d_merged, id.vars = "index", variable.name = "Series")
ggplot(d_merged, aes(index, value)) +
  geom_line(aes(color = Series))


#### Analysis barplot ####
list.files()
data_het <- read.table("mon_80_Abisko_64_Jämtland_Härjedalen_16.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_3134Excesshet_3.missing05.Real.hap2dip.het",header = T, sep = "\t")
head(data_het)
data_het(data_het$F==1)

pdf("B.pas_het.pdf",width=8, height=6)
# barplot label angle:https://stackoverflow.com/questions/10286473/rotating-x-axis-labels-in-r-for-barplot
# https://www.r-graph-gallery.com/210-custom-barplot-layout.html
# https://www.r-graph-gallery.com/209-the-options-of-barplot.html
# http://www.sthda.com/english/wiki/add-titles-to-a-plot-in-r-software
# make part of axis label italic: https://www.statology.org/italics-in-r/
# https://stackoverflow.com/questions/23969726/italics-and-normal-text-in-a-main-plot-title
# https://stackoverflow.com/questions/32555531/how-to-italicize-part-one-or-two-words-of-an-axis-title
barplot(data_het$O.E.het.,names.arg = data_het$INDV, 
        xlab=substitute(paste('Individual (',italic('Bombus pascuorum'),')')),
        ylab = "Heterozygosity", cex.lab=0.8,
        col = "gray", col.axis="black", space = 0,
        cex.names = 0.5,cex.axis = 0.6, las=2)
#axis(0.1)
#  width = 0.8, xlim = c(0,55),font.axis=2
dev.off()

#### ggplot geom_hist ####
#### italic #### https://www.tutorialspoint.com/how-to-write-partial-title-of-x-axis-in-italics-using-ggplot2-of-r
library(ggplot2)
head(data_het)
het_histgram <- ggplot(data_het,aes(x=INDV,y=O.E.het.))+
  geom_bar(stat="identity",col="black",fill="gray",size=0.2)+
  labs(x=expression(paste("Individuals (",italic("Bombus pascuorum"),")")),y="Heterozygosity")+
  theme_classic()+
  theme(axis.text = element_text(colour = "black"),
        axis.text.x = element_text(size=7,angle = 80,vjust = 0,hjust = 0),
        axis.title.x = element_text(margin = margin(t=10)),
        axis.title.y = element_text(margin = margin(r=10)),
        axis.line = element_line(size = 0.2),
        axis.ticks = element_line(size = 0.2))+
  theme(plot.margin = unit(c(1,1,1,1),"cm"))

ggsave(het_histgram, file = "histogram_het_B.pas.pdf",width = 6,height = 4)

# dev.off()

#############################################################################
#### het ####
list.files()
lsfile <- file.info(dir(pattern = "O_E"))
lsfile[order(lsfile$mtime)]

het_10hyper <- read.table("B_bal.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.hyp_10.filter_real_non_var_missing05.het",header = T,sep = "\t")
head(het_10hyper)
het_10hyper$F[het_10hyper$F < 0] <- 0
het_10hyper$het <- 1 -het_10hyper$F

het_43balteatus <- read.table("B_bal.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.bal_43.filter_non_var_missing05.hap2dip.het",header = T,sep = "\t")
head(het_43balteatus)
het_43balteatus$F[het_43balteatus$F < 0] <- 0
het_43balteatus$het <- 1 -het_43balteatus$F

het_6polaris <- read.table("B_bal.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.pol_6.filter_real_non_var_missing05.het",header = T,sep = "\t")
head(het_6polaris)
het_6polaris$F[het_6polaris$F < 0] <- 0
het_6polaris$het <- 1 -het_6polaris$F

het_12alpinus <- read.table("B_bal.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.alp_12.filter_real_non_var_missing05.het",header = T,sep = "\t")
head(het_12alpinus_polaris_2)
head(het_12alpinus)
het_12alpinus$F[het_12alpinus$F < 0] <- 0
het_12alpinus$het <- 1 -het_12alpinus$F

het_79monticola <- read.table("mon_79_Abisko_63_Jämtland_Härjedalen_16.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_3134Excesshet_3.missing05.Real.hap2dip.het",header = T,sep = "\t")
head(het_79monticola)
het_79monticola$F[het_79monticola$F < 0] <- 0
het_79monticola$het <- 1 -het_79monticola$F
str(het_79monticola)

het_128lapponicus <- read.table("lap_128_Abisko_109_Jämtland_Härjedalen_19.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_3134Excesshet_3.missing05.Real.hap2dip.het",header = T,sep = "\t")
head(het_128lapponicus)
het_128lapponicus$F[het_128lapponicus$F < 0] <- 0
het_128lapponicus$het <- 1 -het_128lapponicus$F
str(het_128lapponicus)

het_10hyper$Group=rep("B. hyperboreus",10)
het_43balteatus$Group=rep("B. balteatus",43)
het_6polaris$Group=rep("B. polaris",6)
het_12alpinus$Group=rep("B. alpinus",12)

het_79monticola$Group=rep("B. monticola",79)
het_128lapponicus$Group=rep("B. lapponicus",128)

het_merged_balteatus <- rbind(het_10hyper,het_6polaris,het_12alpinus,het_43balteatus)
het_merged_79montonicus_128lapponicus_sylvicola <- rbind(het_79monticola,het_128lapponicus)
head(het_merged_balteatus)
show(het_merged_balteatus)
head(het_merged_79montonicus_128lapponicus_sylvicola)
show(het_merged_79montonicus_128lapponicus_sylvicola)

getwd()
write.table(het_merged_balteatus,file = "E:/Share/Sweden_UU/SW_mountain_bee/analysis/het/het_merged_balteatus.phased.txt",
            row.names = F,quote = F,sep = "\t")
write.table(het_merged_79montonicus_128lapponicus_sylvicola,file = "E:/Share/Sweden_UU/SW_mountain_bee/analysis/het/remove_heterozygous_sites_male_female_79monticola_128lapponicus_B_syl.gzvcf.het.txt",
            row.names = F,quote = F,sep = "\t")

het_merged_balteatus <- read.table("het_merged_balteatus.txt",header = T,sep = "\t")
head(het_merged_balteatus)

library(ggplot2)
library(tidyverse) # for not sort x axis labels # https://stackoverflow.com/questions/20041136/avoid-ggplot-sorting-the-x-axis-while-plotting-geom-bar
# scale_x_discrete(limits=het_merged_balteatus$INDV)+
# x=fct_inorder(INDV)
# plot by group
# https://www.r-graph-gallery.com/48-grouped-barplot-with-ggplot2.html
merged_het_plot1 <- ggplot(het_merged_79montonicus_128lapponicus_sylvicola,aes(x=fct_inorder(INDV),y=het,fill=Group))+
  geom_bar(stat = "identity",position="dodge",size=0.2,col="black",width = 1)+
  theme_classic()+
  labs(x=expression(paste("Individuals")),y="Heterozygosity")+
#   labs(x=expression(paste("Individuals (",italic("Bombus sylvicola")," Ref.)")),y="Heterozygosity (O/E)")+
  theme(axis.text.x = element_text(angle = 80,color="black",size = 2,vjust = 0,hjust = 0),
        axis.text.y = element_text(colour = "black",size = 7),
        axis.line = element_line(size = 0.2),
        axis.ticks = element_line(size = 0.2),
        legend.position = "top",legend.text = element_text(size=6),
        plot.margin = unit(c(1,1,1,1),"cm"))

ggsave(merged_het_plot1, file = "merged_het_grouped_plot.Bmon_lap.pdf",width = 6,height = 4)

#### modify strip #### 
# https://statisticsglobe.com/change-font-size-of-ggplot2-facet-grid-labels-in-r
# https://datavizpyr.com/how-to-remove-facet_wrap-title-box-in-ggplot2/
# strip.background = element_blank()
# strip.background = element_rect(fill = "white")
# https://datavizpyr.com/how-to-change-facet_wrap-box-color-in-ggplot2/
# use different font size: https://stackoverflow.com/questions/36334486/how-to-use-different-font-sizes-in-ggplot-facet-wrap-labels
merged_het_plot2 <- ggplot(het_merged_79montonicus_128lapponicus_sylvicola,aes(x=fct_inorder(INDV),y=het,fill=Group))+
  geom_bar(stat = "identity",position="dodge",size=0.2,col="black",width = 1)+
  theme_classic()+
  scale_y_continuous(labels = scales::percent,expand = c(0,0))+
  labs(x=expression(paste("Individuals")),y="Heterozygosity")+
#  labs(x=expression(paste("Individuals (Ref. ",italic("Bombus sylvicola"),")")),y="Heterozygosity (O/E)")+
  theme(axis.text.x = element_text(angle = 90,color="black",size = 2,vjust = 0,hjust = 0),
        axis.text.y = element_text(colour = "black",size = 7),
        axis.line = element_line(size = 0.2),
        axis.ticks = element_line(size = 0.2),
        legend.position="none",
        plot.margin = unit(c(1,1,1,1),"cm"),
        strip.placement = "outside",
        strip.background = element_blank(),
        strip.text.x = element_text(size = c(8,4,5,5),face = "italic"),
        panel.spacing = unit(0, units = "cm"))+
  facet_grid(~Group,
             scales = "free_x",
             space = "free_x",
             switch = "x")  
# scale_x_continuous(expand = c(0,0))+
ggsave(merged_het_plot2, file = "merged_het_grouped_plot.Bmon_lap_not_sort_x.pdf",width = 6,height = 4)

# bal
merged_het_plot_bal <- ggplot(het_merged_balteatus,aes(x=fct_inorder(INDV),y=het,fill=Group))+
  geom_bar(stat = "identity",position="dodge",size=0.2,col="black",width = 1)+
  theme_classic()+
  scale_y_continuous(labels = scales::percent,expand = c(0,0))+
  labs(x=expression(paste("Individuals")),y="Heterozygosity")+
  #  labs(x=expression(paste("Individuals (Ref. ",italic("Bombus sylvicola"),")")),y="Heterozygosity (O/E)")+
  theme(axis.text.x = element_text(angle = 90,color="black",size = 5,vjust = 0.3),
        axis.text.y = element_text(colour = "black",size = 7),
        axis.line = element_line(size = 0.2),
        axis.ticks = element_line(size = 0.2),
        legend.position="none",
        plot.margin = unit(c(1,1,1,1),"cm"),
        strip.placement = "outside",
        strip.background = element_blank(),
        strip.text.x = element_text(size = 6,face = "italic"),
        panel.spacing = unit(0, units = "cm"))+
  facet_grid(~Group,
             scales = "free_x",
             space = "free_x",
             switch = "x")  
# scale_x_continuous(expand = c(0,0))+
ggsave(merged_het_plot_bal, file = "merged_het_grouped_plot.Bbal_hyp_pol_alp.not_sort_x.pdf",width = 6,height = 4)


#### sort file list ####
# https://stat.ethz.ch/pipermail/r-help/2008-January/152146.html
# https://stackoverflow.com/questions/13762224/how-to-sort-files-list-by-date
list.files(full.names = T,pattern = "^B.pas")
list.files(full.names = T,pattern = "^[B.pas]")
list.files(pattern = "B.pas")
dir(pattern = "^B.pas")
file.info(dir())
file.info(dir(pattern = "^B.pas"))
lsfile <- file.info(dir(pattern = "syl"))
lsfile[order(lsfile$mtime),]

# Grouped
ggplot(data, aes(fill=specie, y=value, x=condition)) + 
  geom_bar(position="dodge", stat="identity")




#### PCA ####
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/pca")
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
dfile <- file.info(dir(pattern = "eigenvec$"),extra_cols = F)
dfile[order(dfile$mtime),]

dfile <- dfile[with(dfile,order(as.POSIXct(mtime))),]
files = rownames(dfile)



df <- read.delim("B.pas_bcftools_SNP_biallelic_no_filter_concat_phased.pca.eigenvec.group",sep = "\t")
head(df$Group)
head(df)
eigen_val <- read.delim("B.pas_bcftools_SNP_biallelic_no_filter_concat_phased.pca.eigenval",header = F,sep = "\t")
sum_eigen_val <- sum(eigen_val$V1)
sum_eigen_vals <- lapply(eigen_val$V1,function(x){
  rt <- (x/sum_eigen_val)*100
  rt <- round(rt)
  return(rt)
})

pca_pas <- ggplot(df, aes(PC1,PC2,color=Group))+
  geom_point(size=0.1,alpha = 3/4)+
  theme_classic()+
  theme(legend.position = "top" )+
  xlab(paste0("PC1: ",sum_eigen_vals[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals[[2]],"% variance"))+
  geom_text_repel(aes(label=IID),size=1,
                  segment.size=0.1,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

ggsave(pca_pas,filename= "pac_PC1_PC2_pas.pdf",width = 6,height = 4)

#  segment.color = "grey50",
# ,color=Group)
# geom_point(aes(shape=factor(Group)), size=2,alpha = 1/2)+
# geom_point(aes(color=Group))+

#### pca plots for Arctic bumblebees ##### 
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/pca")
df1 <- read.delim("Bpas_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.vcf2plink.new.pca.eigenvec",sep = " ",header = F)
df1 <- read.delim("Bpas_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.vcf2plink.new_rmDA_02.pca.eigenvec",sep = " ",header = F)

df2 <- read.delim("Bsyl_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excesshet_3.vcf2plink.new.pca.eigenvec",sep = " ",header = F)
df2_lap <- read.delim("lap_128_Abisko_109_Jämtland_Härjedalen_19.pca.eigenvec",header = F,sep = " ")
df2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.pca.eigenvec",header = F,sep = " ")
df2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210.pca.eigenvec",header = F,sep = " ")
df2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211.pca.eigenvec",header = F,sep = " ")
df2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211_007.pca.eigenvec",header = F,sep = " ")
df2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211_007_004_BH_03.pca.eigenvec",header = F,sep = " ")

df3 <- read.delim("Bbal_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.vcf2plink.new.pca.eigenvec",sep = " ",header = F)
df3_bal <- read.delim("sample_balteatus_43.pca.eigenvec",header = F,sep = " ")
df3_hyp <- read.delim("subset_10hyperboreus.pca.eigenvec",header = F,sep = " ")
df3_alp <- read.delim("subset_12alpinus_2.pca.eigenvec",header = F,sep = " ")
df3_pol <- read.delim("subset_6polaris_1.pca.eigenvec",header = F,sep = " ")

head(df$Group)
head(df1)
head(df2)
head(df3_pol)
library(stringr)
library(stringi)
df1_new <- gsub("DA.*","DA",df1$V2)
#### replace string ####
#https://www.statology.org/r-gsub-multiple-patterns/
df1$V2 <- stri_replace_all_regex(df1$V2,
                                  pattern = c("DA.*","GT.*","M_L.*","SS.*","SL.*","NS.*"),
                                  replacement = c("Uppsala/Dalarna","Gotland","Abisko","Västergötland","Ammarnäs","Härjedalen/Umeå"),
                                  vectorize=F)

#### prepared in excel; strange------have to substitute twice

df2$V2 <- stri_replace_all_regex(df2$V2,
                                     pattern = c("M_L008","M_L057","M_L071","M_L072","M_L074","M_L076","M_L077","M_L081","M_L082","M_L083","M_L084","M_L086","M_L087","M_L088","M_L090","M_L091","M_L092","M_L095","M_L109","M_L110","M_L111","M_L112","M_L113","M_L114","M_L115","M_L116","M_L117","M_L120","M_L121","M_L122","M_L123","M_L124","M_L125","M_L127","M_L139","M_L144","M_L145","M_L148","M_L154","M_L157","M_L171","M_L173","M_L174","M_L175","M_L176","M_L183","M_L184","M_L185","M_L186","M_L187","M_L193","M_L199","M_L200","M_L215","M_L216","M_L226","M_L002","M_L003","M_L005","M_L009","M_L012","M_L014","M_L018","M_L021","M_L028","M_L030","M_L043","M_L046","M_L060","M_L061","M_L085","M_L089","M_L096","M_L097","M_L099","M_L100","M_L135","M_L138","M_L141","M_L178","M_L180","M_L189","M_L192","M_L194","AC-006","AC-012","AC-017","AC-038","AC-043","AC-044","AC-067","AC-069","AC-071","AC-072","AC-073","AC-080","AC-081","AC-082","AC-087","AC-091","AC-093","AC-105","AC-115","AC-135","AC-136","AC-137","AC-138","AC-141","AC-150","WO_003","WO_004","WO_005","WO_006","WO_007","WO_067","WO_111","WO_269","WO_331","WO_358","WO_383","WO_448","WO_449","WO_703","WO_815","WO_865","BH_10","BH_11","BH_12"),
                                     replacement = c("Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Härjedalen_lapponicus","Härjedalen_lapponicus","Härjedalen_lapponicus"),
                                     vectorize=F)

df2$V2 <- stri_replace_all_regex(df2$V2,
                                     pattern = c("M_L004","M_L007","M_L013","M_L017","M_L025","M_L027","M_L029","M_L054","M_L055","M_L056","M_L119","M_L147","M_L160","M_L168","M_L169","M_L191","M_L197","AC-014","AC-020","AC-021","AC-023","AC-028","AC-034","AC-046","AC-047","AC-049","AC-061","AC-106","AC-111","AC-118","AC-129","AC-133","M_L202","M_L203","M_L205","M_L206","M_L210","M_L211","M_L213","M_L214","M_L218","M_L219","M_L220","M_L221","M_L223","M_L224","M_L225","M_L075","M_L093","M_L130","M_L131","M_L133","M_L136","M_L140","M_L143","M_L146","M_L150","M_L152","M_L153","M_L159","M_L166","M_L167","M_L172","BH_01","BH_02","BH_03","BH_04","BH_05","BH_06","BH_07","BH_08","BH_09","BH_14","BH_15","BH_16","BH_17","BH_18","BH_19","WO_002"),
                                     replacement = c("Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Jämtland_monticola"),
                                     vectorize=F)
#### lap or mon
df2_lap$V2 <- stri_replace_all_regex(df2_lap$V2,
                                 pattern = c("M_L008","M_L057","M_L071","M_L072","M_L074","M_L076","M_L077","M_L081","M_L082","M_L083","M_L084","M_L086","M_L087","M_L088","M_L090","M_L091","M_L092","M_L095","M_L109","M_L110","M_L111","M_L112","M_L113","M_L114","M_L115","M_L116","M_L117","M_L120","M_L121","M_L122","M_L123","M_L124","M_L125","M_L127","M_L139","M_L144","M_L145","M_L148","M_L154","M_L157","M_L171","M_L173","M_L174","M_L175","M_L176","M_L183","M_L184","M_L185","M_L186","M_L187","M_L193","M_L199","M_L200","M_L215","M_L216","M_L226","M_L002","M_L003","M_L005","M_L009","M_L012","M_L014","M_L018","M_L021","M_L028","M_L030","M_L043","M_L046","M_L060","M_L061","M_L085","M_L089","M_L096","M_L097","M_L099","M_L100","M_L135","M_L138","M_L141","M_L178","M_L180","M_L189","M_L192","M_L194","AC-006","AC-012","AC-017","AC-038","AC-043","AC-044","AC-067","AC-069","AC-071","AC-072","AC-073","AC-080","AC-081","AC-082","AC-087","AC-091","AC-093","AC-105","AC-115","AC-135","AC-136","AC-137","AC-138","AC-141","AC-150","WO_003","WO_004","WO_005","WO_006","WO_007","WO_067","WO_111","WO_269","WO_331","WO_358","WO_383","WO_448","WO_449","WO_703","WO_815","WO_865","BH_10","BH_11","BH_12"),
                                 replacement = c("Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Abisko_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Jämtland_lapponicus","Härjedalen_lapponicus","Härjedalen_lapponicus","Härjedalen_lapponicus"),
                                 vectorize=F)

df2_mon$V2 <- stri_replace_all_regex(df2_mon$V2,
                                 pattern = c("M_L004","M_L007","M_L013","M_L017","M_L025","M_L027","M_L029","M_L054","M_L055","M_L056","M_L119","M_L147","M_L160","M_L168","M_L169","M_L191","M_L197","AC-014","AC-020","AC-021","AC-023","AC-028","AC-034","AC-046","AC-047","AC-049","AC-061","AC-106","AC-111","AC-118","AC-129","AC-133","M_L202","M_L203","M_L205","M_L206","M_L210","M_L211","M_L213","M_L214","M_L218","M_L219","M_L220","M_L221","M_L223","M_L224","M_L225","M_L075","M_L093","M_L130","M_L131","M_L133","M_L136","M_L140","M_L143","M_L146","M_L150","M_L152","M_L153","M_L159","M_L166","M_L167","M_L172","BH_01","BH_02","BH_03","BH_04","BH_05","BH_06","BH_07","BH_08","BH_09","BH_14","BH_15","BH_16","BH_17","BH_18","BH_19","WO_002"),
                                 replacement = c("Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Abisko_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Härjedalen_monticola","Jämtland_monticola"),
                                 vectorize=F)

#### change legend order ####
#https://statisticsglobe.com/change-display-order-of-ggplot2-plot-legend-in-r
df2$V2 <- factor(df2$V2,levels = c("Abisko_lapponicus","Jämtland_lapponicus","Härjedalen_lapponicus",
                                   "Abisko_monticola","Jämtland_monticola","Härjedalen_monticola"))

### bal 1
df3$V2 <- stri_replace_all_regex(df3$V2,
                                 pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                 replacement = c("Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus","Hyperboreus_Jämtland","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Balteatus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Alpinus","Polaris","Polaris","Polaris","Polaris","Polaris","Polaris_Jämtland"),
                                 vectorize=F)
### bal 2
df3$V2 <- stri_replace_all_regex(df3$V2,
                                 pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                 replacement = c("Hyperboreus_AC","Hyperboreus_AC","Hyperboreus_AC","Hyperboreus_AC","Hyperboreus_AC","Hyperboreus_ML","Hyperboreus_ML","Hyperboreus_ML","Hyperboreus_ML","Hyperboreus_WO","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_AC","Balteatus_BH","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Balteatus_ML","Alpinus_AC","Alpinus_AC","Alpinus_AC","Alpinus_AC","Alpinus_AC","Alpinus_AC","Alpinus_AC","Alpinus_ML","Alpinus_ML","Alpinus_ML","Alpinus_ML","Alpinus_ML","Polaris_ML","Polaris_ML","Polaris_AC","Polaris_AC","Polaris_AC","Polaris_WO"),
                                 vectorize=F)
### each species
head(df3_bal)
df3_bal$V2 <- stri_replace_all_regex(df3_bal$V2,
                                     pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                     replacement = c("Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Jämtland)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Härjedalen)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Jämtland)"),
                                     vectorize=F)
str(df3_bal)                                 

df3_hyp$V2 <- stri_replace_all_regex(df3_hyp$V2,
                                     pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                     replacement = c("Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Jämtland)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Härjedalen)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Jämtland)"),
                                     vectorize=F)
df3_pol$V2 <- stri_replace_all_regex(df3_pol$V2,
                                     pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                     replacement = c("Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Jämtland)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Härjedalen)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Jämtland)"),
                                     vectorize=F)
df3_alp$V2 <- stri_replace_all_regex(df3_alp$V2,
                                     pattern = c("AC-015","AC-018","AC-027","AC-036","AC-041","M_L020","M_L053","M_L058","M_L062","WO_001","AC-002","AC-003","AC-004","AC-011","AC-016","AC-022","AC-029","AC-078","AC-090","AC-113","AC-121","AC-126","AC-152","AC-156","BH_13","M_L024","M_L032","M_L033","M_L049","M_L098","M_L101","M_L102","M_L103","M_L105","M_L106","M_L107","M_L108","M_L126","M_L129","M_L137","M_L142","M_L149","M_L151","M_L155","M_L177","M_L179","M_L181","M_L182","M_L188","M_L190","M_L195","M_L196","M_L198","AC-007","AC-008","AC-019","AC-153","AC-045","AC-010","AC-033","M_L006","M_L010","M_L011","M_L019","M_L022","M_L015","M_L026","AC-025","AC_026","AC-112","WO_456"),
                                     replacement = c("Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Abisko/Kiruna)","Hyperboreus (Jämtland)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Härjedalen)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Balteatus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Alpinus (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Abisko/Kiruna)","Polaris (Jämtland)"),
                                     vectorize=F)

head(df1)

eigen_val1 <- read.delim("Bpas_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.vcf2plink.new.pca.eigenval",header = F,sep = " ")
eigen_val1 <- read.delim("Bpas_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.vcf2plink.new_rmDA_02.pca.eigenval",header = F,sep = " ")

eigen_val2 <- read.delim("Bsyl_DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excesshet_3.vcf2plink.new.pca.eigenval",header = F,sep = " ")
eigen_val2_lap <- read.delim("lap_128_Abisko_109_Jämtland_Härjedalen_19.pca.eigenval",header = F,sep = " ")
eigen_val2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.pca.eigenval",header = F,sep = " ")
eigen_val2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210.pca.eigenval",header = F,sep = " ")
eigen_val2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211.pca.eigenval",header = F,sep = " ")
eigen_val2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211_007.pca.eigenval",header = F,sep = " ")
eigen_val2_mon <- read.delim("mon_79_Abisko_63_Jämtland_Härjedalen_16.rm_M_L210_211_007_004_BH_03.pca.eigenval",header = F,sep = " ")


eigen_val3 <- read.delim("Bbal_DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.chr_sorted.vcf2plink.new.pca.eigenval",header = F,sep = " ")
eigen_val3_bal <- read.delim("sample_balteatus_43.pca.eigenval",header = F,sep = " ")
eigen_val3_hyp <- read.delim("subset_10hyperboreus.pca.eigenval",header = F,sep = " ")
eigen_val3_alp <- read.delim("subset_12alpinus_2.pca.eigenval",header = F,sep = " ")
eigen_val3_pol <- read.delim("subset_6polaris_1.pca.eigenval",header = F,sep = " ")

head(eigen_val1)
sum_eigen_val1 <- sum(eigen_val1$V1)
sum_eigen_vals1 <- lapply(eigen_val1$V1,function(x){
  rt <- (x/sum_eigen_val1)*100
  rt <- round(rt)
  return(rt)
})
#### syl_mon_lap
sum_eigen_val2 <- sum(eigen_val2$V1)
sum_eigen_vals2 <- lapply(eigen_val2$V1,function(x){
  rt <- (x/sum_eigen_val2)*100
  rt <- round(rt)
  return(rt)
})

sum_eigen_val2_lap <- sum(eigen_val2_lap$V1)
sum_eigen_vals2_lap <- lapply(eigen_val2_lap$V1,function(x){
  rt <- (x/sum_eigen_val2_lap)*100
  rt <- round(rt)
  return(rt)
})

sum_eigen_val2_mon <- sum(eigen_val2_mon$V1)
sum_eigen_vals2_mon <- lapply(eigen_val2_mon$V1,function(x){
  rt <- (x/sum_eigen_val2_mon)*100
  rt <- round(rt)
  return(rt)
})

#### bal mixed

sum_eigen_val3 <- sum(eigen_val3$V1)
sum_eigen_vals3 <- lapply(eigen_val3$V1,function(x){
  rt <- (x/sum_eigen_val3)*100
  rt <- round(rt)
  return(rt)
})
### per species: bal
sum_eigen_val3_bal <- sum(eigen_val3_bal$V1)
sum_eigen_vals3_bal <- lapply(eigen_val3_bal$V1,function(x){
  rt <- (x/sum_eigen_val3_bal)*100
  rt <- round(rt)
  return(rt)
})
# hyp
sum_eigen_val3_hyp <- sum(eigen_val3_hyp$V1)
sum_eigen_vals3_hyp <- lapply(eigen_val3_hyp$V1,function(x){
  rt <- (x/sum_eigen_val3_hyp)*100
  rt <- round(rt)
  return(rt)
})

# alp
sum_eigen_val3_alp <- sum(eigen_val3_alp$V1)
sum_eigen_vals3_alp <- lapply(eigen_val3_alp$V1,function(x){
  rt <- (x/sum_eigen_val3_alp)*100
  rt <- round(rt)
  return(rt)
})

# pol
sum_eigen_val3_pol <- sum(eigen_val3_pol$V1)
sum_eigen_vals3_pol <- lapply(eigen_val3_pol$V1,function(x){
  rt <- (x/sum_eigen_val3_pol)*100
  rt <- round(rt)
  return(rt)
})
####################
#change legend title: https://stackoverflow.com/questions/52985946/change-legend-title-ggplot2
#labs(x=expression(paste("Number of assumed populations, ",italic(K)))
#https://stackoverflow.com/questions/70849958/changing-legend-title-in-ggplot-changes-the-shown-legend-aesthetic
#https://stackoverflow.com/questions/59669647/changing-legend-title-ggplot
#https://stackoverflow.com/questions/14622421/how-to-change-legend-title-in-ggplot
# change legend text size
#https://www.statology.org/ggplot2-legend-size/

# multiple lines legend title
#https://stackoverflow.com/questions/42154922/align-two-line-legend-title-to-the-left-with-expression
#https://stackoverflow.com/questions/53364672/multi-line-legend-text-including-exponent-with-ggplot
# legend transparency
#https://stackoverflow.com/questions/35108443/ggplot2-make-legend-key-fill-transparent

############# pca pas ############
library(ggplot2)
library(ggrepel) # for function "geom_text_repel"
pca_pas1 <- ggplot(df1, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = c(0.45,0.8),legend.text = element_text(size=8),
        legend.title = element_text(size=8),
        legend.key.size = unit(0.2, 'cm'),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups (",italic("B. pascuorum"),")")))+
#  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals1[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals1[[2]],"% variance"))+
  scale_colour_manual(values =c("black", "blue", "#BCBD22","#9632B8","#008280","red"))+

  geom_text_repel(aes(label=ifelse(V4 < -0.5,as.character(V1),'')),size=2.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

pca_pas2 <- ggplot(df1, aes(V3,V5,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups (",italic(B.pascuorum),")")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals1[[1]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals1[[3]],"% variance"))+
  scale_colour_manual(values =c("black", "#D55E00", "cyan","#009E73","deeppink","blue"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082,as.character(V1),'')),size=1.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

pca_pas3 <- ggplot(df1, aes(V4,V5,color=V2))+
  geom_point(size=1,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups (",italic(B.pascuorum),")")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC2: ",sum_eigen_vals1[[2]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals1[[3]],"% variance"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082,as.character(V1),'')),size=1.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

ggsave(pca_pas,filename= "Bpas_14haploid_41diploid.vcf2ped.new.ped.PC2_PC3.label.pdf",width = 6,height = 4)

# labels beside points: geom_text(aes(label=ifelse(V3>0.2 | V4>0.5,as.character(V1),'')),hjust=1, vjust=-1,size=1)
# pas2 -> label=ifelse(V3>0 |V3 < -0.082
install.packages("cowplot")
library(cowplot)
merge1 <- plot_grid(pca_pas1,pca_pas2,pca_pas3,ncol=3,nrow=1, align="hv")

ggsave(merge1,filename = "merged_pca_pas.pdf",width = 10,height = 3)

#### pca mon_lap ####
# multiple lines legend title
#https://stackoverflow.com/questions/42154922/align-two-line-legend-title-to-the-left-with-expression
#https://stackoverflow.com/questions/53364672/multi-line-legend-text-including-exponent-with-ggplot
# legend transparency
#https://stackoverflow.com/questions/35108443/ggplot2-make-legend-key-fill-transparent
head(df2)
pca_mon_lap1 <- ggplot(df2, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = c(0.6,0.8),legend.text = element_text(size=8),
        legend.background=element_rect(fill = alpha("white", 0)),
        legend.title = element_text(size=8),
        legend.title.align = 0,
        legend.key.size = unit(0.2, 'cm'),
        legend.key.width = unit(0.5, 'cm'),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(atop(textstyle("Sample groups"),
                                  "("~italic(B.~lapponicus)~"and"~italic(B.~monticola)~ ")")~phantom (1000000)~phantom (1000000)))+
#  labs(color=expression(atop(atop(textstyle("Leakage Rate"),
#                       textstyle("at 75 Pa")),
#                  "(L/s-" ~m^2~ ")")))+
#  labs(color=expression(atop("Sample groups", italic("(B. lapponicus and B. monticola)"))))+
#  labs(color=paste('Sample groups\n(',italic('B. lapponicus and B. monticola'),')', sep=''))+
  xlab(paste0("PC1: ",sum_eigen_vals2[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals2[[2]],"% variance"))+
  scale_colour_manual(values =c("black", "#D55E00", "cyan","#009E73","deeppink","blue"))+
#  scale_colour_manual(values =c("black", "orange", "cyan","green","pink","blue"))

  geom_text_repel(aes(label=ifelse(V4>0.2 | V2 == "Abisko_monticola" & V3 < 0,as.character(V1),'')),
                  size=2, # | V3 > 0.05 , V3 < 0 && V2 == "Abisko_monticola"
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 200))
#### 
pca_mon_lap2 <- ggplot(df2, aes(V3,V5,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(atop(textstyle("Sample groups"),
                             "("~italic(B.~lapponicus)~"and"~italic(B.~monticola)~ ")")~phantom (1000000)~phantom (1000000)))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC1: ",sum_eigen_vals2[[1]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals2[[3]],"% variance"))+
  scale_colour_manual(values =c("black", "#D55E00", "cyan","#009E73","deeppink","blue"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082,as.character(V1),'')),size=2,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 200))

pca_mon_lap3 <- ggplot(df2, aes(V4,V5,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups (",italic(B.monticola)," and ",italic(B.lapponicus),")")))+
  #  guides(fill=guide_legend(title="Sample groups"))+
  xlab(paste0("PC2: ",sum_eigen_vals2[[2]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals2[[3]],"% variance"))+
  scale_colour_manual(values =c("black", "orange", "cyan","chartreuse","red","blue"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082,as.character(V1),'')),size=2,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 200))

ggsave(pca_pas,filename= "Bpas_14haploid_41diploid.vcf2ped.new.ped.PC2_PC3.label.pdf",width = 6,height = 4)

#### syl_mon+lap
#### lap  
pca_syl_lap1 <- ggplot(df2_lap, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = c(0.22,1),legend.text = element_text(size=8),
        plot.margin = unit(c(1,1,1,1),"cm"),
        legend.background=element_rect(fill = alpha("white", 0)),
        legend.title = element_text(size=8),
        legend.title.align = 0,
        legend.key.size = unit(0.2, 'cm'),
        legend.key.width = unit(0.5, 'cm'),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(paste("Sample groups",
                             "(",italic("B. lapponicus"),")")))+
  xlab(paste0("PC1: ",sum_eigen_vals2_lap[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals2_lap[[2]],"% variance"))+
  scale_colour_manual(values =c("black", "deeppink","blue"))
  #  scale_colour_manual(values =c("black", "orange", "cyan","green","pink","blue"))
  
  geom_text_repel(aes(label=ifelse(V4>0.2,as.character(V1),'')),size=2, # | V3 > 0.05
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 200))

  pca_syl_lap2 <- ggplot(df2_lap, aes(V3,V5,color=V2))+
    geom_point(size=2,alpha = 2/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          plot.margin = unit(c(1,1,1,1),"cm"),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. lapponicus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals2_lap[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals2_lap[[3]],"% variance"))+
    scale_colour_manual(values =c("black", "deeppink","blue"))
#### mon
  pca_syl_mon1 <- ggplot(df2_mon, aes(V3,V4,color=V2))+
    geom_point(size=2,alpha = 2/4)+
    theme_classic()+
    theme(legend.position = c(0.3,0.9),legend.text = element_text(size=8),
          plot.margin = unit(c(1,1,1,1),"cm"),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. monticola"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals2_mon[[1]],"% variance"))+
    ylab(paste0("PC2: ",sum_eigen_vals2_mon[[2]],"% variance"))+
    scale_colour_manual(values =c("black", "deeppink","blue"))+
    
    geom_text_repel(aes(label=ifelse( V3 < -0.4 | V4 > 0.25,as.character(V1),'')),size=2, # | V3 > 0.05
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.5,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 200))

  pca_syl_mon2 <- ggplot(df2_mon, aes(V3,V5,color=V2))+
    geom_point(size=2,alpha = 2/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          plot.margin = unit(c(1,1,1,1),"cm"),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. monticola"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals2_mon[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals2_mon[[3]],"% variance"))+
    scale_colour_manual(values =c("black", "deeppink","blue"))  
  
  
#### bal
pca_bal1 <- ggplot(df3, aes(V3,V4,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = c(0.61,0.75),legend.text = element_text(size=8),
        legend.background=element_rect(fill = alpha("white", 0)),
        legend.title = element_text(size=8),
        legend.title.align = 0,
        legend.key.size = unit(0.2, 'cm'),
        legend.key.width = unit(0.5, 'cm'),
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(atop(textstyle("Sample groups"),
                             "("~italic(B.~balteatus)~","~italic(B.~hyperboreus)~","~italic(B.~alpinus)~"and"~italic(B.~polaris)~")")))+
  xlab(paste0("PC1: ",sum_eigen_vals3[[1]],"% variance"))+
  ylab(paste0("PC2: ",sum_eigen_vals3[[2]],"% variance"))+
  scale_colour_manual(values =c("black", "#D55E00","deeppink","blue"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082|V4 > 0,as.character(V1),'')),size=1.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))

pca_bal2 <- ggplot(df3, aes(V3,V5,color=V2))+
  geom_point(size=2,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(atop(textstyle("Sample groups"),
                             "("~italic(B.~balteatus)~","~italic(B.~hyperboreus)~","~italic(B.~alpinus)~"and"~italic(B.~polaris~")"))))+
  xlab(paste0("PC1: ",sum_eigen_vals3[[1]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals3[[3]],"% variance"))+ 
  scale_colour_manual(values =c("black", "#D55E00","deeppink","blue"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082|V4 > 0,as.character(V1),'')),size=1.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 200))

pca_bal3 <- ggplot(df3, aes(V4,V5,color=V2))+
  geom_point(size=1,alpha = 2/4)+
  theme_classic()+
  theme(legend.position = "none",
        axis.line = element_line(size=0.3),
        axis.text = element_text(color = "black"),
        axis.ticks = element_line(size = 0.3))+
  labs(color=expression(atop(textstyle("Sample groups"),
                             "("~italic(B.~balteatus)~","~italic(B.~hyperboreus)~","~italic(B.~alpinus)~"and"~italic(B.~polaris~")"))))+
  xlab(paste0("PC2: ",sum_eigen_vals3[[2]],"% variance"))+
  ylab(paste0("PC3: ",sum_eigen_vals3[[3]],"% variance"))

  geom_text_repel(aes(label=ifelse(V3>0 |V3 < -0.082 |V4 > 0,as.character(V1),'')),size=1.5,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.5,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 300))
#### PCA within species ####
### bal
### PC1 PC2  
  pca_bal_bal1 <- ggplot(df3_bal, aes(V3,V4,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = c(0.51,0.9),legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                " (",italic("B. balteatus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_bal[[1]],"% variance"))+
    ylab(paste0("PC2: ",sum_eigen_vals3_bal[[2]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))+
  
  geom_text_repel(aes(label=ifelse(V2=="Balteatus (Härjedalen)",as.character(V1),'')),size=2,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.75,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))
### PC1 PC3
pca_bal_bal2 <- ggplot(df3_bal, aes(V3,V5,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. balteatus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_bal[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals3_bal[[3]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))+
  
  geom_text_repel(aes(label=ifelse(V2=="Balteatus (Härjedalen)",as.character(V1),'')),size=2,
                  segment.size=0.1,
                  segment.color = "grey50",
                  alpha=0.75,
                  show.legend=FALSE,
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))  
  
  ### hyp
  ### PC1 PC2  
pca_bal_hyp1 <- ggplot(df3_hyp, aes(V3,V4,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = c(0.65,0.9),legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                " (",italic("B. hyperboreus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_hyp[[1]],"% variance"))+
    ylab(paste0("PC2: ",sum_eigen_vals3_hyp[[2]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))+
    
    geom_text_repel(aes(label=ifelse(V4<0, as.character(V1),'')),size=2,
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.75,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 100))
  ### PC1 PC3
  pca_bal_hyp2 <- ggplot(df3_hyp, aes(V3,V5,color=V2,label=V1))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. hyperboreus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_hyp[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals3_hyp[[3]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))+
    geom_text_repel(aes(label=ifelse(V3<1, as.character(V1),'')),size=2,
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.75,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 100))    
#    geom_text()
### pol
### PC1 PC2  
pca_bal_pol1 <- ggplot(df3_pol, aes(V3,V4,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = c(0.51,0.9),legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                " (",italic("B. polaris"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_pol[[1]],"% variance"))+
    ylab(paste0("PC2: ",sum_eigen_vals3_pol[[2]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))+
    
    geom_text_repel(aes(label=ifelse(V3<1,as.character(V1),'')),size=2,
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.75,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 100))
### PC1 PC3
  pca_bal_pol2 <- ggplot(df3_pol, aes(V3,V5,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. polaris"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_pol[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals3_pol[[3]],"% variance"))+
    scale_colour_manual(values =c("darkorange","blue"))  
### alp
### PC1 PC2  
  pca_bal_alp1 <- ggplot(df3_alp, aes(V3,V4,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = c(0.51,0.9),legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                " (",italic("B. alpinus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_alp[[1]],"% variance"))+
    ylab(paste0("PC2: ",sum_eigen_vals3_alp[[2]],"% variance"))+
    scale_colour_manual(values =c("blue","darkorange"))+
    
    geom_text_repel(aes(label=ifelse(V3<1,as.character(V1),'')),size=2,
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.75,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 100))
  ### PC1 PC3
  pca_bal_alp2 <- ggplot(df3_alp, aes(V3,V5,color=V2))+
    geom_point(size=2,alpha = 3/4)+
    theme_classic()+
    theme(legend.position = "none",legend.text = element_text(size=8),
          legend.background=element_rect(fill = alpha("white", 0)),
          legend.title = element_text(size=8),
          legend.title.align = 0,
          legend.key.size = unit(0.2, 'cm'),
          legend.key.width = unit(0.5, 'cm'),
          axis.line = element_line(size=0.3),
          axis.text = element_text(color = "black"),
          axis.ticks = element_line(size = 0.3))+
    labs(color=expression(paste("Sample groups",
                                "(",italic("B. alpinus"),")")))+
    xlab(paste0("PC1: ",sum_eigen_vals3_alp[[1]],"% variance"))+
    ylab(paste0("PC3: ",sum_eigen_vals3_alp[[3]],"% variance"))+
    scale_colour_manual(values =c("blue","darkorange"))+
    
    geom_text_repel(aes(label=ifelse(V3<1,as.character(V1),'')),size=2,
                    segment.size=0.1,
                    segment.color = "grey50",
                    alpha=0.75,
                    show.legend=FALSE,
                    max.overlaps = getOption("ggrepel.max.overlaps", 100))  

  
# labels beside points: geom_text(aes(label=ifelse(V3>0.2 | V4>0.5,as.character(V1),'')),hjust=1, vjust=-1,size=1)
# pas2 -> label=ifelse(V3>0 |V3 < -0.082
install.packages("cowplot")
library(cowplot)
merge1 <- plot_grid(pca_pas1,pca_pas2,ncol=2,nrow=1, align="hv")
merge2 <- plot_grid(pca_mon_lap1,pca_mon_lap2,ncol=2,nrow=1, align="hv")
merge3 <- plot_grid(pca_bal1,pca_bal2,ncol=2,nrow=1, align="hv")
merge2_3 <- plot_grid(pca_syl_lap1,
                      pca_syl_lap2,
                      pca_syl_mon1,
                      pca_syl_mon2,
                      ncol=2,nrow=2, align="hv")
# within species
merge_bal_hyp_alp_pol <- plot_grid(pca_bal_bal1,pca_bal_bal2,
                                   pca_bal_hyp1,pca_bal_hyp2,
                                   pca_bal_alp1,pca_bal_alp2,
                                   pca_bal_pol1,pca_bal_pol2,
                                   ncol=2,nrow=4, align="hv")

pca_syl_mon2
merge4 <- plot_grid(merge1,merge2,merge3,ncol=1,nrow=3, align="hv")
merge5 <- plot_grid(pca_pas1,pca_pas2,
                    pca_mon_lap1,pca_mon_lap2,
                    pca_bal1,pca_bal2,
                    ncol=2,nrow=3, align="hv")

ggsave(merge1,filename = "merged_pca_pas.new.pdf",width = 10,height = 3)
ggsave(merge2,filename = "merged_pca_mon_lap.new.pdf",width = 10,height = 3)
ggsave(merge3,filename = "merged_pca_bal.new.pdf",width = 10,height = 3)
ggsave(merge5,filename = "merged_pca_pas_mon_lap_bal.DP_ExcHet.new.pdf",width = 10,height = 12)
ggsave(merge2_3,filename = "merged_pca_within_lap_mon.DP_ExcHet.pdf",width = 10,height = 8)
ggsave(merge_bal_hyp_alp_pol,filename = "merged_pca_within_bal_hyp_alp_pol.DP_ExcHet.geno09.pdf",
       width = 8,height = 12)



#### admixture ####
list.files()
show()
CV <- read.delim("cross_validation.txt",header = F,sep = " ")
CV
CV$K <- 1:4
library(ggplot2)
ggplot(CV,aes(x=K,y=V4))+
  geom_point(color="blue")+
  geom_line()+
  labs(x=expression(paste("Number of assumed populations, ",italic(K))),y="Cross validation value")+
  theme_classic()
# connect point with line
# https://stackoverflow.com/questions/65509782/connecting-points-in-ggplot2-graph-with-lines
tableK3 <- read.table("B.pas_bcftools_SNP_no_filter_concat_phased.plink.3.Q")
tableK4 <- read.table("B.pas_bcftools_SNP_no_filter_concat_phased.plink.4.Q")
head(tableK4)
ord3=tableK4[order(tableK3$V1,tableK3$V2,tableK3$V3),]
ord4=tableK4[order(tableK4$V1,tableK4$V2,tableK4$V3,tableK4$V4),]
head(ord3)

sample_names <- read.table("pop_label.txt",header = F,sep = "\t")
head(sample_names)
class(names)

names <- as.factor(sample_names$V1) # https://stackoverflow.com/questions/7070173/convert-data-frame-column-to-a-vector
K3 <- barplot(t(as.matrix(tableK3)),las="2",space = 0, names.arg=names,
              col.axis="black",font.axis=1,cex.names = 0.5, cex.axis = 0.8,
              col = c("#D55E00","#0072B2", "#b6dbff"),
              xlab = "Individual",ylab = "K = 3",border = NA)
pdf("admixture_pas.4.pdf",width = 6,height = 2.5)
K4 <- barplot(t(as.matrix(tableK4)),las="2",space = 0, names.arg=names,
              col.axis="black",font.axis=1,cex.names = 0.5, cex.axis = 0.8,
              col = c("#D55E00","#0072B2", "#b6dbff", "#920000"),
              xlab = "Individual",ylab = "K = 4",border = NA)
dev.off()
# barplot: https://r-graph-gallery.com/210-custom-barplot-layout.html
# http://howtoinr.weebly.com/customize-labels1.html
# https://stackoverflow.com/questions/65013406/how-to-generate-30-distinct-colors-that-are-color-blind-friendly
# https://stackoverflow.com/questions/57153428/r-plot-color-combinations-that-are-colorblind-accessible
#D55E00 - dark orange
#0072B2 - sea blue
#b6dbff - light blue
#920000 - red

install.packages("pophelper")
remotes::install_github('royfrancis/pophelper')
library("pophelper")
getwd()
list.files()
sfiles_pas <- list.files()
str(sfiles_pas)
#sfiles <- "B.pas_bcftools_SNP_no_filter_concat_phased.plink"
slist_pas <- readQ(files = sfiles_pas)
str(slist_pas)
head(slist_pas)
slist_pas[[4]]
tr1_pas <- tabulateQ(qlist = slist_pas)
sr1_pas <- summariseQ(tr1_pas)

# read labels
label_pas <- read.delim("../data/pop_label.txt",header = F,stringsAsFactors = F)
class(label_pas)
rownames(slist_pas[[1]]) <- label_pas$V1
rownames(slist_pas[[2]]) <- label_pas$V1
rownames(slist_pas[[3]]) <- label_pas$V1
rownames(slist_pas[[4]]) <- label_pas$V1

# problem
if(length(unique(sapply(slist_pas,nrow)))==55) slist <- lapply(slist_pas,"rownames<-",label_pas$V1)
lapply(slist_pas, rownames)[1:5] # for each matrix 


plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9)
plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T)
# made it!!!
plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T,useindlab = T,showyaxis = T)
#############################
install.packages("showtext")
library(showtext)
font_add_google("Patrick Hand","patrick")
showtext_auto()

plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T,useindlab = T,indlabhjust = 0.5,
      indlabsize=6,indlabheight=0.08,panelspacer = 0.25,
      sppos="left", splabcol = "black", splab=paste0("K=",sapply(slist_pas[c(2,3,4)],ncol)))
#############################
#sort according to cluster
plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T,useindlab = T,indlabangle = 85,indlabhjust = 0.5,indlabcol = "black",
      indlabheight =0.5,panelspacer = 0.02,sortind = "Cluster1",sharedindlab = F)

# group label issue ###### ?
group_pas <- read.delim("../data/pas_ind2pop-Copy.txt",header = F,stringsAsFactors = F)
str(group_pas)

plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T,useindlab = T,indlabangle = 85,indlabhjust = 0.5,indlabcol = "black",
      indlabheight =0.5,panelspacer = 0.5,
      grplab = group_pas,grplabsize=4,linesize=0.8,pointsize=4)




plotQ(slist_pas[c(2,3,4)],imgoutput="join",returnplot=T,exportplot=F,basesize=9,
      showindlab = T,useindlab = T,indlabangle = 85,indlabhjust = 0.5,indlabcol = "black",
      indlabheight =0.5,panelspacer = 0.02,
      grplab = group_pas,grplabsize=4,linesize=0.8,pointsize=4)




install.packages("ape")
library(ape)
list.files()
individual_tree <- read.tree("intree")
individual_tree <- read.tree("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.biallelic_maf0.01missing0.1.geno.nan_0.dist_fastme.terminal.individual_tree")
str(individual_tree)
one_tree <- consensus(individual_tree,p = 1, check.labels = TRUE, rooted = FALSE)
write.tree(one_tree,file = "one_tree.tree")
################################################### merge ggplot plots###############
install.packages("gridExtra")
library("gridExtra")
library("grid")
library(scales)
blank <- grid.rect(gp=gpar(col="white"), width = c(0,0),height = c(0,0))
plist <- list(K3,K4)
grid.arrange(nrow=2,grobs=plist)
grid.arrange(p_log_Pi,blank,p3,p_Fst,ncol=2, nrow=2, widths=c(4, 2), heights=c(2,4))
install.packages("cowplot")
library(cowplot)
cowplot::plot_grid(plotlist = plist,nrow=2)


#### previous example ####
barplot(data_het$O.E.het.,names.arg = data_het$INDV, 
        xlab=substitute(paste('Individual (',italic('Bombus pascuorum'),')')),
        ylab = "Heterozygosity", cex.lab=0.8,
        col = "gray", col.axis="black", space = 0,
        cex.names = 0.5,cex.axis = 0.6, las=2)
#axis(0.1)
#  width = 0.8, xlim = c(0,55),font.axis=2



K3 <- barplot(t(as.matrix(ord3)),las="2",space = 0, 
              col = c("#009999","#FF9900","#FF3300","#FFFF00"),
              xlab = "Individual",ylab = "K = 3",border = NA)
K4 <- barplot(t(as.matrix(tableK4)),las="2",space = 0, 
              col = rainbow(4),xlab = "Individual",ylab = "K = 4",border = NA)
K4 <- barplot(t(as.matrix(ord4)),las="2",space = 0, 
              col = c("#009999","#FF9900","#FF3300","#FFFF00","#003366"),
              xlab = "Individual",ylab = "K = 4",border = NA)

#### previous example ####
names = c("1_1", "1_10", "1_11", "1_12", "1_13", "1_2", "1_3", "1_4", 
          "1_5", "1_6",	"1_7", "1_8",	"2_1",	"2_10",	"2_11",	"2_12",	
          "2_2",	"2_3",	"2_4",	"2_6",	"2_7",	"3_1",	"3_10",	"3_11",	
          "3_12",	"3_2",	"3_3",	"3_4",	"3_5",	"3_6",	"3_7",	"3_8",	
          "3_9", "4_1","4_10",	"4_11",	"4_12",	"4_2",	"4_3",	"4_4",	
          "4_5",	"4_6",	"4_8",	"4_9")
K5 <- barplot(t(as.matrix(tableK5)),las="2",space = 0, 
              names.arg=names, cex.names=0.8, 
              col=c("#009999","#FF9900","#FF3300","#FFFF00","#003366"),
              xlab = "Individual",ylab = "K = 5",border = NA)

install.packages("Rcpp")
library(Rcpp)
install.packages("conStruct")
library(conStruct)

# https://stackoverflow.com/questions/5620885/how-does-one-reorder-columns-in-a-data-frame
pop_label <- read.csv("B.pas_bcftools_SNP_no_filter_concat_phased.plink.nosex", sep = "\t",header = F)
head(pop_label)
pop_label$ID <- 1:55
new_pop_label <- subset(pop_label, select=c(ID,V1))
head(new_pop_label)
write.table(new_pop_label,file = "new_pop_label.txt",row.names = F,col.names = F,quote = F)

head(df)

#### fst ####
list.files()
library(tidyverse) # change header case
library(ggplot2)
library(ggrepel)

fst_monticola <- read_tsv("vcf_fst_monticola_28male_52female.weir.fst")
fst_monticola <- read.table("vcf_fst_monticola_28male_52female.weir.fst.remove_nan_negative.txt",header = T)
fst_monticola_0ver_0.2 <- read_tsv("vcf_fst_monticola_28male_52female.weir.fst.remove_nan_negative_over_0.2.txt")

head(fst_monticola_0ver_0.2)
head(fst_monticola)

#### change header case ####
# https://speciationgenomics.github.io/per_site_Fst/
# https://statisticsglobe.com/change-letter-case-column-names-r
data <- data.frame(cOl1 = 1:6,         # Create example data frame
                   coL2 = c(1, 3, 2, 4, 3, 5))
data
names(data) <- toupper(names(data))
data

names(fst_monticola_0ver_0.2) <- tolower(names(fst_monticola_0ver_0.2))
head(fst_monticola_0ver_0.2)
class(fst_monticola_0ver_0.2)
str(fst_monticola_0ver_0.2)
fst_monticola_0ver_0.2$coordinate <- c(1:2189)
library(stringr) 
# concatenate columns https://www.marsja.se/how-to-concatenate-two-columns-or-more-in-r-stringr-tidyr/
# https://stackoverflow.com/questions/18115550/combine-two-or-more-columns-in-a-dataframe-into-a-new-column-with-a-new-name
fst_monticola_0ver_0.2$label <- paste0(fst_monticola_0ver_0.2$chrom,"-",fst_monticola_0ver_0.2$pos)
fst_monticola_0ver_0.2$label <- str_c(fst_monticola_0ver_0.2$chrom,':',fst_monticola_0ver_0.2$pos)

# position for label:https://stackoverflow.com/questions/15624656/label-points-in-geom-point

fst_barplot <- ggplot(fst_monticola_0ver_0.2, aes(y=weir_and_cockerham_fst,x=coordinate))+
  geom_point(size=0.2,stroke = 0,color="blue",alpha=2/4)+
  labs(y="Weir_and_Cockerham_FST > 0.2", x="Coordinate",
       title = expression(paste("Per-site ", italic(F)[ST]," between males and females for ", italic("Bombus monticola"))))+
  theme_classic()+
  theme(plot.title = element_text(size = 9,hjust = 0.5))+
  geom_text_repel(data=subset(fst_monticola_0ver_0.2,weir_and_cockerham_fst> 0.9),
                  nudge_y = 1-subset(fst_monticola_0ver_0.2,weir_and_cockerham_fst> 0.9)$weir_and_cockerham_fst,
                  aes(label=label),size=0.3,
                  segment.size=0.1,
                  show.legend=FALSE,
#                  box.padding   = 0.4,
#                  point.padding = 0,
#                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 100))


ggsave(fst_barplot,filename="fst_plot_male_female_monticola(over0.2).shape_19point_0.2stroke_0.pdf",width = 6,height = 4)

# make smaller point size
# https://stackoverflow.com/questions/34638902/point-size-in-ggplot-2-0-0
# https://stackoverflow.com/questions/51700127/ggplot2-how-to-produce-smaller-points
# https://github.com/tidyverse/ggplot2/issues/1666
# https://stackoverflow.com/questions/20155400/defining-minimum-point-size-in-ggplot2-geom-point
# https://stackoverflow.com/questions/37398598/geom-point-smallest-point-size-is-not-in-proportion
# shape="."
# size=0.05 normal (stroke = 0)
# default shape=19 not 16 in older version of ggplot2
#### Italic,  superscript, and subscript ####
#x=expression(paste("Individuals (",italic("Bombus pascuorum"),")"))
#y=expression(italic(F)[ST*","~Maryland~vs~North~Cape])
#title = expression(Per-site~italic(F)[ST*]~between~males~and~females~for~italic("Bombus monticola"))
# https://www.dataanalytics.org.uk/axis-labels-in-r-plots-using-expression/#sub_sup
# use variable in expression: https://stackoverflow.com/questions/32555531/how-to-italicize-part-one-or-two-words-of-an-axis-title
# https://stackoverflow.com/questions/67320474/using-subscript-and-italics-in-ggplot2-axis-labels
# title position / adjust line space if split a line into two
#: https://www.datanovia.com/en/blog/ggplot-title-subtitle-and-caption/


# vcfR
setwd("E:/Share/Sweden_UU/SW_mountain_bee/vcfR")
list.files()
library("vcfR")
library(help="vcfR")
install.packages("adegenet")
install.packages("pegas")
library(adegenet)
library("pegas")
vcfR2genlight()
syl_contig1_4_sample <- read.vcfR("Bsyl_AC-020_21_BH_12_WO_815.contig1_2100_2300.ID.vcf",convertNA = F,checkFile = T,check_keys = T,verbose = F)
syl_contig1_4_sample <- read.vcfR("Bsyl_AC-020_21_BH_12_WO_815.contig1_2100_3500.header.ID_replace.vcf",convertNA = F,checkFile = T,check_keys = T,verbose = F)

class(syl_contig1_4_sample)
str(syl_contig1_4_sample)
show(syl_contig1_4_sample)
head(syl_contig1_4_sample)

#syl_genind <- vcfR2genind(syl_contig1_4_sample)
#syl_genind$tab
syl_loci <- vcfR2loci(syl_contig1_4_sample,return.alleles=T) # vcfR
str(syl_loci)
syl_loci$contig_001_2106
loci2genind <- loci2genind(syl_loci,ploidy=c(2,2,1,1)) # pegas
str(loci2genind)
loci2genind$all.names
loci2genind$tab

loci2genind$ploidy
as.matrix(loci2genind)
## PCA
sum(is.na(loci2genind$tab))
loci2genind$ploidy
x <- tab(loci2genind,freq=T,NA.method="mean")
class(x)
dim(x)
x[1:4,1:10]
pca1 <- dudi.pca(x,scale = F,scannf = F,nf=3)
barplot(pca1$eig[1:50], main = "PCA eigenvalues", col = heat.colors(50))

s.label(pca1$li) 
title("PCA of bumblebee") 
add.scatter.eig(pca1$eig[1:20], 3,1,2)

## color plot
colorplot(pca1$li[c(1,2)], pca1$li, transp=TRUE, cex=3, xlab="PC 1", ylab="PC 2") 
title("PCA of B.syl") 
abline(v=0,h=0,col="grey", lty=2)

dev.off()


####
loci <- as.loci(syl_loci, allele.sep = "/|")

syl_genlight <- vcfR2genlight(syl_contig1_4_sample,n.cores = 1)
str(syl_genlight)
head(position(syl_genlight),20)
head(alleles(syl_genlight),20)
head(locNames(syl_genlight),20)

glPlot(syl_genlight,posi = "topleft")

PCA1 <- glPca(syl_genlight)
scatter(pca1, posi="bottomright") 
title("PCA of the US influenza data\n axes 1-2")

queryMETA(syl_contig1_4_sample, element = 'DP')


data(vcfR_test) 
check_keys(vcfR_test)
queryMETA(vcfR_test)
queryMETA(vcfR_test, element = 'DP') #


#### smc++ ####
# read json files
setwd("E:/Share/Sweden_UU/SW_mountain_bee/SMC")
list.files()
install.packages("rjson")
library(rjson)
mon_smc_results <- fromJSON(file = "lap_model.final.json")

#### boot ####
# https://www.mayin.org/ajayshah/KB/R/documents/boot.html
x=seq(from=10,to=50,by=10)
x
d=c(3,2,2)
x[2:3] # indices

d
x[1]
setwd("E:/Share/Sweden_UU/Roc_Se_bumblebee/analysis_NJ_Ne_fst_time/NJ_syl")
list.files()
fst_syl_lap <- read.csv("Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.geno_csv",header = T)
fst_syl_lap_Na <- read.csv("Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.biSNP_GQ20_DP3_25000_ExHet20_minorAC2_mis05.rm_maleHet.oneway.imp.geno_csv",header = T,na.strings = "0.00")
fst_bal <- read.csv("../NJ_bal/Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.geno_csv",header = T)

head(fst_syl_lap,n=1L)
write.table((head(fst_syl_lap,n=1L)),"Roc_Se_syl_inc_lap.txt",row.names = F,col.names = T,quote = F)
write.table((head(fst_bal,n=1L)),"Roc_Se_bal.txt",row.names = F,col.names = T,quote = F)

head(fst_bal)
str(fst_bal)

View(fst_syl_lap) # open in a file
View(fst_syl_lap_Na)

#### deal with nan ####
# https://stackoverflow.com/questions/18142117/how-to-replace-nan-value-with-zero-in-a-huge-data-frame
# https://www.tutorialkart.com/r-tutorial/r-dataframe-replace-na-with-0/
is.na(fst_syl_lap$Fst_incognitus_sylvicola)
fst_syl_lap$Fst_incognitus_sylvicola[is.na(fst_syl_lap$Fst_incognitus_sylvicola)]=0
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
head(fst_syl_lap_inc)
head(fst_bal_Roc_Se)
tail(fst_syl_lap_inc)
str(fst_syl_lap_inc)
#### reshape data ####
library(reshape2)
fst_pi_dxy_syl_Roc_Se_lap_inc <- fst_syl_lap[,c(1:4,7,9:10,12:13,16,18:19,22)]
fst_pi_dxy_Roc_Se_bal <- fst_bal[,c(1:4,7,9,13,23)]
head(fst_pi_dxy_syl_Roc_Se_lap_inc)
head(fst_pi_dxy_Roc_Se_bal)
# melt data into a column
fst_pi_dxy_syl_Roc_Se_lap_inc_reshape <- melt(fst_pi_dxy_syl_Roc_Se_lap_inc,id.var=c("windowID","scaffold","start","end"))
fst_pi_dxy_Roc_Se_bal_reshape <- melt(fst_pi_dxy_Roc_Se_bal,id.var=c("windowID","scaffold","start","end"))
head(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape)
head(fst_pi_dxy_Roc_Se_bal_reshape)
# change variable order
re_order_stats <- factor(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape$variable)
re_order_stats_bal <- factor(fst_pi_dxy_Roc_Se_bal_reshape$variable)
str(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape)
str(fst_pi_dxy_Roc_Se_bal_reshape)
str(re_order_stats_bal$variable)
class(re_order_stats_bal)
levels(re_order_stats_bal)

class(re_order_stats)
re_order_stats <- factor(re_order_stats,levels(re_order_stats)[c(7,8,9,1,2,3,4,5,6)])
re_order_stats_bal <- factor(re_order_stats_bal,levels(re_order_stats_bal)[c(4,1,2,3)])

fst_pi_dxy_syl_Roc_Se_lap_inc_reshape$variable <- re_order_stats
fst_pi_dxy_Roc_Se_bal_reshape$variable <- re_order_stats_bal
levels(fst_pi_dxy_Roc_Se_bal_reshape$variable)
## ggplot facet
library(ggplot2)
# exclude some variable in facet_grid
# https://stackoverflow.com/questions/10608133/plot-only-a-select-few-facets-in-facet-grid
# facet_strip 
# https://www.datanovia.com/en/blog/how-to-change-ggplot-facet-labels/
p_inc_lap <- ggplot(subset(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape,variable %in% 
c("pi_lapponicus","pi_incognitus","dxy_lapponicus_incognitus","Fst_lapponicus_incognitus")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.1)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 3.5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))

p_lap_syl <- ggplot(subset(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape,variable %in% 
                             c("pi_lapponicus","pi_sylvicola","dxy_lapponicus_sylvicola","Fst_lapponicus_sylvicola")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.1)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 3.5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1,"lines"))

p_inc_syl <- ggplot(subset(fst_pi_dxy_syl_Roc_Se_lap_inc_reshape,variable %in% 
                             c("pi_sylvicola","pi_incognitus","dxy_incognitus_sylvicola","Fst_incognitus_sylvicola")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.1)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 3.5, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1, "lines"))

#### balteatus - Roc - Se
p_Roc_Se_bal <- ggplot(subset(fst_pi_dxy_Roc_Se_bal_reshape,variable %in% 
                             c("Fst_Roc_bal_Se_bal","pi_Roc_bal","pi_Se_bal","dxy_Roc_bal_Se_bal")),aes(windowID,value,color=variable))+
  geom_line(aes(group=factor(variable)),size=0.1)+
  facet_grid(variable~.,scales = "free_y")+
  xlab("Window (30 Kb) series across genome")+ ylab("Value")+
  theme_light()+theme(legend.position = "none",axis.title = element_text(colour = "Black",size = 7),
                      axis.text = element_text(colour = "black",size = 6),
                      strip.text.y = element_text(
                        size = 4, color = "black", face = "plain"),
                      panel.spacing.y = unit(0.1, "lines"))
#### Generation/Divergence Time boxplot ####
my_vec <- c("1234,560", "5,555", "10,101")                            # Create example vector
my_vec 
my_vec_updated <- as.numeric(gsub(",", "", my_vec))                   # Convert example vector
my_vec_updated 

time_data <- read.table("E:/Share/Sweden_UU/Roc_Se_bumblebee/analysis/NJ_syl/Ne_data_syl_bal.txt",header = F)
time_data_final <- read.table("E:/Share/Sweden_UU/Roc_Se_bumblebee/analysis/NJ_syl/Ne_Fst_time_data.txt",header = T)

str(time_data_final)
time_data_t <- t(time_data)
str(time_data_t)
df_time <- as.data.frame(time_data_t)
str(df_time)
df_time_new <- df_time %>%
  mutate_at(c(1,2,3),as.factor)
str(df_time_new)

# Convert Data Frame Columns with Comma as Thousand Separator
# https://statisticsglobe.com/modify-numbers-with-comma-as-thousand-separator-in-r
df_time_new <- df_time
df_conv <- c("V2","V3")
df_time_new[,c("V2","V3")] <- lapply(df_time_new[,c("V2","V3")], function(x){
  as.numeric(as.character(gsub(",", "", x)))
})
df_time_new
# 
df_time_update <- df_time
df_time_update$V2 <- as.numeric(gsub(",", "", df_time$V2))
df_time_update$V2 <- as.numeric(as.character(gsub(",", "", df_time$V2)))
df_time_update$V3 <- as.numeric(as.character(gsub(",", "", df_time$V3)))
df_time_update[,df_conv] <- as.numeric(as.character(gsub(",", "", df_time[,df_conv])))
df_time_update[c("V2","V3")] <- as.numeric(as.character(gsub(",", "", df_time[c("V2","V3")])))
as.factor(as.character(gsub(",", "", df_time[c("V2","V3")])))

# another way
# https://stackoverflow.com/questions/1523126/how-to-read-data-when-some-numbers-contain-commas-as-thousand-separator
library(dplyr)
df_time_test <- df_time
df_time_test_conv1 <- df_time_test %>% mutate_at(2:3, readr::parse_number)
df_time_test_conv2 <- df_time_test %>% mutate_at(vars("V2","V3"), readr::parse_number)

Ne_data_header <- read.table("Ne_data_syl_bal_new.txt",header = F,stringsAsFactors = T)
Ne_data_header_t <- t(Ne_data_header)
Ne_data_header
str(Ne_data_header_t)
df <- as.data.frame(Ne_data_header_t)
str(df)
#
df_new <- as.data.frame(sapply(df[2], as.numeric))
str(df_new)
# https://stackoverflow.com/questions/22772279/converting-multiple-columns-from-character-to-numeric-format-in-r
library(dplyr)
df_new <- df %>%
  mutate_at(c(2:3),as.numeric)

colnames(df_new) <- c("Species","Low","Up")
Ne_data_t_new <- melt(df_new,id.var="Species")
Ne_data_final <- melt(time_data_final,id.var="Species")
time_data_final
Species_factor <- factor(Ne_data_t_new$Species)
class(Species_factor)
levels(Species_factor)
str(Ne_data_t_new)
species_order <- c("B.bal_US","B.bal_SE","B.syl_(lap)","B.lap_(syl)","B.inc_(lap)","B.lap_(inc)","B.syl_(inc)","B.inc_(syl)")
class(species_order)
default
[1] "B.bal_SE"    "B.bal_US"    "B.inc_(lap)" "B.inc_(syl)" "B.lap_(inc)" "B.lap_(syl)"
[7] "B.syl_(inc)" "B.syl_(lap)"
Species_factor
[1] "B.lap_(inc)" "B.inc_(lap)" "B.inc_(syl)" "B.syl_(inc)" "B.lap_(syl)" "B.syl_(lap)"
[7] "B.bal_SE"    "B.bal_US"
Species_factor <- factor(Species_factor,levels =(Species_factor)[c(8,7,6,5,4,3,2,1)])
Species_factor <- factor(Species_factor,levels =(Species_factor)[c(1,2,3,5,4,7,6,8)])
levels(Species_factor)
Ne_data_t_new$Species <- Species_factor
levels(Ne_data_t_new$Species)
#### ggplot boxplot ####
#### scientific notion #### 
# https://stackoverflow.com/questions/14563989/force-r-to-stop-plotting-abbreviated-axis-labels-scientific-notation-e-g-1e
# http://www.sthda.com/english/wiki/ggplot2-axis-ticks-a-guide-to-customize-tick-marks-and-labels
# geom_text - comma separated
# https://stackoverflow.com/questions/56490813/how-do-i-add-a-comma-separator-to-a-text-label-in-geom-text
require(scales)
p <- ggplot(Ne_data_final,aes(x=Species,y=value))+
  geom_boxplot(color="gray30")+
#  ylab(expression(paste(italic(N),"e (95% CI)")))+
  ylab(expression(paste("Generation/Year"," (95% CI)")))+
  xlab("Speciess")+
#  coord_flip()+
  geom_text(aes(label = scales::comma(value)),color="red",size=2,vjust = 0.5)+
#  geom_text(aes(label=value),color="red",size=2,vjust = 0.5)+
  theme_light()+
  theme(axis.title = element_text(size=8,colour = "black"),
        axis.text = element_text(size = 6,colour = "black"),
        axis.text.x = element_text(face = "italic"),
        panel.grid.minor = element_line(size = 0.5, linetype = 'solid',
                                        colour = "white"))+
#  scale_y_continuous(labels = scales::label_number())
  scale_y_continuous(labels = scales::comma)

ggsave("Ne_fst_time_data.US_SE.pdf",p,width = 4,height = 2)
getwd()

#### base R boxplot ####
boxplot(Ne_data,
        xlab="Species",
        ylab=expression(paste(italic(N),"e")),
        par(cex.lab=0.8), par(cex.axis=0.6))
text(labels=)

#### boot ####
mean_fst <- function(x,d){
  return(mean(x[d]))
}

mean_fst(3,4)
library(boot)
b1000_Fst_lap_inc=boot(fst_syl_lap_inc$Fst_lapponicus_incognitus,mean_fst,R=1000)

b5000_Fst_lap_inc=boot(fst_syl_lap_inc$Fst_lapponicus_incognitus,mean_fst,R=5000) # 95%   ( 0.3133,  0.3236 ) 
b8000_Fst_lap_inc=boot(fst_syl_lap_inc$Fst_lapponicus_incognitus,mean_fst,R=8000) # 95%   ( 0.3132,  0.3237 )  
b10000_Fst_lap_inc=boot(fst_syl_lap_inc$Fst_lapponicus_incognitus,mean_fst,R=10000) # 95%   ( 0.3132,  0.3236 )

b5000_Fst_lap_syl=boot(fst_syl_lap_inc$Fst_lapponicus_sylvicola,mean_fst,R=5000) # 95%   ( 0.1916,  0.1974 ) 
#### nan problem #####
b5000_Fst_inc_syl=boot(fst_syl_lap_inc$Fst_incognitus_sylvicola,mean_fst,R=5000) # problem ? 95%   ( 0.2375,  0.2477 )
b5000_Fst_mon_syl=boot(fst_syl_lap_inc$Fst_monticola_sylvicola,mean_fst,R=5000)
b5000_Fst_bal_Roc_Se=boot(fst_bal_Roc_Se$Fst_Roc_bal_Se_bal,mean_fst,R=5000)    # 95%   ( 0.1089,  0.1132 )
plot(fst_syl_lap_inc$Fst_incognitus_sylvicola)
str(fst_syl_lap_inc$Fst_lapponicus_sylvicola)
str(fst_syl_lap_inc$Fst_incognitus_sylvicola)

library(stringr)
x <- c("apple", "banana", "pear")
str_extract(fst_syl_lap_inc$Fst_incognitus_sylvicola,"NAN")

if('apple' %in% x){
  print("ap is in x")
}

if ('0.000' %in% fst_syl_lap){
  print("nan is found")
}else{
  print("nan is not found")
}

g <- grep("nan",fst_syl_lap_inc$Fst_incognitus_sylvicola)
g <- grep("nan",x)
g <- grepl("nan",x)
g <- regexpr("nan",x)
gregexpr("nan",x)
g
length(g)

print(b1000)
sd(b5000_Fst_bal_Roc_Se$t[,1])
plot(b5000_Fst_inc_syl)
sd(b5000_Fst_lap_inc$t[,1])
sd(b5000_Fst_lap_syl$t[,1])
sd(b5000_Fst_inc_syl$t[,1])
ci=boot.ci(b5000_Fst_lap_inc,type = "basic")
ci=boot.ci(b8000_Fst_lap_inc,type = "basic")
ci=boot.ci(b10000_Fst_lap_inc,type = "basic")
ci=boot.ci(b5000_Fst_lap_syl,type = "basic")
ci=boot.ci(b5000_Fst_inc_syl,type = "basic") # nan problem?
ci=boot.ci(b5000_Fst_bal_Roc_Se,type = "basic")
ci
cat("95% CI from ", ci$basic[1,4], " - ", ci$basic[1,5], "\n")



3*173458*(-log10(1-0.089))
3*173458*(-log10(1-0.1132))
3*158075*(-log(1-0.089))

