## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp
vcf-concat -h
## g600_chunks (having duplicates)
ls *g600_10kb_fb_*vcf > BomVet_REF_BomHyp.individual_fb_vcf_file.list

vcf-concat Bomvet.REF_BomHypn.g600_10kb_fb_chr1.qual_20.g.vcf Bomvet.REF_BomHypn.g600_10kb_f
b_chr2.qual_20.g.vcf | bgzip -c > concated_fb_chr_1_2.vcf.gz
vcf_list=BomVet_REF_BomHyp.individual_fb_vcf_file.list
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.vcf.gz

## sort chromosome order with SortVcf (indexed automatically)
conda activate gatk_4.3.0.0
gatk --list
gatk SortVcf --INPUT concated_fb_all_chr.vcf.gz --OUTPUT concated_fb_all_chr.sorted_chr.vcf.gz
less -S concated_fb_all_chr.sorted_chr.vcf.gz

## g600_regions
ls *g600*regions*vcf > BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
vcf_list=BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
conda activate variant_calling_mapping
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.g600_100_regions.vcf.gz
conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated_fb_all_chr.g600_100_regions.vcf.gz --OUTPUT concated_fb_all_chr.g600_100_regions.sorted_chr.vcf.gz

## example from freebayes
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  Andmar_pool1
chr1    3332    .       T       A       221.12  .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=1>
chr1    19245   .       G       T       31.41   .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=2>
chr1    19255   .       G       A       94.6    .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=5>
chr1    19298   .       G       C       38.6    .       AB=0.417582;ABP=8.37933;AC=24;AF>
chr1    19451   .       G       A       2225.52 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=1>
chr1    19460   .       AAGGCCGG        AAGACCGA        2413.2  .       AB=0;ABP=0;AC=58>
chr1    19482   .       G       C       2071    .       AB=0.881481;ABP=173.656;AC=51;AF>
chr1    19500   .       A       T       1564.41 .       AB=0.729927;ABP=65.9196;AC=42;AF>
chr1    19515   .       GCAGA   ATAGG   1300.26 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=6>
chr1    19532   .       GAC     AAT     1189.91 .       AB=0;ABP=0;AC=58;AF=1;AN=58;AO=5>

## keep biallelic snp, remove duplicates and normalize snp with long base, also remove monomorphic snps
bcftools view -v snps -A -m 2 -M 2 concated_fb_all_chr.g600_100_regions.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | less -S

number of sites covered by reads 200X

## variant filtering after hard_filtering
bcftools view -v snps -A -m 2 -M 2 -f PASS concated_deo_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | \
    bcftools query -f '%CHROM\t%POS\t%DP\t%DPB\t%MQM[\t%SAMPLE\tGQ=%GQ\tDP=%DP\tTYPE=%TYPE]\n'| less -S

REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomHypn_7925v1_2.md_chr.fa

## example of output query data
chr1    66849   502     502     60      Andmar_pool1    GQ=11   DP=502  TYPE=SNP
chr1    68097   469     469     59.9393 Andmar_pool1    GQ=21   DP=469  TYPE=SNP
chr1    99914   548     548     58.9736 Andmar_pool1    GQ=19   DP=548  TYPE=SNP
chr1    116296  570     573     60      Andmar_pool1    GQ=12   DP=570  TYPE=SNP
chr1    117038  525     525     60      Andmar_pool1    GQ=11   DP=525  TYPE=SNP
chr1    123741  515     515     60      Andmar_pool1    GQ=11   DP=515  TYPE=SNP
chr1    197577  561     561     60      Andmar_pool1    GQ=12   DP=561  TYPE=SNP
chr1    247579  584     584     59.9229 Andmar_pool1    GQ=13   DP=584  TYPE=SNP
chr1    327127  572     572     59.9891 Andmar_pool1    GQ=17   DP=572  TYPE=SNP
chr1    337434  527     527     60      Andmar_pool1    GQ=11   DP=527  TYPE=SNP

## qualimap ref length

## snpeff neutral variants

## https://unix.stackexchange.com/questions/66255/awk-how-to-add-all-columns-beginning-with-specific-row
awk -F " " '{sum=0;for(i=200;i<=NR;i++){sum+=$i};print sum}'

## total number of bases with depth > 9
awk -F " " 'NR > 9 {sum+=$3}END{print sum}' ./samtools_stat_cov/SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt
125571763
## genome fraction coverage 
awk -F " " 'NR > 9 {len=133880608;sum+=$3}END{print sum/len}' ./samtools_stat_cov/SRR24680792.sort.marked_rm_dups.bam.stats_COV.txt
0.937938

## total length of dro_mel genome
awk -F " " 'NR > 0 {sum+=$2}END{print sum}' /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa.fai
133880608
