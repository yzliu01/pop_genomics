#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=1-05:05:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 100g
##SBATCH --array=1-4%4
#SBATCH --job-name=pbadaptorfilt_Chorthippus_parallelus
#SBATCH --error=pbadaptorfilt_Chorthippus_parallelus.%A_%a.e
#SBATCH --output=pbadaptorfilt_Chorthippus_parallelus.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate related env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate HiFiAsm

export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt
export PATH=$PATH:/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/HiFiAdapterFilt/DB

## variable of script 
pbadaptorfilt_sh=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly/hifiasm/pbadaptorfilt.sh
## indicate only read file name suffix not full names

#61-75
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Chorthippus_parallelus
mkdir filtered
$pbadaptorfilt_sh -p ERR102248 -o ./filtered

