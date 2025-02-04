

## obtain amino acide sequences for each busco_id if starting with M
# Loop through all .faa files
# correct for bootstrap
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
cd $annotation_id_dir

for file in `ls *.fa | sort -V`; do
#for file in `ls *.fa | sort -V | head -2`; do
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
        cp "$file" "$file.without_start_M.fa"
        rm "$file"
    else
        echo "$file passed the filter."
    fi
done

## check how many files with amino sequence starting with M left
ls | grep -v "_M.fa" | wc -l

new_transcript_id_8_bom_apis_wasp (211)
new_transcript_id_7_and_pas_wasp (537)


## extract single_copy_orthologue_id and save them in a file, which will be used in gffread to retreat nucleotide sequences
for single_copy_orthologue_id in $(ls | grep -v "_M.fa")
do
grep ">" $single_copy_orthologue_id | sed 's/>//' > $single_copy_orthologue_id.header.list
done


## delete the version number for species but Apis mel
for list in $(ls *fa.header.list)
do
new_file=${list/list/new.list}
# Apis mel gtf file contains transcript id with version number but not for others
sed -E '/Apis_mel/!s/(.[ful|hae|hat|tri|hor|hyp|pas|syl]+.*)\.[1-9]/\1/g' $list > $new_file
done


## categorize each group: Andrena and Bombus

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
# 14 reference species
ref_And_bic=$ref_dir/Andrena_bicolor-GCA_960531205.1-softmasked.fa
ref_And_ful=$ref_dir/Andrena_fulva-GCA_946251845.1-softmasked.fa
ref_And_hae=$ref_dir/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
ref_And_hat=$ref_dir/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
ref_And_mar=$ref_dir/Andrena_marginata_GCA_963932335.1-softmasked.fa
ref_And_tri=$ref_dir/Andrena_trimmerana-GCA_951215215.1-softmasked.fa

#ref_Apis_mel=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
#ref_Bom_con=$ref_dir/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
#ref_Bom_hor=$ref_dir/Bombus_hortorum-GCA_905332935.1-softmasked.fa
#ref_Bom_hyp=$ref_dir/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
#ref_Bom_mus=$ref_dir/Bombus_muscorum-GCA_963971125.1-softmasked.fa
ref_Bom_pas=$ref_dir/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
#ref_Bom_syl=$ref_dir/Bombus_sylvestris-GCA_911622165.2-softmasked.fa
#ref_Bom_vet=$ref_dir/Bombus_veteranus.hifi_asm_pl2-softmasked.simple_headers.fa

#ref_Ves_vul=$ref_dir/Vespula_vulgaris-GCA_905475345.1-softmasked.fa

ref_list=(
    "$ref_And_bic"
    "$ref_And_ful"
    "$ref_And_hae"
    "$ref_And_hat"
    "$ref_And_mar"
    "$ref_And_tri"

    #"$ref_Apis_mel"
    #"$ref_Bom_con"
    #"$ref_Bom_hor"
    #"$ref_Bom_hyp"
    #"$ref_Bom_mus"
    "$ref_Bom_pas"
    #"$ref_Bom_syl"
    #"$ref_Bom_vet"
    
    #"$ref_Ves_vul"
)

## In GTF, fields must be separated by a single TAB and no white space. *******
## path to gft files
gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id

gtf_And_bic=$gtf_dir/Andrena_bicolor-GCA_960531205.1_braker-genes.transcript_id.new.gtf
gtf_And_ful=$gtf_dir/Andrena_fulva-GCA_946251845.1-2023_02-genes.transcript_id.new.gtf
gtf_And_hae=$gtf_dir/Andrena_haemorrhoa-GCA_910592295.1-2021_11-genes.transcript_id.new.gtf
gtf_And_hat=$gtf_dir/Andrena_hattorfiana-GCA_944738655.1-2022_08-genes.transcript_id.new.gtf
gtf_And_mar=$gtf_dir/Andrena_marginata-GCA_963932335.1_braker-genes.transcript_id.new.gtf
gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr.gtf-

