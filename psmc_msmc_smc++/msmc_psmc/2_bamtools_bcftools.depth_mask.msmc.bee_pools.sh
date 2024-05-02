#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 3g
#SBATCH --array=1-6%6
#SBATCH --time=16:10:00
#SBATCH --error=cal_ave_depth_each_chr.%A_%a.e
#SBATCH --output=cal_ave_depth_each_chr.%A_%a.o
#SBATCH --job-name=cal_ave_depth_each_chr
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping
## run msmc2 (weird)
#msmc2_Linux

msmc2_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
#REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
#REF_fai=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
#chr=`cut -f 1 $REF_fai`

REF_list=(
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa"
    #"Bombus_hypnorum-GCA_911387925.1-softmasked.fa"
    #"Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa"
    #"Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa"
)

REF_fai_list=(
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai"
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai"
    "Andrena_hattorfiana-GCA_944738655.1-softmasked.fa.fai"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa.fai"
    #"Bombus_hypnorum-GCA_911387925.1-softmasked.fa.fai"
    #"Apis_mellifera_HAv-GCF_003254395.2-softmasked.fa.fai"
    #"Drosophila_melanoganster-GCF_000001215.4_Release_6_plus_ISO1_MT_genomic-softmasked.fa.fai"
)
#chr_list=`cut -f 1 ${REF_fai_list[*]}`

bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_list=(
        "Bomvet.New_REF_BomPas.sort.marked_dups.bam"
        "Bompas.New_REF_BomPas.sort.marked_dups.bam"
        "Andhae.New_REF_AndHae.sort.marked_dups.bam"
        "Andmar.New_REF_AndHae.sort.marked_dups.bam"
        "Andmar.New_REF_AndHat.sort.marked_dups.bam"
        "Andmar.New_REF_AndMar.sort.marked_dups.bam"
)

output_msmc_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
cd $output_msmc_mask
msmc_mask_output_vcf=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf
samtools_DP=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats

## generate bed file for each chromosome
## https://github.com/stschiff/msmc-tools/tree/master

test() {
for chr in ${chr[*]}
    do
    #echo $chr
    for bam in ${bam_list[*]}
        do
    bcftools mpileup -q 20 -Q 20 -C 50 -r $chr -f $REF $bam_dir/$bam | bcftools call -c -V indels |
    $msmc2_tools/bamCaller.py 200 $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz
    done
done
}

*********************************************************************************************
## calculate average depth
calculate_average_depth() {
    for bam in ${bam_list[*]}
## for specifi bam
#for bam in ${bam_list[2]}
    do
    #echo $i
    echo $bam
    chr_list=`cut -f 1 $REF_dir/${REF_fai_list[i]}`
    #chr_list=`cut -f 1 $REF_dir/${REF_fai_list[2]}`
    for chr in ${chr_list}
        do
        echo "Mean depth chr_$chr:" | tr '\n' '\t' > $samtools_DP/$bam.ave.DP
        samtools depth -r $chr $bam_dir/$bam | awk '{sum += $3} END {print sum / NR}' >> $samtools_DP/$bam.ave.DP
    done
done
}

## for all to make bed for each chromosome
test() {
for chr in ${chr_list}
    do
    if [ $chr == "CALYFQ010000008.1" ]
    then
    echo $chr
    fi
done
}
## assign average depth
## vet-pas pas-pas hae-hae mar-hae mar-hat mar-mar
average_depth=(545 450 550 425 410 520)

#echo ${average_depth[*]}
make_bed_each_chr() {
for i in ${!bam_list[*]}
    do
    #echo $i
    ave_depth=${average_depth[i]}
    echo ${bam_list[i]}
    chr_list=`cut -f 1 $REF_dir/${REF_fai_list[i]}`
    for chr in ${chr_list}
        do
        REF=${REF_fai_list[i]/.fai/}
        echo $REF
        echo "chr_$chr"
        #echo $chr_list
        #echo ${bam_list[i]}.${chr_list[j]}
    #done
#done
        bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r $chr -f $REF_dir/$REF $bam_dir/${bam_list[i]} | bcftools call -c -V indels |
        $msmc2_tools/bamCaller.py $ave_depth $output_msmc_mask/${bam_list[i]}.$chr.msmc_mask.bed.gz | gzip -c > \
        $msmc_mask_output_vcf/${bam_list[i]}.$chr.msmc_masked.vcf.gz
    done
done
}

#calculate_average_depth
#make_bed_each_chr

## array jobs
#SLURM_ARRAY_TASK_ID=6
## array_task_id: 1,2,3,4,5,6
REF_fai=$(echo ${REF_fai_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
REF=${REF_fai/.fai/}
bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
depth=$(echo ${average_depth[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

#echo $REF_fai
#echo $REF
#echo $bam
#echo $depth

for chr in `cut -f 1 $REF_dir/${REF_fai[*]}`
    do
    #REF=${REF_fai/.fai/}
    echo -e "\n****\n$REF_fai"
    echo $REF
    echo $bam
    echo $depth
    echo -e "chr_$chr\n****\n"
#done
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -r $chr -f $REF_dir/$REF $bam_dir/$bam | bcftools call -c -V indels |
    $msmc2_tools/bamCaller.py $depth $output_msmc_mask/$bam.$chr.msmc_mask.bed.gz | gzip -c > \
    $msmc_mask_output_vcf/$bam.$chr.msmc_masked.vcf.gz
done


exit 0

*********************************************************************************************
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


*********************
## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh

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
conda activate variant_calling_mapping
## run msmc2 (weird)
#msmc2_Linux