
## check R path
.libPaths() # in the terminal
/home/yzliu/miniforge3/envs/R/lib/R/library
conda activate R
## check the loaded lirbary in R
sessionInfo()


conda install -c conda-forge r-terra r-rnaturalearth


*************************************************
## another way
## https://biostats-r.github.io/biostats/workingInR/140_maps.html
# The low-resolution (1:110 million) coastline and country data, suitable for world maps, are included in the rnaturalearth package. 
# The rnaturalearthdata package, also on CRAN, contains medium-resolution data. 
# High-resolution (1:10 million) data are in the rnaturalearthhires package

install.packages("rnaturalearth")
library(rnaturalearth)
library(ggplot2)
library(sf)

Warning messages:
1: In CPL_crs_from_input(x) :
  GDAL Error 1: PROJ: proj_create_from_database: Open of /home/yzliu/miniforge3/envs/R/share/proj failed
2: In CPL_crs_from_input(x) :
  GDAL Error 1: PROJ: proj_create_from_database: Open of /home/yzliu/miniforge3/envs/R/share/proj failed

# The environment variable PROJ_LIB is not set or points to the wrong location.
Sys.setenv(PROJ_LIB = "/home/yzliu/miniforge3/envs/R/share/proj")

## install via conda to R env
conda install -c conda-forge r-terra r-rnaturalearth

"
## gdal issue
gdalinfo --version
# GDAL 3.7.1, released 2023/07/06
which gdal-config
gdal-config --prefix
#~/miniforge3/bin/gdal-config
#/home/yzliu/miniforge3
install.packages("terra", dependancies = TRUE)
"
world <- ne_countries(scale = 110, returnclass = "sf") 
small_scale_map <- ggplot() +
  geom_sf(data = world) +
  coord_sf(xlim = c(-20, 50), ylim = c(33, 80)) +
  ggtitle("Europe")

europe <- ne_countries(scale = 50, continent = "Europe") 
medium_scale_map <- ggplot() +
  geom_sf(data = europe) +
  coord_sf(xlim = c(5, 30), ylim = c(55, 71)) +
  ggtitle("Norden")



install.packages("rnaturalearthdata")

europe <- ne_countries(scale = 50, continent = "Europe") 
medium_scale_map <- ggplot() +
  geom_sf(data = europe) +
  coord_sf(xlim = c(5, 30), ylim = c(55, 71)) +
  ggtitle("Norden")
********************************************************
# Need extra package for high resolution data
#install.packages("rnaturalearthhires")
library("rnaturalearthhires")
#install.packages("rnaturalearthhires", repos = "https://ropensci.r-universe.dev")


library(rnaturalearth)
library(ggplot2)
library(sf)

## add north symble
library("ggspatial")
library("rgbif")

# The scale of map to return, one of '110', '50', '10' or 'small', 'medium', 'large'.
norway <- ne_countries(scale = 10, country = "Norway") 
large_scale_map <- ggplot() +
  geom_sf(data = norway) +
  coord_sf(xlim = c(4, 9), ylim = c(59, 62)) +
  ggtitle("Vestland")

## denmark - best one
europe <- ne_countries(scale = 50, continent = "Europe")

# high resolution denmark alone
denmark <- ne_countries(scale = 10, country = "denmark") 

## plot bee sampling sites
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot")

bee_site <- read.table("./organized_bee_lat_lon.tsv",sep = "\t",header = T,na.strings = "NA")
head(bee_site)

high_scale_map <- ggplot() +
    geom_sf(data = denmark, fill = "lightgray", color = "black") +
    coord_sf(xlim = c(8,12.6), ylim = c(54.5,58)) +
    theme_minimal() +
    #ggtitle("Denmark") +
    # https://www.geeksforgeeks.org/how-to-change-position-of-ggplot-title-in-r/
    
    #theme(plot.title = element_text(hjust=0)) +
    
    # add sampling sites
    geom_point(data = bee_site, mapping = aes(x = as.numeric(Longitude), y = as.numeric(Latitude), col = Species), size=2,alpha=1) + 
    #scale_colour_manual(values =c("firebrick4", "orange", "black","blue")) +
    # use color matched with phylogeny tree
    ## marginata: #0072B2 -> #332288
    scale_colour_manual(values =c("#009E73", "#332288", "#D55E00","#CC79A7")) +
    theme(
        #plot.title = element_text(hjust=0, vjust=0.5), 
        legend.position = c(0.25,0.9), legend.text = element_text(size=9), 
        legend.key.height = unit(0.5, "lines"),
        legend.background = element_rect(fill=NA),
        ) +
    labs(x = "Longitude", y = "Latitude") +
    geom_label(aes(x=10, y=10, label="N"), size=3, label.padding=unit(1,"mm"), label.r=unit(1,"lines")) +

    annotation_north_arrow(location = "tr",which_north = "true", 
        pad_x = unit(0.5, "cm"), pad_y = unit(0.5, "cm"),
        style = north_arrow_orienteering,width = unit(1, "cm"), 
        # north_arrow_nautical
        height = unit(1, "cm")) +

    annotation_scale()


