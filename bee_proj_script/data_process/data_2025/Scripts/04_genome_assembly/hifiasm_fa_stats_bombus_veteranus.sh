#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=02:05:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 100g
#SBATCH --array=1%1
#SBATCH --array=1-3%3
#SBATCH --job-name=hifiasm_purging_0_1_2_Bom_vet
#SBATCH --error=hifiasm_purging_0_1_2_Bom_vet.%A_%a.e
#SBATCH --output=hifiasm_purging_0_1_2_Bom_vet.%A_%a.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate HiFiAsm

# filtered fastq dir
filtered_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered
cd $filtered_dir

file1=HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.filt.fastq.gz
file2=HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.filt.fastq.gz
#purge_level_list=(0 1 2)
purge_level_list=(3)
purge_level=$(echo ${purge_level_list[@]} | tr ' ' '\n'| sed -n ${SLURM_ARRAY_TASK_ID}p)
# length of array
# echo ${#purge_level[@]}
# For inbred or homozygous genomes, you may disable purging with option -l0
# purge level. 0: no purging; 1: light; 2/3: aggressive [0 for trio; 3 for unzip]
time hifiasm -o Bombus_veteranus.pl_$purge_level.asm $file1 $file2 -t 20 -l"$purge_level" \
    > ./Bombus_veteranus.pl_$purge_level.out 2>./Bombus_veteranus.pl_$purge_level.error

exit 0

# step IV: convert .gfa file to .fasta file

for gfa in $(ls | grep '.asm.bp.p_ctg.gfa')
do
echo $gfa
#done
awk '/^S/{print ">"$2;print $3}' $gfa > ./assembly_fa_stats/$gfa.fa
done

# purging level 3
gfa=Bombus_veteranus.pl_3.asm.bp.p_ctg.gfa
awk '/^S/{print ">"$2;print $3}' $gfa > ./assembly_fa_stats/$gfa.fa


# step V: stats of assembly fasta
conda install bioconda::assembly-stats
conda install bioconda::quast
# help
assembly-stats
....

cd ./assembly_fa_stats
assembly-stats Bombus_veteranus.pl*.asm.bp.p_ctg.gfa.fa > stats_hifi_asm_with_fail.log
assembly-stats Bombus_veteranus.pl_3.asm.bp.p_ctg.gfa.fa >> stats_hifi_asm_with_fail.log



# step VI: assessment of completeness of genome assemblies or annotations by BUSCO
# best assembly
And_mar_raw_genome=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#Bombus_veteranus.pl_2.asm.bp.p_ctg.gfa.fa
cd $And_mar_raw_genome
# step VII: rename fasta headers and reorder them
hifi_asm=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm
sed 's/\(>ptg.*\)/\1 \[Bombus veteranus\]/' Bombus_veteranus.pl_2.asm.bp.p_ctg.gfa.fa | less -S | grep '^>' | sed 's/>//' | sort -V > $hifi_asm/Bom_vet_fasta_headers.list
sed 's/\(>ptg.*\)/\1 \[Bombus veteranus\]/' Bombus_veteranus.pl_2.asm.bp.p_ctg.gfa.fa > Bombus_veteranus.hifi_asm_pl2.fa

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