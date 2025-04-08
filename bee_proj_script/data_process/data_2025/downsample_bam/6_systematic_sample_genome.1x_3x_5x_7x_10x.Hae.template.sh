#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --array=1-10%10
#SBATCH --time=1-16:00:00
#SBATCH --error=Hae_get_filtered_2025_DP_1x_3x_5x_7x_10x.%A_%a.e
#SBATCH --output=Hae_get_filtered_2025_DP_1x_3x_5x_7x_10x.%A_%a.o
#SBATCH --job-name=Hae_get_filtered_2025_DP_1x_3x_5x_7x_10x
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
New_REF_BomPas_mask_region=$REF_MASKED_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed
New_REF_BomVet_mask_region=$REF_MASKED_DIR/Bombus_veteranus.hifi_asm_pl2-softmasked_ref_gene.conca_sorted.bed

## region of selected - bed files
BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
BED_01=Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_whole.subset_01.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_BomPas=$REF_DIR/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa
REF_BomVet=$REF_DIR/Bombus_veteranus.hifi_asm_pl2.fa

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.vcf.gz
Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}

Andmar_New_REF_AndMar_VCF=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndMar_VCF_filter=${Andmar_New_REF_AndMar_VCF/.vcf.gz/}

Bompas_New_REF_BomPas_VCF=concated.BomPas_New_REF_BomPas.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Bompas_New_REF_BomPas_VCF_filter=${Bompas_New_REF_BomPas_VCF/.vcf.gz/}
Bomvet_New_REF_BomVet_VCF=concated.BomVet_New_REF_BomVet.100kb_g1500x_regions.vcf.gz
Bomvet_New_REF_BomVet_VCF_filter=${Bomvet_New_REF_BomVet_VCF/.vcf.gz/}

## index vcf files
vcf_list=(
    $Andhae_New_REF_AndHae_VCF
    $Andmar_New_REF_AndMar_VCF
    $Bompas_New_REF_BomPas_VCF
    $Bomvet_New_REF_BomVet_VCF)

index_vcf(){
for vcf in ${vcf_list[@]}
do
echo $vcf
#done
ll -lh $vcf
#vcf_copy=${vcf/vcf.gz/cp.vcf.gz}
#cp $vcf $vcf_copy
echo "indexing: $vcf"
bcftools index $vcf
done
}
#index_vcf

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps

# 2023-2024-2025
## Proportion of genome
## 4. Andmar_New_REF_AndMar_VCF
## 39 ind 78*2*1
## 1x 3x 5x 7x 10x

BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
BED_LIST=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_01.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_02.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_03.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_04.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_05.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_06.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_07.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_08.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_09.bed"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_whole.subset_10.bed"

)

## remove prefix text using #
#chr_n=${ref_chr_md[i]#ref_genome_md_chr_}
## remove suffix text using %
#chr_n=${chr_n%.fasta}

## test
#SLURM_ARRAY_TASK_ID=1

## bed file input
BED=$(echo ${BED_LIST[@]} | tr " " "\n"| sed -n ${SLURM_ARRAY_TASK_ID}p)
## remove prefix text using #
#OUT_PORT=${BED/#Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_whole.subset_}
#echo $OUT_PORT
## remove suffix text using %
#OUT_PORT=${OUT_PORT/%.bed}
#echo $OUT_PORT

## portion value
PROP_LIST=(01 02 03 04 05 06 07 08 09 10)
PROP=$(echo ${PROP_LIST[@]} | tr " " "\n"| sed -n ${SLURM_ARRAY_TASK_ID}p)
echo "P_$PROP"

depth=(78 256 390 546 780)
depth_time=(1x 3x 5x 7x 10x)

for i in ${!depth[@]}
#for depth in 20
do
echo -e "${depth[i]}\t${depth_time[i]}"
#done
bcftools view -R $BED_DIR/$BED $Andhae_New_REF_AndHae_VCF | \
bcftools filter --soft-filter mask --mask-file $New_REF_AndHae_mask_region | \
bcftools filter --SnpGap 5:indel | \
bcftools norm -d none -f $REF_AndHae | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < "${depth[i]}" || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andhae_New_REF_AndHae_VCF_filter".SNP_softmask_genic_bi_FMT_DP_"${depth_time[i]}"_1500x_noMS.P_"$PROP".vcf.gz
done

exit 0

export OPENBLAS_NUM_THREADS=4
#OpenBLAS blas_thread_init: pthread_create failed for thread 27 of 64: Resource temporarily unavailable
#OpenBLAS blas_thread_init: RLIMIT_NPROC 1000 current, 1000 max
bcftools view -R $BED_DIR/$BED_01 $Andmar_New_REF_AndMar_VCF -Oz -o concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.P01_test.vcf.gz

bcftools view -v snps -A -m 2 -M 2 -f 'PASS' -R $BED_DIR/$BED_01 $Andmar_New_REF_AndMar_VCF | less -S

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


******************************** test ************************
## Proportion of genome
## 4. Andmar_New_REF_AndMar_VCF
## 40 ind 40*2*1
1x 3x 5x 7x 10x

conda activate variant_calling_mapping

REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa

REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed

concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
#Andhae_New_REF_AndHae_VCF=concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
#Andhae_New_REF_AndHae_VCF_filter=${Andhae_New_REF_AndHae_VCF/.vcf.gz/}
Andmar_New_REF_AndMar_VCF=concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.vcf.gz
Andmar_New_REF_AndMar_VCF_filter=${Andmar_New_REF_AndMar_VCF/.vcf.gz/}

BED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
BED_01=Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_whole.subset_01.bed

Andmar_New_REF_AndMar_VCF_P01(){
#for depth in {80,240,400,560,800}
for depth in 80 240 400 560 800
#for depth in 20
do
#echo $depth
#done
bcftools view -R $BED_DIR/$BED_01 $Andmar_New_REF_AndMar_VCF | \
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region | \
bcftools filter --SnpGap 5:indel | \
bcftools norm -d none -f $REF_AndMar | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < $depth || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$Andmar_New_REF_AndMar_VCF_filter".SNP_softmask_genic_bi_FMT_DP_"$depth"_1500x_noMS.P01.vcf.gz
done
}

Andmar_New_REF_AndMar_VCF_P01

export OPENBLAS_NUM_THREADS=4
#OpenBLAS blas_thread_init: pthread_create failed for thread 27 of 64: Resource temporarily unavailable
#OpenBLAS blas_thread_init: RLIMIT_NPROC 1000 current, 1000 max
bcftools view -R $BED_DIR/$BED_01 $Andmar_New_REF_AndMar_VCF -Oz -o concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.P01_test.vcf.gz

bcftools view -v snps -A -m 2 -M 2 -f 'PASS' -R $BED_DIR/$BED_01 $Andmar_New_REF_AndMar_VCF | less -S
