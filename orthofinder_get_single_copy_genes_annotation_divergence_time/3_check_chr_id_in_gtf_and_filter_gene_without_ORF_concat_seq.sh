

******************** step V_a: obtain amino acide sequences for each busco_id if starting with M ********************
## codes from chatGPT
#!/bin/bash
# Loop through all .faa files
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/OrthoFinder/Results_Aug29/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep15_1/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep19_apoidea/Single_Copy_Orthologue_Sequences

annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_and_pas_wasp/OrthoFinder/Results_Oct01/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_9_bom_apis_wasp/OrthoFinder/Results_Oct02/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_9_bom_apis_wasp/OrthoFinder/Results_Oct04/Single_Copy_Orthologue_Sequences
# correct for bootstrap
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
annotation_id_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
cd $annotation_id_dir

# ls |sort -V | head
# OG0003399.fa
# OG0003400.fa

# ls *.fa | wc -l
# 1176

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

***************** check how many files left ********************
ls | grep -v "_M.fa" | wc -l
new_transcript_id_9_bom_apis_wasp (72)
new_transcript_id_9_bom_apis_wasp (75)
new_transcript_id_8_and_pas_wasp (255)

new_transcript_id_8_bom_apis_wasp (211)
new_transcript_id_7_and_pas_wasp (537)

head OG0003401.fa
>And_bic.g14096.t1
MAFFEWRRFNFFDLKKEVDGGKIAKALGDAQVTAATSGNGNLVFGDNTGNVHLVNRTYDV
TTFRAYEITLTLAQQVQHSTFLFTIGEDELGCNPTIKVWNLEKQGSPTCVRISRAIPSYK
NITPKSSPIQKAFVPPKTPIVPSNPFQTVEYDESKNPFFDEKDSNLVKDNDDDDCNKNLN
PFSR*
>And_ful.ENSAFVG00005013433
MAFFEWRRFNFFDLKKEVDGGKIAKALGDAQVTAATSGNGNLVFGDNTGNVHLVNRTYDV
TTFRAYEITLTLAQQVQHSTFLFTIGEDELGCNPTIKVWNLEKQGSPICVRISRAIPSYR
AVPATALCVHSSLTLMAVGFGDGCIMLYRGDLTRERKNKIKVLQDANISITGLAIKSTGK

******** extract single_copy_orthologue_id and save them in a file, which will be used in gffread to retreat nucleotide sequences ********
for single_copy_orthologue_id in $(ls | grep -v "_M.fa")
do
grep ">" $single_copy_orthologue_id | sed 's/>//' > $single_copy_orthologue_id.header.list
done

## transcript_id issue existing
cat OG0009015.fa.header.list
And_bic.g16795.t1
And_ful.ENSAFVT00005003830.1
And_hae.ENSAHET00005017064.1
And_hat.ENSAHTT00000015488.1
And_mar.g13175.t1
And_tri.ENSFOKT00000008096.1
Apis_mel.XM_006562385.3
Bom_con.g8573.t1
Bom_hor.ENSBHTT00000024822.1
Bom_hyp.ENSBHYT00000003502.1
Bom_mus.g5288.t1
Bom_pas.ENSBPAT00000022594.1
Bom_syl.ENSBSYT00000010046.1
Bom_vet.g3380.t1

*********** delete the version number for species but Apis mel **************
for list in $(ls *fa.header.list)
do
new_file=${list/list/new.list}
# Apis mel gtf file contains transcript id with version number but not for others
sed -E '/Apis_mel/!s/(.[ful|hae|hat|tri|hor|hyp|pas|syl]+.*)\.[1-9]/\1/g' $list > $new_file
done

cat OG0009015.fa.header.new.list
And_bic.g16795.t1
And_ful.ENSAFVT00005003830
And_hae.ENSAHET00005017064
And_hat.ENSAHTT00000015488
And_mar.g13175.t1
And_tri.ENSFOKT00000008096
Apis_mel.XM_006562385.3
Bom_con.g8573.t1
Bom_hor.ENSBHTT00000024822
Bom_hyp.ENSBHYT00000003502
Bom_mus.g5288.t1
Bom_pas.ENSBPAT00000022594
Bom_syl.ENSBSYT00000010046
Bom_vet.g3380.t1

