

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/orthofinder_get_single_copy_genes_annotation_divergence_tim
    e/mcmctree_divergence_time_bom_apis_approx_lh")

pos_mean <- read.table("posterior_mean_run_1_2.txt", header = T, sep = "\t")
head(pos_mean)

pdf("convergence_check_bom_apis.pdf")
plot(pos_mean$mean_1, pos_mean$mean_2, xlab="mean_1", ylab="mean_2", main="Plot of mean_1 vs mean_2")
lines(pos_mean$mean_1, pos_mean$mean_2, col = "blue")
dev.off()
