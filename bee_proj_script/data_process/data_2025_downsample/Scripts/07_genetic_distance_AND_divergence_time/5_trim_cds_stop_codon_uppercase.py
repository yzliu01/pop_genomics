import argparse
from Bio import SeqIO
from Bio.Seq import Seq

def replace_terminal_stop_codons(input_file, output_file):
    stop_codons = ["TAA", "TAG", "TGA"]
    
    with open(output_file, "w") as out_handle:
        for record in SeqIO.parse(input_file, "fasta"):
            sequence = str(record.seq).upper()  # Convert sequence to uppercase
            
            # Check if the sequence ends with a stop codon
            for stop_codon in stop_codons:
                if sequence.endswith(stop_codon):
                    sequence = sequence[:-3] + "NNN"
                    break  # Only replace the first matching stop codon at the end
            
            # Update the record's sequence with the modified one
            record.seq = Seq(sequence)  # Assigning the modified sequence back
            
            # Write the modified sequence to the output file
            SeqIO.write(record, out_handle, "fasta")
    
    print(f"Sequences with terminal stop codons replaced saved to {output_file}")

def main():
    # Setup argparse to take input and output files from the command line
    parser = argparse.ArgumentParser(description="Replace terminal stop codons (TAA, TAG, TGA) with NNN, handling both upper and lowercase sequences.")
    parser.add_argument("-i", "--input", required=True, help="Input FASTA file")
    parser.add_argument("-o", "--output", required=True, help="Output FASTA file")

    args = parser.parse_args()

    # Call the function to replace stop codons
    replace_terminal_stop_codons(args.input, args.output)

if __name__ == "__main__":
    main()