ls *.header.list | wc -l
211
ls *.header.new.list | wc -l
211 # pas_apis
537 # and_pas

head OG0003401.fa.header.list
And_bic.g14096.t1
And_ful.ENSAFVG00005013433
And_hae.ENSAHEG00005010799
And_hat.ENSAHTG00000005884
And_mar.g10890.t1
And_tri.ENSFOKG00000011406
Apis_mel.XP_026300747
Bom_con.g12659.t1
Bom_hor.ENSBHTG00000018305
Bom_hyp.ENSBHYG00000014989
# test
file=OG0009220.fa.header.list
while IFS= read -r line
do
echo "read line: "$line
done < $file

********** formal **********

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

************ In GTF, fields must be separated by a single TAB and no white space. *******
## path to gft files
#gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id
gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id
#cd $gtf_dir

gtf_And_bic=$gtf_dir/Andrena_bicolor-GCA_960531205.1_braker-genes.transcript_id.new.gtf
gtf_And_ful=$gtf_dir/Andrena_fulva-GCA_946251845.1-2023_02-genes.transcript_id.new.gtf
gtf_And_hae=$gtf_dir/Andrena_haemorrhoa-GCA_910592295.1-2021_11-genes.transcript_id.new.gtf
gtf_And_hat=$gtf_dir/Andrena_hattorfiana-GCA_944738655.1-2022_08-genes.transcript_id.new.gtf
gtf_And_mar=$gtf_dir/Andrena_marginata-GCA_963932335.1_braker-genes.transcript_id.new.gtf
## first column is sparated by space that is not allowed in gtf file
## tab separated gtf
##gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.new.gtf
##gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.new.gtf-
##gtf_And_tri=$gtf_dir/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr.gtf
## correct one
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

#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_gene_id/OrthoFinder/Results_Aug29/Single_Copy_Orthologue_Sequences
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep15_1/Single_Copy_Orthologue_Sequences
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_14species/OrthoFinder/Results_Sep19_apoidea/Single_Copy_Orthologue_Sequences

#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_and_pas_wasp/OrthoFinder/Results_Oct01/Single_Copy_Orthologue_Sequences
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_9_bom_apis_wasp/OrthoFinder/Results_Oct02/Single_Copy_Orthologue_Sequences
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_9_bom_apis_wasp/OrthoFinder/Results_Oct04/Single_Copy_Orthologue_Sequences

#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences
single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences

