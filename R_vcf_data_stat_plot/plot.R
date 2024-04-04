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
head(as.numeric(as.character(EH_DP_MP_data$V5))

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
sfs_file <-"concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.equal_self.sfs"
list.files(pattern = "ann_no_mis.equal_self")
sfs_pas1 <- read.table(sfs_file,sep=" ",header=F)
sfs_pas <- sfs_pas[,!is.na(sfs_pas1[1,])]
sfs_pas2 <- t(sfs_pas)

sfs_file_pas_REF_pas <-"concated.Bompas.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.equal_self.sfs"
sfs_file_hae_REF_hae <-"concated.Andhae.New_REF_AndHae.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP200_noMS_AO3.ann_no_mis.equal_self.sfs"

list.files(pattern = "ann_no_mis.equal_self")
sfs_pas_REF_pas <- read.table(sfs_file_pas_REF_pas,sep=" ",header=F)
sfs_hae_REF_hae <- read.table(sfs_file_hae_REF_hae,sep=" ",header=F)
sfs_hae_REF_hae <- sfs_hae_REF_hae[,!is.na(sfs_hae_REF_hae[1,])]
class(sfs_hae_REF_hae)
sfs_hae_REF_hae_t <- as.data.frame(t(sfs_hae_REF_hae))
class(sfs_hae_REF_hae_t)
library(ggplot2)
ggplot()+
    geom_point(aes(sfs_hae_REF_hae_t$V1))


pdf("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/sfs_plot/sfs_pas_REF_pas.pdf")
plot(sfs_pas2$V1,type="h")
dev.off()

pdf("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data/sfs_plot/sfs_hae_REF_hae.pdf")
plot(sfs_hae_REF_hae_t,type="h")
dev.off()
