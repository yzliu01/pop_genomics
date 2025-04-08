#### generate formatted R script in WORD
# https://stackoverflow.com/questions/10128702/how-to-preserve-formatting-from-rstudio-when-copy-pasting-to-word

####### vcftools stats
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/fst/syl_snp_stat")
getwd()
list.files()

ind_missing_syl <- read.csv("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.vcf.imiss",header = T,sep = "\t")
snp_den_syl <- read.csv("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.vcf.5k.snpden",header = T,sep = "\t")
f_site_missing_syl <- read.csv("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.vcf.lmiss",header = T,sep = "\t")
head(f_ind_missing_syl)
head(snp_den_syl)
head(f_missing_syl)
str(f_missing_syl)
str(snp_den_syl)
f_missing_syl$new_pos <- c(1:3307642)
head(f_missing_syl)
snp_den_syl$new_pos <- c(1:49435)

library(ggplot2)

a1 <- head(f_missing_syl)
a1

  # plot a part of the data
  # group issue: https://stackoverflow.com/questions/27082601/ggplot2-line-chart-gives-geom-path-each-group-consist-of-only-one-observation

ggplot(subset(f_missing_syl,new_pos %in% c(1:600)),aes(new_pos,F_MISS,group=1))+
  geom_point(size=0.2)+
  ylim(0,0.3)

ggplot(subset(f_missing_syl,new_pos %in% c(1:600)),aes(new_pos,F_MISS,group=1))+
  geom_point(size=0.2)+
  geom_line()

a <- ggplot(f_missing_syl,aes(new_pos,F_MISS,group=1))+
  geom_line()+
  ylim(0,0.3)+
  theme_classic()+
  labs(x=expression(paste("New coordinate across contigs (",italic("Bombus monticola/lapponicus"),")")),y="Missing rate per site)")
  
ggsave(a,filename = "Missing data per site for B_mon_lap (DP3_GQ20_biSNP_maf0.02_f_missing0.2).pdf",width = 8,height = 5)

###############
b <- ggplot(snp_den_syl,aes(new_pos,VARIANTS.KB))+
  geom_point(size=0.5,stroke=0)+
  theme_classic()+
  labs(x=expression(paste("New coordinate across contigs (",italic("Bombus monticola/lapponicus"),")")),y="Variant No. per kb)")

ggsave(b,filename = "Variant No. per kb for B_mon_lap (DP3_GQ20_biSNP_maf0.02_f_missing0.2).pdf",width = 8,height = 5)

###############
ggplot(f_ind_missing_syl,aes(INDV,F_MISS))+
  geom_line()+
  geom_smooth(method = "loess", se = FALSE, 
              span = 0.25, linetype=3,color='#2980B9', size = 0.1)

c <- ggplot(f_ind_missing_syl,aes(INDV,F_MISS))+
  geom_bar(stat = "identity",col="black",fill="gray",size=0.1)+
  theme_classic()+
  labs(x=expression(paste("Individuals (",italic("Bombus monticola/lapponicus"),")")),y="Missing data per individual (%)")+
  theme(axis.text = element_text(colour = "black"),
        axis.text.x = element_text(size=3,angle = 85,vjust = 0,hjust = 0))

ggsave(c,filename = "Missing_data_per_ind_B_mon_lap (DP3_GQ20_biSNP_maf0.02_f_missing0.2).pdf",width = 8,height = 5)

############## Fst

setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/fst/fst")
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/fst/fst/pas/50K/./edited_columns/")
list.files()
fst1 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Ammarnäs_SL_4Uppsala_Dalama_DA_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst2 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Ammarnäs_SL_8Gotland_GT_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst3 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Ammarnäs_SL_8Harjedalen_NS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst4 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Ammarnäs_SL_8V_Ö-gotland_SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst5 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Uppsala_Dalama_DA_8Gotland_GT_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst6 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Uppsala_Dalama_DA_8Harjedalen_NS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst7 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_4Uppsala_Dalama_DA_8V_Ö-gotland_SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst8 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_8Gotland_GT_8Harjedalen_NS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst9 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_8Gotland_GT_8V_Ö-gotland_SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst10 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_8Harjedalen_NS_8V_Ö-gotland_SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst11 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_23Abisko_4Ammarnäs_SL_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst12 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_23Abisko_4Uppsala_Dalama_DA_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst13 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_23Abisko_8Gotland_GT_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst14 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_23Abisko_8Harjedalen_NS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst15 <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2_23Abisko_8v-o-gotland_SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")
fst_mix <- read.csv("Bpas_55_dip_SNP_concat.DP3_GQ20_biSNP_maf0.02_f_missing0.2.vcf.gz_23Abisko_Mix_4NS_4SS_50K.windowed.weir.fst.edited.txt",header = T,sep = "\t")

fst16 <- read.csv("DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.lap_108Abisko_19JamHar_out_5K_win_fst.windowed.weir.fst",header = T,sep = "\t")
fst17 <- read.csv("DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.mon_64Abisko_16JamHar_out_5K_win_fst.windowed.weir.fst",header = T,sep = "\t")


####  merged_coordinate_gene_name.txt -> 
#### E:/Share/Sweden_UU/SW_mountain_bee/analysis/annotation
library(plyr) # merge and keep original order
# https://stackoverflow.com/questions/42851020/in-r-merge-2-dataframes-while-maintaining-the-row-order-of-the-first-dataframe
co_gene_name <- read.table("E:/Share/Sweden_UU/SW_mountain_bee/analysis/annotation/merged_coordinate_gene_name.sort_uniq_range.txt",sep = "\t",header = T)
head(co_gene_name)
str(co_gene_name)
# combine_file_1 <- merge(fst1,co_gene_name,by="CHROM.BIN_START.BIN_END",sort = T, all = TRUE)
combine_file <- plyr::join(fst1,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
tail(combine_file)
str(combine_file)

head(fst1)
tail(fst1)
str(fst1)
fst1$New_coordinate <- c(1:5652)

combine_file$New_coordinate <- c(1:5652)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
# https://stackoverflow.com/questions/11275187/replace-negative-values-by-zero
# negative Fst to o
# https://www.biostars.org/p/132253/

fst1$MEAN_FST[fst1$MEAN_FST < 0] <- 0

#### conditional print
# https://statisticsglobe.com/return-data-frame-row-based-on-value-in-column-in-r
fst_new <- fst1[fst1$MEAN_FST == 1,]
fst_1_2 <- combine_file[combine_file$MEAN_FST > 0.6,]
head(fst_1_2)

head(fst_new)
fst1[3976:3980,]
write.table(combine_file,file = "combine_file_Ammarnas_Uppsala_Dalama.txt",quote = F,row.names = F,col.names = T,sep = "\t")

ggplot(subset(fst1,New_coordinate %in% c(1:600)),aes(New_coordinate,MEAN_FST,group=1))

fst_N_variant_2 <- fst1[fst1$N_VARIANTS < 2,]
fst_N_variant_2 <- fst1[fst1$N_VARIANTS < 2,]
str(fst_N_variant_2)

plot_fst_N_variant_2 <- ggplot(fst_N_variant_2,aes(New_coordinate,N_VARIANTS,group=1))+
  geom_point(size=0.5,stroke=0)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Ammarnäs "][italic(vs)][" Uppsala_Dalama"],")")),
       y=expression(paste("N_VARIANTS < 2 in 50K win (63 windows in total)")))
ggsave(plot_fst_N_variant_2,filename = "fst_N_variant_in_50K_win_less than 2 B_pas Ammarnas vs Uppsala_Dalama(50K).pdf",width = 6,height = 4)

library(ggrepel)
#plot1 <- ggplot(fst1,aes(New_coordinate,MEAN_FST,group=1))
plot1 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Ammarnäs "][italic(vs)][" Uppsala_Dalama"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.4),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.4)$MEAN_FST,
                  aes(label=Gene_Name),size=1.6,
                  segment.size=0.1,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))


ggsave(plot1,filename = "Fst B_pas Ammarnas vs Uppsala_Dalama (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)


ggplot(subset(fst1,New_coordinate %in% c(1:600)),aes(New_coordinate,MEAN_FST,group=1))

### --------------
### 4Ammarnäs_SL_8Gotland_GT
str(fst2)
fst2$New_coordinate <- c(1:5673)
fst2$MEAN_FST[fst2$MEAN_FST < 0] <- 0
head(fst2)

combine_file <- plyr::join(fst2,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5673)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_2 <- fst2[fst2$MEAN_FST > 0.6,]
head(fst_1_2)

# plot2 <- ggplot(fst2,aes(New_coordinate,MEAN_FST,group=1))
plot2 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Ammarnäs "][italic(vs)][" Gotland"],")")),
           y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=0.6,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))


