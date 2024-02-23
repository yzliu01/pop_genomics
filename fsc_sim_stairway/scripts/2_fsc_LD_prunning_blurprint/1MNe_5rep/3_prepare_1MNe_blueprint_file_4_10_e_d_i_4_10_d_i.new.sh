*********** create list of each blueprint file (non-pruned SNP) ************
#cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
#sfs_20_80_200=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.blueprint.txt

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint
sfs_20_80_200=sfs_hapS_20_80_200_5rep_4_10_e_d_i_4_10_d_i_final.blueprint.txt

#blueprint_output_folder_list_5rep=ft_sim_1000000Ne_20_80_200_200S_1E_00_01_05_09d_05i_20Chr_15Mb.5rep_blueprint.output_dir_name.list

#blueprint_file_list_5rep=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.5rep_blueprint.file_name.list
blueprint_file_list_5rep=sfs_hapS_20_80_200_5rep_4_10_e_d_i_4_10_d_i_final.5rep_blueprint.file_name.list
## take the (last) 3rd column
#sed 's/\.blueprint//g' $sfs_20_80_200 | awk '{print $NF}' > $blueprint_output_folder_list_5rep
awk '{print $NF".blueprint"}' $sfs_20_80_200 > $blueprint_file_list_5rep


***************** non-pruned (new) *********************
## make blueprint replicate (5) files
#cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
#blueprint_file_list_5rep=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.5rep_blueprint.file_name.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint
blueprint_file_list_5rep=sfs_hapS_20_80_200_5rep_4_10_e_d_i_4_10_d_i_final.5rep_blueprint.file_name.list

## blueprint file name
## ft_sim_1000000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1.blueprint
#stairway_dir=/home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep
stairway_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/1000000Ne_5rep
# rm ./1000000Ne_5rep/*20hapS*.blueprint
for size in {20,80,200};do
    for bp_file in `grep "$size"hapS $blueprint_file_list_5rep`;do
        ## 1000000Ne,100000Ne,1000000Ne

        #echo $bp_file by using templates
        cat ft_sim_1000000Ne_"$size"hapS_1E_50G_00d_20Chr_15Mb_1_0_MSFS.blueprint > $stairway_dir/$bp_file
    done
done

****************** replace data and pattern in blueprint files ***********************
****************** non-pruned                         **********
## blueprint files (plot for 5 rep)
#cd /home/yzliu/bin/stairway_plot_v2.1.2/stairway_plot_blueprint
#blueprint_file_list_5rep=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.5rep_blueprint.file_name.list

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint
#blueprint_file_list_5rep=sfs_hapS_20_80_200_5rep_4_10_e_d_i_4_10_d_i_final.5rep_blueprint.file_name.list
## ft_sim_1000000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1.blueprint

#sfs_FilePlotName_20_80_200=sfs_file_20_80_200hapS_10_2_e_id_cons_non_pruned.blueprint.txt
sfs_FilePlotName_20_80_200=sfs_hapS_20_80_200_5rep_4_10_e_d_i_4_10_d_i_final.blueprint.txt
## ft_sim_1000000Ne_20hapS_1E_50G_00d_20Chr_15Mb_1
## ft_sim_1000000Ne_20hapS_1E_50G_00d_20Chr_15Mb_2

for sample_size in {20hapS,80hapS,200hapS};do
    for i in {1..80};do
    ## number of row, 80 for each group (20hapS,80hapS,200hapS)

        ## sfs file
        ## modify AA and CC with pop_name and proj_dir_name in column (NF-1)
        #sfs1=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $(NF-1)}'`
        
        ## attention to input file
        
        ## blueprint file names in last column; dir of blueprint files
        sfs2=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $NF}'`
        ## add ".blueprint" file extension
        sfs3=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {print $NF".blueprint"}'`
        sed -i -e "3s/AA/$sfs2/" -e "12s/CC/$sfs2/" ./1000000Ne_5rep/$sfs3
        ## modify pop BB (sfs) and DD with sfs data and plot_title in col1 and the last col (NF)
        ## attention to input file (set the last two columns empty $NF=$(NF-1)="")
        sfs4=`grep "$sample_size" $sfs_FilePlotName_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)="";print}' | sed 's/[[:blank:]]*$//'`
        ## issue: sfs4=`grep "$sample_size" $sfs_20_80_200 | awk -F "\t" -v var=$i 'FNR==var {$NF=$(NF-1)=""}1' | sed 's/[[:blank:]]*$//'`
        ## remove excess space
        ## https://unix.stackexchange.com/questions/102008/how-do-i-trim-leading-and-trailing-whitespace-from-each-line-of-some-output
        sed -i -e "7s/BB/$sfs4/" -e "20s/DD/$sfs2/" ./1000000Ne_5rep/$sfs3
    done
done


#### run blueprint files ####

