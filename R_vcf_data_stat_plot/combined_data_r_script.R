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


MQ_bal_plot <- ggplot(MQ_bal,aes(as.numeric(V5)))+
  geom_density()+
  xlim(0,80)+
  labs(x="MQ_combined_bal")
  scale_x_continuous(limits=c(0,80))

 
  ggplot(MQ_bal,aes(V3))+
    geom_histogram(bins=200)+
#    xlim(0,80)+
    labs(x="Excesshet_combined_bal")+
    xlim(0,50)
  
  ggplot(MQ_bal,aes(V4))+
    geom_histogram(bins=200)+
    #    xlim(0,80)+
    labs(x="DP_combined_bal")+
    xlim(0,200000)
#### syl ####  
  MQ_syl_plot <- ggplot(MQ_syl_mon,aes(as.numeric(V5)))+
    geom_density()+
    xlim(0,80)+
    labs(x="MQ_combined_syl")
  scale_x_continuous(limits=c(0,80))
  
  
  ggplot(MQ_syl_mon,aes(V3))+
    geom_histogram(bins=200)+
    #    xlim(0,80)+
    labs(x="Excesshet_combined_syl")+
    xlim(0,50)
  
  ggplot(MQ_syl_mon,aes(V4))+
    geom_histogram(bins=200)+
    #    xlim(0,80)+
    labs(x="DP_combined_syl")+
    xlim(0,200000)  
  
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
