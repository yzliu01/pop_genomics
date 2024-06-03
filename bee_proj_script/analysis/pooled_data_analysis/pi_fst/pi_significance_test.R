


## mean + sd in R

setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup")

pi_files <- list.files(pattern="COV4_400.pi$")
pi_files[1]
pi_BomPas_REF_BomPas <- read.table("Bompas.New_REF_BomPas.sort.marked_dups.bam.mpileup.COV4_400.pi",header=F,sep="\t")
head(pi_BomPas_REF_BomPas)
str(pi_BomPas_REF_BomPas)
is.numeric(pi_BomPas_REF_BomPas$V5)
pi_V5 <- head(as.numeric(pi_BomPas_REF_BomPas$V5))
mean_pi_BomPas_REF_BomPas <- mean(as.numeric(pi_BomPas_REF_BomPas$V5),na.rm = TRUE)
[1] 0.003810733

sd(as.numeric(pi_BomPas_REF_BomPas$V5),na.rm = TRUE)
[1] 0.002653637

plot_mean_pi_BomPas_REF_BomPas <- boxplot(as.numeric(pi_BomPas_REF_BomPas$V5),na.rm = TRUE)

********************************

library(ggplot2)
species_list <- c(
    "AndHae_REF_AndHae",
    "AndMar_REF_AndHae",
    "AndMar_REF_AndHat",
    "AndMar_REF_AndMar",
    "BomPas_REF_BomPas",
    "BomVet_REF_BomPas"
)
pi_list <- c(
    "Andhae.New_REF_AndHae.sort.marked_dups.bam.mpileup.COV4_400.pi",
    "Andmar.New_REF_AndHae.sort.marked_dups.bam.mpileup.COV4_400.pi",
    "Andmar.New_REF_AndHat.sort.marked_dups.bam.mpileup.COV4_400.pi",
    "Andmar.New_REF_AndMar.sort.marked_dups.bam.mpileup.COV4_400.pi",
    "Bompas.New_REF_BomPas.sort.marked_dups.bam.mpileup.COV4_400.pi",
    "Bomvet.New_REF_BomPas.sort.marked_dups.bam.mpileup.COV4_400.pi"
)

#pi_data <- file.path(pi_files_path,pi_list[2])
#df2 <- read.table(pi_data,header=F,sep="\t")


pi_files_path <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup"
setwd(pi_files_path)

## create a function to read data
read_table <- function(x){
pi_data <- file.path(pi_files_path,pi_list[x])
#file.path(pi_files_path,pi_list[3])
df_pi <- read.table(pi_list[x],header=F,sep="\t")
#df_pi <- read.table(pi_data,header=F,sep="\t")

return(df_pi)
}

df1 <- read_table(1)
df2 <- read_table(2)
df3 <- read_table(3)
df4 <- read_table(4)
df5 <- read_table(5)
df6 <- read_table(6)
#head(df1)
#head(df5)
str(df2)
df1$V6 <- rep("AndHae_REF_AndHae",33260)
df2$V6 <- rep("AndMar_REF_AndHae",33099)
df3$V6 <- rep("AndMar_REF_AndHat",42873)
df4$V6 <- rep("AndMar_REF_AndMar",29726)
df5$V6 <- rep("BomPas_REF_BomPas",30794)
df6$V6 <- rep("BomVet_REF_BomPas",30792)
#head(df1)
#tail(df5)

df1$V5 <- as.numeric(df1$V5)
df4$V5 <- as.numeric(df4$V5)
df5$V5 <- as.numeric(df5$V5)
df6$V5 <- as.numeric(df6$V5)

combined_df <- rbind(df1,df2,df3,df4,df5,df6)
combined_df_new <- rbind(df1,df4,df5,df6)
#str(combined_df)
#tail(combined_df)

## convert the 5th column of the combined dataset from chr to numeric 
combined_df$V5 <- as.numeric(combined_df$V5)
combined_df_new$V5 <- as.numeric(combined_df_new$V5)
str(combined_df)
library(ggpubr)

## check normality
ggdensity(data = df1$V5,
            main = "density of pi",
            xlab = "Values")
## only for 5000 samples: http://www.sthda.com/english/wiki/normality-test-in-r
shapiro.test(df1$V5)

## large sample size: https://stackoverflow.com/questions/28217306/error-in-shapiro-test-sample-size-must-be-between
install.packages("nortest")
library(nortest)
ad.test(df1$V5)

#        Anderson-Darling normality test
#data:  df1$V5
#A = 196.03, p-value < 2.2e-16
ad.test(df4$V5)
ad.test(df5$V5)
ad.test(df6$V5)

# create three related groups of data
group1 <- c(23, 25, 26, 24, 22, 21, 28, 27, 26, 23)
group2 <- c(20, 19, 18, 23, 25, 22, 21, 24, 26, 27)
group3 <- c(17, 19, 21, 20, 22, 23, 24, 26, 28, 27)

data <- cbind(group1, group2,group3)
# perform Friedman test
result <- friedman.test(data)
data_df <- cbind(df1$V5,df4$V5,df5$V5,df6$V5)
head(data_df)
colnames(data_df) <- c("Hae","Mar","Pas","Vet")
result <- friedman.test(data_df)

