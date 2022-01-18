## --------------------------------------------------------------------------------------##
##
## Script name: 
##
## Purpose of the script:
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
library(raster)
library(sf)
library(tidyverse)
library(stringr)

shps_wgs84_list = list.files("D:/OneDrive - University of Idaho/MagicValleyData/Eastern_snake_plains_field_boundary_layers/wgs84/",
                             pattern ="\\.shp$", full.names = TRUE)

magicvalley_mask = raster::shapefile("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")

destloc = "D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/"


for (shp in shps_wgs84_list) {
  fname = tools::file_path_sans_ext(stringr::str_split(shp,"/")[[1]][6])
  print(fname)
  r = raster::shapefile(shp)
  r = raster::crop(r, magicvalley_mask)
  r = r %>% sf::st_as_sf()
  sf::st_write(r, paste0("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/", fname,"_magicvalley.shp"))
  
}

