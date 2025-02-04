#!/bin/sh
#SBATCH --account eDNA
#SBATCH --time=04:45:00
##SBATCH --time=00:15:00
#SBATCH --cpus-per-task 20
#SBATCH --mem 10g
#SBATCH --job-name=7_bom_and_partition_mafft_align_codon
#SBATCH --error=7_bom_and_partition_mafft_align_codon.%A.e
#SBATCH --output=7_bom_and_partition_mafft_align_codon.%A.o

source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate myproject
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py

# bom_apis_8
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis

fas_1st=8species_211OG.codon1.fas
fas_2nd=8species_211OG.codon2.fas
fas_3rd=8species_211OG.codon3.fas

for fas in $fas_1st $fas_2nd $fas_3rd
do
##echo $fas
##done
#3 align each codon sequence
##mafft --localpair --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
mafft --auto --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
## convert fasta format to phylip format
$catfasta2phyml $fas.aligned.fas > $fas.aligned.phylip
done
## combine each codon file to a single one for mcmctree rum
cat 8species_211OG.codon*.aligned.phylip > 8species_211OG.cds_codons.txt


# and_pas_wasp
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas

fas_1st=7species_537OG.codon1.fas
fas_2nd=7species_537OG.codon2.fas
fas_3rd=7species_537OG.codon3.fas

for fas in $fas_1st $fas_2nd $fas_3rd
do
#echo $fas
#done
# align each codon sequence
mafft --auto --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
#mafft --localpair --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
# convert fasta format to phylip format
$catfasta2phyml $fas.aligned.fas > $fas.aligned.phylip
done
# combine each codon file to a single one for mcmctree rum
cat 7species_537OG.codon*.aligned.phylip > 7species_537OG.cds_codons.txt

