## --------------------------------------------------------------------------------------##
##
## Script name: 07_rasterize_field_mean_ET.R
##
## Purpose of the script: rasterize the field mean ET to be then used to do the
##                        band math and calculate relative ET.
##
## Author: Chinmay Deval
##
## Created On: 2022-01-22
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
library(stars)
library(tidyverse)

save_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/vectorized_fieldmeanET/"

shp_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/"

## --------------------------------------------------------------------------------------##
template_raster <- stars::read_stars("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20200401to20201031_et.tif")


## --------------------------------------------------------------------------------------##

shp_list = list.files(shp_loc, pattern = "\\.shp$",full.names = TRUE) 

for (shp in shp_list) {
  yr = tools::file_path_sans_ext(stringr::str_split(shp,"_")[[1]][7])
  poly = sf::st_read(shp)
  rasterized_mean = stars::st_rasterize(poly[, "mean"], template = template_raster)
  stars::write_stars(rasterized_mean, paste0(save_loc, "rasterized_fieldmeanET_", yr,".tif"))
  
}
