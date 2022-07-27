
setwd("./Testelayouts/app2/")
dir()
shinyApp("./Testelayouts/ui.R","./Testelayouts/server.R")

shinyApp(ui,server)
