## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)

## ---- loading libraries--------------------------------------------------
library(devtools)
library(geospaar)
library(dplyr)
library(tidyr)
library(tidyverse)
library(ggplot2)
library(fs)
library(mapview)
library(rgeos)
library(rgdal)
library(rmarkdown)
library(sf)
library(sp)
library(tibble)
library(stats)
library(utils)
library(knitr)
library(gstat)
library(raster)

## ------------------------------------------------------------------------
library(longisland)

## ------------------------------------------------------------------------
mastersheet <- readr::read_csv(
  system.file("extdata/Mastersheet.csv", package = "longisland")) %>%
  st_as_sf(., coords = c("long", "lat"), crs = 4326)
mastersheet_na.omit <- na.omit(mastersheet)
mast <- mastersheet_na.omit

## ------------------------------------------------------------------------
library(mapview)
mapview_study_regions <- mapview(mast, zcol = "Region", legend = TRUE)
mapview_study_regions

## ------------------------------------------------------------------------
mapview_ox <- mapview(mast, zcol = "Dissolved Oxygen Change (mg/L)", at = seq(-3, 4, 1), legend = TRUE)
mapview_ox

## ------------------------------------------------------------------------
mapview_sal <- mapview(mast, zcol = "Salinity Change (PSU)", at = seq(-1.5, 1.5, 0.5), legend = TRUE)
mapview_sal

## ------------------------------------------------------------------------
mapview_temp <- mapview(mast, zcol = "Temperature Change (Fahrenheit)", at = seq(-1, 3, 0.5), legend = TRUE)
mapview_temp

## ------------------------------------------------------------------------
mapview_con <- mapview(mast, zcol = "Conductivity Change (S/m)", at = seq(-0.3, 0.3, 0.1), legend = TRUE)
mapview_con

## ------------------------------------------------------------------------
mapview_den <- mapview(mast, zcol = "Density Change (kg/m^3)", at = seq(-1.8, 0.9, 0.3), legend = TRUE)
mapview_den

## ------------------------------------------------------------------------
mastersheet_new <- readr::read_csv(
  system.file("extdata/Mastersheet_new.csv", package = "longisland")) %>% 
  st_as_sf(., coords = c("long", "lat"), crs = 4326)
r <- raster(extent(mastersheet_new), res = 0.03)
US_Data <- getData('GADM', country='USA', level=0) %>% st_as_sf
# US_Data %>% st_as_sf %>% 
#   filter(NAME_1 %in% c("New York", "Connecticut", "New Jersey")) -> US_Data 
# US_Data %>% st_geometry %>% plot(col = "grey")
US_Data <- st_crop(US_Data, st_bbox(mastersheet_new)) %>% as_Spatial

