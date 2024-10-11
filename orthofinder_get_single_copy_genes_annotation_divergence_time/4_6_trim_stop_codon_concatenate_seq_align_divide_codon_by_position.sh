
# 14_species.prank.fasta

******** step IV: trim stop codon before using prank alignment ***********
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

********* step V: run prank - codon - to align sequences ***********
# script is here
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_CDS_codon_prank_36OG.iterate2.sh


********* step VI: make sure fasta haders have the same name ***********
cd ./trimmed_stop_codon_concat
#for fa in $(ls OG*cds.14_species*trimmed_stop_codon.prank_codon.iterate2*fas)

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


************ old steps: necessary following step: trim stop codon **********

#aligned_seq_14_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species
#cd $aligned_seq_14_species

aligned_seq_14_species_iterate2=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2
cd $aligned_seq_14_species_iterate2

# test wtih $aligned_seq_14_species
#input_fa=OG0009251.cds.14_species.prank_codon-iterate8.fa.best.fas
#output_fa=OG0009251.cds.14_species.prank_codon-iterate8-trim-stop-codon.fa.best.fas
#python $trim_cds_stop_codon_uppercase -i $input_fa -o ./trimmed_stop_codon/$output_fa

# step I and II
for fas in $(ls OG*prank_codon.iterate2*best.fas)
do
# trim stop codons at the end of the sequences
echo "trimming stop codon: $fas"
output_tem_fa=${fas/fa.best.fas/trimmed_stop_codon.fas}
python $trim_cds_stop_codon_uppercase -i $fas -o ./trimmed_stop_codon_concat/$output_tem_fa
# make sure fasta haders have the same name
echo "making same headers: $output_tem_fa"
output_fa=${output_tem_fa/fas/same_header.fas}
sed -E 's/(^>[^.]*)\..*/\1/' ./trimmed_stop_codon_concat/$output_tem_fa > ./trimmed_stop_codon_concat/$output_fa
# delete temporary file
echo "deleting $output_tem_fa"
rm ./trimmed_stop_codon_concat/$output_tem_fa
done

************ step VII: concatenate alignmeng of each gene *************
# step III
## https://github.com/nylander/catfasta2phyml
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py

# format fasta file
$catfasta2phyml -f OG*14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.fas > cat.out.14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.fas

## format strick phylip format using plags -p and -s as a combination (see --help)
cd ./trimmed_stop_codon_concat
$catfasta2phyml -ps OG*14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.fas > cat.out.14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.phy
$catfasta2phyml -ps OG*14_species.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas > cat.out.14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.phy

# final cat
$catfasta2phyml -f OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas > cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
$catfasta2phyml -ps OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas > cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy

## new run
# 9_bom_apis_wasp
$catfasta2phyml -ps OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.9_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
OG0009541.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 141541-143319
OG0009548.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 143320-147780
OG0009549.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 147781-149493
OG0009565.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 149494-153192
# new run for 75 OG
$catfasta2phyml -ps OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.9_species_75OG.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
OG0009573.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 74452-77133
OG0009574.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 77134-78801
OG0009590.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 78802-80622

# format fasta file
#$catfasta2phyml -f OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.9_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
$catfasta2phyml -f OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.9_species_75OG.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

## issue of not enough data
alignment_over_50perct_data=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp/alignment_over_50perct_data
fas_list=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp/cat.out_no_missing_over_50perct.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas.list
cd $alignment_over_50perct_data
for fas in `cat $fas_list`
do
cp $fas $alignment_over_50perct_data
done

$catfasta2phyml -ps OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.48_alignment_over_50perct_data.9_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
OG0009549.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 147781-149493
OG0009565.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 149494-153192

# format fasta file
$catfasta2phyml -f OG*9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.48_alignment_over_50perct_data.9_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

# 8_and_pas_wasp
$catfasta2phyml -ps OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
OG0009293.cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 116626-118137
OG0009294.cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 118138-118998
# format fasta file
$catfasta2phyml -f OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas


# display
OG0009220.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 1-735
OG0009227.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 736-2385
...
OG0009534.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 44488-45486
OG0009546.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 45487-47058



## https://github.com/ballesterus/Utensils
geneStitcher=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/geneStitcher.py
python $geneStitcher -h

Traceback (most recent call last):
  File "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/geneStitcher.py", line 6, in <module>
    from partBreaker import WritePresAb
ModuleNotFoundError: No module named 'partBreaker'


## https://jlsteenwyk.com/PhyKIT/usage/index.html#create-concatenation-matrix
conda search phykit
conda install phykit
phykit create_concat -a file -p prefix.name.out
phykit create_concat -a conc_two_gene_align.list -p conc_32320at7399_32232at7399.align.afa


