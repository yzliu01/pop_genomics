#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 150g
##SBATCH --array=4%1
#SBATCH --array=1,3-4%3
##SBATCH --time=00:10:00
#SBATCH --time=10:10:00
#SBATCH --job-name=bee_pools_psmc_hifi_Hae_Mar_Pas_Vet
#SBATCH --error=bee_pools_psmc_hifi_Hae_Mar_Pas_Vet.%A_%a.e
#SBATCH --output=bee_pools_psmc_hifi_Hae_Mar_Pas_Vet.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping for bcftools
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## psmc
#https://github.com/lh3/psmc
#https://psmc-tutorial-birdlab.readthedocs.io/en/latest/01_Data_Pre-Processing.html#j-creating-consensus-fq-file
#https://blog.csdn.net/zaprily/article/details/108764219
#https://gtpb.github.io/PGDH19/pages/ms-psmc_practical; https://github.com/willyrv/ms-PSMC

# test
#SLURM_ARRAY_TASK_ID=4

ref_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome
ref_list=(
    "Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa"
    "Andrena_marginata_GCA_963932335.1-softmasked.fa"
    "Bombus_pascuorum-GCA_905332965.1-softmasked.fa"
    "Bombus_veteranus.hifi_asm_pl2.fa"
)
ref=$(echo ${ref_list[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)
#echo $ref

input_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/output_bam_psmc
# Bash does not support inline comments within an array definition like that. 
# The comment (# meandepth 12.8x) will be treated as part of the value, which can cause errors.
in_bam_list=(
    "AndHae_hifi_asm.aligned.bam"
    "AndMar_hifi_asm.aligned.bam"
    "BomPas_hifi_asm.aligned.bam"
    # meandepth 12.8x
    "BomVet_hifi_asm.aligned.bam"
)
in_bam=$(echo ${in_bam_list[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)

# generate consensus fq file from bam files
psmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output
cd $psmc_output
#output_fq=${in_bam//}
## earlier test problem ? mappability is for msmc
## https://github.com/samtools/bcftools/issues/391
## using samtools/bcftools 1.0 or greater, which means you should be using call rather than view.
#samtools view -b -L $mappability_path/mappability_pas.copy.bed $bam_pas | \
#    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | \
#    vcfutils.pl vcf2fq -d 200 -D 1500 | gzip > $psmc_output/pas_REF_pas_DP200_1500x.vcf2fq.fq.gz

# Here option -d sets and minimum read depth and -D sets the maximum. It is
# recommended to set -d to a third of the average depth and -D to twice.
# use the example of "BomVet_hifi_asm.aligned.bam" # meandepth 12.8x [5,30]

# value of -d and -D
d_one_third_mean_depth=(18 38 41 4)
d_depth=$(echo ${d_one_third_mean_depth[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)
D_twice_mean_depth=(112 232 250 26)
D_depth=$(echo ${D_twice_mean_depth[@]} | tr " " "\n" | sed -n ${SLURM_ARRAY_TASK_ID}p)
# calculated from: 2_minimap2_samtools_qualimap_sam_stats_cov.sh
#AndHae_hifi_asm.aligned.bam.samtools.cov:  99.7685 55.4087
#AndMar_hifi_asm.aligned.bam.samtools.cov:  99.9983 115.417
#BomPas_hifi_asm.aligned.bam.samtools.cov:  99.9783 124.556
#BomVet_hifi_asm.aligned.bam.samtools.cov:  99.9481 12.8501

## index bam file if bam files are not indexed
#samtools index BomVet_hifi_asm.aligned.bam

#samtools mpileup -C 50 -f $ref_dir/$ref $input_dir/$in_bam | head -1000 > $in_bam.intermediate.mpileup
# https://github.com/samtools/bcftools/wiki/HOWTOs#consensus-calling (outdated)

# below is right
# samtools mpileup --help # get underneath info
# Note that using "samtools mpileup" to generate BCF or VCF files has been
# removed.  To output these formats, please use "bcftools mpileup" instead.
# :[mpileup] maximum number of reads per input file set to -d 250
#bcftools mpileup -C 50 -f $ref_dir/$ref $input_dir/$in_bam | head -1000 > $in_bam.intermediate.mpileup

# BomVet_hifi_asm.aligned.bam.intermediate.mpileup
#head $in_bam.intermediate.mpileup
#ptg000001l      1       T       0       *       *
#ptg000001l      2       T       0       *       *
#ptg000001l      3       T       0       *       *
#ptg000001l      4       G       1       ,       D

#bcftools call -c $in_bam.intermediate.mpileup > $in_bam.intermediate.mpileup.vcf
#bcftools call -c $in_bam.intermediate.mpileup | head -10
#bcftools call -c BomVet_hifi_asm.aligned.bam.intermediate.mpileup | head -10

#bam=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/output_bam_psmc/AndHae_hifi_asm.aligned.bam
#ref=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa
#bcftools mpileup -C 50 -f $ref $bam | bcftools call -c | \
#    vcfutils.pl vcf2fq -d 5 -D 40 | gzip > $bam.fq.gz

bcftools mpileup -C 50 -f $ref_dir/$ref $input_dir/$in_bam | bcftools call -c | \
    vcfutils.pl vcf2fq -d $d_depth -D $D_depth | gzip > $in_bam.fq.gz

# prepare psmcfa files
conda activate psmc
#utiles_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/psmc/utils
#$utiles_tools/fq2psmcfa -q20 $pas_REF_pas_DP200_1500x_fq > pas_REF_pas_DP200_1500x.psmcfa
in_bam_fq_file=$in_bam.fq.gz
out_psmcfa_file=${in_bam_fq_file/.gz/}
fq2psmcfa -q20 $in_bam_fq_file > $out_psmcfa_file.psmcfa

#psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o pas_REF_pas_DP200_1500x.psmc pas_REF_pas_DP200_1500x.psmcfa 
#psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o pas_REF_pas_DP200_1500x.consense.psmc pas_REF_pas_DP200_1500x.consense.psmcfa 
#utils/psmc2history.pl diploid.psmc | utils/history2ms.pl > ms-cmd.sh
#utils/psmc_plot.pl diploid diploid.psmc


## bootstrap

## convert interleved lines to single line
## https://www.ecseq.com/support/ngs-snippets/convert-interleaved-fasta-files-to-single-line
## https://www.biostars.org/p/76376/#76394
#awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' pas_REF_pas_DP200_1500x.split.psmcfa | less -S > pas_REF_pas_DP200_1500x.split.one_line_seq.psmcfa

# run splitfa to split long chromosome sequences to short segments
# not spliting
#$utiles_tools/splitfa pas_REF_pas_DP200_1500x.psmcfa > $psmc_output/bootstrap/pas_REF_pas_DP200_1500x.split.psmcfa
## spliting
#$utiles_tools/splitfa pas_REF_pas_DP200_1500x.psmcfa 100000 > $psmc_output/bootstrap/pas_REF_pas_DP200_1500x.split_100000.psmcfa
splitfa $out_psmcfa_file.psmcfa 100000 > ./bootstrap/$out_psmcfa_file.split_100000.psmcfa

## 20 rounds of bootstrapping
cd $psmc_output/bootstrap
psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o $out_psmcfa_file.psmc $out_psmcfa_file.psmcfa
# 20 rounds of bootstrapping
seq 20 | xargs -i echo psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" \
	    -o round-{}.$out_psmcfa_file.split_100000.psmc $out_psmcfa_file.split_100000.psmcfa | sh

cat $out_psmcfa_file.psmc round-{}.$out_psmcfa_file.split_100000.psmc > $out_psmcfa_file.combined.psmc


exit 0

## plot issues ?
$utiles_tools/psmc_plot.pl -pY50000 combined combined.psmc
conda activate gnuplot
$utiles_tools/psmc_plot.pl -S -R -u 3.6e-09 -g 1 ../pas_REF_pas_DP200_1500x.psmc.plot ../pas_REF_pas_DP200_1500x.combined.psmc

$utiles_tools/psmc_plot.pl -R -u 3.6e-09 -g 1 -p pas_REF_pas_DP200_1500x.combined.psmc.plot pas_REF_pas_DP200_1500x.combined.psmc

## errors
Can't find PostScript prologue file prologue.ps
        loadpath is empty
        gnuplotrc is read from /anaconda/envs/_build/share/gnuplot/5.0
Please copy prologue.ps to one of the above directories
or set the environmental variable GNUPLOT_PS_DIR
or set the loadpath appropriately
         line 0: Plot failed!

Can't exec "epstopdf": No such file or directory at /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/psmc/utils/psmc_plot.pl line 236, <> line 11634.

******************************************************************************************

bam_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
bam_pas=Bompas.New_REF_BomPas.sort.marked_dups.bam
#bam_vet=Bomvet.New_REF_BomPas.sort.marked_dups.bam
mappability_path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/ref_masked_bed
REF=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/Bombus_pascuorum-GCA_905332965.1-softmasked.fa
psmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output
cd $bam_dir
bam_list=(
        #"Andhae.New_REF_BomPas.sort.marked_dups.bam"
        "Bompas.New_REF_BomPas.sort.marked_dups.bam"
        #"Andmar.New_REF_BomPas.sort.marked_dups.bam"
        "Bomvet.New_REF_BomPas.sort.marked_dups.bam")
bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_ID}p)
#bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n 2p)

bam_output=${bam_list/.sort.marked_dups.bam/}

# aligned depth from qualimap
# A. haemorrhoa 550 1/3=183 2x=1100
# A. marginata  500 1/3=167 2x=1000
# B. pascuorum  500 1/3=167 2x=1000
# B. veteranus  550 1/3=183 2x=1100
#
samtools view -b -L $mappability_path/mappability_pas.bed.gz $bam | \
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | \
    vcfutils.pl vcf2fq -d 200 -D 1500 | gzip > $psmc_output/$bam_output.vcf2fq_test.fq.gz
    ## convert vcf file to fasta file using vcfutils.pl coming with bcftools not in psmc
    ## vcfutils.pl not supported anymore ??
    #less -S | gzip > $psmc_output/pas_REF_pas_DP1500x.vcf.gz
    #bcftools consensus -m $mappability_path/mappability_pas.bed.gz 

exit 0

## make consensus file
vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
bcftools index $vcf_dir/concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP400_noMS_AO3.vcf.gz
cat $REF | bcftools consensus $vcf_dir/concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP600_noMS_AO3.vcf.gz > \
    concated.Andhae.New_REF_BomPas.DP600x_consensus.fa

Applied 1757 variants (600x)
Applied 12504 variants (400x)

exit 0

******************************************************************************************



samtools view -b -L $mappability_path/mappability_pas.bed.gz $bam_pas | \
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | less -S \
    | gzip > $psmc_output/pas_REF_pas_DP1500x.vcf.gz

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