ggsave(plot2,filename = "Fst B_pas Ammarnas vs Gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 4Ammarnäs_SL_8Harjedalen_NS
### 
str(fst3)
fst3$New_coordinate <- c(1:5662)
fst3$MEAN_FST[fst3$MEAN_FST < 0] <- 0
head(fst3)

combine_file <- plyr::join(fst3,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5662)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_3 <- fst3[fst3$MEAN_FST > 0.6,]
head(fst_1_3)

plot3 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Ammarnäs "][italic(vs)][" Harjedalen"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.3),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.3)$MEAN_FST,
                  aes(label=Gene_Name),size=1,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))

ggsave(plot3,filename = "Fst B_pas Ammarnas vs Harjedalen (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 4Ammarnäs_SL_8V_Ö-gotland_SS
str(fst4)
fst4$New_coordinate <- c(1:5669)
fst4$MEAN_FST[fst4$MEAN_FST < 0] <- 0
head(fst4)

combine_file <- plyr::join(fst4,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5669)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_4 <- fst4[fst4$MEAN_FST > 0.6,]
head(fst_1_4)

plot4 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Ammarnäs "][italic(vs)][" V_Ö-gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.3),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.3)$MEAN_FST,
                  aes(label=Gene_Name),size=1.5,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))

ggsave(plot4,filename = "Fst B_pas Ammarnas vs V_O-gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 4Uppsala_Dalama_DA_8Gotland_GT
str(fst5)
fst5$New_coordinate <- c(1:5673)
fst5$MEAN_FST[fst5$MEAN_FST < 0] <- 0
head(fst5)

combine_file <- plyr::join(fst5,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5673)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_5 <- fst5[fst5$MEAN_FST > 0.6,]
head(fst_1_5)
fst_1_5
plot5 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Uppsala_Dalama "][italic(vs)][" Gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=0.8,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot5,filename = "Fst B_pas Uppsala_Dalama vs Gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 4Uppsala_Dalama_DA_8Harjedalen_NS
str(fst6)
fst6$New_coordinate <- c(1:5663)
fst6$MEAN_FST[fst6$MEAN_FST < 0] <- 0
head(fst6)

combine_file <- plyr::join(fst6,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5663)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

plot6 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Uppsala_Dalama "][italic(vs)][" Harjedalen"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.4),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.4)$MEAN_FST,
                  aes(label=Gene_Name),size=1.2,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot6,filename = "Fst B_pas Uppsala_Dalama vs Harjedalen (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 4Uppsala_Dalama_DA_8V_Ö-gotland_SS
str(fst7)
fst7$New_coordinate <- c(1:5667)
fst7$MEAN_FST[fst7$MEAN_FST < 0] <- 0
head(fst7)

combine_file <- plyr::join(fst7,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5667)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

plot7 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Uppsala_Dalama "][italic(vs)][" V_Ö-gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=0.8,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot7,filename = "Fst B_pas Uppsala_Dalama vs V_O-gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 8Gotland_GT_8Harjedalen_NS
str(fst8)
fst8$New_coordinate <- c(1:5674)
fst8$MEAN_FST[fst8$MEAN_FST < 0] <- 0
head(fst8)

combine_file <- plyr::join(fst8,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5674)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_8 <- fst8[fst8$MEAN_FST > 0.6,]
head(fst_1_8)
fst_1_8

plot8 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Gotland "][italic(vs)][" Harjedalen"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=0.7,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))

ggsave(plot8,filename = "Fst B_pas Gotland vs Harjedalen (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 8Gotland_GT_8V_Ö-gotland_SS
str(fst9)
fst9$New_coordinate <- c(1:5680)
fst9$MEAN_FST[fst9$MEAN_FST < 0] <- 0
head(fst9)

combine_file <- plyr::join(fst9,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5680)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_9 <- fst9[fst9$MEAN_FST > 0.6,]
head(fst_1_9)
fst_1_9

plot9 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Gotland "][italic(vs)][" V_Ö-gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.6, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=0.6,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 800))

ggsave(plot9,filename = "Fst B_pas Gotland vs V_O-gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 8Harjedalen_NS_8V_Ö-gotland_SS
str(fst10)
fst10$New_coordinate <- c(1:5674)
fst10$MEAN_FST[fst10$MEAN_FST < 0] <- 0
head(fst10)

combine_file <- plyr::join(fst10,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5674)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

plot10 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Harjedalen "][italic(vs)][" V_Ö-gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.5),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.5)$MEAN_FST,
                  aes(label=Gene_Name),size=0.8,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot10,filename = "Fst B_pas Harjedalen vs V_O-gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 23Abisko_4Ammarnäs_SL
str(fst11)
fst11$New_coordinate <- c(1:5686)
fst11$MEAN_FST[fst11$MEAN_FST < 0] <- 0
head(fst11)

combine_file <- plyr::join(fst11,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5686)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_11 <- fst11[fst11$MEAN_FST > 0.5,]
fst_1_11

plot11 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" Ammarnäs"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.4),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.4)$MEAN_FST,
                  aes(label=Gene_Name),size=0.8,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot11,filename = "Fst B_pas Abisko vs Ammarnas (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 23Abisko_4Uppsala_Dalama_DA
str(fst12)
fst12$New_coordinate <- c(1:5692)
fst12$MEAN_FST[fst12$MEAN_FST < 0] <- 0
head(fst12)

combine_file <- plyr::join(fst12,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5692)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_12 <- fst12[fst12$MEAN_FST > 0.5,]
fst_1_12

plot12 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" Uppsala_Dalama"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=1.2,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot12,filename = "Fst B_pas Abisko vs Uppsala_Dalama (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 23Abisko_8Gotland_GT
str(fst13)
fst13$New_coordinate <- c(1:5695)
fst13$MEAN_FST[fst13$MEAN_FST < 0] <- 0
head(fst13)

combine_file <- plyr::join(fst13,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5695)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_13 <- fst13[fst13$MEAN_FST > 0.5,]
fst_1_13

plot13 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" Gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.6),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.6)$MEAN_FST,
                  aes(label=Gene_Name),size=1,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 600))

ggsave(plot13,filename = "Fst B_pas Abisko vs Gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 23Abisko_8Harjedalen_NS
## hits for this pair
co_gene_name <- read.table("E:/Share/Sweden_UU/SW_mountain_bee/analysis/annotation/Pas_Abisko_Har.merged_coordinate_gene_name.sort_uniq_range.txt",sep = "\t",header = T)
head(co_gene_name)
str(co_gene_name)
#

str(fst14)
fst14$New_coordinate <- c(1:5691)
fst14$MEAN_FST[fst14$MEAN_FST < 0] <- 0
head(fst14)

# filter small number of variants
fst_14_new <- fst14[fst14$N_VARIANTS  > 10,]
head(fst_14_new)
str(fst_14_new)
fst_1_14 <- fst_14_new[fst_14_new$MEAN_FST > 0.3,]

combine_file <- plyr::join(fst14,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5691)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

combine_file_new <- combine_file[combine_file$N_VARIANTS  > 10,]
head(combine_file_new)
str(combine_file_new)

fst_1_14 <- fst14[fst14$MEAN_FST > 0.3,]
combine_file_14_1 <- combine_file_14[combine_file_14$MEAN_FST > 0.5,]
head(fst_1_14)
head(combine_file_14_1)

plot14 <- ggplot(combine_file_new,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" Harjedalen"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
#  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
#  geom_text(aes(label=ifelse(MEAN_FST>0.3,as.character(Gene_Name),'')),hjust=0,vjust=0,size=1)

#  geom_text_repel(data=subset(combine_file_new,MEAN_FST > 0.3),
                  nudge_y = 1-subset(combine_file_new,MEAN_FST > 0.3)$MEAN_FST,
                  aes(label=Gene_Name),size=1,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))

ggsave(plot14,filename = "Fst B_pas Abisko vs Harjedalen (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

### 23Abisko_8v-o-gotland_SS
str(fst15)
head(fst15)
fst15$New_coordinate <- c(1:5700)
fst15$MEAN_FST[fst15$MEAN_FST < 0] <- 0
head(fst15)

combine_file <- plyr::join(fst15,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5700)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

fst_1_15 <- fst15[fst15$MEAN_FST > 0.5,]
head(fst_1_15)

plot15 <- ggplot(combine_file,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" V-O-gotland"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))+
  geom_hline(yintercept = 0.5, linetype="solid",color="red",size=0.3)+
  geom_text_repel(data=subset(combine_file,MEAN_FST > 0.3),
                  nudge_y = 1-subset(combine_file,MEAN_FST > 0.3)$MEAN_FST,
                  aes(label=Gene_Name),size=1,
                  segment.size=0.05,
                  show.legend=FALSE,
                  #                  box.padding   = 0.4,
                  #                  point.padding = 0,
                  #                  force         = 1,
                  direction = c("both", "y", "x"),
                  max.overlaps = getOption("ggrepel.max.overlaps", 500))

