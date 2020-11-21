## loaded packages
library(tidyverse)
library(broom)
library (janitor)



############
## Task 1 ##
############
## Load and clean FacultySalaries_1995.csv file ##

# Loaded Data in 
fs <- read_csv("FacultySalaries_1995.csv")

# get rid of un-necessary capitalization 
names(fs) <- make_clean_names(names(fs))
names(fs)

# separate full professor, associate professor, associate professor, and all professors

# full professor
full <- fs %>% select(c(1:4,16), ends_with("_all"), matches("full_prof")) %>%
  pivot_longer(contains("full_prof"),
               names_to= c("measurement", "rank"),values_to="average",
               names_prefix= "avg_full_prof_",
               names_sep= "_") %>%
  mutate(rank="Full")
               

# associate professor
assoc <- fs %>% select(c(1:4,16), ends_with("_all"), matches("assoc_prof")) %>%
  pivot_longer(contains("assoc_prof"),
               names_to= c("measurement", "rank"),values_to="average",
               names_prefix= "avg_assoc_prof_",
               names_sep= "_") %>%
  mutate(rank="Assoc")

# assistant professor
assist <- fs %>% select(c(1:4,16), ends_with("_all"), matches("assist_prof")) %>%
  pivot_longer(contains("assist_prof"),
               names_to= c("measurement", "rank"),values_to="average",
               names_prefix= "avg_assist_prof_",
               names_sep= "_") %>%
  mutate(rank="Assist")

#combine the different ranks
full <- rbind(full,assoc,assist)

# re-make the comp, salary, and number columns 
full <- full %>% pivot_wider(
  names_from = measurement,
  values_from = average)

#change rank from character to factor)
full$rank <- as.factor(full$rank)
str(full$rank)

## Re-create the graph shown in "fig1.png" ##
## Please pay attention to what variables are on this graph. ##
## This task is really all about whether you can make a tidy dataset out of something a bit wonky. ##
## Refer back to the video where we cleaned "Bird_Measurements.csv" ##

p1 <- full %>% filter(tier != "VIIB") %>%
  ggplot(aes(x=rank, y=salary, fill=rank))+
  geom_boxplot() +
  facet_wrap(~tier)+
  labs(y="Salary", x="Rank", fill="Rank")+
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 75))
p1

## Export it to your Exam_3 folder as LASTNAME_Fig_1.jpg (note, that's a jpg, not a png)##
ggsave("NAYLOR_Fig_1.jpg", plot=p1)


############
## Task 2 ##
############

## Export an ANOVA table to a file called "Salary_ANOVA_Summary.txt" ##
## The ANOVA model should test the influence of "State", "Tier", and "Rank" ##
## on "Salary" but should NOT include any interactions between those predictors.##

# create a model using state, tier, and rank as predictors for salary
mod1 <- aov(data= full, salary ~ state + tier + rank)

#summary of the modal
summary(mod1)

#export the ANOVA table.
capture.output(summary(mod1), file="Salary_ANOVA_Summary.txt")


############
## Task 3 ##
############

## The rest of the test uses another data set. The "Juniper_Oils.csv" data. Get it loaded and take a look. ##
## It's not exactly tidy either. Get used to that. It's real data collected as part of a collaboration between ##
## Young Living Inc. and UVU Microbiology. A number of dead cedar trees were collected and the chemical composition ##
## of their essential oil content was measured. The hypothesis was that certain chemicals would degrade over time since ## 
## they died in fires. So there are a bunch of columns for chemical compounds, and a column for "YearsSinceBurn." 
## The values under each chemical are Mass-Spec concentrations. ##

#load in the "Juniper_Oils.csv" data.
jo <- read_csv("Juniper_Oils.csv")

# select only the desired columns
jo_chem <- jo %>%
  select('alpha-pinene':thujopsenal,41) %>%
  pivot_longer(-YearsSinceBurn,
               names_to="ChemicalID",
               values_to="Concentration")


############
## Task 4 ##
############

## Make me a graph of the following:
## x = YearsSinceBurn
## y = Concentration
## facet = ChemicalID (use free y-axis scales)
## See Fig2.png for an idea of what I'm looking for

p2 <- jo_chem %>%
  ggplot(aes(x=YearsSinceBurn, y=Concentration))+
  geom_smooth()+
  facet_wrap(~ChemicalID, scales= "free") +
  theme_minimal()
p2

# export the graph
ggsave("NAYLOR_Fig_2.jpg",plot=p2, width=10)


############
## Task 5 ##
############

## Use a generalized linear model to find which chemicals show concentrations that are significantly (significant, as in P < 0.05) ##
## affected by "Years Since Burn". Use the tidy() function from the broom R package ##
## (Thank Dalton for asking about this) in order to produce a data frame showing JUST the significant chemicals and their model output (coefficient estimates, p-values, etc)##   

mod2 <- lm(Concentration ~ ChemicalID * YearsSinceBurn, jo_chem)

# summarize the model
summary(mod2)

#tidy the model
tidy(mod2)
tidy_mod2= tidy(mod2)

# get the significant of less than 0.5
glm_sig <- filter(tidy_mod2, p.value < 0.05)

#clean the data to get rid of ChemicalID
glm_sig$term <- str_remove(glm_sig$term, "ChemicalID")

# the table of chemicals with significance of less than 0.05
glm_sig
