
install.packages("sp")
library(sp)
library(ggplot2)
library(grid) # for unit
library(gridExtra) # for grid.arrange

# zoom bounding box
xlim <- c(179500,181000); ylim <- c(332000,332500)

# size of zoomed area - offset from top left corner of main plot: 
x_offs <- 1000 ; y_offs <- 1300

# settings for full plot
fulltheme <- theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
            panel.background = element_blank(), 
            axis.text.x=element_blank(), axis.text.y=element_blank(),
            axis.ticks=element_blank(),
            axis.title.x=element_blank(), axis.title.y=element_blank())

# settings for zoom plot
zoomtheme <- theme(legend.position="none", axis.line=element_blank(),axis.text.x=element_blank(),
            axis.text.y=element_blank(),axis.ticks=element_blank(),
            axis.title.x=element_blank(),axis.title.y=element_blank(),
            panel.grid.major = element_blank(), panel.grid.minor = element_blank(), 
            panel.background = element_rect(color='red', fill="white"),
            plot.margin = unit(c(0,0,-6,-6),"mm"))


############## point example  #############
data(meuse)

# variables to plot
vars <- names(meuse)[3:10]

plotlist <- list()

for (i in vars) {
  # full plot
  p.full <- ggplot(meuse, aes_string(x = "x", y = "y", color=i)) + 
    geom_point() + fulltheme
  # zoomed plot
  p.zoom <- ggplot(meuse, aes_string(x = "x", y = "y", color=i)) + 
    geom_point() + coord_cartesian(xlim=xlim, ylim=ylim) + zoomtheme
  # put them together
  g <- ggplotGrob(p.zoom)
  plotlist[[length(plotlist) + 1]] <- p.full + 
    annotation_custom(grob = g, xmin = min(meuse$x), xmax = min(meuse$x) + x_offs, ymin = max(meuse$y) - y_offs, ymax = max(meuse$y))
}

# plot
do.call(grid.arrange,  c(plotlist, ncol=4))


install.packages("qplot")
p <- qplot(1:10, 1:10)

polydata <- data.frame(x = c(7.9, 10.1, 10.1, 7.9, 7.9),
                       y = c(7.9, 7.9, 10.1, 10.1, 7.9))
linedata <- data.frame(x = c(7.9, 7, 10.1, 10),
                       y = c(7.9, 5, 7.9, 5),
                       id = c("a", "a", "b", "b"))
p +
  geom_path(data = polydata, aes(x, y)) +
  geom_line(data = linedata, aes(x, y, group = id),
            linetype = "solid") +
  annotation_custom(
    grob = ggplotGrob(g),
    xmin = 7,
    xmax = 10,
    ymin = 1,
    ymax = 5
  )

## install unsuccessful package in R env if not woking Radian terminal
conda activate R
install.packages("ggpubr",dependencies = T)
library("ggpubr")
time <- seq(from = 0,
            to = 10,
            by = 0.5)

line_1 <- c(0, 0, 0, 66, 173, 426, 1440, 800, 1200, 400, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
line_2 <- c(0, 0, 0, 0, 0, 0, 0, 0, 1000, 25000, 5000, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)

df <- data.frame(time, line_1, line_2)

p1 = ggplot(data = df, aes(x = time)) +
  geom_line(aes(y = line_2), color = "red", position = position_nudge(x = 0.5, y = 1000)) +
  geom_line(aes(y = line_1),color = "blue") +
  geom_rect(aes(xmin = 1, xmax = 5, ymin = 0, ymax = 1500), color = "black", alpha = 0) +
  theme_pubr( base_size = 8, border = TRUE)

#The plot with a zoom
p2 = ggplot(data = df, aes(x = time, y = line_1)) +
  geom_line(color = "blue") +
  xlim (1, 5) +
  ylim (0, 1500) +
  theme_pubr( base_size = 8,border = TRUE)

p1 + 
  annotation_custom(ggplotGrob(p2), xmin = 7.5, xmax = 10, ymin = 10000, ymax = 20000) +
  geom_rect(aes(xmin = 7.5, xmax = 10, ymin = 10000, ymax = 20000), color='violet', linetype='dashed', alpha=0) +
  geom_path(aes(x,y,group=grp), 
            data=data.frame(x = c(1,7.5,5,10), y=c(1500,10000,1500,10000),grp=c(1,1,2,2)),
            linetype='dashed')
