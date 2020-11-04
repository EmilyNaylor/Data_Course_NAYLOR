# Cleaning the bird data set.

#packages
library(tidyverse)
library(janitor)



# data set
df <- read_csv("./Data/Bird_Measurements.csv") %>%
  select(!ends_with("_N"))

janitor::make_clean_names((names(df)))


str(df)
names(df)

names(df)[names(df) == "unsexed_mass"] <- "Unsexed_mass"

#make families a factor
df$Family <- as.factor(df$Family)

# make longer by making gender a variable.

male <- df %>% select(c(1:4,20:22), starts_with("m"))%>%
               pivot_longer(starts_with("m_"),
                            names_to= "Measurement",
                            values_to="Value",
                            names_prefix= "m_")%>%
                mutate(Sex="male")
female <- df %>% select(c(1:4,20:22), starts_with("f"))%>% 
                pivot_longer(starts_with("f_"),
                              names_to= "Measurement",
                              values_to="Value",
                              names_prefix= "f_")%>%
                mutate(Sex="female")
unisex <- df %>% select(c(1:4,20:22), starts_with("u"))%>%
                  pivot_longer(starts_with("unsexed_"),
                               names_to= "Measurement",
                               values_to="Value",
                               names_prefix= "unsexed_")%>%
                  mutate(Sex="unsexed")