print(high_scale_map)

ggsave(high_scale_map, filename = "sampling_map.new_review.pdf", width=5, height=6)



ggsave(high_scale_map, filename = "simple_denmark_map.new.pdf", width=6, height=6)




# add projection
shp = st_read(dsn = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot/denmark/dk_1km.shp") 
st_bbox(shp)
shp_lam = st_transform(shp, 3035)
#shp_lam = st_transform(shp, 2381)
st_bbox(shp_lam)

A = ggplot(data = shp_lam) + geom_sf(data = "denmark") + 
    # Recommended CRS	EPSG Code 4237
  #coord_sf(xlim = c(3,17), ylim = c(53, 59)) + 
  # Recommended CRS: ETRS89 / LAEA
  coord_sf(xlim = c(3886000,4749000), ylim = c(3459000, 3922000)) + 
             annotation_north_arrow(location = "tl",which_north = "true", 
                         pad_x = unit(0.2, "cm"), pad_y = unit(0.2, "cm"),
                         style = north_arrow_nautical,width = unit(1.5, "cm"), 
                         height = unit(1.5, "cm")) +
  annotation_scale()

A

library(ggmap)
basemap(limits = c(-30, 30, 50, 80)) +
  geom_sf(data = aquaculture, colour = "red")


# combine maps with patchwork
library(patchwork)
small_scale_map + medium_scale_map + large_scale_map

****************************************************************
## one with shape
pck = c("ggplot2","ggspatial","sf", "patchwork", "rgbif")
suppressMessages(lapply(pck, require, character.only = TRUE))
## had issue
install.packages(c("ggspatial","rgbif"), dependencies = TRUE)

## https://rpubs.com/Rubio-Polania/1145197
## best option
conda install -c conda-forge r-ggspatial r-rgbif
library("ggspatial")
library("rgbif")
# shape data
# https://data.humdata.org/dataset/cod-ab-chn; https://epsg.io/?q=china
# city
shp = st_read(dsn = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot/china/chn_admbndl_ALL_ocha_2020.shp") 
# province
shp = st_read(dsn = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot/china/chn_admbnda_adm1_ocha_2020.shp") 
# https://github.com/longwosion/geojson-map-china/blob/master/china.json
shp = st_read(dsn = "/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/R_vcf_data_stat_sfs_plot/china/china.json") 

ggplot(data = shp) + geom_sf()

## without specific projection
A = ggplot(data = shp) + geom_sf() + 
  coord_sf(xlim = c(70,140), ylim = c(15, 55)) + 
             annotation_north_arrow(location = "tl",which_north = "true", 
                         pad_x = unit(0.2, "cm"), pad_y = unit(0.2, "cm"),
                         style = north_arrow_nautical,width = unit(1.5, "cm"), 
                         height = unit(1.5, "cm")) +
  annotation_scale()

A

# ISN2004/LAEA Island - projection
shp_LAM = st_transform(shp, 9947)
st_bbox(shp_LAM)

## https://biostats-r.github.io/biostats/workingInR/140_maps.html; https://stackoverflow.com/questions/61809382/how-can-i-put-a-scalebar-and-a-north-arrow-on-the-map-ggplot
## https://epsg.io/?q=china

shp_epsg = st_transform(shp, 4480)
st_bbox(shp_epsg)

# 4326
     xmin      ymin      xmax      ymax 
 73.55770  18.16132 134.72635  53.53136
# 4480
     xmin      ymin      xmax      ymax 
 73.55770  18.16132 134.72635  53.53136 

## correct EPSG 2381 - 2390 (China Lambert Conformal Conic projections for different zones)
shp_lam = st_transform(shp, 2390)
shp_lam = st_transform(shp, 2381)
st_bbox(shp_lam)

 xmin       ymin       xmax       ymax 
-5161238.8  2209533.0   479712.3  6689554.3 

    xmin     ymin     xmax     ymax 
-2517502  2009550  2494947  6046957

B = #ggplot(data = shp_epsg) + geom_sf() + 
  ggplot(data = shp_lam) + geom_sf() + 
  #coord_sf(xlim = c(73.55770,134.72635), ylim = c(18.16132,53.53136)) + 
  # 2390
  #coord_sf(xlim = c(-5161238.8,479712.3), ylim = c(2209533.0,6689554.3)) + 
  # 2381
  coord_sf(xlim = c(-2517502,2494947), ylim = c(2009550,6046957)) + 
  #scale_y_reverse() +  # Reverse Y-axis
             annotation_north_arrow(location = "tl",which_north = "true", 
                         pad_x = unit(0.2, "cm"), pad_y = unit(0.2, "cm"),
                         style = north_arrow_nautical,width = unit(1.5, "cm"), 
                         height = unit(1.5, "cm")) +
  annotation_scale()

ggsave(B, filename = "map_china_projection.projection_2381.province.pdf", width = 8, height = 8)



C = ggplot(data = shp_LAM) + geom_sf() + 
  coord_sf(xlim = c(3929520,2050290.9), ylim = c(1083030.5, 1502427.1)) + 
             annotation_north_arrow(location = "tl",which_north = "true", 
                         pad_x = unit(0.2, "cm"), pad_y = unit(0.2, "cm"),
                         style = north_arrow_nautical,width = unit(1.5, "cm"), 
                         height = unit(1.5, "cm")) +
  annotation_scale()

(B | C) + plot_layout(widths = c(2, 2)) + plot_annotation(tag_levels = 'A')




















****************************************************************
## plot map using ggplot2
## https://warin.ca/posts/rcourse-datavisualizationwithr-maps/

library(ggplot2)
world <- map_data("world")
europe <- subset(world, region %in% c("Albania", "Andorra", "Armenia", "Austria", "Azerbaijan",
                                      "Belarus", "Belgium", "Bosnia and Herzegovina", "Bulgaria",
                                      "Croatia", "Cyprus", "Czechia","Denmark","Estonia","Finland", 
                                      "France","Georgia", "Germany", "Greece","Hungary","Iceland", 
                                      "Ireland", "Italy","Kazakhstan", "Kosovo", "Latvia","Liechtenstein", 
                                      "Lithuania", "Luxembourg","Malta","Moldova","Monaco","Montenegro",
                                      "Macedonia", "Netherlands","Norway","Poland","Portugal","Romania",
                                      "Russia","San Marino","Serbia","Slovakia","Slovenia","Spain",
                                      "Sweden","Switzerland","Turkey","Ukraine","UK","Vatican"))



denmark <- map_data("world", region = "Denmark")
new_data <- subset(world, region %in% c("Denmark"))

ggplot(data = europe, aes(x = long, y= lat, group = group)) +
    geom_polygon(data = europe, fill = "white", color = "black") +
    geom_polygon(data = denmark, fill = "gray", color = "black") +
    ## wider range
    #coord_fixed(ratio=1.5, xlim = c(-15,180), ylim = c(35,80))
    ## denmark within EU
    coord_fixed(ratio=1.5, xlim = c(-15,50), ylim = c(35,80))
    theme_void()

## denmark along
ggplot(data = denmark, aes(x = long, y= lat, group = group)) +
    #geom_polygon(data = europe, fill = "white", color = "black") +
    geom_polygon(data = denmark, fill = "white", color = "red") +
    #coord_fixed(ratio=1.5, xlim = c(-15,180), ylim = c(35,80))
    ## denmark within EU
    coord_fixed(ratio=1.5, xlim = c(8,15.5), ylim = c(54.5,58))
    theme_void()


new_data_1 <- subset(world, region %in% c("China"))
new_data_2 <- subset(world, region %in% c("Taiwan"))
new_data_3 <- subset(world, region %in% c("South China Sea"))

ggplot(data = europe, aes(x = long, y= lat, group = group)) +
    geom_polygon(data = new_data_1, fill = "white", color = "black") +
    geom_polygon(data = new_data_2, fill = "white", color = "black") +
    #coord_fixed(ratio=1.5, xlim = c(-15,180), ylim = c(35,80))
    coord_fixed(ratio=1.5, xlim = c(65,135), ylim = c(15,55))
    theme_void()

*************************************************
## https://cran.r-project.org/web/packages/plotDK/readme/README.html
install.packages("plotDK")
# devtools::install_github("https://github.com/kristianSN/plotDK")
library(plotDK)

plotDK(plotlevel = "region")


************************************************* issues of installination
if(!require("devtools")) install.packages("devtools")
devtools::install_github("sebastianbarfort/mapDK")


*************************************************
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

county_info <- map_data("denmark")
install.packages("terra")
conda update -c conda-forge gdal
conda install -c conda-forge "gdal>=3.0"  # Installs a modern GDAL version in base r, not env R

install.packages("rnaturalearth")  # if not already installed
library(rnaturalearth)

install.packages("mapsDK")  # if not already installed
library(mapsDK)

install.packages(c("systemfonts","textshaping","ragg","pkgdown","devtools"))



municipalities <- mapDK()  # gets municipality data
plot(municipalities)


denmark <- ne_states(country = "denmark", returnclass = "sf")
ggplot(denmark) + geom_sf()

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