

Apis_mel_busco_annotation_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/BUSCO_Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa/run_hymenoptera_odb10
cd $Apis_mel_busco_annotation_path

out_bed_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_complete_gene_cds_bed
grep -v "^#" full_table.tsv | awk '$2 == "Complete"' | cut -f 3-5 | less -S > ../../busco_complete_gene_cds_bed/Apis_mel_GCF_003254395.2-softmasked.bed

grep -v "^#" full_table.tsv | awk '$2 == "Complete"' | cut -f 3-6 | less -S > ../../busco_complete_gene_cds_bed/Apis_mel_GCF_003254395.2-softmasked.bed

grep -v "^#" full_table.tsv | awk '$2 == "Complete"' | less -S > ../../busco_complete_gene_cds_bed/Apis_mel_GCF_003254395.2-softmasked.bed

bedtools sort -chrThenSizeA -i /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_complete_gene_cds_bed/Apis_mel_GCF_003254395.2-softmasked+.bed | tail


*************************   step I: obtain annotation results *****************
# positive (sense - sequence of RNA transcripts) and negative strand (antisense - template strand) in the gff files
# most organisms make use of both strands
## https://en.wikipedia.org/wiki/Sense_(molecular_biology)
## Most organisms with sufficiently large genomes make use of both strands, with each strand functioning as the template strand for different RNA transcripts in different places along the same DNA molecule. In some cases, RNA transcripts can be transcribed in both directions (i.e. on either strand) from a common promoter region, or be transcribed from within introns on either strand
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/BUSCO_Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences

less 2at7399.gff | head

NC_037638.1     miniprot        mRNA    18292095        18360736        36785   +       .       ID=MP040744;Rank=1;Identity=0.9093;Positive=0.9564;Target=2at7399_6 1 7886
NC_037638.1     miniprot        CDS     18292095        18292430        543     +       0       Parent=MP040744;Rank=1;Identity=0.8403;Target=2at7399_6 1 118
NC_037638.1     miniprot        CDS     18294092        18294323        345     +       0       Parent=MP040744;Rank=1;Identity=0.8974;Target=2at7399_6 119 194

less 15at7399.gff | head

NC_037647.1     miniprot        mRNA    194843  223889  19969   -       .       ID=MP013729;Rank=1;Identity=0.8007;Positive=0.8747;Target=15at7399_8 1 4725
NC_037647.1     miniprot        CDS     223710  223889  242     -       0       Parent=MP013729;Rank=1;Identity=0.8689;Target=15at7399_8 1 61
NC_037647.1     miniprot        CDS     223503  223620  201     -       0       Parent=MP013729;Rank=1;Identity=0.9250;Target=15at7399_8 62 100

cd ../.. (/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/BUSCO_Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa/run_hymenoptera_odb10)
grep -v "^#" full_table.tsv | awk '$2 == "Complete"' | less -S

0at7399 Complete        NC_037639.1     15697707        15766362        +       15262.0 7367    https://v10-1.orthodb.org/?query=0at7399        Immunoglobulin
1at7399 Complete        NC_037641.1     12199321        12261213        +       8580.2  4041    https://v10-1.orthodb.org/?query=1at7399        GAR domain
2at7399 Complete        NC_037638.1     18292094        18360733        +       12706.3 6852    https://v10-1.orthodb.org/?query=2at7399        Spectrin repeat

grep -v "^#" full_table.tsv | cut -f 2 | sort -V | uniq -d

Complete
Duplicated
Fragmented
Missing
# Note: 'uniq' does not detect repeated lines unless they are adjacent.
# You may want to sort the input first, or use 'sort -u' without 'uniq'.
grep -v "^#" full_table.tsv | cut -f 2 | sort -u

Complete
Duplicated
Fragmented
Missing

## obtain results using for loop
busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test

#busco_species_dir=$busco_dir/BUSCO_Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa/run_hymenoptera_odb10/busco_sequences

busco_Apis_mel=$busco_dir/BUSCO_Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_bic=$busco_dir/BUSCO_Andrena_bicolor-GCA_960531205.1.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_ful=$busco_dir/BUSCO_Andrena_fulva-GCA_946251845.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_hae=$busco_dir/BUSCO_Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_hat=$busco_dir/BUSCO_Andrena_hattorfiana-GCA_944738655.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_mar=$busco_dir/BUSCO_Andrena_marginata_GCA_963932335.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_And_tri=$busco_dir/BUSCO_Andrena_trimmerana-GCA_951215215.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences 
busco_Bom_con=$busco_dir/BUSCO_Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_Bom_hor=$busco_dir/BUSCO_Bombus_hortorum-GCA_905332935.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_Bom_hyp=$busco_dir/BUSCO_Bombus_hypnorum-GCA_911387925.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_Bom_mus=$busco_dir/BUSCO_Bombus_muscorum-GCA_963971125.1.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_Bom_pas=$busco_dir/BUSCO_Bombus_pascuorum-GCA_905332965.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
busco_Bom_syl=$busco_dir/BUSCO_Bombus_sylvestris-GCA_911622165.2-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences
#busco_Ves_vul=$busco_dir/BUSCO_Vespula_vulgaris-GCA_905475345.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences

species_list=(
    "busco_And_bic"
    "busco_And_ful"
    "busco_And_hae"
    "busco_And_hat"
    "busco_And_mar"
    "busco_And_tri"
    "busco_Apis_mel"
    "busco_Bom_con"
    "busco_Bom_hor"
    "busco_Bom_hyp"
    "busco_Bom_mus"
    "busco_Bom_pas"
    "busco_Bom_syl"
    #"busco_Ves_vul" ## exclude outgroup species
)

********** step II: retrieve complete CDS of single_copy_busco_sequences *********
 # deleted
