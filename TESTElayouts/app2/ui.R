shinyUI(fluidPage(theme = "style.css",
                  div(style = "padding: 1px 0px; width: '100%'",
                      titlePanel(
                        title = "",
                        windowTitle = "Living in the Lego World"
                      )
                  ),
                  navbarPage(
                    
                    # Application title.
                    title = div(span(img(src = "lego_head_small.png"),
                                     "Living in the Lego World",
                                     style = "position: relative; top: 70%; transform: translateY(-50%);")),
                  
#=======================================================================================  
                  ### Demographics. 
#=======================================================================================
                    tabPanel(
                      
                      "Demographics",
                      # One tab for each plot/table.
                      tabsetPanel(
                        
                        type = "tabs",

#----------------------------------------------------------------------------------------                      
                      # Circle-packing plot of ethnicity and gender.
#----------------------------------------------------------------------------------------                      
                        tabPanel(
                          
                          "Ethnicity and gender",
                          
                          # Main panel with plot.
                          mainPanel(
                            "TESTE",
                            leafletOutput('map', height = 250),
                           "TESTE"
                          )
                          ),
                        
##################################################################################
                        # MYTESTE
##################################################################################
                        tabPanel(
                          
                          "TESTE HERE",
                          
                          # Sidebar panel for controls.
                          sidebarPanel(
                            includeHTML("iNatspps.html"),              #iNaturalist
                            pickerInput(
                              "demographicsMeasurePicker", "Choose measure to plot:",
                              choices = c("Ethnic diversity", "Percent female"),
                              selected = "Ethnic diversity",
                              multiple = F
                            ),
                            pickerInput(
                              "demographicsOrderPicker", "Order by:",
                              choices = c("Measure", "Number of pieces", "Theme name"),
                              selected = "Measure",
                              multiple = F
                            ),
                            tags$p(HTML("<b>Hover</b> to see the number of pieces and measure value.")),
                            tags$p(HTML("<b>Ethnic diversity</b> is the Shannon entropy (base 2) of color over all pieces.")),
                            tags$p(HTML("<b>Percent female</b> is the percent of female pieces out of all pieces, excluding pieces of unknown gender.")),
                            tags$p(HTML("<b>Saturation</b> represents the number of pieces in the theme."))
                          ),
                          
                          # Main panel with plot.
                          mainPanel(
                            includeHTML("iNatspps.html"),              #iNaturalist
                            includeHTML("supplementary-material2.html")                                )
                          
                        ),
##################################################################################                              
                        # Table for finding sets with pieces of particular ethnicity/gender.
                        tabPanel(
                          
                          "Find sets with a specific ethnicity or gender",
                          
                          # Sidebar panel for controls.
                          sidebarPanel("TEXT",
                                       "TESTE", shinycssloaders::withSpinner(leaflet::leafletOutput("map", width = "300%", height = "300%"))),
                            # Main panel with table.
                          mainPanel("TESTE",
                            leafletOutput("map", width = "30%", height = "30%")  
                          )
                          
                        )
                      )
                      
                    ),


#=======================================================================================  
#                     About and credits.
#=======================================================================================

                    tabPanel(
                      
                      "About",
                      
                      # Various tabs.
                      tabsetPanel(
                        
                        # General info.
                        tabPanel(
                          "Overview",
                          tags$h1("Scope"),
                          tags$p(HTML("This collection of visualizations addresses the question, \"What is it like to live in the Lego world?\"  In other words, if you're Wyldstyle, what kinds of people do you meet?  How are they feeling?  What plants and animals do you find around you?")),
                          tags$p(HTML("Think of each theme as an island on the Lego planet.  Each visualization can be faceted by theme, so you can compare fashion, flora and fauna, etc. across themes.")),
                          tags$h1("Approach"),
                          tags$p(HTML("Parts are labeled and categorized using three main sources of information:")),
                          tags$ul(
                            tags$li(HTML("The part category (e.g., \"Minifig Heads\" or \"Plants and Animals\") specified in the database")),
                            tags$li(HTML("The hexadecimal part color specified in the database")),
                            tags$li(HTML("Keywords in the part name"))
                          ),
                          tags$p(HTML("The keywords that map part names to categories involve more-or-less hand-curated lists and some <i>very</i> basic text processing (mostly regular expressions).  The process is <b>not 100% accurate</b>; there are plenty of false positives and false negatives.  But it's good enough for a first pass.")),
                          tags$h1("GitHub"),
                          tags$p(HTML("Source code is available at <a href=\"https://github.com/kaplanas/Shiny-Lego\">https://github.com/kaplanas/Shiny-Lego</a>."))
                        ),
                        
                        # Credits.
                        tabPanel(
                          "Credits",
                          tags$h1("Datasets"),
                          tags$p(HTML("All Lego data comes from the files made available by <a href=\"https://rebrickable.com/downloads/\">Rebrickable</a>.  The app checks for new data about once a week.")),
                          tags$p(HTML("Phylogenetic trees are inferred from hypernym relations in the <a href=\"https://wordnet.princeton.edu/\">WordNet</a> database, using the files provided by <a href=\"http://wordnetport.sourceforge.net/\">WordNetPort</a>.")),
                          tags$p(HTML("Basic lemmatization uses the list in the <a href=\"https://github.com/trinker/lexicon\">lexicon</a> package.")),
                          tags$h1("R Packages"),
                          tags$p(HTML("<a href=\"http://shiny.rstudio.com/\">Shiny</a> and the <a href=\"https://www.tidyverse.org/\">tidyverse</a>, of course.")),
                          tags$p(HTML("Position and size of the circles in the demographics circle-packing graphs are calculated using <a href=\"https://github.com/thomasp85/ggraph\">ggraph</a>.")),
                          tags$p(HTML("<a href=\"https://igraph.org/r/\">igraph</a> is used to model the hierarchical relationships in the circle-packing graphs, and to construct phylogenetic trees from the graph of WordNet hypernym relationships.")),
                          tags$p(HTML("Treemaps, polar charts, and bar charts are rendered with <a href=\"https://www.highcharts.com/\">Highcharts</a>, via <a href=\"http://jkunst.com/highcharter/\">Highcharter</a>.")),
                          tags$p(HTML("Phylogenetic trees are rendered with <a href=\"https://datastorm-open.github.io/visNetwork/\">visNetwork</a>.")),
                          tags$p(HTML("Tables are rendered with <a href=\"https://datatables.net/\">DataTables</a>, using the <a href=\"https://rstudio.github.io/DT/\">DT</a> package.")),
                          tags$p(HTML("Joins with regular expressions are facilitated by <a href=\"https://github.com/dgrtwo/fuzzyjoin\">fuzzyjoin</a>.")),
                          tags$p(HTML("<a href=\"https://github.com/statsmaths/cleanNLP\">cleanNLP</a> and <a href=\"https://cran.r-project.org/web/packages/wordnet/index.html\">wordnet</a> aren't used in the app, but were helpful in exploratory data analysis</a>."))
                        ),
                        
                        # Other visualizations.
                        tabPanel(
                          "Other visualizations",
                          tags$p(HTML("")),
                          tags$p(HTML("<a href=\"https://shiny.rstudio.com/gallery/lego-set.html\">LEGO set visualizer</a> (Shiny app)")),
                          tags$p(HTML("<a href=\"https://www.kaggle.com/devisangeetha/lego-let-s-play\">LEGO - Let's play</a> (parts, colors, sets, and themes)")),
                          tags$p(HTML("<a href=\"https://mode.com/blog/lego-data-analysis\">67 years of Lego sets</a>")),
                          tags$p(HTML("<a href=\"https://flowingdata.com/2015/10/19/evolving-lego-color-palette/\">Evolving LEGO color palette</a>")),
                          tags$p(HTML("<a href=\"https://nateaff.com/2017/09/11/lego-topic-models/\">LEGO color themes as topic models</a>")),
                          tags$p(HTML("<a href=\"https://www.wired.com/2012/01/the-mathematics-of-lego/\">The mathematics of Lego</a> (set size and the power law)")),
                          tags$p(HTML("<a href=\"http://www.bartneck.de/2010/12/17/taxonomy-for-lego-minifigures/\">Taxonomy for LEGO Minifigures</a>")),
                          tags$p(HTML("<a href=\"https://www.kaggle.com/martinellis/prominence-of-special-parts-over-time-visualised\">Prominence of special parts over time, visualised</a>")),
                          tags$p(HTML("<a href=\"https://therealityprose.wordpress.com/2013/01/17/what_happened_with_lego/\">What happened with LEGO</a> (Lego set price over time)")),
                          tags$p(HTML("Various other projects on <a href=\"https://www.kaggle.com/rtatman/lego-database/kernels\">Kaggle</a>"))
                        )
                        
                      )
                      
                    )
                    
                  )))
