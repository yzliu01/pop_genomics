#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 10g
#SBATCH --array=2-3%2
#SBATCH --time=06:00:00
#SBATCH --error=get_filtered_2025_DP_1x_1.5x_2x.%A_%a.e
#SBATCH --output=get_filtered_2025_DP_1x_1.5x_2x.%A_%a.o
#SBATCH --job-name=get_filtered_2025_DP_1x_1.5x_2x
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## run in terminal
#export OPENBLAS_NUM_THREADS=1

## pooled bees
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## complement (softmasked_regions + gene_regions) bed file - preferred
## test low sequencing depth for Andrena species
New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndHat_mask_region=$REF_MASKED_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_BomHyp_mask_region=$REF_MASKED_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_ApisMel_mask_region=$REF_MASKED_DIR/Amel_HAv-GCF_003254395.2-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndFul_mask_region=$REF_MASKED_DIR/Andrena_fulva-GCA_946251845.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_AndTri_mask_region=$REF_MASKED_DIR/Andrena_trimmerana-GCA_951215215.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_BomCon_mask_region=$REF_MASKED_DIR/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked_ref_gene.conca_sorted.bed
#New_REF_BomHor_mask_region=$REF_MASKED_DIR/Bombus_hortorum-GCA_905332935.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_AndBic_mask_region=$REF_MASKED_DIR/Andrena_bicolor-GCA_960531205.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_alt_BomMus_mask_region=$REF_MASKED_DIR/Bombus_muscorum-GCA_963971125.1-softmasked_ref_gene.conca_sorted.bed
#New_REF_BomSyl_mask_region=$REF_MASKED_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked_ref_gene.conca_sorted.bed
#New_REF_BomVet_mask_region=$REF_MASKED_DIR/Bombus_veteranus.hifi_asm_pl2-softmasked_ref_gene.conca_sorted.bed

#2025
REF_CerRyb_mask_region=$REF_MASKED_DIR/Cerceris_rybyensis-GCA_910591515.1-softmasked_ref_gene.conca_sorted.bed
REF_MegLea_mask_region=$REF_MASKED_DIR/Megachile_leachella-GCA_963576845.1-softmasked_ref_gene.conca_sorted.bed
REF_RutMac_mask_region=$REF_MASKED_DIR/Rutpela_maculata-GCA_936432065.2-softmasked_ref_gene.conca_sorted.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndHat=$REF_DIR/Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
#REF_BomHyp=$REF_DIR/Bombus_hypnorum-GCA_911387925.1-softmasked.fa
#REF_ApisMel=$REF_DIR/Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa
## new
#REF_BomCon=$REF_DIR/Bombus_confusus-GCA_014737475.1_ASM1473747v1-softmasked.fa
#REF_BomHor=$REF_DIR/Bombus_hortorum-GCA_905332935.1-softmasked.fa
#REF_AndTri=$REF_DIR/Andrena_trimmerana-GCA_951215215.1-softmasked.fa
REF_AndFul=$REF_DIR/Andrena_fulva-GCA_946251845.1-softmasked.fa
## new
#REF_AndBic=$REF_DIR/Andrena_bicolor-GCA_960531205.1.fa
#REF_BomMus=$REF_DIR/Bombus_muscorum-GCA_963971125.1.fa
#REF_BomSyl=$REF_DIR/Bombus_sylvestris-GCA_911622165.2-softmasked.fa
#REF_BomVet=$REF_DIR/Bombus_veteranus.hifi_asm_pl2.fa

