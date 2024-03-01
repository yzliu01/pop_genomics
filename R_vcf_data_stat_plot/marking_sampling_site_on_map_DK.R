#### draw map with Stamenmap (Stadiamap) ggmap ####
list.files()
install.packages("RgoogleMaps")
install.packages("mapdata")
library(RgoogleMaps)
library(mapdata)
help("mapdata")
??mapdata
lat <- c(48,64)
lon <- c(-140,-110)
center = c(mean(lat),mean(lon))
zoom <- 5
terrmap <- GetMap(center = center,zoom = 4,maptype = "terrain",destfile = "test_terrain.png")
map("worldHires","Canada", col="gray90", fill=TRUE)
map("worldHires","Denmark", col="gray90", fill=TRUE)
map("worldHires","Canada", xlim=c(-141,-53), ylim=c(40,85), col="gray90", fill=TRUE)
map("worldHires","Canada", xlim=c(-150,-10),ylim=c(0,120), col="gray90", fill=TRUE)  #plot the region of Canada I want


#### Stamen maps #####
# work well
#https://www.r-bloggers.com/2018/10/getting-started-stamen-maps-with-ggmap/
install.packages("ggmap")
install.packages("rosm")
install.packages("caret")
library(ggmap)
#scale must be a positive integer 0-18, see ?get_stamenmap.
library(caret) ## data(Sacramento)
library(dplyr) ## forward data
library(rosm) ## automatic zoom function.

library(httr)    
set_config(use_proxy(url="10.3.100.207",port=8080))

getOption('timeout')
options(timeout=1000000)

bbox <- c(bottom = 25.75, top = 49 , right = -67, left = -125)
usmap <- get_stadiamap(bbox = bbox, zoom = 5, maptype = 'stamen_terrain') 
ggmap(usmap)

## https://stackoverflow.com/questions/77274624/stamen-map-mapping-no-longer-working-in-r
spillover <- get_stadiamap( bbox=c(left=-2.2, bottom=51, right=-1.3, top=51.7),  
                            maptype="stamen_terrain_background", zoom=2)
ggmap(spillover)
## or 
bbox_everest <- c(left = 86.05, bottom = 27.21, right = 87.81, top = 28.76)
ggmap(get_stadiamap(bbox_everest, zoom = 10))

## As of 29-02-2024
## install newer version
packageVersion("ggmap")
## https://stackoverflow.com/questions/77418619/error-in-curlcurl-fetch-memoryurl-handle-handle-with-ggmap-package
detach(package:ggmap, unload = TRUE)
## options(download.file.method = "curl")
remotes::install_github("dkahle/ggmap")

## install on new windows machine via vs code in terminal [conda activate R -> enter: R]
install.packages("ggplot2",dependancy=TRUE)
## solution to install ggmap when got issue: https://github.com/forestgeo/learn/issues/102
options(download.file.method = "curl")
remotes::install_github("https://github.com/dkahle/ggmap")
library(ggmap)
?register_stadiamaps

## google API-Key - following not working anymore
## register_stadiamaps(key = "AIzaSyAsh8H8QRZdawAXfRhnnpJCCqz88coK1-8", write = TRUE)
## ggmap one works
register_stadiamaps(key = "10fc01ec-fa9a-4c7b-bfff-e4fc2312191b", write = TRUE)
## https://github.com/dkahle/ggmap/issues/237
httr::set_config(httr::use_proxy(url = "http://64.251.21.73", port = 8080), override = TRUE)
httr::set_config(httr::use_proxy(url = "http://proxy:8000"), override = TRUE)
urlonly = TRUE

get_googlemap("waco texas", urlonly = TRUE)
qmplot()

## https://www.r-bloggers.com/2018/10/getting-started-stamen-maps-with-ggmap/
data(Sacramento)
head(Sacramento)
df <- Sacramento %>% group_by(city) %>%
  summarize(median_price = median(price), transactions = n(),
            latitude = mean(latitude), longitude = mean(longitude))

qmplot(x = longitude, y = latitude, data = df, maptype = "stamen_watercolor", 
       geom = "point", color = median_price, size = transactions) +
  scale_color_gradient(low = "blue", high = "red")


data(Sacramento)
df <- Sacramento
height <- max(Sacramento$latitude) - min(Sacramento$latitude)
width <- max(Sacramento$longitude) - min(Sacramento$longitude)
sac_borders <- c(bottom  = min(Sacramento$latitude)  - 0.1 * height, 
                 top     = max(Sacramento$latitude)  + 0.1 * height,
                 left    = min(Sacramento$longitude) - 0.1 * width,
                 right   = max(Sacramento$longitude) + 0.1 * width)
#map <- get_stamenmap(sac_borders, zoom = 10, maptype = "terrain")
map <- get_stadiamap(sac_borders, zoom = 10, maptype = "stamen_terrain")

