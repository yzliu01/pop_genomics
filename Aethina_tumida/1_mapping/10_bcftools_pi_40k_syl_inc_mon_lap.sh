#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:10:00
#SBATCH -J pi_40k.syl_inc_mon_lap.hap2dip
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=pi_40k.Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.hap2dip.%A.e
#SBATCH --output=pi_40k.Roc_214syl_67inc_F.SE_75mon_27M_48F_128lap_62M_66F.hap2dip.%A.o

module load bioinfo-tools
module load vcftools

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig

cd $INPUT_DIR

# roc_syl
INPUT_FILE=bcftools_subset_rocky_214_syl.vcf.gz
# rename file
OUT_FILE=${INPUT_FILE/.vcf.gz/.40k}
vcftools --gzvcf $INPUT_FILE --window-pi 40000 --out ./stats/$OUT_FILE


## se_inc
INPUT_FILE=bcftools_subset_rocky_67_inc.vcf.gz
# rename file
OUT_FILE=${INPUT_FILE/.vcf.gz/.40k}
vcftools --gzvcf $INPUT_FILE --window-pi 40000 --out ./stats/$OUT_FILE

# se_mon
INPUT_FILE=bcftools_subset_se_75_mon.hap2dip.vcf.gz
# rename file
OUT_FILE=${INPUT_FILE/.vcf.gz/.40k}
vcftools --gzvcf $INPUT_FILE --window-pi 40000 --out ./stats/$OUT_FILE

# lap
INPUT_FILE=bcftools_subset_se_128_lap.hap2dip.vcf.gz
# rename file
OUT_FILE=${INPUT_FILE/.vcf.gz/.40k}
vcftools --gzvcf $INPUT_FILE --window-pi 40000 --out ./stats/$OUT_FILE

