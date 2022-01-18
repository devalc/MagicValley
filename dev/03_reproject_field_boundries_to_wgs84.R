## --------------------------------------------------------------------------------------##
##
## Script name: 03_reproject_field_boundries_to_wgs84.R
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

reproj_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Eastern_snake_plains_field_boundary_layers/wgs84/"

magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")

gdb_loc <- "D:/OneDrive - University of Idaho/MagicValleyData/Eastern_snake_plains_field_boundary_layers/"

gdb_files = list.files(gdb_loc,full.names = TRUE)


for (gdb in gdb_files){
  fname = tools::file_path_sans_ext(stringr::str_split(gdb,"/")[[1]][5])
  lyr= sf::st_read(gdb, fid_column_name = "FID")%>% 
    sf::st_transform(CRS("+init=epsg:4326"))
  lyr=  sf::st_cast(lyr, "MULTIPOLYGON")
  sf::st_write(lyr,paste0(reproj_loc,fname,".shp"))
}