ggsave(plot15,filename = "Fst B_pas Abisko vs V-O-gotland (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K).pdf",width = 8,height = 5)

############# fst_mix
str(fst_mix)
fst_mix$New_coordinate <- c(1:5697)
fst_mix$MEAN_FST[fst_mix$MEAN_FST < 0] <- 0
head(fst_mix)

# filter small number of variants
fst_mix_new <- fst_mix[fst_mix$N_VARIANTS  > 10,]
head(fst_mix_new)
str(fst_mix_new)
fst_1_mix<- fst_mix_new[fst_mix_new$MEAN_FST > 0.3,]

combine_file <- plyr::join(fst_mix,co_gene_name, by='CHROM.BIN_START.BIN_END')
head(combine_file)
str(combine_file)
combine_file$New_coordinate <- c(1:5691)
combine_file$MEAN_FST[combine_file$MEAN_FST < 0] <- 0
head(combine_file)
str(combine_file)

combine_file_new <- combine_file[combine_file$N_VARIANTS  > 10,]
head(combine_file_new)
str(combine_file_new)

plot_mix <- ggplot(fst_mix_new,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0,alpha=0.6)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus pascuorum")["Abisko "][italic(vs)][" 4SS_4SN"],")")),
       y=expression(paste(italic(F)[ST]," (50 kb window)")))



###################################### 
#### fst16 lap_108Abisko_19JamHar ####
str(fst16)
fst16$New_coordinate <- c(1:48702)

density_lap <- ggplot(fst16,aes(New_coordinate,N_VARIANTS,group=1))+
  geom_line()+
  #ylim(0,0.3)+
  theme_classic()+
  labs(x=expression(paste("New coordinate across contigs (",italic("Bombus lapponicus"),")")),y="N_VARIANTS")
ggsave(density_lap,filename = "density_lap.DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.5k.pdf",width = 6,height = 4)


fst16$MEAN_FST[fst16$MEAN_FST < 0] <- 0
head(fst16)
plot16 <- ggplot(fst15,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus lapponicus")["Abisko "][italic(vs)][" JamHar"],")")),
       y=expression(paste(italic(F)[ST]," (5 kb window)")))

ggsave(plot16,filename = "Fst B_lap Abisko vs JamHa (DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip).pdf",width = 8,height = 5)


lap_108Abisko_19JamHa
mon_64Abisko_16JamHar


#### fst17 mon_64Abisko_16JamHar ####
head(fst17)
str(fst17)
fst17$New_coordinate <- c(1:48843)

density_mon <- ggplot(fst17,aes(New_coordinate,N_VARIANTS,group=1))+
  geom_line()+
  #ylim(0,0.3)+
  theme_classic()+
  labs(x=expression(paste("New coordinate across contigs (",italic("Bombus monticola"),")")),y="N_VARIANTS")
ggsave(density_mon,filename = "density_mon.DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip.5k.pdf",width = 6,height = 4)

fst17$MEAN_FST[fst16$MEAN_FST < 0] <- 0
head(fst17)
plot17 <- ggplot(fst17,aes(New_coordinate,MEAN_FST,group=1))+
  geom_point(size=0.5,stroke=0)+
  theme_classic()+
  theme(axis.text = element_text(colour = "black",size = 8),axis.title = element_text(colour = "black",size = 9))+
  labs(x=expression(paste("No. of windows across genome (",italic("Bombus monticola")["Abisko "][italic(vs)][" JamHar"],")")),
       y=expression(paste(italic(F)[ST]," (5 kb window)")))

ggsave(plot17,filename = "Fst B_mon Abisko vs JamHa (DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip).pdf",width = 8,height = 5)

library(ggplot2)
library(gridExtra)
### merge plots
#merge1 <- grid.arrange(plot1,plot2,plot3,plot4,ncol=1,nrow=4)
merge1 <- plot_grid(plot1,plot2,plot3,plot4,ncol=1,nrow=4, align="v")
merge2 <- plot_grid(plot5,plot6,plot7,plot8,plot9,plot10,ncol=1,nrow=6,align="v")
merge3 <- plot_grid(plot11,plot12,plot13,plot14,plot15,ncol=1,nrow=5,align="v")
merge4 <- plot_grid(plot16,plot17,ncol=1,nrow=2,align="v")

#### align combined plots #### 
install.packages("cowplot")
library(cowplot)
plot_grid(plot1,plot2,plot3,plot4,ncol=1,nrow=4, align="hv")

ggsave(merge1,filename = "merged_Fst B_pas Ammarnas vs others (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K)-gene.pdf",width = 8,height = 8)
ggsave(merge2,filename = "merged_Fst B_pas Uppsala_Gotland_Harjedalen (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K)-gene.pdf",width = 8,height = 10)
ggsave(merge3,filename = "merged_Fst B_pas Abisko vs others (DP3_GQ20_biSNP_maf0.02_f_missing0.2.50K)-gene.pdf",width = 8,height = 9)
ggsave(merge4,filename = "merged_Fst B_mon_lap Abisko vs JamHa (DP3_GQ20_biSNP_maf0.02_f_missing0.2.hap2dip).pdf",width = 6,height = 6)



#### manual Fst & plot multiple columns: lap_allele_freq ####
# linux: [yzliu@rackham3 vcftools_stats]$ 
# paste gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing099.118Female_89Male.hwe0001.Male.frq gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing099.118Female_89Male.hwe0001.Female.frq | cut -f 1,2,3,4,5,6,10,11,12 | sed '1d;s/:/\t/g' | sed '1i CHROM\tPOS\tN_ALLELES\tN_CHR_M\tREF_M\tREF_M_frq\tALT_M\tALT_M_frq\tN_CHR_F\tREF_F\tREF_F_frq\tALT_F\tALT_F_frq' > gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing099.118Female_89Male.hwe0001.53female_55male.frq
setwd("E:/Share/Sweden_UU/SW_mountain_bee/mapping/freebayes_gatk_allele_freq")
list.files()
lap_freq <- read.delim("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.53female_55male.frq",header = T,sep = "\t")
gatk_contig_1_2_freq <- read.delim("gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing05.hf_PASS.frq.txt",header = F,sep = "\t")[-1,]
fb_contig_1_2_freq <- read.delim("bcftools_freebayes_vcftools_filtered_DP3_GQ20_BiSNP_maf005_missing05_Bsyl.contig_001_002_merge_M_F.maf005_missing05.frq.txt",header = F,sep = "\t")[-1,]
head(fb_contig_1_2_freq)
str(fb_contig_1_2_freq)
lap_freq_hwe <- read.delim("gatk_89haploid_118diploid_Bsyl.contig_001_002.BiSNP_DP3_Q20_maf005_missing099.118Female_89Male.hwe0001.53female_55male.frq",header = T,sep = "\t")
head(lap_freq_hwe)

#issue - fb_contig_1_2_freq <- read.table("bcftools_freebayes_vcftools_filtered_DP3_GQ20_BiSNP_maf005_missing05_Bsyl.contig_001_002_merge_M_F.maf005_missing05.frq.txt",header = F,sep = "\t")[-1,]
head(lap_freq)
str(lap_freq)
head(gatk_contig_1_2_freq)
head(fb_contig_1_2_freq)
####
#library(stringr)
library(stringi)
df1_new <- gsub("DA.*","DA",df1$V2)
#### replace string ####
#https://www.statology.org/r-gsub-multiple-patterns/

gatk_contig_1_2_freq[,5:6] <- stri_replace_all_regex(c(gatk_contig_1_2_freq$V5,gatk_contig_1_2_freq$V6),
                                                   pattern=c("A:","T:","C:","G:"),
                                                   replacement=c("","","",""),
                                                   vectorize=F)

fb_contig_1_2_freq[,5:6] <- stri_replace_all_regex(c(fb_contig_1_2_freq$V5,fb_contig_1_2_freq$V6),
                                                 pattern=c("A:","T:","C:","G:"),
                                                 replacement=c("","","",""),
                                                 vectorize=F)
head(fb_contig_1_2_freq)

merge_fb_gatk <- merge.data.frame(fb_contig_1_2_freq,gatk_contig_1_2_freq,by=c("V1","V2"),sort = F)
merge_fb_gatk[,4] <- stri_replace_all_regex(merge_fb_gatk$V4.x,
                                            pattern=" ",
                                            replacement="",
                                            vectorize=F)
