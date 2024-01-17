#!/bin/bash -l

#SBATCH -A snic2022-22-258
##SBATCH -p node
##SBATCH -C mem256GB
##SBATCH -p core
#SBATCH -n 19
##SBATCH -n 10
#SBATCH -t 1-04:00:00
#SBATCH -J minorAC2.imp_geno_stats.Roc_Se_bal
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu@imbim.uu.se
#SBATCH --error=imp_geno_stats.Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.minorAC2.%A.e
#SBATCH --output=imp_geno_stats.Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.minorAC2.%A.o

module load bioinfo-tools Beagle/5.1 python bcftools

INPUT_DIR=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/bal_bal_alp_hyp_pol/DB_VCF/merge_vcf_per_contig_new2
cd $INPUT_DIR
Input_vcf=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.vcf.gz
Beagle_imp_out=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp
imp_vcf_Roc_Se_bal=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.vcf.gz
geno=Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.geno.gz
Ploidy_File=PloidyFile.Roc_299bal_dip.Se_71bal_17hap_54dip.list
popFile=popsFile.Roc_299.Se_bal43_12alp_10hyp_6pol.list

out_csv=./simon_martin/Roc_299F_bal.SE_26F17M_bal_12alp_10hyp_6pol.combined_GT_HF.GQ20_DP3_25000_ExHet20_biSNP_minorAC2_mis05.rm_maleHet.imp.geno_csv.gz
bal_fai=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_balteatus_v1.fna.fai

## phase vcf
java -Xmx121g -jar /sw/apps/bioinfo/Beagle/5.1/rackham/beagle.jar gt=$Input_vcf out=$Beagle_imp_out

## get geno.gz - need to index phased vcf file

#bcftools index $imp_vcf_Roc_Se_bal

python /home/yzliu/bin/parseVCFs.py -i $imp_vcf_Roc_Se_bal --ploidyFile $Ploidy_File \
--fai $bal_fai --ploidyMismatchToMissing --skipIndels --threads 10 | bgzip > $geno

## have issue - solution - index geno.gz file
# Traceback (most recent call last):   File "/usr/lib64/python2.7/multiprocessing/process.py", line 258, in _bootstrap     self.run()
# https://github.com/simonhmartin/genomics_general/issues/14
#module load bioinfo-tools python bcftools
tabix -p vcf $geno

## calculate Fst
python /home/yzliu/bin/simon_martin/popgenWindows.py --ploidyFile $Ploidy_File -w 30000 -m 10 -g $geno \
-o $out_csv -f phased -p Roc_bal -p alp -p Se_bal -p hyp -p pol -T 6 --popsFile $popFile --addWindowID

