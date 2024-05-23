data <- read.table("combined_read_all_results_contig_0_1_2_1kb_mean_rho.txt", sep = "", header = T)
cum_contig <- read.table("Mbel_contig_cum_length_tab_modified_2.txt", header = T,sep = "\t")
data$cumulative_pos <- ((data$Group.1*1e3) - 500) + cum_contig$pos[match(data$contig_i, cum_contig$contig)]

getwd()
Rdata <- readRDS("tarseq_0.Rdata")
head(Rdata)
Rdata$interval <- diff(c(0,Rdata$Loci))
Rdata$rec_dist <- Rdata$interval*Rdata$Mean_rho
