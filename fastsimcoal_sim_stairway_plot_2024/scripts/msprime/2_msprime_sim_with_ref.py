# conda activate bioproject
# cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes
import msprime
import numpy as np
import tskit
import random

# Define parameters
sample_size = 100  # Number of haploid individuals
mutation_rate = 2.9e-9  # Mutation rate per site per generation
recombination_rate = 2.0e-9  # Recombination rate per site per generation

# Define chromosome sizes and names
chromosome_sizes = [100000000, 100000000, 150000000, 150000000, 100000000, 
                    100000000, 100000000, 100000000, 100000000, 100000000]  # Sizes for 10 chromosomes
chromosome_names = [str(i+1) for i in range(1)]  # Names as strings "1" to "10"

# Define nucleotide composition (equal proportions of A, T, C, G)
nucleotides = ["A", "T", "C", "G"]

# Function to generate a random sequence
def generate_sequence(length):
    return "".join(random.choices(nucleotides, k=length))

'''# Generate the reference genome and save it to a FASTA file
reference_genome = {}
with open("reference_genome.fasta", "w") as fasta_file:
    for name, size in zip(chromosome_names, chromosome_sizes):
        # Generate a random sequence for the chromosome
        sequence = generate_sequence(size)
        # Store the sequence in the reference genome dictionary
        reference_genome[name] = sequence
        # Write the chromosome to the FASTA file
        fasta_file.write(f">{name}\n")  # Write the header
        fasta_file.write(sequence + "\n")  # Write the sequence
'''
# Load the reference genome into a dictionary
reference_genome = {}
with open("reference_genome.fasta", "r") as fasta_file:
    current_chr = None
    for line in fasta_file:
        if line.startswith(">"):
            current_chr = line.strip().split(">")[1]
            reference_genome[current_chr] = ""
        else:
            reference_genome[current_chr] += line.strip()

# Define demographic model
demography = msprime.Demography()
demography.add_population(name="pop", initial_size=200000)  # Initial population size

# Add events in reverse chronological order (most recent to oldest)

# Exponential decrease from 4,000 generations ago to present
final_population_size = 1000
growth_rate_decrease = np.log(final_population_size / 200000) / 4000  # Growth rate for exponential decrease
demography.add_population_parameters_change(time=4000, growth_rate=growth_rate_decrease, population="pop")

# Stable population size from 12,000 to 4,000 generations ago
demography.add_population_parameters_change(time=12000, growth_rate=0, population="pop")

# Exponential growth from 12,000 generations ago to Nt = 200,000
# Growth rate is calculated as: r = ln(Nt / N0) / t
growth_rate = np.log(200000 / 1000) / (12000 - 4000)  # Growth rate for exponential increase
demography.add_population_parameters_change(time=12000, growth_rate=growth_rate, population="pop")

# Bottleneck at 12,000 generations ago
demography.add_population_parameters_change(time=12000, initial_size=1000, population="pop")

# Simulate for each chromosome
ts_list = []
for i, size in enumerate(chromosome_sizes):
    # Simulate ancestry
    ts = msprime.sim_ancestry(
        samples=sample_size,
        demography=demography,
        sequence_length=size,
        recombination_rate=recombination_rate,
        ploidy=1  # Haploid
    )
    
    # Simulate mutations using the reference genome as the ancestral state
    tables = ts.dump_tables()
    for site in tables.sites:
        # Get the position of the site
        pos = int(site.position)
        # Get the ancestral state from the reference genome
        ancestral_state = reference_genome[chromosome_names[i]][pos - 1]  # Positions are 1-based in VCF
        # Update the ancestral state in the site table
        site.ancestral_state = ancestral_state
        site.derived_state = ancestral_state  # Default derived state (can be updated later)
    # Rebuild the tree sequence
    ts = tables.tree_sequence()
    
    # Simulate mutations
    ts = msprime.sim_mutations(ts, rate=mutation_rate)
    ts_list.append(ts)
    
    # Optionally, write each tree sequence to a separate VCF file
    with open(f"chromosome_{chromosome_names[i]}.vcf", "w") as vcf_file:
        ts.write_vcf(vcf_file, contig_id=chromosome_names[i])

# Combine tree sequences into a single tree sequence
combined_tables = ts_list[0].tables.copy()
for ts in ts_list[1:]:
    # Append tables
    combined_tables.nodes.append_columns(
        flags=ts.tables.nodes.flags,
        time=ts.tables.nodes.time,
        population=ts.tables.nodes.population,
        individual=ts.tables.nodes.individual,
        metadata=ts.tables.nodes.metadata,
        metadata_offset=ts.tables.nodes.metadata_offset,
    )
    combined_tables.edges.append_columns(
        left=ts.tables.edges.left,
        right=ts.tables.edges.right,
        parent=ts.tables.edges.parent,
        child=ts.tables.edges.child,
    )
    combined_tables.sites.append_columns(
        position=ts.tables.sites.position,
        ancestral_state=ts.tables.sites.ancestral_state,
        ancestral_state_offset=ts.tables.sites.ancestral_state_offset,
        metadata=ts.tables.sites.metadata,
        metadata_offset=ts.tables.sites.metadata_offset,
    )
    combined_tables.mutations.append_columns(
        site=ts.tables.mutations.site,
        node=ts.tables.mutations.node,
        derived_state=ts.tables.mutations.derived_state,
        derived_state_offset=ts.tables.mutations.derived_state_offset,
        parent=ts.tables.mutations.parent,
        metadata=ts.tables.mutations.metadata,
        metadata_offset=ts.tables.mutations.metadata_offset,
    )

# Sort edges by (time[parent], child, left)
combined_tables.sort()

# Validate the combined tables to ensure correctness
combined_tables.check_integrity()

# Build the combined tree sequence
combined_ts = combined_tables.tree_sequence()

# Write the combined tree sequence to a single VCF file
with open("combined_simulated_population.vcf", "w") as vcf_file:
    combined_ts.write_vcf(vcf_file, chromosome=chromosome_names)  # Use chromosome for multiple chromosomes