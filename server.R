library(plotly)

source("mapsetup.R")



function(input, output, session) {
  
# acsvar <- "B00001_001E"
# maptitle <- ""
# legendtitle <- ""
  
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

customgo <- eventReactive(input$cgo,{
customvar <- input$valCol})

mergego <- eventReactive(input$cgo,{
  mergevar <- input$fipsCol})

mapgo <- eventReactive(input$cgo,{  
  maptitle=input$mapTitle})

leggo <- eventReactive(input$cgo,{  
  legendtitle=input$legendTitle})

sourcego <- eventReactive(input$cgo,{  
  creditsource=input$creditSource})
  

#output$customMap=renderPlot({custom_map_p(filedata = filedata(), mergevar = mergego(), customvar = customgo(), maptitle = mapgo(), legendtitle = leggo(), creditsource = sourcego())})
  
output$downloadButton <- downloadHandler(
  filename = "Shinyplot.png",
  content = function(file) {
    png(file)
    renderPlot({custom_map_p(filedata, mergevar = mergego(), customvar = customgo(), maptitle = mapgo(), legendtitle = leggo(), creditsource = sourcego())})
    dev.off()
  })    

}
