## First, load some useful packages…##
library(modelr)
library(broom)
library(tidyverse)
library(MASS)
library(car)
library(dplyr)
library(patchwork)

## Next, load some data… ##
data("mtcars")
glimpse(mtcars)

## Let’s try a simple linear model with displacement and horsepower as explanatory variables…
mod1 = lm(mpg ~ disp, data = mtcars)
summary(mod1)

## It may help to look at it visually…##
ggplot(mtcars, aes(x=disp,y=mpg)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()

## Let’s look at one that incorporates speed instead ##
mod2 = lm(mpg ~ qsec, data = mtcars)
ggplot(mtcars, aes(x=disp,y=qsec)) + 
  geom_point() + 
  geom_smooth(method = "lm") +
  theme_minimal()


##How to compare these two different models?##
mean(mod1$residuals^2)
mean(mod2$residuals^2)


## The add_predictions() function from the modelr package lets us take our data frame and our model
## and look at what values our model assigns to our response variable (mpg). This is looking at ACTUAL 
## vs PREDICTED values. If they are close enough for comfort we can move on and make predictions for
## unknown values in our model.
df <- mtcars %>% 
  add_predictions(mod1) 
df[,c("mpg","pred")] %>% head()

# Make a new dataframe with the predictor values we want to assess
# mod1 only has "disp" as a predictor so that's what we want to add here
newdf = data.frame(disp = c(500,600,700,800,900)) # anything specified in the model needs to be here with exact matching column names

# making predictions
pred = predict(mod1, newdata = newdf)

# combining hypothetical input data with hypothetical predictions into one new data frame
hyp_preds <- data.frame(disp = newdf$disp,
                        pred = pred)

# Add new column showing whether a data point is real or hypothetical
df$PredictionType <- "Real"
hyp_preds$PredictionType <- "Hypothetical"

# joining our real data and hypothetical data (with model predictions)
fullpreds <- full_join(df,hyp_preds)

# plot those predictions on our original graph
ggplot(fullpreds,aes(x=disp,y=pred,color=PredictionType)) +
  geom_point() +
  geom_point(aes(y=mpg),color="Black") +
  theme_minimal()


##################
## Assignment 8 ##
##################


## loads the “/Data/mushroom_growth.csv” data set ##
df <- read_csv("../../Data/mushroom_growth.csv")

## creates several plots exploring relationships between the response and predictors ##

## Plot 1, how light affects growth rate ##
ggplot(df, aes(x=as.factor(Light), y=GrowthRate, color=Species))+
  geom_boxplot()

## Plot 2, how nitrogen concentration affects growth rate ##
ggplot(df, aes(x=as.factor(Nitrogen), y=GrowthRate, color=Species))+
  geom_boxplot()

## Plot 3, how humidity affects growth rate ##
ggplot(df, aes(x=as.factor(Humidity), y=GrowthRate, color=Species))+
  geom_boxplot()

## Plot 4, how temperature affects growth rate ##
ggplot(df, aes(x=as.factor(Temperature), y=GrowthRate, color=Species))+
  geom_boxplot()

## defines at least 2 models that explain the dependent variable “GrowthRate” ##

##Model with growth rate as a function of all of the variables##
mod_all= glm(GrowthRate ~ Species * Light * Nitrogen * 
                          Humidity * Temperature, data=df)

summary(mod_all)

##Step AIC to determine which relationships are important##
modall_step <- stepAIC(mod_all)

##Create a new model based on the step##
stepall_mod <- glm(data=df, formula=modall_step$formula)
summary(stepall_mod)

##New model based upon significance from the step model##
mod1 = glm(GrowthRate ~ Species * Light* Humidity * Temperature, data=df)
summary(mod1)

##New step AIC to get an equation with better significance##
step1 <- stepAIC(mod1)

##It outputted the exact same equation so I will just keep model 1 as is ##
## Model 2, testing a model without temperature because it was not as significant as other variables##
mod2 = glm(GrowthRate ~ Species * Light* Humidity, data=df)
summary(mod2)

##New step AIC to get an equation with better significance##
step2 <- stepAIC(mod2)

##Trying last two formulas as new aov models##

##Model with GrowthRate as a function of Light, Species, Humidity, and Temperature##
mod3 = aov(GrowthRate ~ Species * Light* Humidity * Temperature, data=df)
summary(mod3)

##Model same as model 3 but without Temperature##
mod4 = aov(GrowthRate ~ Species * Light* Humidity, data=df)
summary(mod4)

##calculates the mean sq. error of each model##

##Model with all##
mean(mod_all$residuals^2)

##Model with the AIC version of all##
mean(modall_step$residuals^2)

##Model 1##
mean(mod1$residuals^2)

##Model 2##
mean(mod2$residuals^2)

##Model 3##
mean(mod3$residuals^2)

##Model 4##
mean(mod4$residuals^2)


## selects the best model you tried ##

###############
## Model 3 !!##
###############

## adds predictions based on new hypothetical values ##
  ## for the independent variables used in your model ##
df_pre <- df %>% 
  add_predictions(mod3) 
df_pre[,c("GrowthRate","pred")] %>% head()

##Select only the predictors##
print(df)
df3 = data.frame(Species= c("P.ostreotus","P.ostreotus","P.ostreotus","P.ostreotus"),
                 Light=c(5,15,25,30),
                 Humidity=c("High", "High", "High", "High"),
                 Temperature=c(20,20,20,20))

## make predictions ##
pred = predict(mod3, newdata = df3)

##combine hypothetical input data with their predictions##
hyp_preds <- data.frame(Species = df3$Species,
                        Light =  df3$Light,
                        Temperature = df3$Temperature,
                        Humidity = df3$Humidity,
                        pred = pred)

## new column with either real or hypothetical ##
df_pre$PredictionType <- "Real"
hyp_preds$PredictionType <- "Hypothetical"


## join the data-sets for plotting##
fullpreds <- full_join(df_pre,hyp_preds)

## plots these predictions alongside the real data ##
##plot based on light## 
p2 <- ggplot(fullpreds,aes(x=Light,y=pred,color=PredictionType)) +
  geom_point (size=3) +
  geom_point(aes(y=GrowthRate),shape=1, color="Black")+
  theme_minimal()
p2

## Write the code you would use to model the data found in##
##“/Data/non_linear_relationship.csv” with a linear model 
##(there are a few ways of doing this)##

##load the data in##
dat <- read_csv("../../Data/non_linear_relationship.csv")

##Plot the Data##
ggplot(dat,aes(x=predictor,y=response))+
  geom_point()+
  geom_smooth(method="lm")

##Plotting with a linear model##
dat2 <- dat %>%
  filter(predictor >= 1) %>% #99% data is above 1#
  mutate(lpredictor = log2(predictor), lresponse= log2(response)) #log transform the data#

##Take a look##
ggplot(dat2,aes(x=lpredictor,y=lresponse))+
  geom_point()+
  geom_smooth(method="lm")

##Make a model of the data##
mod_dat <- lm(lpredictor ~ lresponse, data = dat2)
summary(mod_dat)



