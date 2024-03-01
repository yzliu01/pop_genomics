## https://cyverse.atlassian.net/wiki/spaces/DEapps/pages/259063974/vcftools-merge+0.1.16
## https://vcftools.sourceforge.net/perl_module.html

conda activate variant_calling_mapping

vcf-concat -h
ls *g600*vcf > BomVet_REF_BomHyp.individual_fb_vcf_file.list

vcf-concat Bomvet.REF_BomHypn.g600_10kb_fb_chr1.qual_20.g.vcf Bomvet.REF_BomHypn.g600_10kb_f
b_chr2.qual_20.g.vcf | gzip -c > concated_fb_chr_1_2.vcf.gz
vcf_list=BomVet_REF_BomHyp.individual_fb_vcf_file.list
vcf-concat --files $vcf_list | gzip -c > concated_fb_all_chr.vcf.gz

## sort chromosome order with SortVcf (indexed automatically)
conda activate gatk_4.3.0.0
gatk --list
gatk SortVcf --INPUT concated_fb_all_chr.vcf.gz --OUTPUT concated_fb_all_chr.sorted_chr.vcf.gz

