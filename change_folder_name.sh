
awk -F " " 'NR > 7 && NR < 10 {sum+=$2}END{print sum}' $BomVet_BomPas_COV
less qualimap_mean_CocDP.txt | awk '{count++; Sum += $2} END {print Sum/count}'

cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned
## https://juejin.cn/s/linux%20%E6%89%B9%E9%87%8F%E4%BF%AE%E6%94%B9%E6%96%87%E4%BB%B6%E5%A4%B9%E5%90%8D

find -maxdepth 1 -name "*_1_err*" -type d -exec bash -c 'mv "$0" "${0/_1_err/_1_ERR}"' {} \;

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned/1MNe_swp

ft_sim_1000000Ne_200hapS_1E_200G_10e_d_cons_20Chr_15Mb_1
ft_sim_1000000Ne_200hapS_1E_200G_10e_d_cons_20Chr_15Mb_2
ft_sim_1000000Ne_200hapS_1E_200G_10e_d_cons_20Chr_15Mb_3
ft_sim_1000000Ne_200hapS_1E_200G_10e_d_cons_20Chr_15Mb_4
ft_sim_1000000Ne_200hapS_1E_200G_10e_d_cons_20Chr_15Mb_5

find . -name "1000000Ne*no_singleton" -type d -exec bash -c 'mv "$0" "${0/1000000Ne_no_singleton/}"' {} \;

## execution
ls -d -t ft_sim* | head -340
ls -d -t ft_sim* | head -340 
find . -name "ft_sim_1000000Ne*[2|3]00*" -type d -exec bash -c 'mv "$0" "${0/1000000Ne/1000000Ne_no_singleton}"' {} \;


******************************************************************
ls -d *_1_ERR*

ft_sim_10000Ne_200hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_200hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR
ft_sim_10000Ne_20hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_20hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR
ft_sim_10000Ne_80hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_80hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR

conda activate dos2unix
dos2unix -h

dos2unix /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/ft_sim_100000Ne_80_200hapS_1E_50_100_500G_09d_20Chr_15Mb.unfinished.anders.sh
dos2unix: converting file /home/yzliu/eDNA/faststorage/yzliu/DK_proj/backup/scripts/fastsimcoal/para_test3/ft_sim_100000Ne_80_200hapS_1E_50_100_500G_09d_20Chr_15Mb.unfinished.anders.sh to Unix format...