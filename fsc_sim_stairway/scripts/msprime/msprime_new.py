#####################
import tskit
import msprime
import numpy
import random
import math
****************************************************************************
#############   advice from the author of msprime #############
# https://tskit.dev/msprime/docs/latest/demography.html#sec-demography-events
# Population parameters change
# Demography.add_population_parameters_change()
# initial_size=5000

growth_r1=0.02
growth_r2=0.04
growth_r3=0
t1=100
t2=200
t3=500
N1 = 1000 / math.exp(-growth_r1 * t1)
N2 = 1000 / math.exp(-growth_r2 * t2)
N3 = 1000 / math.exp(-growth_r3 * t3)
print(N1,N2,N3)

*************************************************************************************
demography = msprime.Demography()
demography.add_population(name="A", initial_size=1000)
demography.add_population_parameters_change(time=100, growth_rate=0.03, population="A")
demography.add_population_parameters_change(time=200, growth_rate=-0.04,population="A")
demography.add_population_parameters_change(time=300, growth_rate=0.01, population="A")
demography.add_population_parameters_change(time=500, growth_rate=-0.04, population="A")
demography.add_population_parameters_change(time=600, growth_rate=0, population="A")
demography.debug()

# https://tskit.dev/msprime/docs/stable/api.html#msprime.Demography.add_population_parameters_change
# two events (negative - recent shrink)
demography1 = msprime.Demography()
demography1.add_population(name="A", initial_size=10000)
demography1.add_population_parameters_change(time=0.1, growth_rate=-0.0007, population="A")
demography1.add_population_parameters_change(time=1000, growth_rate=0, population="A")
demography1.debug()

# two events (positive - recent expansion)
demography2 = msprime.Demography()
demography2.add_population(name="A", initial_size=10000)
demography2.add_population_parameters_change(time=0.1, growth_rate=0.0007, population="A")
demography2.add_population_parameters_change(time=1000, growth_rate=0, population="A")
demography2.debug()

# You can then use a demographydebugger:
debug1 = demography1.debug()
print(debug1)

debug2 = demography2.debug()
print(debug2)
# to verify whether the specified model corresponds to what you intended.
# Alternatively, you could convert the demography object to a demes.graph using demography,to_demes()and use demesdraw to plot a visual representation (see here).
import demesdraw
import matplotlib.pyplot as plt
#graph = demography.to_demes()

# two events (negative - recent shrink)
graph1 = msprime.Demography.to_demes(demography1)
fig, ax = plt.subplots()  # use plt.rcParams["figure.figsize"]
demesdraw.tubes(graph1, ax=ax, seed=1)
plt.show()

# two events (positive - recent expansion)
graph2 = msprime.Demography.to_demes(demography2)
fig, ax = plt.subplots()  # use plt.rcParams["figure.figsize"]
demesdraw.tubes(graph2, ax=ax, seed=1)
plt.show()

# Then simulate with:
ts = msprime.sim_ancestry(
    samples=30, 
    sequence_length=10e6,
    demography=demography,
    ploidy=2,
    recombination_rate=1e-8,
    random_seed=1
)

#### formal sim Dec 2023
## negative - shrink
ts = msprime.sim_ancestry(
    samples=20, 
    sequence_length=1.5e7,
    demography=demography1,
    ploidy=2,
    recombination_rate=8.9e-8,
    random_seed=1
)

seed = random.Random()
import random
sys.maxsize

random.seed(5)
random.seed()
int(random.random())
random.randint(0,100000)
random.randint(0,sys.maxsize)

print(random.random())

from random import seed
from random import random
seed(1)
# generate some random numbers
print(random(), random(), random())

***********************************************

# two events (positive - recent expansion)
# https://github.com/tskit-dev/msprime/discussions/2250
import demes
# method I
graph = demes.load("msprime_test.yaml")
demography2 = msprime.Demography.from_demes(graph)

# method II
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

## replaced with above
demography2 = msprime.Demography()
demography2.add_population(name="A", initial_size=10000)
demography2.add_population_parameters_change(growth_rate=0.0007, population="A")
demography2.add_population_parameters_change(time=1000, growth_rate=0, population="A")
demography2.debug()
# You can then use a demographydebugger:
debug2 = demography2.debug()
print(debug2)

## positive - expansion
ts = msprime.sim_ancestry(
    samples=20, 
    sequence_length=1.5e7,
    demography=demography2,
    ploidy=2,
    recombination_rate=8.9e-8,
    random_seed=random.randint(0,100000)
)
type(ts)
print(ts)


