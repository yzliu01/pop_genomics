
## trim stop codon before using prank alignment
#conda activate bioproject
conda activate myproject
#trim_cds_stop_codon=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_cds_stop_codon.py
trim_cds_stop_codon_uppercase=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_cds_stop_codon_uppercase.py

python $trim_cds_stop_codon_uppercase --help

# 8_bom_apis
new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $new_transcript_id_8_bom_apis

# 7_and_pas
new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $new_transcript_id_7_and_pas

#for fa in $(ls OG*cds.14_species*.fa)

# 8_bom_apis
#for fa in $(ls OG*cds.8_species.trimmed.fa)

# 7_and_pas
for fa in $(ls OG*cds.7_species.trimmed.fa)
do
# trim stop codons at the end of the sequences
echo "trimming stop codon: $fa"
output_tem_fa=${fa/fa/trimmed_stop_codon.fa}
#ython $trim_cds_stop_codon_uppercase -i $fa -o ./aligned_seq_14_species_iterate2/trimmed_stop_codon_concat/$output_tem_fa
python $trim_cds_stop_codon_uppercase -i $fa -o $output_tem_fa
done

## run prank - codon - to align sequences
# script is here
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/git_demography_pollinator_decline/Scripts/genetic_distance_&_divergence_time/5_prank_codon_537OG.7_and_pas.iterate2.sh
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/git_demography_pollinator_decline/Scripts/genetic_distance_&_divergence_time/5_prank_codon_211OG.8_bom_apis.iterate2.sh


## make sure fasta haders have the same name
cd ./trimmed_stop_codon_concat

# 8_bom_apis
new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $new_transcript_id_8_bom_apis

# 7_and_pas
new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $new_transcript_id_7_and_pas

for fa in $(ls OG*cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas)
#for fa in $(ls OG*cds.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas)
do
echo "making same headers: $output_fa"
output_fa=${fa/fa.best.fas/same_header.fas}
sed -E 's/(^>[^.]*)\..*/\1/' $fa > $output_fa
# delete temporary file
#echo "deleting $fa"
#rm $fa
done


##  concatenate alignmeng of each gene
## https://github.com/nylander/catfasta2phyml
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py

new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $new_transcript_id_8_bom_apis
# 8_bom_apis
$catfasta2phyml -f OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
# format fasta file
$catfasta2phyml -f OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas


new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $new_transcript_id_7_and_pas
# 7_and_pas
$catfasta2phyml -ps OG*7species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.7_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
# format fasta file
$catfasta2phyml -f OG*7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.7_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas



## step VIII: divide_codon_by_position
conda activate myproject
divide_codon_by_position=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/divide_codon_by_position.py
# Usage: python script.py <input_fasta> <codon1_output> <codon2_output> <codon3_output>

## bom_apis_8
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
bom_apis_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis/cat.out.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
python $divide_codon_by_position $bom_apis_fa 8species_211OG.codon1.fas 8species_211OG.codon2.fas 8species_211OG.codon3.fas

## and_pas_7
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
and_pas_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas/cat.out.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
python $divide_codon_by_position $and_pas_fa 7species_537OG.codon1.fas 7species_537OG.codon2.fas 7species_537OG.codon3.fas



## align 1st, 2nd, and 3rd codons - run large data on server
conda activate myproject
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
trimmed_stop_codon_concat=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat

## run large data on server
## 7_mafft_align_codon.sh

# bom_apis_wasp
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis

fas_1st=8species_211OG.codon1.fas
fas_2nd=8species_211OG.codon2.fas
fas_3rd=8species_211OG.codon3.fas

for fas in $fas_1st $fas_2nd $fas_3rd
do
#echo $fas
#done
# align each codon sequence
mafft --localpair --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
# convert fasta format to phylip format
$catfasta2phyml $fas.aligned.fas > $fas.aligned.phylip
done
# combine each codon file to a single one for mcmctree rum
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
mafft --localpair --maxiterate 1000 --thread 20 $fas > $fas.aligned.fas
# convert fasta format to phylip format
$catfasta2phyml $fas.aligned.fas > $fas.aligned.phylip
done
# combine each codon file to a single one for mcmctree rum
cat 7species_537OG.codon*.aligned.phylip > 7species_537OG.cds_codons.txt