write.table(merge_fb_gatk,file = "merge_gatk_fr_allele_freq.txt",quote = F,row.names = F,sep = "\t")
# sort = T works;
#https://stackoverflow.com/questions/49980961/merging-data-frames-in-r-results-not-sorted
# alternative way # X[with(X, order(one, two)),]
#https://chartio.com/resources/tutorials/how-to-sort-a-data-frame-by-multiple-columns-in-r/
#https://stackoverflow.com/questions/1296646/sort-order-data-frame-rows-by-multiple-columns
alt_sort <- merge_fb_gatk[with(merge_fb_gatk, order(V1, V2)),]
head(alt_sort)
str(merge_fb_gatk)
head(merge_fb_gatk,n=3L)
remove_sp_merge_fb_gatk <- trimws(merge_fb_gatk$V5.x, which=c("both"))
head(gsub(" ", "",merge_fb_gatk))

# https://stackoverflow.com/questions/20760547/removing-whitespace-from-a-whole-data-frame-in-r
library("dplyr")
str(merge_fb_gatk)
merge_fb_gatk %>%
  mutate_all(trimws)

head(merge_fb_gatk)

#### subset data for a specific contig
head(subset(merge_fb_gatk,merge_fb_gatk$V1=="contig_002"))

#### use a second delimiter when "A:" is not replaced with ""
#https://stackoverflow.com/questions/20075135/multiple-separators-for-the-same-file-input-r
install.packages("splitstackshape")
library(splitstackshape)
head(merge_fb_gatk)
merge_fb_gatk_del <- concat.split(merge_fb_gatk,split.col =c("V5.x","V6.x","V5.y","V6.y"),sep = ":",drop = T)
head(merge_fb_gatk_del)
str(merge_fb_gatk_del)
write.table(merge_fb_gatk_del,file = "merge_fb_gatk_allele_freq_sub_colon.txt",quote = F,row.names = F,sep = "\t")
head(merge_gatk_fr_del)
merge_fb_gatk_contig_pos = select(merge_gatk_fr_del,1,2)
head(merge_fb_gatk_contig_pos)
write.table(merge_fb_gatk_contig_pos,file = "merge_fb_gatk_common_allele_contig_pos.txt",quote = F,row.names = F,col.names = F, sep = "\t")
#### find rows that two columns are not equal
#https://stackoverflow.com/questions/59583932/find-rows-that-are-not-equal-identical-in-two-columns-including-nas
df <- subset(merge_fb_gatk_del,merge_fb_gatk_del$V5.x_1!=merge_fb_gatk_del$V5.y_1)
df <- subset(merge_fb_gatk_del,merge_fb_gatk_del$V6.x_1!=merge_fb_gatk_del$V6.y_1)
df <- subset(merge_fb_gatk_del,merge_fb_gatk_del$V5.x_1==merge_fb_gatk_del$V5.y_1)
head(df)

gatk_contig_1_2_freq=gatk_contig_1_2_freq[-1,]
fb_contig_1_2_freq=fb_contig_1_2_freq[-1,]

head(merge_fb_gatk_del)
str(merge_fb_gatk_del)
merge_fb_gatk_del$Coord <- c(1:76893)


#### reshape data for plotting multiple column ####
merge_fb_gatk_del_reshape <- data.frame(x=merge_gatk_fr_del$Coord,
                                   y=c(merge_gatk_fr_del$V5.x_2,merge_gatk_fr_del$V5.y_2),
                                   group=c(rep("V5.x_2",76893),
                                           rep("V5.y_2",76893)))
head(merge_fb_gatk_del_reshape)

#### replace column/group names with smooth line
# https://www.geeksforgeeks.org/how-to-plot-a-smooth-line-using-ggplot2-in-r/
# https://www.datanovia.com/en/blog/how-to-plot-a-smooth-line-using-ggplot2/
library(stringi) # for "stri_replace_all_regex" function
merge_fb_gatk_del_reshape[,3] <- stri_replace_all_regex(merge_fb_gatk_del_reshape$group,
                                            pattern=c("V5.x_2","V5.y_2"),
                                            replacement=c("fb_ref_allle","gatk_ref_allele"),
                                            vectorize=F)

library(ggplot2)
#### Ref allele freq is slightly greater than that of freebayes
ggp_fb_gatk_syl <- ggplot(subset(merge_fb_gatk_del_reshape, x<500),aes(x,y,col=group))+
  geom_line(alpha=0.6,size=0.1)+
  theme_classic()+
  theme(axis.text = element_text(size = 6,colour = "black"),
        axis.title = element_text(size=7),
        legend.position = "top",
        legend.title = element_text(size=7),
        legend.text = element_text(size=6))+
  labs(color=paste('Variant callers'),
       x="Variant Site Coord",y="Allele Freq (Freebayes and GATK)")+
  stat_smooth(method = loess)

  geom_smooth(method = loess,formula = y ~ poly(x, 2), se = FALSE)
#  geom_smooth(method = lm)

write.table()  
  
  
install.packages("knitr")
library(knitr) 
stitch("E:/Share/Sweden_UU/SW_mountain_bee/analysis/fst/syl_snp_stat/Bombus_vcftools_stats_plot.R")
stitch(script="E:/Share/Sweden_UU/SW_mountain_bee/analysis/fst/syl_snp_stat/Bombus_vcftools_stats_plot.R", system.file("misc", "Bombus_vcftools_stats_plot.R.Rhtml", package="knitr"))
  

#### manual calculation Fst in R ####
# https://stackoverflow.com/questions/16358987/errorattempt-to-apply-non-function
library("dplyr") # use  %>% 
lap_freq$fst_dip_hap <- 1-2*(lap_freq$REF_M_frq*lap_freq$ALT_M_frq+lap_freq$REF_F_frq*lap_freq$ALT_F_frq)/(lap_freq$REF_M_frq+lap_freq$REF_F_frq)/(lap_freq$ALT_M_frq+lap_freq$ALT_F_frq)
head(lap_freq)
lap_freq_hwe$fst_dip_hap <- 1-2*(lap_freq_hwe$REF_M_frq*lap_freq_hwe$ALT_M_frq+lap_freq_hwe$REF_F_frq*lap_freq_hwe$ALT_F_frq)/(lap_freq_hwe$REF_M_frq+lap_freq_hwe$REF_F_frq)/(lap_freq_hwe$ALT_M_frq+lap_freq_hwe$ALT_F_frq)
head(lap_freq_hwe)

write.table(lap_freq_hwe,file = "lap_freq_male_female_hwe.per_site.all.fst",quote = F,row.names = F,sep = "\t")

## change scientific notion
# https://datacornering.com/remove-scientific-notation-in-r/
# https://stackoverflow.com/questions/39623636/forcing-r-output-to-be-scientific-notation-with-at-most-two-decimals
format(4.470862e-01, scientific = F, digits = 3)
#[1] 0.4470862
sprintf("%.3f", 4.470862e-01)
# use sci notion: https://stackoverflow.com/questions/39623636/forcing-r-output-to-be-scientific-notation-with-at-most-two-decimals
# remove sci notion: https://statisticsglobe.com/format-decimal-places-in-r
format(round(data,6), scientific = F)
lap_freq_hwe$fst_dip_hap <- format(round(lap_freq_hwe$fst_dip_hap,6), scientific = F)
str(lap_freq_hwe)

library(dplyr)
lap_freq=select(lap_freq,-14) #https://www.listendata.com/2015/06/r-keep-drop-columns-from-data-frame.html
head(lap_freq[,1:13])
################## subset data test
lap_freq_subset <- lap_freq[1:500,]
str(lap_freq_subset)
lap_freq_subset$Coord <- c(1:500)

fst_sbuset_1$Coord <- c(1:7156)
head(fst_sbuset_1)
str(fst_sbuset_1)

fst_sbuset_1_reshape <- data.frame(x=fst_sbuset_1$Coord,
                               y=c(fst_sbuset_1$REF_M_frq,fst_sbuset_1$REF_F_frq),
                               group=c(rep("REF_M_frq",7156),
                                       rep("REF_F_frq",7156)))
head(fst_sbuset_1_reshape)
tail(fst_sbuset_1_reshape)
##################
#### data reshape ####
# https://statisticsglobe.com/plot-all-columns-of-data-frame-in-r
lap_freq$Coord_all <- c(1:2541874)
lap_freq_reshape_all <- data.frame(x=lap_freq$Coord_all,
                                      y=c(lap_freq$REF_M_frq,lap_freq$REF_F_frq),
                                      group=c(rep("REF_M_frq",nrow(lap_freq)),
                                              rep("REF_F_frq",nrow(lap_freq))))

