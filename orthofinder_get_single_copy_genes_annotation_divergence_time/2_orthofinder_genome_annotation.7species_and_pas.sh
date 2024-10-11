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
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
#conda create -n orthofinder -c bioconder orthofinder
conda activate orthofinder # got error due to lower version of diamond 0.8.36 
#conda install diamond=2.1.9 # update it
## run OrthoFinder on a directory (not a or some file/s) of protein sequence fasta files: 
## e.g. ./OrthoFinder/orthofinder -f /OrthoFinder/ExampleData/
#work_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/gene_annotation/orthofinder
work_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas
# data set of Apoidea or Hymenoptera
orthofinder -a 20 -f $work_dir # containing: And_bic_braker.aa.fa Apis_mel_braker.aa.fa

exit 0

## https://github.com/davidemms/OrthoFinder/tree/master/tools
primary_transcript_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/get_single_copy_genes_from_annotation/primary_transcript.py
ref_annotation=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation
cd $ref_annotation
for f in *.fa ; do python $primary_transcript_py $f ; done

Bom_syl_ref=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/Bombus_sylvestris-GCA_911622165.2-2023_03-pep.fa

cp $Bom_syl_ref $Bom_syl_ref.copy
python $primary_transcript_py $Bom_syl_ref.copy


## check if sequences in files in : Single_Copy_Orthologue_Sequences are from each species
Single_Copy_Orthologue_Sequences=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/OrthoFinder/Results_Aug29_1/Single_Copy_Orthologue_Sequences
cd $Single_Copy_Orthologue_Sequences
ls *.fa | xargs grep '>' -c > ../count_ortho_num_single_copy_ortho_seq.txt
