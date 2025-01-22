
## https://www.biostars.org/p/279195/
conda activate variant_calling_mapping
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
ls *bi_MQ20_DP270.vcf.gz

vcf=(`ls *bi_MQ20_DP270.vcf.gz`)
rename_list=(
    "AndHae_REF_AndHae.rename.list"
    "AndHae_REF_AndHat.rename.list"
    "AndHae_REF_BomPas.rename.list"
    "AndMar_REF_AndHae.rename.list"
    "AndMar_REF_AndHat.rename.list"
    "AndMar_REF_BomPas.rename.list"
    "BomPas_REF_ApisMel.rename.list"
    "BomPas_REF_BomHyp.rename.list"
    "BomPas_REF_BomPas.rename.list"
    "BomVet_REF_ApisMel.rename.list"
    "BomVet_REF_BomHyp.rename.list"
    "BomVet_REF_BomPas.rename.list"
)

## a test: the array index starts with 0
for i in {0..11}
    do
    output_name=${vcf[i]/bi_MQ20_DP270/bi_MQ20_DP270_rename}
    echo  ${rename_list[i]} "---"$output_name"---" ${vcf[i]}
done

## right codes:
for i in {0..11}
    do
    vcf=(`ls *bi_MQ20_DP270.vcf.gz`)
    rename_list=(
    "AndHae_REF_AndHae.rename.list"
    "AndHae_REF_AndHat.rename.list"
    "AndHae_REF_BomPas.rename.list"
    "AndMar_REF_AndHae.rename.list"
    "AndMar_REF_AndHat.rename.list"
    "AndMar_REF_BomPas.rename.list"
    "BomPas_REF_ApisMel.rename.list"
    "BomPas_REF_BomHyp.rename.list"
    "BomPas_REF_BomPas.rename.list"
    "BomVet_REF_ApisMel.rename.list"
    "BomVet_REF_BomHyp.rename.list"
    "BomVet_REF_BomPas.rename.list"
)
    output_name=${vcf[i]/bi_MQ20_DP270/bi_MQ20_DP270_rename} ## important
    ## https://superuser.com/questions/121627/how-to-get-elements-from-list-in-bash
    bcftools reheader -s ${rename_list[i]} -o $output_name ${vcf[i]} ## important
done
##
bcftools reheader -s BomVet_REF_BomPas.rename.list -o concated.fb_per_contig_BomVet_REF_BomPas.g600_regions.bi_MQ20_DP270_rename.vcf.gz concated.fb_per_contig_BomVet_REF_BomPas.g600_regions.bi_MQ20_DP270.vcf.gz