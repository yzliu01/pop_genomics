#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 10g
##SBATCH --array=1-10%10
#SBATCH -t 12:00:00
#SBATCH -J bcftools_mpileup_bam_mask_msmc.BomPas_BomVet_New_REF_BomPas
#SBATCH --error=bcftools_mpileup_bam_mask_msmc.BomPas_BomVet_New_REF_BomPas.%A.e
#SBATCH --output=bcftools_mpileup_bam_mask_msmc.BomPas_BomVet_New_REF_BomPas.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping for bcftools
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## formal for 12 bee pools
msmc2_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
chr_list=`cut -f 1 $REF_fai`
#chr=$(cut -f 1 $REF_fai | sed -n ${SLURM_ARRAY_TASK_ID}p)
## 81 chr

bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_list=(
        #"Andhae.New_REF_BomPas.sort.marked_dups.bam"
        "Bompas.New_REF_BomPas.sort.marked_dups.bam"
        #"Andmar.New_REF_BomPas.sort.marked_dups.bam"
        "Bomvet.New_REF_BomPas.sort.marked_dups.bam")
#bam=${echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p}

output_msmc_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
cd $output_msmc_mask
msmc_mask_output_vcf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf

#out_bam_name=${bam/.sort.marked_dups.bam/}

#bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels | \
#    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > \
#    $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz

#exit 0

## generate mask vcf
for chr in ${chr_list[*]}
    do
    #echo $chr
    for bam in ${bam_list[*]}
        do
        out_bam_name=${bam/.sort.marked_dups.bam/}
        bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels | \
        $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > \
        $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz
    done
done



## initial run for generate_multihetsep
called_mask_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf
msmc_bam_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
mappability_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
multihetsep_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output
cd $multihetsep_output

for chr in ${chr_list[*]}
    do
    /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/Bombus_pascuorum-GCA_905332965.1-softmasked.bed \
    $called_mask_path/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Bompas.New_REF_BomPas.$chr.multihetseq.txt
done

exit 0

# I - use unphased vcf files
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Bompas.New_REF_BomPas.sort.marked_dups.bam.1.msmc_mask.bed.gz \
    --mask $mappability_path/Bombus_pascuorum-GCA_905332965.1-softmasked.bed \
    $called_mask_path/Bompas.New_REF_BomPas.sort.marked_dups.bam.1.msmc_masked.vcf.gz \
    > $multihetsep_output/Bompas.New_REF_BomPas.chr_1.multihetseq.txt

for chr in {011..592};do /home/yzliu/bin/msmc/msmc-tools/generate_multihetsep.py \
    --chr contig_$chr --mask $called_mask_path/M_L013.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \
    --mask $called_mask_path/M_L054.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/M_L211.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/M_L224.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/BH_08.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/BH_16.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/M_L028.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/M_L043.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/M_L060.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/AC-012.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/WO_004.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/WO_448.sorted_marked_dups.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/120_S_Bor_6_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/262_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/612_S_Pen_18_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/727_S_Qua_21_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/859_S_Niw_25_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/72_S_Bor_2_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/300_S_Hor_10_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/586_S_Pen_17_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $called_mask_path/780_S_Qua_22_W.sorted.marked_dupes.rg.bam.contig_$chr.out_mask.bed.gz \ 
    --mask $mapability_path/syl_35_90.contig_$chr.mask.bed.gz \
    ./M_L013.vcf.gz ./M_L054.vcf.gz ./M_L211.vcf.gz ./M_L224.vcf.gz ./BH_08.vcf.gz ./BH_16.vcf.gz ./M_L028.vcf.gz ./M_L043.vcf.gz ./M_L060.vcf.gz ./AC-012.vcf.gz ./WO_004.vcf.gz ./WO_448.vcf.gz ./120_S_Bor_6_W.vcf.gz ./262_S_Hor_10_W.vcf.gz ./612_S_Pen_18_W.vcf.gz ./727_S_Qua_21_W.vcf.gz ./859_S_Niw_25_W.vcf.gz ./72_S_Bor_2_W.vcf.gz ./300_S_Hor_10_W.vcf.gz ./586_S_Pen_17_W.vcf.gz ./780_S_Qua_22_W.vcf.gz \
    > ./contig_001_592_multihetseq/mon6_lap6_inc5_syl4.contig_$chr.multihetseq.txt; done


exit 0

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

