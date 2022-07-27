#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


#Based on 
#https://github.com/kaplanas/Shiny-Lego
#https://github.com/NHohl/ShinyEcology/tree/master/app

library(dplyr)
library(tidyr)
library(tibble)
library(ggplot2)
library(shiny)
library(shinyWidgets)
library(shinycssloaders)
library(igraph)
library(ggraph)
library(scales)
library(DT)
library(treemap)
library(highcharter)
library(purrr)
library(stringr)
library(fuzzyjoin)
library(lexicon)
library(visNetwork)
library(httr)
library(rdrop2)
library(lubridate)
library(flexdashboard)
library(tidyverse)
library(knitr)
library(leaflegend)
library(leaflet)
#library(leaflet.extras)
library(shiny)
library(shinyjs)
library(highcharter)
library(DT)
library(plotly)



# Define server logic required to draw a histogram
server = function(input, output, session) {
  
  latitude<-c(35.94077, 35.83770, 35.84545, 35.81584, 35.79387, 36.05600)
  longitude<-c(-78.58010, -78.78084, -78.72444, -78.62568, -78.64262,-78.67600)
  amounts1<-c(27, 44, 34, 46, 25, 15)
  amounts2<-c(34, 52, 35, 78, 14, 24)
  ids<-c("a", "b", "c", "d", "e", "f")
  df<-data.frame(ids,amounts1,amounts2,latitude,longitude)
  
  map = createLeafletMap(session, 'map')
  
  session$onFlushed(once = T, function() {
    
    output$map <- renderLeaflet({
      leaflet(df) %>%
        addMarkers( ~ longitude,~ latitude)
    })
  })
  
  observe({
    click <- input$map_marker_click
    if (is.null(click))
      return()
    
    print(click)
    text <-
      paste("Lattitude ",
            click$lat,
            "Longtitude ",
            click$lng)
    
    leafletProxy(mapId = "map") %>%
      clearPopups() %>%
      addPopups(dat = click, lat = ~lat, lng = ~lng, popup = text)
    
    # map$clearPopups()
    # map$showPopup(click$latitude, click$longtitude, text)
  })
}
