
## slurm session
srun --account eDNA -c 10 --pty bash
srun --account eDNA -t 10:00:00 --mem 16g --pty bash

## terminal test issue
## https://stackoverflow.com/questions/52026652/openblas-blas-thread-init-pthread-create-resource-temporarily-unavailable
OpenBLAS blas_thread_init: pthread_create failed for thread 53 of 64: Resource temporarily unavailable
OpenBLAS blas_thread_init: RLIMIT_NPROC 1000 current, 1000 max

export OPENBLAS_NUM_THREADS=1


## squeue sort
squeue -u yzliu | sort -t "t" -k1 -h
## check unfinished job
ls *35671660*.e* | xargs egrep 'CANCELLED|kill' | sort -V | head

## check if job finished
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script/data_process/fb_variant_calling_each_group_1500_x/only_report_var
grep -E 'CANCELLED|kill' *35265444*.e

## find file in a directory
find . -type f -path "*.fai" -print
./Bombus_hypnorum-GCA_911387925.1-softmasked.N.fa.fai

## pending jobid
squeue -u yzliu |  sort -Vr
squeue -j 36356255
squeue -u yzliu -h -t pending,running -r

squeue -u yzliu -h -t pending,running -r | grep '36356255'


sed -i -e 's/--mem\ 150g/--mem\ 250g/' -e 's/--time=07:00/--time=12:00/' *regions.short.sh*

## array batch job bash different ranges
#SBATCH --array=4,8,12,16-48:2

ls *30029690_[2-6][0-9]*txt | tail -n +3 | xargs rm
ls *30207955_[0-9]{2..5}*.o.txt
ls | egrep *30207955_[0-9]{2}*.o.txt
ls | egrep *.30207955_[0-9]{2}*.o.txt
ll -v *.txt | egrep "aa_[0-9]+.txt"
## display two digits
ls | grep -E *30207955_[0-9]{3}.*.txt | xargs rm

ls -d -- *[!0-9][0-9].txt
# The ! at the beginning of the group complements its meaning.

https://stackoverflow.com/questions/8467424/echo-newline-in-bash-prints-literal-n
echo -e "######  bamtools stats: $File1 ######\n"
printf "######  bamtools stats: $File1 ######\n"

## create link to a file in a directory
ln /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_clean_fastq/SRR24680791_1.fastq.clean.gz .
## cteate symbolic link/symbolic in the current dir
ln -s /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/empirical_drosophila_clean_fastq/SRR24680791_1.fastq.clean.gz .
