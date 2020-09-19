library(tidyverse)

 
############
## Task 1 ##
############

dat <- read.csv("DNA_Conc_by_Extraction_Date.csv")
?hist
hist(dat$DNA_Concentration_Katy, main="Frequency of Katy's DNA Concentration Measurements ",xlab = "Measured DNA Concentrations")

jpeg("Katys_hist.jpeg")
hist(dat$DNA_Concentration_Katy, main="Frequency of Katy's DNA Concentration Measurements ",xlab = "Measured DNA Concentrations")
dev.off()


hist(dat$DNA_Concentration_Ben, main="Frequency of Ben's DNA Concentration Measurements ",xlab = "Measured DNA Concentrations")


jpeg("Bens_hist.jpeg")
hist(dat$DNA_Concentration_Ben, main="Frequency of Ben's DNA Concentration Measurements ",xlab = "Measured DNA Concentrations")
dev.off()



############
## Task 2 ##
############

class(dat$Year_Collected)
Year_Factor <- as.factor(dat$Year_Collected)

class(Year_Factor)

plot(x=Year_Factor, y=dat$DNA_Concentration_Katy, xlab= "YEAR", ylab= "DNA Concentration", main= "Katy's Extractions", col= "white")
?plot

plot(x=Year_Factor, y=dat$DNA_Concentration_Ben, xlab= "YEAR", ylab= "DNA Concentration", main= "Ben's Extractions", col= "white")




############
## Task 3 ##
############


jpeg("NAYLOR_Plot1.jpeg")
plot(x=Year_Factor, y=dat$DNA_Concentration_Katy, xlab= "YEAR", ylab= "DNA Concentration", main= "Katy's Extractions", col= "white")
dev.off()

jpeg("NAYLOR_Plot2.jpeg")
plot(x=Year_Factor, y=dat$DNA_Concentration_Ben, xlab= "YEAR", ylab= "DNA Concentration", main= "Ben's Extractions", col= "white")
dev.off()



############
## Task 4 ##
############

##Made sure that Ben always had higher concentrations compared to Katy##
filter(dat, DNA_Concentration_Ben > DNA_Concentration_Katy)
filter(dat, DNA_Concentration_Ben < DNA_Concentration_Katy)
filter(dat, DNA_Concentration_Ben == DNA_Concentration_Katy)

##New Vectors only containing the DNA Concentrations for Ben or Katy##
Ben_DNA <- dat[,"DNA_Concentration_Ben"]
Katy_DNA <- dat[,"DNA_Concentration_Katy"]

##Finding the differences between the concentrations of Ben and Katy##
Ben_DNA - Katy_DNA

##Putting those differences into a new vector##
Ben_Rel_Katy <- Ben_DNA - Katy_DNA

##Putting the smallest difference between the concentrations into a vector##
##(it was 0.0108855005)##
Ben_min <- min(Ben_Rel_Katy)

##Creating a logic class vector to determine which row had the smallest difference##
Ben_DNA - Katy_DNA == Ben_min
condit <- Ben_DNA - Katy_DNA == Ben_min

##Finding which row the True corresponded to##
?which()
which(condit)


##Discovering that which could also find the minimum value in a vector and using that instead##
Ben_min_fix <- which.min(Ben_Rel_Katy)

##Finding the Year that corresponded to the smallest difference between Ben and Katy's measurements##
dat[Ben_min_fix,"Year_Collected"]
BEN_Low_Rel_Katy_Year <- dat[Ben_min_fix,"Year_Collected"]
Year_Lowest_Ben_rel_Katy <- data.frame(
  "Year with Lowest Performance by Ben compared to Katy" = BEN_Low_Rel_Katy_Year)

##Putting the answer into a text file##
?write()
write.table(Year_Lowest_Ben_rel_Katy, file= "Task_4_Answer.txt", sep="", row.names = FALSE)


############
## Task 5 ##
############

?POSIXct
?as.POSIXct.date
?as.Date.POSIXct()
?axis.POSIXct()

downstairs <- filter(dat, Lab == "Downstairs")

class(downstairs$Date_Collected)

Date_Col <- as.POSIXct(downstairs$Date_Collected)
class(Date_Col)

plot(Date_Col,downstairs$DNA_Concentration_Ben, 
     xlab = "Date_Collected", ylab= "DNA_Concentration_Ben")

jpeg("Ben_DNA_over_time.jpg")
plot(Date_Col,downstairs$DNA_Concentration_Ben, 
     xlab = "Date_Collected", ylab= "DNA_Concentration_Ben")
dev.off()


########################
## Task 6 (Bonus Task)##
########################

Ben_Only <- dat[,c("DNA_Concentration_Ben","Date_Collected")]

?mean()
mean(Ben_Only$DNA_Concentration_Ben)

levels(Year_Factor)

class(Ben_Only$Date_Collected)
Ben_Only$Date_Collected <- as.Date(Ben_Only$Date_Collected)
?format
Ben_Only$Year <- format(Ben_Only$Date_Collected,format="%Y")

?aggregate()
aggregate(DNA_Concentration_Ben ~ Year, Ben_Only , mean )

BEN_Yearly_Averge <- aggregate(DNA_Concentration_Ben ~ Year, Ben_Only , mean )

max(BEN_Yearly_Averge$DNA_Concentration_Ben)
Average_Max <- max(BEN_Yearly_Averge$DNA_Concentration_Ben)


which.max(BEN_Yearly_Averge$DNA_Concentration_Ben)
x <- which.max(BEN_Yearly_Averge$DNA_Concentration_Ben)

BEN_Yearly_Averge[x,"Year"]
Yearly_Max <- BEN_Yearly_Averge[x,"Year"]

Bonus_Task_Answer <- data.frame("Year" = Yearly_Max, "Average DNA Concentration" = Average_Max)
write.csv(Bonus_Task_Answer, file="Bonus_Task_Answer.txt", row.names = FALSE)

write.csv(BEN_Yearly_Averge, file="Ben_Average_Conc.csv", row.names = FALSE)
