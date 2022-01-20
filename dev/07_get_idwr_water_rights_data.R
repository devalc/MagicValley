## --------------------------------------------------------------------------------------##
##
## Script name: Fetch idwr water rights
##
## Purpose of the script: 07_get_idwr_water_rights_data.R
##
## Author: Chinmay Deval
##
## Created On: 2022-01-19
##
## Copyright (c) Chinmay Deval, 2022
## Email: chinmay.deval91@gmail.com
##
## --------------------------------------------------------------------------------------##
##  Notes: Query link was created by providing magic valley extent to the api 
##         at https://data-idwr.opendata.arcgis.com/datasets/IDWR::water-right-pods/api 
##   For Some reason this not generating all the data. Need to figure this out later.
##   for not data was downloaded manually from the website.
##
## --------------------------------------------------------------------------------------##

## --------------------------clear environment and console-------------------------------##
rm(list = ls())
cat("\014")

## ----------------------------------Load packages---------------------------------------##
library(tidyverse)
library(jsonlite)
library(sp)

magicvalley_mask = sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_wgs84.shp")

raw_water_rights_data <- jsonlite::fromJSON("https://maps.idwr.idaho.gov/arcgis/rest/services/BP/_WaterRights/MapServer/4/query?where=1%3D1&outFields=*&geometry=-115.0868499999999983%2C41.9882089999999977%2C-112.9999650000000031%2C43.9929490000000030&geometryType=esriGeometryEnvelope&inSR=4326&spatialRel=esriSpatialRelContains&outSR=4326&f=json")

df1 = raw_water_rights_data$features$attributes
df2 = raw_water_rights_data$features$geometry
df = cbind(df1,df2)
xy <- df[,c(27,28)]
spdf <- sp::SpatialPointsDataFrame(coords = xy, data = df,
                               proj4string = CRS("+proj=longlat +datum=WGS84 +ellps=WGS84 +towgs84=0,0,0"))

