#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=04:00:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 60g
##SBATCH --mem 100g
##SBATCH --array=1-1%60
##SBATCH --array=2-2159%60
#SBATCH --job-name=8bom_apis
#SBATCH --error=8bom_apis.%A.e
#SBATCH --output=8bom_apis.%A.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate orthofinderwork_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis
# data set of Apoidea or Hymenoptera
orthofinder -a 20 -f $work_dir # containing: And_bic_braker.aa.fa Apis_mel_braker.aa.fa

exit 0
