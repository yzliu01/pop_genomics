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
getwd()
EH_DP_MQ_data = read.table("ExcessHet_DP_MQ_new.txt",header=F)
head(EH_DP_MQ_data)
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

MQ_data <- ggplot(EH_DP_MP_data,aes(as.numeric(as.character(EH_DP_MP_data$V5))))+
  geom_histogram(bins=100)+
  xlim(0,100)+
  labs(x="MQ_combined_plus_bif_van")
#  scale_x_continuous(limits=c(0,60))

#### combined ####  
MQ_plot <- ggplot(EH_DP_MP_data,aes(as.numeric(V5)))+
   geom_density()+
   xlim(0,50)+
   labs(x="MQ_combined_plus_bif_van")
   scale_x_continuous(limits=c(0,80))

### save file as pdf/png
# https://bookdown.org/ndphillips/YaRrr/saving-plots-to-a-file-with-pdf-jpeg-and-png.html
pdf(file="./plus_plus_bif_van_EH.pdf",width=6,height=4)
ggplot(EH_DP_MQ_data,aes(V3))+
geom_histogram(bins=80)+
#    xlim(0,80)+
labs(x="plus_plus_bif_van_EH")+
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
