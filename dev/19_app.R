## --------------------------------------------------------------------------------------##
##
## Script name: 
##
## Purpose of the script: 19_app.R
##
## Author: Chinmay Deval
##
## Created On: 2021-07-16
##
## Copyright (c) Chinmay Deval, 2021
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
library(shiny)
library(leaflet)
library(mapview)
library(viridis)
library(tidyverse)
library(shinyWidgets)
# library(shinycssloaders)
library(bslib)
library(thematic)
library(leafem)
library(raster)
library(sf)

## ----------------------------------Init Options---------------------------------------##
options(shiny.maxRequestSize = 100 * 1024 ^ 2)
thematic_shiny(font = "auto")


## --------------------------------------------------------------------------------------##
tictoc::tic()

persistence_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/persistence_new_RAT_lyr_magicValley_1986_2020.tif") 
diff_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/difference_new_RAT_lyr_magicValley_1986_2020.tif") 
diff_cls_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/new_rel_ET/persistence/difference_5percent_new_RAT_lyr_magicValley_1986_2020.tif") 

# levels(persistence_ras)[[1]]$ID <-  c("No", "Yes")
# levels(diff_ras)[[1]]$ID <-  c("Lower", "Same", "Higher")
# levels(diff_cls_ras)[[1]]$ID <-  c("Lower", "Same", "Higher")
# 

# field_shp <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp")
# field_shp <- qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.qs")
# field_shp = qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/stats_merged_shp/simplified_field_boundaries_with_all_stats.qs")

tictoc::toc()

Persistence_pal <- colorFactor("viridis", values(persistence_ras), na.color = "transparent")
# Persistence_pal <- colorFactor("Spectral", as.factor(values(data[[1]])), na.color = NA)
diff_pal <- colorFactor("viridis", values(diff_ras), na.color = "transparent")
diff_cls_ras_pal <- colorFactor("viridis", values(diff_cls_ras), na.color = "transparent")



## ----------------------------------define UI------------------------------------------##
# 

ui <- navbarPage(title = div("ET-Persistence",
                             div(tags$a(
                               href = "https://www.uidaho.edu/",
                               tags$img(
                                 src = 'D:/GitHub/CAFE-ET-Persistence/www/UI.jpg',
                                 style = "position:fixed;right: 10px;top: 5px;padding-bottom:10px;",
                                 height = 70
                               )
                             ))),
                 
                 windowTitle = "CAFE-ET-Persistence",
                 
                 id="nav",
                 theme = bslib::bs_theme(primary = "#fa8072", secondary = "#25E7F3", 
                                         success = "#A8CEDD", bootswatch = "flatly"),
                 
                 
                 tabPanel("",
                          
                          div(class="outer",
                              
                              tags$head(
                                # Include our custom CSS
                                includeCSS("D:/GitHub/CAFE-ET-Persistence/www/styles.css"),
                                # includeScript("gtag.js")
                              ),
                              
                              
                              # If not using custom CSS, set height of leafletOutput to a number instead of percent
                              leafletOutput("map", width="100%", height="100%") ,
                              
                              )
                          
                          
                 )
)

server <- function(input, output, session) {
  
  output$map <- leaflet::renderLeaflet({
    leaflet() %>%
      addProviderTiles("Esri.WorldImagery") %>%
      leaflet::setView(lng = -114.07, lat = 42.7, zoom = 10)
      
      
  })
  
  observe({
    leafletProxy("map")%>%
      addRasterImage(persistence_ras,
                     colors = Persistence_pal,
                     opacity = 1,
                     layerId = "Persistence_95",
                     group = "Persistence",
                     project = FALSE) %>%
      addMouseCoordinates()  %>% 
      addLegend(pal = Persistence_pal, 
                values = values(persistence_ras),labels=c("NO","Yes"),
                  title = "Persistence")%>%
      addRasterImage(diff_ras,
                     colors = diff_pal,
                     opacity = 1,
                     layerId = "difference_class",
                     group = "Low/Same/High",
                     project = FALSE)%>% 
      addLegend(pal = diff_pal, values = values(diff_ras),title = "Difference from field average")%>%
      addRasterImage(diff_cls_ras,
                     colors = diff_cls_ras_pal,
                     opacity = 1,
                     layerId = "dif_perc_class",
                     group = "Difference from field mean greater than 5%",
                     project = FALSE)%>% 
      addLegend(pal = diff_cls_ras_pal, values = values(diff_cls_ras),title = "Difference from field mean greater than 5%")%>%
      addLayersControl(overlayGroups = c("Persistence", 
                                         "Low/Same/High",
                                         "Difference from field mean greater than 5%"
      ),
      options = layersControlOptions(collapsed = FALSE, title = "Layer Control")
      )%>% hideGroup(c("Low/Same/High", "Difference from field mean greater than 5%"))
    
    
    
    # %>% 
    #   addLegend(pal = Persistence_pal, values = values(persistence_ras),title = "Persistence")%>%
    #   addPolygons(data = field_shp,
    #               color = "red",
    #               fillColor = "gray",
    #               fillOpacity = 0.1,
    #               weight = 1.5,
    #               group = "Field Boundary")
    
    # %>%
    #       addMiniMap(tiles = providers$Esri.WorldImagery,
    #                  toggleDisplay = TRUE)
  })
      
  
    
    
  

}

# run_with_themer(shinyApp(ui, server))
shinyApp(ui, server)