import allel
import numpy as np

# Load VCF file (adjust the file path as needed)
callset = allel.read_vcf('/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP234_1500x_noMS.vcf.gz')

# Extract genotype data
genotypes = allel.GenotypeArray(callset['calldata/GT'])
positions = callset['variants/POS']

# Assuming you know the ploidy level, let's say it's tetraploid (4)
ploidy = 78

# Convert genotypes to allele counts manually for polyploid data
def genotype_to_allele_counts(genotypes, ploidy):
    n_variants, n_samples, _ = genotypes.shape
    allele_counts = np.zeros((n_variants, ploidy))
    for i in range(n_variants):
        for j in range(n_samples):
            for allele in genotypes[i, j]:
                if allele >= 0:  # exclude missing data
                    allele_counts[i, allele] += 1
    return allele_counts

allele_counts = genotype_to_allele_counts(genotypes, ploidy)

# Function to calculate nucleotide diversity (π) for polyploid data
def calculate_pi(allele_counts):
    total_sites = allele_counts.shape[0]
    pi_values = []
    for i in range(total_sites):
        ac = allele_counts[i]
        ac_sum = ac.sum()
        if ac_sum > 1:
            p = ac / ac_sum
            pi_site = 1.0 - np.sum(p ** 2)
            pi_values.append(pi_site)
    mean_pi = np.mean(pi_values) if pi_values else 0
    return mean_pi

# Function to calculate π in sliding windows
def sliding_window_pi(positions, allele_counts, window_size, step_size):
    max_pos = positions[-1]
    window_starts = np.arange(0, max_pos, step_size)
    window_pi = []
    for start in window_starts:
        end = start + window_size
        in_window = (positions >= start) & (positions < end)
        window_allele_counts = allele_counts[in_window]
        if window_allele_counts.size > 0:
            pi = calculate_pi(window_allele_counts)
        else:
            pi = np.nan  # or 0, depending on how you want to handle empty windows
        window_pi.append((start, end, pi))
    return window_pi

# Define window size and step size (e.g., 10,000 bp windows with a step size of 5,000 bp)
window_size = 10000
step_size = 5000

# Calculate nucleotide diversity (π) in sliding windows
window_pi = sliding_window_pi(positions, allele_counts, window_size, step_size)

# Extract the π values from the sliding windows
pi_values = [pi for start, end, pi in window_pi if not np.isnan(pi)]

# Calculate the average π across all sliding windows
average_pi = np.mean(pi_values) if pi_values else 0

# Print results
print("Start\tEnd\tPi")
for start, end, pi in window_pi:
    print(f"{start}\t{end}\t{pi}")

print(f"\nAverage nucleotide diversity (π) across all sliding windows: {average_pi}")
