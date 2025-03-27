
## all: checked methods
input_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $input_sfs_dir
#out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates
out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/2025_pools/templates

# attention to the order of files
./concated.Cerryb.REF_CerRyb.DP_1x.equal_self.sfs
./concated.Cerryb.REF_CerRyb.DP_3x.equal_self.sfs
./concated.Cerryb.REF_CerRyb.DP_5x.equal_self.sfs
./concated.Cerryb.REF_CerRyb.DP_7x.equal_self.sfs
./concated.Cerryb.REF_CerRyb.DP_10x.equal_self.sfs

# delete old sfs files
rm $out_sfs_dir/*.sfs

for species in {Cerryb,Meglea,Rutmac};do
    ## different sort orders
    sfs1=`find -maxdepth 1 -print | grep "$species" | egrep "DP_[0-9]" | grep "equal_self.sfs$" | sort -V`

    ## downsample linear genome
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep "P_[0-1][0-9]" | grep "equal_self.sfs$" | sort -V`
    ## downsample reads
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep '_[0-9]P|_[0-1][0-9]P' | grep "equal_self.sfs$" | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
    sfs2=`find -maxdepth 1 -print | grep "xxxxx_old_script" | sort -V`

# species: Cerryb - 50 ind
    if [ "$species" = "Cerryb" ];then
        for file_name in $sfs1;do
            #    echo -e "\n"
            new_file_name=${file_name//}
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
            
            ## delete old files
            # ls $out_sfs_dir/*hapS_5rep_*00d*_final* | grep -v '200_300G' | xargs rm
        done
        
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
        done

# species: Meglea - 50 ind
    elif [ "$species" = "Meglea" ];then
        for file_name in $sfs1;do
            # empty sfs data for 10x
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
        done

# species: Rutmac - 50 ind
    elif [ "$species" = "Rutmac" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-52 >> $out_sfs_dir/"$species"_50_dipS.DP_1_3_5_7_10x.sfs;
        done
    else

# species: Vet
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_1_3_5_7_10x.sfs;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_1000000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_1_3_5_7_10x.sfs;
        done

    fi
done
