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

path_to_irri_field_boundaries = "D:/OneDrive - University of Idaho/MagicValleyData/Irrigated_fields_in_magic_valley_wgs84/IrrigatedLands_2016_only_irrigated_fields.shp"

raster = "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/persistence_at_95_magicValley_1986_2020.tif"

path_to_write_rasters = "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/"

fname =raster.rsplit('/' )[5].rsplit('.')[0]

input_raster = gdal.Open(raster)
output_raster = path_to_write_rasters + fname + "_clipped_to_2016_poly_cutline.tif"
print(output_raster)
warp = gdal.Warp(output_raster, input_raster, dstSRS="+proj=longlat +datum=WGS84 +no_defs",
                   cutlineDSName =path_to_irri_field_boundaries,cropToCutline=True, creationOptions = ['COMPRESS=LZW'])
warp = None # Closes the files
