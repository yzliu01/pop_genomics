

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