********* step III: get common busco id of amino sequences **********

cd $busco_dir
for busco_species in `echo ${species_list[@]}`
    do
    cd `echo ${!busco_species}`
    ## sort the busco id (-V natural sort of numbers)
    ls *.faa | sort -V > $busco_dir/busco_species_single_copy_complete_CDS/busco_id/"${busco_species}".single_copy_complete.busco.id

    cd ..
done

## go to the folder containing list for each species
cd  /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/busco_id
## count the total number of shared single copy genes 

## https://stackoverflow.com/questions/43472246/finding-common-value-across-multiple-files-containing-single-column-values
#awk '{a[$1]++} END{for(k in a) if(a[k]==ARGC-1) print k}' busco*.id | sort -V | wc -l
#4959
## output the list of commonly shared busco_id (chatGPT)
awk '{a[$1]++} END{for(k in a) if(a[k]==ARGC-1) print k}' busco*.id | sort -V > common_busco_id.txt


****** step IV: procure (fetch) the shared single_copy_busco_amino_acid_sequences shared by all these species into separate file ******
busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
busco_id_dir=$busco_dir/busco_species_single_copy_complete_CDS/busco_id
busco_id=`cat $busco_id_dir/common_busco_id.txt`
cd $busco_id_dir
for id in $busco_id
    do
    #busco_id_dir=$busco_dir/busco_species_single_copy_complete_CDS/busco_id
    #busco_id=`cat $busco_id_dir/common_busco_id.txt`
    for busco_species in `echo ${species_list[@]}`
        do
        cd `echo ${!busco_species}`
        ## Variable Expansion: The species_list contains the names of variables as strings. To get the value of each variable in the loop, I used the syntax ${!busco_species} which performs indirect expansion, resolving the value of the variable whose name is stored in busco_species.
        pwd
        new_busco_id=${id/.faa/}
        cat $id >> $busco_id_dir/"$new_busco_id".shared_aa.faa
        echo "$new_busco_id".shared_aa.faa
    done
done

********* step V: filter out FASTA sequences that not start with the amino acid M (Methionine) after the header line **********
## https://stackoverflow.com/questions/26479562/what-does-ifs-do-in-this-bash-loop-cat-file-while-ifs-read-r-line-do

******************** step V_a: obtain amino acide sequences for each busco_id if starting with M ********************
## codes from chatGPT
#!/bin/bash
# Loop through all .faa files
cd $busco_id_dir
for file in `ls *aa.faa | sort -V`; do
    exclude=false
    seq=""

    # Read through the file line by line
    while IFS= read -r line || [ -n "$line" ]; do
        if [[ "$line" == ">"* ]]; then
            # If line is a header, process the previous sequence
            if [ -n "$seq" ]; then
                if [[ "${seq:0:1}" != "M" ]]; then
                    exclude=true
                    break
                fi
            fi
            # Reset sequence for the next entry
            seq=""
        else
            # Accumulate sequence lines (remove whitespaces)
            seq+=$(echo -n "$line" | tr -d '[:space:]')
        fi
    done < "$file"

    # Handle the last sequence in the file
    if [ -n "$seq" ] && [[ "${seq:0:1}" != "M" ]]; then
        exclude=true
    fi

    # If any sequence did not start with M, rename the file and delete them
    if $exclude; then
        echo "Excluding $file as it contains sequences not starting with M."
        # Uncomment the following line to delete the file
        # rm "$file"
        # Alternatively, rename the file with .retained.faa extension, and delete those without starting "M"
        cp "$file" "$file.without_start_M.faa"
        rm "$file"
    else
        echo "$file passed the filter."
    fi
done


************************ change header names in animo acid fasta files, xxx.faa starting with M *********************
species=busco_Bom_pas
for species in ${species_list[@]}
do
    #sed 's/|.*//g' 32232at7399.shared_aa.faa
    sed "s/7399|.*/7399.$species/g" 32232at7399.shared_aa.faa
done

******** chatgpt *******
ls *shared_aa.faa | wc -l
2546

for each_aa_file in $(ls *shared_aa.faa | head -2)

cd $busco_id_dir
rm *.shared_aa.new_header.faa

for each_aa_file in $(ls *shared_aa.faa)
do
# Initialize the species index
species_index=0

# Process the input FASTA file
while IFS= read -r line; do
    if [[ $line == \>*at7399* ]]; then
        # Replace everything after "at7399" with the current species
        new_header=$(echo $line | sed "s/7399.*/7399.gff.${species_list[$species_index]}.combined/") # make them have the same header names as that for combined nuc sequences
        #new_header="${line%%at7399*}at7399.gff.${species_list[$species_index]}" 
        #echo $new_header >> 32232at7399.shared_aa.new_header.faa
        new_file_name=${each_aa_file/faa/new_header.faa}
        echo $new_header >> $new_file_name
        ((species_index++))
    else
        # Print the sequence lines as is
        #echo "$line" >> 32232at7399.shared_aa.new_header.faa
        echo "$line" >> $new_file_name
    fi
#done < 32232at7399.shared_aa.faa
done < $each_aa_file
done

## delete test results files
rm *.shared_aa.new_header.faa

less 1012at7399.shared_aa.new_header.faa
>1012at7399.gff.busco_Apis_mel
MSSSFIIEPQESGLEKKDDTLIIIVNDDGT

************ step V_b: get the shared single_copy_busco_sequences by all these species into separate file **********
busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
busco_id_dir=$busco_dir/busco_species_single_copy_complete_CDS/busco_id

