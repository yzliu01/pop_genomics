#!/bin/bash


# File containing the desired order of headers
## header_order="header_order.txt"
header_order="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/hifi_asm/Bom_vet_fasta_headers.list"
# Directory containing the FASTA files
## fasta_dir="path_to_your_fasta_files"
fasta_dir="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome"
cd $fasta_dir
# Loop through each FASTA file in the directory
for fasta_file in "$fasta_dir"/Bombus_veteranus*.hifi_asm_pl2.fa; do
    # Output file name
    output_file=$fasta_dir/"reordered_$(basename "$fasta_file")"
    # basename command prints NAME with any leading directory components removed.
    # If specified, also remove a trailing SUFFIX.
    
    # Create a temporary file to hold the reordered sequences
    temp_file=$(mktemp)
    # echo $temp_file
    # /tmp/tmp.Z81viG00Ue

    # Loop through each header in the order file
    while IFS= read -r header; do # header is the variable like line
        # Extract the sequence corresponding to the current header
        echo $header
        awk -v header=">$header" 'BEGIN {found=0} $0 ~ header {found=1; print $0; next} 
            /^>/ && found {found=0} found {print $0}' "$fasta_file" >> "$temp_file"
        head -2 $temp_file
    done < "$header_order"

    # Move the reordered sequences to the output file
    mv "$temp_file" "$output_file"
    echo "Reordered sequences saved to $output_file"
done


# how to use it
# make the script executable: chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/reorder_fasta_sequences.sh
#copy the dir and paste it in the terminal
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/reorder_fasta_sequences.sh

**************** worked **************

#!/bin/bash

# Define the input and output files
input_fasta="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2.fa"
output_fasta="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_veteranus.hifi_asm_pl2.sorted.fa"

# Reorder the fasta sequences by their header names
awk '/^>/ {if (seq) print seq; print; seq=""} /^[^>]/ {seq = seq $0} END {if (seq) print seq}' $input_fasta \
| paste - - \
| sort -k1,1 \
| tr "\t" "\n" \
> $output_fasta

echo "FASTA sequences have been reordered by header and saved in $output_fasta"


## use bioawk and seqkit
# https://bioinformaticsworkbook.org/Appendix/Unix/bioawk-basics.html#gsc.tab=0
conda install bioawk
# https://bioinf.shenwei.me/seqkit/usage/
conda install -c bioconda seqkit

Ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/
bioawk -c fastx '{print $name,length($seq)}' Gerris_lacustris-GCA_951217055.1-softmasked.fa

# 3. sort by ID, ignoring case.

echo -e ">seq1\nACGTNcccc\n>seq3\natcgaac\n>SEQ2\nacgtnAAAA" \
    | seqkit sort -Ni
[INFO] read sequences ...
[INFO] 3 sequences loaded
[INFO] sorting ...
[INFO] output ...
>seq1
ACGTNcccc
>SEQ2
acgtnAAAA
>seq3
atcgaa


echo -e ">seq1\nACGTNcccc\n>seq3\natcgaac\n>SEQ2\nacgtnAAAA" \
    | seqkit sort -Ni --quiet
    
>seq1
ACGTNcccc
>SEQ2
acgtnAAAA
>seq3
atcgaac
