library(rgdal)
library(raster)
library(tidycensus)
library(tidyverse)
library(tmap)
library(tmaptools)
library(stringr)

options(tigris_use_cache = TRUE)

# Add key to .Renviron
Sys.setenv(CENSUS_KEY="70702eabc2d9259f35334d5702000e246ecffd14")
# Reload .Renviron
readRenviron(".Renviron")
# Check to see that the expected key is output in your R console
Sys.getenv("CENSUS_KEY")

#Load the tables and filter out the ones we don't want
acs_choices=load_variables(2015, "acs5", cache=TRUE) #%>%
  #filter(endsWith(acs_choices$name,"E") & nchar(acs_choices$name)>8)

custom_map_p=function(filedata,customvar,mergevar,maptitle,legendtitle,creditsource,colorpal,numbreaks,breakstyle){
  
  #Load Data
  co_geo <- get_acs(
    geography = "county",
    variables = "B19013_001E",
    endyear = 2015,
    output = "wide",
    state = "CO",
    geometry = TRUE
  )
  
  #Add Geonum column
  co_geo$geonum = paste0("1",co_geo$GEOID)
  
  co_geo <- merge(x=co_geo,y=filedata,by.x="NAME",by.y=mergevar)
  co_geo[[customvar]] <- as.numeric(co_geo[[customvar]])
  
  #Shorten county name
  co_geo$NAME = str_replace(
    co_geo$NAME, " County, Colorado", ""
  )
  
  #Basic map
  tm_shape(co_geo) +
    tm_borders(col = "grey") +
    tm_text("NAME", size=.5) +
    tm_layout(title = maptitle, title.position = c("center","top"), inner.margins = c(.05,.18,.1,.02)) +
    tm_legend(position = c("left","center")) +
    tm_compass(position = c(.07, .15), color.light = "grey90") +
    tm_credits(creditsource, position = c(.73, 0)) +
    tm_fill(customvar, palette = colorpal, title = legendtitle, n = numbreaks, style = breakstyle, auto.palette.mapping = FALSE)

}

# save_map_p=function(filename,filedata,customvar,mergevar,maptitle,legendtitle,creditsource,colorpal,numbreaks){
#   
#   #Load Data
#   co_geo <- get_acs(
#     geography = "county",
#     variables = "B19013_001E",
#     endyear = 2015,
#     output = "wide",
#     state = "CO",
#     geometry = TRUE
#   )
#   
#   #Add Geonum column
#   co_geo$geonum = paste0("1",co_geo$GEOID)
#   
#   co_geo <- merge(x=co_geo,y=filedata,by.x="NAME",by.y=mergevar)
#   co_geo[[customvar]] <- as.numeric(co_geo[[customvar]])
#   
#   #Shorten county name
#   co_geo$NAME = str_replace(
#     co_geo$NAME, " County, Colorado", ""
#   )
#   
#   #Basic map
#   tm <- tm_shape(co_geo) +
#     tm_borders(col = "grey") +
#     tm_text("NAME", size=.5) +
#     tm_layout(title = maptitle, title.position = c("center","top"), inner.margins = c(.05,.18,.1,.02)) +
#     tm_legend(position = c("left","center")) +
#     tm_compass(position = c(.07, .15), color.light = "grey90") +
#     tm_credits(creditsource, position = c(.73, 0)) +
#     tm_fill(customvar, palette = colorpal,title = legendtitle)
#   
#   save_tmap(tm, filename)
#}
