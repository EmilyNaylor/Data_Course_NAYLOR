library(tidyverse)
library(modelr)
library(MASS)
library(patchwork)


df <- modelr::heights
head(df)


mod1 <- lm(data=df, formula = income ~ height * sex)


summary(mod1)
mean(residuals(mod1)^2)

mod_full <- glm(data=df, 
                formula= income ~ height * weight * sex * marital * education)

p1 <- add_predictions(df, mod_full) %>%
  ggplot(aes(x=height,color=sex))+
  geom_point(aes(y=income)) +
  geom_point(aes(y=pred),color="black", size=0.5)+
  ggtitle("mod_full")

p2 <- add_predictions(df, mod1) %>%
  ggplot(aes(x=height,color=sex))+
  geom_point(aes(y=income)) +
  geom_point(aes(y=pred),color="black", size=0.5)+
  ggtitle("mod1")

p1/p2





step <- stepAIC(mod_full)
step$formula

mod_step <- glm(data=df, 
                formula=step$formula)

p3 <- add_predictions(df, mod_step) %>%
  ggplot(aes(x=height,color=sex))+
  geom_point(aes(y=income)) +
  geom_point(aes(y=pred),color="black", size=0.5)+
  ggtitle("mod_step")


p1/p2/p3


anova(mod_full, mod_step)

mean(residuals(mod_full)^2)
mean(residuals(mod_step)^2)




# Grad school admissions
df2 <- read_csv("./Data/GradSchool_Admissions.csv")

#change to true false
df2$admit <- as.logical(df2$admit)

mod3 <- glm(data=df2,
            admit ~ gre + gpa * rank, family="binomial")

add_predictions(df2, mod3, type="response")  %>%
  ggplot(aes(x=gpa, y=pred, color=gre))+
  geom_point()+
  facet_wrap(~rank)
summary(mod3)

df2 %>% 
  ggplot(aes(x=factor(rank), y=gre))+
  geom_boxplot()


