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


library(mapview)
library(qs)
library(rmapshaper)

save_dir = "D:/GitHub/MagicValley/plots/"


fields= qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/field_boundaries_with_all_stats.qs")