cd $busco_id_dir
# ls *aa.faa | wc -l
# 10001at7399.shared_aa.faa
# 1887
ls *aa.faa | sort -V > busco_id.retained.list
sed 's/shared_aa.faa/gff/g' busco_id.retained.list > busco_id.retained.gff.list
rm busco_id.retained.list busco_id.retained.gff.new.list

busco_id=`cat $busco_id_dir/busco_id.retained.gff.list`
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

for id in $busco_id
    do
    echo $id
    ## e.g., 10765at7399.gff
    for busco_species in `echo ${species_list[@]}`
        do
        cd `echo ${!busco_species}`
        ## Variable Expansion: The species_list contains the names of variables as strings. To get the value of each variable in the loop, I used the syntax ${!busco_species} which performs indirect expansion, resolving the value of the variable whose name is stored in busco_species.
        pwd
        #find -type f -name "$id" -exec grep -h 'CDS' {} \+ | cut -f 1,4- | sort -k1,1V -k2,2n > "$busco_dir"/busco_species_single_copy_complete_CDS/shared_CDS_with_M/"$id.$busco_species".single_CDS_with_M.bed
        ## standard bed file: https://en.wikipedia.org/wiki/BED_(file_format); cut does not reorder the column, need to use awk
        #find -type f -name "$id" -exec grep -h 'CDS' {} \+ | cut -f 1,4,5,3,6- | sort -k1,1V -k2,2n > "$busco_dir"/busco_species_single_copy_complete_CDS/shared_CDS_with_M/"$id.$busco_species".single_CDS_with_M.bed
        find -type f -name "$id" -exec grep -h 'CDS' {} \+ | awk 'BEGIN{OFS="\t"}{print $1,$4,$5,$3,$6,$7,$8,$9}' | sort -k1,1V -k2,2n > "$busco_dir"/busco_species_single_copy_complete_CDS/shared_CDS_with_M/"$id.$busco_species".single_CDS_with_M.bed
        ## 10191at7399.gff.busco_Bom_hyp.single_CDS_with_M.bed

    done
    cd $busco_dir
    pwd
done

find . -type f -name "*.single_CDS_with_M.bed" -print | head

**************** test *************
## use Busco id of all single_copy_busco_sequences and multi_copy_busco_sequences in 
# # Busco id	Status	Sequence	Gene Start	Gene End	Strand

cd $busco_species_dir

## merge files from the two folders
## print all file in a folder with absolute dir: https://askubuntu.com/questions/444551/get-absolute-path-of-files-using-find-command
find "$(pwd -P)" -type f -name '*.gff' -print

cd multi_copy_busco_sequences
cd single_copy_busco_sequences

*********** test data o-based and 1-based ***********
# bedtools sort -chrThenSizeA -i Apis_mel_GCF_003254395.2-softmasked+.bed | tail

## convert bed file (1-based) bed from gff files (start and end position) to bedtools bed files (0-based)
## The bedtools merge tool expects the BED file to be sorted in ascending order by the first three columns (chromosome, start, end). If the file is not sorted, it can lead to errors like the one you've seen.
cut -f 1-3 single_copy_complete_CDS_merge_test.bed | sort -k1,1 -k2,2n -k3,3n | bedtools merge -i stdin  | awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3-1}' | bedtools getfasta -fi $busco_apis_mel -bed stdin -fo Api_mel.out_single_copy_CDS_merge_test.fa
## test data
NC_037638.1	9478	9546	114	-	0	Parent=MP040176;Rank=1;Identity=1.0000;Target=29579at7399_6 82 103
NC_037638.1	9779	9827	84	-	1	Parent=MP040176;Rank=1;Identity=1.0000;Target=29579at7399_6 65 81
NC_037638.1	9800	10994	138	-	2	Parent=MP040176;Rank=1;Identity=1.0000;Target=29579at7399_6 38 64
NC_037638.1	11054	11121	127	-	1	Parent=MP040176;Rank=1;Identity=1.0000;Target=29579at7399_6 15 37
NC_037638.1	11201	11244	71	-	0	Parent=MP040176;Rank=1;Identity=1.0000;Target=29579at7399_6 1 14
NC_037638.1	12655	13012	470	+	0	Parent=MP027710;Rank=1;Identity=0.7521;Target=2259at7399_3 1 120
NC_037647.1	4483069	4483198	224	-	2	Parent=MP004597;Rank=1;Identity=1.0000;Target=11988at7399_7 209 251
NC_037647.1	4483000	4483636	327	-	1	Parent=MP004597;Rank=1;Identity=1.0000;Target=11988at7399_7 147 208
NC_037647.1	4483916	4484038	224	-	1	Parent=MP004597;Rank=1;Identity=1.0000;Target=11988at7399_7 106 146
# test result
NC_037638.1     9477    9545
NC_037638.1     9778    10993
NC_037638.1     11053   11120
NC_037638.1     11200   11243
NC_037638.1     12654   13011
NC_037647.1     4482999 4483635
NC_037647.1     4483915 4484037


***** step VI: variable loop to get shared busco_id and differentiate positive (+) and negative (-) strand *****
## dir for single_copy_busco_sequences
busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

conda activate variant_calling_mapping

busco_id_dir=$busco_dir/busco_species_single_copy_complete_CDS/busco_id
#busco_id=`head -2 $busco_id_dir/busco_id.retained.gff.new.list`
busco_id_list=$busco_id_dir/busco_id.retained.gff.list

#cd ./test_+-
#busco_id="6606at7399.gff" 
## example data of a negative record
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M/6606at7399.gff.busco_And_bic.single_CDS_with_M.bed
# ENA|OY482664|OY482664.1	36492416	36492744	CDS	466	-	2	Parent=MP051924;Rank=1;Identity=0.7909;Target=6606at7399_2
# ENA|OY482664|OY482664.1	36492986	36493175	CDS	273	-	0	Parent=MP051924;Rank=1;Identity=0.8438;Target=6606at7399_2
# ENA|OY482664|OY482664.1	36493265	36493349	CDS	116	-	1	Parent=MP051924;Rank=1;Identity=0.7500;Target=6606at7399_2

