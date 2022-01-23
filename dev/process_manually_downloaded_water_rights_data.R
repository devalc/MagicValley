## --------------------------------------------------------------------------------------##
##
## Script name: 08_process_manually_downloaded_water_rights_data.R
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

fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE)

water_rights_Data = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/Water_Right_PODs.shp")


water_rights_for_magic_valley = sf::st_crop(water_rights_Data, magicvalley_mask)

water_rights_for_irrigated_fields = sf::st_crop(water_rights_Data, fields2016)