# check the number of valid ortholog groups
ls $single_copy_orthologue_with_start_M/*new.list | wc -l

36
255 (new_transcript_id_8_and_pas_wasp)
72 (new_transcript_id_9_bom_apis_wasp)

537 (new_transcript_id_7_and_pas_wasp)
211 (new_transcript_id_8_bom_apis_wasp)

#extracted_cds_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds
#extracted_cds_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new
#cd $extracted_cds_dir

#extracted_cds_dir_8_and_pas_wasp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_and_pas_wasp
#cd $extracted_cds_dir_8_and_pas_wasp

#extracted_cds_dir_9_bom_apis_wasp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp
#cd $extracted_cds_dir_9_bom_apis_wasp

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

****** delete log file if existing *******
rm file_36OG.log
rm file_255OG_rest.log
rm file_75OG_rest.log

****** find out empty file ******
find . -type f -name 'OG0009220*cds.fa' -size +0 | wc -l
find . -type f -name 'OG0009227*cds.fa' -size +0 | wc -l

# delete file empty files
find . -type f -size 0 -delete
find . -type f -size +0
rm *list.out

********** check each ortholog has all sequences and concatenate sequences **********
# 36OG
cd $extracted_cds_dir

# 7_and_pas_wasp
extracted_cds_dir_7_and_pas_wasp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $extracted_cds_dir_7_and_pas_wasp
# 7_and_pas_wasp
single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_7_and_pas/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences

# 8_bom_apis_wasp
extracted_cds_dir_8_bom_apis_wasp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $extracted_cds_dir_8_bom_apis_wasp
# 8_bom_apis_wasp
#single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_9_bom_apis_wasp/OrthoFinder/Results_Oct02/Single_Copy_Orthologue_Sequences
single_copy_orthologue_with_start_M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id_8_bom_apis/OrthoFinder/Results_Oct07/Single_Copy_Orthologue_Sequences

#cd $single_copy_orthologue_with_start_M
# OG id in the single_copy_gene folder
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

rm *.cds.14_species.fa

OG0009015       14
OG0009027       14
OG0009044       14
OG0009055       14
OG0009162       14
OG0009169       14
OG0009208       14
OG0009218       14

****** chatGPT check if multiple of three bases *******
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

rename 9_species 8_species *trimmed.fa
## only a finding
# Sequence Apis_mel.NM_001010975.1 has excess 2 base(s). Original length: 902, Trimmed length: 900

****** not multiple of three bases for Apis mellifera *******

OG0009313.cds.14_species.fa
conda activate myproject
Apis_mel_ref=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
#gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id
#Apis_mel_gtf=$gtf_dir/Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.transcript_id.new.gtf
OG_gtf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new
OG0009313_gtf=OG0009313.Apis_mel.NM_001010975.1.Apis_mellifera-GCF_003254395.2_Amel_HAv3.1-genes.transcript_id.new.gtf.gtf
gffread -x $OG_gtf_dir/codon_issue/$OG0009313_gtf.codon_issue.fa  -g $Apis_mel_ref $OG0009313_gtf

wrong_result: GAATCTtcttta(A)
stop_codon(tta): 10937826 (a)    10937828(t)




****** issue and investigation of Andrena trimmerana gtf file ******
and_tri_gtf=OG0009015.And_tri.ENSFOKT00000008096.Andrena_trimmerana.gtf
and_tri_gtf=OG0009027.And_tri.ENSFOKT00000014743.Andrena_trimmerana.gtf
gffread -x $and_tri_gtf.CDS.fa  -g $ref_And_tri $and_tri_gtf

less -S $ref_And_tri | grep '>' | head
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_trimmerana-GCA_951215215.1-softmasked.fa

new_ref_And_tri=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_trimmerana-GCA_951215215.1-softmasked.new_header.fa
sed -E 's/(>ENA.*\.[1-9]) .*/\1/g' $ref_And_tri > $new_ref_And_tri | less -S
gffread -x $and_tri_gtf.CDS.fa  -g $new_ref_And_tri $and_tri_gtf

origional_gtf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.is_new_transcript_id.gtf-
origional_gtf_md_chr=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.is_new_transcript_id.md_chr.gtf-
new_tri_gtf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.new.gtf
tab_separated_tri_gtf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/new_transcript_id/Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr.gtf-
gffread -x And_tri.test_CDS.fa  -g $ref_And_tri $origional_gtf
gffread -x And_tri.test_CDS.fa  -g $ref_And_tri $origional_gtf_md_chr
gffread -x And_tri.test_CDS.fa  -g $ref_And_tri $tab_separated_tri_gtf
# Warning: couldn't find fasta record for '1'!
# Error: no genomic sequence available (check -g option!).
gffread -x And_tri.test_CDS.fa  -g $ref_And_tri $new_tri_gtf

gffread -x And_tri.test_CDS.fa  -g $new_ref_And_tri $origional_gtf
gffread -x And_tri.test_CDS.fa  -g $new_ref_And_tri $new_tri_gtf

