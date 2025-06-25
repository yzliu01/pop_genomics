## all: checked methods
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100_replicates
out_sfs_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/100_replicates/templates

rm $out_sfs_dir/*hapS_100rep_others_final.txt

for sample_size in {20,80,200};do
    ## different sort orders
    sfs1=`find -maxdepth 2 -print | grep "1000000Ne" | grep "1E" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    sfs2=`find -maxdepth 2 -print | grep "1000000Ne" | grep "1E" | grep "05i--" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    if [ $sample_size == 20 ];then
        for stable_decrease in $sfs1;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-11,22-24 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-11,22-24 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
        done
    elif [ $sample_size == 80 ];then
        for stable_decrease in $sfs1;do
            #printf $sfs"\n"
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-41,82-84 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-41 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-41,82-84 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
        done
    else
        for stable_decrease in $sfs1;do
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-101,202-204 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt;
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
            ## result file: sfs_1000000Ne_200hapS_5rep_final.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-101,202-204 >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_100rep_others_final.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> $out_sfs_dir/sfs_1000000Ne_"$sample_size"hapS_5rep_final.txt
        done
    fi
done
