#!/bin/bash -l
#SBATCH -A snic2022-22-258
#SBATCH -p node
##SBATCH -n 18
#SBATCH -t 6-04:20:00
#SBATCH -C mem256GB
#SBATCH -J atum_geno_dist
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=8_geno_dist.atum_49_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.ploidy_flag.%A.e
#SBATCH --output=8_geno_dist.atum_49_EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.ploidy_flag.%A.o

module load bioinfo-tools python bcftools

## vcf file
INPUT_DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping
INPUT_VCF=$INPUT_DIR/merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.vcf.gz

## provide a fasta index file using the --fai option in parseVCFs.py; alternatively, add vcf header after phasing
# Ploidy_File=PloidyFile.Roc_281_dip.Se_203_86hap_117dip.list

time bcftools index $INPUT_VCF
GENO_DIR=/crex/proj/snic2020-6-58/private/yzliu/test/fastq_bt/gVCF/DB_VCF/merged_gvcf_genotyping/Fst_Dxy_martin
GENO=$GENO_DIR/merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno.gz
Atum_fai=/crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna.fai

cd $GENO_DIR

# --minQual 30 --gtf flag=DP min=5 max=100 --ploidyFile $Ploidy_File
## default 
## For parallel processing using tabix, the wrapper parseVCFs.py uses the contig lengths provided in the header of the VCF file. \
If you prefer to skip these, or if there is no header, you can provide a fasta index file using the --fai option.
time python /home/yzliu/bin/parseVCFs.py -i $INPUT_VCF \
--fai $Atum_fai --ploidyMismatchToMissing --skipIndels --threads 18 | bgzip > $GENO

## https://github.com/simonhmartin/genomics_general/issues/29
## -g input.geno.gz -f phased --windType cat -o output.dist
# time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 \
# --haploid M_L075 M_L093 M_L113 M_L130 M_L131 M_L133 M_L136 M_L140 M_L143 
# -o $DIST

DIST=merged_49Atum.SNP.H_F.EH_50_FMT_DP3_50_GQ20_BiSNP_mac2_missing05_rmMono.phased.header_lines.geno.dist
## 74 geno - 190 min dist + days
# --ploidyFile $Ploidy_File
time python /home/yzliu/bin/distMat.py -f phased -g $GENO --windType cat -T 18 -o $DIST


