#!/bin/sh
#SBATCH --account eDNA
##SBATCH --cpus-per-task 20
#SBATCH --mem 50g
#SBATCH --array=1-4%4
#SBATCH --time=1-10:00:00
#SBATCH --error=get_per_site_depth.%A_%a.e
#SBATCH --output=get_per_site_depth.%A_%a.o
#SBATCH --job-name=get_per_site_depth
#SBATCH --mail-type=all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com

## activate (env) tools of variant_calling_mapping
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
conda activate variant_calling_mapping

## bam files
BAM_DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam
cd $BAM_DIR

## test
#SLURM_ARRAY_TASK_ID=1

##ls *sort.marked_dups.new.bam > bee_pools.sort.marked_dups.new.bam.list
bam_list=$(cat bee_4_pools.New_REF_bam_marked_dups.prop_genome.list | sed -n ${SLURM_ARRAY_TASK_ID}p)
#Andhae.New_REF_AndHae.sort.marked_dups.bam
#Andmar.New_REF_AndMar.sort.marked_dups.bam
#Bompas.New_REF_BomPas.sort.marked_dups.bam
#Bomvet.New_REF_BomVet.sort.marked_dups.bam

## bed dir
bed_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/ref_genome/random_prop_sample_genome
cd $bed_dir
# random sampleing
bed_list_1=$(ls Andrena_haemorrhoa-GCA_910592295.1-softmasked.fa.fai.win_*.shuf_subset_*.bed)
bed_list_2=$(ls Andrena_marginata_GCA_963932335.1-softmasked.fa.fai.win_*.shuf_subset_*.bed)
bed_list_3=$(ls Bombus_pascuorum-GCA_905332965.1-softmasked.fa.fai.win_*.shuf_subset_*.bed)
bed_list_4=$(ls Bombus_veteranus.hifi_asm_pl2.fa.fai.win_*.shuf_subset_*.bed)

bed_file_list=("${bed_list_1[@]}" "${bed_list_2[@]}" "${bed_list_3[@]}" "${bed_list_4[@]}")
# select bed file
bed_file=(${bed_file_list[SLURM_ARRAY_TASK_ID-1]})

out_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_stats
cd $out_dir

for bed in ${bed_file[@]}
do
echo "Processing BED File: $bed"
#done
out_file=${bed/.bed/.new.depth}

samtools depth $BAM_DIR/$bam_list -b $bed_dir/$bed -o $out_dir/$out_file

done
