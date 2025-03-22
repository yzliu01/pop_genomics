

center_lat <- 37.8
center_long <- -122.4
width <- 0.2
num_points <- 500
test_data <- data.frame('lat'=rnorm(num_points, mean=center_lat, sd=width),
                       'long'=rnorm(num_points, mean=center_long, sd=width),
                       'year'=floor(runif(num_points, min=1990, max=2020)),
                       'temp'=runif(num_points, min=-10, max=40)
                       )

head(test_data)

library(ggplot2)
install.packages(c("s2","units","sf","transformr","gganimate","gifski"))
install.packages(c("s2","units","sf","transformr"))

library(gganimate)
library(gifski)
# had issues
conda activate R
conda install -c conda-forge r-s2 r-units r-sf r-transformr
conda install -c conda-forge r-gganimate r-gifski 
conda install -c conda-forge r-cli


which_state <- "california"
county_info <- map_data("county", region=which_state)


base_map <- ggplot(data = county_info, mapping = aes(x = long, y = lat, group = group)) +
 geom_polygon(color = "black", fill = "white") +
  coord_quickmap() +
  theme_void() 

base_map


map_with_data <- base_map +
  geom_point(data = test_data, aes(x = long, y = lat, group=year))
map_with_data

# To zoom in on the portion of the map around San Francisco
install.packages("cli")
library(cli)
#2. Clear R environment
#You might also want to clear your environment and re-run the code to avoid any lingering objects causing conflicts:
rm(list = ls())  # Clears the environment
gc()  # Garbage collection to free memory
#3. Check for package conflicts
#Sometimes, conflicts between different packages might cause issues. Ensure that all packages are updated and compatible:

update.packages()

min_long <- min(test_data$long)
max_long <- max(test_data$long)
min_lat <- min(test_data$lat)
max_lat <- max(test_data$lat)
map_with_data <- map_with_data +
  coord_quickmap(xlim = c(min_long, max_long),  ylim = c(min_lat, max_lat))
map_with_data

# add color

map_with_data <- base_map +
  geom_point(data = test_data, aes(x = long, y = lat, color=temp, group=year)) +
  coord_quickmap(xlim = c(min_long, max_long),  ylim = c(min_lat, max_lat))

map_with_data