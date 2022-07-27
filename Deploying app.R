library(rsconnect)


#AUTHORIZE ACCOUNT
# Verificar em:
# https://www.shinyapps.io/admin/#/dashboard



#Load the app in my shinyApp account
#rsconnect::deployApp('path/to/your/app')

rsconnect::deployApp("Footprint.rmd")

#PROBLENS??
 #Try

#Update all packages loaded
update.packages((.packages())) 

old.packages((.packages())) 

#Update Rmarkdown
install.packages("rmarkdown")

#Page not found? Others?
??renv::rsconnect	