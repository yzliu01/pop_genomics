#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:10:00
#SBATCH -J ROH_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=ROH_49mon.%A.e
#SBATCH --output=ROH_49mon.%A.o

module load bioinfo-tools
module load vcftools
module load plink

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/new_variant_calling_ploidy/combined_vcf_genotyping
OUT_DIR=$INPUT_DIR/homozygosity

cd $INPUT_DIR
# mon
INPUT_FILE=mon.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.mon_49F.vcf.gz
ped_FILE=mon.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.mon_49F
bed_FILE=mon.DP3_GQ20_biSNP_maf005_f_missing05.infoDP4_3134Excesshet_25.rm_non_var.mon_49F
plink_ROH_FILE=plink_ROH_49mon

vcftools --gzvcf $INPUT_FILE --plink --out $INPUT_DIR/$ped_FILE
plink --file $ped_FILE --make-bed --recode 12 --out $INPUT_DIR/$bed_FILE
plink --file $INPUT_DIR/$bed_FILE --out $OUT_DIR/$plink_ROH_FILE --homozyg



