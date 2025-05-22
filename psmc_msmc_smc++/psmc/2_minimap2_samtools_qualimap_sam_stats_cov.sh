#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=1-12:05:00
#SBATCH --cpus-per-task 20
##SBATCH --ntasks=1
#SBATCH --mem 100g
#SBATCH --array=1-4%4
#SBATCH --job-name=hifi_fq2bam_mapping_sam_stats_cov_AndHae_AndMar_BomPas_BomVet
#SBATCH --error=hifi_fq2bam_mapping_sam_stats_cov_AndHae_AndMar_BomPas_BomVet.%A_%a.e
#SBATCH --output=hifi_fq2bam_mapping_sam_stats_cov_AndHae_AndMar_BomPas_BomVet.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
# or
# conda activate HiFiAsm
#conda install bioconda::minimap2
#minimap2 -h

# test with the 2 file
#SLURM_ARRAY_TASK_ID=1
for SLURM_ARRAY_TASK_ID in {1..4}
do
#echo $SLURM_ARRAY_TASK_ID
#done
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ref_list=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Bombus_veteranus.hifi_asm_pl2.fa"
)
ref=$(echo ${ref_list[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)
#echo $ref

hifi_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi
fq_file_list=(
    "andrena_harmorrhoa/ERR6412038.fastq.gz"
    "andrena_marginata/ERR11180452.fastq.gz"
    "bombus_pascuorum/ERR6548408.fastq.gz"
    "bombus_veteranus/filtered/hifi_reads.filt.merged.fastq.gz"
)

## merge multiple fastq files into a single one using cat
# https://www.biostars.org/p/136025/
#cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered
#ls *hifi_reads.bc2055.filt.fastq.gz
#cat *hifi_reads.bc2055.filt.fastq.gz > hifi_reads.filt.merged.fastq.gz

fq_file=$(echo ${fq_file_list[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)

output_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/output_bam_psmc
out_bam_list=(
    "AndHae_hifi_asm.aligned.bam"
    "AndMar_hifi_asm.aligned.bam"
    "BomPas_hifi_asm.aligned.bam"
    "BomVet_hifi_asm.aligned.bam"
)
out_bam=$(echo ${out_bam_list[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)

cd $output_dir
# https://github.com/lh3/minimap2
# detailed manual
# https://lh3.github.io/minimap2/minimap2.html; ./minimap2 -ax map-hifi ref.fa pacbio-ccs.fq.gz > aln.sam # PacBio HiFi/CCS genomic reads (v2.19 or later)
# align long reads to reference genomes

# output in the SAM format -a; wrong option: map-pb; (minimap2 --version 2.17-r941)-x map-hifi : [ERROR] unknown preset 'map-hifi'
## force to updata it; https://bioconda.github.io/recipes/minimap2/README.html
#conda install minimap2=2.28
#conda install --force-reinstall minimap2
# mamba install minimap2=2.28 # fast

time minimap2 -x map-hifi -t 20 -a $ref_dir/$ref $hifi_dir/$fq_file | samtools sort -o $output_dir/$out_bam --write-index -

# bam stats on aligned bam files
bam_out_stats_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
cd $bam_out_stats_dir
time samtools coverage $output_dir/$out_bam -o $out_bam.samtools.cov.stats
#time samtools stats -in $output_dir/$out_bam > $out_bam.samtools.stats

# samtools cov outputs
grep -v '^#' $out_bam.samtools.cov.stats | awk -v out_bam="$out_bam" 'BEGIN {i=0; sum_coverage=0; sum_meandepth=0}{i++;sum_coverage += $6; sum_meandepth += $7} END {print out_bam ".samtools.cov: ", sum_coverage/i, sum_meandepth/i;}'
#cov     depth
#99.9087 12.8949
done

exit 0

AndHae_hifi_asm.aligned.bam.samtools.cov:  99.7685 55.4087
AndMar_hifi_asm.aligned.bam.samtools.cov:  99.9983 115.417
BomPas_hifi_asm.aligned.bam.samtools.cov:  99.9783 124.556
BomVet_hifi_asm.aligned.bam.samtools.cov:  99.9481 12.8501


fq_s2=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.filt.fastq.gz
fq_s3=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered/HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.filt.fastq.gz
ref_BomVet_hifi_asm=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa
out_bam=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
time minimap2 -x map-pb -t 20 -a $ref_BomVet_hifi_asm $fq_s2 $fq_s3 | samtools sort -o $out_bam/BomVet_hifi_asm.aligned.bam --write-index -

bam_out_stats_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
cd $bam_out_stats_dir
time samtools stat $out_bam/BomVet_hifi_asm.aligned.bam -o $bam_out_stats_dir/BomVet_hifi_asm.aligned.bam.samtools.cov.stats

exit 0

# samtools cov outputs
grep -v '^#' $bam_out_stats_dir/BomVet_hifi_asm.aligned.bam.samtools.cov.stats | awk '{i>0;i++;sum_coverage += $6; sum_meandepth += $7} END {print sum_coverage/i "\t" sum_meandepth/i;}'
cov     depth
99.9087 12.8949
# example results
#rname	startpos	endpos	numreads	covbases	coverage	meandepth	meanbaseq	meanmapq
ptg000001l	1	9230241	33357	9230241	100	34.787	38.9	59.6
ptg000002l	1	4244569	15713	4244564	99.9999	34.8777	38.9	55.9
ptg000003l	1	4249947	13730	4249934	99.9997	30.3519	39	58.1

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

-x STR 	Preset []. This option applies multiple options at the same time. It should be applied before other options because options applied later will overwrite the values set by -x. Available STR are:
map-ont 	Align noisy long reads of ~10% error rate to a reference genome. This is the default mode.
map-hifi 	Align PacBio high-fidelity (HiFi) reads to a reference genome (-k19 -w19 -U50,500 -g10k -A1 -B4 -O6,26 -E2,1 -s200).
map-pb 	Align older PacBio continuous long (CLR) reads to a reference genome (-Hk19).
asm5 	Long assembly to reference mapping (-k19 -w19 -U50,500 --rmq -r100k -g10k -A1 -B19 -O39,81 -E3,1 -s200 -z200 -N50). Typically, the alignment will not extend to regions with 5% or higher sequence divergence. Only use this preset if the average divergence is far below 5%.
asm10 	Long assembly to reference mapping (-k19 -w19 -U50,500 --rmq -r100k -g10k -A1 -B9 -O16,41 -E2,1 -s200 -z200 -N50). Up to 10% sequence divergence.
asm20 	Long assembly to reference mapping (-k19 -w10 -U50,500 --rmq -r100k -g10k -A1 -B4 -O6,26 -E2,1 -s200 -z200 -N50). Up to 20% sequence divergence.
splice 	Long-read spliced alignment (-k15 -w5 --splice -g2k -G200k -A1 -B2 -O2,32 -E1,0 -b0 -C9 -z200 -ub --junc-bonus=9 --cap-sw-mem=0 --splice-flank=yes). In the splice mode, 1) long deletions are taken as introns and represented as the ‘N’ CIGAR operator; 2) long insertions are disabled; 3) deletion and insertion gap costs are different during chaining; 4) the computation of the ‘ms’ tag ignores introns to demote hits to pseudogenes.
splice:hq 	Long-read splice alignment for PacBio CCS reads (-xsplice -C5 -O6,24 -B4).
sr 	Short single-end reads without splicing (-k21 -w11 --sr --frag=yes -A2 -B8 -O12,32 -E2,1 -b0 -r100 -p.5 -N20 -f1000,5000 -n2 -m20 -s40 -g100 -2K50m --heap-sort=yes --secondary=no).
ava-pb 	PacBio CLR all-vs-all overlap mapping (-Hk19 -Xw5 -e0 -m100).
ava-ont 	Oxford Nanopore all-vs-all overlap mapping (-k15 -Xw5 -e0 -m100 -r2k). 