*********** reference data directory ************
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

busco_Apis_mel=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
busco_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa
busco_And_ful=$ref_dir/Andrena_fulva-GCA_946251845.1-softmasked.fa
busco_And_hae=$ref_dir/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
busco_And_hat=$ref_dir/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
busco_And_mar=$ref_dir/Andrena_marginata_GCA_963932335.1-softmasked.fa
busco_And_tri=$ref_dir/Andrena_trimmerana-GCA_951215215.1-softmasked.fa
busco_Bom_con=$ref_dir/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
busco_Bom_hor=$ref_dir/Bombus_hortorum-GCA_905332935.1-softmasked.fa
busco_Bom_hyp=$ref_dir/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
busco_Bom_mus=$ref_dir/Bombus_muscorum-GCA_963971125.1.fa
busco_Bom_pas=$ref_dir/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
busco_Bom_syl=$ref_dir/Bombus_sylvestris-GCA_911622165.2-softmasked.fa
#busco_Ves_vul=$ref_dir/Vespula_vulgaris-GCA_905475345.1-softmasked.fa

ref_list=(
    "busco_And_bic"
    "busco_And_ful"
    "busco_And_hae"
    "busco_And_hat"
    "busco_And_mar"
    "busco_And_tri"
    "busco_Apis_mel"
    "busco_Bom_con"
    "busco_Bom_hor"
    "busco_Bom_hyp"
    "busco_Bom_mus"
    "busco_Bom_pas"
    "busco_Bom_syl"
    #"busco_Ves_vul"
)

cd $shared_CDS_with_M_dir
conda activate variant_calling_mapping

for id in `cat $busco_id_list`
#for id in `echo $busco_id`
    do

    echo $id
#done
    for busco_species_ref in ${ref_list[@]}
        do
        #pwd
        echo $busco_species_ref
        echo ${!busco_species_ref}
        ## folder_dir: $ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
        ref=`echo ${!busco_species_ref}`

        strand=`cut -f 6 $shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed | uniq`
        echo "$shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed"
        if [[ $strand == "+" ]]
        then
            echo "negative strand +"
            awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3,$4,$5,$6,$7,$8,$9}' $shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed \
            | bedtools getfasta -fi $ref -bed stdin -s > "$id.$busco_species_ref".single_CDS_with_M+.fa
        else
            echo "positive strand -"
            ## https://github.com/davetang/defining_genomic_regions
            ## https://www.biostars.org/p/84686/
            ## Tutorial:Cheat Sheet For One-Based Vs Zero-Based Coordinate Systems
            ## only column START:$n-1
            awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3,$4,$5,$6,$7,$8,$9}' $shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed \
            | bedtools getfasta -fi $ref -bed stdin -s > "$id.$busco_species_ref".single_CDS_with_M-.fa

            ## reverse the order of records in fasta files
            # https://www.biostars.org/p/9462522/
            paste - - < "$id.$busco_species_ref".single_CDS_with_M-.fa | tac | tr "\t" "\n" > "$id.$busco_species_ref".single_CDS_with_M-RC.fa

        fi
    done

done # test code

******* following not working properly *******
        ## get list of all columns of gff files
        #find -type f -name '*.gff' -exec grep -h 'CDS' {} \+ | sort -k1 >> ../single_multiple_complete_CDS.txt ## save results in folder: busco_sequences
        
        ## make bed file (0-based) with seq names and cds start and end position from gff files (1-based)

        ## According to the results of retrieved sequences, it is necessary to use only column START:$n-1, otherwhise it causes issues with start codons 

        #find -type f -name '*.gff' -exec grep -h 'CDS' {} \+ | cut -f 1,4- | sort -k1 >> ../single_copy_complete_CDS.bed ## save results in folder: busco_sequences
        ## sort the first columns (-V natural sort of numbers) and second solumn (numeric sort)
        awk '{if ($6 == "+") print $0}' $shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed | awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3,$4,$5,$6,$7,$8,$9}' | bedtools getfasta -fi $ref -bed stdin -s > "$id.$busco_species_ref".single_CDS_with_M+.fa
        
        awk '{if ($6 == "-") print $0}' $shared_CDS_with_M_dir/"$id.$busco_species_ref".single_CDS_with_M.bed | awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3,$4,$5,$6,$7,$8,$9}' | bedtools getfasta -fi $ref -bed stdin -s > "$id.$busco_species_ref".single_CDS_with_M-.fa
        
        ## reverse the order of records in fasta files
        #paste - - < "$id.$busco_species_ref".single_CDS_with_M-.fa | tac | tr "\t" "\n" > "$id.$busco_species_ref".single_CDS_with_M-RC.fa
        
        ##cut -f 1-4 "$id$busco_species_ref".single_CDS_withM.bed | sort -k1,1 -k2,2n -k3,3n | bedtools merge -i stdin  | awk 'BEGIN{OFS="\t"}{print $1,$2-1,$3-1}' | bedtools getfasta -fi $ref -bed stdin -fo "$id$busco_species_ref".single_CDS_withM.fa
    done
done


********** test codes for above step VI: reverse complementary sequences from negative strand ************
# - 
And_bio_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M/31at7399.gff.busco_And_bio.single_CDS_with_M.bed
bedtools getfasta -fi $ref_dir/Andrena_bicolor-GCA_960531205.1.fa -s -bed $And_bio_bed | head | less -S
# + (without M)
And_bio_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/BUSCO_Andrena_bicolor-GCA_960531205.1.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences/32167at7399.gff
bedtools getfasta -fi $ref_dir/Andrena_bicolor-GCA_960531205.1.fa -s -bed $And_bio_bed | head | less -S


