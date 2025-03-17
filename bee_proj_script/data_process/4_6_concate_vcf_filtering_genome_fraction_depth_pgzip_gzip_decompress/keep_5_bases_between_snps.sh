#To ensure that there are at least 5 base pairs (bp) between two SNPs in a VCF file, you can use bcftools filter with a custom awk command. Here’s how:
#Method 1: Using bcftools filter and awk

bcftools view -H input.vcf | awk 'BEGIN{prev_pos=0} {if ($2 - prev_pos >= 5) print; prev_pos=$2}' > filtered_snps.vcf

#Explanation:

#    bcftools view -H input.vcf: Extracts variant lines (without headers) from the VCF file.
#    awk:
#        Keeps track of the previous SNP position.
#        Checks if the current SNP is at least 5 bp away from the previous SNP.
#        If the condition is met, the SNP is kept.
#        Updates prev_pos for the next comparison.

#Method 2: Using bcftools filter with INFO/TYPE=SNP

#If your VCF has SNPs marked in the INFO field, you can use:

bcftools filter -e 'TYPE!="SNP" || POS-PREV(POS)<5' input.vcf -o filtered_snps.vcf

#    This removes SNPs that are within 5 bp of another SNP.

#Method 3: Using vcftools

#Alternatively, if you have vcftools:

vcftools --vcf input.vcf --thin 5 --recode --out filtered_snps

#    --thin 5: Ensures SNPs are at least 5 bp apart.