head(lap_freq_reshape_all)

lap_freq_subset1 <- subset(lap_freq_reshape,y>0.8)
str(lap_freq_subset1)
lap_freq_subset1 %>%
  group_by(group) %>%
  summarise(n=n())

lap_freq_subset1$Coord_subset <- c(1:2915054)
lap_freq_reshape_subset <- data.frame(x=lap_freq_subset1$Coord_subset,
                                      y=c(lap_freq_subset1$REF_M_frq,lap_freq_subset1$REF_F_frq),
                                      group=c(rep("REF_M_frq",1437933),
                                              rep("REF_F_frq",1477121)))

str(group)
head(lap_freq_reshape_subset)
tail(lap_freq_reshape_subset)

library(ggplot2)

ggp_M_F_all_freq <- ggplot(lap_freq_reshape_all,aes(x,y,col=group))+
  geom_point(alpha=0.2,size=0.4)+
  theme_classic()+
  theme(axis.text = element_text(size = 6,colour = "black"),
        axis.title = element_text(size=7),
        legend.title = element_text(size=7),
        legend.text = element_text(size=6))+
  labs(color=paste('Sex groups'),
       x="Genome_coord",y="Ref. allele frequency (B. lapponicus males vs females)")

#  scale_x_continuous(labels = comma)+
#  scale_y_discrete(labels = function(x) round(as.numeric(x), digits=2))

ggp_M_F_freq + facet_grid(group ~ .)

#### plot manually calculated Fst in ggplot - remove missing data
# https://statisticsglobe.com/remove-na-values-from-ggplot2-plot-in-r
df_complete <- df[complete.cases(df), ]        # Remove incomplete rows
df_complete

fst_sbuset <- lap_freq_hwe[lap_freq_hwe$fst_dip_hap > 0.2,]
head(fst_sbuset)
str(fst_sbuset)
str(lap_freq_hwe)
lap_freq_hwe$Coord <- c(1:576692)
library(dplyr)
data_subset_freq=select(fst_sbuset,c(-3,-4,-5,-7,-9,-10,-12,-14))
data_subset_freq_hwe=select(fst_sbuset,c(1,2))

## all data
data_subset_freq=select(lap_freq,c(1,2,14))
head(data_subset_freq)
fst_sbuset_1 <- data_subset_freq[data_subset_freq$fst_dip_hap > 0.25,]
str(fst_sbuset_1)
head(fst_sbuset_1)

write.table(data_subset_freq,file="gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.53female_vs_55male.frq_per_site_fst_chr.txt",sep = "\t",quote = F,row.names = F)
write.table(data_subset_freq_hwe,file="data_subset.syl_lap_M_F.freq_hwe_contig_pos_fst02.txt",sep = "\t",quote = F,row.names = F)

head(fst_sbuset$CHROM,fst_sbuset$POS,fst_sbuset$N_CHR_M,fst_sbuset$REF_M_frq,fst_sbuset$N_CHR_F,fst_sbuset$ALT_F_frq,fst_sbuset$fst_dip_hap,fst_sbuset$Coord)
##https://statisticsglobe.com/change-formatting-of-numbers-of-ggplot2-plot-axis-in-r
# change axis text to non-sci notation
install.packages("scales")
library("scales")
ggp_M_F_hwe_fst<- ggplot(lap_freq_hwe,aes(Coord,fst_dip_hap))+
  geom_point(alpha=0.1,size=0.6,color="blue")+
  theme_classic()+
  theme(axis.text = element_text(size = 5,colour = "black"))+
  labs(x="Genome_coord",y="Fst between B. lapponicus males and females")+
  scale_x_continuous(labels = comma)+
  scale_y_continuous(labels = function(y) round(as.numeric(y), digits=2))

  scale_y_discrete(labels = function(y) round(as.numeric(y), digits=2))

#### depth histgram plot ####
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/syl_lap_allele_freq")
list.files()

syl_allele_freq <- read.delim("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.freq2.frq",sep = "\t",skip = 1,col.names = c("chr", "pos", "nalleles", "nchr", "a1", "a2"))
syl_allele_missing <- read.delim("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.lmiss",sep = "\t")
syl_allele_qual <- read.delim("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.lqual",sep = "\t")
pas_indv_missing <- read.delim("genotyping_output_14haploid_41diploid_B_pas.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.infoDP3_1000Excesshet_3.imiss",sep = "\t")
bal_indv_missing <- read.delim("gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP3_1000Excesshet_3.chr_sorted.imiss",sep = "\t")
syl_indv_missing <- read.delim("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.infoDP5_3134Excesshet_3.imiss",sep = "\t")
##
DP_syl_all <- read.table("maf0.05_f_missing0.5.53female_vs_55male.per_site.DP.INFO",sep = "\t",header = T)  
DP_syl_025 <- read.table("maf0.05_f_missing0.5.lap_53female_vs_55male.frq_per_site_fst0.25.chr_pos.DP.INFO",sep = "\t",header = T)  
ExcessHet_syl_all <- read.table("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.ExcessHet.INFO",sep = "\t",header = T)  
ExcessHet_syl_025 <- read.table("maf0.05_f_missing0.5.53female_vs_55male.frq_per_site_fst0.25.chr_pos.ExcessHet.INFO",sep = "\t",header = T)  
#
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/pas_allele_freq")
DP_pas_all <- read.table("14haploid_41diploid_B_pas.HF.DP3_GQ20_biSNP_maf005_f_missing05.all_sites.DP.INFO",sep = "\t",header = T)  
ExcessHet_pas_all <- read.table("14haploid_41diploid_B_pas.HF.DP3_GQ20_biSNP_maf005_f_missing05.all_sites.ExcessHet.INFO",sep = "\t",header = T)  
#
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/bal_allele_freq")
DP_bal_all <- read.table("gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.all_sites.DP.INFO",sep = "\t",header = T)  
ExcessHet_bal_all <- read.table("gatk_17haploid_54diploid_B_bal.SNP_hard_filtered.DP3_GQ20_biSNP_maf005_f_missing05.all_sites.ExcessHet.INFO",sep = "\t",header = T)  

head(syl_allele_freq)
head(syl_allele_missing)
head(syl_allele_qual)
head(pas_allele_missing)
head(DP_bal_all)  
str(DP_all)
head(ExcessHet_syl_all)
str(ExcessHet_syl_all)
str(ExcessHet_pas_all)
str(ExcessHet_bal_all)
str(ExcessHet_all)
head(ExcessHet_025)
head(DP_025)
str(DP_025)
sessionInfo()

# find minor allele frequency
# https://speciationgenomics.github.io/filtering_vcfs/
syl_allele_freq$maf <- syl_allele_freq %>% select(a1, a2) %>% apply(1, function(z) min(z))
head(syl_allele_freq)

ggplot(syl_allele_freq, aes(maf)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
ggplot(syl_allele_freq, aes(maf)) + geom_histogram(fill = "dodgerblue1", colour = "black", alpha = 0.3)
ggplot(syl_allele_missing, aes(F_MISS)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)
ggplot(syl_allele_qual, aes(QUAL)) + geom_density(fill = "dodgerblue1", colour = "black", alpha = 0.3)+
  xlim(0,20000)+
  ylim(0,0.00015)

#### barplot ####
#https://stackoverflow.com/questions/6085238/adding-space-between-bars-in-ggplot2
ggplot(syl_indv_missing, aes(x=INDV,y=F_MISS)) + 
  geom_bar(stat = "identity",fill = "dodgerblue1",colour = "black", alpha = 0.3,
           width = 1,size=0.1,position = position_nudge(x = 0.5))+
  scale_x_discrete(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))+
  theme_classic()+
  theme(axis.text.x = element_text(size = 2,colour = "black",angle = 90),
        axis.line = element_line(size = 0.2),axis.ticks = element_line(size=0.2))
#,vjust = 1,hjust = 0
head(pas_indv_missing)

barplot(pas_indv_missing$F_MISS,names.arg = pas_indv_missing$INDV,
  col.axis="black",font.axis=1,cex.names = 0.4, cex.axis = 0.8)
  #col = c("#D55E00","#0072B2", "#b6dbff"),
  #xlab = "Individual",ylab = "K = 3",border = NA)

#### set number of bins and axis label and range ####
# https://t-redactyl.io/blog/2016/02/creating-plots-in-r-using-ggplot2-part-7-histograms.html

# DP -> 1000 PAS
# ExcessHet -> 3 PAS
pas_DP_plot <- ggplot(DP_all,aes(DP))+
  geom_histogram(bins = 10,binwidth = 100)+
  scale_x_continuous(breaks = seq(0, 4000, 500),
                     limits=c(0, 4000))

