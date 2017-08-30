library(rgdal)
library(raster)
library(tidycensus)
library(tidyverse)
library(tmap)
library(tmaptools)
library(stringr)

options(tigris_use_cache = TRUE)

#Load the tables and filter out the ones we don't want
acs_choices=load_variables(2015, "acs5", cache=TRUE) #%>%
  #filter(endsWith(acs_choices$name,"E") & nchar(acs_choices$name)>8)

counties_map_p=function(acsvar,maptitle,legendtitle){

  #Load Data
co_geo <- get_acs(
  geography = "county",
  variables = acsvar,
  endyear = 2015,
  output = "wide",
  state = "CO",
  geometry = TRUE
)

#Shorten county name
co_geo$NAME = str_replace(
  co_geo$NAME, " County, Colorado", ""
)

#Basic map
tm_shape(co_geo) +
  tm_polygons(acsvar, title=legendtitle) +
  tm_text("NAME", size=.5) +
  tm_layout(title = maptitle, title.position = c("center","top"), inner.margins = c(.05,.2,.1,.02)) +
  tm_legend(position = c("left","center")) +
  tm_style_col_blind() +
  tm_compass(position = c(.07, .15), color.light = "grey90") +
  tm_credits("US Census Bureau 2011-2015 ACS", position = c(.73, 0))
}  

custom_map_p=function(filedata,customvar,mergevar,maptitle,legendtitle,creditsource){
  
  #Load Data
  co_geo <- get_acs(
    geography = "county",
    variables = "B19013_001E",
    endyear = 2015,
    output = "wide",
    state = "CO",
    geometry = TRUE
  )
  
  df <- merge(x=co_geo,y=filedata,by=c("NAME",mergevar),all=FALSE)
  
  #Shorten county name
  co_geo$NAME = str_replace(
    co_geo$NAME, " County, Colorado", ""
  )
  
  #Basic map
  tm_shape(co_geo) +
    tm_polygons(customvar, title=legendtitle) +
    tm_text("NAME", size=.5) +
    tm_layout(title = maptitle, title.position = c("center","top"), inner.margins = c(.05,.2,.1,.02)) +
    tm_legend(position = c("left","center")) +
    tm_style_col_blind() +
    tm_compass(position = c(.07, .15), color.light = "grey90") +
    tm_credits(creditsource, position = c(.73, 0))
}  
