#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
##SBATCH -C mem128GB
#SBATCH -t 01:30:00
##SBATCH --array=1-49%10
#SBATCH -J create_ref_index_dict
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=create_ref_index_dict.%A.e
#SBATCH --output=create_ref_index_dict.%A.o

# 1\. index fasta file - bwa index -a bwtsw reference.fa
module load bioinfo-tools bwa samtools GATK
#module list:1) uppmax; 4) bwa/0.7.17; 7) GATK/4.3.0.0; 2) bioinfo-tools; 5) samtools/1.14; 3) sratools/3.0.0; 6) java/sun_jdk1.8.0_151
bwa index -a bwtsw /crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

# 2\. samtools faidx reference.fa
samtools faidx /crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna

# 3\. Create dictionary
## get local jar -> cmd: gatk CreateSequenceDictionary

java -jar /sw/bioinfo/GATK/4.3.0.0/rackham/gatk-package-4.3.0.0-local.jar CreateSequenceDictionary \
\-R /crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.fna \
\-O /crex/proj/snic2020-6-58/private/yzliu/test/ref_genome/AetTumi1.1_genomic_chr_1_8_mt.dict