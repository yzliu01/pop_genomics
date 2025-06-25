



a detailed step-by-step guide to using ABC-RF (Approximate Bayesian Computation with Random Forests) for reconstructing a continuous effective population size (Ne) trajectory from genetic data.
🧬 GOAL: Estimate how Ne changes over time using ABC-RF

We'll walk through the complete pipeline, from simulation to trajectory reconstruction.
📊 OVERVIEW OF THE PIPELINE

    Model Ne trajectory with priors

    Simulate genetic data

    Compute summary statistics

    Train random forest regressors (ABC-RF)

    Apply trained model to observed data

    Reconstruct and visualize Ne trajectory

🔹 Step 1: Define Prior on Ne Trajectory

We model Ne as changing through time using, for example:

    A piecewise constant model (e.g., 10 epochs)

    A parametric function (e.g., exponential, logistic)

    A nonparametric spline model

Example (Piecewise Constant with 10 time points):

    Set a uniform/log-uniform prior on Ne in each time window:
    Ne_t ~ Uniform(100, 1e6) for t = 1 to 10.

    Define a time grid:
    Example: [0–100], [100–500], [500–1k], ..., [10k–50k] generations ago.

🔹 Step 2: Simulate Genetic Data

Use a coalescent simulator to simulate DNA sequences based on the Ne trajectories sampled from the prior.
Simulators:

    msprime

    scrm

    fastsimcoal

    SLiM (for forward-in-time)

Example (in msprime, Python):

import msprime
import numpy as np

# Define an Ne trajectory
Ne_trajectory = [500, 1000, 3000, ..., 8000]  # one value per time epoch
demography = msprime.Demography()
demography.add_population(name="A", initial_size=Ne_trajectory[0])

# Define size changes over time
for i in range(1, len(Ne_trajectory)):
    demography.add_population_parameters_change(time=times[i], initial_size=Ne_trajectory[i], population="A")

# Simulate data
ts = msprime.sim_ancestry(samples=20, demography=demography, sequence_length=1e6, recombination_rate=1e-8)
mutated = msprime.sim_mutations(ts, rate=1e-8)

Simulate many such datasets by sampling new Ne_trajectories from the prior each time.
🔹 Step 3: Compute Summary Statistics

Compute statistics from:

    Each simulated dataset

    Your observed dataset

Examples of summary stats:

    Site Frequency Spectrum (SFS)

    Pairwise diversity (π)

    Tajima’s D

    LD decay

    Number of segregating sites

    Haplotype diversity

Use tools:

    scikit-allel (Python)

    egglib, msstats, Arlequin

    Custom scripts

💡 Normalize the statistics if necessary.





 STEP 3: Compute Summary Statistics — with Code
✅ Option A: Python (with scikit-allel)
Install dependencies:

pip install scikit-allel numpy pandas

Example: Compute SFS, diversity, Tajima's D from VCF

import allel
import numpy as np
import pandas as pd

# Load VCF or simulation output
callset = allel.read_vcf('simulated_data.vcf')  # or use msprime output to VCF
genotypes = allel.GenotypeArray(callset['calldata/GT'])

# Convert to allele counts
ac = genotypes.count_alleles()

# Compute summary statistics
sfs = allel.sfs(ac[:, 1])                       # Site Frequency Spectrum
tajd = allel.tajima_d(ac[:, 1])                 # Tajima's D
pi = allel.sequence_diversity(pos=callset['variants/POS'], ac=ac, start=0, stop=1e6)
h1 = genotypes.count_haplotypes().mean()        # Haplotype diversity (approx)

# Collect all statistics
summary_stats = {
    'tajimas_d': tajd,
    'pi': pi,
    'num_haplotypes': h1,
    'sfs_bin1': sfs[1] if len(sfs) > 1 else 0,
    'sfs_bin2': sfs[2] if len(sfs) > 2 else 0,
    # Add more bins as needed
}

