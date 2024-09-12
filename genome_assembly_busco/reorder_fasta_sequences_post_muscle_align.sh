#!/bin/bash

# File containing the desired order of headers
## header_order="header_order.txt"
header_order="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/taxa_name_order.list"
# Directory containing the FASTA files
## fasta_dir="path_to_your_fasta_files"
fasta_dir="/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/reorder_test_summary"

# Loop through each FASTA file in the directory
for fasta_file in "$fasta_dir"/*.fasta; do
    # Output file name
    output_file=$fasta_dir/"reordered_$(basename "$fasta_file")"
    
    # Create a temporary file to hold the reordered sequences
    temp_file=$(mktemp)

    # Loop through each header in the order file
    while IFS= read -r header; do
        # Extract the sequence corresponding to the current header
        awk -v header=">$header" 'BEGIN {found=0} $0 ~ header {found=1; print $0; next} 
            /^>/ && found {found=0} found {print $0}' "$fasta_file" >> "$temp_file"
    done < "$header_order"

    # Move the reordered sequences to the output file
    mv "$temp_file" "$output_file"
    echo "Reordered sequences saved to $output_file"
done


# how to use it
# make the script executable: chmod +x /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/reorder_fasta_sequences.sh
#copy the dir and paste it in the terminal
# /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/genome_assembly_busco/reorder_fasta_sequences.sh