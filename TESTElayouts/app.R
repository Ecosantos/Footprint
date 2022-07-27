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


ui = #tagList(
      #  shinythemes::themeSelector(),
        navbarPage(
            # theme = "cerulean",  # <--- To use a theme, uncomment this
            "shinythemes",
            tabPanel("Navbar 1",
                     sidebarPanel(
                         fileInput("file", "File input:"),
                         textInput("txt", "Text input:", "general"),
                         sliderInput("slider", "Slider input:", 1, 100, 30),
                         tags$h5("Default actionButton:"),
                         actionButton("action", "Search"),
                         
                         tags$h5("actionButton with CSS class:"),
                         actionButton("action2", "Action button", class = "btn-primary")
                     ),
                     mainPanel(
                         tabsetPanel(
                             tabPanel("Tab 1",
                                      h4("Table"),
                                      tableOutput("table"),
                                      h4("Verbatim text output"),
                                      verbatimTextOutput("txtout"),
                                      h1("Header 1"),
                                      h2("Header 2"),
                                      h3("Header 3"),
                                      h4("Header 4"),
                                      h5("Header 5")
                             ),
                             tabPanel("Tab 2", includeHTML("iNatspps.html")),
                             tabPanel("Tab 3", "This panel is intentionally left blank")
                         )
                     )
            ),
            tabPanel("Navbar 2", 
                     includeHTML("iNatspps.html"),
                     includeHTML("Supplementary-material2.html")),
            tabPanel("Navbar 3", "This panel is intentionally left blank")
        )
#    )


server = function(input, output) {
        output$txtout <- renderText({
            paste(input$txt, input$slider, format(input$date), sep = ", ")
        })
        output$table <- renderTable({
            head(cars, 4)
        })
    }
    
    
shinyApp(ui,server)