#gtf_Apis_mel=$gtf_dir/Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.transcript_id.new.gtf
#gtf_Bom_con=$gtf_dir/Bombus_confusus-GCA_014737475.1_ASM1473747v1_braker-genes.transcript_id.new.gtf
#gtf_Bom_hor=$gtf_dir/Bombus_hortorum-GCA_905332935.1-2021_11-genes.transcript_id.new.gtf
#gtf_Bom_hyp=$gtf_dir/Bombus_hypnorum-GCA_911387925.1-2021_11-genes.transcript_id.new.gtf
#gtf_Bom_mus=$gtf_dir/Bombus_muscorum-GCA_963971125.1_braker-genes.transcript_id.new.gtf
gtf_Bom_pas=$gtf_dir/Bombus_pascuorum-GCA_905332965.1-2021_11-genes.transcript_id.new.gtf
#gtf_Bom_syl=$gtf_dir/Bombus_sylvestris-GCA_911622165.2-2023_03-genes.transcript_id.new.gtf
#gtf_Bom_vet=$gtf_dir/Bombus_veteranus-softmasked-hifiasm_braker.genes.transcript_id.new.gtf

#gtf_Ves_vul=$gtf_dir/Vespula_vulgaris-GCA_905475345.1-2021_11-genes.transcript_id.new.gtf

#gtf_Ves_vul=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/Vespula_vulgaris-GCA_905475345.1-2021_11-genes.new_gene_id.gtf
#new_gtf_name=${gtf_Ves_vul%%[_-]GCA*}
#echo $new_gtf_name

gtf_list=(
    "$gtf_And_bic"
    "$gtf_And_ful"
    "$gtf_And_hae"
    "$gtf_And_hat"
    "$gtf_And_mar"
    "$gtf_And_tri"
    
    #"$gtf_Apis_mel"
    #"$gtf_Bom_con"
    #"$gtf_Bom_hor"
    #"$gtf_Bom_hyp"
    #"$gtf_Bom_mus"
    "$gtf_Bom_pas"
    #"$gtf_Bom_syl"
    #"$gtf_Bom_vet"
    
    #"$gtf_Ves_vul"
)

## call gffread
conda activate myproject
#gffread -h
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences

