##################################################
#   This script loads and cleans the raw data    #
#   and saves the clean data set.                #
#                                                #
#   Author: Emily Naylor - Nov 25, 2020          #
#                                                #
##################################################

## Load packages ##
library(tidyverse)
library(janitor)

## Load in the cleaned excel file ##
dat <- read.csv("Data/SNP_meta_data_cleaned_excel.csv")

## Inspect data set ##
glimpse(dat)
names(dat)

## Clean the names ##
names(dat) <-janitor::make_clean_names(names(dat))

## Check the names ##
names(dat)

## Sub-set data for the two-sided subset-based meta-analysis ##
## of the heterogenous disease meta-analyses ##
# See ASSET_manual_examples.R: Heterogeneous traits or studies or the ASSET Vignette online for more information #

## Finding the SE from p-values and Z-score ##
 dat <-dat %>%
   mutate(se=abs(or/qnorm(p)))

## Create new subsetted datasets with the standard error and the odds ratio ##
## In order to pivot them wider ##
 
# Create the OR data-subset
 OR <- dat %>%
   select(-c("se", "p", "maf_cases", "maf_ctrls")) %>%
   pivot_wider(names_from = meta_analysis_disease,
               values_from = or)
 
# Adjust names 
 colnames(OR)[7:10] <- paste(colnames(OR)[7:10], "Beta", sep = ".")

# Create the SE data-subset
 SE <- dat %>%
   select(-c("or", "p", "maf_cases", "maf_ctrls")) %>%
   pivot_wider(names_from = meta_analysis_disease,
               values_from = se)
 
 # Adjust names 
 colnames(SE)[7:10] <- paste(colnames(SE)[7:10], "SE", sep = ".")

 ## Combine the subsets together to create a new data frame ##
 ## that will have the SE and OR by disease ##
 
 full_dat <- full_join(OR,SE)
 
## Save the cleaned data, "Data/SNP_Data_Organized.csv" ##
 write.csv(full_dat, "Data/SNP_Data_Organized.csv")
 