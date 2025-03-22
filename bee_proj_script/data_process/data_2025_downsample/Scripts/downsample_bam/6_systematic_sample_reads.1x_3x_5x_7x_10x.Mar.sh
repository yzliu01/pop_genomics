#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --array=1-9%9
#SBATCH --time=1-16:00:00
#SBATCH --error=Mar_downsample_read_2025_DP_1x_3x_5x_7x_10x.%A_%a.e
#SBATCH --output=Mar_downsample_read_2025_DP_1x_3x_5x_7x_10x.%A_%a.o
#SBATCH --job-name=Mar_downsample_read_2025_DP_1x_3x_5x_7x_10x
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
# for sh in $(ls -t /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/downsample_bam/*sh | head -4);do sbatch $sh;done
## run in terminal
#export OPENBLAS_NUM_THREADS=1

## pooled bees
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
## complement (softmasked_regions + gene_regions) bed file - preferred
## test low sequencing depth for Andrena species
New_REF_AndHae_mask_region=$REF_MASKED_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked_ref_gene.conca_sorted.bed
New_REF_AndMar_mask_region=$REF_MASKED_DIR/Andrena_marginata_GCA_963932335.1-softmasked_ref_gene.conca_sorted.bed

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF_AndHae=$REF_DIR/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_AndMar=$REF_DIR/Andrena_marginata_GCA_963932335.1-softmasked.fa

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

vcf_file=$(ls Andmar*_0_*100kb_1500x_region.vcf.gz | sort -V | sed -n ${SLURM_ARRAY_TASK_ID}p)
output_vcf=${vcf_file/.100kb_1500x_region.vcf.gz/}

## vcf files for each percentage of downsampling
#ls Andhae*_0_*100kb_1500x_region.vcf.gz | sort -V
#Andhae.New_REF_AndMar_0_1.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_2.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_3.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_4.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_5.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_6.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_7.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_8.100kb_1500x_region.vcf.gz
#Andhae.New_REF_AndMar_0_9.100kb_1500x_region.vcf.gz

## 100% read group vcf files: from genome 100% genome sampling
## /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/data_2025_downsample/Scripts/downsample_bam/
## 6_systematic_sample_genome.1x_3x_5x_7x_10x.Mar.sh

#ls concated.AndMar*noMS.P_10.vcf.gz | sort -V
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_10.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_3x_1500x_noMS.P_10.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_5x_1500x_noMS.P_10.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_7x_1500x_noMS.P_10.vcf.gz
#concated.AndMar_New_REF_AndMar.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_10x_1500x_noMS.P_10.vcf.gz

## index vcf files
vcf_list=(
    $Andhae_New_REF_AndMar_VCF
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

## remove prefix text using #
#chr_n=${ref_chr_md[i]#ref_genome_md_chr_}
## remove suffix text using %
#chr_n=${chr_n%.fasta}

## test
#SLURM_ARRAY_TASK_ID=2

## bed file input
#BED=$(echo ${BED_LIST[@]} | tr " " "\n"| sed -n ${SLURM_ARRAY_TASK_ID}p)
## remove prefix text using #
#OUT_PORT=${BED/#Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_whole.subset_}
#echo $OUT_PORT
## remove suffix text using %
#OUT_PORT=${OUT_PORT/%.bed}
#echo $OUT_PORT

## portion value
#PROP_LIST=(01 02 03 04 05 06 07 08 09 10)
PROP_LIST=(01 02 03 04 05 06 07 08 09)
PROP=$(echo ${PROP_LIST[@]} | tr " " "\n"| sed -n ${SLURM_ARRAY_TASK_ID}p)
echo -e "processing: P_$PROP \t $vcf_file"

# Mar
## 40 ind 40*2*1
depth=(80 240 400 560 800)
depth_time=(1x 3x 5x 7x 10x)

for i in ${!depth[@]}
#for depth in 20
do
echo -e "${depth[i]}\t${depth_time[i]}"
#done
#bcftools view -R $BED_DIR/$BED $Andhae_New_REF_AndMar_VCF | \
bcftools filter --soft-filter mask --mask-file $New_REF_AndMar_mask_region $vcf_file | \
bcftools filter --SnpGap 5:indel | \
bcftools norm -d none -f $REF_AndMar | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < "${depth[i]}" || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$output_vcf"P_downsample_reads."${depth_time[i]}".vcf.gz
done

exit 0

# in - Andmar.New_REF_AndMar_0_2.100kb_1500x_region.vcf.gz
# out - Andmar.New_REF_AndMar_0_2P_downsample_reads.1x.vcf.gz