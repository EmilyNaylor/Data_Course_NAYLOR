# load packages
library(tidyverse)


############
## Task 1 ##
############

## Load the landdata-states.csv file into R ##
df <- read.csv("landdata-states.csv")

## To change the y-axis values to plain numeric, add options(scipen = 999) to your script ##
options(scipen = 999)

## Re-create the graph shown in "fig1.png" ##
p1 <- ggplot(df, aes(x=Year, y=Land.Value, color=region))+
  geom_smooth()+
  labs(x="Year", y="Land Value (USD", color= "Region")+
  theme_minimal()

p1

## Export it to your Exam_2 folder as LASTNAME_Fig_1.jpg (note, that's a jpg, not a png) ##
ggsave("NAYLOR_Fig_1.jpg", plot= p1)


############
## Task 2 ##
############

## What is "NA Region???" ##
## Write some code to show which state(s) are found in the "NA" region ##

NA_states <- df %>% filter(is.na(region)) %>% ## filters only the NA region
  select(State) %>% ## selects only the states
  distinct() ## deletes any duplicates

NA_states

## Save the states found in NA region as a text file ##
write.csv(NA_states, "Task2answr.txt", row.names = FALSE)


############
## Task 3 ##
############

## The rest of the test uses another data set. The unicef-u5mr.csv data. Get it loaded and take a look.##
## It's not exactly tidy. You had better tidy it! ##
df2 <- read.csv("unicef-u5mr.csv")

## Tidy the data by making a variable year and a variable U5MR ##
df2 <- pivot_longer(df2,starts_with("U5MR."),
                        names_to="Year", 
                        values_to="U5MR",
                        names_prefix="U5MR.")
df2

## Save as a new tidy data-set""
write.csv(df2, "unicef-u5mr_long.csv")


############
## Task 4 ##
############


## Re-create the graph shown in fig2.png ##

## Change Year into a continuous numeric value ##
class(df2$Year)
df2$Year <- as.numeric(df2$Year)

## Create a plot the same as fig2 ##
p2 <- df2 %>% ggplot(aes(x=Year, y=U5MR, color=Continent))+
  geom_point(size=2, aes(color=Continent)) +
  labs(y= "Mortality Rate") +
  theme_minimal()

p2

## Export it to your Exam_2 folder as LASTNAME_Fig_2.jpg (note, that's a jpg, not a png)##
ggsave("NAYLOR_Fig_2.jpg", plot=p2)


############
## Task 5 ##
############

## Re-create the graph shown in fig3.png ##
## Note: This is a line graph of average mortality rate over time for each continent ## 
## (i.e., all countries in each continent, yearly average), this is NOT a geom_smooth() ## 


## filter and find the yearly mean by continent ##
yearly_mean <- df2 %>%
  group_by(Continent, Year) %>% ## filters by continent and year
  na.omit() %>%            ## removes any na values
  mutate(MeanMR= mean(U5MR))## finds the mean mortality rate

## Re-creation of fig3 ##
p3 <- yearly_mean %>% 
  ggplot(aes(x=Year, y=MeanMR, color=Continent))+
  geom_line(size=2, lineend= "round")+
  labs(y="Mean Mortality Rate (deaths per 1000 live births)")+
  theme_minimal()

p3
  
## Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png) ##
ggsave("NAYLOR_Fig_3.jpg", plot=p3)
  
############
## Task 6 ##
############

## Re-create the graph shown in fig4.png ##
## Note: The y-axis shows proportions, not raw numbers ##
## This is a scatterplot, faceted by region ##


## find the yearly proportion by region##
prop <- df2 %>% 
  group_by(Region, Year)%>%
  na.omit()%>%
  mutate(U5MR/sum(U5MR))%>%
  arrange(Region)



#copy figure 4##
p4 <- prop %>% 
  ggplot(aes(x=Year, y=U5MR/sum(U5MR)*1000))+
           geom_point(color="blue",alpha=0.4, size=0.5)+
           facet_wrap(~Region) + 
          ylim(0,0.45) +
          labs(y="Mortality Rate")+
          theme_minimal()+
          theme(strip.background = element_rect(color="black", fill="white"),
                strip.text = element_text(size=7))
p4

## Export it to your Exam_2 folder as LASTNAME_Fig_3.jpg (note, that's a jpg, not a png) ##
ggsave("NAYLOR_Fig_4.jpg", plot=p4)
