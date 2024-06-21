## calculate pi from the filtered variant files

conda activate variant_calling_mapping

vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
#vcf_pas2hyp=$vcf_dir/concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP204_1500x_noMS.vcf.gz
vcf_mar2mar=$vcf_dir/concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP240_1500x_noMS.vcf.gz
vcf_hae2hae=$vcf_dir/concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP234_1500x_noMS.vcf.gz
vcf_pas2pas=$vcf_dir/concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP204_1500x_noMS.vcf.gz
vcf_vet2pas=$vcf_dir/concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP174_1500x_noMS.vcf.gz
out_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/stats

cd $out_dir

## add headers

#bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_pas2hyp | less -S > $out_dir/vcf_pas2hyp.allele.freq
#bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_pas2hyp | less -S | \
#    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' | sed '1i CHR\tPOS\tREF\tALT\tAF_1\tAF_2' > $out_dir/vcf_pas2hyp.allele_1_2.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_mar2mar | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' | sed '1i CHR\tPOS\tREF\tALT\tAF_1\tAF_2' > $out_dir/vcf_mar2mar.allele_1_2.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_hae2hae | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' | sed '1i CHR\tPOS\tREF\tALT\tAF_1\tAF_2' > $out_dir/vcf_hae2hae.allele_1_2.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_pas2pas | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' | sed '1i CHR\tPOS\tREF\tALT\tAF_1\tAF_2' > $out_dir/vcf_pas2pas.allele_1_2.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_vet2pas | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' | sed '1i CHR\tPOS\tREF\tALT\tAF_1\tAF_2' > $out_dir/vcf_vet2pas.allele_1_2.freq

## no header
bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_mar2mar | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' > $out_dir/vcf_mar2mar.allele.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_hae2hae | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' > $out_dir/vcf_hae2hae.allele.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_pas2pas | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' > $out_dir/vcf_pas2pas.allele.freq

bcftools query -f '%CHROM\t%POS\t%REF\t%ALT\t%AF\n' $vcf_vet2pas | less -S | \
    awk 'BEGIN{FS=OFS="\t"}{print $0,1-$NF}' > $out_dir/vcf_vet2pas.allele.freq

*******************************************
pool_size=34
called_sites=217024964
n_snps_204=804197

n_snps_mar2mar_204=647385

pi_pas2hyp = n/(n-1)*xi*xj*pij = 34/33*1/2*1/2*804197/217024964

head vcf_mar2mar.allele_1_2.freq

*********************************************
##
#  Fst calculation
#    By default Fst is calculated from the allele-frequencies (not from the
#    allele-counts) using the standard equation as shown in "Hartl and Clark
#    (2007): Principles of Population Genetics"

#     Fst = (Pi_total - Pi_within) / Pi_total
#     Pi_within = (Pi_population1 + Pi_population2)/ 2
#     Pi: 1 - fA ^ 2 - fT ^ 2 -fC ^ 2 - fG ^ 2
#     fN:  frequency of nucleotide N
#     Pi_total: for the total Pi the allele frequencies of the two
#         populations are averaged and Pi is calculated as shown above

## with headers
vcf_mar2mar.allele_1_2.freq.pi
CHR	POS	REF	ALT	AF_1	AF_2	1
ENA|OZ010659|OZ010659.1	2761	T	G	0.0375	0.9625	0.0721875
ENA|OZ010659|OZ010659.1	2939	A	T	0.2625	0.7375	0.387188
ENA|OZ010659|OZ010659.1	2944	A	G	0.175	0.825	0.28875
ENA|OZ010659|OZ010659.1	2953	C	A	0.0875	0.9125	0.159687
ENA|OZ010659|OZ010659.1	3014	G	A	0.05	0.95	0.095
## 1st line data
1-0.0375^2-0.9625^2
[1] 0.0721875
# vcf_mar2mar
no. of called site with filtering: 3x
284858344
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2}' vcf_mar2mar.allele_1_2.freq > vcf_mar2mar.allele_1_2.freq.pi
awk '{count++;sum += $7}END{print sum/count}' vcf_mar2mar.allele_1_2.freq.pi
0.206338

*** without headers ***

head vcf_mar2mar.allele.freq.pi
ENA|OZ010659|OZ010659.1 2761    T       G       0.0375  0.9625  0.0721875       2.53415e-10
ENA|OZ010659|OZ010659.1 2939    A       T       0.2625  0.7375  0.387188        1.35923e-09
ENA|OZ010659|OZ010659.1 2944    A       G       0.175   0.825   0.28875 1.01366e-09
ENA|OZ010659|OZ010659.1 2953    C       A       0.0875  0.9125  0.159687        5.60586e-10
ENA|OZ010659|OZ010659.1 3014    G       A       0.05    0.95    0.095   3.33499e-10
ENA|OZ010659|OZ010659.1 4138    C       T       0.1375  0.8625  0.237187        8.32651e-10
ENA|OZ010659|OZ010659.1 4274    T       A       0.025   0.975   0.04875 1.71138e-10
ENA|OZ010659|OZ010659.1 4330    A       G       0.1375  0.8625  0.237187        8.32651e-10
ENA|OZ010659|OZ010659.1 4346    G       C       0.15    0.85    0.255   8.95182e-10
ENA|OZ010659|OZ010659.1 4436    T       G       0.0875  0.9125  0.159687        5.60586e-10

*** average ***
# vcf_mar2mar
## per site average
awk '{count++;sum += $8}END{print sum/count}' vcf_mar2mar.allele.freq.pi
7.2435e-10
## across the genome
awk '{count++;sum += $7}END{print sum/284858344}' vcf_mar2mar.allele.freq.pi
0.000468933

*********************************************

awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2}' vcf_hae2hae.allele_1_2.freq > vcf_hae2hae.allele_1_2.freq.pi
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2}' vcf_pas2pas.allele_1_2.freq > vcf_pas2pas.allele_1_2.freq.pi
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2}' vcf_vet2pas.allele_1_2.freq > vcf_vet2pas.allele_1_2.freq.pi

# no header
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2,(1-$5^2-$6^2)/284858344}' vcf_mar2mar.allele.freq > vcf_mar2mar.allele.freq.pi
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2,(1-$5^2-$6^2)/294076304}' vcf_hae2hae.allele.freq > vcf_hae2hae.allele.freq.pi
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2,(1-$5^2-$6^2)/262425280}' vcf_pas2pas.allele.freq > vcf_pas2pas.allele.freq.pi
awk 'BEGIN{FS=OFS="\t"}{print $0,1-$5^2-$6^2,(1-$5^2-$6^2)/236253189}' vcf_vet2pas.allele.freq > vcf_vet2pas.allele.freq.pi

*** average ***
# vcf_mar2mar: 0.0011543482911495785

# vcf_hae2hae
DP234_1500x
294076304

awk '{count++;sum += $7}END{print sum/count}' vcf_hae2hae.allele_1_2.freq.pi
0.170175

## across the genome
awk '{count++;sum += $7}END{print sum/294076304}' vcf_hae2hae.allele.freq.pi
0.00104236

# vcf_pas2pas
DP204_1500x
262425280
## across the genome
awk '{count++;sum += $7}END{print sum/262425280}' vcf_pas2pas.allele.freq.pi
0.000768491

# vcf_vet2pas: 0.008623075821527656
DP174_1500x
236253189
## across the genome
awk '{count++;sum += $7}END{print sum/236253189}' vcf_vet2pas.allele.freq.pi
0.000496683


