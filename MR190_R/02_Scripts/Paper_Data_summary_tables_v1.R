

#Clear existing data and graphics
rm(list=ls())
graphics.off()


#####################################
# find working directory
getwd() #Shows the default working directory 
# "MR190_R"
#####################################

#install.packages("gmodels")
#install.packages("sjmisc")
#install.packages("gtools")
#install.packages("readxl")

#install.packages("table1")
#install.packages("gtsummary")  

#install.packages("xfun")

#Load libraries
library(tidyverse)
library(dplyr)
library(ggplot2)
library(sjmisc)
library(gmodels)
library(Hmisc)
library(readxl)
library(writexl)
library(table1)
library(gtsummary)
library(stats)
library(rstatix)

import::from("sjmisc", "frq")
import::from("gmodels", "CrossTable")


#####################################################################
# to adjust decimal places of categorical variables

my.render.cat <- function(x) {
  c("", sapply(stats.default(x), function(y) with(y,
                                                  sprintf("%d (%0.0f%%)", FREQ, PCT))))
}

#####################################################################


# reload the data data_MR190.Rda data object
data <- readRDS("03_Output/Data/data_190_variables.Rda") 

colnames(data)


#####################
# update labels

label(data$region.factor) <- "Region"
label(data$Income_group.factor) <- "Country income level"
label(data$residence_setting.factor) <- "Residence of population served"
label(data$level.factor) <- "Facility level"
label(data$dtg_rollout_type.factor) <- "Type of initiative used to rollout DTG"


data$vl_avail.factor <- factor(data$vl_avail, levels = c( "1","2", "3"),
                               labels = c("Available on-site", "Available off-site", "Not available"))

data$dr_avail.factor <- factor(data$dr_avail, levels = c( "1","2", "3"),
                               labels = c("Available on-site", "Available off-site", "Not available"))

label(data$vl_avail.factor)="Viral load testing"
label(data$dr_avail.factor)="Drug resistance testing"


###################################################################
# other data
###################################################################

table1::table1(~ age_group_cat3.factor + age_group_ado.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table0 <- table1::table1(~  age_group_cat3.factor + age_group_ado.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table0 <- as.data.frame(table0)

write_xlsx(table0, "03_Output/Data/Summary/SummaryTable0_region.xlsx")

###################################################################
# DTG data
###################################################################

# Table1

table1::table1(~ dtg_1.factor + dtg_1_plan_yr.factor  +  insti_firstline___77.factor + insti_firstline___1.factor + insti_firstline___2.factor + insti_firstline___3.factor + dtg_1_intro_unk.factor + dtg_1_artnaive.factor + dtg_1_suppressVL.factor + dtg_1_unsuppressVL.factor + dtg_1_noDR.factor + dtg_1_DR.factor + dtg_1_women50.factor + dtg_1_women1549.factor + dtg_1_preg.factor + dtg_1_men.factor + dtg_1_adol.factor + dtg_1_child.factor + dtg_1_other.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table1 <- table1::table1(~ dtg_1.factor + dtg_1_plan_yr.factor  +  insti_firstline___77.factor + insti_firstline___1.factor + insti_firstline___2.factor + insti_firstline___3.factor + dtg_1_intro_unk.factor + dtg_1_artnaive.factor + dtg_1_suppressVL.factor + dtg_1_unsuppressVL.factor + dtg_1_noDR.factor + dtg_1_DR.factor + dtg_1_women50.factor + dtg_1_women1549.factor + dtg_1_preg.factor + dtg_1_men.factor + dtg_1_adol.factor + dtg_1_child.factor + dtg_1_other.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table1 <- as.data.frame(table1)

write_xlsx(table1, "03_Output/Data/Summary/SummaryTable1_region.xlsx")

# Table2

table2 <- table1::table1(~ dtg_2.factor + dtg_2_plan_yr.factor  + dtg_2_intro_unk.factor + dtg_2_suppressVL.factor + dtg_2_unsuppressVL.factor + dtg_2_noDR.factor + dtg_2_DR.factor + dtg_2_women50.factor + dtg_2_women1549.factor + dtg_2_preg.factor + dtg_2_men.factor + dtg_2_adol.factor + dtg_2_child.factor + dtg_2_other.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table2 <- as.data.frame(table2)

write_xlsx(table2, "03_Output/Data/Summary/SummaryTable2_region.xlsx")

# Table3

table3 <- table1::table1(~ dtg_3.factor + dtg_3_plan_yr.factor + dtg_3_intro_unk.factor + dtg_3_suppressVL.factor + dtg_3_unsuppressVL.factor + dtg_3_noDR.factor + dtg_3_DR.factor + dtg_3_women50.factor + dtg_3_women1549.factor + dtg_3_preg.factor + dtg_3_men.factor + dtg_3_adol.factor + dtg_3_child.factor + dtg_3_other.factor | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table3 <- as.data.frame(table3)

write_xlsx(table3, "03_Output/Data/Summary/SummaryTable3_region.xlsx")


# Table4

table4 <- table1::table1(~ dtg_rollout_type.factor + dtg_trans_vl_yn.factor + dtg_trans_vl_months.factor + dtg_genotyping.factor + dtg_geno_pt_adult1.factor + dtg_geno_pt_adult2.factor + dtg_geno_pt_adult3.factor + dtg_geno_pt_childPI.factor + dtg_geno_pt_childNNRTI.factor + dtg_geno_pt_other.factor  | region.factor, data = data, overall=c(left="Total"), render.categorical = my.render.cat)

table4 <- as.data.frame(table4)

write_xlsx(table4, "03_Output/Data/Summary/SummaryTable4_region.xlsx")


# Save
#write_xlsx(mytable1_final, "03_Output/Paper/Table_1_final_region.xlsx")

