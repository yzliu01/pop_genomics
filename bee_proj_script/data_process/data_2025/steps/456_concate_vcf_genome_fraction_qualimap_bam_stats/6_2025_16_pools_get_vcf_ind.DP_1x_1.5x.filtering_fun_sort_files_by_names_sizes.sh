#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 10g
#SBATCH --array=12%1
##SBATCH --array=1-16%16
#SBATCH --time=10:00:00
#SBATCH --error=get_filtered_2025_DP_16pools_1x_1.5x.%A_%a.e
#SBATCH --output=get_filtered_2025_DP_16pools_1x_1.5x.%A_%a.o
#SBATCH --job-name=get_filtered_2025_DP_16pools_1x_1.5x
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
REF_mask_region_list=(
## early
#"Cerceris_rybyensis-GCA_910591515.1-softmasked_ref_gene.conca_sorted.bed"
#"Megachile_leachella-GCA_963576845.1-softmasked_ref_gene.conca_sorted.bed"
#"Rutpela_maculata-GCA_936432065.2-softmasked_ref_gene.conca_sorted.bed"

## latest version (31 in total)
Aelia_acuminata-GCA_911387785.2-softmasked_ref_gene.conca_sorted.bed
Agelastica_alni-GCA_950111635.2.masked_ref_gene.conca_sorted.bed
Amphimallon_solstitiale-GCA_963170755.1-softmasked_ref_gene.conca_sorted.bed
#Aphodius_sticticus-GCA_963966075.1-softmasked_ref_gene.conca_sorted.bed # run 4
#Bibio_marci-GCA_910594885.2-softmasked_ref_gene.conca_sorted.bed
##Bombylius_major-GCA_932526495.1-softmasked_ref_gene.conca_sorted.bed # run 6
##Cerceris_rybyensis-GCA_910591515.1-softmasked_ref_gene.conca_sorted.bed # run 7
## grasshopper
## grasshopper
#Dorcus_parallelipipedus-GCA_958336345.1-softmasked_ref_gene.conca_sorted.bed
##Ephemera_danica-GCA_000507165.2-softmasked_ref_gene.conca_sorted.bed # run 9
Eristalis_intricaria-GCA_964034865.1-softmasked_ref_gene.conca_sorted.bed
Eristalis_pertinax-GCA_907269125.1-softmasked_ref_gene.conca_sorted.bed
Gerris_lacustris-GCA_951217055.1-softmasked_ref_gene.conca_sorted.bed
Lasioglossum_morio-GCA_916610235.2-softmasked_ref_gene.conca_sorted.bed
Leptopterna_dolobrata-GCA_954871275.1.masked_ref_gene.conca_sorted.bed
Malachius_bipustulatus-GCA_910589415.1-softmasked_ref_gene.conca_sorted.bed
##Megachile_leachella-GCA_963576845.1-softmasked_ref_gene.conca_sorted.bed # run 16
Mystacides_longicornis-GCA_963576905.1.masked_ref_gene.conca_sorted.bed
#Noctua_pronuba-GCA_905220335.1-softmasked_ref_gene.conca_sorted.bed
##Notonecta_glauca.hifi_asm_pl3-softmasked_ref_gene.conca_sorted.bed # run 19
##Ochropleura_plecta-GCA_905475445.1-softmasked_ref_gene.conca_sorted.bed # run 20
#Panurgus_banksianus.hifi_asm_pl3.masked_ref_gene.conca_sorted.bed
Phosphuga_atrata-GCA_944588485.1-softmasked_ref_gene.conca_sorted.bed
#Phragmatobia_fuliginosa-GCA_932526445.1-softmasked_ref_gene.conca_sorted.bed # run 23
Porcellio_scaber-GCA_034700385.1.masked_ref_gene.conca_sorted.bed
#Pterostichus_niger-GCA_947425015.1-softmasked_ref_gene.conca_sorted.bed
Rhagonycha_fulva-GCA_905340355.1-softmasked_ref_gene.conca_sorted.bed
#Rutpela_maculata-GCA_936432065.2-softmasked_ref_gene.conca_sorted.bed # run 27
#Stenurella_melanura-GCA_963583905.1-softmasked_ref_gene.conca_sorted.bed # run 28
Tachina_fera-GCA_905220375.1-softmasked_ref_gene.conca_sorted.bed
Tholera_decimalis-GCA_943138885.2.masked_ref_gene.conca_sorted.bed
Xestia_c-nigrum-GCA_916618015.1.masked_ref_gene.conca_sorted.bed

)
#REF_mask_region=${REF_mask_region_list[SLURM_ARRAY_TASK_ID]} # start from 0
REF_mask_region=$(echo ${REF_mask_region_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p) # start from 1

## ref
REF_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF_list=(

    "Aelia_acuminata-GCA_911387785.2-softmasked.fa"
    "Agelastica_alni-GCA_950111635.2.fa.masked" # no gene bed    
    "Amphimallon_solstitiale-GCA_963170755.1-softmasked.fa"
    #"Aphodius_sticticus-GCA_963966075.1-softmasked.fa" # no gene bed
    #"Bibio_marci-GCA_910594885.2-softmasked.fa"
    #"Bombylius_major-GCA_932526495.1-softmasked.fa"
    #"Cerceris_rybyensis-GCA_910591515.1-softmasked.fa" # test for stairway plot
    ###"Chorthippus_brunneus.hifi_asm_pl3.fa.masked" # grasshopper
    ###"Chorthippus_parallelus.hifi_asm_pl3.fa.masked" # grasshopper
    #"Dorcus_parallelipipedus-GCA_958336345.1-softmasked.fa"
    #"Ephemera_danica-GCA_000507165.2-softmasked.fa" # no gene bed
    "Eristalis_intricaria-GCA_964034865.1-softmasked.fa"
    "Eristalis_pertinax-GCA_907269125.1-softmasked.fa"
    "Gerris_lacustris-GCA_951217055.1-softmasked.fa"
    "Lasioglossum_morio-GCA_916610235.2-softmasked.fa"
    "Leptopterna_dolobrata-GCA_954871275.1.fa.masked" # no gene bed
    "Malachius_bipustulatus-GCA_910589415.1-softmasked.fa"
    #"Megachile_leachella-GCA_963576845.1-softmasked.fa" # test for stairway plot
    "Mystacides_longicornis-GCA_963576905.1.fa.masked" # no gene bed
    #"Noctua_pronuba-GCA_905220335.1-softmasked.fa"
    #"Notonecta_glauca.hifi_asm_pl3.fa.masked" # "Notonecta_glauca.hifi_asm_pl3-softmasked.fa" # self assembly: best -> same as: Notonecta_glauca.hifi_asm_pl3.fa.masked
    #"Ochropleura_plecta-GCA_905475445.1-softmasked.fa"
    ##"Panurgus_banksianus.hifi_asm_pl3.fa.masked" # assembling
    "Phosphuga_atrata-GCA_944588485.1-softmasked.fa"
    #"Phragmatobia_fuliginosa-GCA_932526445.1-softmasked.fa"
    "Porcellio_scaber-GCA_034700385.1.fa.masked" # no gene bed
    #"Pterostichus_niger-GCA_947425015.1-softmasked.fa"
    "Rhagonycha_fulva-GCA_905340355.1-softmasked.fa"
    #"Rutpela_maculata-GCA_936432065.2-softmasked.fa" # test for stairway plot
    #"Stenurella_melanura-GCA_963583905.1-softmasked.fa" # no gene bed
    "Tachina_fera-GCA_905220375.1-softmasked.fa"
    "Tholera_decimalis-GCA_943138885.2.fa.masked"
    "Xestia_c-nigrum-GCA_916618015.1.fa.masked" # no gene bed

)

#REF=${REF_list[SLURM_ARRAY_TASK_ID]} # start from 0
REF=$(echo ${REF_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p) # start from 1

## vcf
concated_vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
cd $concated_vcf_dir

## earlier (GQ_issue? and attention to VCF file names)
vcf_list=(

AelAcu_REF_AelAcu.100kb_1500x_region.vcf.gz
AgeAln_REF_AgeAln.100kb_1500x_region.vcf.gz
AmpSol_REF_AmpSol.100kb_1500x_region.vcf.gz
#AphSti_REF_AphSti.100kb_1500x_region.vcf.gz
#BibMar_REF_BibMar.100kb_1500x_region.vcf.gz
#BomMaj_REF_BomMaj.100kb_1500x_region.vcf.gz
#CerRyb_REF_CerRyb.100kb_1500x_region.vcf.gz
##DorPar_REF_DorPar.100kb_1500x_region.vcf.gz
#EphDan_REF_EphDan.100kb_1500x_region.vcf.gz
EriInt_REF_EriInt.100kb_1500x_region.vcf.gz
EriPer_REF_EriPer.100kb_1500x_region.vcf.gz
GerLac_REF_GerLac.100kb_1500x_region.vcf.gz
LasMor_REF_LasMor.100kb_1500x_region.vcf.gz
LepDol_REF_LepDol.100kb_1500x_region.vcf.gz
MalBip_REF_MalBip.100kb_1500x_region.vcf.gz
#MegLea_REF_MegLea.100kb_1500x_region.vcf.gz
MysLon_REF_MysLon.100kb_1500x_region.vcf.gz
#NocPro_REF_NocPro.100kb_1500x_region.vcf.gz
#NotGla_REF_NotGla.100kb_1500x_region.vcf.gz
#OchPle_REF_OchPle.100kb_1500x_region.vcf.gz
##PanBan_REF_PanBan.100kb_1500x_region.vcf.gz
PhoAtr_REF_PhoAtr.100kb_1500x_region.vcf.gz
#PhrFul_REF_PhrFul.100kb_1500x_region.vcf.gz
PorSca_REF_PorSca.100kb_1500x_region.10kb.vcf.gz
#PteNig_REF_PtgNig.100kb_1500x_region.vcf.gz
RhaFul_REF_RhaFul.100kb_1500x_region.vcf.gz
#RutMac_REF_RutMac.100kb_1500x_region.vcf.gz
#SteMel_REF_SteMel.100kb_1500x_region.vcf.gz
TacFer_REF_TacFer.100kb_1500x_region.vcf.gz
ThoDec_REF_ThoDec.100kb_1500x_region.vcf.gz
XesC-n_REF_XesC-n.100kb_1500x_region.vcf.gz

)
#vcf_file=${vcf_list[SLURM_ARRAY_TASK_ID]}  # start from 0
vcf_file=$(echo ${vcf_list[@]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p) # start from 1
output_vcf=${vcf_file/.100kb_1500x_region.vcf.gz/}
## SteMel_REF_SteMel

## index vcf files if have not been indexed
index_vcf(){
for vcf in `ls -t *.gz | head -3`
do
bcftools index $vcf
done
}
## execute function
## index_vcf

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  latest  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
## keep biallelic snp, remove duplicates and normalize snp with long base (bcftools norm -d none/-m-snps), also remove monomorphic snps

## 50 -> 1x: ind 50*2*1
#depth=(100 200 300 400 500)
#depth_time=(1x 2x 3x 4x 5x)

depth=(100 150)
depth_time=(1x 1.5x)

#depth=(250 300)
#depth_time=(2.5x 3x)

#depth=(100 150 200 250 300)
#depth_time=(1x 1.5x 2x 2.5x 3x)

for i in ${!depth[@]}
do
echo -e "${depth[i]}\t${depth_time[i]}"
#done
#bcftools view -R $BED_DIR/$BED $Andhae_New_REF_AndMar_VCF | \
bcftools filter --soft-filter mask --mask-file $REF_MASKED_DIR/$REF_mask_region $vcf_file | \
bcftools filter --SnpGap 5:indel | \
bcftools norm -a -f $REF_DIR/$REF | \
bcftools view -v snps -A -m 2 -M 2 -f 'PASS' | \
bcftools filter -e 'AC==0 || AC == AN' | \
bcftools view -e "MEAN(FMT/DP) < "${depth[i]}" || MEAN(FMT/DP) > 1500" \
-Oz -o ./"$output_vcf".DP_"${depth_time[i]}".vcf.gz
## SteMel_REF_SteMel.1x.vcf.gz
done

exit 0



## change vcf file names caused by (100kb_1500x_region or 100kb_1500x_regions)
## SteMel_REF_SteMel.100kb_1500x_region.vcf.gz.DP_1x.vcf.gz
rename '100kb_1500x_region.vcf.gz.' '' *100kb_1500x_region.vcf.gz.*.vcf.gz

## sort vcf file order
ls -t *x.vcf.gz | head -30 | sort -V

## >>>>>>>>>>>>>>>>>>>>>>>>>>>>>  early  <<<<<<<<<<<<<<<<<<<<<<<<<<<<<
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

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
ls concated*vcf.vcf.gz


## sort output files with sizes
## sorting by the 5th underscore-separated field (-k5,5), which corresponds to the coverage depth (e.g., 10x, 1x, etc.).
ls -lh concated*Rut*vcf*.vcf.gz | sort -t '_' -k5,5 -V
-rw-rw-r-- 1 yzliu eDNA 1.7G Mar 25 10:37 concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz.DP_1x.vcf.gz
-rw-rw-r-- 1 yzliu eDNA  49M Mar 25 11:37 concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz.DP_3x.vcf.gz
-rw-rw-r-- 1 yzliu eDNA  11M Mar 25 12:36 concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz.DP_5x.vcf.gz
-rw-rw-r-- 1 yzliu eDNA 3.0M Mar 25 13:37 concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz.DP_7x.vcf.gz
-rw-rw-r-- 1 yzliu eDNA 546K Mar 25 14:43 concated.Rutmac.REF_RutMac.100kb_g1500x_regions.vcf.gz.DP_10x.vcf.gz

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
