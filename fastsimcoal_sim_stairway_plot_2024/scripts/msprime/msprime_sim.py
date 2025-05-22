## run msprime
# conda activate bioproject

# how to use msprime to simulate a bottleneck at 12000 generations ago and a exponential increase from 12000 generations ago to Nt of 200000, kept stable till 4000 generations ago followed by a exponential decrease till present. I want to simulate sequences for a sample size 100 haploid individuals at a mutation rate and recombination rate for 10 chromosome with chr names in numbers and with each having different size, and output to a vcf file
import msprime
import numpy as np  # Import numpy for mathematical operations
import tskit  # Import tskit for concatenating tree sequences

# Define parameters
sample_size = 100  # Number of haploid individuals
#mutation_rate = 1e-8  # Mutation rate per site per generation
#recombination_rate = 1e-8  # Recombination rate per site per generation

mutation_rate = 2.9e-9  # Mutation rate per site per generation; https://doi.org/10.1093/molbev/msu302
recombination_rate = 2.0e-9  # Recombination rate per site per generation; https://genome.cshlp.org/content/33/4/587; https://doi.org/10.1146/annurev-genet-111523-102550

# Define chromosome sizes and names
#chromosome_sizes = [1000000, 1500000, 2000000, 2500000, 3000000, 
#                    3500000, 4000000, 4500000, 5000000, 5500000]  # Sizes for 10 chromosomes
chromosome_sizes = [100000000, 100000000, 150000000, 150000000, 100000000, 
                    100000000, 100000000, 100000000, 100000000, 100000000]  # Sizes for 10 chromosomes
chromosome_names = [str(i+1) for i in range(10)]  # Names as strings "1" to "10"

# Define demographic model
demography = msprime.Demography()
demography.add_population(name="pop", initial_size=200000)  # Initial population size

# Add events in reverse chronological order (most recent to oldest)

# Exponential decrease from 4,000 generations ago to present
# Final population size is set to 1000 (for example)
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

'''
for size in chromosome_sizes:
    ts = msprime.sim_ancestry(
        samples=sample_size,
        demography=demography,
        sequence_length=size,
        recombination_rate=recombination_rate,
        ploidy=1  # Haploid
    )
    ts = msprime.sim_mutations(ts, rate=mutation_rate)
    ts_list.append(ts)

# Combine chromosome simulations into a single tree sequence using tskit
combined_ts = tskit.concat(ts_list)

# Write to VCF file
with open("simulated_population.vcf", "w") as vcf_file:
    combined_ts.write_vcf(vcf_file, chromosome_names=chromosome_names)
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
    

'''

# Simulate for each chromosome
ts_list = []
for size in chromosome_sizes:
    ts = msprime.sim_ancestry(
        samples=sample_size,
        demography=demography,
        sequence_length=size,
        recombination_rate=recombination_rate,
        ploidy=1  # Haploid
    )
    ts = msprime.sim_mutations(ts, rate=mutation_rate)
    ts_list.append(ts)

# Combine chromosome simulations into a single tree sequence
combined_ts = msprime.concat(ts_list)

# Write to VCF file
with open("simulated_population.vcf", "w") as vcf_file:
    combined_ts.write_vcf(vcf_file, chromosome_names=chromosome_names)

'''


'''
To simulate the demographic history you described using msprime, we will:

    Define the demographic model:

        A bottleneck at 12,000 generations ago.

        Exponential population growth from 12,000 generations ago to a population size of 200,000.

        Stable population size from 12,000 to 4,000 generations ago.

        Exponential decrease from 4,000 generations ago to the present.

    Simulate sequences for 100 haploid individuals with a specified mutation rate and recombination rate for 10 chromosomes of different sizes.

    Output the results to a VCF file.


Explanation of the Code

    Demographic Model:

        A bottleneck is simulated at 12,000 generations ago by reducing the population size to 1,000.

        Exponential growth is modeled from 12,000 generations ago to a population size of 200,000.

        The population remains stable at 200,000 from 12,000 to 4,000 generations ago.

        Exponential decrease is modeled from 4,000 generations ago to the present, with the population size decreasing to 1,000.

    Chromosome Simulation:

        Each chromosome is simulated separately with its own size and recombination rate.

        The msprime.concat function combines the tree sequences of all chromosomes into a single tree sequence.

    VCF Output:

        The combined tree sequence is written to a VCF file, with chromosome names specified.

Key Parameters

    Sample Size: 100 haploid individuals.

    Mutation Rate: 1e-8 per site per generation.

    Recombination Rate: 1e-8 per site per generation.

    Chromosome Sizes: Defined as a list of lengths for 10 chromosomes.

    Chromosome Names: Named as "1" to "10".

Output

The output will be a VCF file (simulated_population.vcf) containing the simulated variants for the 100 haploid individuals across the 10 chromosomes.
Notes

    Adjust the mutation_rate, recombination_rate, and chromosome_sizes as needed.

    The growth_rate for exponential increase and decrease is calculated using the formula:
    r=ln⁡(Nt/N0)t
    r=tln(Nt​/N0​)​

    where NtNt​ is the final population size, N0N0​ is the initial population size, and tt is the time interval.

Let me know if you need further clarification or adjustments!

'''