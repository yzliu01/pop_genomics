#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 6
#SBATCH -t 20:30:00
#SBATCH -J fst_Dxy_popgenWindow.atum_49
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=popgenWindow_fst_Dxy.atum_49_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono_phased.%A.e
#SBATCH --output=popgenWindow_fst_Dxy.atum_49_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono_phased.%A.o

module load bioinfo-tools python bcftools

GENO_INPUT=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/Fst_Dxy_martin
Atum_fai=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna.fai

cd $GENO_INPUT
GENO=merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno.gz
#ploidy=PloidyFile.Roc_281_dip.Se_203_86hap_117dip.list

popFile=popFile_8BF_1_4BF_2_12SA_8GZ_9LB_8TZ.list
OUT_CSV=merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno_csv.gz

## have issue - solution - index geno.gz file
## Traceback (most recent call last):   File "/usr/lib64/python2.7/multiprocessing/process.py", line 258, in _bootstrap     self.run()
## https://github.com/simonhmartin/genomics_general/issues/14

tabix -p $GENO

## --ploidyFile $ploidy
## --fai $Atum_fai ?
time python /home/yzliu/bin/simon_martin/popgenWindows.py -w 30000 -m 10 -g $GENO -o $OUT_CSV \
-p BF_1 -p BF_2 -p GZ -p LB -p SA -p TZ -f phased -T 6 --popsFile $popFile --addWindowID
