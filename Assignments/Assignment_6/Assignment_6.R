library(tidyverse)
library(colorspace)
library(colorblindr)
library(patchwork)

## 1 ##
data("mtcars")

## 2 ##
?mtcars
filter(mtcars, am=="0")
automatic<- filter(mtcars,am=="0")

## 3 ##
write.csv(automatic, "automatic_mtcars.csv")


## 4 ##
pa <- ggplot(automatic,aes(x=hp, y=mpg))+
  labs(title = "Effect of horsepower on miles per a gallon for automatic transmissions",
                                              y="Miles per gallon", x="Horsepower")
pa + geom_point(color="#6d8da8")+
  geom_smooth(span=0.5,color="#0c0d0c", se=FALSE)+
  theme_minimal()


## 5 ##
ggsave("./mpg_vs_hp_auto.png")

## 6 ##
pa2 <- ggplot(automatic,aes(x=wt, y=mpg))+
  labs(title = "Effect of weight on miles per a gallon for automatic transmissions",
       y="Miles per gallon", x="Weight (*1000 lbs)")
pa2 + geom_point()+
  geom_smooth(span=0.8,se=FALSE)+
  theme_minimal()

## 7 ##
ggsave("./mpg_vs_wt_auto.tiff")


## 8 ##
dis200 <- filter(mtcars, disp < 200 | disp == 200)

## 9 ##
write.csv(dis200,"mtcars_max200_displ.csv")


## 10 ##
or_max <- max(mtcars$hp)
aut_max <- max(automatic$hp)
dis200_max <- max(dis200$hp)
Max_hp <- data.frame("Original"= or_max, "Automatic"=aut_max, "200 max disp."=dis200_max, row.names = " Max Horsepower")


## 11 ##
write.table(Max_hp,"hp_maximums.txt")
tst <- read.table("hp_maximums.txt")

## 12 ##
p1 <- ggplot(mtcars,aes(x=wt, y=mpg))+
  labs(title = "Effect of Weight on MPG", x= "Weight (*1000 lbs)", y= "Miles per a Gallon")+
  geom_smooth(method="lm", se=FALSE, aes(color=as.factor(cyl)))+
  geom_point(aes(color=as.factor(cyl)))+
  scale_color_manual(values = c("#00798c", "#d1495b","#edae49"), name = "# fo cylinders", labels = c('4', '6','8'))+
  theme_minimal()
p1

p2 <- ggplot(mtcars,aes(x=as.factor(cyl), y=mpg, color=as.factor(cyl)))+
  labs(title = "Effect of Cylinder Number on MPG", x= "# of Cylinders", y= "Miles per a Gallon")+
  geom_violin(aes(fill=as.factor(cyl)))+
  scale_fill_manual(values = c("#00798c", "#d1495b","#edae49"), name = "# of cylinders", labels = c('4', '6','8'))+
  scale_color_manual(values = c("#00798c", "#d1495b","#edae49"), name = "# of cylinders", labels = c('4', '6','8'))+
  theme_minimal()
p2

p3 <- ggplot(mtcars,aes(x=hp, y=mpg))+
  labs(title = "Effect of Horsepower on MPG", x= "Horspower", y= "Miles per a Gallon")+
  geom_smooth(method="lm", se=FALSE, aes(color=as.factor(cyl)))+
  geom_point(aes(color=as.factor(cyl)))+
  scale_color_manual(values = c("#00798c", "#d1495b","#edae49"), name = "# of cylinders", labels = c('4', '6','8'))+
  theme_minimal()
p3

p1 + p2 + p3 

## 13 ##
ggsave("combined_mtcars_plot.png", width = 15)
