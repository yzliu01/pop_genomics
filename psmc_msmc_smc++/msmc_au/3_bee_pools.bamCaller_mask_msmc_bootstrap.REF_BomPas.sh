#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 10g
##SBATCH --array=1-10%10
#SBATCH -t 12:00:00
#SBATCH -J bcftools_mpileup_bamCaller_mask_msmc.BomPas_BomVet_New_REF_BomPas
#SBATCH --error=bcftools_mpileup_bamCaller_mask_msmc.BomPas_BomVet_New_REF_BomPas.%A.e
#SBATCH --output=bcftools_mpileup_bamCaller_mask_msmc.BomPas_BomVet_New_REF_BomPas.%A.o
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
#bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)

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

## Bompas_REF_BomPas
for chr in ${chr_list[*]}
    do
    /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/mappability_pas.bed.gz \
    $called_mask_path/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Bompas.New_REF_BomPas.$chr.multihetseq.txt
done

## Bomvet_REF_BomPas
for chr in ${chr_list[*]}
    do
    /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Bomvet.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/mappability_pas.bed.gz \
    $called_mask_path/Bomvet.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Bomvet.New_REF_BomPas.$chr.multihetseq.txt
done

## move non-empty file to a folder
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output
for i in `find . -maxdepth 1 -name 'Bompas*.txt' -size +0`;
    do cp $i ./non_empty;
done

for i in `find . -maxdepth 1 -name 'Bomvet*.txt' -size +0`;
    do cp $i ./non_empty;
done

## bootstrap
#https://doi.org/10.1007/978-1-0716-0199-0_7
# MSMC and MSMC2: The Multiple Sequentially Markovian Coalescent
##REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
msmc2_tools_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
msmc_input_files=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output/non_empty
cd $bootstrap_output
## pas
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/BomPas_REF_bootstrap $msmc_input_files/Bompas.New_REF_BomPas.*.multihetseq.txt

## vet
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/BomVet_REF_bootstrap $msmc_input_files/Bomvet.New_REF_BomPas.*.multihetseq.txt


exit 0

# I - use unphased vcf files on the 1st chromosome
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Bompas.New_REF_BomPas.sort.marked_dups.bam.1.msmc_mask.bed.gz \
    --mask $mappability_path/mappability_pas.bed.gz  \
    $called_mask_path/Bompas.New_REF_BomPas.sort.marked_dups.bam.1.msmc_masked.vcf.gz \
    > $multihetsep_output/Bompas.New_REF_BomPas.chr_1.multihetseq.txt


## psmc
#https://github.com/lh3/psmc
#https://psmc-tutorial-birdlab.readthedocs.io/en/latest/01_Data_Pre-Processing.html#j-creating-consensus-fq-file
#https://blog.csdn.net/zaprily/article/details/108764219
#https://gtpb.github.io/PGDH19/pages/ms-psmc_practical

less $mappability_path/mappability_pas.bed.gz| head
1       32253   32258
1       32265   32485
1       32514   33086
1       33128   33849
1       33907   34197
1       34235   34331
1       34461   35288
1       35325   35916
1       35962   36136
1       36163   36791
bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_pas=Bompas.New_REF_BomPas.sort.marked_dups.bam
bam_vet=Bomvet.New_REF_BomPas.sort.marked_dups.bam
mappability_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
psmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output
cd $bam_dir
samtools view -b -L $mappability_path/mappability_pas.bed.gz $bam_pas | \
    ## some filters
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | \
    ## convert vcf file to fasta file using vcfutils.pl coming with bcftools not in psmc
    vcfutils.pl vcf2fq -d 200 -D 1500 | gzip > $psmc_output/pas_REF_pas_diploid.fq.gz

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
