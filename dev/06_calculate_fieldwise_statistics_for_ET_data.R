## --------------------------------------------------------------------------------------##
##
## Script name: _calculate_fieldwise_statistics_for_ET_data.R
##
## Purpose of the script: Calculate field wise statistics of ET for each available image
##
## Author: Chinmay Deval
##
## Created On: 2022-01-19
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
library(sf)
library(exactextractr)
library(tidyverse)

## --------------------------------------------------------------------------------------## 

raster::beginCluster()

ET1986 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_19860401to19861031_et.tif")
ET1996 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_19960401to19961031_et.tif")
ET2000 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20000401to1031_et.tif")
ET2002 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20020401to20021031_et.tif")
ET2006 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20060401to20061031_et.tif")
ET2008 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20080401to20081031_et.tif")
ET2009 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20090401to20091031_et.tif")
ET2010 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20100401to20101031_et.tif")
ET2011 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20110401to20111031_et.tif")
ET2013 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20130401to20131031_et.tif")
ET2015 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20150401to20151031_et.tif")
ET2016 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20160401to20161031_et.tif")
ET2017 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20170401to20171031_et.tif")
ET2018 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20180401to20181031_et.tif")
ET2019 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20190401to20191031_et.tif")
ET2020 <- raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/p3940_20200401to20201031_et.tif")

fields1986 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_1986_only_irrigated_fields.shp",
                          quiet = TRUE)

fields1996 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_1996_only_irrigated_fields.shp",
                          quiet = TRUE)

fields2000 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2000_only_irrigated_fields.shp",
                          quiet = TRUE)

fields2002 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2002_only_irrigated_fields.shp",
                          quiet = TRUE)

fields2006 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2006_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2008 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2008_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2009 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2009_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2010 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2010_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2011 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2011_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2012 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2012_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2013 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2013_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2014 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2014_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2015 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2015_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2016 <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE)
fields2016a <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp",
                          quiet = TRUE)
## ------------------------------------ET stats--------------------------------------------------##

fields1986 = fields1986 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET1986, fields1986, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET1986, fields1986, 'mean'),
                                          stdev = exactextractr::exact_extract(ET1986, fields1986, 'stdev'),
                                          Year = lubridate::year(as.Date("1986", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields1996 = fields1996 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET1996, fields1996, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET1996, fields1996, 'mean'),
                                          stdev = exactextractr::exact_extract(ET1996, fields1996, 'stdev'),
                                          Year = lubridate::year(as.Date("1996", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2000 = fields2000 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2000, fields2000, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2000, fields2000, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2000, fields2000, 'stdev'),
                                          Year = lubridate::year(as.Date("2000", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2002 = fields2002 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2002, fields2002, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2002, fields2002, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2002, fields2002, 'stdev'),
                                          Year = lubridate::year(as.Date("2002", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2006 = fields2006 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2006, fields2006, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2006, fields2006, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2006, fields2006, 'stdev'),
                                          Year = lubridate::year(as.Date("2006", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2008 = fields2008 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2008, fields2008, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2008, fields2008, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2008, fields2008, 'stdev'),
                                          Year = lubridate::year(as.Date("2008", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2009 = fields2009 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2009, fields2009, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2009, fields2009, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2009, fields2009, 'stdev'),
                                          Year = lubridate::year(as.Date("2009", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2010 = fields2010 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2010, fields2010, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2010, fields2010, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2010, fields2010, 'stdev'),
                                          Year = lubridate::year(as.Date("2010", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2011 = fields2011 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2011, fields2011, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2011, fields2011, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2011, fields2011, 'stdev'),
                                          Year = lubridate::year(as.Date("2011", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2013 = fields2013 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2013, fields2013, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2013, fields2013, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2013, fields2013, 'stdev'),
                                          Year = lubridate::year(as.Date("2013", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2015 = fields2015 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2015, fields2015, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2015, fields2015, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2015, fields2015, 'stdev'),
                                          Year = lubridate::year(as.Date("2015", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2016 = fields2016 %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2016, fields2016, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2016, fields2016, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2016, fields2016, 'stdev'),
                                          Year = lubridate::year(as.Date("2016", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 


fields2017 = fields2016a %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2017, fields2016a, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2017, fields2016a, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2017, fields2016a, 'stdev'),
                                          Year = lubridate::year(as.Date("2017", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2018 = fields2016a %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2018, fields2016a, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2018, fields2016a, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2018, fields2016a, 'stdev'),
                                          Year = lubridate::year(as.Date("2018", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2019 = fields2016a %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2019, fields2016a, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2019, fields2016a, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2019, fields2016a, 'stdev'),
                                          Year = lubridate::year(as.Date("2019", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



fields2020 = fields2016a %>% dplyr::mutate(cv = exactextractr::exact_extract(ET2020, fields2016a, 'coefficient_of_variation'),
                                          mean = exactextractr::exact_extract(ET2020, fields2016a, 'mean'),
                                          stdev = exactextractr::exact_extract(ET2020, fields2016a, 'stdev'),
                                          Year = lubridate::year(as.Date("2020", format = "%Y")))%>% 
  dplyr::mutate_at(c(1,8:10), list(~round(., 2)))%>%
  dplyr::select(-c(FID_1, Shp_Lng, Shap_Ar)) 



## ---------------------------------------write shps with zonal stats-----------------------------------------------##
sf::st_write(fields1986, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_1986.shp",overwrite=TRUE)
qs::qsave(fields1986, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_1986.qs")

sf::st_write(fields1996, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_1996.shp",overwrite=TRUE)
qs::qsave(fields1996, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_1996.qs")

sf::st_write(fields2000, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2000.shp",overwrite=TRUE)
qs::qsave(fields2000, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2000.qs")

sf::st_write(fields2002, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2002.shp",overwrite=TRUE)
qs::qsave(fields2002, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2002.qs")

sf::st_write(fields2006, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2006.shp",overwrite=TRUE)
qs::qsave(fields2006, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2006.qs")

sf::st_write(fields2008, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2008.shp",overwrite=TRUE)
qs::qsave(fields2008, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2008.qs")

sf::st_write(fields2009, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2009.shp",overwrite=TRUE)
qs::qsave(fields2009, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2009.qs")

sf::st_write(fields2010, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2010.shp",overwrite=TRUE)
qs::qsave(fields2010, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2010.qs")

sf::st_write(fields2011, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2011.shp",overwrite=TRUE)
qs::qsave(fields2011, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2011.qs")

sf::st_write(fields2013, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2013.shp",overwrite=TRUE)
qs::qsave(fields2013, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2013.qs")

sf::st_write(fields2015, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2015.shp",overwrite=TRUE)
qs::qsave(fields2015, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2015.qs")

sf::st_write(fields2016, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2016.shp",overwrite=TRUE)
qs::qsave(fields2016, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2016.qs")

sf::st_write(fields2017, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2017.shp",overwrite=TRUE)
qs::qsave(fields2017, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2017.qs")

sf::st_write(fields2018, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2018.shp",overwrite=TRUE)
qs::qsave(fields2018, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2018.qs")

sf::st_write(fields2019, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2019.shp",overwrite=TRUE)
qs::qsave(fields2019, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2019.qs")

sf::st_write(fields2020, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2020.shp",overwrite=TRUE)
qs::qsave(fields2020, "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/field_shape_zonal_stats_2020.qs")


raster::endCluster()