# +
And_tri_bed=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/BUSCO_Andrena_trimmerana-GCA_951215215.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences/31at7399.gff
bedtools getfasta -fi $ref_dir/Andrena_trimmerana-GCA_951215215.1-softmasked.fa -s -bed $And_tri_bed | head

## reverse the order of **records with (-)** in a fasta file
shared_CDS_with_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M

grep "+" -l *with_M.bed | head -5

busco_assess_neg=`grep "-" -l *with_M.bed | head -2`
for busco_id in $busco_assess_neg
    do
    echo $busco_id
    bedtools getfasta -fi $ref_dir/Andrena_bicolor-GCA_960531205.1.fa -s -bed $And_bio_bed
    paste - - < `echo $busco_id` | tac | tr "\t" "\n";
done

paste - - < test.fa | tac | tr "\t" "\n"
## working
paste - - < 31at7399.aa2nuc.And_bio.fa | tac | tr "\t" "\n"

************* step VII: combine multi-sequence into a single one ***************
webtool: https://www.bioinformatics.org/sms2/combine_fasta.html for a small number of files

************* loop ************
busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

grep -v '>' 31769at7399.gff.busco_Bom_con.single_CDS_with_M-RC.fa | tr -d "\n"
## list a large number of files with "M+" or "M-RC" and just print file names without directory
find . -name '*gff.busco*M+*' -o -name '*gff.busco*M-RC*' -printf "%f\n"
## find and delete empty files
find . -type f -empty -delete

************* loop - final ************
## find files with name "*gff.busco*M+*" or "*gff.busco*M-RC*", and print only file name without directory
## \( -name '*gff.busco*M+*' -o -name '*gff.busco*M-RC*' \): Groups the -name conditions with -o for logical OR. The escaped parentheses \( and \) ensure that the conditions are evaluated together.
## they are with space.
for fa in `find . \( -name '*gff.busco*M+*' -o -name '*gff.busco*M-RC*' \) -printf "%f\n" | sort -V`

## check with the first a few items
#for fa in $(find . \( -name '*gff.busco*M+*' -o -name '*gff.busco*M-RC*' \) -printf "%f\n" | sort -V | head -30)
#for fa in "10027at7399.gff.busco_And_bic.single_CDS_with_M+.fa.copy" ## moved to "test_+-" folder
    do
    echo $fa
## check file names
#done

    # fa item: 31769at7399.gff.busco_Bom_con.single_CDS_with_M-RC.fa
    if [[ "$fa" == *single_CDS_with_M+*.fa ]]; then
    temp_file_name="${fa/single_CDS_with_M+.fa/combined.fa}"
    elif [[ "$fa" == *single_CDS_with_M-RC*.fa ]]; then
    temp_file_name="${fa/single_CDS_with_M-RC.fa/combined.fa}"
    fi
    echo $temp_file_name

    new_file_name_header=${temp_file_name/fa/header.13species.fa}
    echo $new_file_name_header
    head_line=${new_file_name_header/.header.13species.fa/}
    
    grep -v '>' $fa | tr -d "\n" > $temp_file_name # 31769at7399.gff.busco_Bom_con.combine.fa
    ## in-place edit a header to the first line
    sed "1 i\\>$head_line" $temp_file_name > $new_file_name_header
    ## delete temporary file    
    rm $temp_file_name

done

************ extract unique busco_id  and merge sequences from each species *********
## step 1: extract unique busco_id from the file names

#e.g., 1at7399.gff.busco_And_ful.combined.header.fa

uniq_prefix=$(
for file in *.gff.busco_*.combined.header.13species.fa
    do
    prefix=$(echo "$file" | sed 's/\.busco.*//')
    echo "$prefix"
    # e.g., 1at7399.gff

    ## sort out output in one step
done | sort -V | uniq
    )

busco_species=$(
for file in $(ls *.gff.busco_*.combined.header.13species.fa | head -40)
    do
    species=$(echo "$file" | sed -E 's/.*gff\.busco_([^.]+)\.combined\.header\.13species\.fa/\1/')
    echo "$species"
    # e.g., And_ful, Bom_hor

    ## sort out output in one step
done | sort -V | uniq
    )

## takes 2m9s
echo "sort and uniq are done!"

## step 2: list all files matching each unique prefix and then concatenate their sequences
for prefix in $uniq_prefix
    ## e.g. 32123at7399.gff
    do
    echo -e "\nfiles matching pattern: $prefix"

    ## list files of unique busco_id and concatenate all with a newline space between each
    # ${prefix}* | xargs cat
    for file in ${prefix}*combined.header.13species.fa
    ## e.g.
    #for file in `ls 1at7399.gff*header*`
        do
        echo $file
        ## check for each species
        #e.g., 1at7399.gff.busco_And_ful.combined.header.fa
        #for species in $busco_species
        #    do
            #cat $file >> 1at7399.gff.combined_share.fa
            #echo -e "\n" >> 1at7399.gff.combined_share.fa
            #cat $file.busco_$species.combined.header.fa >> $prefix.combined_share.fa
            cat $file >> $prefix.combined_share.13species.fa
            echo -e "\n" >> $prefix.combined_share.13species.fa
            echo $prefix.combined_share.13species.fa
        #done
    done
done

less 32320at7399.gff.combined_share.13species.fa
>32320at7399.gff.busco_And_bic.combined
ATGCGTATTACGAGTATACTATTTTATAAGGTGCATAA