########################################
# Example 2: simulating without a pedigree
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

# diploid
def write_vcf_dip(mts, output):
    with open(output, "w") as vcf_file:
        mts.write_vcf(vcf_file)
# single replicate
mts = msprime.sim_mutations(ts, rate=1e-6, random_seed=1)
write_vcf_dip(mts, "one_pop_msprime_sim_3chr_1rep_1e6.vcf")


# make 5 replicates
for rep in range(1,6):
    mts = msprime.sim_mutations(ts, rate=1e-6, random_seed=rep)
    write_vcf_dip(mts, "one_pop_msprime_sim_3chr_1rep_1e6_" + str(rep) + ".vcf")

################ not working ##################
replicates = msprime.sim_ancestry(
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

for replicate_index, ts_5rep in enumerate(replicates):
    mts_5rep = msprime.sim_mutations(ts_5rep, rate=3.6e-9, random_seed=1)
    
    def write_vcf_dip(mts_5rep, output):
        with open(output, "w") as vcf_file:
            mts_5rep.write_vcf(vcf_file)
        
    write_vcf_dip(mts_5rep, "one_pop_msprime_sim_5_rep_3chr_mu1e_re1e_" + str(replicate_index) + ".vcf")

#################################
# test
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
type(ts_5rep)

# output simulated data in vcf format
# formal sim Dec 2023
mts = msprime.sim_mutations(ts, rate=3.6e-9, random_seed=1)
SVG(mts.draw_svg())

# diploid
def write_vcf_dip(mts, output):
    with open(output, "w") as vcf_file:
        mts.write_vcf(vcf_file)

# make 5 replicates
for rep in range(1,6):
    mts = msprime.sim_mutations(ts_5rep, rate=3.6e-9, random_seed=rep)
    write_vcf_dip(mts, "one_pop_msprime_sim_1_rep_20chr_mu36e9_re89e8_" + str(rep) + ".vcf")


################ not working ##################
replicates = msprime.sim_ancestry(samples=10, num_replicates=5, random_seed=1)
for replicate_index, ts_5rep in enumerate(replicates):
    mts_5rep = msprime.sim_mutations(ts_5rep, rate=3.6e-9, random_seed=1)
    
    def write_vcf_dip(mts_5rep, output):
        with open(output, "w") as vcf_file:
            mts_5rep.write_vcf(vcf_file)
        
    write_vcf_dip(mts_5rep, "one_pop_msprime_sim_1_rep_20chr_mu1e_re89e_" + str(replicate_index) + ".vcf")

# issue to output data in vcf (no data obtained except header lines of vcf format)
write_vcf_dip(mts, "one_pop_msprime_sim_3chr_1rep.vcf")

#### formal sim Dec 2023
write_vcf_dip(mts, "one_pop_msprime_sim_mu1e_re89e_output_file.vcf")
write_vcf_dip(mts_5rep, "one_pop_msprime_sim_1_rep_20chr_mu1e_re89e.vcf")


## easySFS
## pop file name (filtered and non-filtered)
tsk_0_tsk_0 popA
tsk_1_tsk_1 popA

tsk_0 popA
tsk_1 popA

conda activate bcftools
bcftools query -l one_pop_msprime_sim_mu1e_re89e_output_file.vcf | awk '{print $0,"popA"}' > one_pop_30ind_msprime.list

conda activate bioproject
$easySFS -i $vcf -p one_pop_30ind_msprime.list -a -f --preview
$easySFS -i $vcf -p one_pop_30ind_msprime.list -a -f --proj 60 -o . --prefix one_pop_msprime_sim_mu1e_re89e_output_file.vcf

## LD 0.5
vcf=one_pop_msprime_sim_mu1e_re89e_output_file.vcf
$plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --indep-pairwise 50 10 0.5 --out $vcf.final_ld05
$plink --vcf $vcf --double-id --allow-extra-chr --set-missing-var-ids @:# --extract $vcf.final_ld05.prune.in --out $vcf.final_ld05.pruned --keep-allele-order --
recode vcf
vcf=one_pop_msprime_sim_mu1e_re89e_output_file.vcf.final_ld05.pruned.vcf
$easySFS -i $vcf -p one_pop_30ind_msprime_pruned.list -a -f --proj 60 -o . --prefix one_pop_msprime_sim_mu1e_re89e_output_file.vcf.final_ld05.pruned