df = pd.DataFrame([summary_stats])
df.to_csv("summary_stats.csv", index=False)

You can repeat this for each simulated dataset and stack them into a training matrix.
✅ Option B: R (for output from fastsimcoal or ms)

Use the PopGenome or pegas packages.
Install packages:

install.packages("PopGenome")
install.packages("pegas")

Example using PopGenome

library(PopGenome)

# Read FASTA, VCF, or MS format
genome <- readData("path/to/simulated_data/", format = "MS")

# Compute summary statistics
genome <- neutrality.stats(genome)

tajd <- genome@Tajima.D
pi <- genome@nuc.diversity.within
sfs <- genome@binned.sfs[[1]]  # example binned SFS
h1 <- genome@hap.diversity.within

summary_stats <- data.frame(
  tajimas_d = tajd,
  pi = pi,
  h1 = h1,
  sfs_bin1 = sfs[1],
  sfs_bin2 = sfs[2]
  # etc...
)

write.csv(summary_stats, "summary_stats.csv", row.names = FALSE)

You’d repeat this process for all simulated datasets to generate a training matrix of summary stats.
🔁 Automate for Simulations

For ABC-RF, you need thousands of such datasets. So:

    Loop over each simulation replicate

    Extract summary statistics

    Save them to a table (rows = datasets, columns = stats)

You will end up with a training dataset like this:
tajimas_d	pi	sfs_bin1	sfs_bin2	...	Ne_t1	Ne_t2	...
1.2	0.01	5	3	...	1000	5000	...
0.8	0.015	4	2	...	1500	7000	...
...	...	...	...	...	...	...	...
Then you use this to train the random forest in Step 4.


🔹 Step 4: Train Random Forest Regressors

We now train a random forest regressor to learn the relationship between summary statistics and Ne at each time epoch.
Inputs:

    X = Summary statistics from simulated data

    Y = Ne value at a specific time epoch

Repeat for each time point in the Ne trajectory (i.e., train 10 models for 10 epochs).
R Example using abcrf:

library(abcrf)

# For Ne at time t1
data <- data.frame(Ne_t1 = target_ne_t1, summary_stats)
rf_model <- regAbcrf(Ne_t1 ~ ., data = data, ntree = 500)

In Python (using scikit-learn):

from sklearn.ensemble import RandomForestRegressor

model = RandomForestRegressor(n_estimators=500)
model.fit(summary_matrix, Ne_values_t1)  # Do this for t1, t2, ..., t10

You can also use ABC-RF tools like abcrf which automate the process.
🔹 Step 5: Apply Model to Observed Summary Stats

Compute the same summary statistics from your observed genetic data. Then use the trained RF models to predict Ne.
R Example:

prediction <- predict(rf_model, obs_summary_stats, training = data)
mean_Ne_t1 <- prediction$expectation

Repeat for each time epoch to reconstruct the full trajectory.
🔹 Step 6: Reconstruct and Visualize Ne Trajectory

Plot the posterior mean, median, and credible intervals of Ne over time.
Example (in R):

plot(times, Ne_means, type="l", ylim=c(100, 1e6), log="y")
polygon(c(times, rev(times)), c(Ne_lower, rev(Ne_upper)), col=rgb(0,0,1,0.2), border=NA)

Use a log scale for Ne if the range is large.
✅ Advantages of ABC-RF in This Context

    No tolerance threshold like in traditional ABC

    Automatic feature selection

    Robust to irrelevant/collinear statistics

    Higher accuracy in parameter estimation

🧪 Final Tips

    Simulate a large number of datasets (e.g., 10,000–100,000)

    Validate using cross-validation and posterior predictive checks

    Consider using ABC-SMC-RF for more efficient parameter exploration

⚙️ Tools Recap
Task	Tools
Simulate data	msprime, scrm, SLiM
Summary stats	scikit-allel, egglib, R
ABC-RF training	abcrf (R), scikit-learn (Py)
Visualization	ggplot2, matplotlib