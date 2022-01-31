## --------------------------------------------------------------------------------------##
##
## Script name: 13_field_avg_soils_prop_gSURRGO.R
##
## Purpose of the script:
##
## Author: Chinmay Deval
##
## Created On: 2022-01-25
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes: gSURRGO gdb was clipped to magic valley and the maps were created for tawc0150cm, sand 
##        content and depth to bedrock (min) using Lookup.
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


twac0150 = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/clipped_to_magicValley/aws0150wta_magic_valley.tif")
depthtobedrockmin = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/clipped_to_magicValley/brockdepmin_magic_valley.tif")
totalsandcont = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/clipped_to_magicValley/sandtotal1_magic_valley.tif")


fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE) %>% sf::st_transform(crs(depthtobedrockmin))

## --------------------------------------------------------------------------------------##
##  Assuming a constant field boundary: the latest one from 2016 to extract the properties 
## --------------------------------------------------------------------------------------##               

### change to range!

df1= fields2016 %>% 
  dplyr::mutate(bedrck_min= exact_extract(depthtobedrockmin, 
                                           fields2016, 'min',
                                           progress = TRUE),
                bedrck_max= exact_extract(depthtobedrockmin, 
                                           fields2016, 'max',
                                           progress = TRUE),
                bedrck_diff= bedrck_max - bedrck_min,
                twac_min= exact_extract(twac0150,
                                            fields2016, 'min',
                                            progress = TRUE),
                twac_max= exact_extract(twac0150,
                                            fields2016, 'max',
                                            progress = TRUE),
                twac_diff= twac_max - twac_min,
                sandc_min= exact_extract(totalsandcont,
                                            fields2016, 'min',
                                            progress = TRUE),
                sandc_max= exact_extract(totalsandcont,
                                            fields2016, 'max',
                                            progress = TRUE),
                sandc_diff= sandc_max - sandc_min
                )


df1 = df1 %>%   sf::st_transform(CRS("+init=epsg:4326")) 


sf::st_write(df1, 
             "D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/field_stats/gSURRGO_soils_field_stats.shp")


qs::qsave(df1, 
             "D:/OneDrive - University of Idaho/MagicValleyData/gSSURGO_ID_data/field_stats/gSURRGO_soils_field_stats.qs")