## --------------------------------------------------------------------------------------##
##
## Script name: 17_rasters_with_RAT.R
##
## Purpose of the script: creates factor rasters with attribute for factors
##
## Author: Chinmay Deval
##
## Created On: 2022-01-29
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

write_rat_back = "D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/"

data <- raster::stack("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/persistence_at_95_magicValley_1986_2020_clipped_to_1986_poly_cutline.tif")

names(data) <- c('Persistence_95', 'difference_class', "dif_perc_class")

persistence = data[["Persistence_95"]]
persistence_rat = ratify(persistence)
prat=levels(persistence_rat)[[1]]
prat$Pixel_Values = 0:1
prat$Class_Names <- c("Not Persistent", "Persistent")
levels(persistence_rat) = prat


diff_class = data[['difference_class']]
diff_class_rat  = ratify(diff_class)
drat = levels(diff_class_rat)[[1]]
drat$Pixel_Values = -1:1
drat$Class_Names <- c("Lower than field average", "Same as field average", "Higher than field average")
levels(diff_class_rat) = drat

diff_perc_cls = data[['dif_perc_class']]
diff_perc_cls_rat = ratify(diff_perc_cls)
dpercrat = levels(diff_perc_cls_rat)[[1]]
dpercrat$Pixel_Values = -1:1
dpercrat$Class_Names <- c("More than 5% lower than field average",
                          "Same as field average",
                          "More than 5% higher than field average")
levels(diff_perc_cls_rat) = dpercrat


# rasfinal = raster::stack(persistence_rat, 
#                          diff_class_rat, 
#                          diff_perc_cls_rat, RAT = TRUE)


raster::writeRaster(persistence_rat, 
                    paste0(write_rat_back,"persistence_new_RAT_lyr_magicValley_1986_2020.tif"),
                    overwrite=TRUE,
                    options=c("COMPRESS=LZW"))

raster::writeRaster(diff_class_rat, 
                    paste0(write_rat_back,"difference_new_RAT_lyr_magicValley_1986_2020.tif"),
                    overwrite=TRUE,
                    options=c("COMPRESS=LZW"))

raster::writeRaster(diff_perc_cls_rat, 
                    paste0(write_rat_back,"difference_5percent_new_RAT_lyr_magicValley_1986_2020.tif"),
                    overwrite=TRUE,
                    options=c("COMPRESS=LZW"))