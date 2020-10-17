## load needed packages
library(tidyverse)

# import data
df <- read_csv("designed_experiment.csv")

# get a fill for data
glimpse(df)
summary(df$Plant_Mass)
plot(df$Plant_Mass)

ggplot(df, aes(x=Plant_Mass, fill=Plant_Species)) + 
  geom_density(alpha=.5)+
  facet_wrap(~Water_Saturation)

ggplot(df, aes(x=Water_Saturation, y=Plant_Mass, color=Agricultural_Treatment))+
  geom_point()+
  geom_smooth(method="lm")+
  facet_wrap(~Plant_Species)

# try some linear models

mod1 <- glm(data=df,
             Plant_Mass ~ Water_Saturation)
plot(mod1$residuals)
summary(mod1)


mod2 <- glm(data=df,
            Plant_Mass ~ Water_Saturation + Agricultural_Treatment + Plant_Species)
summary(mod2)


mod3 <- glm(data=df,
            Plant_Mass ~ Water_Saturation * Agricultural_Treatment * Plant_Species)
summary(mod3)


#mean sq residules
mean(mod1$residuals^2)
mean(mod2$residuals^2)
mean(mod3$residuals^2) # mod3 has lowest residuals


# going with mod3, let's make predictions using it..
add_predicions(df,mod3)

