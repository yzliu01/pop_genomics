
cd /home/yzliu/bin/stairway_plot_v2.1.2/systematic_ft_non_pruned
## https://juejin.cn/s/linux%20%E6%89%B9%E9%87%8F%E4%BF%AE%E6%94%B9%E6%96%87%E4%BB%B6%E5%A4%B9%E5%90%8D

find -maxdepth 1 -name "*_1_err*" -type d -exec bash -c 'mv "$0" "${0/_1_err/_1_ERR}"' {} \;


ls -d *_1_ERR*

ft_sim_10000Ne_200hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_200hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR
ft_sim_10000Ne_20hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_20hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR
ft_sim_10000Ne_80hapS_2E_100_500G_2e_d_2e_i_20Chr_15Mb_1_ERR
ft_sim_10000Ne_80hapS_2E_100_500G_2e_i_2e_d_20Chr_15Mb_1_ERR
