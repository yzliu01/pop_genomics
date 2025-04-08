
********** After prank running, make sure fasta haders have the same name **********

# 8_bom_apis
new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
cd $new_transcript_id_8_bom_apis

# 7_and_pas
new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
cd $new_transcript_id_7_and_pas

#for fa in $(ls OG*cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas)
for fa in $(ls OG*cds.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.fa.best.fas)
do
echo "making same headers: $output_fa"
output_fa=${fa/fa.best.fas/same_header.fas}
sed -E 's/(^>[^.]*)\..*/\1/' $fa > $output_fa
# delete temporary file
#echo "deleting $fa"
#rm $fa
done

********** create a list to sample alignments **********

# 537 (new_transcript_id_7_and_pas_wasp)
# 211 (new_transcript_id_8_bom_apis_wasp)

# 8_bom_apis
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
ls OG*same_header.fas > OG_cds_8_species_same_header_fas.list
# 7_and_pas
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
ls OG*same_header.fas > OG_cds_7_species_same_header_fas.list



## create list of 1000 random slection of 211/537 OGs
new_transcript_id_8_bom_apis=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_8_bom_apis
# use shuf: Write a random permutation of the input lines to standard output.

# 8_bom_apis
## 1000 bootstraps of 211 OGs
for n in $(seq 1 1000)
do
#echo $n
shuf -n 211 -r $new_transcript_id_8_bom_apis/OG_cds_8_species_same_header_fas.list | sort -V > $new_transcript_id_8_bom_apis/shuf_sample_list/OG_cds_8_species_same_header_fas.shuf_211OG_$n.list
done

# 7_and_pas
new_transcript_id_7_and_pas=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_annotation/primary_transcripts/extracted_cds_new/new_transcript_id_7_and_pas
## 1000 bootstraps of 211 OGs
for n in $(seq 1 1000)
do
#echo $n
shuf -n 537 -r $new_transcript_id_7_and_pas/OG_cds_7_species_same_header_fas.list | sort -V > $new_transcript_id_7_and_pas/shuf_sample_list/OG_cds_7_species_same_header_fas.shuf_537OG_$n.list
done


********** concatenate aligned sequence (bootstraped) using catfasta2phyml **********
## comprehensive method
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py

# 8_bom_apis
cd $new_transcript_id_8_bom_apis

# format strick phylip
$catfasta2phyml -ps OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.phy
# final cat
$catfasta2phyml -f OG*8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

