#!/bin/bash

# Usage: ./extract_clean_cds.sh genome.fasta annotations.gff output_cds.fasta cleaned_cds.fasta

# Input parameters
GENOME_FASTA=$1
GFF_FILE=$2
OUTPUT_CDS_FASTA=$3
CLEANED_CDS_FASTA=$4

***********   revision ***********
conda activate myproject

test_folder=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/busco/test/busco_species_single_copy_complete_CDS/shared_CDS_with_M_seq_align/test
#cd $test_folder/And_bic_10027at7399_busco
cd $test_folder/Apis_mel_10027at7399_busco

GFF_FILE=$test_folder/Apis_mel_10027at7399_busco/10027at7399.gff
#GFF_FILE=$test_folder/And_bic_10027at7399_busco/10027at7399.gff
ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
GENOME_FASTA=$ref_dir/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
#GENOME_FASTA=$ref_dir/Andrena_bicolor-GCA_960531205.1.fa

#gffread_output=${gff_species/gff/gff.gffread.fa}
#gffread -w $gffread_output -g $ref_apis_mel $gff_species

OUTPUT_CDS_FASTA=${GFF_FILE/gff/gff.gffread_cds.fa}
#gffread -x $OUTPUT_CDS_FASTA -g $GENOME_FASTA $GFF_FILE


# Step 1: Extract CDS sequences using gffread
echo "Extracting CDS sequences from GFF file..."
gffread -x $OUTPUT_CDS_FASTA -g $GENOME_FASTA $GFF_FILE

************** check ORF **************
# Step 2: Remove sequences with internal stop codons
echo "Removing internal stop codons from extracted CDS sequences..."

# Create a temporary file to store sequences without internal stop codons
TEMP_FILE=$(mktemp)

# Define stop codons (assuming standard genetic code)
STOP_CODONS=("TGA" "TAA" "TAG")

# Function to check for internal stop codons and filter sequences
check_internal_stops() {
    local has_stop=0

    # Check for internal stop codons
    for stop_codon in "${STOP_CODONS[@]}"; do
        if echo "$seq" | grep -q "$stop_codon"; then
            has_stop=1
            break
        fi
    done

    return $has_stop
}

# Read the extracted CDS FASTA file
header=""
seq=""
while read -r line; do
    if [[ $line == ">"* ]]; then
        # If a sequence has been accumulated, check for internal stops
        if [[ -n $seq ]]; then
            check_internal_stops
            if [[ $? -eq 0 ]]; then
                # No internal stop codons, write to temp file
                echo "$header" >> $TEMP_FILE
                echo "$seq" >> $TEMP_FILE
            fi
        fi
        # Start new sequence
        header=$line
        seq=""
    else
        # Accumulate sequence lines
        seq+=$line
    fi
done < $OUTPUT_CDS_FASTA

# Check the last sequence
if [[ -n $seq ]]; then
    check_internal_stops
    if [[ $? -eq 0 ]]; then
        echo "$header" >> $TEMP_FILE
        echo "$seq" >> $TEMP_FILE
    fi
fi

# Step 3: Rename the temporary file to the final output
mv $TEMP_FILE $CLEANED_CDS_FASTA

echo "Cleaned CDS sequences without internal stop codons saved to $CLEANED_CDS_FASTA"