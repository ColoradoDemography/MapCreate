library(plotly)
library(ggplot2)


source("mapsetup.R")



shinyServer(function(input, output) ({
  
# acsvar <- "B00001_001E"
# maptitle <- ""
# legendtitle <- ""
  
myPlot <- function(){
  custom_map_p(filedata = filedata(), mergevar = mergego(), customvar = customgo(), maptitle = mapgo(), legendtitle = leggo(), creditsource = sourcego())
}
  
filedata <- reactive({
  infile <- input$datafile
  if (is.null(infile)) {
    # User has not uploaded a file yet
    return(NULL)
  }
  read.csv(infile$datapath, stringsAsFactors = FALSE)
})
  
output$contents <- renderTable({

  infile <- input$datafile
  
  if (is.null(infile))
    return(NULL)
  
  read.csv(infile$datapath, header = input$header)
})

output$fipsCol <- renderUI({
  df <-filedata()
  if (is.null(df)) return(NULL)
  
  items=names(df)
  names(items)=items
  selectInput("fips", "FIPS:",items)
  
})

output$valCol <- renderUI({
  df <-filedata()
  if (is.null(df)) return(NULL)
  
  items=names(df)
  names(items)=items
  selectInput("value", "Value:",items)
  
})

#Get the variables for the map plot

customgo <- reactive({
customvar <- input$value})

mergego <- reactive({
  mergevar <- input$fips})

mapgo <- reactive({  
  maptitle=input$mapTitle})

leggo <- reactive({  
  legendtitle=input$legendTitle})

sourcego <- reactive({  
  creditsource=input$creditSource})
  

output$customMap=renderPlot({
  if (input$cgo[[1]] == 0)
    return()
  else
    myPlot()
})
  
output$customMapPNG <- downloadHandler(
  filename = 
    paste("map",input$radButton,sept=".")
  ,
  content = function(file){
    if(input$radButton == "png")
      png(file)
    else
      pdf(file)
  myPlot()
  dev.off()
  })

}))
