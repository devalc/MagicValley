## --------------------------------------------------------------------------------------##
##
## Script name: 16_merge_info_from_shps.R
##
## Purpose of the script: Get field scale info files on dominant crop type, 
##                                                   ET stats,
##                                                   Soil props,
##                                                   elevation and slope diff,
##                                                   and water rights
##                        and return a combined file with all info at one place.
## 
##
## Author: Chinmay Deval
##
## Created On: 2022-01-24
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes: Everything is calculated using 2016 field boundaries.
##  # irri_fields = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp")
## dom_crop = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp")
## ET_persistence already has columns from irri_fields and dom_crop.
##   
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(sf)
library(tidyverse)
library(qs)

ET_persistence = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/field_stats/field_perisitance_stats_magick_valley.shp")
WR_stats = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_appeneded_to_2016_field_boundries.shp")
soils_stats = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/field_stats/gSURRGO_soils_field_stats.shp")


WR_stats = WR_stats %>% as.data.frame()%>% dplyr::select(FID,
                                                         PriorityDa,
                                                         Owner,
                                                         OverallMax,
                                                         source,
                                                         WR_class,
                                                         RDR_classs,-geometry)

soils_stats = soils_stats %>% as.data.frame() %>% dplyr::select(FID,
                                                                dpthtbd,
                                                                twc0150,
                                                                ttlsndc,-geometry)

merged_shps = ET_persistence %>% dplyr::left_join(soils_stats, by =c("FID"))%>%
  dplyr::left_join(WR_stats, by =c("FID")) %>% dplyr::select(-c(MastrCt))



sf::st_write(merged_shps, "D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/field_boundaries_with_all_stats.shp")
qs::qsave(merged_shps, "D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/field_boundaries_with_all_stats.qs")
