library(plotly)
library(shiny)

source("mapsetup.R")

shinyUI(pageWithSidebar(headerPanel("Create A Map"),
          sidebarPanel("",
                  fileInput("datafile", 'Choose CSV file',
                            accept=c('text/csv', 'text/comma-separated-values,text/plain')),
                    tags$hr(),
                    checkboxInput("header", "Header", TRUE),

                  uiOutput("fipsCol"),
                  uiOutput("valCol"),

                  textInput("mapTitle","Add a Map Title", ""),
                  textInput("legendTitle","Add a Legend Title", ""),
                  textInput("creditSource", "Add a Data Source", ""),
                  numericInput("numBreaks", "Number of Breaks", 6),
                  selectInput("breakStyle", "Choose Break Style", c("Natural" = "jenks",
                                                                    "Quantile" = "quantile")),
                  selectInput("colorPal", "Select Palette", c("Blue" = "Blues",
                                                              "Red" = "Reds",
                                                              "Green" = "Greens",
                                                              "Red to Green" = "RdYlGn",
                                                              "Red to Blue" = "RdYlBu")),

                  actionButton("cgo", "Plot Map")),

                  #radioButtons(inputId = "radButton", label = "Select the file type", choices = list("png","pdf"))),


          mainPanel(
            plotOutput("customMap")
            #downloadButton(outputId = "customMapPNG", "Download Map")
            
          )
))

           # function(req) {
           #   htmlTemplate("index.html",
           #                userfile=fileInput("datafile", 'Choose CSV file',
           #                                   accept=c('text/csv', 'text/comma-separated-values,text/plain')),
           #                        tags$hr(),
           #                        checkboxInput("header", "Header", TRUE),
           #                fipsColumn=uiOutput("fipsCol"),
           #                valColumn=uiOutput("valCol"),
           #                mapTitle=textInput("mapTitle","Add a Map Title", ""),
           #                legendTitle=textInput("legendTitle","Add a Legend Title", ""),
           #                sourceTitle=textInput("creditSource", "Add a data source", ""),
           #                buttonGo=actionButton("cgo", "Plot Map"),
           #                customMap=plotOutput("customMap"),
           #                buttonDL=downloadButton('customMapPNG', 'Download PNG')
           #                
           #                # county=selectInput("acsVar","Select a county:", choices = unique(acs_choices$label), selected = 'B01002_001E'),
           #                # mapTitle=textInput("mapTitle","Map Title"),
           #                # legendTitle=textInput("legendTitle","Legend Title"),
           #                # counties_map_p=plotlyOutput("countyMap"),
           #                # counties_map_d=downloadButton('countyMapPNG', 'Download PNG')
           #   )
           # }
           
           
           
           
           
           
