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


fields= qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/new_stats/field_boundaries_with_all_stats.qs")
fields_simplified = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/new_stats/simplified_field_boundaries_with_all_stats.qs")

head(fields)

WR_points = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/Water_Rights_PODs/field_stats/water_rights_info_processed_points.qs")

# tm_style("cobalt")
tmap_mode("plot")
## --------------------------------------------------------------------------------------##
irr_status_map = tm_shape(fields,name = "Irrigation Status") +
  tm_borders("black",lwd = 0.0001) +
  tm_fill("IRRI_ST",title = "Irrigation Status",
          alpha = 1,palette = "viridis",style = "cat", colorNA = "white") + 
  tm_style("col_blind")+ 
  tm_layout(frame = FALSE,
            legend.title.size = 2,
            legend.text.size = 1)+
  tm_compass(position = c("right", "bottom"))+
  tm_scale_bar(position = c("right", "bottom"))

tmap_save(irr_status_map, paste0(save_dir, "Irrigation_Status_map.png"),
          dpi = 300,
          width = 12,
          height = 14,units = "in")
## --------------------------------------------------------------------------------------##

WR_class_map = tm_shape(fields,name = "Water Right Status") +
  tm_borders("black",lwd = 0.0001) +
  tm_fill("WR_class",title= "Water Right Status (Senior if before 1935)",
          alpha = 1,palette = "viridis",style = "cat", colorNA = "white")+ 
  tm_style("col_blind")+ 
  tm_layout(frame = FALSE,
                                   legend.title.size = 2,
                                   legend.text.size = 1)+
  tm_compass(position = c("right", "bottom"))+
  tm_scale_bar(position = c("right", "bottom"))

tmap_save(WR_class_map, paste0(save_dir, "Water_Rights_map.png"),
          dpi = 300,
          width = 12,
          height = 14,units = "in")
## --------------------------------------------------------------------------------------##

RDR_class_map = tm_shape(fields,name = "Overall Maximum Diversion Rate") +
  tm_borders("black",lwd = 0.0001) +
  tm_fill("RDR_classs",alpha = 1,
          title="Maximum diversion rate",
          palette = "viridis",style = "cat", colorNA = "white")+ 
  tm_style("col_blind")+
  tm_layout(frame = FALSE,
            legend.title.size = 2,
            legend.text.size = 1)+
  tm_compass(position = c("right", "bottom"))+
  tm_scale_bar(position = c("right", "bottom"))

tmap_save(RDR_class_map, paste0(save_dir, "Overall_Maximum_Diversion_Rate_map.png"),
          dpi = 300,
          width = 12,
          height = 14,units = "in")
## --------------------------------------------------------------------------------------##

# tm_shape(fields) +
#   tm_borders("black",lwd = 0.0001) +
#   tm_shape(WR_points) +
#   tm_dots(size=0.2,col="WR_classs")


WR_class = mapview::mapview(WR_points, zcol="WR_class")

source = mapview::mapview(WR_points, zcol="source")


RDR_class = mapview::mapview(WR_points, zcol="RDR_classs")

fields_with_100_persistence = fields %>% dplyr::filter(Prsstn_ == 100)
mapview::mapview(fields_with_100_persistence, zcol="Prsstn_")

fields_with_more70_persistence = fields %>% dplyr::filter(Prsstn_>=70)
mapview::mapview(fields_with_more70_persistence, zcol="Prsstn_")

## --------------------------------------------------------------------------------------##
## 
mapview::mapview(fields, zcol="elvtn_m_d")
