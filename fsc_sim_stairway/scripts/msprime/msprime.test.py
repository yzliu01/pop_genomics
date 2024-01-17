#       open jupyter notebook
1)
conda activate bioproject
2)
ssh -L7699:s21n13:7699 yzliu@login.genome.au.dk
3)
unset XDG_RUNTIME_DIR
conda activate bioproject
4)
jupyter-notebook --no-browser --port=$UID --ip=0.0.0.0


x = 2
y = 4
z = x*y
print(z)

# install msprime in server terminal
conda install -c conda-forge msprime

import msprime
from IPython.display import SVG, display

# Simulate an ancestral history for 3 diploid samples under the coalescent
# with recombination on a 5kb region with human-like parameters.
ts = msprime.sim_ancestry(
    samples=3,
    recombination_rate=1e-8,
    sequence_length=5_000,
    population_size=10_000,
    random_seed=123456)
# Visualise the simulated ancestral history.
SVG(ts.draw_svg())

ts = msprime.sim_ancestry(2)
ts

demography = msprime.Demography.isolated_model([100, 200])
demography

ts = msprime.sim_ancestry(samples=[msprime.SampleSet(3, ploidy=2)],
                          sequence_length=1000,
                          ploidy=3,
                          end_time=10000,
                          population_size=100,
                          random_seed=1234)
print(ts.tables.individuals)
print(ts.tables.nodes)
SVG(ts.draw_svg())

import svg
canvas = svg.SVG(
    width=60,
    height=60,
    elements=[
        svg.Circle(
            cx=30, cy=30, r=20,
            stroke="red",
            fill="white",
            stroke_width=5,
        ),
    ],
)
print(canvas)

#####################
import tskit
import msprime
import numpy
import random
import math
POP1,POP2 = 0,1  ### Specify POP1 = 0 and POP2 = 1
def simple_migration(migration_rate12, migration_rate21):
    
    ts = msprime.simulate(
        Ne=1e4,
        recombination_rate=1e-8,
        mutation_rate=1e-8,
        length = 5e5, # 10MB
        population_configurations = [
            msprime.PopulationConfiguration(sample_size=150, initial_size=1e4),
            msprime.PopulationConfiguration(sample_size=150, initial_size=1e4), # POP2
        ],
        migration_matrix =[
            [0,migration_rate21],
            [migration_rate12,0],
        ],
        demographic_events = [
            msprime.MassMigration(time=1e4, source=POP1, destination=POP2, proportion=1.0),
        ],
        random_seed=random.seed())
    return (ts)

ts=simple_migration(0.02,0.05)

def test():
    demography = msprime.Demography()
    demography.add_population(name="A", initial_size=100)
    demography.add_population(name="B", initial_size=100)
    demography.add_population(name="C", initial_size=100)
    demography.add_population_split(time=5, derived=["A", "B"], ancestral="C")

    ts = msprime.sim_ancestry(
        samples=[
            msprime.SampleSet(num_samples=5, population="A", time=1),
            msprime.SampleSet(num_samples=5, population="B", time=2),
            msprime.SampleSet(num_samples=5, population="C", time=6),
        ],
        demography=demography,
        ploidy=2,
        start_time=10,
        sequence_length=10000,
        recombination_rate=3.8e-8,
#        mutation_rate=3.8e-7,
        random_seed=1234)

    return(ts)
ts = test()
SVG(ts.draw_svg())


ts = msprime.sim_ancestry(
    samples=6,
    recombination_rate=1e-8,
    sequence_length=5_000,
    population_size=10_000,
    random_seed=123456)


ts = msprime.simulate(
    sample_size=6,
    recombination_rate=1e-8,
    mutation_rate=3.8e-7,
    length=5_000000,
    Ne=10_000,
    random_seed=123456)

### This script simulates 1 population of size 1e4 until 300 generations ago. At this point, exponential growth occurs from size 1e4 to Size_after_growth
#def simple_growth():
def simple_growth(growth_r):
#    growth_r=0.05
    T_growth = 300 ### last 300 generations of exponential growth
    Size_before_growth = 1e4
    ### Calculate the population size after exponential growth. This is a little bit different than Tim's exercise 
    Size_after_growth = Size_before_growth / math.exp(-growth_r * T_growth)
    ts = msprime.simulate(
        Ne=1e4,
        recombination_rate=1e-8,
        mutation_rate=1e-8,
        length = 5e6, # 10MB 
        population_configurations = [
            # POP1 Specify population size at time point 0 to be the calculated size after growth
            msprime.PopulationConfiguration(sample_size=10, growth_rate=growth_r, initial_size=Size_after_growth),
        ],
        migration_matrix =[
            [0],
        ],
        demographic_events = [
            ### Set population size to 1e4 prior to exponential growth start and set the growth rate prior to this time to 0
            msprime.PopulationParametersChange(time=T_growth, initial_size=Size_before_growth, growth_rate=0)
        ],
        random_seed=random.seed())
    print(Size_after_growth)
    return (ts)

