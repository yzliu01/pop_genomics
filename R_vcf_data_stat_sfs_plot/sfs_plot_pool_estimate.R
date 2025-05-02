

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot")

data <- read.table("data_pool_DP.txt", header=T, sep="\t")

pdf("depth_percent.pdf",width = 4, height = 4)
plot(data$mean_DP, data$percent, type = "p", col = "red", pch = 19, cex = 1, lwd = 2,
     xlim = c(min(data$mean_DP) - 10, max(data$mean_DP) + 10),  # Adjust x-axis limits
     ylim = c(min(data$percent) - 0.01, max(data$percent) + 0.01))  # Adjust y-axis limits

# pos = 3: Places text above the points (change to 1 for below, 2 for left, 4 for right).
#text(data$mean_DP, data$percent, labels = paste(data$species, data$mean_DP, sep = "\n"), pos = 1, cex = 0.4)
text(data$mean_DP, data$percent, labels = paste(data$species, data$mean_DP, sep = " DP: "), pos = 1, cex = 0.3)
#text(data$mean_DP, data$percent, labels = paste(data$species, data$mean_DP, data$percent, sep = " "), pos = 1, cex = 0.4)

dev.off()