************* step VIII: align multiple sequences ***************
## https://mafft.cbrc.jp/alignment/software/; https://github.com/rcedgar/muscle
## reasons to choose different program: https://help.geneious.com/hc/en-us/articles/360044627712-Which-multiple-alignment-algorithm-should-I-use
conda activate myproject
#conda install bioconda::mafft

busco_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

********* use --auto to get precise alignment and mafft keep order of faster headers *********
## https://mafft.cbrc.jp/alignment/software/manual/manual.html
mafft --auto --thread 4 3803at7399.gff.combined_share.fa >> ./test_+-/3803at7399.gff.combined_share.auto.mafft
mafft --localpair --maxiterate 1000 --thread 4 3803at7399.gff.combined_share.fa >> ./test_+-/3803at7399.gff.combined_share.L_INS.mafft
mafft --auto --thread 4 32320at7399.gff.combined_share.fa > 32320at7399.gff.combined_share.mafft
cp 32320at7399.gff.combined_share.mafft 32320at7399.gff.combined_share.mafft.copy

seq="1at7399.gff.combined_share.fa"
mafft --auto --thread 20 $seq > ../shared_CDS_with_M_seq_align/1at7399.gff.combined_share.mafft_auto.fasta
## Strategy:
## FFT-NS-2 (Fast but rough)
## Progressive method (guide trees were built 2 times.)

## accurate strategy: L-INS-i
mafft --localpair --maxiterate 1000 --thread 20 $seq > ../shared_CDS_with_M_seq_align/1at7399.gff.combined_share.mafft_L-INS-i.fasta


revtrans=/home/yzliu/miniforge3/envs/RevTrans/bin/revtrans.py
conda activate RevTrans
$revtrans 10027at7399.gff.busco_Bom_pas.combined.header.fa 10027at7399.faa -match trans
$revtrans 10027at7399.gff.combined_share.fa 10027at7399.shared_aa.faa.mafft.fa -match trans
## issue
No cross-reference, skipping peptide sequence 10027at7399_2|17:588553-590785|- <unknown description>

conda activate myproject
seq=10027at7399.shared_aa.rename_header.faa 
mafft --localpair --maxiterate 1000 --thread 20 $seq > ./$seq.mafft.fa # 10027at7399.shared_aa.rename_header.faa.mafft.fa

conda activate RevTrans
## attention to number of seq and match option
$revtrans 10027at7399.gff.combined_share.fa 10027at7399.shared_aa.rename_header.faa.mafft.fa \
    -match name > 10027at7399.gff.combined_share.revtrans.fa

