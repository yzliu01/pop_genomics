******** step I: create a list to sample alignments ********

# 537 (new_transcript_id_7_and_pas_wasp)
# 211 (new_transcript_id_8_bom_apis_wasp)

# 8_bom_apis
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
ls OG*same_header.fas > OG_cds_8_species_same_header_fas.list
# 7_and_pas
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
ls OG*same_header.fas > OG_cds_7_species_same_header_fas.list

# just a test in R
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis")
OG_list <- read.table("OG_cds_9_species_same_header_fas.list",header=F)
head(OG_list)
class(OG_list)
as.list(OG_list)

a <- c(1,2,0,7,5)
class(a)
a[runif(2,1,6)]
a[sample(1:length(a), 2)]
sample(a, 3, replace=FALSE)

************** step II: create list of 10 random slection of 10 OG **************
new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
# use shuf: Write a random permutation of the input lines to standard output.
# -r, --repeat              output lines can be repeated
shuf -n 211 -r OG_cds_8_species_same_header_fas.list | sort -V #| uniq -d

# 8_pas_apis
for n in $(seq 1 211)
do
#echo $n
shuf -n 211 -r $new_transcript_id_8_bom_apis/OG_cds_8_species_same_header_fas.list | sort -V > $new_transcript_id_8_bom_apis/shuf_sample_list/OG_cds_8_species_same_header_fas.211OG_$n.list
done

# 7_and_pas
for n in $(seq 1 537)
do
#echo $n
shuf -n 537 -r $new_transcript_id_7_and_pas/OG_cds_7_species_same_header_fas.list | sort -V > $new_transcript_id_7_and_pas/shuf_sample_list/OG_cds_7_species_same_header_fas.537OG_$n.list
done


*********** step III: catfasta2phyml ***********
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py
## format strick phylip format using plags -p and -s as a combination (see --help)
cd ./trimmed_stop_codon_concat
$catfasta2phyml -ps OG*14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.fas > cat.out.14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.phy
$catfasta2phyml -ps OG*14_species.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas > cat.out.14_species.prank_codon.iterate2.trimmed_stop_codon.same_header.phy

# final cat
$catfasta2phyml -f OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas > cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.fas
$catfasta2phyml -ps OG*14_species*trimmed_stop_codon.prank_codon.iterate2*same_header.fas > cat.out.14_species.trimmed_stop_codon.prank_codon.iterate2.same_header.phy

*********** comprehensive method *************
cd $new_transcript_id_7_and_pas
# 8_pas_apis
folder_name_list=$(ls OG_cds*211OG*.list)
for folder_name in $folder_name_list
    do
    #echo $folder_name
    #done
    filal_folder_name=${folder_name/.list/}
    mkdir $filal_folder_name
#done
        # read file list and copy the files to a directory
        while IFS= read -r file
        do
        cp ./$file ./bootstraps/$filal_folder_name
        done < $folder_name
    # read the fas files from each bootstrap folder and output concatenated alignment sequences to bootstrap folder
    $catfasta2phyml -ps ./bootstraps/$filal_folder_name/OG*cds.8_species*iterate2.same_header.fas > ./bootstraps/cat.out.$filal_folder_name.phy
    $catfasta2phyml -f ./bootstraps/$filal_folder_name/OG*cds.8_species*iterate2.same_header.fas > ./bootstraps/cat.out.$filal_folder_name.fas

done

cd $new_transcript_id_7_and_pas
# 7_and_pas
folder_name_list=$(ls ./shuf_sample_list/OG_cds*537OG*.list)
# OG_cds_9_species_same_header_fas.50OG_1.list
for folder_name in $folder_name_list
    do
    #echo $folder_name
    #done
    # create folders for each bootstrap
    filal_folder_name=${folder_name/.list/}
    # OG_cds_9_species_same_header_fas.50OG_1
    mkdir $filal_folder_name
#done
        # read file list and copy the fas files to the directory of each bootstrap
        while IFS= read -r file
        do
        cp ./$file ./bootstraps/$filal_folder_name
        done < $folder_name
    # read the fas files from each bootstrap folder and output concatenated alignment sequences to bootstrap folder
    $catfasta2phyml -ps ./bootstraps/$filal_folder_name/OG*cds.7_species*iterate2.same_header.fas > ./bootstraps/cat.out.$filal_folder_name.phy
    $catfasta2phyml -f ./bootstraps/$filal_folder_name/OG*cds.7_species*iterate2.same_header.fas > ./bootstraps/cat.out.$filal_folder_name.fas

done

************ run yn00 ***********
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j
ls *50OG_1.ctl
# example .ctl file name
yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_1.ctl

for i in $(seq 2 10)
do
cp yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_1.ctl yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_$i.ctl
sed -i "s/50OG_1/50OG_$i/g" yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_$i.ctl
yn00 yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_1.ctl
yn00 yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_$i.ctl
done

yn00_ds_OG_1_log=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp/substitution_rate_yn00_9_bom_apis_wasp_75OG.10bootstraps_50OG_1.log
awk "NR >= 135 && NR <= 144" $yn00_ds_OG_1_log
new_transcript_id_9_bom_apis_wasp=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_9_bom_apis_wasp
cd $new_transcript_id_9_bom_apis_wasp

for ds_log in $(ls *50OG*log)
do
awk 'NR >= 135 && NR <= 144 {print $1,$4,$7,$10,$13,$16,$19,$22,$25}' FS=" " $ds_log | sed 's/)//g' >> yn00_ds_9species_bom_apis_wasp_50OG_10bootstraps.log
done


****** extract dS from condeml run *******
# a test result
boostrap_dS=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j/bee_work/boostrap_dS
# run codeml in the specific folder to keep output files in the same place
cd $boostrap_dS/codeml_8_pas_apis_211OG_bootstrap.test_2
# run codeml
codeml ./codeml_8_pas_apis_211OG_bootstrap.test_2/codeml_8_pas_apis_211OG_bootstrap.test.ctl

result_test_1=./codeml_8_pas_apis_211OG_bootstrap.test_1/rst.xxx
#result_test_2=./codeml_8_pas_apis_211OG_bootstrap.test_2/rst

#awk 'NR > 5 && NR < 42 {print $1,$2,$6}' OFS="\t" $result_test_1
out_name=${result_test_1#*/rst}
echo "$out_name"

## create a temporary directory for dS extraction
cd $boostrap_dS
mkdir temp

## use index for each bootstrap
index=0
for dS in $(find . -type f -name 'rst')
do
#echo $dS
## ./codeml_8_pas_apis_211OG_bootstrap.test_2/rst
((index++))
#done
## delete strings before rst
out_name=${dS#*/rst}
echo "rst$out_name"_"$index"
## read just the 6th column of dS
awk 'NR > 5 && NR < 42 {print $6}' OFS="\t" $dS > ./temp_dS/"rst$out_name"_"$index".temp
## combine each dS
paste ./temp_dS/*.temp > combined_2_bootstraps.log
done
