************ non-pruned ( tab separated) *******************************************

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep/templates
out_sub_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint

#sfs_1000000Ne_"$sample_size"hapS_200_300G_5rep_00d_01d_05d_09d_final.txt

for sample_size in {20,80,200};do
    if [ $sample_size == 20 ];then
        cat sfs_1000000Ne_"$sample_size"hapS_200_300G_5rep_00d_01d_05d_09d_final.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$13=++a[$11]}1' | \
        awk '{ for (i = 1; i <= 11; ++i) printf $i"\t"; print "" $12$13}' > $out_sub_dir/sfs_Ne1000000_hapS_200_300G_20_80_200_5rep_00d_01d_05d_09d_final.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by
    elif [ $sample_size == 80 ];then
        cat sfs_1000000Ne_"$sample_size"hapS_200_300G_5rep_00d_01d_05d_09d_final.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_Ne1000000_hapS_200_300G_20_80_200_5rep_00d_01d_05d_09d_final.blueprint.txt
    else
        cat sfs_1000000Ne_"$sample_size"hapS_200_300G_5rep_00d_01d_05d_09d_final.txt |\
        cut -d "/" -f 1,3,5 | \
        sed -e 's/\.\///g' -e 's/_MAFpop0\.obs//' -e 's/MAFpop0\.obs//1' | \
        awk -F "\t" -v OFS="\t" '{$103=++a[$101]}1' | \
        awk '{ for (i = 1; i <= 101; ++i) printf $i"\t"; print "" $102$103}' >> $out_sub_dir/sfs_Ne1000000_hapS_200_300G_20_80_200_5rep_00d_01d_05d_09d_final.blueprint.txt
    fi
done
