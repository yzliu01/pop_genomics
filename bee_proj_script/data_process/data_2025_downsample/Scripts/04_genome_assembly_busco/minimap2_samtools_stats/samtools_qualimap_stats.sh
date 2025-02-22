#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=01:05:00
#SBATCH --cpus-per-task 20
##SBATCH --ntasks=1
#SBATCH --mem 100g
##SBATCH --array=1-3%3
#SBATCH --job-name=check_stats_BomVet_hifi
#SBATCH --error=check_stats_BomVet_hifi.%A.e
#SBATCH --output=check_stats_BomVet_hifi.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
#conda install bioconda::minimap2
#minimap2 -h
bam_raw_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus
cd $bam_raw_dir
bam_out_stats_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
#bamtools stats -in $MARKED_BAM > ./bam_stats/bamtools_stats/$MARKED_BAM
#samtools stats -in $MARKED_BAM > ./bam_stats/samtools_stats/$MARKED_BAM

## merge two raw bam files
#samtools merge -o Bomvet.hifi_reads.s2_s3.bam HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.bam HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.bam

## run stats
samtools stats -in Bomvet.hifi_reads.s2_s3.bam > $bam_out_stats_dir/Bomvet.hifi_reads.s2_s3.bam.samtools.stats
#samtools stats -in HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.bam > $bam_out_stats_dir/BomVet_hifi_s2.bam.samtools.stats
#samtools stats -in HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.bam > $bam_out_stats_dir/BomVet_hifi_s3.bam.samtools.stats

exit 0

# samtools
grep -v '^#' $bam_out_stats_dir/BomVet_hifi_asm.aligned.bam.samtools.cov.stats | awk '{i>0;i++;sum_coverage += $6; sum_meandepth += $7} END {print sum_coverage/i "\t" sum_meandepth/i;}'
cov     depth
99.9087 12.8949

# https://hifiasm.readthedocs.io/en/latest/faq.html
# Usually >=13x HiFi reads per haplotype. Higher coverage might be able to improve the contiguity of assembly.

# qualimap

>>>>>>> Reference

     number of bases = 356,460,956 bp
     number of contigs = 742

>>>>>>> Globals

     number of windows = 1141

     number of reads = 1,098,117
     number of mapped reads = 1,086,938 (98.98%)
     number of supplementary alignments = 25,795 (2.35%)
     number of secondary alignments = 601,908

     number of mapped bases = 10,594,840,313 bp
     number of sequenced bases = 10,562,348,653 bp
     number of aligned bases = 0 bp
     number of duplicated reads (estimated) = 20,179
     duplication rate = 0.52%

>>>>>>> Coverage

     mean coverageData = 29.7223X
     std coverageData = 14.1034X