ggmap(map)+
  geom_point(data = df, mapping = aes(x = longitude, y = latitude, 
                                               col = type),size=0.5)

## data structure
city    zip beds baths sqft         type  price latitude longitude
1        SACRAMENTO z95838    2     1  836  Residential  59222 38.63191 -121.4349
2        SACRAMENTO z95823    3     1 1167  Residential  68212 38.47890 -121.4310

#### automatic zoom function - optimize zoom level ####
# https://gis.stackexchange.com/questions/356575/how-to-automatically-set-an-adequate-zoom-level-for-tiled-data-from-stamen-in-r
bbox=c(left = 10.6, bottom = 54.8, right =
         24.5, top = 69.2)
rosm:::tile.raster.autozoom(
  extract_bbox(
    matrix(bbox,ncol=2,byrow=TRUE)),
  epsg=4326
) #### suggested zoom = 5

bumblebee_site <- read.table("bumblebee_collection_sites_new.txt",sep = "\t",header = T,na.strings = "NA")
tail(bumblebee_site)
bumblebee_map <- get_stadiamap(bbox = c(left = 10.6, bottom = 54.8, right =
                                24.5, top = 69.2), zoom = 6, maptype = "stamen_terrain")
ggmap(bumblebee_map)+
  geom_point(data = bumblebee_site, mapping = aes(x = LON, y = LAT, 
                                      col = Species),size=0.6,alpha=0.6)+
  scale_colour_manual(values =c("red", "orange", "black","violet","deeppink","blue","cyan"))


## danmark bee excel data
install.packages("readxl")
library("readxl", help, pos = 2, lib.loc = NULL)
library(ggplot2, help, pos = 2, lib.loc = NULL)
setwd("/home/yzliu/eDNA/faststorage/yzliu/DK_proj/population_genomics/bee_proj_script")
## Denmark are in range: Latitude from 54.76906 to 57.72093 and longitude from 8.24402 to 14.70664
bee_site <- read_excel("organized_bee_lat_lon.xlsx")

bee_site <- read.table("organized_bee_lat_lon.tsv",sep = "\t",header = T,na.strings = "NA")
head(bee_site)
bee_map <- get_stadiamap(bbox = c(left = 7.7, bottom = 54.76906, right =12.5, top = 57.7), zoom = 10, maptype = "stamen_terrain")
#install.packages(c("sf","maptools"))
devtools::install_github('oswaldosantos/ggsn')
install.packages("devtools",denpendencies=TRUE)
library(devtools, help, pos = 2, lib.loc = NULL)
#install.packages("https://cran.r-project.org/src/contrib/Archive/ggsn/ggsn_0.5.0.tar.gz",repos=NULL,method="libcurl",dependencies= TRUE)
bee_site_plot <- ggmap(bee_map) +
                geom_point(data = bee_site, mapping = aes(x = as.numeric(Longitude), y = as.numeric(Latitude), col = Species_name), size=2,alpha=0.4) + 
                scale_colour_manual(values =c("red", "orange", "black","blue")) +
                theme(legend.position = c(0.2,0.9),legend.text = element_text(size=12), legend.background = element_rect(fill=NA))                 
                geom_label(aes(x=10, y=10, label="N"), size=3, label.padding=unit(1,"mm"), label.r=unit(1,"lines")) 

ggsave(filename="bee_site_plot_transparent_legend.pdf",height = 20, width =20, units = "cm", bee_site_plot)




#  scale_colour_manual(values = rainbow(9)) 
# https://r-graph-gallery.com/42-colors-names.html
#http://www.sthda.com/english/wiki/ggplot2-colors-how-to-change-colors-automatically-and-manually
####################
sisquoc <- read.table("test_lat_lon.txt",sep = "\t",header = T)
sbbox <- make_bbox(lon=sisquoc$lon,sisquoc$lat,f=.1)
sq_map <- get_map(location = sbbox,maptype = "terrain",source = "google")
ggmap(sq_map) + geom_point(data = sisquoc, mapping = aes(x = lon, y = lat), color = "red")

ggmap::register_google(key = "AIzaSyAsh8H8QRZdawAXfRhnnpJCCqz88coK1-8")

map <- get_map(location = "texas", zoom = 6, source = "stamen")
ggmap(map, fullpage = TRUE)

install.packages("mapproj")
library(mapproj)
map(database= "world", ylim=c(45,90), xlim=c(-160,-50), col="grey80", fill=TRUE, projection="gilbert", orientation= c(90,0,225))
lon <- c(-72, -66, -107, -154)  #fake longitude vector
lat <- c(81.7, 64.6, 68.3, 60)  #fake latitude vector
coord <- mapproject(lon, lat, proj="gilbert", orientation=c(90, 0, 225))  #convert points to projected lat/long
points(coord, pch=20, cex=1.2, col="red")
