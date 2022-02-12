## --------------------------------------------------------------------------------------##
##
## Script name: 15_persistence_pixels_to_fields.R
##
## Purpose of the script: Writes persistence stats to fields.
##
## Author: Chinmay Deval
##
## Created On: 2022-01-27
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
library(exactextractr)

## --------------------------------------------------------------------------------------##
raster::beginCluster()

rast_data <- raster::stack("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/persistence_clipped_to_2016_poly_cutline.tif")

rast_data95 <- rast_data[[1]]
rm(rast_data)
fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp",
                          quiet = TRUE)

raster::endCluster()



fields2016=fields2016%>% dplyr::mutate(Persistance_percent = exact_extract(rast_data95, fields2016,
                 function(value, cov_frac) (sum(value[!is.na(value)] == 1)/length(value[!is.na(value)]))*100 ),
                 Persistance_percent = dplyr::coalesce(Persistance_percent, NA_real_))



sf::st_write(fields2016, "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/field_stats/field_perisitance_stats_magick_valley.shp")
qs::qsave(fields2016, "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/field_stats/field_perisitance_stats_magick_valley.qs")
