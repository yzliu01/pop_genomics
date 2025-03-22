
## all: checked methods
input_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $input_sfs_dir
#ls -t concated.AndHae*P_[0-1][0-9].equal_self.sfs | sort -V
## downsample genome
out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates

# delete old sfs files
rm $out_sfs_dir/*.sfs

for species in {Hae,Mar,Pas,Vet};do ## downsample genome
    ## different sort orders
    ## downsample genome
    sfs1=`find -maxdepth 1 -print | grep "$species" | egrep P_[0-1][0-9] | grep "equal_self.sfs$" | sort -V`
    ## downsample reads
    sfs2=`find -maxdepth 1 -print | grep "xxxxx_old_script" | sort -V`
# species: Hae
    if [ "$species" = "Hae" ];then
        for file_name in $sfs1;do
            #    echo -e "\n"
            new_file_name=${file_name//}
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-41 >> $out_sfs_dir/"$species"_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
            
            ## delete old files
            # ls $out_sfs_dir/*hapS_5rep_*00d*_final* | grep -v '200_300G' | xargs rm
        done
        
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-41 >> $out_sfs_dir/"$species"_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done

# species: Mar
    elif [ "$species" = "Mar" ];then
        for file_name in $sfs1;do
            # empty sfs data for 10x
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-42 >> $out_sfs_dir/"$species"_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-42 >> $out_sfs_dir/"$species"_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done

# species: Pas
    elif [ "$species" = "Pas" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-36 >> $out_sfs_dir/"$species"_34_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-36 >> $out_sfs_dir/"$species"_34_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done
    else

# species: Vet
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_1000000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs;
        done

    fi
done
