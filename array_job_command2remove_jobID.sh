

## array batch job bash different ranges
#SBATCH --array=4,8,12,16-48:2

ls *30029690_[2-6][0-9]*txt | tail -n +3 | xargs rm
ls *30207955_[0-9]{2..5}*.o.txt
ls | egrep *30207955_[0-9]{2}*.o.txt
ls | egrep *.30207955_[0-9]{2}*.o.txt
ll -v *.txt | egrep "aa_[0-9]+.txt"

ls | grep -E *30207955_[0-9]{3}.*.txt | xargs rm

ls -d -- *[!0-9][0-9].txt
# The ! at the beginning of the group complements its meaning.