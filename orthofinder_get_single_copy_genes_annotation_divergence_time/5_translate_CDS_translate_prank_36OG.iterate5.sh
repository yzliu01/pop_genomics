#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=05:45:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 10g
##SBATCH --array=1-1%60
#SBATCH --job-name=4_translate_CDS_translate_prank_36OG_iterate5
#SBATCH --error=4_translate_CDS_translate_prank_36OG_iterate5.%A_%a.e
#SBATCH --output=4_translate_CDS_translate_prank_36OG_iterate5.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model.
## https://ariloytynoja.github.io/prank-msa/#methods
conda activate myproject

#busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
extracted_cds_seq_14_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new
cd $extracted_cds_seq_14_species

#ulimit -c unlimited

mkdir aligned_seq_14_species

#input_fa=$(ls *.cds.14_species.fa | sed -n ${SLURM_ARRAY_TASK_ID}p)
for input_fa in $(ls *.cds.14_species.fa)
do
output_fa_name=${input_fa/fa/prank_translate.iterate5.fa}
# align them using the codon model
prank -d=$input_fa -verbose \
    -o=./aligned_seq_14_species/$output_fa_name \
    -translate -F
done

# -iterate=8 -translate

exit 0

prank -d=OG0009421.cds.14_species.fa-stop2 -iterate=1 -verbose -o=./aligned_seq_14_species/OG0009421.cds.14_species.prank_translated.fa-stop-issue-iterate1 -codon -translate -F

# http://wasabiapp.org/software/prank/
# codon alignment
prank -d=OG0009421.cds.14_species.fa-stop2 -iterate=8 -verbose -o=./aligned_seq_14_species/OG0009421.cds.14_species.prank_translated.fa-stop-issue-iterate8-codon -codon -F

# output reordered the original sequence order

exit 0

# translated alignments of protein-coding DNA sequences
prank -d=OG0009015.cds.14_species.fa -iterate=4 -verbose \
    -o=./aligned_seq_14_species/OG0009015.cds.14_species.prank_translated.fa \
    -translate -F

# align them using the codon model
prank -d=OG0009251.cds.14_species.fa -iterate=5 -verbose \
    -o=./aligned_seq_14_species/OG0009251.cds.14_species.prank_codon.dumped.fa \
    -codon -F


## srun --account eDNA -t 10:00:00 --mem 16g --pty bash
## srun --account eDNA -t 00:30:00 --mem 40g --pty bash

************ latest results with transcript_id ************

-----------------
 PRANK v.170427:
-----------------

Input for the analysis
 - aligning sequences in 'OG0009015.cds.14_species.fa'
 - using inferred alignment guide tree
 - external tools available:
    MAFFT for initial alignment

Correcting (arbitrarily) for multifurcating nodes.
Correcting (arbitrarily) for multifurcating nodes.

Generating multiple alignment: iteration 1.
#13#(13/13): 98% computed                    
Alignment score: 36
Correcting (arbitrarily) for multifurcating nodes.
