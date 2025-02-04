import sys
from Bio import SeqIO

def divide_codons_by_position(input_file, output_files):
    # Open output files for writing
    with open(output_files[0], 'w') as codon1, open(output_files[1], 'w') as codon2, open(output_files[2], 'w') as codon3:
        # Parse the input FASTA file
        for record in SeqIO.parse(input_file, "fasta"):
            # Get the sequence of the current record
            sequence = str(record.seq)
            
            # Initialize codon position sequences
            codon1_seq = []
            codon2_seq = []
            codon3_seq = []
            
            # Go through the sequence in triplets, ignoring gaps
            for i in range(0, len(sequence), 3):
                codon = sequence[i:i+3]  # Get the codon triplet (or less if at the end)
                
                # Skip codons with gaps
                if '-' not in codon:
                    if len(codon) > 0: codon1_seq.append(codon[0])  # 1st codon position
                    if len(codon) > 1: codon2_seq.append(codon[1])  # 2nd codon position
                    if len(codon) > 2: codon3_seq.append(codon[2])  # 3rd codon position
            
            # Join the lists into strings
            codon1_seq = ''.join(codon1_seq)
            codon2_seq = ''.join(codon2_seq)
            codon3_seq = ''.join(codon3_seq)
            
            # Write to corresponding files
            codon1.write(f">{record.id}\n{codon1_seq}\n")
            codon2.write(f">{record.id}\n{codon2_seq}\n")
            codon3.write(f">{record.id}\n{codon3_seq}\n")

# Get input and output file paths from terminal arguments
if len(sys.argv) < 5:
    print("Usage: python script.py <input_fasta> <codon1_output> <codon2_output> <codon3_output>")
    sys.exit()

input_fasta = sys.argv[1]
output_files = [sys.argv[2], sys.argv[3], sys.argv[4]]

# Split the codons by position
divide_codons_by_position(input_fasta, output_files)
