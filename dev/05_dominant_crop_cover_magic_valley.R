## --------------------------------------------------------------------------------------##
##
## Script name: dominant_crop_cover_magic_valley.R
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
##  Notes:
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

## --------------------------------------------------------------------------------------##

 
 
cropscape2016 <- raster::raster('')
fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/",
                     quiet = TRUE)
magicvalley_mask = raster::shapefile("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")
