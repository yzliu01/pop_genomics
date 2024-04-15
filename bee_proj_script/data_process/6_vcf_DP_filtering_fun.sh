#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 10g
#SBATCH --array=1-3%3
#SBATCH --time=06:00:00
#SBATCH --error=get_vcf_DP200_400_600x.%A.e
#SBATCH --output=get_vcf_DP200_400_600x.%A.o
#SBATCH --job-name=get_vcf_DP200_400_600x
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping


                                        ## pooled bees
conda activate variant_calling_mapping
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## complement (softmasked_regions + gene_regions) bed file - preferred
New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked_ref_gene.conca_sorted.bed
New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed

## only softmasked_regions bed file
#New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.bed
#New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.bed
#New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.bed
#New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.bed
#New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}
##Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/concated.*.vcf.gz/}
#echo ${Andhae_New_REF_AndHae_VCF_filter/concated./}
Andhae_New_REF_BomPas_VCF=concated.AndHae_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_BomPas_VCF_filter=${Andhae_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_BomPas_VCF=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomPas_VCF_filter=${Bompas_New_REF_BomPas_VCF/.vcf.gz/}
Bomvet_New_REF_BomPas_VCF=concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomPas_VCF_filter=${Bomvet_New_REF_BomPas_VCF/.vcf.gz/}
Bompas_New_REF_ApisMel_VCF=concated.BomPas_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_ApisMel_VCF_filter=${Bompas_New_REF_ApisMel_VCF/.vcf.gz/}
Bomvet_New_REF_ApisMel_VCF=concated.BomVet_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_ApisMel_VCF_filter=${Bomvet_New_REF_ApisMel_VCF/.vcf.gz/}

## later (GQ_issue?)
Andmar_New_REF_AndHae_VCF=concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHae_VCF_filter=${Andmar_New_REF_AndHae_VCF/.vcf.gz/}
Andmar_New_REF_BomPas_VCF=concated.AndMar_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_BomPas_VCF_filter=${Andmar_New_REF_BomPas_VCF/.vcf.gz/}
Andmar_New_REF_AndHat_VCF=concated.AndMar_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHat_VCF_filter=${Andmar_New_REF_AndHat_VCF/.vcf.gz/}
Andhae_New_REF_AndHat_VCF=concated.AndHae_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHat_VCF_filter=${Andhae_New_REF_AndHat_VCF/.vcf.gz/}
Bompas_New_REF_BomHyp_VCF=concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomHyp_VCF_filter=${Bompas_New_REF_BomHyp_VCF/.vcf.gz/}
Bomvet_New_REF_BomHyp_VCF=concated.BomVet_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bomvet_New_REF_BomHyp_VCF_filter=${Bomvet_New_REF_BomHyp_VCF/.vcf.gz/}

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps
## Bomvet_New_REF_BomPas_VCF ****************
Bomvet_New_REF_BomPas_VCF(){
for depth in {174,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bomvet_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## Andhae_New_REF_AndHae_VCF *************   New Version afterwards
Andhae_New_REF_AndHae_VCF(){
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## Bompas_New_REF_BomPas_VCF ****************
Bompas_New_REF_BomPas_VCF(){
for depth in {204,400,600}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bompas_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## function list of array jobs
function_list=(
    "Bomvet_New_REF_BomPas_VCF"
    "Andhae_New_REF_AndHae_VCF"
    "Bompas_New_REF_BomPas_VCF"
)

## make array jobs
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
#function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 3p)

## execute array jon function
## https://www.cyberciti.biz/faq/unixlinux-bash-shell-script-function-call-in-echo-command/
echo $($function_array)

exit 0

## function
vcf_DP(){
    echo "Hello!"
}
#vcf_DP
fun_vcf_DP=vcf_DP
echo $($fun_vcf_DP)



## Andmar_New_REF_AndHae_VCF
Andmar_New_REF_AndHae_VCF(){
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andmar_New_REF_AndHae_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andmar_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## Andmar_New_REF_AndMar_VCF ## later
Andmar_New_REF_AndHae_VCF(){
for depth in {234,400,600}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andmar_New_REF_AndMar_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}