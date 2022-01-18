## --------------------------------------------------------------------------------------##
##
## Script name: create_project_extent.R
##
## Purpose of the script: Create a boundry layer for magic valley which will be used to define
## the processing
##
## Author: Chinmay Deval
##
## Created On: 2022-01-14
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
library(tigris)
library(sf)
library(tidyverse)

## --------------------------------------------------------------------------------------##
ID_county_boundries  <- tigris::counties(state = "ID", cb = TRUE) %>% 
  sf::st_as_sf() 

magic_valley_counties  <- tigris::counties(state = "ID", cb = TRUE) %>% 
  sf::st_as_sf()  %>% 
  dplyr::filter(NAME %in% c("Blaine", "Camas", "Cassia", "Gooding", "Jerome", "Lincoln", "Minidoka", "Twin Falls"))

# merge to get outer boundary
magic_valley_extent <- magic_valley_counties %>% sf::st_union() %>% sf::st_transform(crs = 4326)

# save

sf::st_write(magic_valley_extent, 
             'D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp', 
             driver = 'ESRI Shapefile')

# NAD83 same as raster proj
# 

magic_valley_extent_NAD83 <- magic_valley_counties %>% 
  sf::st_union() %>% 
  sf::st_transform("+proj=tmerc +lat_0=42 +lon_0=-114 +k=0.9996 +x_0=2500000 +y_0=1200000 +datum=NAD83 +units=m +no_defs ")

# save

sf::st_write(magic_valley_extent_NAD83, 
             'D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_NAD83.shp', 
             driver = 'ESRI Shapefile')
#visual 

plt<- ggplot() +
  geom_sf(data = ID_county_boundries, ) +
  geom_sf(data = magic_valley_extent, fill = "#e07a5f", alpha = 0.5)+
  geom_sf_text(data = magic_valley_counties,aes(label = NAME),
               nudge_x = .15, nudge_y = -.03, size =4.5)+
  ggtitle("Counties representing the magic valley")+
  ggthemes::theme_fivethirtyeight(base_size = 20)+
  theme(axis.text.x = element_text(angle = 90))

ggsave("magicvalley.png", plot = plt,dpi = 300,units = "in",height = 12,width = 10)
