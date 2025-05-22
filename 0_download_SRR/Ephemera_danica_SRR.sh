#!/bin/bash
#SBATCH --account eDNA
##SBATCH --cpus-per-task 12
#SBATCH --mem 60g
#SBATCH --array=1-4%4
#SBATCH --time=20:14:00
#SBATCH --error=Ephemera_danica_SRR.%A_%a.e
#SBATCH --output=Ephemera_danica_SRR.%A_%a.o
#SBATCH --job-name=Ephemera_danica_SRR
#SBATCH --mail-type=all #begin,end,fail,all
#SBATCH --mail-user=yuanzhen.liu2@gmail.com #send email notification

## install sra-tools
#conda create --name sratools sra-tools -y
## call env
source /home/yzliu/miniforge3/etc/profile.d/conda.sh
## https://stackoverflow.com/questions/61915607/commandnotfounderror-your-shell-has-not-been-properly-configured-to-use-conda
## https://github.com/rvalieris/parallel-fastq-dump
conda activate parallel-fastq-dump

## output dir
DIR=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/hifi/Ephemera_danica
cd $DIR

## test
SLURM_ARRAY_TASK_ID=1

## SRR variables
SRR_list_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/0_download_SRR/Ephemera_danica_SRR.list
#SRR=`cat fastq_SRR_49.list`
SRR=$(cat $SRR_list_dir | sed -n ${SLURM_ARRAY_TASK_ID}p)

## this function is to run the jobs in parallel
#   function pwait() {
#   while [ $(jobs -p | wc -l) -ge $1 ]; do
#   sleep $2
#   done
#   }

## create a function
#function SRR_fastq_download() {
#       pwait 20 10s
#       for id in $SRR; do
#       fastq-dump $id --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
#       done
#}

## execute the function
#SRR_fastq_download

## Array jobs
## OUTPUT_NAMES=${INTPUT_NAMES/.g.vcf.gz/.hard_filtered.g.vcf.gz} # modify file names # working
#fastq-dump $SRR --split-files --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip
parallel-fastq-dump --sra-id $SRR --threads 6 --outdir . --split-3 --skip-technical --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip

#parallel-fastq-dump --sra-id SRR24680761 --threads 6 --outdir . --split-3 --skip-technical --defline-seq '@$ac[.$si][:$sn][:$sg][:$rn] $ri' --gzip

exit 0

## faster option
## https://github.com/ncbi/sra-tools/wiki/HowTo:-fasterq-dump

## For best performance it is recommended to use 'prefetch' to download the accession
## https://github.com/ncbi/sra-tools/wiki/08.-prefetch-and-fasterq-dump
## The prefetch-tool has a default maximum download-size of 20G. If the requested accession is bigger than 20G, 
## you will need to increase that limit. You can specify an extremely high limit no matter how large the requested accession is. 
## You can also query the accession-size using the vdb-dump-tool and the --info option. 
## For instance, vdb-dump SRR000001 --info tells you how large this accession is ( among other information ).

## query the accession-size
vdb-dump SRR946749 --info 
acc    : SRR946749
path   : /faststorage/project/eDNA/yzliu/DK_proj/data/bee_proj_data/hifi/Ephemera_danica/SRR946749/SRR946749.sra
remote : https://sra-pub-run-odp.s3.amazonaws.com/sra/SRR946749/SRR946749
size   : 19,611,009,089

## lift the limit above that size
## prefetch SRR946749 --max-size 80g
prefetch SRR946749 --output-directory . --max-size 800000000000



SRR_list=(
SRR946750
SRR946749
SRR946748
SRR946747
)

for SRR in ${SRR_list[@]}
do
#echo "prefetching: $SRR"
#time prefetch $SRR --output-directory . --max-size 80g
echo "downloading: $SRR"
time fasterq-dump $SRR --threads 8 --outdir . --seq-defline '@$ac.$si [spot_name:$sn][spot_group:$sg][read_len:$rl] $ri'
#time gzip $SRR
done

## compress fastq files
## faster: pigz
time gzip *[0-9]_[1-2].fastq
time pigz -kf *[0-9]_[1-2].fastq
time pigz -k *[0-9]_[1-2].fastq

## The fasterq-dump-tool performs a split-3 operation by default. 
## split-3
#fastq-dump SRR946749 --split-3 --skip-technical
fasterq-dump SRR946749 --threads 8 --outdir . --seq-defline '@$ac[.$si][spot_name:$sn][spot_group:$sg][read_len:$rl] $ri'
#2025-05-06T13:19:14 fasterq-dump.3.0.10 err: name not found while resolving query within virtual file system module - failed to resolve accession '@$ac[.$si][:$sn][:$sg][:$rn] $ri' - Cannot resolve accession ( 404 ); ncbi_phid=939B3AE62B2EED4500005FD6576770DE.1.m_2
#2025-05-06T13:19:14 fasterq-dump.3.0.10 err: param unknown while parsing argument list within application support module - Unknown argument '--defline-seq'

fasterq-dump SRR946749 --threads 8 --outdir .

