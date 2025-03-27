
# summary dir
summary_dir=/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new
ls -d *_0_{2..6}.no_singleton* | sort -V
# AndHae *final.summary file
summary_list=$(find . -maxdepth 2 -type f -name "*AndHae*_0_[2-6].no_singleton*final.summary" -print | sort -V) # 30402
summary_list=$(find . -maxdepth 2 -type f -name "*AndMar*_0_[2-6].no_singleton*final.summary" -print | sort -V) # 31202
summary_list=$(find . -maxdepth 2 -type f -name "*BomPas*_0_[2-6].no_singleton*final.summary" -print | sort -V)
summary_list=$(find . -maxdepth 2 -type f -name "*BomVet*_0_[2-6].no_singleton*final.summary" -print | sort -V)

for summary in ${summary_list[@]}
do
#echo $summary
# check the number of lines in each file
wc -l $summary
done



setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new")



