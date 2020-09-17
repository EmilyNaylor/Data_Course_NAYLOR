library(tidyverse)

read.csv("../../Data/ITS_mapping.csv")
maps <- read.csv("../../Data/ITS_mapping.csv")
?read_csv
read.delim("../../Data/ITS_mapping.csv")
maps <- read.delim("../../Data/ITS_mapping.csv")
read.delim2("../../Data/ITS_mapping.csv")
maps2 <- read.delim2("../../Data/ITS_mapping.csv")
?plot
?boxplot
plot(x=maps$Ecosystem, y=maps$Lat)
class(maps$Ecosystem)
as.factor(maps$Ecosystem)
Ecosystem_factor <- as.factor(maps$Ecosystem)
class(Ecosystem_factor)
boxplot(x=Ecosystem_factor, y=maps$Lat)
plot(x=maps$Ecosystem,y=maps$Lat)
boxplot(Lat ~ Ecosystem, data = maps)
dev.off()
class(maps$Ecosystem)
plot(x=Ecosystem_factor,y=maps$Lat)

?plot
?png
png("silly_boxplot.png",width=960)
plot(x=Ecosystem_factor,y=maps$Lat,main="Silly Boxplot",xlab="Ecosystem",ylab="Latitude")
dev.off()
