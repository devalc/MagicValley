## --------------------------------------------------------------------------------------##
##
## Script name: 21_random_forest_variable_importance.R
##
## Purpose of the script: feature engineering and variable importance
##
## Author: Chinmay Deval
##
## Created On: 2022-02-11
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes:
##   
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(qs)
library(rpart)
library(tidyverse)
library(randomForest)
library(janitor)
library(Boruta)
## --------------------------------------------------------------------------------------##

fields= qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/new_stats/field_boundaries_with_all_stats.qs")


# WR_points = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_processed_points.qs")

fields_with_one_crop = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/one_dominant_crop_over_entire_ts.qs")%>%
  as.data.frame()%>%dplyr::select("FID","Crop") 


fields_merged = dplyr::left_join(fields, fields_with_one_crop, by=c("FID"))%>%
  dplyr::mutate_if(sapply(., is.character), as.factor)

## -------------------------------------------------------------------------##
set.seed(123)

## --------------------------------Random forest(specifically Boruta)-----------------------------------------##
# fields_merged <- drop_na(fields_merged)

fields_merged_all = fields_merged %>%as.data.frame()%>%
  dplyr::select(-c(geometry, FID, sndc_mn, sndc_mx, sndc_df))


# Perform Boruta search
boruta_output_all <- Boruta(Prsstn_ ~ ., data=na.omit(fields_merged_all), doTrace=2)  
print(boruta_output_all)

# Get significant variables including tentatives
boruta_signif_all <- getSelectedAttributes(boruta_output_all, withTentative = TRUE)
print(boruta_signif_all) 


# Do a tentative rough fix
roughFixMod <- TentativeRoughFix(boruta_output_all)
boruta_signif <- getSelectedAttributes(roughFixMod,withTentative = F)
print(boruta_signif)


# Variable Importance Scores
imps <- attStats(roughFixMod)
imps2 = imps[imps$decision != 'Rejected', c('meanImp', 'decision')]
head(imps2[order(-imps2$meanImp), ])  # descending sort

png("../MagicValley/plots/variable_importance_crude_all.png", 
    width = 12, height = 12, units = "in", res = 300)
plot(boruta_output_all, cex.axis=.7, las=2, xlab="", main="Variable Importance")  
dev.off()

## -------------------------------------------------------------------------##

fields_merged_var_sel = fields_merged_all %>%
  dplyr::select(-c("Cr_2005", "Cr_2007", "Cr_2008", "Cr_2009", "Cr_2010","Cr_2011",
                "Cr_2012","Cr_2013","Cr_2014","Cr_2015","Cr_2016","Cr_2017",
                "Cr_2018","Cr_2019", "Cr_2020", "Owner")) 


# Perform Boruta search
boruta_output_sel <- Boruta(Prsstn_ ~ ., data=na.omit(fields_merged_var_sel), doTrace=2)  
print(boruta_output_sel)

# Get significant variables including tentatives
boruta_signif_sel <- getSelectedAttributes(boruta_output_sel, withTentative = TRUE)
print(boruta_output_sel) 



# Do a tentative rough fix
roughFixMod_Sel <- TentativeRoughFix(boruta_output_sel)
boruta_signif_sel <- getSelectedAttributes(roughFixMod_Sel,withTentative = F)
print(boruta_signif_sel)


# Variable Importance Scores
imps_Sel <- attStats(roughFixMod_Sel)
imps2_Sel = imps_Sel[imps_Sel$decision != 'Rejected', c('meanImp', 'decision')]
head(imps2[order(-imps2_Sel$meanImp), ])  # descending sort

png("../MagicValley/plots/variable_importance_crude_sel_vars.png", 
    width = 12, height = 12, units = "in", res = 300)
plot(boruta_output_sel, cex.axis=.7, las=2, xlab="", main="Variable Importance")  
dev.off()
