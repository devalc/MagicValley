## --------------------------------------------------------------------------------------##
##
## Script name: 08_calc_relative_ET.R
##
## Purpose of the script: Reads in the cumulative annual total crop water use for each year
##                        and the field mean annual total crop water use for year and 
##                        returns relative ET raster.
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
library(tidyverse)

ras_path = "D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/"

shp_path = "D:/OneDrive - University of Idaho/MagicValleyData/Zonal_stats_ET/rasterized_fieldmeanET/"

write_loc = "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/"
## --------------------------------------------------------------------------------------##

FieldMean1986 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_1986.tif"))
FieldMean1996 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_1996.tif"))
FieldMean2000 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2000.tif"))
FieldMean2002 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2002.tif"))
FieldMean2006 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2006.tif"))
FieldMean2008 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2008.tif"))
FieldMean2009 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2009.tif"))
FieldMean2010 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2010.tif"))
FieldMean2011 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2011.tif"))
FieldMean2013 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2013.tif"))
FieldMean2015 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2015.tif"))
FieldMean2016 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2016.tif"))
FieldMean2017 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2017.tif"))
FieldMean2018 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2018.tif"))
FieldMean2019 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2019.tif"))
FieldMean2020 <- raster::raster(paste0(shp_path, "rasterized_fieldmeanET_2020.tif"))

ET1986 <- raster::raster(paste0(ras_path, "p3940_19860401to19861031_et.tif"))
ET1996 <- raster::raster(paste0(ras_path, "p3940_19960401to19961031_et.tif"))
ET2000 <- raster::raster(paste0(ras_path, "p3940_20000401to1031_et.tif"))
ET2002 <- raster::raster(paste0(ras_path, "p3940_20020401to20021031_et.tif"))
ET2006 <- raster::raster(paste0(ras_path, "p3940_20060401to20061031_et.tif"))
ET2008 <- raster::raster(paste0(ras_path, "p3940_20080401to20081031_et.tif"))
ET2009 <- raster::raster(paste0(ras_path, "p3940_20090401to20091031_et.tif"))
ET2010 <- raster::raster(paste0(ras_path, "p3940_20100401to20101031_et.tif"))
ET2011 <- raster::raster(paste0(ras_path, "p3940_20110401to20111031_et.tif"))
ET2013 <- raster::raster(paste0(ras_path, "p3940_20130401to20131031_et.tif"))
ET2015 <- raster::raster(paste0(ras_path, "p3940_20150401to20151031_et.tif"))
ET2016 <- raster::raster(paste0(ras_path, "p3940_20160401to20161031_et.tif"))
ET2017 <- raster::raster(paste0(ras_path, "p3940_20170401to20171031_et.tif"))
ET2018 <- raster::raster(paste0(ras_path, "p3940_20180401to20181031_et.tif"))
ET2019 <- raster::raster(paste0(ras_path, "p3940_20190401to20191031_et.tif"))
ET2020 <- raster::raster(paste0(ras_path, "p3940_20200401to20201031_et.tif"))

## --------------------------------------------------------------------------------------##

RelET1986 = ET1986 / FieldMean1986
RelET1996 = ET1996 / FieldMean1996
RelET2000 = ET2000 / FieldMean2000
RelET2002 = ET2002 / FieldMean2002
RelET2006 = ET2006 / FieldMean2006
RelET2008 = ET2008 / FieldMean2008
RelET2009 = ET2009 / FieldMean2009
RelET2010 = ET2010 / FieldMean2010
RelET2011 = ET2011 / FieldMean2011
RelET2013 = ET2013 / FieldMean2013
RelET2015 = ET2015 / FieldMean2015
RelET2016 = ET2016 / FieldMean2016
RelET2017 = ET2017 / FieldMean2017
RelET2018 = ET2018 / FieldMean2018
RelET2019 = ET2019 / FieldMean2019
RelET2020 = ET2020 / FieldMean2020


## --------------------------------------------------------------------------------------##
raster::writeRaster(RelET1986,
                    paste0(write_loc,"Relative_ET_1986.tif")
                    )

raster::writeRaster(RelET1996,
                    paste0(write_loc,"Relative_ET_1996.tif")
                    )

raster::writeRaster(RelET2000,
                    paste0(write_loc,"Relative_ET_2000.tif")
                    )

raster::writeRaster(RelET2002,
                    paste0(write_loc,"Relative_ET_2002.tif")
                    )

raster::writeRaster(RelET2006,
                    paste0(write_loc,"Relative_ET_2006.tif"))

raster::writeRaster(RelET2008,
                    paste0(write_loc,"Relative_ET_2008.tif"))

raster::writeRaster(RelET2009,
                    paste0(write_loc,"Relative_ET_2009.tif"))

raster::writeRaster(RelET2010,
                    paste0(write_loc,"Relative_ET_2010.tif"))

raster::writeRaster(RelET2011,
                    paste0(write_loc,"Relative_ET_2011.tif"))

raster::writeRaster(RelET2013,
                    paste0(write_loc,"Relative_ET_2013.tif"))

raster::writeRaster(RelET2015,
                    paste0(write_loc,"Relative_ET_2015.tif"))

raster::writeRaster(RelET2016,
                    paste0(write_loc,"Relative_ET_2016.tif"))

raster::writeRaster(RelET2017,
                    paste0(write_loc,"Relative_ET_2017.tif"))

raster::writeRaster(RelET2018,
                    paste0(write_loc,"Relative_ET_2018.tif"))

raster::writeRaster(RelET2019,
                    paste0(write_loc,"Relative_ET_2019.tif"))

raster::writeRaster(RelET2020,
                    paste0(write_loc,"Relative_ET_2020.tif"))