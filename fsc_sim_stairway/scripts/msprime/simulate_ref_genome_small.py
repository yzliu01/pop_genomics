import random

# Define chromosome sizes and names
chromosome_sizes = [1000000, 1000000, 1500000, 1500000, 1000000, 
                    1000000, 1000000, 1000000, 1000000, 1000000]  # Sizes for 10 chromosomes
chromosome_names = [str(i+1) for i in range(10)]  # Names as strings "1" to "10"

# Function to generate random DNA sequence
def generate_dna_sequence(length):
    return "".join(random.choices("ACGT", k=length))

# Simulate reference genome
reference_genome = {}
for name, size in zip(chromosome_names, chromosome_sizes):
    reference_genome[name] = generate_dna_sequence(size)

# Write to FASTA file
with open("sim_reference_genome_11Mb.fasta", "w") as fasta_file:
    for name, sequence in reference_genome.items():
        fasta_file.write(f">{name}\n")
        fasta_file.write(sequence + "\n")
        
# it takes shortly