## --------------------------------------------------------------------------------------##
##
## Script name: _test_summary_ET_persistence.R
##
## Purpose of the script:
##
## Author: Chinmay Deval
##
## Created On: 2022-01-28
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

library(qs)
library(tmap)
library(leaflet)
library(tidyverse)


save_dir = "D:/GitHub/MagicValley/plots/"


fields= qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/field_boundaries_with_all_stats.qs")

head(fields)

tm_style("col_blind")

## --------------------------------------------------------------------------------------##
irr_status_map = tm_shape(fields,name = "Irrigation Status") +
  tm_borders("black",lwd = 0.0001) +
  tm_fill("IRRI_ST",alpha = 1,palette = "cat",style = "cat")

tmap_save(irr_status_map, paste0(save_dir, "Irrigation_Status_map.png"),
          dpi = 300,
          width = 16,
          height = 12,units = "in")
## --------------------------------------------------------------------------------------##

 
