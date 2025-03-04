# conda activate bioproject
# cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/simulated_reference_genomes

import numpy as np
import msprime
import demes
import demesdraw
import matplotlib.pyplot as plt

import tskit
import random

# how to use msprime to simulate a bottleneck at 12000 generations ago and a exponential increase
# from 12000 generations ago to Nt of 200000 at 8000 generations ago, kept stable till from 8000 to 4000 generations ago followed by 
# a exponential decrease till 1000 generations ago to present. I want to simulate sequences for a sample size 
# 100 haploid individuals at a mutation rate and recombination rate for 10 chromosome 
# with chr names in numbers and with each having different size, and output to a vcf file

# Define parameters
sample_size = 100  # Number of haploid individuals
mutation_rate = 2.9e-9  # Mutation rate per site per generation
recombination_rate = 2.0e-9  # Recombination rate per site per generation

# Define chromosome sizes and names
chromosome_sizes = [100000000, 100000000, 150000000, 150000000, 100000000, 
                    100000000, 100000000, 100000000, 100000000, 100000000]  # Sizes for 10 chromosomes
chromosome_names = [str(i+1) for i in range(10)]  # Names as strings "1" to "10"

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
   
# Initialize demography (older to recent) in complex way         
'''
demography = msprime.Demography()
demography.add_population(name="pop", initial_size=10_000)

# Bottleneck at 12,000 generations ago (Ne = 1,000), explicitly setting growth_rate=0
demography.add_population_parameters_change(time=12_000, initial_size=1_000, growth_rate=0, population="pop")

# Exponential increase from 12,000 to 8,000 generations ago (1,000 → 200,000)
growth_rate_increase = np.log(200_000 / 1_000) / (12_000 - 8_000)
demography.add_population_parameters_change(time=8_000, growth_rate=growth_rate_increase, population="pop")

# Stable population from 8,000 to 4,000 generations ago (Ne = 200,000)
demography.add_population_parameters_change(time=4_000, initial_size=200_000, growth_rate=0, population="pop")

# Exponential decrease from 4,000 generations ago to present (200,000 → 10,000)
growth_rate_decrease = np.log(10_000 / 200_000) / 4_000
demography.add_population_parameters_change(time=0, growth_rate=growth_rate_decrease, population="pop")

# Sort events to ensure chronological order
demography.sort_events()
'''

'''
So the timeline is:
From time T=infinity to T=12000: size 1000 (constant).
T=12000 to T=8000: exponential growth from 1000 to 200000.
T=8000 to T=4000: constant 200000.
T=4000 to T=1000: exponential decline from 200000 to 10000.
T=1000 to T=0: constant 10000.

'''

# Initialize demography in chronological time order - complex way

demography = msprime.Demography()

# Stable size from 1,000 generations ago to present (10,000 → 10,000)
demography.add_population(name="pop", initial_size=10_000)

# Exponential decrease from 4,000 generations ago to 1,000 (200,000 → 10,000)
# Growth rate is calculated as: r = ln(Nt / N0) / t
growth_rate_decrease = np.log(10_000 / 200_000) / (4_000 - 1_000)
demography.add_population_parameters_change(time=1_000, growth_rate=growth_rate_decrease, population="pop")

# Stable population from 8,000 to 4,000 generations ago (Ne = 200,000)
demography.add_population_parameters_change(time=4_000, initial_size=200_000, growth_rate=0, population="pop")

# Exponential increase from 12,000 to 8,000 generations ago (1,000 → 200,000)
# Growth rate is calculated as: r = ln(Nt / N0) / t
growth_rate_increase = np.log(200_000 / 1_000) / (12_000 - 8_000)
demography.add_population_parameters_change(time=8_000, growth_rate=growth_rate_increase, population="pop")

# Bottleneck at 12,000 generations ago (Ne = 1,000), explicitly setting growth_rate=0
demography.add_population_parameters_change(time=12_000, initial_size=1_000, growth_rate=0, population="pop")

'''
# visualize dem
graph2 = msprime.Demography.to_demes(demography)
fig, ax = plt.subplots()  # use plt.rcParams["figure.figsize"]
demesdraw.tubes(graph2, ax=ax, seed=1)
# Save the plot as a PDF file
#plt.savefig("demography_plot.pdf", format="pdf", bbox_inches="tight")

# Optionally, display the plot (if you want to see it in your environment)
plt.show()

'''

## save below in ymal file
'''
## define demography using ymal
## KeyError: "demes[0] pop: epochs[0]: unexpected field: 'growth_rate'. Allowed fields are: ['end_time', 'start_size', 'end_size', 'size_function', 'cloning_rate', 'selfing_rate']"

## The demographic model should strictly follow chronological order (oldest to newest)

description: "Demographic model with a bottleneck, exponential growth, stability, and exponential decline"
time_units: generations
demes:
  - name: pop
    description: "A single population with varying size over time"
    epochs:
      # Bottleneck at 12,000 generations ago (Ne = 1,000)
      - end_time: 12000
        start_size: 1000
        size_function: constant

      # Exponential increase from 12,000 to 8,000 generations ago (1,000 → 200,000)
      - end_time: 8000
        start_size: 1000
        end_size: 200000
        size_function: exponential

      # Stable from 8,000 to 4,000 generations ago (Ne = 200,000)
      - end_time: 4000
        start_size: 200000
        size_function: constant

      # Exponential decline from 4,000 to 1,000 generations ago (200,000 → 10,000)
      - end_time: 1000
        start_size: 200000
        end_size: 10000
        size_function: exponential

      # Stable from 1,000 generations ago to present (Ne = 10,000)
      - end_time: 0
        start_size: 10000
        size_function: constant

'''    

# Load the demographic model from the YAML file
'''
with open("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/fsc_sim_stairway/scripts/msprime/10000Ne_dem.yml", "r") as yaml_file:
    graph = demes.load(yaml_file)
'''
'''
# Convert the demes graph to msprime demography
demography = msprime.Demography.from_demes(graph)

# Sort events to ensure chronological order
#demography.sort_events()

# Visualize the demographic model
fig, ax = plt.subplots(figsize=(6, 5))
demesdraw.tubes(graph, ax=ax, seed=1)

# Save the plot as a PDF file
plt.savefig("demography_plot.pdf", format="pdf", bbox_inches="tight")

# Optionally, display the plot (if you want to see it in your environment)
plt.show()

'''

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
    with open(f"chr_{chromosome_names[i]}.vcf", "w") as vcf_file:
        ts.write_vcf(vcf_file, contig_id=chromosome_names[i])

'''
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

'''