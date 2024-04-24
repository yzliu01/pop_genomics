#!/bin/bash -l

#SBATCH -A snic2022-22-258
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 15:30:00
#SBATCH -J bam_mask.lap_mon
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com
#SBATCH --error=bam_mask.lap_mon.%A.%a.e
#SBATCH --output=bam_mask.lap_mon.%A.%a.o

module load bioinfo-tools python samtools bcftools

## calculate depth for mon and lap, syl and inc
REF=/crex/proj/snic2020-6-58/private/yzliu/reference_genome/Bombus_sylvicola_v1.fna
BAM_INPATH_mon_lap_syl_inc=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/SYL
cd $BAM_INPATH_mon_lap_syl_inc
## create soft link to bam of inc and syl in MC's directory
##inc
#120_S_Bor_6_W.sorted.marked_dupes.rg.bam
#150_S_Bor_3_W.sorted.marked_dupes.rg.bam
#262_S_Hor_10_W.sorted.marked_dupes.rg.bam
#471_S_Eva_14_W.sorted.marked_dupes.rg.bam
#612_S_Pen_18_W.sorted.marked_dupes.rg.bam
#727_S_Qua_21_W.sorted.marked_dupes.rg.bam
#859_S_Niw_25_W.sorted.marked_dupes.rg.bam
#949_S_Niw_27_W.sorted.marked_dupes.rg.bam
##syl
#8_S_Dem_1_W.sorted.marked_dupes.rg.bam
#70_S_Dem_1_W.sorted.marked_dupes.rg.bam
#72_S_Bor_2_W.sorted.marked_dupes.rg.bam
#149_S_Bor_3_W.sorted.marked_dupes.rg.bam
#300_S_Hor_10_W.sorted.marked_dupes.rg.bam
#441_S_Eva_14_W.sorted.marked_dupes.rg.bam
#586_S_Pen_17_W.sorted.marked_dupes.rg.bam
#780_S_Qua_22_W.sorted.marked_dupes.rg.bam
#908_S_Niw_25_W.sorted.marked_dupes.rg.bam

#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/120_S_Bor_6_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/150_S_Bor_3_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/262_S_Hor_10_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/471_S_Eva_14_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/612_S_Pen_18_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/727_S_Qua_21_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/859_S_Niw_25_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco_bams/949_S_Niw_27_W.sorted.marked_dupes.rg.bam

#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/8_S_Dem_1_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/70_S_Dem_1_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/72_S_Bor_2_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/149_S_Bor_3_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/300_S_Hor_10_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/441_S_Eva_14_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/586_S_Pen_17_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/780_S_Qua_22_W.sorted.marked_dupes.rg.bam
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv_bams/908_S_Niw_25_W.sorted.marked_dupes.rg.bam

## also need bam index 
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/150_S_Bor_3_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/262_S_Hor_10_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/471_S_Eva_14_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/612_S_Pen_18_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/727_S_Qua_21_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/859_S_Niw_25_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/inco.bam.bais/949_S_Niw_27_W.sorted.marked_dupes.rg.bam.bai

#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/8_S_Dem_1_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/70_S_Dem_1_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/72_S_Bor_2_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/149_S_Bor_3_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/300_S_Hor_10_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/441_S_Eva_14_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/586_S_Pen_17_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/780_S_Qua_22_W.sorted.marked_dupes.rg.bam.bai
#ln -s /crex/proj/snic2020-6-58/private/bumblebee_project/population_sequencing/sylv_bees/mappings/sylv.bam.bais/908_S_Niw_25_W.sorted.marked_dupes.rg.bam.bai


OUT_PUT_mon_lap_inc_syl=$BAM_INPATH_mon_lap_syl_inc/samtools_bam_depth
## better output to "Sweden_Colorado" folder; before it's SYL folder
OUT_PUT_mon_lap_inc_syl=/crex/proj/snic2020-6-58/private/seq_data/P23261_feb22_bombus_osmia/Sweden_Colorado/syl_inc_lap_mon/DB_VCF/samtools_bam_depth_mask

# use bcftools instead samtools - https://github.com/samtools/bcftools/issues/1129
## parameters - https://github.com/stschiff/msmc-tools/tree/master
#for chr in {001..592};do
#    for bam in {M_L013.sorted_marked_dups.bam,M_L054.sorted_marked_dups.bam,M_L028.sorted_marked_dups.bam,M_L060.sorted_marked_dups.bam};do
#    bcftools mpileup -q 20 -Q 20 -C 50 -r contig_$chr -f $REF $BAM_INPATH_mon_lap_syl_inc/$bam | bcftools call -c -V indels |
#    /home/yzliu/bin/msmc/msmc-tools/bamCaller.py 10 $bam.$chr.out_mask.bed.gz | gzip -c > $bam.$chr.out.vcf.gz
#    done
#done

## attention to set path of output: out_mask.bed.gz 
## formal for 12 bee pools
## install required package in the base env
conda install conda-forge::dmd
conda install conda-forge::gsl
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare
wget https://github.com/stschiff/msmc2/archive/refs/tags/v2.1.4.zip
unzip v2.1.4.zip
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
## issue - https://github.com/stschiff/msmc2/issues/48

## conda installing
mamba create --name msmc2 msmc2
conda create --name conda_msmc2 msmc2
## activate env
conda activate conda_msmc2
## run msmc2 (weird)
msmc2_Linux

msmc2_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
chr=`cut -f 1 $REF_fai`
bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_list=(
        #"Andhae.New_REF_BomPas.sort.marked_dups.bam"
        "Bompas.New_REF_BomPas.sort.marked_dups.bam"
        #"Andmar.New_REF_BomPas.sort.marked_dups.bam"
        "Bomvet.New_REF_BomPas.sort.marked_dups.bam")

output_msmc_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
cd $output_msmc_mask
msmc_mask_output_vcf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf

for chr in ${chr[*]}
    do
    #echo $chr
    for bam in ${bam_list[*]}
        do
    bcftools mpileup -q 20 -Q 20 -C 50 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels |
    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz
    done
done


for chr in ${1..2}
    do
    #echo $chr
    for bam in ${bam_list[*]}
        do
    bcftools mpileup -q 20 -Q 20 -C 50 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels |
    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz
    done
done
## test
bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r 1 -f $REF $bam_dir/Bompas.New_REF_BomPas.sort.marked_dups.bam | bcftools call -c -V indels |
    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/Bompas.New_REF_BomPas.1.msmc_mask.bed.gz

