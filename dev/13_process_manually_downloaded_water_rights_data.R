## --------------------------------------------------------------------------------------##
##
## Script name: 13_process_manually_downloaded_water_rights_data.R
##
## Purpose of the script: Data was downloaded manually since I haven't figured out
##                      way to query all the data.
##
## Author: Chinmay Deval
##
## Created On: 2022-01-19
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
library(tidyverse)
library(sf)

## --------------------------------------------------------------------------------------##
magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")

fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp",
                          quiet = TRUE)

water_rights_Data = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/Water_Right_PODs.shp")

#clip WR data to magic valley extent
water_rights_for_magic_valley = sf::st_crop(water_rights_Data, magicvalley_mask)


df = sf::st_join(water_rights_for_magic_valley, left = FALSE, fields2016['FID'])%>% # join field boundaries and WR points. Keeps points inside polygons
  dplyr::distinct(FID, .keep_all = TRUE)%>% # remove duplicates
  dplyr::select(-c(SpatialDat,WRMap,VersionNum,Basis,DiversionN,
                             MetalTagNu, DiversionT,PointOfDiv,WRDocs,WRReport,
                             SourceQual, TributaryO, Tributar_1, WaterDistr,SplitSuffi,
                             SequenceNu,DataSource,RightID,OBJECTID,WaterRight,BasinNumbe ))%>% 
  dplyr::mutate(source = dplyr::case_when(Source == 'GROUND WATER' ~ "Groundwater",
                                          stringr::str_ends(Source, "SPRING") ~ "Spring", 
                                          TRUE  ~ "Surfacewater"))%>% 
  dplyr::mutate(WR_class = dplyr::case_when(PriorityDa <= '1985-12-31' ~ "Senior_WaterRight",
                                          TRUE  ~ "Junior_WaterRight"))%>% 
  dplyr::mutate(RDR_classs = dplyr::case_when(OverallMax <= 10 ~ "low",
                                              dplyr::between(OverallMax, 10.01,500) ~ "medium",
                                              dplyr::between(OverallMax, 500.01,1500) ~ "high",
                                              dplyr::between(OverallMax, 1500.01, 3000) ~ "very_high"
                                              ))%>% dplyr::select(-c(Source, Status))

df1 = df %>%
as.data.frame()%>% dplyr::select(-geometry)
 
dfsmerged = dplyr::left_join(fields2016, df1, by =c("FID"))


sf::st_write(dfsmerged, "D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_appeneded_to_2016_field_boundries.shp")
qs::qsave(dfsmerged, "D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_appeneded_to_2016_field_boundries.qs")

