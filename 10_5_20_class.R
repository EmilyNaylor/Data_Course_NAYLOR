# load packages
library(tidyverse)
library(skimr)
library(car)

#read in MLD data set
df <- read.csv("./Data/MLO_Metadata.csv")

#Quick look at data
glimpse(df)
skim(df)

# dplyr verbs ###
filter()##picks rows
select()##picks columns
arrange()## arranges data frame based on a column
mutate()## creates or modify columns as a function
group_by()# create groups based on column
summarise()# summarize...usually based on a grouped variable

%>% # pipe - output of left side become FIRST ARGUMENT of right side function

  
  
  
  
  
  
  
  
  
  









library(tidyverse)
library(car)





df <- read_csv('./Data/BioLog_Plate_Data.csv')
data("MplsStops")
data("MplsDemo")

glimpse(df)

# it's not tidy yet. Need to fix it up
df_long <- pivot_longer(df,starts_with("Hr_"),
                    names_to="Time", 
                    values_to="Absorbance",
                    names_prefix="Hr_")

nrow(df_long)/nrow(df) #look.... we made it 3 times as long!!

unique(df_long$Substrate)

#clean white space
str_squish(df_long$Substrate)

#change to numeric
df_long$Time<-as.numeric(df_long$Time)

names(df_long)[1]<- "SampleID"

#visualizations
df_long %>% 
  ggplot(aes(x=Time,y=Absorbance,color=`Sample ID`))+
      geom_smooth()+
     facet_wrap(~Substrate)+
  theme_minimal()


#combine clear creek 
df_long <- df_long %>% mutate(SampleType=case_when(SampleID %in% c("Clear_Creek","Waste_Water")~"Water",
                            SampleID %in% c("Soil_1","Soil_2")~"Soil"))

df_long %>% 
  ggplot(aes(x=Time,y=Absorbance,color=SampleType))+
  geom_smooth()+
  facet_wrap(~Substrate)+
  theme_minimal()   
