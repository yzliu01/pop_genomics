#(R) [yzliu@fe-open-01 ~]$ mkdir -p ~/.R
#IC' > ~/.R/Makevars
(R) [yzliu@fe-open-01 ~]$ echo 'CXX17 = g++-7 -std=gnu++17 -fPIC' > ~/.R/Makevars
(R) [yzliu@fe-open-01 ~]$ cat ~/.R/Makevars
CXX17 = g++-7 -std=gnu++17 -fPIC

/home/yzliu/miniforge3/envs/Radian/bin/radian
/home/yzliu/miniforge3/bin/radian

# get quantile threshshold
#https://stats.stackexchange.com/questions/13399/calculating-the-95th-percentile-comparing-normal-distribution-r-quantile-and
getwd()
setwd("/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon_bif_van/DB_VCF/merged_vcf_per_contig/stats")
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/cleanfastq_sortbam_markduplicate/stats/samtools_stats/samtools_stat_cov")
getwd()
list.files()
EH_DP_MQ_data = read.table("concated_deo_mel_all_chr.sorted_chr.SNP_hard_filtered.CHROM_POS_QUAL_DP_MQ",header=F)
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF")
CHROM_POS_QUAL_DP_MQ = read.table("concated_deo_mel_all_chr.sorted_chr.SNP_hard_filtered.CHROM_POS_QUAL_DP_MQ",header=F)

stats_dro_mel_COV <- read.table("SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt",header=F)
head(EH_DP_MQ_data)

head(CHROM_POS_QUAL_DP_MQ)
    V1    V2      V3   V4    V5
1 chrX 38888   40.55  158 44.96
2 chrX 38909   32.39  224 43.48

head(stats_dro_mel_COV)
str(stats_dro_mel_COV)
# DP
quantile(EH_DP_MQ_data$V4,0.95)
5865
# EH
quantile(EH_DP_MQ_data$V3,0.95)
3.1
# Convert Factor to Numeric in R
numeric_vector <- as.numeric(as.character(factor_vector))
data <- as.numeric(as.character(EH_DP_MQ_data$V))
# We must first convert the factor vector to a character vector, then to a numeric vector. This ensures that the numeric vector contains the actual numeric values instead of the factor levels.
quantile(data,0.95,na.rm=TRUE)
95% 
60

##############
list.files()
sessionInfo()
library(ggplot2)
library(dplyr)
MQ_bal <- read.delim("ExcessHet_DP_MQ_new.txt",header = F)
MQ_syl_mon <- read.delim("ExcessHet_DP_MQ_new.txt",header = F)
head(MQ_syl_mon)
tail(MQ_bal)
str(MQ_syl_mon)
MQ_bal_new <- MQ_bal %>%
  mutate_at(c(2:5),as.numberic)

head(EH_DP_MP_data)
head(as.numeric(as.character(EH_DP_MP_data$V5)))

MQ_data <- ggplot(CHROM_POS_QUAL_DP_MQ,aes(as.numeric(as.character(V3))))+
  geom_histogram(bins=500)+
  xlim(0,500)+
  labs(x="dro_mel_68_QUAL")
#  scale_x_continuous(limits=c(0,60))
ggsave("distribution_QUAL.pdf",MQ_data,width=6,height=4)
#### combined ####  
MQ_plot <- ggplot(stats_dro_mel_COV,aes(V2))+
   geom_density()+
   xlim(0,50)+
   labs(x="stats_dro_mel_COV")
   scale_x_continuous(limits=c(0,80))

### save file as pdf/png
# https://bookdown.org/ndphillips/YaRrr/saving-plots-to-a-file-with-pdf-jpeg-and-png.html
pdf(file="./CHROM_POS_QUAL_DP_MQ.pdf",width=6,height=4)
plot(stats_dro_mel_COV$V2,stats_dro_mel_COV$V3)
ggplot(stats_dro_mel_COV,aes(V3))+
geom_histogram(bins=80)+
    xlim(0,800)+
labs(x="stats_dro_mel_COV")+
xlim(0,10)
dev.off()



ggplot(EH_DP_MP_data,aes(V4))+
  geom_histogram(bins=10)+
   #    xlim(0,80)+
  labs(x="plus_plus_bif_van_DP")+
  xlim(0,10000)  
  
setwd("/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping")
setwd("/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/PAS/new_variant_calling_ploidy/combined_vcf_genotyping")
file="gatk_89haploid_118diploid_B_syl.SNP_hard_filtered.DP3_GQ20_biSNP.missing05_DP3_3134_Excesshet25.POS_QUAL.txt"
file_pas_maf0_005 = "genotyping_output_14haploid_41diploid_B_pas.SNP_hard_filtered.DP3_GQ20_biSNP_0_005maf_05missing.POS_QUAL.txt"
file_pas_maf002_missing05="genotyping_output_14haploid_41diploid_B_pas.SNP_hard_filtered.DP3_GQ20_biSNP_maf002_missing05_DP3_1000_Excesshet25.QUAL.txt"

