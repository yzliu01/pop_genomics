
# 14_species.prank.fasta

******** step IV: trim stop codon before using prank alignment ***********
extracted_cds_new=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new
cd $extracted_cds_new
for fa in $(ls OG*cds.14_species*.fa)
do
# trim stop codons at the end of the sequences
echo "trimming stop codon: $fa"
output_tem_fa=${fa/fa/trimmed_stop_codon.fa}
python $trim_cds_stop_codon_uppercase -i $fa -o ./aligned_seq_14_species_iterate2/trimmed_stop_codon_concat/$output_tem_fa
done

********* step V: run prank - codon - to align sequences ***********
# script is here
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_CDS_codon_prank_36OG.iterate2.sh

********* step VI: make sure fasta haders have the same name ***********
cd ./trimmed_stop_codon_concat
for fa in $(ls OG*cds.14_species*trimmed_stop_codon.prank_codon.iterate2*fas)
do
echo "making same headers: $output_tem_fa"
output_fa=${fa/fa.best.fas/same_header.fas}
sed -E 's/(^>[^.]*)\..*/\1/' $fa > $output_fa
# delete temporary file
#echo "deleting $fa"
#rm $fa
done


************ old steps: necessary following step: trim stop codon **********

conda activate bioproject
trim_cds_stop_codon=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_cds_stop_codon.py
trim_cds_stop_codon_uppercase=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/5_trim_cds_stop_codon_uppercase.py

#aligned_seq_14_species=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species
#cd $aligned_seq_14_species

aligned_seq_14_species_iterate2=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2
cd $aligned_seq_14_species_iterate2

python $trim_cds_stop_codon_uppercase --help

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

# display
OG0009220.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 1-735
OG0009227.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 736-2385
OG0009251.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.issue.same_header.fas = 2386-2769
OG0009253.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 2770-3867
OG0009266.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 3868-4884
OG0009268.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 4885-5508
OG0009280.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 5509-9138
OG0009282.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 9139-10464
OG0009287.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 10465-11256
OG0009289.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 11257-11853
OG0009291.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 11854-12594
OG0009295.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 12595-14214
OG0009306.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 14215-16896
OG0009313.cds.14_species_apis.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 16897-17796
OG0009314.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 17797-18792
OG0009317.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 18793-19944
OG0009341.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 19945-20319
OG0009365.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 20320-24087
OG0009380.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 24088-24417
OG0009385.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 24418-25512
OG0009407.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 25513-28197
OG0009412.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 28198-29781
OG0009421.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 29782-30507
OG0009448.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 30508-31338
OG0009451.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 31339-32385
OG0009458.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 32386-33219
OG0009461.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 33220-33735
OG0009462.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 33736-35112
OG0009463.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 35113-36177
OG0009479.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 36178-37659
OG0009487.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 37660-39237
OG0009522.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 39238-40704
OG0009523.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 40705-42252
OG0009530.cds.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas = 42253-44487
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

# partition
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


********************* divide_codon_by_position **********************
cat_fa=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat/cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
divide_codon_by_position=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/divide_codon_by_position.py
python $divide_codon_by_position $cat_fa 14species_36OG.codon1.fas 14species_36OG.codon2.fas 14species_36OG.codon3.fas


********************* align 1st, 2nd, and 3rd codons **********************
conda activate myproject
trimmed_stop_codon_concat=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/aligned_seq_14_species_iterate2/trimmed_stop_codon_concat
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
