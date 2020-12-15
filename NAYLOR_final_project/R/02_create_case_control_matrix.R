##################################################
#   This script creates a case-control overlap   #
#     matrices based on the number of controls   #
#     and cases.                                 #
#                                                #
#   Author: Emily Naylor - Dec 7, 2020           #
#                                                #
##################################################


## Numbers for the matrices can be found in "Data/snp_data_raw.xlsx" on the first sheet ##

## Control Matrix 
## number of controls shared for Celiac Disease ##
CeDctrl <- c(13902,12628,13896,9416)
        #CeD    RA    SSc  T1D    
## number of control shared for Rheumatoid Arthritis ##
RActrl <- c(12628,19862,12623,9416)
        #CeD   RA    SSc   T1D
## number of control shared for Systemic Sclerosis ##
SScctrl <- c(13896,12623,15067,9411)
        #CeD   RA    SSc   T1D
## number of control shared for Type 1 Diabetes ##
T1Dctrl <- c(9416,9416,9411,9416)
         #CeD  RA  SSc  T1D

## Create a matrix ##
cntrl <- rbind(CeDctrl,RActrl,SScctrl,T1Dctrl)

## Change the column names ##
colnames(cntrl) <- c("CeD","RA","SSc","T1D")
rownames(cntrl) <- c("CeD","RA","SSc","T1D")

## Export the control matrix ##
write.table(cntrl,file="Data/control_matrix.txt")


## Case Matrix ##
## Control Matrix 
## number of controls shared for Celiac Disease ##
CeDcs <- c(11489,0,0,0)
   
## number of control shared for Rheumatoid Arthritis ##
RAcs <- c(0,15523,0,0)

## number of control shared for Systemic Sclerosis ##
SSccs <- c(0,0,3477,0)

## number of control shared for Type 1 Diabetes ##
T1Dcs <- c(0,0,0,7670)

## Create a matrix ##
case <- rbind(CeDcs,RAcs,SSccs,T1Dcs)

## Change the column names ##
colnames(case) <- c("CeD","RA","SSc","T1D")
rownames(case) <- c("CeD","RA","SSc","T1D")

## Export the control matrix ##
write.table(case,file="Data/case_matrix.txt")


## Case/Control Matrix ##
## number of cases/controls shared for Celiac Disease ##
CeD <- c(0,0,0,0)

## number of cases/controls shared for Rheumatoid Arthritis ##
RA <- c(0,0,0,0)

## number of cases/controls shared for Systemic Sclerosis ##
SSc <- c(0,0,0,0)

## number of cases/controls shared for Type 1 Diabetes ##
T1D <- c(0,0,0,0)

## Create a matrix ##
case_ctrl <- rbind(CeD,RA,SSc,T1D)

## Change the column names ##
colnames(case_ctrl) <- c("CeD","RA","SSc","T1D")
rownames(case_ctrl) <- c("CeD","RA","SSc","T1D")

## Export the case/control matrix ##
write.table(case_ctrl,file="Data/case_control_matrix.txt")


