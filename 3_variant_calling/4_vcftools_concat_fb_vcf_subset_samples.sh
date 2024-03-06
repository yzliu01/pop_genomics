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

## g600_regions bee pools
ls *g600*regions*vcf > BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
vcf_list=BomVet_REF_BomHyp.individual_fb.g600_100_regions.vcf_file.list
conda activate variant_calling_mapping
vcf-concat --files $vcf_list | bgzip -c > concated_fb_all_chr.g600_100_regions.vcf.gz
conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated_fb_all_chr.g600_100_regions.vcf.gz --OUTPUT concated_fb_all_chr.g600_100_regions.sorted_chr.vcf.gz


## dro mel
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF/vcfs_all_indv/DB_VCF
ls *100kb*g.vcf.gz > dro_mel.vcf_file.list
vcf_list=dro_mel.vcf_file.list
conda activate variant_calling_mapping
vcf-concat --files $vcf_list | gzip -c > ../concated_dro_mel_all_chr.vcf.gz
conda activate gatk_4.3.0.0
gatk SortVcf --INPUT concated_dro_mel_all_chr.vcf.gz --OUTPUT concated_dro_mel_all_chr.sorted_chr.vcf.gz


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

## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none), also remove monomorphic snps
bcftools view -v snps -A -m 2 -M 2 concated_fb_all_chr.g600_100_regions.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | less -S

number of sites covered by reads 200X

## variant filteringfor {bees}
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/fb_per_contig_BomVet_REF_BomHyp
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/iyBomHypn_7925v1_2.md_chr.fa
concated_fb_all_chr.g600_100_regions.sorted_chr.vcf.gz
bcftools view -v snps -A -m 2 -M 2 concated_fb_all_chr.g600_100_regions.vcf.gz | \
    bcftools norm -D -f $REF | bcftools filter -e 'AC==0 || AC == AN' | bcftools view -i 'INFO/DP > 200 && INFO/MQM > 15 && FMT/GQ > 10' | \
    bcftools query -f '%CHROM\t%POS\t%DP\t%DPB\t%MQM[\t%SAMPLE\tGQ=%GQ\tDP=%DP\tTYPE=%TYPE]\n'| less -S

## variant filtering for {dro_mel}
## https://gatk.broadinstitute.org/hc/en-us/community/posts/4476803114779-GenotypeGVCFs-Output-no-call-as-reference-genotypes
## GenotypeGVCFs Output no call as reference genotypes 
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/dro_mel_gatk_vcf/DB_VCF
REF_DRO_MEL=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/D_melanogaster.7509v1.md_chr.fa
## bcftools norm -D -> bcftools norm -d none 
bcftools view -i 'FMT/DP > 3 | INFO/MQ > 20'

bcftools view -v snps -A -m 2 -M 2 -f PASS concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz | \
    bcftools norm -d none -f $REF_DRO_MEL | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | bcftools view -i 'FMT/DP > 3' | \
    bcftools query -f '%CHROM\t%POS\t%QUAL\t%DP\t%MQ\n'| less -S > concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered.CHROM_POS_QUAL_DP_MQ

bcftools view -v snps -A -m 2 -M 2 -f PASS concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz | bcftools norm -d none -f $REF_DRO_MEL | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | bcftools view -i 'MIN(FMT/DP) > 3 | F_MISSING < 0.3' -Oz -o ./concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.vcf.gz

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

## get sample name list
less -S concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG03.vcf.gz \
    | bcftools query -l
    
BP_CS_01
BP_CS_02
BP_CS_03
BP_CS_04

## subset samples in vcf
sample_listS=("BP_CS.list" "SB_RP.list" "SB_SE.list" "SPD.list")
vcf_dro_mel=concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered.vcf.gz

bcftools view -v snps -A -m 2 -M 2 -f PASS $vcf_dro_mel | bcftools norm -d none -f $REF_DRO_MEL | \
    bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
    bcftools view -S SB_RP.list -i 'MIN(FMT/DP) > 3 | F_MISSING < 0.3' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.SB_RP.list.vcf.gz

for sample_list in ${sample_listS[*]};
    do echo $sample_list;
done
for sample_list in ${sample_listS[*]};
    do bcftools view -v snps -A -m 2 -M 2 -f PASS $vcf_dro_mel | bcftools norm -d none -f $REF_DRO_MEL \
        | bcftools filter -e 'AC==0 || AC == AN' | bcftools +setGT -- -t q -n . -i 'FMT/DP=0' | \
        bcftools view -S $sample_list -i 'MIN(FMT/DP) > 3 | F_MISSING < 0.3' | bcftools filter -e 'AC==0 || AC == AN' \
    -Oz -o ./concated_dro_mel_all_chr.sorted_chr.SNP_hard_filtered_bi_MQ20_FMT_DP3_MSG0.$sample_list.vcf.gz;
done


## qualimap ref length

## snpeff neutral variants