## 2025
REF_CerRyb=$REF_DIR/"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa"
REF_MegLea=$REF_DIR/"Megachile_leachella-GCA_963576845.1-softmasked.fa"
REF_RutMac=$REF_DIR/"Rutpela_maculata-GCA_936432065.2-softmasked.fa"

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}
Andhae_New_REF_BomPas_VCF=concated.AndHae_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_BomPas_VCF_filter=${Andhae_New_REF_BomPas_VCF/.vcf.gz/}
#Bompas_New_REF_BomPas_VCF=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bompas_New_REF_BomPas_VCF_filter=${Bompas_New_REF_BomPas_VCF/.vcf.gz/}
#Bomvet_New_REF_BomPas_VCF=concated.BomVet_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bomvet_New_REF_BomPas_VCF_filter=${Bomvet_New_REF_BomPas_VCF/.vcf.gz/}
#Bompas_New_REF_ApisMel_VCF=concated.BomPas_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bompas_New_REF_ApisMel_VCF_filter=${Bompas_New_REF_ApisMel_VCF/.vcf.gz/}
#Bomvet_New_REF_ApisMel_VCF=concated.BomVet_New_REF_ApisMel.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bomvet_New_REF_ApisMel_VCF_filter=${Bomvet_New_REF_ApisMel_VCF/.vcf.gz/}

## March 2024 - later (GQ_issue?)
Andmar_New_REF_AndMar_VCF=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndMar_VCF_filter=${Andmar_New_REF_AndMar_VCF/.vcf.gz/}
Andmar_New_REF_AndHae_VCF=concated.AndMar_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHae_VCF_filter=${Andmar_New_REF_AndHae_VCF/.vcf.gz/}
Andmar_New_REF_BomPas_VCF=concated.AndMar_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_BomPas_VCF_filter=${Andmar_New_REF_BomPas_VCF/.vcf.gz/}
Andmar_New_REF_AndHat_VCF=concated.AndMar_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndHat_VCF_filter=${Andmar_New_REF_AndHat_VCF/.vcf.gz/}
Andhae_New_REF_AndHat_VCF=concated.AndHae_New_REF_AndHat.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHat_VCF_filter=${Andhae_New_REF_AndHat_VCF/.vcf.gz/}
#Bompas_New_REF_BomHyp_VCF=concated.BomPas_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bompas_New_REF_BomHyp_VCF_filter=${Bompas_New_REF_BomHyp_VCF/.vcf.gz/}
#Bomvet_New_REF_BomHyp_VCF=concated.BomVet_New_REF_BomHyp.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Bomvet_New_REF_BomHyp_VCF_filter=${Bomvet_New_REF_BomHyp_VCF/.vcf.gz/}

## different vcf file names
## June 2024
#Andmar_New_REF_AndTri_VCF=concated.AndMar_New_REF_AndTri.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Andmar_New_REF_AndTri_VCF_filter=${Andmar_New_REF_AndTri_VCF/.vcf.gz/}
Andhae_New_REF_AndFul_VCF=concated.AndHae_New_REF_AndFul.100kb_g1500x_regions.all_chr.sorted.vcf.gz
Andhae_New_REF_AndFul_VCF_filter=${Andhae_New_REF_AndFul_VCF/.vcf.gz/}
#Bompas_New_REF_BomCon_VCF=concated.BomPas_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Bompas_New_REF_BomCon_VCF_filter=${Bompas_New_REF_BomCon_VCF/.vcf.gz/}
#Bomvet_New_REF_BomCon_VCF=concated.BomVet_New_REF_BomCon.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Bomvet_New_REF_BomCon_VCF_filter=${Bomvet_New_REF_BomCon_VCF/.vcf.gz/}
#Bompas_New_REF_BomHor_VCF=concated.BomPas_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Bompas_New_REF_BomHor_VCF_filter=${Bompas_New_REF_BomHor_VCF/.vcf.gz/}
#Bomvet_New_REF_BomHor_VCF=concated.BomVet_New_REF_BomHor.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Bomvet_New_REF_BomHor_VCF_filter=${Bomvet_New_REF_BomHor_VCF/.vcf.gz/}
## 23 June 2024
#Andmar_New_REF_AndBic_VCF=concated.AndMar_New_REF_AndBic.100kb_g1500x_regions.vcf.gz
#Andmar_New_REF_AndBic_VCF_filter=${Andmar_New_REF_AndBic_VCF/.vcf.gz/}
##Bompas_New_alt_REF_BomMus_VCF=concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.all_chr.sorted.vcf.gz
#Bompas_New_alt_REF_BomMus_VCF=concated.BomPas_New_alt_REF_BomMus.100kb_g1500x_regions.vcf.gz
#Bompas_New_alt_REF_BomMus_VCF_filter=${Bompas_New_alt_REF_BomMus_VCF/.vcf.gz/}
#Bompas_New_REF_BomSyl_VCF=concated.BomPas_New_REF_BomSyl.100kb_g1500x_regions.vcf.gz
#Bompas_New_REF_BomSyl_VCF_filter=${Bompas_New_REF_BomSyl_VCF/.vcf.gz/}
#Bomvet_New_REF_BomSyl_VCF=concated.BomVet_New_REF_BomSyl.100kb_g1500x_regions.vcf.gz
#Bomvet_New_REF_BomSyl_VCF_filter=${Bomvet_New_REF_BomSyl_VCF/.vcf.gz/}
#Bomvet_New_REF_BomVet_VCF=concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.vcf.gz
#Bomvet_New_REF_BomVet_VCF_filter=${Bomvet_New_REF_BomVet_VCF/.vcf.gz/}

