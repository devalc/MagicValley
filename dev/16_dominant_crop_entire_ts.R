## --------------------------------------------------------------------------------------##
##
## Script name: 16_dominant_crop_entire_ts.R
##
## Purpose of the script:
##
## Author: Chinmay Deval
##
## Created On: 2022-01-31
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

colnames(df)[7] = paste0("MasterCat_", yr1)
# colnames(df)[8] = paste0("Crop_", yr1)

df = df %>% dplyr::select(-c(Shp_Lng, Shap_Ar, ACRES, FID_1, Crop))


raster_list = raster_list[2:15]


for (ras in raster_list){
  yr = stringr::str_split(ras, pattern = "_")[[1]][5]
  rasin = raster::raster(ras)
  df1= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(rasin, fields2016, 'mode', progress = TRUE))%>% 
    dplyr::left_join(linkdata, by ="MasterCat") 
  
  colnames(df1)[7] = paste0("MasterCat_", yr)
  
  df1 = df1 %>% dplyr::select(-c(Shp_Lng, Shap_Ar, ACRES, FID_1,IRRI_ST ,Crop))%>% as.data.frame()
  
  df = dplyr::left_join(df, df1, by=c("FID", "geometry"))
}



dataas_df = df %>% as.data.frame() %>% dplyr::select(-geometry, -IRRI_ST)
dataas_df = dataas_df %>%  
  reshape2::melt()%>%
  dplyr::select(-variable)%>%
  dplyr::group_by(FID)%>%
  dplyr::count(value)%>%
  dplyr::mutate(max = max(n))%>% 
  dplyr::slice(which.max(n))%>% 
  dplyr::ungroup()%>% 
  dplyr::select(-n, -max)

colnames(dataas_df) = c("FID", "MasterCat")


df = df %>% dplyr::select(FID)%>% dplyr::left_join(dataas_df, by= c("FID"))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")


sf::st_write(df, 
             "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/one_dominant_crop_over_entire_ts.shp")



qs::qsave(df, 
             "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/one_dominant_crop_over_entire_ts.qs")
