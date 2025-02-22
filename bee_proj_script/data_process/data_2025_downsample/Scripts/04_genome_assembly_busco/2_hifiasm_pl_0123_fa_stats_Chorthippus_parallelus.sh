#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=2-15:05:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 800g
##SBATCH --mem 500g # not enough
#SBATCH --array=1-4%4
#SBATCH --job-name=hifiasm_purging_0_1_2_3_Cho_par
#SBATCH --error=hifiasm_purging_0_1_2_3_Cho_par.%A_%a.e
#SBATCH --output=hifiasm_purging_0_1_2_3_Cho_par.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# step III
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate HiFiAsm

# filtered fastq dir
filtered_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_parallelus/filtered
cd $filtered_dir

#file1=ERR10224876.fastq.gz
#file2=ERR10224877.fastq.gz
file=ERR102248*.filt.fastq.gz
purge_level_list=(0 1 2 3)
#purge_level_list=(3)
purge_level=$(echo ${purge_level_list[@]} | tr ' ' '\n'| sed -n ${SLURM_ARRAY_TASK_ID}p)
# length of array
# echo ${#purge_level[@]}
# For inbred or homozygous genomes, you may disable purging with option -l0
# purge level. 0: no purging; 1: light; 2/3: aggressive [0 for trio; 3 for unzip]
#time hifiasm -o Chorthippus_parallelus.pl_$purge_level.asm $file1 $file2 -t 20 -l"$purge_level" \
#    > ./Chorthippus_parallelus.pl_$purge_level.out 2>./Chorthippus_parallelus.pl_$purge_level.error

time hifiasm -o Chorthippus_parallelus.pl_$purge_level.asm $file -t 20 -l"$purge_level" \
    > ./Chorthippus_parallelus.pl_$purge_level.out 2>./Chorthippus_parallelus.pl_$purge_level.error

exit 0

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission
sbatch 

# step IV: convert primary contig: .asm.bp.p_ctg.gfa file to .fasta file
mkdir assembly_fa_stats

for gfa in $(ls | grep '.asm.bp.p_ctg.gfa')
do
echo $gfa
#done
awk '/^S/{print ">"$2;print $3}' $gfa > ./assembly_fa_stats/$gfa.fa
done

# purging level 3
gfa=Chorthippus_parallelus.pl_3.asm.bp.p_ctg.gfa
awk '/^S/{print ">"$2;print $3}' $gfa > ./assembly_fa_stats/$gfa.fa

less -S Chorthippus_parallelus.pl_0.asm.bp.p_ctg.gfa.fa
>ptg000001l
ATACGGGTCACTGGGC
>ptg000002l
ACGAAGAGTGGTTTTC

# step V: stats of assembly fasta
conda activate HiFiAsm
conda install bioconda::assembly-stats
conda install bioconda::quast
# help
assembly-stats
....

cd ./assembly_fa_stats
assembly-stats Chorthippus_parallelus.pl*.asm.bp.p_ctg.gfa.fa > stats_hifi_asm_with_fail.log
assembly-stats Chorthippus_parallelus.pl_3.asm.bp.p_ctg.gfa.fa >> stats_hifi_asm_with_fail.log

# need BUSCO mapping to assess the quality of ref genome (No. of single copy genes and complete genes)
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm/busco_summary
# according to earlier analysis/assembly, puring level at 2 gave better assembly.

** step VI: assessment of completeness of genome assemblies or annotations by BUSCO **
# best assembly
#raw_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
raw_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_parallelus/filtered/assembly_fa_stats
# Chorthippus_parallelus.pl_2.asm.bp.p_ctg.gfa.fa
cd $raw_genome

# step VII: rename fasta headers and reorder them
hifi_asm=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
sed 's/\(>ptg.*\)/\1 \[Notonecta glauca\]/' Chorthippus_parallelus.pl_2.asm.bp.p_ctg.gfa.fa | less -S
# >ptg000001l [Notonecta glauca]
# ATTTGGTTGTTGCTTTGCACATAGTACAAT
sed 's/\(>ptg.*\)/\1 \[Notonecta glauca\]/' Chorthippus_parallelus.pl_2.asm.bp.p_ctg.gfa.fa | less -S | grep '^>' | sed 's/>//' | sort -V > $hifi_asm/Not_gla_fasta_headers.list
sed 's/\(>ptg.*\)/\1 \[Notonecta glauca\]/' Chorthippus_parallelus.pl_2.asm.bp.p_ctg.gfa.fa > Chorthippus_parallelus.hifi_asm_pl2.fa

# script to reorder fasta headers
reorder_fasta_sequences=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/reorder_fasta_sequences_post_muscle_align.sh



# step I
# download bam files from the server of provider
# https://filesender.deic.dk/download.php?token=f3d3819d-af01-46c5-bfc8-50ef202bbbf5&files_ids=337768
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus
wget 'https://filesender.deic.dk/download.php?token=f3d3819d-af01-46c5-bfc8-50ef202bbbf5&files_ids=337768%2C337769%2C337770%2C337771'

# install assemblier
conda create -n HiFiAsm bioconda::hifiasm
unzip 'download.php?token=f3d3819d-af01-46c5-bfc8-50ef202bbbf5&files_ids=337768,337769,337770,337771'

HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.bam
HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.bam

# step II
# convert bam to fastq files and remove adaptor sequences
# https://github.com/sheinasim/HiFiAdapterFilt/tree/master
conda activate HiFiAsm
#conda install bamtools blast
# blastn

# Add script and database to your path using:
# make sure the folder name is HiFiAdapterFilt/DB otherwise change it in the pbadaptorfilt.sh
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/DB

#hifiadaptorfilt=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt-master/hifiapterfilt.sh
#$hifiadaptorfilt -o filtered
pbadaptorfilt=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/pbadapterfilt.sh
# run pbadaptorfilt.sh in the folder
$pbadaptorfilt

# move files to folder filtered
filtered=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered
ls | grep -v ".bam" | xargs cp $filtered