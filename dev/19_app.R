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

persistence_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/persistence_new_RAT_lyr_magicValley_1986_2020.tif") 
diff_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/difference_new_RAT_lyr_magicValley_1986_2020.tif") 
diff_cls_ras = raster::raster("D:/OneDrive - University of Idaho/MagicValleyData/Relative_ET/persistence/difference_5percent_new_RAT_lyr_magicValley_1986_2020.tif") 

# levels(data[[1]])[[1]]$VALUE <-  c("No", "Yes")
# levels(data[[2]])[[1]]$VALUE <-  c("Lower", "Same", "Higher")
# levels(data[[3]])[[1]]$VALUE <-  c("Lower", "Same", "Higher")
# 

# field_shp <- sf::st_read("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.shp")
field_shp <- qs::qread("D:/OneDrive - University of Idaho/MagicValleyData/CropScape_data_for_magicvalley/Common_land_cover_category/dominant_crop_cover_ts_shp/dominant_crop_cover_2005_to_2020_with_2016_field_boundry.qs")
tictoc::toc()


# Persistence_pal <- colorFactor("Spectral", as.factor(values(data[[1]])), na.color = NA)
# diff_pal <- colorFactor("Spectral", as.factor(values(data[[2]])), na.color = NA)



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
      leaflet::setView(lng = -113.67, lat = 42.815, zoom = 10)%>%
          addMiniMap(tiles = providers$Esri.WorldImagery,
                     toggleDisplay = TRUE)
      
      
  })
  
  observe({
    leafletProxy("map") %>%
        addRasterImage(persistence_ras,
                       colors = "viridis",
                       opacity = 1,
                       layerId = "Persistence_95",
                       group = "Persistence",
                       project = FALSE) %>%
        addMouseCoordinates() %>%
        addImageQuery(persistence_ras, type="mousemove", layerId = "Persistence_95")
    # %>%
        # addRasterImage(diff_ras,
        #                # colors = diff_pal,
        #                opacity = 1,
        #                layerId = "difference_class",
        #                group = "Low/Same/High",
        #                project = FALSE) %>%
        #                    addMouseCoordinates() %>%
        #                    addImageQuery(diff_ras, type="mousemove", layerId = "difference_class")%>%
        # addRasterImage(diff_cls_ras,
        #                # colors = diff_pal,
        #                opacity = 1,
        #                layerId = "dif_perc_class",
        #                group = "Difference from field mean greater than 5%",
        #                project = FALSE) %>%
        # addMouseCoordinates() %>%
        # addImageQuery(diff_cls_ras, type="mousemove", layerId = "dif_perc_class")%>%
        # addPolygons(data = field_shp,
        #             color = "red",
        #             fillColor = "gray",
        #             fillOpacity = 0.1,
        #             weight = 1.5,
        #             group = "Field Boundary",
        #             popup = popup <- paste0("<strong>2005:</strong>", field_shp$Crop_2005,"<br/>",
        #                                     "<strong>2007:</strong>", field_shp$Crop_2007, "<br/>",
        #                                     "<strong>2008:</strong>", field_shp$Crop_2008, "<br/>",
        #                                     "<strong>2010:</strong>", field_shp$Crop_2010, "<br/>",
        #                                     "<strong>2011:</strong>", field_shp$Crop_2011, "<br/>",
        #                                     "<strong>2012:</strong>", field_shp$Crop_2012, "<br/>",
        #                                     "<strong>2013:</strong>", field_shp$Crop_2013, "<br/>",
        #                                     "<strong>2014:</strong>", field_shp$Crop_2014, "<br/>",
        #                                     "<strong>2015:</strong>", field_shp$Crop_2015, "<br/>",
        #                                     "<strong>2016:</strong>", field_shp$Crop_2016, "<br/>",
        #                                     "<strong>2017:</strong>", field_shp$Crop_2017, "<br/>",
        #                                     "<strong>2018:</strong>", field_shp$Crop_2018, "<br/>",
        #                                     "<strong>2019:</strong>", field_shp$Crop_2019, "<br/>",
        #                                     "<strong>2020:</strong>", field_shp$Crop_2020, "<br/>")) %>%
        # addLegend("topleft", pal=Persistence_pal, values=as.factor(values(data[[1]])),
        #           title="Persistently different:", opacity=1, layerId="Persistence_leg",
        #           labFormat  = labelFormat(
        #             transform = function(x) {
        #               levels(data[[1]])[[1]]$VALUE[which(levels(data[[1]])[[1]]$ID == x)]
        #             })) %>%
        # addLegend("topleft", pal=diff_pal, values=as.factor(values(data[[3]])),
        #           title="Difference greater than +-5% of field mean ET:", opacity=1, layerId="diff_high_low_leg",
        #           labFormat  = labelFormat(
        #             transform = function(x) {
        #               levels(data[[3]])[[1]]$VALUE[which(levels(data[[3]])[[1]]$ID == x)]
        #             })) %>%
        # addLegend("topleft", pal=diff_pal, values= as.factor(values(data[[2]])),
        #           title="Compared to field mean ET:", opacity=1, layerId="Persistence_leg1",
        #           labFormat  = labelFormat(
        #             transform = function(x) {
        #               levels(data[[2]])[[1]]$VALUE[which(levels(data[[2]])[[1]]$ID == x)]
        #             })
        #           ) %>%
        # addLayersControl(overlayGroups = c("Persistence", "Low/Same/High",
        #                                    "Difference from field mean greater than 5%", "Field Boundary"),
        #   options = layersControlOptions(collapsed = FALSE, title = "Layer Control")
        #   )%>% hideGroup(c("Low/Same/High", "Difference from field mean greater than 5%"))
  })
      
  
    
    
  

}

# run_with_themer(shinyApp(ui, server))
shinyApp(ui, server)
  

