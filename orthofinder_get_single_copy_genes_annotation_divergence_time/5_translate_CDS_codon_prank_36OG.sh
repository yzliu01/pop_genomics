#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=05:45:00
##SBATCH --cpus-per-task 10
#SBATCH --mem 10g
##SBATCH --array=1-1%60
#SBATCH --job-name=4_translate_CDS_codon_prank_36OG
#SBATCH --error=4_translate_CDS_codon_prank_36OG.%A_%a.e
#SBATCH --output=4_translate_CDS_codon_prank_36OG.%A_%a.o
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
output_fa_name=${input_fa/fa/prank_codon.fa}
# align them using the codon model
prank -d=$input_fa -verbose \
    -o=./aligned_seq_14_species/$output_fa_name \
    -codon -F
done

# -iterate=8 -translate

exit 0

prank -d=OG0009421.cds.14_species.fa-stop2 -iterate=1 -verbose -o=./aligned_seq_14_species/OG0009421.cds.14_species.prank_translated.fa-stop-issue-iterate1 -translate -F

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
# -iterater8
# stop codon at the end
prank -d=OG0009251.cds.14_species.fa -iterate=8 -verbose \
    -o=./aligned_seq_14_species/OG0009251.cds.14_species.prank_codon-iterate8.fa \
    -codon -F

prank -d=OG0009251.cds.14_species.fa -iterate=2 -verbose \
    -o=./aligned_seq_14_species/OG0009251.cds.14_species.prank_codon-iterate2.fa \
    -codon -F

# -iterater2
prank -d=OG0009421.cds.14_species.fa -iterate=2 -verbose \
    -o=./aligned_seq_14_species/OG0009421.cds.14_species.prank_codon-iterater2.fa \
    -codon -F

# -iterater5
prank -d=OG0009421.cds.14_species.fa -iterate=5 -verbose \
    -o=./aligned_seq_14_species/OG0009421.cds.14_species.prank_codon-iterater5.fa \
    -codon -F

#"OG0009313" # not multiple of 3 bases
fa_list=(   ##"OG0009421"
            #"OG0009313"
            #"OG0009317"
            #"OG0009380"
            "OG0009487"
            "OG0009523"
            "OG0009546"

            )
for fa in `echo ${fa_list[*]}`
do
echo $fa
#done
prank -d="$fa".cds.14_species.fa -iterate=5 -verbose \
    -o=./aligned_seq_14_species/$fa.cds.14_species.prank_codon-iterater5.fa \
    -codon -F
done

## srun --account eDNA -t 10:00:00 --mem 16g --pty bash
## srun --account eDNA -t 00:30:00 --mem 40g --pty bash
