#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 4
#SBATCH --mem 1g
##SBATCH --array=1-10%10
#SBATCH -t 15:00:00
#SBATCH -J bcftools_mpileup_bamCaller_mask_msmc.AndHae_AndMar_New_REF_AndHae
#SBATCH --error=bcftools_mpileup_bamCaller_mask_msmc.AndHae_AndMar_New_REF_AndHae.%A.e
#SBATCH --output=bcftools_mpileup_bamCaller_mask_msmc.AndHae_AndMar_New_REF_AndHae.%A.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping for bcftools
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## formal for 12 bee pools
msmc2_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
REF_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome

REF1=Bombus_pascuorum-GCA_905332965.1-softmasked.fa
REF2=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
REF3=Andrena_hattorfiana-GCA_944738655.1-softmasked.fa
REF4=Andrena_marginata_GCA_963932335.1-softmasked.fa

REF_fai1=Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai
REF_fai2=Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai
REF_fai3=Andrena_hattorfiana-GCA_944738655.1-softmasked.fa.fai
REF_fai4=Andrena_marginata_GCA_963932335.1-softmasked.fa.fai

chr_list1=`cut -f 1 $REF_dir/$REF_fai1 | sort -V`
chr_list2=`cut -f 1 $REF_dir/$REF_fai2 | sort -V`
chr_list3=`cut -f 1 $REF_dir/$REF_fai3 | sort -V`
chr_list4=`cut -f 1 $REF_dir/$REF_fai4 | sort -V`

## initial run for generate_multihetsep
called_mask_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/msmc_mask_output_vcf
msmc_bam_mask=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask
mappability_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/SNPable
multihetsep_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output
cd $multihetsep_output

## script variable
generate_multihetsep_py=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py


## Bompas_REF_BomPas
for chr in ${chr_list1[*]}
    do
    $generate_multihetsep_py \
    --mask $msmc_bam_mask/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/REF_BomPas/ref_mappability_k35_r50.$chr.mask.bed.gz \
    $called_mask_path/Bompas.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Bompas.New_REF_BomPas.$chr.multihetseq.txt
done

## Bomvet_REF_BomPas
for chr in ${chr_list1[*]}
    do
    $generate_multihetsep_py \
    --mask $msmc_bam_mask/Bomvet.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/REF_BomPas/ref_mappability_k35_r50.$chr.mask.bed.gz \
    $called_mask_path/Bomvet.New_REF_BomPas.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Bomvet.New_REF_BomPas.$chr.multihetseq.txt
done

## AndHae_REF_AndHae
for chr in ${chr_list2[*]} # chr_list - see above
    do
    $generate_multihetsep_py \
    --mask $msmc_bam_mask/Andhae.New_REF_AndHae.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/REF_AndHae/ref_mappability_k35_r50.$chr.mask.bed.gz \
    $called_mask_path/Andhae.New_REF_AndHae.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Andhae.New_REF_AndHae.$chr.multihetseq.txt
done

## AndMar_REF_AndHat
for chr in ${chr_list3[*]}
    do
    $generate_multihetsep_py \
    --mask $msmc_bam_mask/Andmar.New_REF_AndHat.sort.marked_dups.bam.$chr.msmc_mask.bed.gz \
    --mask $mappability_path/REF_AndHat/ref_mappability_k35_r50.$chr.mask.bed.gz \
    $called_mask_path/Andmar.New_REF_AndHat.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz \
    > $multihetsep_output/Andmar.New_REF_AndHat.$chr.multihetseq.txt
done

## AndMar_REF_AndMar
## chr_name of AndMar
chr_list4=(
    'ENA|OZ010659|OZ010659.1'
    'ENA|OZ010660|OZ010660.1'
    'ENA|OZ010661|OZ010661.1'
    'ENA|OZ010662|OZ010662.1'
    'ENA|OZ010663|OZ010663.1'
    'ENA|OZ010664|OZ010664.1'
    'ENA|OZ010665|OZ010665.1'
)
## working
for chr in ${chr_list4[*]}
#for chr in 'ENA|OZ010660|OZ010660.1' 'ENA|OZ010661|OZ010661.1' 'ENA|OZ010662|OZ010662.1' 'ENA|OZ010663|OZ010663.1' 'ENA|OZ010664|OZ010664.1' 'ENA|OZ010665|OZ010665.1'
    do
    $generate_multihetsep_py \
    --mask $msmc_bam_mask/"Andmar.New_REF_AndMar.sort.marked_dups.bam.$chr.msmc_mask.bed.gz" \
    --mask $mappability_path/REF_AndMar/"ref_mappability_k35_r50.$chr.mask.bed.gz" \
    $called_mask_path/"Andmar.New_REF_AndMar.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz" \
    > $multihetsep_output/"Andmar.New_REF_AndMar.$chr.multihetseq.txt"
