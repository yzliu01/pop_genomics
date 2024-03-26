

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

## prepare plueprint files in batches
100kNe_5rep
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100000Ne_5rep/templates
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100000Ne_5rep

for sample_size in {20,80,200}
do
    for group in {"cons","1.1i","1.5i","1.9i","2e_i_cons","2e_d_cons","10e_i_cons","10e_d_cons"}
    do
        for time in {50,100,500,1000}
        do
            for i in {1..5}
            do
                temp_blueprint=$dir/ft_sim_100000Ne_"$sample_size"hapS_1E_50G_cons_20Chr_15Mb_0.blueprint
                #echo "$sample_size"-"$group"-"$time"-"$i"
                cp "$temp_blueprint" ./ft_sim_100000Ne_"$sample_size"hapS_1E_"$time"G_"$group"_20Chr_15Mb_"$i".blueprint
            done
        done
    done
done

## 2 event
for sample_size in {20,80,200}
do
    for group in {"2i_2i","10d_10d","2e_i_2e_d","2e_d_2e_i"}
    do
        temp_blueprint=$dir/ft_sim_100000Ne_"$sample_size"hapS_2E_100_500G_10d_10d_20Chr_15Mb_0.blueprint
        #echo "$sample_size"-"$group"-"$i"
            for i in {1..5}
            do
            cp "$temp_blueprint" ./ft_sim_100000Ne_"$sample_size"hapS_2E_100_500G_"$group"_20Chr_15Mb_"$i".blueprint
        done
    done
done

## 1MNe
cp templates
dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep/templates
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep

for sample_size in {20,80,200}
do
    for group in {"cons","1.1i","1.5i","1.9i","2e_i_cons","2e_d_cons","10e_i_cons","10e_d_cons"}
    do
        for time in {50,100,500,1000}
        do
            for i in {1..5}
            do
                temp_blueprint=$dir/ft_sim_1000000Ne_"$sample_size"hapS_1E_50G_cons_20Chr_15Mb_0.blueprint
                #echo "$sample_size"-"$group"-"$time"-"$i"
                cp "$temp_blueprint" ./ft_sim_1000000Ne_"$sample_size"hapS_1E_"$time"G_"$group"_20Chr_15Mb_"$i".blueprint
            done
        done
    done
done

## 2 event
for sample_size in {20,80,200}
do
    for group in {"2i_2i","10d_10d","2e_i_2e_d","2e_d_2e_i"}
    do
        temp_blueprint=$dir/ft_sim_1000000Ne_"$sample_size"hapS_2E_100_500G_10d_10d_20Chr_15Mb_0.blueprint
        #echo "$sample_size"-"$group"-"$i"
            for i in {1..5}
            do
            cp "$temp_blueprint" ./ft_sim_1000000Ne_"$sample_size"hapS_2E_100_500G_"$group"_20Chr_15Mb_"$i".blueprint
        done
    done
done