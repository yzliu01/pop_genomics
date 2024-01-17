#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 18
#SBATCH -t 27:40:00
#SBATCH -J thin1000_geno_Roc_Se_bal
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=vcftools_geno_Roc_Se_bal.imp.thin1000.geno.%A.e
#SBATCH --output=vcftools_geno_Roc_Se_bal.imp.thin1000.geno.%A.o

module load bioinfo-tools vcftools python bcftools
dir=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/bal_bal_alp_hyp_pol/DB_VCF/merge_vcf_per_contig_new2

cd $dir

vcf_imp=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcf.gz
thin_vcf=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcftools_thin1000.vcf.gz
thin_geno=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcftools_thin1000.geno.gz
Ploidy_File=PloidyFile.Roc_299bal_dip.Se_71bal_17hap_54dip.list
bal_fai=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.fna.fai

vcftools --gzvcf $vcf_imp --recode-INFO-all --thin 1000 --recode --stdout | bgzip > $thin_vcf

#python /home/yzliu/bin/filterGenotypes.py --threads 6 -i $geno --thinDist 1000 -o $thinDist_1000_geno

# index imp.vcf fiel
bcftools index -f $thin_vcf

python /home/yzliu/bin/parseVCFs.py -i $thin_vcf --ploidyFile $Ploidy_File \
--fai $bal_fai --ploidyMismatchToMissing --skipIndels --threads 10 | bgzip > $thin_geno

DIST=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcftools_thin1000.geno.dist
python /home/yzliu/bin/distMat.py -f phased -T 18 -g $thin_geno --windType cat --ploidyFile $Ploidy_File -o $DIST
