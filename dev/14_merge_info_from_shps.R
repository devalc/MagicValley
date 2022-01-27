## --------------------------------------------------------------------------------------##
##
## Script name: 14_merge_info_from_shps.R
##
## Purpose of the script: Get field scale info files on dominant crop type, 
##                                                   ET stats,
##                                                   Soil props,
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
##   
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(sf)
library(tidyverse)

dom_crop = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp")
ET_stats = sf::st_read()