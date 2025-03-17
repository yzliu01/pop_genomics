#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 8
#SBATCH -t 00:30:00
#SBATCH -J shapeit4.contig001.lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=shapeit4.contig001.lap_mon.%A.%a.e
#SBATCH --output=shapeit4.contig001.lap_mon.%A.%a.o

module load bioinfo-tools SHAPEIT
#module load bioinfo-tools python bcftools

shape_out=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/shapeit
cd $shape_out

#vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/samtools_bam_depth/M_L013.sorted_marked_dups.bam.001.out_mf.vcf.gz
#gzip -d $vcf
unzipped_vcf=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL/samtools_bam_depth/M_L013.sorted_marked_dups.bam.001.out_mf.vcf
#bgzip -k $unzipped_vcf
bgzipped_vcf=$unzipped_vcf.gz
#bcftools index $bgzipped_vcf

shapeit4 --input $bgzipped_vcf -O M_L013_chr001.phase --region contig_001 --thread 8
