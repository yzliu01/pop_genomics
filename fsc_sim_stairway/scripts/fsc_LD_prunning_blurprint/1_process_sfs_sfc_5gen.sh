

## all
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
#awk 'NR>2{print NF;exit}' file
rm *hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt
for sample_size in {20,80,200};do
    ## decrease
    #sfs1=`find -maxdepth 2 -print | grep "10000Ne" | grep "xE" | grep -v "05i" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    ## increase
    #sfs2=`find -maxdepth 2 -print | grep "10000Ne" | grep "xE" | grep "05i" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    ## de_in_crease_stable
    sfs3=`find -maxdepth 2 -print | grep -e 'e_[id]_cons' | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    echo $sfs3
done


for sample_size in {20,80,200};do
    ## decrease
    #sfs1=`find -maxdepth 2 -print | grep "10000Ne" | grep "xE" | grep -v "05i" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    ## increase
    #sfs2=`find -maxdepth 2 -print | grep "10000Ne" | grep "xE" | grep "05i" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    ## de_in_crease_stable
    sfs3=`find -maxdepth 2 -print | grep -e 'e_[id]_cons' | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    
    if [ $sample_size == 20 ];then

    #    for stable_decrease in $sfs1;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
    #        awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    #    done

    #    for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
    #        awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    #    done

        for de_in_crease_stable in $sfs3;do
            echo $de_in_crease_stable
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$de_in_crease_stable 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $de_in_crease_stable | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done

    elif [ $sample_size == 80 ];then

    #    for stable_decrease in $sfs1;do
            #printf $sfs"\n"
    #        awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-41 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    #    done

    #    for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
    #        awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    #    done

        for de_in_crease_stable in $sfs3;do
            echo $de_in_crease_stable
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$de_in_crease_stable 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $de_in_crease_stable | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done

    else

    #    for stable_decrease in $sfs1;do
    #        awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_10000Ne_200hapS_5rep_for_bp_non_pruned.txt
    #    done

    #    for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
    #        awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
    #    done
        
        for de_in_crease_stable in $sfs3;do
            echo $de_in_crease_stable
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$de_in_crease_stable 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $de_in_crease_stable | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done

    fi

done





## all: checked methods
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep

for sample_size in {20,80,200};do
    ## different sort orders
    sfs1=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep -v "05i" | grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    sfs2=`find -maxdepth 2 -print | grep "10000Ne" | grep "1E" | grep "05i" |  grep "15Mb/" | grep "$sample_size"hapS | grep "15Mb_MAFpop0.obs$" | sort -V`
    if [ $sample_size == 20 ];then
        for stable_decrease in $sfs1;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            ## https://unix.stackexchange.com/questions/638196/how-to-print-in-only-one-column-if-condition-with-awk
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-11,22-24 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    elif [ $sample_size == 80 ];then
        for stable_decrease in $sfs1;do
            #printf $sfs"\n"
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-41 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-41,82-84 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    else
        for stable_decrease in $sfs1;do
            awk -v var=$stable_decrease 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $stable_decrease | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            #awk 'NR>=3,NR<=5' $i | cut -d " " -f 2-101 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt;
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
            ## result file: sfs_10000Ne_200hapS_5rep_for_bp_non_pruned.txt
        done
        for increase in $sfs2;do
            #    echo -e "\n"
            #   tr -d # delete newline characters 
            awk -v var=$increase 'BEGIN{FS=OFS="\t"}NR>=3,NR<=5{print $0 var OFS var}' $increase | cut -f 2-101,202-204 >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txttttttt;
            #BEGIN{FS=OFS="\t"}
            #echo -e "\t$i\t$i" >> sfs_10000Ne_"$sample_size"hapS_5rep_for_bp_non_pruned.txt
        done
    fi
done
