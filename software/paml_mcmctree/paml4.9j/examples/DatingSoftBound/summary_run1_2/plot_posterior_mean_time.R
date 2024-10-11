
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/sofwtare/paml_mcmctree/paml4.9j/examples/DatingSoftBound/summary_run1_2")

data_time <- read.table("posterior_mean_time_dataset.txt", sep="\t", header=T)
head(data_time)
show(data_time)

new_data <- data_time[,c(1,2,3,5:7)]

library(tidyr)
library(dplyr)
reshaped_data <- new_data %>% 
    pivot_wider(names_from = run, values_from = c(mean, X2.5..quantil, X97.5..quantil, X95..CI.width))

print(reshaped_data)
str(reshaped_data)

plot(x=reshaped_data$mean_run1, y=reshaped_data$mean_run2, xlab="run1 mean", ylab = "run2 mean", pch =16)
#model <- lm(mean_run1 ~ mean_run2, data = reshaped_data)
#abline(model, col = "red", lty = 2)
abline(lm(reshaped_data$mean_run1 ~ reshaped_data$mean_run2),col="red",lty=2)
#abline(0,1,col="red",lty=2)