done

## "" must be needed for chr name with "|"
chr='ENA|OZ010659|OZ010659.1'
chr2='ENA|OZ010660|OZ010660.1'
chr3='ENA|OZ010661|OZ010661.1'
chr4='ENA|OZ010662|OZ010662.1'
chr5='ENA|OZ010663|OZ010663.1'
chr6='ENA|OZ010664|OZ010664.1'
chr='ENA|OZ010665|OZ010665.1'
for chr in $chr2 $chr3 $chr4 $chr5 $chr6 $chr7
do 
#echo $chr
#done
$generate_multihetsep_py \
    --mask $msmc_bam_mask/"Andmar.New_REF_AndMar.sort.marked_dups.bam.$chr.msmc_mask.bed.gz" \
    --mask $mappability_path/"REF_AndMar/ref_mappability_k35_r50.$chr.mask.bed.gz" \
    $called_mask_path/"Andmar.New_REF_AndMar.sort.marked_dups.bam.$chr.msmc_masked.vcf.gz" \
    > $multihetsep_output/"Andmar.New_REF_AndMar.$chr.multihetseq.txt"
done

## move non-empty file to a folder to use msmc input files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output
for i in `find . -maxdepth 1 -name 'Andhae*.txt' -size +0`;
    do cp $i ./non_empty;
done

for i in `find . -maxdepth 1 -name 'Andmar*.txt' -size +0`;
    do cp $i ./non_empty;
done

for i in `find . -maxdepth 1 -name 'BomPas*.txt' -size +0`;
    do cp $i ./non_empty;
done

for i in `find . -maxdepth 1 -name 'BomVet*.txt' -size +0`;
    do cp $i ./non_empty;
done

## bootstrap using results of all chromosomes
#https://doi.org/10.1007/978-1-0716-0199-0_7
# MSMC and MSMC2: The Multiple Sequentially Markovian Coalescent
##REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
bootstrap_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/msmc_output/bootstrap
msmc2_tools_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master
msmc_input_files=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/msmc_bam_mask/multihetsep_output/non_empty
cd $bootstrap_output
## hae - hae
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/AndHae_REF_AndHae_bootstrap $msmc_input_files/Andhae.New_REF_AndHae.*.multihetseq.txt

## mar - hae
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/AndMar_REF_AndHat_bootstrap $msmc_input_files/Andmar.New_REF_AndHat.*.multihetseq.txt

## mar - mar
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/AndMar_REF_AndMar_bootstrap $msmc_input_files/Andmar.New_REF_AndMar.*.multihetseq.txt

## pas - pas
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/BomPas_REF_BomPas_bootstrap $msmc_input_files/Bompas.New_REF_BomPas.*.multihetseq.txt

## vet - pas
python $msmc2_tools_dir/multihetsep_bootstrap.py -n 20 -s 2000000 \
    --chunks_per_chromosome 20 --nr_chromosomes 30  --seed 6 \
    $bootstrap_output/BomVet_REF_BomPas_bootstrap $msmc_input_files/Bomvet.New_REF_BomPas.*.multihetseq.txt


exit 0

# I - use unphased vcf files on the 1st chromosome
/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/msmc-tools-master/generate_multihetsep.py --chr 1 \
    --mask $msmc_bam_mask/Andhae.New_REF_AndHae.sort.marked_dups.bam.1.msmc_mask.bed.gz \
    --mask $mappability_path/mappability_hae.bed.gz  \
    $called_mask_path/Andhae.New_REF_AndHae.sort.marked_dups.bam.1.msmc_masked.vcf.gz \
    > $multihetsep_output/Andhae.New_REF_AndHae.chr_1.multihetseq.txt



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

