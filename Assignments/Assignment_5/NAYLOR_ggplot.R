library(tidyverse)
library(carData)
library(RColorBrewer)
library(colorblindr)


################
##First Figure##
################

data(iris)

p1= ggplot(iris, aes(y=Petal.Length, x=Sepal.Length))+
  geom_point(aes(color=Species))+ geom_smooth(method = "lm", aes(color=Species))
p1
p1 + labs(title = "Sepal length vs petal length", subtitle = "for three iris species") +
  theme_minimal()
plot1 <-p1 + labs(title = "Sepal length vs petal length", subtitle = "for three iris species") +
  theme_minimal()           

ggsave("./iris_fig1.png")
?ggsave


#################
##Second Figure##
#################

ggplot(iris, aes(x=Petal.Width, fill=Species))+
  geom_density(alpha=.5) +
  theme_minimal() +
  labs(title="Distribution of Petal Widths", subtitle = "for three iris species",
       x="Petal Width")

ggsave("./iris_fig2.png")

################
##Third Figure##
################

class(iris$Species)

iris$width_ratio <- iris$Petal.Width/iris$Sepal.Width

ggplot(iris, aes(y=width_ratio,x=Species))+
  geom_boxplot(aes(fill=Species)) +
  theme_minimal()+
  labs(title = "Sepal- to Petal-Width Ratio",subtitle = "for three iris species", y="Ratio of Sepal Width to Petal Width")

ggsave("./iris_fig3.png")


#################
##Fourth Figure##
#################

data(iris)
iris$Sepal.Length_z <- round((iris$Sepal.Length - mean(iris$Sepal.Length))/sd(iris$Sepal.Length), 2) 
iris <- iris[order(iris$Sepal.Length_z), ] 
iris$order <- c(1:150)


iris$order <- as.factor(iris$order)
class(iris$order)

p2 <- ggplot(iris, aes(y=Sepal.Length_z, x=order,), color="white") + 
  geom_bar(stat='identity', aes(fill=Species),)  +
  labs(title= "Sepal length deviation from the mean of all observations",
       y="Deviance from the Mean",
       caption="Note: Deviance= Sepal.Length -mean(Sepal.Length)") + 
  coord_flip()

p2 + theme(axis.text.y = element_blank(),
           axis.title.y = element_blank(),
           axis.line.y = element_blank(),
           axis.ticks.y = element_blank())

ggsave("./iris_fig4.png")
