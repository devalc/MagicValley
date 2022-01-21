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

path_to_irri_field_boundaries = "D:/OneDrive - University of Idaho/MagicValleyData/magic_valley_field_boundries_wgs84/Irrigated_fields_only_wgs84/IrrigatedLands_1986_only_irrigated_fields.shp"

path_to_rasters = "D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_magicvalley_wgs84/"

path_to_write_rasters = "D:/OneDrive - University of Idaho/MagicValleyData/IDWR_Metric_ET_annual_totals_clipped_to_fields_with_irrigated_status_only/"

rasters_list = glob.glob(path_to_rasters + '/**/*.tif', recursive=True)

print(rasters_list)

for raster in rasters_list:
    fname = raster.rsplit('\\',1)[1].rsplit('.',1)[0]
    print(fname)
    input_raster = gdal.Open(raster)
    output_raster = path_to_write_rasters + fname + ".tif"
    print(output_raster)
    warp = gdal.Warp(output_raster, input_raster, dstSRS="+proj=longlat +datum=WGS84 +no_defs",
                      cutlineDSName =path_to_irri_field_boundaries,cropToCutline=True)
    warp = None # Closes the files