#!/bin/sh
#SBATCH --account eDNA
#SBATCH --cpus-per-task 4
#SBATCH --mem 2g
#SBATCH --array=1-2%2
#SBATCH -t 08:10:00
#SBATCH -J bee_pools.psmc.pas_vet_REF_BomPas
#SBATCH --error=bee_pools.psmc.pas_vet_REF_BomPas.%A_%a.e
#SBATCH --output=bee_pools.psmc.pas_vet_REF_BomPas.%A_%a.o
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping for bcftools
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## psmc
#https://github.com/lh3/psmc
#https://psmc-tutorial-birdlab.readthedocs.io/en/latest/01_Data_Pre-Processing.html#j-creating-consensus-fq-file
#https://blog.csdn.net/zaprily/article/details/108764219
#https://gtpb.github.io/PGDH19/pages/ms-psmc_practical

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
bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n ${SLURM_ARRAY_TASK_JOB}p)
bam=$(echo ${bam_list[*]} | tr ' ' '\n' | sed -n 2p)

bam_output=${bam_list/.sort.marked_dups.bam/}

samtools view -b -L $mappability_path/mappability_pas.bed.gz $bam | \
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | \
    vcfutils.pl vcf2fq -d 200 -D 1500 | gzip > $psmc_output/$bam_output.vcf2fq_test.fq.gz
    ## convert vcf file to fasta file using vcfutils.pl coming with bcftools not in psmc
    ## vcfutils.pl not supported anymore
    #less -S | gzip > $psmc_output/pas_REF_pas_DP1500x.vcf.gz
    #bcftools consensus -m $mappability_path/mappability_pas.bed.gz 

exit 0

vcf_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF
bcftools index $vcf_dir/concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP400_noMS_AO3.vcf.gz
cat $REF | bcftools consensus $vcf_dir/concated.Andhae.New_REF_BomPas.100kb_g1500x_region.sorted_chr.GQ_issue.SNP_softmasked_bi_FMT_DP600_noMS_AO3.vcf.gz > \
    concated.Andhae.New_REF_BomPas.DP600x_consensus.fa

Applied 1757 variants (600x)
Applied 12504 variants (400x)

exit 0

## problem ?
samtools view -b -L $mappability_path/mappability_pas.copy.bed $bam_pas | \
    bcftools mpileup -q 20 -Q 20 -C 50 -d 1500 -f $REF - | bcftools call -c -V indels | \
    vcfutils.pl vcf2fq -d 200 -D 1500 | gzip > $psmc_output/pas_REF_pas_DP200_1500x.vcf2fq.fq.gz


psmc_output=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/psmc_output
pas_REF_pas_DP200_1500x_fq=$psmc_output/pas_REF_pas_DP200_1500x.vcf2fq.fq.gz
pas_REF_pas_DP200_1500x_consense_fq=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/vcf/concated_vcf_each_species_REF/concated.Andhae.New_REF_BomPas.DP400x_consensus.fa
conda activate psmc
utiles_tools=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/psmc/utils
$utiles_tools/fq2psmcfa -q20 $pas_REF_pas_DP200_1500x_fq > pas_REF_pas_DP200_1500x.psmcfa
## consense
$utiles_tools/fq2psmcfa -q20 $pas_REF_pas_DP200_1500x_consense_fq > $psmc_output/pas_REF_pas_DP200_1500x.consense.psmcfa

psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o pas_REF_pas_DP200_1500x.psmc pas_REF_pas_DP200_1500x.psmcfa 
psmc -N25 -t15 -r5 -p "4+25*2+4+6" -o pas_REF_pas_DP200_1500x.consense.psmc pas_REF_pas_DP200_1500x.consense.psmcfa 

## bootstrap
## convert interleved lines to single line
## https://www.ecseq.com/support/ngs-snippets/convert-interleaved-fasta-files-to-single-line
## https://www.biostars.org/p/76376/#76394
awk '{if(NR==1) {print $0} else {if($0 ~ /^>/) {print "\n"$0} else {printf $0}}}' pas_REF_pas_DP200_1500x.split.psmcfa | less -S > pas_REF_pas_DP200_1500x.split.one_line_seq.psmcfa

$utiles_tools/splitfa pas_REF_pas_DP200_1500x.psmcfa > $psmc_output/bootstrap/pas_REF_pas_DP200_1500x.split.psmcfa
## split ?
$utiles_tools/splitfa pas_REF_pas_DP200_1500x.psmcfa 100000 > $psmc_output/bootstrap/pas_REF_pas_DP200_1500x.split_100000.psmcfa

cd $psmc_output/bootstrap
seq 5 | xargs -i echo psmc -N25 -t15 -r5 -b -p "4+25*2+4+6" \
	    -o round-{}.psmc pas_REF_pas_DP200_1500x.split.psmcfa | sh

cat ../pas_REF_pas_DP200_1500x.psmc round-*.psmc > pas_REF_pas_DP200_1500x.combined.psmc

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
