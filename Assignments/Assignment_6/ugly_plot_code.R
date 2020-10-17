library(tidyverse)
library(colorspace)
library(colorblindr)
library(patchwork)
library(ggimage)


data <- data.frame(
  month_name=c("January", "February", "March","April","May","June","July","August","September","October","November","December"),
  daysuntilChristmas=c(0, 0, 0,0,0,0,0,0,0,27,30,25))

# Compute the cumulative percentages (top of each rectangle)
data$ymax = cumsum(data$daysuntilChristmas)

# Compute the bottom of each rectangle
data$ymin = c(0, head(data$ymax, n=-1))


# Make the plot
p1 <- ggplot(data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=month.name,)) +
  geom_rect() +
  coord_polar(theta="y") + # Try to remove that to understand how the chart is built initially
  xlim(c(2, 4)) + # Try to remove that to see how to make a pie chart
  labs(title = "Days until Christmas")
  

p1 + theme(axis.text = element_text(family="sans",color = "#56FF00",size=30),
           panel.background = element_rect(fill="#4A412A"),
           plot.title = element_text(family = "serif",size=10,angle=180,face="italic"),
           legend.text = element_text(color="red",face="bold"),
           plot.background = element_rect(fill = "#73a213",color="red"),
           legend.background = element_rect(fill="grey"),)
ggsave("./NAYLOR_uglyplot.png")