xx = simple_growth(0.005)

Size_after_growth


Size_after_growth2 = 1e4/math.exp(-0.005*200)

######### test ################
#def simple_growth():

growth_r1=0.0005
growth_r2=-0.0006
T_growth1 = 300 ### last 300 generations of exponential growth
T_growth2 = 1000
Size_before_growth1 = 1e4
Size_before_growth2 = 1e6
### Calculate the population size after exponential growth. This is a little bit different than Tim's exercise 
Size_after_growth1 = Size_before_growth1 / math.exp(-growth_r1 * T_growth1)
Size_after_growth2 = Size_before_growth2 / math.exp(-growth_r2 * T_growth2)
yy = msprime.simulate(
    Ne=1e4,
    recombination_rate=1e-8,
    mutation_rate=1e-8,
    length = 5e6, # 10MB 
    population_configurations = [
        # POP1 Specify population size at time point 0 to be the calculated size after growth
        msprime.PopulationConfiguration(sample_size=30, growth_rate=growth_r1, initial_size=Size_after_growth1),
    ],
    migration_matrix =[
        [0],
    ],
    demographic_events = [
        ### Set population size to 1e4 prior to exponential growth start and set the growth rate prior to this time to 0
        msprime.PopulationParametersChange(time=T_growth1, initial_size=Size_before_growth1, growth_rate=0),
        msprime.PopulationParametersChange(time=T_growth2, initial_size=Size_before_growth2, growth_rate=0.006)
    ],
    random_seed=random.seed())
Size_after_growth1
Size_after_growth2

yy

####### Functions to calculate and output summary values

### Outputs vcf file from tree sequence
#Usage is as follows: write_vcf(ts, "output_file.vcf")
# diploid
def write_vcf_dip(ts, output):
    with open(output, "w") as vcf_file:
        ts.write_vcf(vcf_file,ploidy=2)

# haploid
def write_vcf_hap(ts, output):
    with open(output, "w") as vcf_file:
        ts.write_vcf(vcf_file)
# haploid
write_vcf_dip(xx, "pop_sim_output_file_xx.vcf")
write_vcf_hap(xx, "pop_sim_output_file_xx_hap.vcf")
write_vcf_dip(yy, "pop_sim_output_file_yy.vcf")
write_vcf_hap(yy, "pop_sim_output_file_yy_hap.vcf")
write_vcf_hap(ts, "one_pop_msprime_sim_output_file.vcf")


# only able to output vcf-like data with below old methods
msprime.simulate()

ts = msprime.simulate(
    sample_size=30,
    recombination_rate=1e-8,
    mutation_rate=3.8e-7,
    length=10e6,
    demographic_events=demography,
    random_seed=123456)
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

##
demography = msprime.Demography()
demography.add_population(name="A", initial_size=1000)
demography.add_population_parameters_change(time=100, growth_rate=0.03, population="A")
demography.add_population_parameters_change(time=200, growth_rate=-0.04,population="A")
demography.add_population_parameters_change(time=300, growth_rate=0.01, population="A")
demography.add_population_parameters_change(time=500, growth_rate=-0.04, population="A")
demography.add_population_parameters_change(time=600, growth_rate=0, population="A")
demography.debug()

# You can then use a demographydebugger:
debug = demography.debug()
print(debug)
# to verify whether the specified model corresponds to what you intended.
# Alternatively, you could convert the demography object to a demes.graph using demography,to_demes()and use demesdraw to plot a visual representation (see here).

import demesdraw
import matplotlib.pyplot as plt
#graph = demography.to_demes()
graph = msprime.Demography.to_demes(demography)
fig, ax = plt.subplots()  # use plt.rcParams["figure.figsize"]
demesdraw.tubes(graph, ax=ax, seed=1)

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
ts = msprime.sim_ancestry(
    samples=30, 
    sequence_length=1.5e7,
    demography=demography,
    ploidy=2,
    recombination_rate=8.9e-8,
    random_seed=1
)

type(ts)
print(ts)


# output simulated data in vcf format
mts = msprime.sim_mutations(ts, rate=1e-8,random_seed=1)

#### formal sim Dec 2023
mts = msprime.sim_mutations(ts, rate=8.9e-8,random_seed=1)
SVG(mts.draw_svg())
# diploid
def write_vcf_dip(mts, output):
    with open(output, "w") as vcf_file:
        mts.write_vcf(vcf_file)
# issue to output data in vcf (no data obtained except header lines of vcf format)
write_vcf_dip(mts, "one_pop_msprime_sim_output_file.vcf")

#### formal sim Dec 2023
write_vcf_dip(mts, "one_pop_msprime_sim_mu1e_re89e_output_file.vcf")


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






