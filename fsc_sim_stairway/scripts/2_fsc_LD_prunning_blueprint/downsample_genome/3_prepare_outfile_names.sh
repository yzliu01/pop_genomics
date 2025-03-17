
# sfs.final.txt
# 9116	3658	2301	1778	1414	1266	1211	1133	1089	536	./ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb/ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_MAFpop0.obs	./ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb/ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_MAFpop0.obs
# 9183	3645	2358	1700	1510	1280	1153	1087	1105	548	./ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb/ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_MAFpop0.obs	./ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb/ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_MAFpop0.obs

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/pool_downsample_genome/templates
#out_sub_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint
# sfs_Ne10000_hapS_20_80_200_5rep_2i_2d_2d_2i_10d_10d_2i_2i_2ei_2ed_2ed_2ei_final.blueprint.txt
# 9116	3658	2301	1778	1414	1266	1211	1133	1089	536	ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb	ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_1
# 9183	3645	2358	1700	1510	1280	1153	1087	1105	548	ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb	ft_sim_10000Ne_20hapS_2E_100_500G_2d_2d_20Chr_15Mb_2

# 1_10x_P_01_10sfs
# 1270 646 ./concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_01.equal_self.sfs ./concated.AndHae_New_REF_AndHae.100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_DP_1x_1500x_noMS.P_01.equal_self.sfs

# Hae_39_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs
for species in {Hae_39,Mar_40,Pas_34,Vet_29};do
    if [ "$species" = "Hae_39" ];then
        cat "$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs |\
        # cut: the delimiter must be a single character
        #cut -d "/" -f 1,3,5 | \
        awk -F "./" '{print $1 $2 $3}' |\
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/100kb_g1500x_regions.GQ_issue_solved.SNP_softmask_genic_bi_FMT_//g' -e 's/_noMS//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
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
        sed -e 's/concated\.//g' -e 's/_New//g' -e 's/100kb_g1500x_regions.all_chr.sorted.GQ_issue_solved.SNP_softmask_genic_bi_FMT_//g' -e 's/_noMS//g' -e 's/.equal_self.sfs//g' -e 's/_1500x//g' > ./"$species"_dipS.1_3_5_7_10x.P_01_02_03_04_05_06_07_08_09_10.sfs.blueprint.txt
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

