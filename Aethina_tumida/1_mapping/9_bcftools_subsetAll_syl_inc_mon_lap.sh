#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:10:00
#SBATCH -J subset_all_syl_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=bcftools_subset_All.%A.e
#SBATCH --output=bcftools_subset_All.%A.o

module load bioinfo-tools
module load python
module load bcftools/1.14
module load vcftools

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/merged_vcf_per_contig
INPUT_FILE=Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp.vcf.gz
SMP_LIST=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/Roc_214syl_67inc.SE_75mon_128lap.sample_ID.list
OUT_FILE=Roc_214syl_67inc_F.DP3_GQ20_biSNP_maf003_f_mis05_gap10_rmMonoSNP_oneway_mHet.imp_bcf_subsetAll.vcf.gz

cd $INPUT_DIR

bcftools view $INPUT_FILE -S $SMP_LIST -Oz -o $OUT_FILE