ENA|OX578059|OX578059.1	142895829	25	60	61
ENA|OX578060|OX578060.1	91870870	145277477	60	61
ENA|OX578061|OX578061.1	39856278	238679554	60	61
ENA|OX578062|OX578062.1	39551669	279200129	60	61
ENA|OX578063|OX578063.1	29784559	319411018	60	61
ENA|OX578064|OX578064.1	19771	349692012	60	61
# FASTA index file /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_trimmerana-GCA_951215215.1-softmasked.new_header.fa.fai created.
# Warning: invalid end coordinate at line:
ENA|OX578063|OX578063.1 ensembl transcript      19290298        19291127        .       +       .       gene_id "And_tri.ENSFOKG00000009570"; gene_version "1"; transcript_id "And_tri.ENSFOKT00000014743"; transcript_version "1"; gene_source "ensembl"; gene_biotype "protein_coding"; transcript_source "ensembl"; transcript_biotype "protein_coding"; tag "Ensembl_canonical";

**** make sure the chromosome names in gtf file are the same as that in genome.fa file ****
# change simplified chr to original one in the reference fasta files (_ to |)
# And_bic And_mar Bom_mus And_tri (more changes)
# And_bic
ENA_CAUIJW010000001_CAUIJW010000001.1
# new
ENA|CAUIJW010000001|CAUIJW010000001.1

# particular for Andrena trimmerana

_CAXAQ -> |CAXAQ
ENA_OZ010664_OZ010664.1
ENA|OZ010664|OZ010664.1

less $ref_And_tri | grep '>'
>ENA|OX578059|OX578059.1 Andrena trimmerana genome assembly, chromosome: 1
>ENA|OX578060|OX578060.1 Andrena trimmerana genome assembly, chromosome: 2
>ENA|OX578061|OX578061.1 Andrena trimmerana genome assembly, chromosome: 3
>ENA|OX578062|OX578062.1 Andrena trimmerana genome assembly, chromosome: 4
>ENA|OX578063|OX578063.1 Andrena trimmerana genome assembly, chromosome: 5
>ENA|OX578064|OX578064.1 Andrena trimmerana genome assembly, organelle: mitochondrion
>ENA|CATNUO010000001|CATNUO010000001.1 Andrena trimmerana genome assembly, contig: scaffold_100
>ENA|CATNUO010000002|CATNUO010000002.1 Andrena trimmerana genome assembly, contig: scaffold_112
>ENA|CATNUO010000003|CATNUO010000003.1 Andrena trimmerana genome assembly, contig: scaffold_32

less Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.new.gtf- | awk '{print "ENA|"$1"|"$1}' > \
    Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr.gtf

awk 'NR==7{print NF}' OFS="\t" Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.gtf

***** In GTF, fields must be separated by a single TAB and no white space.  ******
http://mblab.wustl.edu/GTF2.html
https://ccb.jhu.edu/software/stringtie/gff.shtml#gffread
## replace numbers chr that are at the beginning of each line
sed -e 's/^1\b/OX578059.1/g' \
    -e 's/^2\b/OX578060.1/g' \
    -e 's/^3\b/OX578061.1/g' \
    -e 's/^4\b/OX578062.1/g' \
    -e 's/^5\b/OX578063.1/g' \
    -e 's/^mitochondrion\b/OX578064.1/g' \
    Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.new.gtf- \
    > Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr_tem_1.gtf-
# CATNUO010000051.1       ensembl exon

## remove the first 5 lines
# print the first column and then print all from the second columns
# In GTF, fields must be separated by a single TAB and no white space.
grep -v '^#' Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr_tem_1.gtf- | \
    awk 'BEGIN {OFS="\t"} {print "ENA|"$1"|"$1, substr($0, index($0,$2))}' | sed 's/\.1|/|/' \
    > Andrena_trimmerana-GCA_951215215.1-2023_07-genes.transcript_id.md_chr.gtf-
## need to change it
# ENA|OX578059.1|OX578059.1
## below is desired
# ENA|OX578059|OX578059.1
rm *md_chr_tem_1.gtf

## $1: Prints the first column (which contains chr_x)
## substr($0, index($0,$2)): Starts printing from the second column ($2) to the last. 
## index($0,$2) finds where the second column starts, and substr extracts everything from that position to the end of the line.
awk '{print $1, substr($0, index($0,$2))}'