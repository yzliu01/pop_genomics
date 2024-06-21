

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

## 200G 300G sim
## delete *15Mb_1.par etc
rm *15Mb_*.par

for i in `ls ft_sim_1000000Ne*_1E_50G*.par`;do cp $i $i.cp;done
rename 50G 200G ft_sim_1000000Ne*_1E_50G*.par.cp

for i in `ls ft_sim_1000000Ne*_1E_50G*.par`;do cp $i $i.cp;done
rename 50G 300G ft_sim_1000000Ne*_1E_50G*.par.cp

for i in `ls ft_sim_1000000Ne*_1E_200G*.par.cp`;do sed -i '13s/50 0/200 0/' $i;done
for i in `ls ft_sim_1000000Ne*_1E_300G*.par.cp`;do sed -i '13s/50 0/200 0/' $i;done

## change par file names
rename ".cp" "" ft_sim_1000000Ne*_1E_*.par.cp

cd ../1000000Ne_new/
for i in `ls *100_500*.par`;do cp $i $i.cp;done

ls *100G_2e_*_cons*.par
ls *100G_10e_*_cons*.par

## ******************** combine two separate simulations ************************
## sum of column
awk -F " " 'NR > 7 && NR < 10 {sum+=$2}END{print sum}' $BomVet_BomPas_COV
less qualimap_mean_CocDP.txt | awk '{count++; Sum += $2} END {print Sum/count}'

## sum of each row
sfs_file_11_20=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep/ft_sim_1000000Ne_20hapS_1E_500G_10e_i_cons_11_20Chr_15Mb/ft_sim_1000000Ne_20hapS_1E_500G_10e_i_cons_11_20Chr_15Mb_MAFpop0.obs
sfs_file_10=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep/ft_sim_1000000Ne_20hapS_1E_500G_10e_i_cons_10Chr_15Mb/ft_sim_1000000Ne_20hapS_1E_500G_10e_i_cons_10Chr_15Mb_MAFpop0.obs

## each column +i
awk '{c=0;for(i=1;i<=NF;++i){c+=$i};print $0, "Sum:", c}' $sfs_file

******************************* combining solution **************************************
## chatGPT "add values in each column in the same rows from the second row in two files in linux and meanwhile keeping header line"
paste $sfs_file_10 $sfs_file_11_20 | awk '{for (i=1; i<=NF/2; i++) printf "%d ", $i + $(i+NF/2); printf "\n"}'

## keep space after "{ }"
## space-separated
{ head -n 2 $sfs_file_10; paste <(tail -n +3 $sfs_file_10) <(tail -n +3 $sfs_file_11_20) | awk '{for (i=1; i<=NF/2; i++) printf "%d ", $i + $(i+NF/2); printf "\n"}'; } > combined_data_1MNe_500G_10e_i_con_20Chr_15Mb.MAF.obs
## tab-separated
{ head -n 2 $sfs_file_10; paste <(tail -n +3 $sfs_file_10) <(tail -n +3 $sfs_file_11_20) | awk '{for (i=1; i<=NF/2; i++) printf "%s\t ", $i + $(i+NF/2); printf "\n"}'; } > combined_data_1MNe_500G_10e_i_con_20Chr_15Mb.MAF.obs


## combine sfs from two separate simulations
Ne_1M=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1000000Ne_5rep
Ne_1M_200G_300G=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/1MNe_200_300G
cd $Ne_1M
ls -td $Ne_1M/ft_sim_1000000Ne_200hapS_1E*10e_i_cons*15Mb | head -n 8

for hap in "200hapS" "80hapS"
    do
    ## for planned simulations
    #for gen in "1000G" "500G" "100G" "50G"
    ## for 300G and 200G simulations
    for gen in "300G" "200G"
        do
        #echo $hap"_"$gen
    #done
#done
        sfs_file_10Chr_folder=$Ne_1M/ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_10Chr_15Mb
        sfs_file_10Chr_MAF=ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_10Chr_15Mb_MAFpop0.obs
        sfs_file_11_20Chr_folder=$Ne_1M/ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_11_20Chr_15Mb
        sfs_file_11_20Chr_MAF=ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_11_20Chr_15Mb_MAFpop0.obs
        sfs_file_20Chr_folder=$Ne_1M/ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_20Chr_15Mb
        ## Ne_1M_200G_300G
        sfs_file_200_300G_20Chr_folder=$Ne_1M_200G_300G/ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_20Chr_15Mb
        ## output conbined sfs file
        sfs_file_20Chr_MAF_output=ft_sim_1000000Ne_"$hap"_1E_"$gen"_10e_i_cons_20Chr_15Mb_MAFpop0.obs
        ## use paste and awk to combine two dataset of sfs and sum each simulation and output it to the previously unsuccessful simulation for 80 and 200 haploids for 1 million Ne
        ## keep the header of one of the simulation, first two lines
        
        ## for planned simulations
        #{ head -n 2 $sfs_file_10Chr_folder/$sfs_file_10Chr_MAF; paste <(tail -n +3 $sfs_file_10Chr_folder/$sfs_file_10Chr_MAF) <(tail -n +3 $sfs_file_11_20Chr_folder/$sfs_file_11_20Chr_MAF) | \
        #awk '{for (i=1; i<=NF/2; i++) printf "%s\t ", $i + $(i+NF/2); printf "\n"}'; } > $sfs_file_20Chr_folder/$sfs_file_20Chr_MAF_output
        
        ## for 300G and 200G simulations
        { head -n 2 $sfs_file_10Chr_folder/$sfs_file_10Chr_MAF; paste <(tail -n +3 $sfs_file_10Chr_folder/$sfs_file_10Chr_MAF) <(tail -n +3 $sfs_file_11_20Chr_folder/$sfs_file_11_20Chr_MAF) | \
        awk '{for (i=1; i<=NF/2; i++) printf "%s\t ", $i + $(i+NF/2); printf "\n"}'; } > $sfs_file_200_300G_20Chr_folder/$sfs_file_20Chr_MAF_output
    done
done

