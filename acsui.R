acs_choices=load_variables(2015, "acs5", cache=TRUE) %>%
  filter(endsWith(acs_choices$name,"E") & nchar(acs_choices$name)>8)

shinyUI(navbarPage("Map Create",
                   tabPanel("ACS Map",
                            actionButton("go", "Plot Map"),
                            selectInput("acsVar","Select a Table:", choices = unique(acs_choices$name), selected = 'B00001_001E'),
                            textInput("mapTitle","Add a Map Title", ""),
                            textInput("legendTitle","Add a Legend Title", ""),
                            plotOutput("countyMap"),
                            downloadButton('countyMapPNG', 'Download PNG')), 
                   
                   
                   # function(req) {
                   #   htmlTemplate("index.html",
                   #                county=selectInput("acsVar","Select a county:", choices = unique(acs_choices$label), selected = 'B01002_001E'),
                   #                mapTitle=textInput("mapTitle","Map Title"),
                   #                legendTitle=textInput("legendTitle","Legend Title"),
                   #                counties_map_p=plotlyOutput("countyMap"),
                   #                counties_map_d=downloadButton('countyMapPNG', 'Download PNG')
                   #   )
                   # },
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   
                   tabPanel("Custom Map")
))