#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 02:10:00
#SBATCH -J minorAC2_subset.RocBal_Se_bal_alp_hyp_pol
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bcftools_subset.RocBal_Se_bal_alp_hyp_pol.minorAC2.%A.e
#SBATCH --output=bcftools_subset.RocBal_Se_bal_alp_hyp_pol.minorAC2.%A.o

module load bioinfo-tools python bcftools vcftools

# input dir
INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/bal_bal_alp_hyp_pol/DB_VCF/merge_vcf_per_contig_new2
INPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcf.gz

cd $INPUT_DIR

# Roc_bal
SMP_LIST=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/bal_bal_alp_hyp_pol/Roc_bal_299F.list
OUTPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.Roc_bal_299F.vcf.gz
# remove monomorphic sites & bcftools index $OUTPUT_FILE
# work with: bcftools view -T XXX -e 'AC==0 || AC == AN' -Oz -o
# not with -S
bcftools view $INPUT_FILE -S $SMP_LIST | bcftools view -e 'AC==0 || AC == AN' -Oz -o $OUTPUT_FILE
#bcftools index $OUTPUT_FILE
vcftools --gzvcf $OUTPUT_FILE --FILTER-summary --out ./stats/$OUTPUT_FILE

# se_bal
SMP_LIST=se_bal.43.list
OUTPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.se_43bal.vcf.gz
# remove monomorphic sites & bcftools index $OUTPUT_FILE
bcftools view $INPUT_FILE -S $SMP_LIST | bcftools view -e 'AC==0 || AC == AN' -Oz -o $OUTPUT_FILE
#bcftools index $OUTPUT_FILE
vcftools --gzvcf $OUTPUT_FILE --FILTER-summary --out ./stats/$OUTPUT_FILE

# alp
SMP_LIST=se_alp.12.list
OUTPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.12alpF.vcf.gz
# remove monomorphic sites & bcftools index $OUTPUT_FILE
bcftools view $INPUT_FILE -S $SMP_LIST | bcftools view -e 'AC==0 || AC == AN' -Oz -o $OUTPUT_FILE
#bcftools index $OUTPUT_FILE
vcftools --gzvcf $OUTPUT_FILE --FILTER-summary --out ./stats/$OUTPUT_FILE

# hyp
SMP_LIST=se_hyp.10.list
OUTPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.10hypF.vcf.gz
# remove monomorphic sites & bcftools index $OUTPUT_FILE
bcftools view $INPUT_FILE -S $SMP_LIST | bcftools view -e 'AC==0 || AC == AN' -Oz -o $OUTPUT_FILE
#bcftools index $OUTPUT_FILE
vcftools --gzvcf $OUTPUT_FILE --FILTER-summary --out ./stats/$OUTPUT_FILE

# pol
SMP_LIST=se_pol.6.list
OUTPUT_FILE=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.6polF.vcf.gz
# remove monomorphic sites & bcftools index $OUTPUT_FILE
bcftools view $INPUT_FILE -S $SMP_LIST | bcftools view -e 'AC==0 || AC == AN' -Oz -o $OUTPUT_FILE
bcftools index $OUTPUT_FILE
vcftools --gzvcf $OUTPUT_FILE --FILTER-summary --out ./stats/$OUTPUT_FILE


## old way
#vcftools --gzvcf $INPUT_FILE --keep $SMP_LIST --recode --recode-INFO-all \
#--mac 1 --non-ref-ac-any 1 --min-alleles 2 --max-alleles 2 --max-missing 0.5 \
#--stdout | bgzip -c >  $OUTPUT_FILE &

