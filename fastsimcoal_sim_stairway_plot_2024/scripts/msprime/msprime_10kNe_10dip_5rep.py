
## call env in bash script not here
######### simulation of multiple chromosomes with 5 replicates #########
import tskit
import msprime
import numpy


import demes
## method II
yaml = """
time_units: generations
demes:
  - name: A
    epochs:
    - {end_time: 1000, start_size: 5000}
    - {end_time: 0, end_size: 10000}
"""
graph = demes.loads(yaml)
demography2 = msprime.Demography.from_demes(graph)

## two events (positive - recent expansion)
## https://github.com/tskit-dev/msprime/discussions/2250
## method II
#graph = demes.load("msprime_test.yaml")
#demography2 = msprime.Demography.from_demes(graph)

## You can then use a demographydebugger:
debug2 = demography2.debug()
print(debug2)

## to verify whether the specified model corresponds to what you intended.
## Alternatively, you could convert the demography object to a demes.graph using demography,to_demes()and use demesdraw to plot a visual representation (see here).
import demesdraw
import matplotlib.pyplot as plt
#graph = demography.to_demes()

## two events (negative - recent shrink)
#...
## two events (positive - recent expansion)
graph2 = msprime.Demography.to_demes(demography2)
fig, ax = plt.subplots()  # use plt.rcParams["figure.figsize"]
demesdraw.tubes(graph2, ax=ax, seed=1)
plt.show()

## multiple chromosomes and five replicates
import math
r_chrom = 8.9e-8
r_break = math.log(2)
chrom_positions = [0, 1.5e7, 3e7, 4.5e7, 6e7, 7.5e7, 9e7, 10.5e7, 12e7, 13.5e7, 15e7, 16.5e7, 18e7, 19.5e7, 21e7, 22.5e7, 24e7, 25.5e7, 27e7, 28.5e7, 30e7]
map_positions = [
    chrom_positions[0],
    chrom_positions[1],
    chrom_positions[1] + 1,
    chrom_positions[2],
    chrom_positions[2] + 1,
    chrom_positions[3],
    chrom_positions[3] + 1,
    chrom_positions[4],
    chrom_positions[4] + 1,
    chrom_positions[5],
    chrom_positions[5] + 1,
    chrom_positions[6],
    chrom_positions[6] + 1,
    chrom_positions[7],
    chrom_positions[7] + 1,
    chrom_positions[8],
    chrom_positions[8] + 1,
    chrom_positions[9],
    chrom_positions[9] + 1,
    chrom_positions[10],
    chrom_positions[10] + 1,
    chrom_positions[11],
    chrom_positions[11] + 1,
    chrom_positions[12],
    chrom_positions[12] + 1,
    chrom_positions[13],
    chrom_positions[13] + 1,
    chrom_positions[14],
    chrom_positions[14] + 1,
    chrom_positions[15],
    chrom_positions[15] + 1,
    chrom_positions[16],
    chrom_positions[16] + 1,
    chrom_positions[17],
    chrom_positions[17] + 1,
    chrom_positions[18],
    chrom_positions[18] + 1,
    chrom_positions[19],
    chrom_positions[19] + 1,
    chrom_positions[20]
]
rates = [r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom, r_break, r_chrom]
rate_map = msprime.RateMap(position=map_positions, rate=rates)

ts_5rep = msprime.sim_ancestry(
    samples=10,
    #population_size=10000, # specified in "demography.add_population"
    recombination_rate=rate_map,
    #start_time=1,
    #sequence_length=1.5e7,
    demography=demography2,
    ploidy=2,
    #num_replicates=5,
    model=[
        msprime.DiscreteTimeWrightFisher(duration=20),
        msprime.StandardCoalescent(),
    ],
    random_seed=1234,
)
ts_5rep
#type(ts_5rep)

## output simulated data in vcf format
## diploid
def write_vcf_dip(mts, output):
    with open(output, "w") as vcf_file:
        mts.write_vcf(vcf_file)

## make 5 replicates
for rep in range(1,6):
    mts = msprime.sim_mutations(ts_5rep, rate=3.6e-9, random_seed=rep)
    write_vcf_dip(mts, "one_pop_msprime_sim_5rep_20chr_mu36e9_re89e8_" + str(rep) + ".vcf")

## exit from the following command
exit()

## Example 2: simulating without a pedigree
r_chrom = 8.9e-8
r_break = math.log(2)
chrom_positions = [0, 1e6, 2e6, 3e6]
map_positions = [
    chrom_positions[0],
    chrom_positions[1],
    chrom_positions[1] + 1,
    chrom_positions[2],
    chrom_positions[2] + 1,
    chrom_positions[3]
]
rates = [r_chrom, r_break, r_chrom, r_break, r_chrom]
rate_map = msprime.RateMap(position=map_positions, rate=rates)

ts = msprime.sim_ancestry(
    10,
    #population_size=1000,
    recombination_rate=rate_map,
    demography=demography2,
    model=[
        msprime.DiscreteTimeWrightFisher(duration=20),
        msprime.StandardCoalescent(),
    ],
    random_seed=1234,
)
ts
type(ts)

## diploid sample
def write_vcf_dip(mts, output):
    with open(output, "w") as vcf_file:
        mts.write_vcf(vcf_file)
## single replicate
mts = msprime.sim_mutations(ts, rate=3.6e-9, random_seed=1)
write_vcf_dip(mts, "one_pop_msprime_sim_1rep_3chr_re89e_mu36e.vcf")

## make 5 replicates
for rep in range(1,6):
    mts = msprime.sim_mutations(ts, rate=1e-6, random_seed=rep)
    write_vcf_dip(mts, "one_pop_msprime_sim_3chr_1rep_1e6_" + str(rep) + ".vcf")
