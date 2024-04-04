#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 10g
##SBATCH --array=1-10%10
#SBATCH -t 12:00:00
#SBATCH -J bcftools_mpileup_bam_mask_msmc.AndHae_AndMar_New_REF_AndHae
#SBATCH --error=bcftools_mpileup_bam_mask_msmc.AndHae_AndMar_New_REF_AndHae.%A.e
#SBATCH --output=bcftools_mpileup_bam_mask_msmc.AndHae_AndMar_New_REF_AndHae.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping for bcftools
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## formal for 12 bee pools
msmc2_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai
chr_list=`cut -f 1 $REF_fai`
#chr=$(cut -f 1 $REF_fai | sed -n ${SLURM_ARRAY_TASK_ID}p)
## cut -f 1 $REF_fai | wc -l
## 402

## ls *New_REF_*.sort.marked_dups.bam
bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_list=(
        "Andhae.New_REF_AndHae.sort.marked_dups.bam"
        "Andmar.New_REF_AndHae.sort.marked_dups.bam"
        #"Andhae.New_REF_BomPas.sort.marked_dups.bam"
        #"Bompas.New_REF_BomPas.sort.marked_dups.bam"
        #"Andmar.New_REF_BomPas.sort.marked_dups.bam"
        #"Bomvet.New_REF_BomPas.sort.marked_dups.bam"
        )
#bam=${echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p}

output_msmc_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
cd $output_msmc_mask
msmc_mask_output_vcf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf

#out_bam_name=${bam/.sort.marked_dups.bam/}

#bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels | \
#    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > \
#    $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz

#exit 0

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

