
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates

# sfs.final.txt
head /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_reads/templates/Mar_40_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs
13 4 3 6 11 5 10 7 2 4 4 6 2 5 3 3 2 1 4 2 2 2 1 4 1 1 2 4 3 4 2 3 3 2 3 3 0 0 0 0 ./Andmar.New_REF_AndMar_0_1P_downsample_reads.7x.equal_self.sfs ./Andmar.New_REF_AndMar_0_1P_downsample_reads.7x.equal_self.sfs

141 122 87 74 70 39 62 50 44 30 41 44 46 32 42 27 26 37 43 31 25 46 51 49 49 42 45 53 66 69 71 75 80 76 99 89 99 85 107 55 ./Andmar.New_REF_AndMar_0_10P_downsample_reads.10x.equal_self.sfs ./Andmar.New_REF_AndMar_0_10P_downsample_reads.10x.equal_self.sfs
# from: ./Andmar.New_REF_AndMar_0_1P_downsample_reads.7x.equal_self.sfs

# to: AndMar_REF_AndMar.08P.DP_1x

# Hae_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs
for species in {Hae_39,Mar_40};do
    if [ "$species" = "Hae_39" ];then
        cat "$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs |\
        # cut: the delimiter must be a single character
        #cut -d "/" -f 1,3,5 | \
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/Andhae.New_REF_AndHae_0_/AndHae_REF_AndHae.0/g' -e 's/downsample_reads\./reads.DP_/g' -e 's/.equal_self.sfs//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        # add order numbers to the duplicate runs
        #awk -F "\t" -v OFS="\t" '{$42=++a[$41]}1' | \
        # i is th enumber of columns including numbers and two file names (this became optional for downsampling)
        #awk '{ for (i = 1; i <= 40; ++i) printf $i"\t"; print "" $41$42}' > $out_sub_dir/"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        ## https://www.baeldung.com/linux/display-columns-from-file
        ## add a number of the same strings in a column
        ## https://stackoverflow.com/questions/18516301/add-a-number-to-each-line-of-a-file-in-bash
        ## https://unix.stackexchange.com/questions/517985/how-can-i-merge-multiple-column-in-one-column-and-separated-by
    elif [ "$species" = "Mar_40" ];then
        cat "$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/Andmar.New_REF_AndMar_0_/AndMar_REF_AndMar.0/g' -e 's/downsample_reads\./reads.DP_/g' -e 's/.equal_self.sfs//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$43=++a[$41]}1' | \
        #awk '{ for (i = 1; i <= 41; ++i) printf $i"\t"; print "" $42$43}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt
    
    elif [ "$species" = "Pas_34" ];then
        cat "$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_//g' -e 's/_noMS//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$103=++a[$101]}1' | \
        #awk '{ for (i = 1; i <= 101; ++i) printf $i"\t"; print "" $102$103}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt
    else
        cat "$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs |\
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/100kb_g1500x_regions.SNP_softmask_genic_bi_FMT_//g' -e 's/_noMS//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
        #awk -F "\t" -v OFS="\t" '{$203=++a[$201]}1' | \
        #awk '{ for (i = 1; i <= 201; ++i) printf $i"\t"; print "" $202$203}' >> $out_sub_dir/sfs_Ne1000000_hapS_20_80_200_400_5rep_00d_01d_05d_09d_final.blueprint.txt

    fi
done

