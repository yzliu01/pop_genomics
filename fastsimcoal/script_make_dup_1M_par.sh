

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/1000000Ne

# ft_sim_1000000Ne_200hapS_1E_100G_05d_20Chr_15Mb.par
for par in `ls *.par`;do
    for rep in {1..5};do
        # copy files
        cp $par $par"_"$rep".par"
        # rename files
        rename .par_ "_" *_[1-5].par
    done
done

rm *_[1-5].par


## 10i_5i
ls *10i_5i*.par | wc -l

for par in `ls *10i_5i*.par`;do
    for rep in {1..5};do
        # copy files
        cp $par $par"_"$rep".par"
        # rename files
        rename .par_ "_" *_[1-5].par
    done
done
