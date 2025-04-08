#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=12:05:00
#SBATCH --cpus-per-task 20
##SBATCH --ntasks=1
#SBATCH --mem 100g
##SBATCH --array=1-3%3
#SBATCH --job-name=check_cov_BomVet_hifi_asm
#SBATCH --error=check_cov_BomVet_hifi_asm.%A.e
#SBATCH --output=check_cov_BomVet_hifi_asm.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
#conda install bioconda::minimap2
#minimap2 -h

fq_s2=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.filt.fastq.gz
fq_s3=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.filt.fastq.gz
ref_BomVet_hifi_asm=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa
out_bam=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
time minimap2 -x map-pb -t 20 -a $ref_BomVet_hifi_asm $fq_s2 $fq_s3 | samtools sort -o $out_bam/BomVet_hifi_asm.aligned.bam --write-index -

bam_out_stats_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
cd $bam_out_stats_dir
time samtools coverage $out_bam/BomVet_hifi_asm.aligned.bam -o $bam_out_stats_dir/BomVet_hifi_asm.aligned.bam.samtools.cov.stats

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

