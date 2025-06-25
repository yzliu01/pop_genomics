

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/steps/systematic_fsc_test3/100_replicates

ls -d ./*00d*_15Mb
for f in $(ls -d ./*00d*_15Mb);do mv $f $f-;done

for f in $(ls -d ./*_15Mb);do mv $f "$f"_test1;done

for f in $(ls -d ./*_15Mb_test1);do new_f=${f/_test1//}; mv $f $new_f;done

# rename folder names
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp-
for f in $(ls -d ft_sim*1MNe*20Chr_15Mb*);do new_f=${f/1MNe/1MNe_no_singleton}; mv $f $new_f;done
for f in $(ls -d ft_sim*1MNe*20Chr_15Mb*);do new_f=${f/1MNe_no_singleton/1000000Ne_no_singleton}; mv $f $new_f;done

ls -d ft_sim*1000000Ne_no_singleton*20Chr_15Mb*
rename 1MNe 1000000Ne ft_sim*1000000Ne_no_singleton*20Chr_15Mb*summary*


ls -d ft_sim*10000Ne*2e_[id]_cons*20Chr*
for f in $(ls -d ft_sim*10000Ne*2e_[id]_cons*20Chr*);do new_f=${f/ft_sim_10000Ne/ft_sim_10000Ne_no_singleton}; mv $f $new_f;done

# copy folders to a different directory
for f in $(ls -d ../1MNe_swp/*);do cp -r $f .;done


cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/stairway_plot_blueprint/10000Ne_5rep_no_singletons
rm *{4e_d_4i,4e_i_4d,10e_d_10i,10e_i_10d,10d_10d,plot.sh}*

rm *0G_00d*blueprint
rm *[0-9][0-9]d* 

ls *blueprint | sort -V | xargs sed -i 's/#smallest_size/smallest_size/g'
ls *blueprint | sort -V | xargs sed -i 's/systematic_ft_non_pruned\//systematic_ft_non_pruned\/10KNe_swp\//g'
ls *blueprint | sort -V | xargs sed -i 's/ft_sim_10000Ne_/ft_sim_10KNe_no_singleton_/g'

ls *blueprint | sort -V | xargs sed -i 's/#smallest_size/smallest_size/g'
ls *blueprint | sort -V | xargs sed -i 's/systematic_ft_test3\/ft_sim_10000Ne/systematic_ft_test3\/10KNe_swp\/ft_sim_10KNe/g'
ls *blueprint | sort -V | xargs sed -i 's/ft_sim_10000Ne/ft_sim_10KNe/g'

ls *blueprint | sort -V | xargs sed -i 's/ft_sim_10KNe/ft_sim_10000Ne/g'
ls *blueprint | sort -V | xargs sed -i 's/systematic_ft_test3/systematic_ft_non_pruned/g'


ls *blueprint | xargs grep -H 'systematic_ft_non_pruned/10KNe_swp' | sort -V | less -NS
630
ls *blueprint | sort -V | xargs sed -i 's/systematic_ft_non_pruned\/ft_sim_10000Ne/systematic_ft_non_pruned\/10KNe_swp\/ft_sim_10000Ne/g'

ls $blueprint_dir/*.blueprint | xargs grep -H 'systematic_ft_non_pruned/100KNe_swp/ft_sim_100000Ne_no_singleton' | sort -V | less -NS

ls *blueprint | sort -V | xargs sed -i 's/10KNe_swp\/10KNe_swp/10KNe_swp/g'
10KNe_swp/10KNe_swp


