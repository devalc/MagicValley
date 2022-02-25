## --------------------------------------------------------------------------------------##
##
## Script name: 23_join_field_stats_by_water_and_irri_districts.R
##
## Purpose of the script:
##
## Author: Chinmay Deval
##
## Created On: 2022-02-24
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
library(tmap)
library(leaflet)
library(tidyverse)

## --------------------------------------------------------------------------------------##
fields= qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/new_stats/field_boundaries_with_all_stats.qs")


# WR_points = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_processed_points.qs")

water_districts = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Water_districts/Water_Districts.geojson")

irri_org = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigation_Organization/Irrigation_Organizations.geojson")

## --------------------------------------------------------------------------------------##

water_districts = water_districts %>% sf::st_make_valid() 

colnames(water_districts)[1:8] = paste0(colnames(water_districts)[1:8], "_WD")


df = sf::st_join(water_districts, left = FALSE, fields['FID']) %>%
  as.data.frame() %>% dplyr::select(-geometry)

fields_with_water_districts = dplyr::left_join(fields, df , by = "FID")

fields_with_water_districts = fields_with_water_districts %>% 
  dplyr::distinct(FID, .keep_all = T)

## --------------------------------------------------------------------------------------##
irri_org=irri_org%>% sf::st_make_valid() 

colnames(irri_org)[1:10] = paste0(colnames(irri_org)[1:10], "_IrriOrg")

irri_org_df = sf::st_join(irri_org, left = FALSE, fields['FID']) %>% 
  as.data.frame() %>% dplyr::select(-geometry)

fields_with_water_districts_and_irri_org = dplyr::left_join(fields_with_water_districts, irri_org_df , by = "FID")
fields_with_water_districts_and_irri_org = fields_with_water_districts_and_irri_org %>% dplyr::distinct(FID, .keep_all = T)


sf::st_write(fields_with_water_districts_and_irri_org, 
             "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/field_stats/fields_all_stats_including_waterdist_and_irri_org.shp")

qs::qsave(fields_with_water_districts_and_irri_org, 
          "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/field_stats/fields_all_stats_including_waterdist_and_irri_org.qs")