# check the number of valid ortholog groups
ls $single_copy_orthologue_with_start_M/*new.list | wc -l

537 (new_transcript_id_7_and_pas_wasp)
211 (new_transcript_id_8_bom_apis_wasp)

extracted_cds_dir_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $extracted_cds_dir_7_and_pas

#extracted_cds_dir_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
#cd $extracted_cds_dir_8_bom_apis

for orthologue_id in $(ls $single_copy_orthologue_with_start_M/*.fa.header.new.list)
#for orthologue_id in $(ls $single_copy_orthologue_with_start_M/*.fa.header.new.list | head -2) # in total, 2 + 34 = 36
#for orthologue_id in $(ls $single_copy_orthologue_with_start_M/*.fa.header.new.list | tail -n +3) # from the third line instead of the last 3 lines because the first has already been tested above.
# Single_Copy_Orthologue_Sequences/OG0003401.fa.header.list
do
#echo $orthologue_id
# it's the path
#/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep15_1/Single_Copy_Orthologue_Sequences/OG0009015.fa.header.list
# delete strings before Sequences
new_orthologue_id=${orthologue_id#*_Sequences/}
# OG0009015.fa.header.list
# delete strings after ".fa"
new_orthologue_id=${new_orthologue_id%.fa*}
# OG0009015
echo -e "\n"$new_orthologue_id"\n"
#done
    while IFS= read -r line
    # line: And_bic.g16795.t1 ...
    do
        # 14 species not including outgroup species
        #for i in $(seq 0 13)
        # 15 species for two groups and outgroup species
        #for i in $(seq 0 14)
        
        # and_pas
        for i in $(seq 0 6) # important to check

        # pas_apis
        #for i in $(seq 0 7) # important to check to avoid invalid file name
        do
        #echo $i
        #done
        #echo -e "read_line_$i: "$new_orthologue_id.$line >> file_36OG_rest.log # file_36OG.log
        #echo -e "\n${gtf_list[i]}\n" >> file_36OG_rest.log

        echo -e "read_line_$i: "$new_orthologue_id.$line >> file_537OG_rest.log
        echo -e "\n${gtf_list[i]}\n" >> file_537OG_rest.log

        ## match gene_id and extract lines from gtf file of each species
        ## match string before and include "transcript_id"
        new_gtf_name=${gtf_list[i]#*transcript_id/}
        ## keep string before "_GCA", forgot "_GCF"
        new_gtf_name=${new_gtf_name%[_-]GC*}
        
        #echo ./$new_orthologue_id.$line.$new_gtf_name.gtf >> file_36OG_rest.log
        
        echo ./$new_orthologue_id.$line.$new_gtf_name.gtf >> file_537OG_rest.log

        grep "$line" ${gtf_list[i]} > ./$new_orthologue_id.$line.$new_gtf_name.gtf
        #| gffread -g ${ref_list[i]} >> ./$orthologue_id.out
        ## write sequences to a file
        #gffread -g ${ref_list[i]} ./$new_orthologue_id.$new_gtf_name.gtf >> ./$new_orthologue_id.$new_gtf_name.cds.out
        gffread -x ./$new_orthologue_id.$line.$new_gtf_name.cds.fa -g ${ref_list[i]} ./$new_orthologue_id.$line.$new_gtf_name.gtf
        
        #echo -e "\nwrite cds to ./$new_orthologue_id.$line.$new_gtf_name.cds.fa\n" >> file_36OG_rest.log
        
        echo -e "\nwrite cds to ./$new_orthologue_id.$line.$new_gtf_name.cds.fa\n" >> file_537OG_rest.log
        
        ## delete empty files that are not matched
        #find . -type f -size 0 -delete
        done
    done < $orthologue_id
done

## delete file empty files
find . -type f -size 0 -delete

## concatenate items of the single_copy_gene for each OG id
for orthlog_id in $(ls $single_copy_orthologue_with_start_M/*fa.header.new.list | sed -e 's/.*Sequences\///' -e 's/\.fa.*//')
do
echo $orthlog_id | tr "\n" "\t"
# extracted cds.fa files
ls | grep -E "$orthlog_id.*.cds.fa" | wc -l
# concatenate all sequences
#ls $orthlog_id.*.cds.fa | xargs cat > $orthlog_id.cds.14_species.fa

# 8_bom_apis
#ls $orthlog_id.*.cds.fa | xargs cat > $orthlog_id.cds.8_species.fa

# 7_and_pas
ls $orthlog_id.*.cds.fa | xargs cat > $orthlog_id.cds.7_species.fa

done


## check if multiple of three bases *******
# need python env
conda activate myproject
trim_excess_bases=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/3_trim_excess_bases.py

# 7_and_pas
extracted_cds_dir_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $extracted_cds_dir_7_and_pas

# 8_bom_apis
extracted_cds_dir_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $extracted_cds_dir_8_bom_apis

#for raw_fa in `ls *.cds.fa | head -20`
for raw_fa in `ls *.cds.fa`
ls | grep 'cds.trimmed.fa' | xargs rm

# use merged sequences
#for raw_fa in `ls *.8_species.fa` # 8_bom_apis
for raw_fa in `ls *.7_species.fa` # 7_and_pas 
do
out_name_trim=${raw_fa/fa/trimmed.fa}
python $trim_excess_bases $raw_fa $out_name_trim
done

## make sure the chromosome names in gtf file are the same as that in genome.fa file