# summarize Friedman test results
#summary(result)
print(result)

## significance test
# pairwise comparisons: https://stats.stackexchange.com/questions/604676/difference-between-wilcoxon-test-and-pairwise-wilcoxon-test-in-r

wt <- wilcox.test(data_df[,"Hae"],data_df[,"Mar"], paired = TRUE, p.adjust.method = "bonferroni")
pairwise.wilcox.test(t(data_df), g = seq(1,4), p.adjust.method = "bonferroni")
pairwise.wilcox.test(t(data_df), g = seq(1,4))
pairwise.wilcox.test(t(data_df), g = letters[1:4])

#        Pairwise comparisons using Wilcoxon rank sum test with continuity correction 

#data:  t(data_df) and seq(1, 4) 

#  1      2      3     
#2 <2e-16 -      -     
#3 <2e-16 <2e-16 -     
#4 <2e-16 <2e-16 <2e-16

#P value adjustment method: holm

**********************************************************************''''
# Create boxplot using ggplot2
#summary_df <- combined_df %>% group_by(V6) %>% summarize(m=mean(V5))
pi_plot <- ggplot(combined_df_new, aes(x = V6, y = V5)) +
    geom_boxplot() +
    ## chatGPT
    stat_summary(fun = mean, geom = "text", aes(label = paste(round(..y.., 4)), vjust = -0.5), size = 3, color = "red") +  # Add mean labels
    theme_pubr(base_size = 10, border = TRUE) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title=element_text(hjust=0.5,size=13),
    axis.title=element_text(color="black",size = 12),
    axis.text = element_text(colour = "black",size = 10),
    panel.border=element_rect(linewidth=1.5), 
    panel.grid.major = element_line(color = "gray", size = 0.5, linetype = 2),
    panel.grid.minor = element_line(color = "gray", size = 0.5, linetype = 2)) +
    labs(title = "pi by Species_REF_Species", x = "Combination", y = "pi")

ggsave("pi_plot_new.pdf",pi_plot,width=15,height=15,unit="cm")




## in for loop
pi_files <- list.files(pattern="COV4_400.pi$")
species_list <- c(
    "AndHae_REF_AndHae",
    "AndMar_REF_AndHae",
    "AndMar_REF_AndHat",
    "AndMar_REF_AndMar",
    "BomPas_REF_BomPas",
    "BomVet_REF_BomPas"
)

pi_files_path <- "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/data/bee_proj_data/bam/bam_stats/samtools_mpileup"

if (length(pi_files) != length(species_list)){
    stop("The number of files does not match the number of species in species_list.")
}

library(ggplot2)

# Initialize an empty list to store data
data_list <- list()

for (i in 1:length(pi_files)){
    #print(pi_files[i])
    #print(paste0("pi_", species_list[i]))
    #print(species_list[i])
    pi_file <- paste0(pi_files_path,"/",pi_files[i])
    #pi_file <- pi_files[i]
    #print(pi_file)
    ## chatGPT: Uses fill = TRUE to handle rows of varying lengths by filling missing values with NA.
    assign(paste0("pi_",species_list[i]),read.table(pi_file,header=F,sep="\t",fill = TRUE))
    #print(head(get(paste0("pi_",species_list[i]))))

    ## get is used to get dynamically created variables, not including specific columns
    #print(head(get(paste0("pi_",species_list[i]))$V5))

    ## calculate mean_pi
    assign(paste0("mean_pi_",species_list[i]), mean(as.numeric(get(paste0("pi_",species_list[i]))$V5),na.rm = TRUE))
    cat(paste0(paste0("\n\n","mean_pi_",species_list[i]),"=",get(paste0("mean_pi_",species_list[i])),"\n"))

    ## calculate mean_pi_sd
    assign(paste0("mean_sd_",species_list[i]), sd(as.numeric(get(paste0("pi_",species_list[i]))$V5),na.rm = TRUE))
    cat(paste0(paste0("\n\n","mean_sd_",species_list[i]),"=",get(paste0("mean_sd_",species_list[i])),"\n"))

    assign(paste0("mean_pi_sd_upper_",species_list[i]), sum(get(paste0("mean_pi_",species_list[i])) + get(paste0("mean_sd_",species_list[i]))))
    assign(paste0("mean_pi_sd_lower_",species_list[i]), sum(get(paste0("mean_pi_",species_list[i])) - get(paste0("mean_sd_",species_list[i]))))
    cat(paste0(paste0("\n\n","mean_pi_sd_range_",species_list[i]),"= [",get(paste0("mean_pi_sd_lower_",species_list[i])),",",get(paste0("mean_pi_sd_upper_",species_list[i])),"]","\n"))

    ## combine data
    data_list[[paste0("pi_",species_list[i])]] <- as.numeric(get(paste0("pi_",species_list[i]))$V5)

    # Combine data into a single data frame
    combined_data <- data.frame(data_list)

    # Reshape data to long format for ggplot2
    #melted_data <- melt(combined_data, variable.name = "Species", value.name = "Value")

    # Create boxplot using ggplot2
    #ggplot(melted_data, aes(x = Species, y = Value)) +
    #    geom_boxplot() +
    #    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    #    labs(title = "Boxplot of V5 Values by Species", x = "Species", y = "V5 Value")

}


