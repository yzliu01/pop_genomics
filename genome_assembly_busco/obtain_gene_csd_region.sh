

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
busco_Ves_vul=$busco_dir/BUSCO_Vespula_vulgaris-GCA_905475345.1-softmasked.fa/run_hymenoptera_odb10/busco_sequences/single_copy_busco_sequences


species_list=(
    "busco_Apis_mel"
    "busco_And_bic"
    "busco_And_ful"
    "busco_And_hae"
    "busco_And_hat"
    "busco_And_mar"
    "busco_And_tri"
    "busco_Bom_con"
    "busco_Bom_hor"
    "busco_Bom_hyp"
    "busco_Bom_mus"
    "busco_Bom_pas"
    "busco_Bom_syl"
    "busco_Ves_vul"
)

********** step II: retrieve complete CDS of single_copy_busco_sequences *********
for busco_species in `echo ${species_list[@]}`
    do
    cd `echo ${!busco_species}`
    ## Variable Expansion: The species_list contains the names of variables as strings. To get the value of each variable in the loop, I used the syntax ${!busco_species} which performs indirect expansion, resolving the value of the variable whose name is stored in busco_species.
    pwd
    find -type f -name '*.gff' -exec grep -h 'CDS' {} \+ | cut -f 1,4- | sort -k1,1V -k2,2n > $busco_dir/busco_species_single_copy_complete_CDS/$busco_species.single_copy_complete_CDS.bed ## save results in folder: busco_sequences
    cd $busco_dir
    pwd
done


********* step III: get common busco id of amino sequences **********
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
## output the list
awk '{a[$1]++} END{for(k in a) if(a[k]==ARGC-1) print k}' busco*.id | sort -V > common_busco_id.txt


****** step IV: procure (fetch) the shared single_copy_busco_sequences by all these species into separate file ******
busco_id_dir=$busco_dir/busco_species_single_copy_complete_CDS/busco_id
busco_id=`cat $busco_id_dir/common_busco_id.txt`

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
    done
    cd $busco_dir
    pwd
done


********* step V: filter out FASTA sequences that not start with the amino acid M (Methionine) after the header line **********
## https://stackoverflow.com/questions/26479562/what-does-ifs-do-in-this-bash-loop-cat-file-while-ifs-read-r-line-do

******************** step V_a: obtain amino acide sequences of each busco_id ********************
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
busco_Ves_vul=$ref_dir/Vespula_vulgaris-GCA_905475345.1-softmasked.fa

ref_list=(
    "busco_Apis_mel"
    "busco_And_bic"
    "busco_And_ful"
    "busco_And_hae"
    "busco_And_hat"
    "busco_And_mar"
    "busco_And_tri"
    "busco_Bom_con"
    "busco_Bom_hor"
    "busco_Bom_hyp"
    "busco_Bom_mus"
    "busco_Bom_pas"
    "busco_Bom_syl"
    "busco_Ves_vul"
)

#cd ..

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

    new_file_name_header=${temp_file_name/fa/header.fa}
    echo $new_file_name_header
    head_line=${new_file_name_header/.header.fa/}
    
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
for file in *.gff.busco_*.combined.header.fa
    do
    prefix=$(echo "$file" | sed 's/\.busco.*//')
    echo "$prefix"
    # e.g., 1at7399.gff

    ## sort out output in one step
done | sort -V | uniq
    )

busco_species=$(
for file in $(ls *.gff.busco_*.combined.header.fa | head -40)
    do
    species=$(echo "$file" | sed -E 's/.*gff\.busco_([^.]+)\.combined\.header\.fa/\1/')
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
    for file in ${prefix}*combined.header.fa
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
            cat $file >> $prefix.combined_share.fa
            echo -e "\n" >> $prefix.combined_share.fa
        #done
    done
done

11660at7399.gff.busco_And_mar.combined.header.fa
11660at7399.gff.busco_And_tri.single_CDS_with_M-RC.fa
11660at7399.gff.busco_And_tri.combined.fa
11660at7399.gff.busco_And_tri.combined.header.fa

************* step VIII: align multiple sequences ***************
## https://mafft.cbrc.jp/alignment/software/; https://github.com/rcedgar/muscle
## reasons to choose different program: https://help.geneious.com/hc/en-us/articles/360044627712-Which-multiple-alignment-algorithm-should-I-use
conda activate myproject
conda install bioconda::mafft

CDS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS
cd $CDS_dir
cat *seq.fa > busco_all_CDS_seq.fa
## mafft --thread 4 busco_all_CDS_seq.fa > busco_all_CDS_seq.output.msa
mafft --phylipout --thread 4 busco_all_CDS_seq.fa > busco_all_CDS_seq.output.phy

mafft --auto --thread 4 32320at7399.gff.combined_share.fa > 32320at7399.gff.combined_share.mafft
cp 32320at7399.gff.combined_share.mafft 32320at7399.gff.combined_share.mafft.copy

muscle -align 32320at7399.gff.combined_share.fa -output ./test_+-/32320at7399.gff.combined_share_align.new.afa
muscle -align 32232at7399.gff.combined_share.fa -output ./test_+-/32232at7399.gff.combined_share_align.new.afa

./test_+-/32232at7399.gff.combined_share_align.afa
./test_+-/32320at7399.gff.combined_share_align.afa

#    -phyiout ./test_+-/32320at7399.gff.combined_share_align.phyi \
#    -physout ./test_+-/32320at7399.gff.combined_share_align.phys

## concatenate aligned fasta files for each gene
## https://github.com/nylander/catfasta2phyml
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
$catfasta2phyml -h
cd test_+-/
$catfasta2phyml -f *align.afa > out.32232at7399_32232at7399.afa

$catfasta2phyml -f 32320at7399.gff.combined_share.mafft \
    32320at7399.gff.combined_share.mafft.copy > out.32320at7399_twice.afa

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

To isolate the substitution rate rr, you rearrange the formula:
r=D/2T

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
