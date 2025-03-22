#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 10g
#SBATCH --array=1-3%3
#SBATCH --time=06:00:00
#SBATCH --error=get_filtered_2025_DP_1x_3x_5x_7x_10x.%A_%a.e
#SBATCH --output=get_filtered_2025_DP_1x_3x_5x_7x_10x.5x_2x.%A_%a.o
#SBATCH --job-name=get_filtered_2025_DP_1x_3x_5x_7x_10x.5x_2x
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## test
#SLURM_ARRAY_TASK_ID=0

## run in terminal
#export OPENBLAS_NUM_THREADS=1

## 2025 pooled bees
REF_MASKED_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed

## be sure the order is the same
## complement (softmasked_regions + gene_regions) bed file - preferred
REF_mask_region=(
    "Cerceris_rybyensis-GCA_910591515.1-softmasked_ref_gene.conca_sorted.bed"
    "Megachile_leachella-GCA_963576845.1-softmasked_ref_gene.conca_sorted.bed"
    "Rutpela_maculata-GCA_936432065.2-softmasked_ref_gene.conca_sorted.bed"
)

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
REF=(
    "Cerceris_rybyensis-GCA_910591515.1-softmasked.fa"
    "Megachile_leachella-GCA_963576845.1-softmasked.fa"
    "Rutpela_maculata-GCA_936432065.2-softmasked.fa"
)

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
vcf_list=(
"concated.Cerryb.REF_CerRyb.100kb_g1500x_regions.vcf.gz"
"concated.Meglea.REF_MegLea.100kb_g1500x_regions.vcf.gz"
"concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz"
)
vcf_file=${vcf_list[SLURM_ARRAY_TASK_ID]}
output_vcf=${vcf_file/.100kb_1500x_region.vcf.gz/}

## index vcf files
index_vcf(){
for vcf in `ls -t *.gz | head -3`
do
bcftools index $vcf
done
}
## execute function
## index_vcf

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  NEW  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps

## 50 -> 1x: ind 50*2*1
depth=(100 300 500 700 1000)
depth_time=(1x 3x 5x 7x 10x)

for i in ${!depth[@]}
do
echo -e "${depth[i]}\t${depth_time[i]}"
#done
#bcftools view -R $BED_DIR/$BED $Andhae_New_REF_AndMar_VCF | \
bcftools filter --soft-filter mask --mask-file $REF_MASKED_DIR/$REF_mask_region $vcf_file | \
bcftools filter --SnpGap 5:indel | \
bcftools norm -d none -f $REF_DIR/$REF | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < "${depth[i]}" || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$output_vcf".DP_"${depth_time[i]}".vcf.gz
done



exit 0

##  function list of array jobs
function_list=(

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
