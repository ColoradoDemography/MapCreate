library(plotly)

source("acsmap.R")



function(input, output, session) {
  
  acsvar <- "B00001_001E"
  maptitle <- ""
  legendtitle <- ""
  
  #Match ACS Table Full Name to Table Code
  acsgo <- eventReactive(input$go,{
    
    acsvar=input$acsVar})
  #as.character()})
  
  mapgo <- eventReactive(input$go,{  
    maptitle=input$mapTitle})#%>%
  #as.character()
  
  leggo <- eventReactive(input$go,{  
    legendtitle=input$legendTitle})#%>%
  #as.character()
  
  
  output$countyMap=renderPlot({counties_map_p(acsvar = acsgo(), maptitle = mapgo(), legendtitle = leggo())})
  
}