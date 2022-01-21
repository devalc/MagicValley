# -*- coding: utf-8 -*-
"""
Created on Fri Jan 14 19:28:13 2022

Reproject rasters to WGS 84- lat lon and clip to magic valley extent

@author: Chinmay Deval 
"""
import os
import glob
from osgeo import gdal
import geopandas as gpd

path_to_magicValley_extent = r"D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_extent/magic_valley_extent_NAD83.shp"

magicValleymask = gpd.read_file(path_to_magicValley_extent)

path_to_rasters = "D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_raw/"

path_to_write_rasters = "D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/"

rasters_list = glob.glob(path_to_rasters + '/**/*.img', recursive=True)

for raster in rasters_list:
    fname = raster.rsplit('\\',1)[1].rsplit('.',1)[0]
    print(fname)
    input_raster = gdal.Open(raster)
    output_raster = path_to_write_rasters + fname + ".tif"
    print(output_raster)
    warp = gdal.Warp(output_raster, input_raster, dstSRS="+proj=longlat +datum=WGS84 +no_defs",
                      cutlineDSName =path_to_magicValley_extent,cropToCutline=True,
                      srcNodata = -3.4e+38,
                     dstNodata = -9999)
    warp = None # Closes the files
