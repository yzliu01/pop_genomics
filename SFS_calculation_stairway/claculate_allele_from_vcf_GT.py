import re
import sys

def parse_vcf(file_path):
    allele_counts = []
    total_alleles = []

    with open(file_path, 'r') as vcf_file:
        for line in vcf_file:
            if line.startswith("#"):
                continue  # Skip header lines
            fields = line.strip().split('\t')
            genotypes = fields[9:]  # Sample genotypes start from the 10th column
            ac, an = calculate_ac_an(genotypes)
            allele_counts.append(ac)
            total_alleles.append(an)

    return allele_counts, total_alleles

def calculate_ac_an(genotypes):
    ac = 0  # Allele count
    an = 0  # Allele number
    
    for genotype in genotypes:
        # Split the genotype field, e.g., "0/1", "1|1", "./.", etc.
        genotype_info = genotype.split(':')
        alleles = re.split(r'[/|]', genotype_info[0])
        
        for allele in alleles:
            if allele == '.':
                continue  # Missing data
            ac += int(allele)
            an += 1
    
    return ac, an

def save_to_file(file_path, allele_counts, total_alleles):
    with open(file_path, 'w') as f:
        f.write("Allele Count\tTotal Alleles\n")
        for ac, an in zip(allele_counts, total_alleles):
            f.write(f"{ac}\t{an}\n")

# Example usage:
#vcf_file_path = '/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_5.vcf'
#vcf_file_path = '/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_3.biallel.vcf'
vcf_file_path = sys.argv[1]

#output_file_path = '/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_5.sfs'
#output_file_path ='/home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/msprime/sfs/one_pop_msprime_sim_10kNe_100dip_5rep_20chr_mu36e9_re89e8_3.biallel.sfs'
output_file_path = sys.argv[2]

allele_counts, total_alleles = parse_vcf(vcf_file_path)
save_to_file(output_file_path, allele_counts, total_alleles)

print("AC and AN have been saved to:", output_file_path)

