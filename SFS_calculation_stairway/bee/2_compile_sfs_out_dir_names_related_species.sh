
## all: checked methods
input_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/SFS_data
cd $input_sfs_dir
#ls -t concated.AndHae*P_[0-1][0-9].equal_self.sfs | sort -V

## downsample reads
#out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates

## downsample genome
out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/bee_pools_blueprint/templates

# delete old sfs files
#rm $out_sfs_dir/*dipS*.sfs
#rm $out_sfs_dir/*_dipS.DP_3_5_7x.sfs
#Hae_39_dipS.DP_3_5_7x.sfs

# attention to the order of files


for species in {Hae,Mar,Pas,Vet};do ## downsample genome

#for species in {Hae,Mar};do ## downsample reads
    ## different sort orders
    ## related species
    # concated."$species"_New_REF_*SNP_softmask_genic_bi_FMT_DP*_1500x_noMS
    ## egrep or grep -E is different from ls _{New,New_alt}_REF_
    sfs1=`find -maxdepth 1 -print | egrep "${species}_(New|New_alt)_REF_" | egrep "SNP_softmask_genic_bi_FMT_DP" | grep "_1500x_noMS.equal_self.sfs$" | sort -V`
    ## clean version
    #sfs1=`find . -maxdepth 1 -type f | grep "${species}_New_REF_.*SNP_softmask_genic_bi_FMT_DP.*_1500x_noMS\.equal_self\.sfs$" | sort -V`

    ## downsample linear genome
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep "P_[0-1][0-9]" | grep "equal_self.sfs$" | sort -V`
    
    ## downsample reads
    #sfs1=`find -maxdepth 1 -print | grep "$species" | egrep '_[0-9]P|_[0-1][0-9]P' | grep "equal_self.sfs$" | perl -pe 'm/_(\d+)P_downsample_reads\.(\d+)x/; ($p, $xn) = ($1, $2); $_ = sprintf("%05d_%05d_%s", $xn, $p, $_);' | sort -t '_' -k1,1n -k2,2n | cut -d'_' -f3-`
    sfs2=`find -maxdepth 1 -print | grep "xxxxx_old_script" | sort -V`
# species: Hae
    if [ "$species" = "Hae" ];then
        for file_name in $sfs1;do
            #    echo -e "\n"
            new_file_name=${file_name//}
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-41 >> $out_sfs_dir/"$species"_39_dipS.DP_3_5_7x.sfs;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
            
            ## delete old files
            # ls $out_sfs_dir/*hapS_5rep_*00d*_final* | grep -v '200_300G' | xargs rm
        done
        
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-41 >> $out_sfs_dir/"$species"_39_dipS.DP_3_5_7x.sfs;
        done

# species: Mar
    elif [ "$species" = "Mar" ];then
        for file_name in $sfs1;do
            # empty sfs data for 10x
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-42 >> $out_sfs_dir/"$species"_40_dipS.DP_3_5_7x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-42 >> $out_sfs_dir/"$species"_40_dipS.DP_3_5_7x.sfs;
        done

# species: Pas
    elif [ "$species" = "Pas" ];then
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-36 >> $out_sfs_dir/"$species"_34_dipS.DP_3_5_7x.sfs;
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-36 >> $out_sfs_dir/"$species"_34_dipS.DP_3_5_7x.sfs;
        done
    else

# species: Vet
        for file_name in $sfs1;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_3_5_7x.sfs;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_1000000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        # no need to change
        for file_name in $sfs2;do
            awk -v var=$file_name 'BEGIN{FS=OFS=" "}NR>=1,NR<=1{print $0 var OFS var}' $file_name | cut -d ' ' -f 1-31 >> $out_sfs_dir/"$species"_29_dipS.DP_3_5_7x.sfs;
        done

    fi
done