pas_ExcessHet_plot <- ggplot(ExcessHet_pas_all,aes(ExcessHet))+
  geom_histogram(bins = 20,binwidth = 1)
#  scale_x_continuous(breaks = seq(0, 30, 2),
#                     limits=c(0, 30))

# bal ExcessHet 3; DP 1000
bal_DP_plot <- ggplot(DP_bal_all,aes(DP))+
  geom_histogram(bins = 100,binwidth = 100) +
  scale_x_continuous(breaks = seq(0, 4500, 500),
                     limits=c(0, 4500))+
  scale_y_continuous(breaks = seq(0, 450000, 50000),
                     limits = c(0,450000))

bal_ExcessHet_plot <- ggplot(ExcessHet_bal_all,aes(ExcessHet))+
  geom_histogram(bins = 20,binwidth = 1)+
#  scale_x_continuous(breaks = seq(0, 15, 2),
#                     limits=c(0, 15))+
  scale_y_continuous(breaks = seq(0, 250000, 50000),
                     limits=c(0, 250000))

ExcessHet_bal_all3 <- subset(ExcessHet_bal_all, ExcessHet_bal_all$ExcessHet < 3)
str(ExcessHet_bal_all)
str(ExcessHet_bal_all3)

 # syl 
ggplot(DP_all_new,aes(DP))+
  geom_histogram(bins = 100,binwidth = 100)+
  scale_x_continuous(breaks = seq(0, 10000, 2000),
                     limits=c(0, 10000))+
  scale_y_continuous(breaks = seq(0, 450000, 50000),
                   limits = c(0,450000))

DP_025_plot <- ggplot(DP_025,aes(DP))+
  geom_histogram(bins = 20,binwidth = 500)+
  scale_x_continuous(breaks = seq(0, 10000, 2000),
                     limits=c(0, 10000))

hist(DP_025$DP)

ExcessHet_syl_all_plot <- ggplot(ExcessHet_syl_all,aes(ExcessHet))+
#  geom_histogram()
  geom_histogram(bins = 100,binwidth = 1)+
#  scale_x_continuous(breaks = seq(0, 50, 3),
#                     limits=c(0, 50))+
  scale_y_continuous(breaks = seq(0, 2500000, 500000),
                     limits=c(0, 2500000))

ExcessHet_025_plot <- ggplot(ExcessHet_025,aes(ExcessHet))+
  geom_histogram(bins = 100,binwidth = 3)+
  scale_x_continuous(breaks = seq(0, 180, 20),
                     limits=c(0, 180))

DP_syl_025_plot <- ggplot(DP_syl_025, aes(DP))+
  geom_histogram(binwidth = 500)+
  scale_x_continuous(breaks = seq(0, 10000, 2000),
                     limits=c(0, 10000))

#### percentile ####
#https://stackoverflow.com/questions/12519629/remove-data-greater-than-95th-percentile-in-data-frame
quantile(DP_syl$DP,0.99)  #2814
quantile(DP_syl$DP,0.96)  #3134 
quantile(DP_syl$DP,0.01)  #1157
quantile(DP_pas_all$DP,0.96) # 674
quantile(DP_bal_all$DP,0.96) #936

summary(DP_bal_all$DP)
summary(ExcessHet_bal_all$ExcessHet)
library(dplyr)
str(DP_bal_all)
DP_bal_all %>% filter(DP < quantile(DP,0.96)) -> DP_bal_all_new
str(DP_bal_all_new)
#### normal distributtion test ####
# https://stackoverflow.com/questions/28217306/error-in-shapiro-test-sample-size-must-be-between
# https://www.statology.org/test-for-normality-in-r/
shapiro.test(DP$DP)
install.packages("nortest")
library(nortest)
ad.test(DP_all_new$DP)

  


#### window size Fst ####
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/syl_lap_allele_freq")
list.files()
library(dplyr)
install.packages("zoo")
library("zoo")
#"" refers to any length of whitespace as being the delimiter
read.delim("window_size_test_R.txt",header = F,sep = "") -> cov
# read.table handle multiple space as delimiter by default
read.table("Blap.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.05_f_missing0.5.53female_vs_55male.frq_per_site_fst0.25.txt",header = T) -> fst
head(fst)

## slide by the number of values instead of genomic position
# https://stackoverflow.com/questions/55717945/plotting-coverage-depth-in-1kb-windows
cov %>%
  group_by(V1) %>%
  do(
    data.frame(
      window.start=rollapply(.$V2,width=5,by=4,FUN=min,align="left",partial=T),
      window.end=rollapply(.$V2,width=5,by=4,FUN=max,align="left",partial=T),
      coverage=rollapply(.$V3,width=5,by=4,FUN=mean,align="left",partial=T)
    )
  )

# A tibble: 2 x 4
# Groups:   V1 [2]
V1 window.start window.end coverage
<int>        <int>      <int>    <dbl>
  1 1091900001          790       1040     263.
2 1091900002         1329       4666     324.


#### 
install.packages("runner")
library("runner")

runner(1:15)
runner(
  1:15,
  k=3,
  f=mean
)

runner(
  letters[1:15],
  f=paste,
  collapse=">"
  
)

#### GenomicRanges ####
if (!require("BiocManager"))
  install.packages("BiocManager")
BiocManager::install("GenomicRanges")
library("GenomicRanges")

seqlengths <- c(chr1=60, chr2=20, chr3=25)
## Create 5 tiles:
tiles <- tileGenome(seqlengths, ntile=5)
tiles
site <- GRanges("chr1:6199548-9699260")
seqlength <- c(chr1=159217232,chr2=184765313,chr3=182121094,chr4=221926752,chr5=187413619)
bin_length <- width(site)
print(bin_length)
bins <- tileGenome(seqlength, tilewidth=bin_length, cut.last.tile.in.chrom=TRUE)
flank.bins <- subsetByOverlaps(bins,site)
new.flank.bins <- setdiff(reduce(flank.bins),site)
new.bins <- c(new.flank.bins,site)
bins <- subsetByOverlaps(bins,new.bins,invert=T)

#### StAMPP ####
install.packages("StAMPP")
library("StAMPP")
data(potato)
head(potato)
# import genotype data and convert to allele frequecies
data(potato.mini, package="StAMPP")
potato.freq <- stamppConvert(potato.mini, "r")
head(potato.freq)
# Calculate pairwise Fst values between each population
potato.fst <- stamppFst(potato.freq, 100, 95, 1)
#### window
library(ggplot2)
fst %>%
  filter(CHROM=="contig_001") %>%
  ggplot(.,aes(x=POS,y=fst_dip_hap))+geom_point()

window_size <- 50000
fst %>%
  filter(CHROM=="contig_001") %>%
  mutate(window=(floor(POS/window_size)*window_size)+(window_size/2)) %>%
  group_by(CHROM,window) %>%
  
  summarize(window_fst=sum(FstNum)/sum(FstDenom),
            count=n()) %>%
  filter(count > 10) %>%
  ggplot(.,aes(x=window,y=window_fst))+geom_point()

#### NGSoptwin
install.packages("NGSoptwin")
library("NGSoptwin")
###### hierfstast ####
install.packages("hierfstat")
library(hierfstat)
pairwise.WCfst()

#### vcfR ####
install.packages("vcfR")
library(vcfR)
library(help=vcfR)
library(ape)
sessionInfo()
version
getRversion()
package_version(R.version)
packageVersion("vcfR")

data(vcfR_example)

# Find the files.
vcf_file <- system.file("extdata", "pinf_sc50.vcf.gz", package = "pinfsc50")
dna_file <- system.file("extdata", "pinf_sc50.fasta", package = "pinfsc50")
gff_file <- system.file("extdata", "pinf_sc50.gff", package = "pinfsc50")
# Read in data.
vcf <- read.vcfR(vcf_file, verbose = FALSE)
dna <- ape::read.dna(dna_file, format="fasta")
gff <- read.table(gff_file, sep="\t", quote = "")

head(vcf)
str(vcf)
show(vcf)
my_dnabin1 <- vcfR2DNAbin(vcf, consensus=FALSE, extract.haps=TRUE,verbose = TRUE)
head(my_dnabin1)
str(my_dnabin1)
par(mar=c(5,8,4,2))
ape::image.DNAbin(my_dnabin1[,ape::seg.sites(my_dnabin1)])
par(mar=c(5,4,4,2))

write.vcf(my_dnabin1, file = "my_dnabin1.vcf.gz")
write.vcf(vcf, file = "vcf.gz")
write.fasta(my_dnabin1, file = "my_dnabin1.fasta")
write.

seg.sites(my_dnabin1)
image(my_dnabin1)

