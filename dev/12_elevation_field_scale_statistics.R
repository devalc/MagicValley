## --------------------------------------------------------------------------------------##
##
## Script name: 12_elevation_field_scale_statistics.R
##
## Purpose of the script: Use the elevation data and calculate  min max 
##                        and difference values for each field
##
## Author: Chinmay Deval
##
## Created On: 2022-01-24
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
library(raster)
library(starsExtra)
library(sf)
library(exactextractr)
library(tidyverse)

elevation_mgkval=  raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Elevation_data/Elevation_in_meters_magic_valley.tif")
  
slope_mgkval = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Elevation_data/Slope_in_degrees_magic_valley.tif")

fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE) %>% sf::st_transform(sf::st_crs(elevation_mgkval))

fields2016 = fields2016 %>% 
  dplyr::mutate(elevation_m_max = exactextractr::exact_extract(elevation_mgkval, fields2016, 'max'),
                elevation_m_min = exactextractr::exact_extract(elevation_mgkval, fields2016, 'min'),
                elevation_m_delta = elevation_m_max - elevation_m_min,
                slope_deg_max = exactextractr::exact_extract(slope_mgkval, fields2016, 'max'),
                slope_deg_min = exactextractr::exact_extract(slope_mgkval, fields2016, 'min'),
                slope_deg_delta = slope_deg_max - slope_deg_min) %>% 
  dplyr::mutate_at(c(1,8:13), list(~round(., 2)))%>%
  dplyr::select(-c(ACRES,FID_1, Shp_Lng, Shap_Ar))

fields2016 = fields2016 %>% st_transform(CRS("+init=epsg:4326"))

sf::st_write(fields2016,"D:/OneDrive - University of Idaho/MagicValleyData/Elevation_data/field_stats/elevation_slope_magicValley_field_stats.shp")