## 2025
CerRyb_REF_CerRyb_VCF=concated.Cerryb.REF_CerRyb.100kb_g1500x_regions.vcf.gz
CerRyb_REF_CerRyb_VCF_filter=${CerRyb_REF_CerRyb_VCF/.vcf.gz/}
MegLea_REF_MegLea_VCF=concated.Meglea.REF_MegLea.100kb_g1500x_regions.vcf.gz
MegLea_REF_MegLea_VCF_filter=${MegLea_REF_MegLea_VCF/.vcf.gz/}
RutMac_REF_RutMac_VCF=concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz
RutMac_REF_RutMac_VCF_filter=${RutMac_REF_RutMac_VCF/.vcf.gz/}


# index vcf files
concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz
concated.Meglea.REF_MegLea.100kb_g1500x_regions.vcf.gz
concated.Cerryb.REF_CerRyb.100kb_g1500x_regions.vcf.gz

for vcf in `ls -t *.gz | head -3`
do
bcftools index $vcf
done


## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps

# 2025
## 1. CerRyb_REF_CerRyb_VCF ****************
50*2*2=200x
CerRyb_REF_CerRyb_VCF(){
for depth in {100,150,200}
do
    bcftools filter --soft-filter mask --mask-file $REF_CerRyb_mask_region $CerRyb_REF_CerRyb_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_CerRyb | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$CerRyb_REF_CerRyb_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 2. MegLea_REF_MegLea_VCF ****************
MegLea_REF_MegLea_VCF(){
for depth in {100,150,200}
do
    bcftools filter --soft-filter mask --mask-file $REF_MegLea_mask_region $MegLea_REF_MegLea_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_MegLea | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$MegLea_REF_MegLea_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 3. RutMac_REF_RutMac_VCF ****************
50*2*2=200x
50*2*2.5=250x
50*2*3=300x
RutMac_REF_RutMac_VCF(){
#for depth in {100,150,200}
for depth in {250,300}
do
    bcftools filter --soft-filter mask --mask-file $REF_RutMac_mask_region $RutMac_REF_RutMac_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_RutMac | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$RutMac_REF_RutMac_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

# 2023-2024
## 1. Andhae_New_REF_AndHae_VCF *************   New Version afterwards
## 39 samples
Andhae_New_REF_AndHae_VCF(){
for depth in {78,117,156}
do
    ## depth_upper=`echo $(($depth+50))`
    bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andhae_New_REF_AndHae_0_2_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_AndHae_0_2_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 2. Andhae_New_REF_BomPas_VCF ****************
Andhae_New_REF_BomPas_VCF(){
for depth in {78,117,156}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andhae_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Andhae_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 3. Bompas_New_REF_BomPas_VCF ****************
Bompas_New_REF_BomPas_VCF(){
for depth in {204,340,476}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bompas_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 4. Bomvet_New_REF_BomPas_VCF ****************
Bomvet_New_REF_BomPas_VCF(){
for depth in {174,290,416}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Bomvet_New_REF_BomPas_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 5. Bompas_New_REF_ApisMel_VCF ****************
Bompas_New_REF_ApisMel_VCF(){
for depth in {204,340,476}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bompas_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bompas_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 6. Bomvet_New_REF_ApisMel_VCF ****************
Bomvet_New_REF_ApisMel_VCF(){
for depth in {174,290,416}
do
    bcftools filter --soft-filter mask --mask-file $New_REF_ApisMel_mask_region $Bomvet_New_REF_ApisMel_VCF | \
    bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_ApisMel | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
    bcftools filter -e 'AC==0 || AC == AN' | \
    bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
    -Oz -o ./"$Bomvet_New_REF_ApisMel_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## later
## 7. Andmar_New_REF_AndMar_VCF
## downsample
## 40 samples
Andmar_New_REF_AndMar_VCF_0_2(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_0_2_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndMar | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_0_2_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

Andmar_New_REF_AndMar_VCF_0_3(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_0_3_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndMar | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_0_3_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

Andmar_New_REF_AndMar_VCF_0_4(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $Andmar_New_REF_AndMar_0_4_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndMar | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_0_4_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}



## 8. Andmar_New_REF_AndHae_VCF
Andmar_New_REF_AndHae_VCF(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region $Andmar_New_REF_AndHae_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHae | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 9. Andmar_New_REF_AndHat_VCF
Andmar_New_REF_AndHat_VCF(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andmar_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 10. Andmar_New_REF_BomPas_VCF
Andmar_New_REF_BomPas_VCF(){
for depth in {80,120,160}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomPas_mask_region $Andmar_New_REF_BomPas_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomPas | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_BomPas_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 11. Andhae_New_REF_AndHat_VCF
Andhae_New_REF_AndHat_VCF(){
for depth in {78,117,156}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndHat_mask_region $Andhae_New_REF_AndHat_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndHat | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndHat_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 12. Bompas_New_REF_BomHyp_VCF
Bompas_New_REF_BomHyp_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bompas_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 13. Bomvet_New_REF_BomHyp_VCF
Bomvet_New_REF_BomHyp_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHyp_mask_region $Bomvet_New_REF_BomHyp_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHyp | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomHyp_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 14. Andhae_New_REF_AndFul_VCF
Andhae_New_REF_AndFul_VCF(){
for depth in {78,117,156}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndFul_mask_region $Andhae_New_REF_AndFul_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndFul | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndFul_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 15. Andmar_New_REF_AndTri_VCF
Andmar_New_REF_AndTri_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndTri_mask_region $Andmar_New_REF_AndTri_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndTri | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndTri_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 16. Bompas_New_REF_BomCon_VCF
Bompas_New_REF_BomCon_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomCon_mask_region $Bompas_New_REF_BomCon_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomCon | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomCon_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 17. Bomvet_New_REF_BomCon_VCF
Bomvet_New_REF_BomCon_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomCon_mask_region $Bomvet_New_REF_BomCon_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomCon | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomCon_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 18. Bompas_New_REF_BomHor_VCF
Bompas_New_REF_BomHor_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHor_mask_region $Bompas_New_REF_BomHor_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHor | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomHor_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 19. Bomvet_New_REF_BomHor_VCF
Bomvet_New_REF_BomHor_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomHor_mask_region $Bomvet_New_REF_BomHor_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomHor | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomHor_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}


## 20. Andmar_New_REF_AndBic_VCF
Andmar_New_REF_AndBic_VCF(){
for depth in {240,400,560}
do
bcftools filter --soft-filter mask --mask-file $New_REF_AndBic_mask_region $Andmar_New_REF_AndBic_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_AndBic | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndBic_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 21. Bompas_New_alt_REF_BomMus_VCF
Bompas_New_alt_REF_BomMus_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_alt_BomMus_mask_region $Bompas_New_alt_REF_BomMus_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomMus | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_alt_REF_BomMus_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 22. Bompas_New_REF_BomSyl_VCF
Bompas_New_REF_BomSyl_VCF(){
for depth in {204,340,476}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomSyl_mask_region $Bompas_New_REF_BomSyl_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomSyl | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bompas_New_REF_BomSyl_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 23. Bomvet_New_REF_BomSyl_VCF
Bomvet_New_REF_BomSyl_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomSyl_mask_region $Bomvet_New_REF_BomSyl_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomSyl | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomSyl_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

## 24. Bomvet_New_REF_BomVet_VCF
Bomvet_New_REF_BomVet_VCF(){
for depth in {174,290,416}
do
bcftools filter --soft-filter mask --mask-file $New_REF_BomVet_mask_region $Bomvet_New_REF_BomVet_VCF | \
bcftools filter --SnpGap 5:indel | bcftools norm -d none -f $REF_BomVet | bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Bomvet_New_REF_BomVet_VCF_filter".SNP_softmask_genic_bi_FMT_DP"$depth"_1500x_noMS.vcf.gz
done
}

##  function list of array jobs
function_list=(
    #"Bomvet_New_REF_BomPas_VCF"
    #"Bomvet_New_REF_BomHyp_VCF"
    #"Bomvet_New_REF_ApisMel_VCF"
    #"Andmar_New_REF_AndMar_VCF"
    #"Andmar_New_REF_AndHae_VCF"
    #"Andmar_New_REF_AndHat_VCF"
    #"Andmar_New_REF_BomPas_VCF"
    #"Andhae_New_REF_AndHae_VCF"    
    #"Andhae_New_REF_AndHat_VCF"
    #"Andhae_New_REF_BomPas_VCF"
    #"Bompas_New_REF_BomPas_VCF"
    #"Bompas_New_REF_BomHyp_VCF"
    #"Bompas_New_REF_ApisMel_VCF"
    #"Andhae_New_REF_AndFul_VCF"
    #"Andmar_New_REF_AndTri_VCF"
    #"Bompas_New_REF_BomCon_VCF"
    #"Bomvet_New_REF_BomCon_VCF"
    #"Bompas_New_REF_BomHor_VCF"
    #"Bomvet_New_REF_BomHor_VCF"
    #"Andmar_New_REF_AndBic_VCF"
    #"Bompas_New_REF_BomSyl_VCF"
    #"Bomvet_New_REF_BomSyl_VCF"
    #"Bompas_New_alt_REF_BomMus_VCF"

    # 2025
    "CerRyb_REF_CerRyb_VCF"
    "MegLea_REF_MegLea_VCF"
    "RutMac_REF_RutMac_VCF"

)

#conda activate variant_calling_mapping

## make array jobs
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 1p)
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 2p)
function_array=$(echo ${function_list[*]} | tr ' ' '\n' | sed -n 3p)
# CerRyb_REF_CerRyb_VCF
# MegLea_REF_MegLea_VCF
# RutMac_REF_RutMac_VCF

## execute array jon function
echo $($function_array)

exit 0

## index vcf files
vcf_list=(
    "$Andhae_New_REF_AndHae_0_2_VCF"
    "$Andhae_New_REF_AndHae_0_3_VCF"
    "$Andhae_New_REF_AndHae_0_4_VCF"
    #"$Andmar_New_REF_AndMar_0_2_VCF"
    "$Andmar_New_REF_AndMar_0_3_VCF"
    "$Andmar_New_REF_AndMar_0_4_VCF"


)

for vcf in $Andmar_New_REF_AndMar_0_2_VCF $Andmar_New_REF_AndMar_0_3_VCF $Andmar_New_REF_AndMar_0_4_VCF \
        $Andhae_New_REF_AndHae_0_2_VCF $Andhae_New_REF_AndHae_0_3_VCF $Andhae_New_REF_AndHae_0_4_VCF

for vcf in `echo ${vcf_list[*]} | tr ' ' '\n'`
do echo $vcf
time bcftools index $vcf
done


exit 0
