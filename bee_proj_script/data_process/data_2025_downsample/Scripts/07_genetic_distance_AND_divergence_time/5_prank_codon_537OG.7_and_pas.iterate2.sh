#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=1-24:00:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 10g
#SBATCH --job-name=5_537OG_7_And_Pas.iterate2
#SBATCH --error=5_537OG_7_And_Pas.iterate2.%A.e
#SBATCH --output=5_537OG_7_And_Pas.iterate2.%A.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model.
## https://ariloytynoja.github.io/prank-msa/#methods
conda activate myproject

#busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
trimmed_stop_codon_concat=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
#extracted_cds_seq_14_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new
cd $trimmed_stop_codon_concat

#ulimit -c unlimited

#input_fa=$(ls *.cds.14_species.fa | sed -n ${SLURM_ARRAY_TASK_ID}p)
#for input_fa in $(ls OG*.cds.14_species.fa)
for input_fa in $(ls OG*.cds.7_species.trimmed.trimmed_stop_codon.fa) # not finished
do
output_fa_name=${input_fa/fa/prank_codon.iterate2.fa}
# align them using the codon model
prank -d=$input_fa -iterate=2 -verbose \
    -o=$output_fa_name \
    -codon -F
done

# output sequences are in uppercase
# -iterate=8 -translate

exit 0
