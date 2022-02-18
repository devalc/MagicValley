## --------------------------------------------------------------------------------------##
##
## Script name: 10_persistence_pattern_hypothesis_testing.R
##
## Purpose of the script: Gets Relative ET stack and calculates persistence pattern
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
library(data.table)
library(matrixStats)
library(tidyverse)

## --------------------------------------------------------------------------------------##
raster::beginCluster()

data <- raster::stack("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/Relative_ET_stack_1986_2020.tif")

names(data) <- c("Relative_ET_1986", "Relative_ET_1996", "Relative_ET_2000", "Relative_ET_2002",
                 "Relative_ET_2006", "Relative_ET_2008", "Relative_ET_2009", "Relative_ET_2010",
                 "Relative_ET_2011", "Relative_ET_2013", "Relative_ET_2015", "Relative_ET_2016",
                 "Relative_ET_2017", "Relative_ET_2018", "Relative_ET_2019", "Relative_ET_2020")

raster::endCluster()

## ---------------------------------------stack to df-----------------------------------------------##

datadf <- data.table(values(data))

# rm(data)
## ----------------------------------------hypothesis testing----------------------------------------------##


tstattest95 <- matrixTests::row_t_onesample(x = as.matrix(datadf),mu = 1, conf.level = .95)

### difference of each pixel mean value compared to the field mean. Field mean is 1. because relative ET is used.
tstattest95 <- tstattest95 %>% dplyr::mutate(difference = mean -1)%>% 
  dplyr::mutate(persistance = case_when(pvalue < 0.05 ~ as.integer(1),
                                        pvalue >= 0.05 ~ as.integer(0),
                                        TRUE ~ NA_integer_)) %>% 
  dplyr::select(persistance, difference, mean)

colnames(tstattest95) <- paste(colnames(tstattest95), sep = "_", "95")


## --------------------------------------------------------------------------------------##

datadf_with_stats <- cbind(datadf, tstattest95)

datadf_with_stats <- datadf_with_stats %>% 
  dplyr::mutate(difference_class = dplyr::case_when((persistance_95==1 & difference_95 < 0) ~ as.integer(-1),
                                                    (persistance_95==1 & difference_95 > 0)  ~ as.integer(1),
                                                    persistance_95==0 ~ as.integer(0),
                                                    TRUE  ~ NA_integer_))

datadf_with_stats <- datadf_with_stats %>% dplyr::mutate(diff_perc = difference_95/mean_95 *100)%>% 
  dplyr::mutate(dif_perc_class = dplyr::case_when((persistance_95==1 & diff_perc < -5) ~ as.integer(-1),
                                                  (persistance_95==1 & diff_perc > 5) ~ as.integer(1),
                                                  persistance_95==0 ~ as.integer(0),  ## switch off
                                                  TRUE  ~ NA_integer_))


## -------------------------------writing ttest results to raster stack -------------------------------------------------------##

r.t95 <- raster::stack(data[[1]],data[[1]], data[[1]])
values(r.t95) <- as.matrix(datadf_with_stats[,c('persistance_95', 'difference_class', 'dif_perc_class')])




raster::writeRaster(r.t95,
                    paste0("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/", "persistence_at_95_magicValley_1986_2020.tif"),
                    overwrite=TRUE,options=c("COMPRESS=LZW"))