folder_name_list=$(ls shuf_sample_list/OG_cds*211OG*.list)
## avoid this issue: './bootstraps/./shuf_sample_list/OG_cds_8_species_same_header_fas.shuf_211OG_104'
# shuf_sample_list/OG_cds_8_species_same_header_fas.211OG_1.list
for folder_name in $folder_name_list
    do
    #echo $folder_name
    #done
    ## create folders for each bootstrap
    filal_folder_name=${folder_name/.list/}
    ## shuf_sample_list/OG_cds_8_species_same_header_fas.211OG_1
    filal_folder_name=${filal_folder_name#*shuf_sample_list/}
    ## OG_cds_8_species_same_header_fas.211OG_1

    # Create the bootstrap folder for the current list of files
    mkdir -p ./bootstraps/$filal_folder_name/
#done
        ## read file list and copy the files to a directory
        while IFS= read -r file
            do
            #echo $file
            ## OG0008677.cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

            # Create the target directory if it doesn't already exist
            mkdir -p ./bootstraps/$filal_folder_name/

            ## check if the file already exists in the target directory
            dest_file="./bootstraps/$filal_folder_name/$(basename $file)"

            ## initialize counter for remaining duplicates
            counter=1

            ## loop to rename the file if a file with the same name already exist
            while [ -e "$dest_file" ]
                do
                ## rename by adding a counter suffix (e.g., file_1.fas, file_2.fas, etc.)
                dest_file="./bootstraps/$filal_folder_name/$(basename ${file%.fas})_$counter.fas"
                counter=$((counter + 1))
            done
            ## OG0008677.cds.8_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas OG_cds_8_species_same_header_fas.shuf_211OG_202
            
            ## copy file to destination folder
            cp "$file" "$dest_file"
            echo "Copied $file to $dest_file"
        done < $folder_name
    ## read the fas files from each bootstrap folder and output concatenated alignment sequences to bootstrap folder
    $catfasta2phyml -ps ./bootstraps/$filal_folder_name/OG*cds.8_species*iterate2.same_header*.fas > ./bootstraps/cat.out.$filal_folder_name.phy
    $catfasta2phyml -f ./bootstraps/$filal_folder_name/OG*cds.8_species*iterate2.same_header*.fas > ./bootstraps/cat.out.$filal_folder_name.fas
done

# 7_and_pas
catfasta2phyml=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/catfasta2phyml.py

cd $new_transcript_id_7_and_pas

# format strick phylip
$catfasta2phyml -ps OG*7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.phy

# final cat
$catfasta2phyml -f OG*7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas > cat.out.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

folder_name_list=$(ls shuf_sample_list/OG_cds*537OG*.list)
## avoid this issue: './bootstraps/./shuf_sample_list/OG_cds_7_species_same_header_fas.shuf_537OG_104'
# shuf_sample_list/OG_cds_7_species_same_header_fas.537OG_1.list
for folder_name in $folder_name_list
    do
    #echo $folder_name
    #done
    ## create folders for each bootstrap
    filal_folder_name=${folder_name/.list/}
    ## shuf_sample_list/OG_cds_7_species_same_header_fas.537OG_1
    filal_folder_name=${filal_folder_name#*shuf_sample_list/}
    ## OG_cds_7_species_same_header_fas.537OG_1

    # Create the bootstrap folder for the current list of files
    mkdir -p ./bootstraps/$filal_folder_name/
#done
        ## read file list and copy the files to a directory
        while IFS= read -r file
            do
            #echo $file
            ## OG0008677.cds.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas

            # Create the target directory if it doesn't already exist
            mkdir -p ./bootstraps/$filal_folder_name/

            ## check if the file already exists in the target directory
            dest_file="./bootstraps/$filal_folder_name/$(basename $file)"

            ## initialize counter for remaining duplicates
            counter=1

            ## loop to rename the file if a file with the same name already exist
            while [ -e "$dest_file" ]
                do
                ## rename by adding a counter suffix (e.g., file_1.fas, file_2.fas, etc.)
                dest_file="./bootstraps/$filal_folder_name/$(basename ${file%.fas})_$counter.fas"
                counter=$((counter + 1))
            done
            ## OG0008677.cds.7_species.trimmed.trimmed_stop_codon.prank_codon.iterate2.same_header.fas OG_cds_7_species_same_header_fas.shuf_537OG_202
            
            ## copy file to destination folder
            cp "$file" "$dest_file"
            echo "Copied $file to $dest_file"
        done < $folder_name
    ## read the fas files from each bootstrap folder and output concatenated alignment sequences to bootstrap folder
    $catfasta2phyml -ps ./bootstraps/$filal_folder_name/OG*cds.7_species*iterate2.same_header*.fas > ./bootstraps/cat.out.$filal_folder_name.phy
    $catfasta2phyml -f ./bootstraps/$filal_folder_name/OG*cds.7_species*iterate2.same_header*.fas > ./bootstraps/cat.out.$filal_folder_name.fas
done

********** run condeml two groups of species **********
## activate env
conda activate myproject

## 8_bom_apis
template_codeml_ctl=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j/bee_work/boostrap_dS/codeml_8_bom_apis_211OG_bootstrap.test_0.ctl
boostrap_dS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j/bee_work/boostrap_dS
cd $boostrap_dS_dir

## n, the number of OGs
for n in $(seq 1 1000)
    do
    mkdir "./bom_apis_8/codeml_8_bom_apis_211OG_bootstrap_$n"
    cp codeml_8_bom_apis_211OG_bootstrap.test_0.ctl "./bom_apis_8/codeml_8_bom_apis_211OG_bootstrap_$n/codeml.dS.ctl"
    ## go to specific bootstrap folder
    cd "./bom_apis_8/codeml_8_bom_apis_211OG_bootstrap_$n"
    ## global replacement of bootstrap numbers
    sed -i "s/shuf_211OG_0/shuf_211OG_$n/g" codeml.dS.ctl
    ## calculate dS
    codeml codeml.dS.ctl
    ## go back to the main bootstrap folder
    cd $boostrap_dS_dir
done

## 7_and_pas
template_codeml_ctl=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j/bee_work/boostrap_dS/codeml_7_and_pas_537OG_bootstrap.test_0.ctl
boostrap_dS_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/software/paml_mcmctree/paml4.9j/bee_work/boostrap_dS
cd $boostrap_dS_dir

## n, the number of OGs
for n in $(seq 1 1000)
    do
    mkdir "./and_pas_7/codeml_7_and_pas_537OG_bootstrap_$n"
    cp codeml_7_and_pas_537OG_bootstrap.test_0.ctl "./and_pas_7/codeml_7_and_pas_537OG_bootstrap_$n/codeml.dS.ctl"
    ## go to specific bootstrap folder
    cd "./and_pas_7/codeml_7_and_pas_537OG_bootstrap_$n"
    ## global replacement of bootstrap numbers
    sed -i "s/shuf_537OG_0/shuf_537OG_$n/g" codeml.dS.ctl
    ## calculate dS
    codeml codeml.dS.ctl
    ## go back to the main bootstrap folder
    cd $boostrap_dS_dir
done


********** extract dS from condeml run **********
## create dataframe of dS from 1000 bootstraps
## create a temporary directory for dS extraction
cd $boostrap_dS
mkdir -p temp

## change species folders
#cd ./bom_apis_8/
cd ./and_pas_7/

## use index for each bootstrap
index=0
for dS in $(find . -type f -name 'rst')
do
#echo $dS
## ./codeml_8_bom_apis_211OG_bootstrap.test_2/rst
((index++))
#done
## delete strings before rst
out_name=${dS#*/rst}
#echo "bom_apis_8.rst$out_name"_"$index"
echo "and_pas_7.rst$out_name"_"$index"

## read just the 6th column of dS
#awk 'NR > 5 && NR < 34 {print $6}' OFS="\t" $dS > ../temp_dS/"bom_apis_8.rst$out_name"_"$index".dS.temp
awk 'NR > 5 && NR < 34 {print $6}' OFS="\t" $dS > ../temp_dS/"and_pas_7.rst$out_name"_"$index".dS.temp

done

## combine each dS
#paste ../temp_dS/bom_apis_8*.dS.temp > ../combined_1000_bootstraps.bom_apis_8.dS
paste ../temp_dS/and_pas_7*.dS.temp > ../combined_1000_bootstraps.and_pas_7.dS

********** calculator 95% bootstrap **********
conda activate myproject
ci_calculator_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/9_CI_calculator.py
chmod +x $ci_calculator_py
python $ci_calculator_py -h
python ci_calculator.py <input_file> <output_file>

cd $boostrap_dS

## bom_apis
python $ci_calculator_py combined_1000_bootstraps.bom_apis_8.dS combined_1000_bootstraps.bom_apis_8.95p.dS

paste <(echo -e "S_1\tS_2"; awk 'NR > 5 && NR < 34 {print $1,$2}' OFS="\t" ./bom_apis_8/codeml_8_bom_apis_211OG_bootstrap_1/rst) \
    combined_1000_bootstraps.bom_apis_8.95p.dS > combined_1000_bootstraps.bom_apis_8.95p.final.dS

## and_pas
python $ci_calculator_py combined_1000_bootstraps.and_pas_7.dS combined_1000_bootstraps.and_pas_7.95p.dS

paste <(echo -e "S_1\tS_2"; awk 'NR > 5 && NR < 34 {print $1,$2}' OFS="\t" ./and_pas_7/codeml_7_and_pas_537OG_bootstrap_1/rst) \
    combined_1000_bootstraps.and_pas_7.95p.dS > combined_1000_bootstraps.and_pas_7.95p.final.dS


**********                  fossile calibrated dating                         **********
********** 4_6_trim_stop_codon_concatenate_seq_align_divide_codon_by_position **********
## go here
4_6_trim_stop_codon_concatenate_seq_align_divide_codon_by_position.sh
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_time/4_6_trim_stop_codon_concatenate_seq_align_divide_codon_by_position.sh
