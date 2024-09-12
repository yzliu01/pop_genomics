#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=03:05:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 100g
#SBATCH --array=1-3%3
#SBATCH --job-name=hifiasm_purging_0_1_2_Bom_vet_with_fail
#SBATCH --error=hifiasm_purging_0_1_2_Bom_vet_with_fail.%A_%a.e
#SBATCH --output=hifiasm_purging_0_1_2_Bom_vet_with_fail.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

# step III
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate HiFiAsm

# filtered fastq dir
filtered_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered
cd $filtered_dir

# four input files
file1=HMW_Bom_m84108_240904_160210_s2.hifi_reads.bc2055.filt.fastq.gz
file2=HMW_Bom_m84108_240904_180129_s3.hifi_reads.bc2055.filt.fastq.gz
file3=HMW_Bom_m84108_240904_160210_s2.fail_reads.bc2055.filt.fastq.gz
file4=HMW_Bom_m84108_240904_180129_s3.fail_reads.bc2055.filt.fastq.gz

purge_level_list=(0 1 2)
purge_level=$(echo ${purge_level_list[@]} | tr ' ' '\n'| sed -n ${SLURM_ARRAY_TASK_ID}p)
# length of array
# echo ${#purge_level[@]}
# For inbred or homozygous genomes, you may disable purging with option -l0
# purge level. 0: no purging; 1: light; 2/3: aggressive [0 for trio; 3 for unzip]
time hifiasm -o Bombus_veteranus.pl_$purge_level.with_fail.asm $file1 $file2 $file3 $file4 -t 20 -l"$purge_level" \
    > ./Bombus_veteranus.pl_"$purge_level".with_fail.out 2>./Bombus_veteranus.pl_"$purge_level".with_fail.error

exit 0

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
conda activate HiFiAsm
#conda install bamtools blast
# blastn

# make sure the folder name is HiFiAdapterFilt/DB otherwise change it in the pbadaptorfilt.sh
# Add script and database to your path using:
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/DB

#hifiadaptorfilt=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt-master/hifiapterfilt.sh
#$hifiadaptorfilt -o filtered
pbadaptorfilt=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/pbadapterfilt.sh
$pbadaptorfilt

# move files to folder filtered
filtered=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/bombus_veteranus/filtered
ls | grep -v ".bam" | xargs cp $filtered