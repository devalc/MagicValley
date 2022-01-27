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


water_rights_for_magic_valley = sf::st_crop(water_rights_Data, magicvalley_mask)


df = sf::st_join(water_rights_for_magic_valley, left = FALSE, fields2016['FID'])%>%
  dplyr::select(-c(SpatialDat,WRMap,VersionNum,Basis,DiversionN,
                             MetalTagNu, DiversionT,PointOfDiv,WRDocs,WRReport,
                             SourceQual, TributaryO, Tributar_1, WaterDistr,SplitSuffi,
                             SequenceNu,DataSource,RightID,OBJECTID,WaterRight,BasinNumbe ))%>% 
  dplyr::mutate(source = dplyr::case_when(Source == 'GROUND WATER' ~ "Groundwater",
                                          stringr::str_ends(Source, "SPRING") ~ "Spring", 
                                          TRUE  ~ "Surfacewater"))

df1 = df %>%
  dplyr::filter(OverallMax >= 0.9) 

df2 = df1 %>%
as.data.frame()%>% dplyr::select(-geometry)

dfsmerged = dplyr::left_join(fields2016, df2, by =c("FID"))


mapview::mapview(dfsmerged,zcol = "source")
