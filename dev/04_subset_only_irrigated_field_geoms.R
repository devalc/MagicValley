## --------------------------------------------------------------------------------------##
##
## Script name: 04_subset_only_irrigated_field_geoms.R
##
## Purpose of the script:  Takes field boundries(wgs84) and subsets them for fields 
##                         that are irrigated/semi-irrigated.
##
## Author: Chinmay Deval
##
## Created On: 2022-01-17
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
library(sf)
library(stringr)
library(raster)
library(tidyverse)
## --------------------------------------------------------------------------------------##

field_boundries_loc = "D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/"

fb_files = list.files(field_boundries_loc,full.names = TRUE,pattern = "\\.shp$")

dir.create(paste0(field_boundries_loc, "Irrigated_fields_only_wgs84"),showWarnings = FALSE)

for (shp in fb_files){
  fname = tools::file_path_sans_ext(stringr::str_split(shp,"/")[[1]][5])
  lyr= sf::st_read(shp,quiet =TRUE)
  if(any(grepl("STATUS", colnames(lyr)))){
    lyr = lyr %>%
      dplyr::rename_at(dplyr::vars(dplyr::starts_with('STATUS')), funs(paste0('IRRI_STATUS')))%>%
      dplyr::filter(IRRI_STATUS != "non-irrigated")
    sf::st_write(lyr,paste0(field_boundries_loc, "Irrigated_fields_only_wgs84/",fname,"_only_irrigated_fields.shp"))
  
  }else{
    print(paste(fname, ":  does not contain column STATUS. Using column starting with 'St_' instead.", sep = ":"))
    
    lyr = lyr %>%
      dplyr::rename_at(dplyr::vars(dplyr::starts_with('St_')), funs(paste0('IRRI_STATUS')))%>%
      dplyr::filter(IRRI_STATUS != "non-irrigated")
    sf::st_write(lyr,paste0(field_boundries_loc, "Irrigated_fields_only_wgs84/",fname,"_only_irrigated_fields.shp"))
  }
  
}
