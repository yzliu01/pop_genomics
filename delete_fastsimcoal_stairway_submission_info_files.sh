

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission

find . -maxdepth 3 -name "3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae*" | head

3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndMar_0_4_bam.100kb_g1500x.chr_regions.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndMar_New_REF_AndMar_0_6_bam.100kb_g1500x.chr_regions.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae_0_4_bam.100kb_g1500x.chr_regions.short.%A_%a.e
3_fb_variant_calling_4_bee_pools.AndHae_New_REF_AndHae_0_6_bam.100kb_g1500x.chr_regions.short.%A_%a.e

find . -type f -name '3_fb_*.e' -print
find . -type f -name '3_fb_*.e' -exec rm {} +
find . -type f -name '3_fb_*.o' -exec rm {} +

find . -type f -name '3_fb_*0_4_bam*.e' -exec rm {} +
find . -type f -name '3_fb_*0_6_bam*.o' -exec rm {} +


## delete files where there are huge number of files
cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new
find . -maxdepth 5 -type f -name '*addTheta' | xargs rm

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/job_submission
find . -maxdepth 5 -type f -name '*3_fb_variant_calling_4_bee_pools*' | xargs rm

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/bee_pools_plot_new
find . -maxdepth 5 -type f -regex '.*genic-\([1-9]\|[1-9][0-9]\|1[0-9][0-9]\|200\)$'

cd /home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/stairway_plot_v2/stairway_plot_v2.1.2/systematic_ft_non_pruned
find . -maxdepth 5 -type f -regex '.*15Mb_[1-5]-\([1-9]\|[1-9][0-9]\|1[0-9][0-9]\|200\)$' | wc -l # | xargs rm