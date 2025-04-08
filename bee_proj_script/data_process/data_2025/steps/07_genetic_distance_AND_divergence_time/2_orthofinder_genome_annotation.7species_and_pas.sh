#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=04:50:00
#SBATCH --cpus-per-task 20
#SBATCH --ntasks=1
#SBATCH --mem 60g
##SBATCH --mem 100g
##SBATCH --array=1-1%60
##SBATCH --array=2-2159%60
#SBATCH --job-name=7and_pas
#SBATCH --error=7and_pas.%A.e
#SBATCH --output=7and_pas.%A.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate orthofinder # got error due to lower version of diamond 0.8.36 
work_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas
# data set of Apoidea or Hymenoptera
orthofinder -a 20 -f $work_dir # containing: And_bic_braker.aa.fa Apis_mel_braker.aa.fa

exit 0


## check if sequences in files in : Single_Copy_Orthologue_Sequences are from each species
Single_Copy_Orthologue_Sequences=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/OrthoFinder/Results_Aug29_1/Single_Copy_Orthologue_Sequences
cd $Single_Copy_Orthologue_Sequences
ls *.fa | xargs grep '>' -c > ../count_ortho_num_single_copy_ortho_seq.txt
