## --------------------------------------------------------------------------------------##
##
## Script name: _download_elevation.R
##
## Purpose of the script: downloads elevation data for magic valley extent.
##
## Author: Chinmay Deval
##
## Created On: 2022-01-24
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes: Elevation units are in meters. Slope calculations based on : 
##  https://desktop.arcgis.com/en/arcmap/10.3/tools/spatial-analyst-toolbox/how-slope-works.htm
##   
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(elevatr)
library(stars)
library(starsExtra)

## --------------------------------------------------------------------------------------##

magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_NAD83.shp")

elevation_raster = get_elev_raster(locations = magicvalley_mask, clip = "bbox", z=10)

elv_as_strs_obj = stars::st_as_stars(elevation_raster)

slope_raster = starsExtra::slope(elv_as_strs_obj)

## --------------------------------------------------------------------------------------##

raster::writeRaster(elevation_raster,
                    "D:/OneDrive - University of Idaho/MagicValleyData/Elevation_data/Elevation_in_meters_magic_valley.tif",
                    overwrite=TRUE,options=c("COMPRESS=LZW"))

stars::write_stars(slope_raster,
                    "D:/OneDrive - University of Idaho/MagicValleyData/Elevation_data/Slope_in_degrees_magic_valley.tif",
                    overwrite=TRUE,options=c("COMPRESS=LZW"))