gt <- extract.gt(vcf,element = "GT", return.alleles = FALSE, 
                convertNA = FALSE, extract = TRUE)

head(gt)

hap <- extract.haps(vcf,mask = FALSE, verbose = TRUE)
head(hap)
write.table(hap,file = "dip2hap.txt",quote = FALSE,sep = "\t",row.names = F)
write.vcf(hap, file = "dip2hap.vcf.gz")

list.files()
vcf_mon_lap <- read.vcfR("gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP_maf0.02_f_missing0.2.imputation_100L.vcf", skip = 8, verbose = FALSE)
str(vcf_mon_lap)
head(vcf_mon_lap)

gt <- extract.gt(vcf_mon_lap,element = "GT", return.alleles = FALSE, 
                 convertNA = FALSE, extract = TRUE)

head(gt)

hap <- extract.haps(vcf_mon_lap,mask = FALSE, verbose = TRUE)
head(hap)



#### read coverage DP QualiMap ####
# add hist labels
# https://stackoverflow.com/questions/24198896/get-values-and-positions-to-label-a-ggplot-histogram
pas_DP <- read.table("qualimap_mean_CocDP.txt",header = T,sep = "\t")
bal_DP <- read.table("bal_qualimap_mean_CocDP.txt",header = T,sep = "\t")
mon_lap_DP <- read.table("mon_lap_qualimap_mean_CocDP.txt",header = T,sep = "\t")


head(bal_DP)
library(ggplot2)

plot_bal_DP <- ggplot(pas_DP,aes(QMMean_CovDP))+
#  geom_density()
  stat_bin(geom="text", aes(label=..count..), vjust=-0.2,size=3)+
  geom_histogram()

# homozygosity
setwd("E:/Share/Sweden_UU/SW_mountain_bee/analysis/plink_homosyzosity")
list.files()
# check data fromate ; remove header
# https://stackoverflow.com/questions/22772279/converting-multiple-columns-from-character-to-numeric-format-in-r
mon_hom <- read.table("plink_ROH_49mon.10kb_50snp_no_het.group.hom",header = F)[-1,]
lap_hom <- read.table("plink_ROH_lap_53F.10kb_50snp_no_het.group.hom",header = F)[-1,]
pas_hom <- read.table("plink_ROH_pas_41F.10kb_50snp_no_het.group.hom",header = F)[-1,]
bal_hom <- read.table("plink_ROH_bal_26F.10kb_50snp_no_het.group.hom",header = F)[-1,]
hyp_hom <- read.table("plink_ROH_hyp_10F.10kb_50snp_no_het.group.hom",header = F)[-1,]
alp_hom <- read.table("plink_ROH_alp_12F.10kb_50snp_no_het.group.hom",header = F)[-1,]
pol_hom <- read.table("plink_ROH_pol_10F.10kb_50snp_no_het.group.hom",header = F)[-1,]

mon_DP <- read.table("mon.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.mon_49F.3_ind_long_ROH.tab.txt",header = F)
mon_DP_3_ind_long_ROH <- read.table("mon.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.mon_49F.3_ind_long_ROH.contig_007_3A1061422-2218638.txt",header = F)
head(mon_DP_3_ind_long_ROH)

head(mon_hom)
head(mon_DP)
str(mon_hom)
str(mon_DP)
sapply(mon_hom,class)

library(dplyr)
library(ggplot2)
library(gridExtra)
library(cowplot)

mon_hom_new <- mon_hom %>%
  mutate_at(c(7:13),as.numeric)
str(mon_hom_new)
head(mon_hom_new)

lap_hom_new <- lap_hom %>%
  mutate_at(c(7:13),as.numeric)
str(lap_hom_new)
head(lap_hom_new)

pas_hom_new <- pas_hom %>%
  mutate_at(c(7:13),as.numeric)
str(pas_hom_new)
head(pas_hom_new)

bal_hom_new <- bal_hom %>%
  mutate_at(c(7:13),as.numeric)
str(bal_hom_new)
head(bal_hom_new)

hyp_hom_new <- hyp_hom %>%
  mutate_at(c(7:13),as.numeric)
str(hyp_hom_new)
head(hyp_hom_new)

alp_hom_new <- alp_hom %>%
  mutate_at(c(7:13),as.numeric)
str(alp_hom_new)
head(alp_hom_new)

pol_hom_new <- pol_hom %>%
  mutate_at(c(7:13),as.numeric)
str(pol_hom_new)
head(pol_hom_new)

# check data issue by plot DP 
mon_DP_3_ind_long_ROH_new <- mon_DP_3_ind_long_ROH %>%
  mutate_at(c(7,12,17),as.numeric)
str(mon_DP_3_ind_long_ROH_new)

mon_DP_new$Coord <- c(1:1884189)
head(mon_DP_new)
tail(mon_DP_new)
subset_DP <- subset(mon_DP_new,mon_DP_new$V7 >100)
#### reshape data for plotting multiple column ####
mon_DP_new_reshape <- data.frame(x=mon_DP_3_ind_long_ROH_new$V2,
                                        y=c(mon_DP_3_ind_long_ROH_new$V7,
                                            mon_DP_3_ind_long_ROH_new$V12,
                                            mon_DP_3_ind_long_ROH_new$V17),
                                        Sample=c(rep("DP(AC_028)",3140),
                                                rep("DP(AC_111)",3140),
                                                rep("DP(ML_169)",3140)))
head(mon_DP_new_reshape)
str(group)

group_plot <- ggplot(mon_DP_new_reshape,aes(x=x,y=y,col=Sample))+
  geom_point(size=0.2)+
  theme_bw()+
  labs(x="SNP POS at contig_007:1061422-2218638",y="Per site DP")+
  theme(axis.text = element_text(size = 6,colour = "black"),
        axis.title = element_text(size=8),
        legend.position = "top",
        legend.title = element_text(size=8),
        legend.text = element_text(size=8))

###########################################################
dat0 <- subset(mon_hom_new,V1 == "M_L013")
# https://stackoverflow.com/questions/46652012/subsetting-data-by-multiple-values-in-multiple-variables-in-r
#### Subsetting data by multiple values in multiple variables in R ####
dat <- subset(mon_hom_new,(V1 %in% c("M_L013","M_L017")))
tail(dat)
sample_name <- unique(mon_hom_new$V1)
str(sample_name)
x <- c("x","u","o")
str(x)

label=ifelse(V3>0 |V3 < -0.082,as.character(V1),'')
#### for loop 'multiple plot' ####
# https://stackoverflow.com/questions/9315611/grid-of-multiple-ggplot2-plots-which-have-been-made-in-a-for-loop
# https://stackoverflow.com/questions/2125231/subsetting-in-r-using-or-condition-with-strings
# way No.1
p <- list()
for (var in unique(mon_hom_new$V1)){
  dev.new()
print(ggplot(mon_hom_new[mon_hom_new$V1==var,],aes(V9))+
          geom_histogram(bins =200)+
    labs(x=paste("Length of ROH (",var,")"),y="Count")+
    theme_classic()+
    scale_x_continuous(expand=c(0,0))+
    scale_y_continuous(expand=c(0,0)))
}

# way No.2
for (var in unique(mon_hom_new$V1)){
  p[[var]] <- ggplot(mon_hom_new[mon_hom_new$V1==var,],aes(V9))+
          geom_histogram(bins =200)+
          labs(x=paste("Length of ROH/Kb (",var,")"),y="Count")+
          theme_classic()+
    theme(axis.text = element_text(size = 4,colour = "black"),
          axis.title = element_text(colour = "black",size = 5))+
    scale_x_continuous(expand=c(0,0))+
    scale_y_continuous(expand=c(0,0))
}

p[[1]]

do.call(grid.arrange,p)
do.call(plot_grid, p)

install.packages("gridGraphics")
library(gridGraphics)
# call plot list 
#https://stackoverflow.com/questions/52985136/r-calling-multiple-elements-in-a-list
do.call("plot_grid",c(p, ncol=7, nrow=7, align="hv"))
do.call("grid.arrange",c(p, ncol=7, nrow=7))

#### alternative facet way to plot multiple Hom ####
# http://www.sthda.com/english/wiki/wiki.php?id_contents=7930
#### arrange multiple row for facet plot ####
# https://stackoverflow.com/questions/2108484/set-number-of-columns-or-rows-in-a-facetted-plot
# https://stackoverflow.com/questions/45611725/multiple-rows-in-facet-grid

#### change facet border/margin  ####
# https://stackoverflow.com/questions/25409981/change-plot-title-sizes-in-a-facet-wrap-multiplot
# https://stackoverflow.com/questions/46220242/ggplot2-outside-panel-border-when-using-facet
# https://stackoverflow.com/questions/36783189/changing-the-appearance-of-facet-labels-size

