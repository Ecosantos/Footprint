library(rsconnect)


#AUTHORIZE ACCOUNT
# Verificar em:
# https://www.shinyapps.io/admin/#/dashboard



#Load the app in my shinyApp account
#rsconnect::deployApp('path/to/your/app')

rsconnect::deployApp("Footprint.rmd")