data_QUAL <- read.table(file_pas_maf002_missing05,header = F)
head(data_QUAL)  
library(ggplot2)  

plot <- ggplot(data_QUAL,aes(V3))  +
  geom_histogram(bins=500)+
  xlim(1,500)
xlim(1,3000)

setwd("/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/stats")
list.files()
data_DP_EH <- read.table("merged_49Atum_1Agla_2Dpon_1Amel.SNP.H_F.vcf.gz.per_site_DP.ExcessHet.chr_DP_EHet.INFO",header=T)
data <- head(data_DP_EH,n=60L)
data
plot(data$ExcessHet)
plot <- ggplot(data,aes(ExcessHet))  +
  geom_histogram(bins=10)
  xlim(1,500)
xlim(1,3000)


setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data")
# deleted
#sfs_file <- "concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.equal_self.sfs"
sfs_file <- "concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP204_1500x_noMS.equal_self.sfs"
#list.files(pattern = "SNP_softmask_genic_bi_FMT_DP200x_noMS.equal_self.sfs$")
list.files(pattern = "SNP_softmask_genic_bi_FMT.*1500x_noMS.equal_self.sfs$")
sfs_pas1 <- read.table(sfs_file,sep=" ",header=F)
#Warning message:
#In read.table(sfs_file, sep = " ", header = F) :
#  incomplete final line found by readTableHeader on 'concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP204_1500x_noMS.equal_self.sfs'
sfs_pas <- sfs_pas1[,!is.na(sfs_pas1[1,])]
#sfs_pas1[,c(TRUE,TRUE,FALSE)]
# transpose line to column
sfs_pas2 <- t(sfs_pas)
class(sfs_pas2)
head(sfs_pas2)
sfs_pas3 <- as.data.frame(sfs_pas2)
class(sfs_pas3)

library(ggplot2)
sfs_file_pas_REF_pas <-"BomPas_New_REF_BomPas.SNP_softmask_genic_bi_FMT_DP200x_noMS.equal_self.sfs"
sfs_file_hae_REF_hae <-"AndHae_New_REF_AndHae.SNP_softmask_genic_bi_FMT_DP200x_noMS.equal_self.sfs"

sfs_file_pas_REF_pas = sfs_file

list.files(pattern = "ann_no_mis.equal_self")
sfs_pas_REF_pas <- read.table(sfs_file_pas_REF_pas,sep=" ",header=F)
sfs_hae_REF_hae <- read.table(sfs_file_hae_REF_hae,sep=" ",header=F)
sfs_pas_REF_pas <- sfs_pas_REF_pas[,!is.na(sfs_pas_REF_pas[1,])]
class(sfs_pas_REF_pas)
str(sfs_pas_REF_pas)
sfs_pas_REF_pas_t <- as.data.frame(t(sfs_pas_REF_pas))
head(sfs_pas_REF_pas_t)
# plot distribution of sfs without y axis values: bar plot
library(dplyr, help, pos = 2, lib.loc = NULL)
ggplot(data = sfs_pas_REF_pas_t, aes(x = 1:nrow(sfs_pas_REF_pas_t),y = V1))+
#ggplot(data = sfs_pas_REF_pas_t, aes(x = factor(seq_along(V1)),y = V1))+
    geom_col(fill = "gray")+
    labs(title = "Bar Plot of SFS", x = "Index", y = "Value")+
    theme_bw(base_size = 12)


pdf("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/sfs_plot/sfs_pas_REF_pas.pdf")
plot(sfs_pas2$V1,type="h")
dev.off()

pdf("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/sfs_plot/sfs_pas_REF_pas.sm_genic.pdf")
plot(sfs_pas_REF_pas_t$V1,type="h")
dev.off()

************************** form sfs plot ********************
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data")
# check sfs distribution
sfs_x <- c(
    "concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP234_1500x_noMS.equal_self.sfs",
    "concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP240_1500x_noMS.equal_self.sfs",
    "concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP204_1500x_noMS.equal_self.sfs",
    "concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP174_1500x_noMS.equal_self.sfs"

    # sfs
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP100_1500x_noMS.equal_self.sfs",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP150_1500x_noMS.equal_self.sfs",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP200_1500x_noMS.equal_self.sfs",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP250_1500x_noMS.equal_self.sfs",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP300_1500x_noMS.equal_self.sfs"

    # sfs prop
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP100_1500x_noMS.equal_self.sfs.prop",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP150_1500x_noMS.equal_self.sfs.prop",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP200_1500x_noMS.equal_self.sfs.prop",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP250_1500x_noMS.equal_self.sfs.prop",
    #"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP300_1500x_noMS.equal_self.sfs.prop"
    
)

