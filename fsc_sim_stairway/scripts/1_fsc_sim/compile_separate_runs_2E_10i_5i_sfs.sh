
path=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd $path
## variable not start with number
hapS_20=`find -maxdepth 2 | egrep '20hapS.*10i_5i.*15Mb_[1-5]_MAFpop0.obs'`

## https://stackoverflow.com/questions/17181787/how-to-use-variables-in-a-bash-for-loop
## https://stackoverflow.com/questions/36223802/store-for-loop-results-as-a-variable-in-bash
## variable in for-loop
sed -n '1,3p' ./ft_sim_10000Ne_80hapS_2E_100_500G_10i_5i_20Chr_15Mb_3/ft_sim_10000Ne_80hapS_2E_100_500G_10i_5i_20Chr_15Mb_3_MAFpop0.obs
## delete older file
rm ./ft_sim_10000Ne_20hapS_2E_100_500G_10i_5i_20Chr_15Mb/compiled_hapS_20_10i_5i.new.sfs
for group in {20,80,200};do
    for rep in {1..5};do
        if [ $rep == 1 ];then
            ## attention to use dollor sign for variables in conditional expression
            ## grep regex: https://www.cyberciti.biz/faq/grep-regular-expressions/
            rep_1=`find -maxdepth 2 | egrep ""$group"hapS.*10i_5i.*15Mb_"$rep"_MAFpop0.obs"`
            sed -n '1,3p' $rep_1 >> ./ft_sim_10000Ne_"$group"hapS_2E_100_500G_10i_5i_20Chr_15Mb/compiled_20_80_200_hapS_20_10i_5i.sfs
            ## for debug
            #echo "xxx xxx" >> ./ft_sim_10000Ne_20hapS_2E_100_500G_10i_5i_20Chr_15Mb/compiled_hapS_20_10i_5i.new.sfs
            #awk 'NR >=1 && NR <= 3' $rep_1 >> ./ft_sim_10000Ne_20hapS_2E_100_500G_10i_5i_20Chr_15Mb/compiled_hapS_20_10i_5i.sfs
        else
            rep_2_5=`find -maxdepth 2 | egrep ""$group"hapS.*10i_5i.*15Mb_"$rep"_MAFpop0.obs"`
            awk 'NR == 3' $rep_2_5 >> ./ft_sim_10000Ne_"$group"hapS_2E_100_500G_10i_5i_20Chr_15Mb/compiled_20_80_200_hapS_20_10i_5i.sfs
        fi
    done
done




unfinished_par=$(
for rep in $(eval echo $hapS_20);do
    if awk 'NR >=1 && NR <= 3' $path/$rep;
done
)

# eva
# Make a new file containing only the header
head -n1 tmp/taxonomy/taxonomy.1.txt > results/classified.txt
# Append all the taxonomy files to the new file without including the header of each file

for fname in tmp/taxonomy/taxonomy*.txt
do
    tail -n +2 $fname >> results/classified.txt
done