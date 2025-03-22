************ non-pruned ( tab separated) *******************************************
cd /home/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep

cut -d "/" -f 1,3,5 sfs_10000Ne_20hapS_5rep_for_bp_non_pruned.txt | \
sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
awk -F "\t" -v OFS="\t" '{$13=++a[$11]".blueprint"}1' | \
awk '{ for (i = 1; i <= 11; ++i) printf $i"\t"; print "" $12$13}'

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/10000Ne_5rep
out_sub_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint

for sample_size in {20,80,200};do
    if [ $sample_size == 20 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$13=++a[$11]}1' | \
        awk '{ for (i = 1; i <= 11; ++i) printf $i"\t"; print "" $12$13}' > $out_sub_dir/sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by
    elif [ $sample_size == 80 ];then
        cat sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.blueprint.txt
    else
        cat sfs_10000Ne_"$sample_size"hapS_5rep_10_2_e_id_cons_bp_non_pruned.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$103=++a[$101]}1' | \
        awk '{ for (i = 1; i <= 101; ++i) printf $i"\t"; print "" $102$103}' >> $out_sub_dir/sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.blueprint.txt
    fi
done
## example
## 22608	11900	8644	6733	5772	5060	4867	4442	4276	2175	ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb	ft_sim_10000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1