#### limit axis ####
# https://stackoverflow.com/questions/3606697/how-to-set-limits-for-axes-in-ggplot2-r-plots

#### Remove baseline color for geom_histogram ####
# StatBin2 -> https://stackoverflow.com/questions/57128090/remove-baseline-color-for-geom-histogram
# https://stackoverflow.com/questions/66532535/changing-color-and-fill-in-geom-histogram-results-in-automatically-printed-line
# https://stackoverflow.com/questions/14938865/removing-base-line-from-geom-histogram-in-ggplot2-via-rpy2


plot_all_mon_hom <- ggplot(mon_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 7,scale = "free_y")+
  labs(x="Length of ROH (Kb) for each sample",y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
#        panel.border = element_blank())+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))
# + panel_border()

do.call("plot_grid",c(p, ncol=7, nrow=7, align="hv"))
do.call("grid.arrange",c(plot_all, ncol=7, nrow=7))
grid.arrange(plot_all,nrow=7)


#### cumulative plot ####
# https://stackoverflow.com/questions/18356860/cumulative-histogram-with-ggplot2
head(subset(mon_hom_new,V1=="M_L214"))
sum(subset(mon_hom_new,V1=="M_L214")[,9])

plot_all_mon_hom <- ggplot(mon_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)), bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  facet_wrap(. ~ V1,ncol = 7,scale = "free_y")+
  labs(x="Length of ROH (Kb) for each sample",y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.1,fill = "white",colour = "black"),
        panel.border=element_rect(colour="black",size=0.1))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

size (6*8)

# overall plot mon
plot_overall_mon_hom <- ggplot(mon_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. monticola"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall cum plot mon
plot_overall_cum_mon_hom <- ggplot(mon_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. monticola"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

### lap
str(unique(lap_hom_new$V1)) # 53
plot_all_lap_hom <- ggplot(lap_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample (",italic("B. lapponicus"),")")),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot lap
plot_overall_lap_hom <- ggplot(lap_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. lapponicus"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall cum plot lap
plot_overall_cum_lap_hom <- ggplot(lap_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. lapponicus"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))



### pas
str(unique(pas_hom_new$V1)) # 41
plot_all_pas_hom <- ggplot(pas_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample (",italic("B. pascuorum"),")")),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        panel.border = element_rect(size=0.25),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot pas
plot_overall_pas_hom <- ggplot(pas_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. pascuorum"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall cum plot pas
plot_overall_cum_pas_hom <- ggplot(pas_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. pascuorum"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

### bal
str(unique(bal_hom_new$V1)) # 53
plot_all_bal_hom <- ggplot(bal_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample (",italic("B. balteatus"),")")),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot bal
plot_overall_bal_hom <- ggplot(bal_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. balteatus"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall plot cum bal
plot_overall_cum_bal_hom <- ggplot(bal_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. balteatus"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

### hyp
str(unique(hyp_hom_new$V1)) # 10
plot_all_hyp_hom <- ggplot(hyp_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample ",italic("B. hyperboreus"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot hyp
plot_overall_hyp_hom <- ggplot(hyp_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. hyperboreus"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall plot cum hyp
plot_overall_cum_hyp_hom <- ggplot(hyp_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. hyperboreus"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

### alp
str(unique(alp_hom_new$V1)) # 12
plot_all_alp_hom <- ggplot(alp_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample (",italic("B. alpinus"),")")),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot alp
plot_overall_alp_hom <- ggplot(alp_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. alpinus"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall plot cum alp
plot_overall_cum_alp_hom <- ggplot(alp_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. alpinus"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

### polaris
str(unique(pol_hom_new$V1)) # 53
plot_all_pol_hom <- ggplot(pol_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  facet_wrap(. ~ V1,ncol = 6,scale = "free_y")+
  labs(x=expression(paste("Length of ROH (Kb) for each sample (",italic("B. polaris"),")")),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        panel.grid = element_blank(),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25,fill = "white"))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

# overall plot pol
plot_overall_pol_hom <- ggplot(pol_hom_new,aes(V9))+
  geom_histogram(bins =200,col="blue",fill="blue",stat = StatBin2)+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. polaris"),)),y="Count")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
#        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

# overall plot cum pol
plot_overall_cum_pol_hom <- ggplot(pol_hom_new,aes(V9))+
  geom_histogram(aes(y=cumsum(..count..)),bins =200,col="blue",fill="blue",stat = StatBin2)+
  stat_bin(aes(y=cumsum(..count..)),bins =200,geom="line",color="red")+
  labs(x=expression(paste("Overall length of ROH (Kb) of ",italic("B. polaris"),)),y="Cumulation (Count)")+
  theme_bw()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 8,colour = "black"),
        axis.title = element_text(colour = "black",size = 9),
        panel.border = element_rect(size=0.25),
        plot.margin = unit(c(0.5, 0.5, 0.5, 0.5), "cm"))+
  #        panel.grid.minor = element_line())+
  scale_x_continuous(expand=c(0,0),limits = c(0,1500))+
  scale_y_continuous(expand=c(0,0))

#### merge plots
merge4 <- plot_grid(plot_all_bal_hom,
                    plot_all_hyp_hom,
                    plot_all_alp_hom,
                    plot_all_pol_hom,
                    rel_heights=c(4,2,2,1.25),
                    ncol=1,align="hv")
# merge single plot
# control axis limit
# https://stackoverflow.com/questions/65017300/how-to-force-multiple-r-plots-to-have-the-same-length-of-x-ticks
# change margin size & add labels
# https://stackoverflow.com/questions/47614314/how-to-put-plots-without-any-space-using-plot-grid
# https://stackoverflow.com/questions/41834093/decrease-margins-between-plots-when-using-cowplot
merge4 <- plot_grid(plot_overall_mon_hom,
                    plot_overall_lap_hom,
                    plot_overall_pas_hom,
                    plot_overall_bal_hom,
                    plot_overall_hyp_hom,
                    plot_overall_alp_hom,
                    plot_overall_pol_hom,
#                    rel_widths=c(3/5,3/5,3/5,3/5,3/5,3/5,3/5),
                    ncol=2,align="hv")
#### cum plot merge
library(cowplot)
merge5 <- plot_grid(plot_overall_cum_mon_hom,
                    plot_overall_cum_lap_hom,
                    plot_overall_cum_alp_hom,
                    plot_overall_cum_bal_hom,
                    plot_overall_cum_hyp_hom,
                    plot_overall_cum_pol_hom,
                    plot_overall_cum_pas_hom,
                    #                    rel_widths=c(3/5,3/5,3/5,3/5,3/5,3/5,3/5),
                    ncol=2,align="hv")

### plot SNP density 
plot_all_SNP_density <- ggplot(mon_hom_new,aes(V10))+
  geom_histogram(bins =200)+
  facet_wrap(. ~ V1,ncol = 7,scale = "free_y")+
  labs(x="No. of SNP in runs (>= 50SNPs:total length >= 10Kb) for each sample",y="Count")+
  theme_classic()+
  theme(axis.line = element_line(size = 0.25), 
        axis.ticks = element_line(size= 0.25,colour = "black"),
        axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 7),
        strip.text = element_text(size=8,margin = margin()),
        strip.background = element_rect(size = 0.25))+
  #        panel.border = element_blank())+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))+
  panel_border()

#library(cowplot)
mon_hom_new %>%
  mutate(V9 =factor(V9,levels = sample_name))

sample_name[1:3]
mon_hom_plot <- hist(data)

ggplot(dat0,aes(V9))+
  geom_histogram(bins =200)+
  labs(x=paste("Length of ROH, Kb, (",dat0$V1,")"),y="Count")+
  theme_classic()+
  theme(axis.text = element_text(size = 5,colour = "black"),
        axis.title = element_text(colour = "black",size = 6))+
  scale_x_continuous(expand=c(0,0))+
  scale_y_continuous(expand=c(0,0))

ggplot(dat0,aes(V9))+
  geom_histogram(bins =200)+
  facet_grid(. ~ V1,scale = "free_y")+
  panel_border()



#### combined data ####
library(ggplot2)
library(dplyr)
MQ_bal <- read.delim("MQ.txt",header = F)
head(MQ_bal)
tail(MQ_bal)
str(MQ_bal)
MQ_bal_new <- MQ_bal %>%
  mutate_at(c(2,3),as.numberic)

MQ_bal_plot <- ggplot(MQ_bal,aes(as.numeric(V3)))+
  geom_density()+
  xlim(0,80)+
  labs(x="MQ_combined_bal")
scale_x_continuous(limits=c(0,80))
