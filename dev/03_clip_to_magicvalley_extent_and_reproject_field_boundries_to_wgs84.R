## --------------------------------------------------------------------------------------##
##
## Script name: 03_crop_to_magicvalley_extent_and_reproject_field_boundries_to_wgs84.R
##
## Purpose of the script:  Reproject field boundries to wgs84
##
## Author: Chinmay Deval
##
## Created On: 2022-01-17
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
library(sf)
library(stringr)
library(raster)
library(tidyverse)
## --------------------------------------------------------------------------------------##

reproj_loc = "D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/"

magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_NAD83.shp")

gdb_loc <- "D:/OneDrive - University of Idaho/MagicValleyData/Eastern_snake_plains_field_boundary_layers/"

gdb_files = list.files(gdb_loc,full.names = TRUE)[1:14]


for (gdb in gdb_files){
  fname = tools::file_path_sans_ext(stringr::str_split(gdb,"/")[[1]][5])
  lyr= sf::st_read(gdb, fid_column_name = "FID")
  lyr = lyr %>% 
    sf::st_transform("+proj=tmerc +lat_0=42 +lon_0=-114 +k=0.9996 +x_0=2500000 +y_0=1200000 +datum=NAD83 +units=m +no_defs ")
  lyr=  sf::st_cast(lyr, "MULTIPOLYGON")
  lyr= sf::st_make_valid(lyr)
  lyr = sf::st_crop(lyr, magicvalley_mask)%>% 
    sf::st_transform(CRS("+init=epsg:4326"))
  sf::st_write(lyr,paste0(reproj_loc,fname,".shp"))
}

# lyr = sf::st_read(gdb, fid_column_name = "FID")
# lyr = lyr %>% 
#   sf::st_transform("+proj=tmerc +lat_0=42 +lon_0=-114 +k=0.9996 +x_0=2500000 +y_0=1200000 +datum=NAD83 +units=m +no_defs ")
# lyr=  sf::st_cast(lyr, "MULTIPOLYGON")
# # sf::sf_use_s2(FALSE)
# lyr= sf::st_make_valid(lyr)
# lyr1 = sf::st_crop(lyr, magicvalley_mask)%>% 
#   sf::st_transform(CRS("+init=epsg:4326"))
# 
# sf::st_write(lyr1, paste0(reproj_loc,fname,"_test2.shp"))