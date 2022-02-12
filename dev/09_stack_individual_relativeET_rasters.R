## --------------------------------------------------------------------------------------##
##
## Script name: 09_stack_individual_relativeET_rasters.R
##
## Purpose of the script: Reads individual relative ET rasters and writes it to a
##                        stacked raster file.
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
library(raster)

raster::beginCluster()

ras_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/"

ras_list = list.files(ras_loc, pattern = "\\.tif$", full.names = TRUE)[1:16]

## --------------------------------------------------------------------------------------##
# relativeET stack

relativeET_stack = raster::stack(ras_list) 

raster::writeRaster(relativeET_stack,
                    paste0(ras_loc, "Relative_ET_stack_1986_2020.tif"),
                    overwrite=TRUE,options=c("COMPRESS=LZW"))
raster::endCluster()
