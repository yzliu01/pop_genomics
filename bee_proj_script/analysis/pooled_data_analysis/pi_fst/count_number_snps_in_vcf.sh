

vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $vcf_dir

#x=234 390 546
and_hae_hae=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_hae_ful=concated.AndHae_New_REF_AndFul.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_hae_hat=concated.AndHae_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_hae_bom_pas=concated.AndHae_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz

#x=240 400 560
and_mar_mar=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_mar_bic=concated.AndMar_New_REF_AndBic.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_mar_tri=concated.AndMar_New_REF_AndTri.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_mar_hat=concated.AndMar_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_mar_hae=concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
and_mar_bom_pas=concated.AndMar_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz

#x=204 340 476
bom_pas_pas=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_mus=concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_syl=concated.BomPas_New_REF_BomSyl.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_hor=concated.BomPas_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_hyp=concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_con=concated.BomPas_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_apis_mel=concated.BomPas_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz

#x=174 290 416
bom_vet_pas=concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_vet_syl=concated.BomVet_New_REF_BomSyl.100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_ver_hor=concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_vet_hyp=concated.BomVet_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_ver_con=concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz
bom_pas_apis_mel=concated.BomVet_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP*_1500x_noMS.vcf.gz


#vcf_list=(
#"and_hae_hae"
#"and_hae_ful"
#"and_hae_hat"
#"and_hae_bom_pas"
#)

vcf_list=(
"$and_hae_hae" ## having three files: _DP234_1500x_noMS.vcf.gz _DP390_1500x_noMS.vcf.gz _DP546_1500x_noMS.vcf.gz
"$and_hae_ful"
"$and_hae_hat"
"$and_hae_bom_pas"

"$and_mar_mar"
"$and_mar_bic"
"$and_mar_tri"
"$and_mar_hat"
"$and_mar_hae"
"$and_mar_bom_pas"

"$bom_pas_pas"
"$bom_pas_mus"
"$bom_pas_syl"
"$bom_pas_hor"
"$bom_pas_hyp"
$bom_pas_con
$bom_pas_apis_mel

$bom_vet_pas
$bom_vet_syl
$bom_ver_hor
$bom_vet_hyp
$bom_ver_con
$bom_pas_apis_mel
)

for vcf in $(echo ${vcf_list[*]})
for vcf in $(echo ${and_hae_hae[*]})
for vcf in $(echo ${and_hae_bom_pas[*]})
    do
    for i in $vcf
    do
    less $vcf | grep -v '^#' | wc -l | tr -d '\n'
    echo -e "\t$i"
    done
done

