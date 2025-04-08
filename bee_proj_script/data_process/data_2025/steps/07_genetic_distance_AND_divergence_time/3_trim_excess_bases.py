import sys
from Bio import SeqIO

def trim_excess_bases(alignment_file, output_file):
    with open(alignment_file, "r") as infile, open(output_file, "w") as outfile:
        for record in SeqIO.parse(infile, "fasta"):
            sequence = str(record.seq)
            seq_len = len(sequence)
            trim_length = seq_len % 3
            if trim_length != 0:
                trimmed_seq = sequence[:-trim_length]
                print(f"Sequence {record.id} has excess {trim_length} base(s). Original length: {seq_len}, Trimmed length: {len(trimmed_seq)}")
            else:
                trimmed_seq = sequence
            
            # Write trimmed sequence to output
            outfile.write(f">{record.id}\n{trimmed_seq}\n")

# Check if the input file is provided
if len(sys.argv) != 3:
    print("Usage: python trim_sequences.py <input_file> <output_file>")
    sys.exit(1)

# Get input and output file from command line
alignment_file = sys.argv[1]
output_file = sys.argv[2]

# Trim sequences and write to output file
trim_excess_bases(alignment_file, output_file)
