##################################################
#   This script performs a heterogeneous          #
#   two-sided subset analysis using the          #
#   package ASSET                                #
#                                                #
#   Author: Emily Naylor - Dec 7, 2020           #
#                                                #
##################################################

## Load the package ASSET ##
library("ASSET")
library(tidyverse)
library(patchwork)


## Load in the data "Data/SNP_Data_Organized.csv" ##
df <- read.csv("Data/SNP_Data_Organized.csv")

## Load in the Control Matrix ##
N00 <- read.table("Data/control_matrix.txt")
## Load in Case Matrix ##
N11 <- read.table("Data/case_matrix.txt")
## Load in Case/Control Matrix ##
N10 <- read.table("Data/case_control_matrix.txt")

## Change it into a matrix ##
N00 <- as.matrix(N00)
N11 <- as.matrix(N11)
N10 <- as.matrix(N10)

## Define the input arguments for the h.trait analysis ##
snps <- as.vector(df[, "snp"])
traits.lab <- paste(c("CeD","RA","SSc","T1D"))
beta.hat <- as.matrix(df[, paste(traits.lab, ".Beta", sep="")])
sigma.hat <- as.matrix(df[, paste(traits.lab, ".SE", sep="")])
cor <- list(N11=N11, N00=N00, N10=N10)
ncase <- diag(N11)
ncntl <- diag(N00)

## Perform a heterogeneous two-sided subset analysis ##
res <- h.traits(snps, traits.lab, beta.hat, sigma.hat, ncase=ncase,
                ncntl=ncntl, cor=cor, cor.numr=FALSE, search=1,
                side=2, meta=TRUE, zmax.args=NULL)

## Analysis summary ##
h.summary(res)
sum <- h.summary(res)

## Export the analysis results ##
write.csv(sum,file="Data/h_trait_analysis.csv")

## Extracting the SNPs that had significant associations 
## with at least 3 of the diseases ##

## retrieve the 1 sided subset ##
sd1 <- sum$Subset.1sided

## select SNPs with 3 or more traits association ##
disease3 <- filter(sd1,Pheno == "CeD,RA,SSc,T1D" | Pheno == "CeD,RA,SSc" |
         Pheno == "CeD,RA,T1D"|Pheno == "CeD,SSc,T1D" |
         Pheno == "RA,SSc,T1D")

## Create a table with the SNP information ##

## Create vector with the SNPs ##
high_SNPS <- disease3$SNP

## filter out the relevant SNPs and data from the original dataset ##
dat <- df %>% select("region","chr","position_bp","snp","a1","gene")%>%
  filter(snp %in% high_SNPS)

## keep SNP variable name the same ##
names(disease3)[names(disease3) == "SNP"] <- "snp"

## join the data together as results##
results <- full_join(disease3,dat,by="snp")

## Export the results of the SNP analysis ##
write.csv(results, file = "Results/Tables/SNP_results.csv")

## Create forest plots for each gene ##

## AFF3 ##
h.forestPlot(res, "rs13415465")
