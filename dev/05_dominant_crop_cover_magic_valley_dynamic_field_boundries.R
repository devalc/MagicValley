## --------------------------------------------------------------------------------------##
##
## Script name: 05_dominant_crop_cover_magic_valley_dynamic_field_boundries.R
##
## Purpose of the script: Identify dominant crop cover in each polygon
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

# linkdata

## --------------------------------------------------------------------------------------##
# magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp") 

## --------------------------------------------------------------------------------------##
## Dynamic field boundries for each year's cropscape data
## --------------------------------------------------------------------------------------##

cropscape2005 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2005_clip_20220117210545_1253417064.tif')
cropscape2007 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2007_clip_20220117210545_1253417064.tif')
cropscape2008 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2008_clip_20220117210545_1253417064.tif')
cropscape2009 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2009_clip_20220117210545_1253417064.tif')
cropscape2010 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2010_clip_20220117210545_1253417064.tif')
cropscape2011 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2011_clip_20220117210545_1253417064.tif')
cropscape2012 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2012_clip_20220117210545_1253417064.tif')
cropscape2013 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2013_clip_20220117210545_1253417064.tif')
cropscape2014 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2014_clip_20220117210545_1253417064.tif')
cropscape2015 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2015_clip_20220117210545_1253417064.tif')
cropscape2016 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2016_clip_20220117210545_1253417064.tif')
cropscape2017 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2017_clip_20220117210545_1253417064.tif')
cropscape2018 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2018_clip_20220117210545_1253417064.tif')
cropscape2019 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2019_clip_20220117210545_1253417064.tif')
cropscape2020 <- raster::raster('D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/CDL_2020_clip_20220117210545_1253417064.tif')



fields2006 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2006_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2008 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2008_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2009 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2009_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2010 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2010_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2011 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2011_only_irrigated_fields.shp",
                     quiet = TRUE)
fields2012 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2012_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2013 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2013_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2014 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2014_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2015 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2015_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE)
## --------------------------------------------------------------------------------------##

dominant_CC_2005= fields2006 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2005, fields2006, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2005, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2005.shp")

dominant_CC_2007= fields2006 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2007, fields2006, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2007, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2007.shp")

dominant_CC_2008= fields2008 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2008, fields2008, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2008, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2008.shp")

dominant_CC_2009= fields2009 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2009, fields2009, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2009, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2009.shp")

dominant_CC_2010= fields2010 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2010, fields2010, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2010, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2010.shp")

dominant_CC_2011= fields2011 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2011, fields2011, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2011, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2011.shp")

dominant_CC_2012= fields2012 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2012, fields2012, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2012, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2012.shp")


dominant_CC_2013= fields2013 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2013, fields2013, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2013, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2013.shp")


dominant_CC_2014= fields2014 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2014, fields2014, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2014, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2014.shp")


dominant_CC_2015= fields2015 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2015, fields2015, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2015, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2015.shp")


dominant_CC_2016= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2016, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2016, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2016.shp")


dominant_CC_2017= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2017, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2017, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2017.shp")


dominant_CC_2018= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2018, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2018, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2018.shp")


dominant_CC_2019= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2019, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2019, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2019.shp")


dominant_CC_2020= fields2016 %>% dplyr::mutate(MasterCat= exact_extract(cropscape2020, fields2016, 'mode', progress = TRUE))%>% 
  dplyr::left_join(linkdata, by ="MasterCat")

sf::st_write(dominant_CC_2020, "D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/fields_layer_with_common_land_cover_info_2020.shp")