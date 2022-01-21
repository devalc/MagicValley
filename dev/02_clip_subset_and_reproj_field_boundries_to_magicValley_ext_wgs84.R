## --------------------------------------------------------------------------------------##
##
## Script name: 02_clip_subset_and_reproj_field_boundries_to_magicValley_ext_wgs84.R
## 
##
## Purpose of the script:  Create a subset of field boundaries that are
##                         either irrigated or semi-irrigated fields in the 
##                         magic valley extent. Reproject to WGS84 and save layers. 
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

reproj_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/"

magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")

gdb_loc <- "D:/OneDrive - University of Idaho/MagicValleyData/Eastern_snake_plains_field_boundary_layers/"

gdb_files = list.files(gdb_loc,full.names = TRUE)[1:14]

gdb_files = gdb_files[12:14]

for (gdb in gdb_files){
  fname = tools::file_path_sans_ext(stringr::str_split(gdb,"/")[[1]][5])
  lyr= sf::st_read(gdb, fid_column_name = "FID")
  lyr = lyr %>%
    sf::st_transform("+proj=tmerc +lat_0=42 +lon_0=-114 +k=0.9996 +x_0=2500000 +y_0=1200000 +datum=NAD83 +units=m +no_defs ")
  lyr=  sf::st_cast(lyr, "MULTIPOLYGON")
  lyr= sf::st_make_valid(lyr)

  if(any(grepl("STATUS|Status", colnames(lyr)))){
    
    lyr = lyr %>%
      dplyr::rename_at(dplyr::vars(dplyr::starts_with('STATUS')), funs(paste0('IRRI_STATUS')))%>%
      dplyr::filter(IRRI_STATUS != "non-irrigated")
    lyr= lyr %>%   sf::st_transform(CRS("+init=epsg:4326"))
    lyr= sf::st_intersection(lyr, magicvalley_mask)
    
    sf::st_write(lyr,paste0(reproj_loc, fname,"_only_irrigated_fields.shp"))

  }else{
    print(paste(fname, ":  does not contain column STATUS. Using column starting with 'St_' instead.", sep = ":"))

    lyr = lyr %>%
      dplyr::rename_at(dplyr::vars(dplyr::starts_with('St_')), funs(paste0('IRRI_STATUS')))%>%
      dplyr::filter(IRRI_STATUS != "non-irrigated")
    
    lyr= lyr %>%   sf::st_transform(CRS("+init=epsg:4326"))
    lyr= sf::st_intersection(lyr, magicvalley_mask)
    
    sf::st_write(lyr,paste0(reproj_loc, fname,"_only_irrigated_fields.shp"))
    
  }

}