***** for loop ****
revtrans=/home/yzliu/miniforge3/envs/RevTrans/bin/revtrans.py
conda activate RevTrans # contains mafft
## 1. align amino acid sequences 
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
busco_id=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/busco_id
revtrans_align_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/revtrans_align
cd $busco_id
## assign an array instead of string
id=($(ls *new_header.faa | sort -V | head -2 | sed 's/\.shared.*//')) ## the first two have issue so they were run separately
echo ${id[1]}
## check the length of an array
echo ${#id[@]}
length=${#id[@]}
for ((index=0; index < length; index++))
do
cd $busco_id
echo -e "\n"$index
aa_seq_file=${id[index]}.shared_aa.new_header.faa   # 0at7399.shared_aa.new_header.faa
nuc_seq_file=${id[index]}.gff.combined_share.13species.fa  # (ls -t *share*fa | head) 32320at7399.gff.combined_share.13species.fa
echo -e "aa: "$aa_seq_file"\nnuc: "$nuc_seq_file

## aligh aa sequence
aligned_file_name=${aa_seq_file/faa/mafft.fasta}  # 0at7399.shared_aa.new_header.mafft.fasta
mafft --localpair --maxiterate 1000 --thread 20 $busco_id/$aa_seq_file > $revtrans_align_dir/$aligned_file_name
echo  "mafft_aligned: "$aligned_file_name

## run revtrans: control of the alignment process by supplying a pre-computed peptide alignment.
## RevTrans will then use this as the scaffold for the DNA alignment.
cd $revtrans_align_dir
revtrans_out_nuc_name=${nuc_seq_file/fa/revtrans.fasta}
$revtrans $shared_CDS_with_M_dir/$nuc_seq_file $aligned_file_name -match name > $revtrans_out_nuc_name
echo $revtrans_out_nuc_name

done





********* muscle change order of fasta headers **********
muscle -align 32320at7399.gff.combined_share.fa -output ./test_+-/32320at7399.gff.combined_share_align.new.afa
muscle -align 32232at7399.gff.combined_share.fa -output ./test_+-/32232at7399.gff.combined_share_align.new.afa

muscle -align 3803at7399.gff.combined_share.fa -output ./test_+-/3803at7399.gff.combined_share_align.muscle.fasta


## prank: align cds sequence while considering codon structure
conda activate myproject
conda install prank
test_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/test
cd $test_folder

prank -h
prank -d=10027at7399.gff.combined_share.fa -o=../shared_CDS_with_M_seq_align/10027at7399.gff.combined_share.prank.fa -codon -F
## https://ariloytynoja.github.io/prank-msa/#methods
## PRANK can do translated alignments of protein-coding DNA sequences or align them using the codon model. 
## Translation is selected with the options -translate (standard code) or -mttranslate (mitochondrial code), 
## and the codon alignment with the option -codon. 

dna_And_bic=10027at7399.gff.busco_And_bic.combined.header.13species.fa
codon_output_file=${dna_And_bic/fa/prank_codon.fa}
prank -d=./And_bic_10027at7399_busco/$dna_And_bic \
    -o=./And_bic_10027at7399_busco/$codon_output_file -codon -F

## conda install bioconda::gffread
#gff_species=$test_folder/apis_mel_10027at7399_busco/10027at7399.gff
gff_species=$test_folder/And_bic_10027at7399_busco/10027at7399.gff
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#ref_apis_mel=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa

#gffread_output=${gff_species/gff/gff.gffread.fa}
#gffread -w $gffread_output -g $ref_apis_mel $gff_species

gffread_output=${gff_species/gff/gff.gffread_cds.fa}
gffread -x $gffread_output -g $ref_And_bic $gff_species

**** different length
prank -d=10027at7399.gff.combined_share.fa -o=../shared_CDS_with_M_seq_align/10027at7399.gff.combined_share.prank_translated.fa -translate -F
## log data
Input for the analysis
 - aligning sequences in '10027at7399.gff.combined_share.fa'
 - using inferred alignment guide tree
 - external tools available:
    MAFFT for initial alignment

Warning: Unknown codons replaced with 'NNN'.
Correcting (arbitrarily) for multifurcating nodes.
Correcting (arbitrarily) for multifurcating nodes.

Generating multiple alignment: iteration 1.
#13#(13/13): 73% computed                    
Alignment score: 2823
Correcting (arbitrarily) for multifurcating nodes.

Generating multiple alignment: iteration 2.
#13#(13/13): 91% aligned                    
Alignment score: 2369
Segmentation fault (core dumped)

## new file
conda activate myproject
## still 14
prank -d=10027at7399.gff.combined_share.13species.fa -o=../shared_CDS_with_M_seq_align/10027at7399.gff.combined_share.real_13species.prank_translated.fa -translate -F
cd ../shared_CDS_with_M_seq_align
prank -d=10027at7399.gff.combined_share.real_13species.fa -o=10027at7399.gff.combined_share.real_13species.prank_translated.fa -translate -F


prank -d=10027at7399.gff.combined_share.fa     -o=../shared_CDS_with_M_seq_align/10027at7399.gff.combined_share.prank_codon.fa     -co
don -F
## codon sequence length is not multiple of three!

for species in ${species_list[@]}
    do
    echo $species
    prank -d="10027at7399.gff.$species.combined.header.fa" -o=../shared_CDS_with_M_seq_align/"10027at7399.gff.$species.combined.header.prank.fa" -codon -F
done

**** short length
prank -d=32232at7399.gff.combined_share.fa -o=../shared_CDS_with_M_seq_align/32232at7399.gff.combined_share.prank_translated.fa -trans
late -F
## log
Alignment score: 219
Correcting (arbitrarily) for multifurcating nodes.

Generating multiple alignment: iteration 5.

Alignment score: 219


Writing
 - alignment to '../shared_CDS_with_M_seq_align/32232at7399.gff.combined_share.prank_codon.fa.best.fas'

Analysis done. Total time 11s





********* all files **************
ls *gff.combined_share.fa | wc -l
2159

for seq in $(ls *gff.combined_share.fa | sort -V | head)
    ## seq file name: 31737at7399.gff.combined_share.fa
    ## seq header: >32320at7399.gff.busco_Ves_vul.
    
    do
    align_name=${seq/fa/muscle.fasta}
    muscle -align $seq -output ../shared_CDS_with_M_seq_align/$align_name

    ## modify headers of fasta sequences
    ## >32320at7399.gff.busco_Bom_syl.combined -> >busco_Bom_syl
    sed -i 's/>.*gff\.\(.*\)\.combined/>\1/' ../shared_CDS_with_M_seq_align/$align_name

    # Input: 14 seqs, avg length 19272, max 25276
    # 00:00 19Mb   CPU has 64 cores, defaulting to 20 threads
    # Segmentation fault (core dumped)iors

    # Input: 14 seqs, avg length 14915, max 15534
    # 00:00 19Mb   CPU has 64 cores, defaulting to 20 threads
    # 00:51 172Gb    42.9% Calc posteriors
    # 02:44 90.1Gb  100.0% Calc posteriors
    # 03:20 5.1Gb   100.0% Consistency (1/2)
    # 03:24 4.2Gb   100.0% Consistency (2/2)
    # 03:24 1.5Gb   100.0% UPGMA5           
    # 04:37 1.5Gb   100.0% Refining

done

******* reorders of headers of fasta sequences after muscle aligning ********
## >32320at7399.gff.busco_Bom_syl.combined -> >busco_Bom_syl
less ./test_+-/32320at7399.gff.combined_share_align.new.afa | sed 's/>.*gff\.\(.*\)\.combined/>\1/'

## taxa_name_order
shared_CDS_with_M_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M
cd $shared_CDS_with_M_dir

seq="1078at7399.gff.combined_share.fa"
#grep '>' $seq | sed 's/>.*gff\.\(.*\)\.combined/>\1/' > ../taxa_name_order.list
cd ../shared_CDS_with_M_seq_align
align_name=${seq/fa/muscle.fasta}
reorder_taxa_name=${align_name/fasta/reordered.fasta}

awk '/^>/ {if (seq) print seq; print; seq=""; next} {seq=seq$0} END {if (seq) print seq}' input.fasta | \
    awk '{if (substr($0,1,1)==">") header=$0; else print header"\t"$0}' | \
    sort -k1,1 | tr "\t" "\n" > reordered.fasta

awk 'NR==FNR {order[$1]; next} /^>/ {h=$0; if (h in order) p=1; else p=0} p {print h; getline; print}' \
    ../taxa_name_order.list ../shared_CDS_with_M_seq_align/$align_name > $reorder_taxa_name


******* concatenate aligned fasta files for each gene ********
******* require the same header names for each taxon to be concatenated ********
## modify header names
# >32320at7399.gff.busco_And_bic.combined
# atgcgtattacgagtatactattttataaggtgcataaca
******** realign the sequences *********

revtrans_align_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/revtrans_align
cd $revtrans_align_dir

for aligned_nuc_file in $(ls *.gff.combined_share.13species.revtrans.fasta | sort -V | head -2)
do

realigned_nuc_file_name=${aligned_nuc_file/revtrans.fasta/revtrans_realign.fasta}
mafft --localpair --maxiterate 1000 --thread 20 $aligned_nuc_file > $realigned_nuc_file_name
echo  "mafft_realigned: "$realigned_nuc_file_name
realigned_nuc_file_new_name=${realigned_nuc_file_name/revtrans_realign.fasta/revtrans_realign.header_md.fasta}
#sed 's/>\(.*\)busco_/>/' $realigned_nuc_file_name > $realigned_nuc_file_new_name
## keep only patterns between gff and .combined
sed -E 's/(.*busco_)([^.]*)(\.combined.*)/>\2/' $realigned_nuc_file_name > $realigned_nuc_file_new_name
echo  "header_md: "$realigned_nuc_file_new_name
done



*.13species.revtrans.header_md.fasta

## https://github.com/nylander/catfasta2phyml
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
#chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
$catfasta2phyml -h
cd test_+-/
$catfasta2phyml -f *align.afa > out.32232at7399_32232at7399.afa ## -f --fasta Print outout in FASTA format

$catfasta2phyml -f 32320at7399.gff.combined_share.mafft \
    32320at7399.gff.combined_share.mafft.copy > out.32320at7399_twice.afa

revtrans_align_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/revtrans_align
## -p --phylip Print outout in PHYLIP format: strict with header names <= 10 characters
$catfasta2phyml -p *.13species.revtrans_realign.header_md.fasta > conca_13psecies_2busco_id.revtrans_realign.header_md.phy 2> conca_13psecies_2busco_id.revtrans_realign.header_md.partitions
## -f --fasta Print outout in FASTA format
$catfasta2phyml -f *.13species.revtrans_realign.header_md.fasta > conca_13psecies_2busco_id.revtrans_realign.header_md.fasta 2> conca_13psecies_2busco_id.revtrans_realign.header_md.partitions


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
aligned_seq_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align
cd $aligned_seq_dir
python $AMAS_dir/AMAS.py summary -h
python $AMAS_dir/AMAS.py summary -f fasta -d dna -i 82at7399.gff.combined_share.muscle.fasta > ../reorder_test_summary/sum.82at7399.txt

cut -f 6 /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/reorder_test/summary.txt
Missing_percent
0.154



******* potential sulution *******
# Input and output file names
input_file="31at7399.aa2nuc.And_bio.fa"
output_file="reversed_output.fa"

# Extract records, treating '>' as a record delimiter
# Reverse records with '(-)' in the header
awk -v RS='>' '/\(-\)/ {print ">"$0}' "$input_file" | tac > temp_reversed.fasta

# Extract records without '(-)'
awk -v RS='>' '!/\(-\)/ {print ">"$0}' "$input_file" > temp_non_reversed.fasta

# Combine both parts into the final output
cat temp_reversed.fasta temp_non_reversed.fasta > "$output_file"

# Clean up temporary files
rm temp_reversed.fasta temp_non_reversed.fasta



*****

Rearranging to Solve for Substitution Rate:

To isolate the substitution rate r, you rearrange the formula:
r=D/2T

## Introduction to Evolutionary Genomics by Saitou Naruya, 2018
According to the neutral theory, the evolutionary rate (λ,lamada) is equal to the mutation rate (μ) in the genome region under pure neutral evolution
where D is the evolutionary distance between genomes A and B, and T is the divergence time between the two genomes. 
Because the two o lineages going to genomes A and B experience the same evolutionary time T from their common ancestral genome, 
the total divergence time between the two genomes is 2T.

This procedure is called the indirect method. For example, the substitutional difference (D) between human and chimpanzee is 1.23% [55]. 
If we assume that the divergence time (T) of these two species is 6 million years, λ = D/2T =1 10−9/ site/year. 
Because the application of the direct method usually takes large amount of resources, 
this indirect method has been widely used from the advent of the molecular evolutionary studies. 
For example, Wu and Li [56] showed that rodents seem to have higher mutation rate than primates. 
It should be noted that T in Eq. 3.1 is the divergence time (Tg) of two genomes, 
and this is longer than the species (or population) divergence time Ts as shown in Fig. 3.19 (see Chap. 4 for details). 
Therefore, if Tg is much larger than Ts, the estimated mutation rate using Tg may be a gloss overestimation, 
for Ts, that can be inferred from fossil records, has been implicitly assumed to be equal to Tg.

λ=μ=8.9*e-8
λ=D/(2T)
D=1.23%
T= 6 mya?
T=D/(2μ)

Applications:

    Molecular Clock: This formula is widely used in molecular clock analysis, where researchers estimate the rate of molecular evolution based on known divergence times (often from the fossil record or geological events) and observed genetic distances between species.

Sources:

    This formula is a fundamental concept found in evolutionary biology and molecular phylogenetics texts, such as:
        "Molecular Evolution" by Wen-Hsiung Li
        "Molecular Evolution and Phylogenetics" by Masatoshi Nei and Sudhir Kumar
        "Principles of Population Genetics" by Daniel L. Hartl and Andrew G. Clark

These sources cover the underlying theory of molecular clocks, genetic distance, and substitution rates in much more detail.


## calculate per site substitute rate
## A Step-by-Step Tutorial: Divergence Time Estimation with Approximate Likelihood Calculation Using MCMCTREE in PAML