## Run AMAS to obtain various kinds of information about each alignment
## https://github.com/marekborowiec/AMAS
AMAS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/AMAS/amas
#cd $AMAS_dir
python $AMAS_dir/AMAS.py -h

## get summary statistics
cd $aligned_seq_14_species
aligned_seq=OG0009055.cds.14_species.prank_translated.fa.best.nuc.fas
#python $AMAS_dir/AMAS.py summary -h
python $AMAS_dir/AMAS.py summary -f fasta -d dna -i $aligned_seq_14_species/$aligned_seq #> ../reorder_test_summary/sum.82at7399.txt
# Wrote summaries to file 'summary.txt'
cut -f 6 summary.txt
Missing_percent
0.176

bom_apis_wasp_9=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp
cd $bom_apis_wasp_9

python $AMAS_dir/AMAS.py summary -f fasta -d dna -i OG0009123.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas -o OG0009123.cds.9_species.summary_alignment.log

for fas in `ls OG*iterate2.same_header.fas | sort -V`
do
out_OG_id=${fas/\.cds*/}
python $AMAS_dir/AMAS.py summary -f fasta -d dna -i $fas -o summary_alignment_$out_OG_id.log
done
# check missing percentage of alignment
grep 'OG' summary_alignment_OG*log | cut -f 1,6,2 | awk '$3 <= 50 {print $0}' | less -S

# list just folder names
ls -d */
new_transcript_id_8_and_pas_wasp/
# obtain alignment with less than 50% missing data
grep -h 'OG' summary_alignment_OG*log | cut -f 1,6,2 | awk '$3 <= 50 {print $0}' | cut -f 1 > cat.out_no_missing_over_50perct.cds.9_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas.list


************ partition - not working so well **************
each_fa_file_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat
cd $each_fa_file_dir

#cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
python $AMAS_dir/AMAS.py concat -f phylip -d dna -n 123 -e \
    -i OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas --part-format nexus #> ../reorder_test_summary/sum.82at7399.txt


python $AMAS_dir/AMAS.py concat -f fasta -d dna -n 123 -e \
    -i OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas \
    --part-format nexus --concat-part 14species_36OG.concat_partition.txt \
    --out-format nexus --concat-out 14species_36OG.concat_alignment.nexus

python $AMAS_dir/AMAS.py split -f nexus -d dna -i 14species_36OG.concat_alignment.nexus \
    -l 14species_36OG.concat_partition.txt -u phylip --remove-empty


example_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/AMAS_test.fas
python $AMAS_dir/AMAS.py concat -f fasta -d dna -n 12 -e -i $example_fa \
    --part-format nexus --concat-part example_data.partition --out-format phylip --concat-out example_data.phylip

python $AMAS_dir/AMAS.py split -f phylip -d dna -i example_data.phylip \
    -l example_data.partition -u phylip --remove-empty




********************* step VIII: divide_codon_by_position **********************
conda activate myproject
divide_codon_by_position=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/divide_codon_by_position.py
# Usage: python script.py <input_fasta> <codon1_output> <codon2_output> <codon3_output>

#cat_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat/cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
#python $divide_codon_by_position $cat_fa 14species_36OG.codon1.fas 14species_36OG.codon2.fas 14species_36OG.codon3.fas

## bom_apis_8
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
bom_apis_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis/cat.out.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
python $divide_codon_by_position $bom_apis_fa 8species_211OG.codon1.fas 8species_211OG.codon2.fas 8species_211OG.codon3.fas

## and_pas_7
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
and_pas_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas/cat.out.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
python $divide_codon_by_position $and_pas_fa 7species_537OG.codon1.fas 7species_537OG.codon2.fas 7species_537OG.codon3.fas



********************* step IX: align 1st, 2nd, and 3rd codons - run large data on server **********************
conda activate myproject
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
trimmed_stop_codon_concat=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat

## run large data on server
## 7_mafft_align_codon.sh

cd $trimmed_stop_codon_concat
fas_1st=14species_36OG.codon1.fas
fas_2nd=14species_36OG.codon2.fas
fas_3rd=14species_36OG.codon3.fas

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
cat 14species_36OG.codon*.aligned.phylip > 14species_36OG.cds_codons.txt


# bom_apis_wasp
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp

fas_1st=9species_75OG.codon1.fas
fas_2nd=9species_75OG.codon2.fas
fas_3rd=9species_75OG.codon3.fas

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
cat 9species_75OG.codon*.aligned.phylip > 9species_75OG.cds_codons.txt


# and_pas_wasp
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_and_pas_wasp

fas_1st=8species_255OG.codon1.fas
fas_2nd=8species_255OG.codon2.fas
fas_3rd=8species_255OG.codon3.fas

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
cat 8species_255OG.codon*.aligned.phylip > 8species_255OG.cds_codons.txt

