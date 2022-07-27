#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

#UTILIZAR
# BASE
#https://shnayder.shinyapps.io/PlanYourExpedition/
#https://github.com/capsellabursa/PlanYourExpedition/blob/master/app.R
#scraping do iNaturalist já feito



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
library(shinydashboard)

Dashboard_Data<-read.csv("DashboardData.csv")

Dashboard_Data<-Dashboard_Data%>%
  mutate(ids=UC_NAME2)%>%
  as_tibble()

MEDIA_UC_MA<-Dashboard_Data%>%
  summarise_at(vars(HFP1993: HFP2013), mean, na.rm = TRUE)%>%
  mutate(UC_NAME2="MEDIA_UC_MA")%>%
  mutate(ids="MEDIA_UC_MA")

#Add MEDIA as a new observation
Dashboard_Data<-Dashboard_Data%>%add_case(MEDIA_UC_MA)

#Check if MEDIA is here
#Dashboard_Data%>%tail(1)

Dashboard_Data_MEDIA<-Dashboard_Data%>%
  filter(UC_NAME2=="MEDIA_UC_MA")%>% select(UC_NAME2,PLA_MAN2,MATA_ARE2,HFP1993:HFP2013)%>%
  pivot_longer(!c(UC_NAME2:MATA_ARE2),names_to="ANO",values_to="Impacto")%>%
  mutate(ANO=str_replace(ANO,"HFP", ""))%>%
  mutate(Impacto=round(Impacto,2))



pal_man<- colorFactor(c("tomato","royalblue2"), domain = df<-Dashboard_Data$PLA_MAN2)
df<-Dashboard_Data




addMapResetButton <- function(leaf) {
  leaf %>%
    addEasyButton(
      easyButton(
        icon = "ion-arrow-shrink", 
        title = "Reset View", 
        onClick = JS(
          "function(btn, map){ map.setView(map._initialCenter, map._initialZoom); }"
        )
      )
    ) %>% 
    htmlwidgets::onRender(
      JS(
        "
function(el, x){ 
  var map = this; 
  map.whenReady(function(){
    map._initialCenter = map.getCenter(); 
    map._initialZoom = map.getZoom();
  });
}"
      )
    )
}



ui <-  dashboardPage(skin = "black",
  dashboardHeader(title = "Basic dashboard"),
  dashboardSidebar(disable = TRUE),
  dashboardBody(
    # Boxes need to be put in a row (or column)
    fluidRow(
      box(leafletOutput('map'), height = 250),
      box(
        title = "Controls",
        plotlyOutput("plotly")
        )
    ), 
    
    #Segunda linha
    fluidRow(
      
      box("TESTE PROPOSAL ONLY",
          sliderInput("slider", "Number of observations:", 1, 100, 50))
      ),
    #Terceira linha
    fluidRow(
      box(
        width = 4, background = "black",
        includeHTML("iNatspps.html")
      ),
      box(
        title = "Title 5", width = 4, background = "light-blue",
        "A box with a solid light-blue background"
      ),
      box(
        title = "Title 6",width = 4, background = "maroon",
        "A box with a solid maroon background"
      )
    )
  )
)
  

server <- function(input, output) {
  
  output$map <- renderLeaflet({
    
    leaflet(Dashboard_Data)%>%
      addTiles() %>%  # Add default OpenStreetMap map tiles
      addMiniMap()%>%
      #    addMarkers(lng = ~Long, lat = ~Lat)%>%
      addMapResetButton()%>%
      addCircleMarkers(
        layerId = ~UC_NAME2, 
        lng = ~Long, lat = ~Lat,
        #                 clusterOptions = markerClusterOptions(),
        color = ~ifelse(PLA_MAN2=="Sim","Blue","Red"),
        #                       color = ~pal_man(PLA_MAN2),
        popup = ~paste0(UC_NAME2,
                        "<br/><strong>Jurisprudence</strong>:",ESF_ADM2,
                        "<br/><strong>Management plan.:</strong>",PLA_MAN2))
  })
  
  
  
  #click_marker <- eventReactive(input$map_marker_click, {
  click_marker <- eventReactive(input$map_marker_click, {
    x<-input$map_marker_click
    if(is.null(input$map_marker_click)){
      return(input$reset) 
    }else{
      return(x$id)
    }
  })
  
  
  
  #Funciona
  data_for_chart <- reactive({
    return(df[df$UC_NAME2 == click_marker(), ])
  })
  
  
  output$plotly<-  renderPlotly({
    data_for_chart2<-data_for_chart()%>%
      as_tibble()%>%
      select(UC_NAME2,PLA_MAN2,MATA_ARE2,HFP1993:HFP2013)%>%
      pivot_longer(!c(UC_NAME2:MATA_ARE2),names_to="ANO",values_to="Impacto")%>%
      mutate(ANO=str_replace(ANO,"HFP", ""))%>%
      mutate(Impacto=round(Impacto,2))
    Dashboard_Data_MEDIA%>%
      plotly::plot_ly(.,
                      x = .$ANO,
                      y = .$Impacto,
                      type = "scatter",
                      mode = 'lines+markers',name="Mata Atlântica")%>%
      add_trace(data_for_chart2, 
                x = data_for_chart2$ANO, 
                y = data_for_chart2$Impacto, mode = "lines+markers",name=data_for_chart2$UC_NAME2) %>%
      layout(hovermode = "x unified",
             #title ="Evolução do impacto antrópico",
             yaxis = list(title = "Impacto Antrópico",range = c(0,55)),
             showlegend = T, 
             legend = list(orientation = 'h')
      )
    
  })
  
}


shinyApp(ui, server)
