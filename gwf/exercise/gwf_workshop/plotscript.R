# Load required libraries
library(ggplot2)
library(purrr)

# Directory where your text files are located
directory <- "results/depths"

# Get list of all .txt files in the directory
file_list <- list.files(directory, pattern = "\\.depth$", full.names = TRUE)

# Step 2 & 3: Read each file, extracting a column of numbers, and store the data along with the filename
data_list <- map(file_list, function(file_path) {
  filename <- tools::file_path_sans_ext(basename(file_path))
  data <- read.table(file_path, header = FALSE)  # Assuming no header
  data <- data[, 3]  # Extracting first column
  data <- data.frame(value = data, filename = filename)
})

# Step 4: Combine all data into a single data frame
combined_data <- do.call(rbind, data_list)

# Create histogram with ggplot2
histogram <- ggplot(data = combined_data, aes(x = value, fill = filename)) +
  geom_histogram(binwidth = 1, position = "identity", alpha = 0.7) + # Adjust binwidth and position as needed
  labs(title = "Histogram of bam files depths",
       x = "Depth",
       y = "Frequency",
       fill = "Filename") +
  theme_minimal()

# Print histogram
#print(histogram)

ggsave("results/depths/histogram.pdf", plot = histogram, width = 8, height = 6, units = "in")