species_list <- c(
    "A. haemorrhoa",
    "A. marginata",
    "B. pascuorum",
    "B. veteranus"
    #"Rutpela_maculata_1x",
    #"Rutpela_maculata_1.5x",
    #"Rutpela_maculata_2x",
    #"Rutpela_maculata_2.5x",
    #"Rutpela_maculata_3x"
)
# show data lines directly in the terminal
#file.show("concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs")
#print(readLines("concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP416_1500x_noMS.equal_self.sfs", warn = F))

plot_list <- list()

library(ggplot2)

## To make the species names in your plot titles italic in R, you can use bquote() or expression() in combination with italic(). 
## However, expression() does not directly evaluate variables, so you'll need to use bquote() to achieve this.
for (i in 1:length(sfs_x)){
    print(sfs_x[i])
    
    ## sfs lines
    #sfs_dt <- suppressWarnings(read.table(sfs_x[i], header=F, sep =" "))
    #sfs_dt1 <- sfs_dt[,!is.na(sfs_dt[1,])]
    #sfs_dt2 <- as.data.frame(t(sfs_dt1))

    ## sfs col for proportion
    sfs_dt2 <- (read.table(sfs_x[i], header=F, sep =" "))
    #print(sfs_dt2)
    print(head(sfs_dt2))
    plot_list[[i]] <- #ggplot(data = sfs_dt2, aes(x = 1:nrow(sfs_dt2), y = V1))+
                    ggplot(data = sfs_dt2, aes(x = factor(seq_along(V1)),y = V1))+
                    geom_col(fill = "gray")+
                    #labs(title = paste0("Bar Plot of SFS: ", species_list[i]), x = "Index", y = "Value")+
                    ## The bquote() function allows you to mix text and evaluated expressions. The .(species_list[i]) syntax inside bquote() evaluates species_list[i] and wraps it in italic() to display it in italics.
                    
                    ## sfs lines
                    #labs(title = bquote("Bar Plot of SFS: " *italic(.(species_list[i]))), x = "Index", y = "Value")+
                    
                    ## sfs col for proportion
                    labs(title = bquote("Bar Plot of SFS Prop: " *italic(.(species_list[i]))), x = "Index", y = "Value")+
                    theme_bw(base_size = 12)+
                    theme(axis.text = element_text(size = 8), axis.text.x = element_text(angle = -10))
}

plot_list <- unname(plot_list)
for (i in 1:length(plot_list)) {
  print(plot_list[[i]])
}

## add plot to the list
print(plot_list[[1]])
plot_list[[2]]
plot_list[[3]]
print(plot_list[[1]])

library(gridExtra)

# remake plot list since it got issues
for (i in 1:length(plot_list)) {
    print(plot_list[[i]])
}

# Assuming plot_list contains your ggplot objects
# Open PDF device
## sfs lines
pdf("./sfs_plot/combined_sfs_plots_hae_mar_pas_vet.pdf", width = 8, height = 8)  # Adjust width and height as needed
## sfs col for proportion
#pdf("./sfs_plot/combined_sfs_prop_plots_RutMac.pdf", width = 12, height = 8)  # Adjust width and height as needed

# Combine plots and save to PDF
gridExtra::grid.arrange(grobs = plot_list, ncol = 2)

# Close the PDF device
dev.off()

# Use print() within grid.arrange(): Sometimes, the plots need to be explicitly printed. You can use lapply() to ensure that each plot is rendered properly.
gridExtra::grid.arrange(grobs = lapply(plot_list, print), ncol = 2)
lapply(plot_list, class)

# alternative method
library(patchwork)

# Combine plots with patchwork
combined_plot <- plot_list[[1]] + plot_list[[2]] + plot_list[[3]] + plot_layout(ncol = 2)
print(combined_plot)

****************************************

# generated example to plot bar plot

library(ggplot2)

# Sample data: let's say you have 39 rows of data
data_list <- list(
  data.frame(value = rnorm(39)),  # Random data for the first plot
  data.frame(value = rnorm(39))   # Random data for the second plot
)

# Create a list to store plots
plot_list <- list()

# Loop through the data and create plots
for (i in 1:length(data_list)) {
  plot_list[[i]] <- ggplot(data = data_list[[i]], aes(x = factor(seq_along(value)), y = value)) +
    geom_col(fill = "gray") +
    labs(title = paste("Bar Plot for Dataset", i), x = "Index", y = "Value") +
    theme_minimal()
}

# Check the first plot
print(plot_list[[1]])
