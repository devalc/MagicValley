## --------------------------------------------------------------------------------------##
##
## Script name: 05_dominant_crop_cover_magic_valley_with_fixed_field_boundries.R
##
## Purpose of the script: Identify dominant crop cover in each polygon assuming field polygons of year 2016
##
## Author: Chinmay Deval
##
## Created On: 2022-01-18
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes: the most common cell value, weighted by the fraction of each cell that is covered by the polygon. 
##  Where multiple values occupy the same maximum number of weighted cells, the largest value will be returned.
##   
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(exactextractr)
library(tidyverse)
library(sf)
library(raster)
library(CropScapeR)

#--- load the crop code reference data ---#
data("linkdata")

linkdata

## --------------------------------------------------------------------------------------##

raster_list <- list.files("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/",
                          pattern = "\\.tif$",full.names = TRUE)


fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE)

## --------------------------------------------------------------------------------------##
##  Assuming a constant field boundary: the latest one from 2016 for the entire timeseries
## --------------------------------------------------------------------------------------##
# df = data.frame()

yr1 = stringr::str_split(raster_list[1], pattern = "_")[[1]][5]
rasin1 = raster::raster(raster_list[1])
df= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(rasin1, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

colnames(df)[8] = paste0("Crop_", yr1)

df = df %>% dplyr::select(-c(Shp_Lng, Shap_Ar, ACRES, FID_1))


raster_list = raster_list[2:15]


for (ras in raster_list){
  yr = stringr::str_split(ras, pattern = "_")[[1]][5]
  rasin = raster::raster(ras)
  df1= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(rasin, fields2016, 'mode', progress = TRUE))%>% 
     dplyr::left_join(linkdata, by ="MasterCat") 
  
  colnames(df1)[8] = paste0("Crop_", yr)
  
  df1 = df1 %>% dplyr::select(-c(Shp_Lng, Shap_Ar, ACRES, FID_1,IRRI_ST ,MasterCat))%>% as.data.frame()
  
  df = dplyr::left_join(df, df1, by=c("FID", "geometry"))
}


sf::st_write(df, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp")
qs::qsave(df, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.qs")
