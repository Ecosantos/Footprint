library(httr)

	search <- paste("&q=",gsub(" ","+","Accipiter striatus"),sep="")

      base_url <- "http://www.inaturalist.org/"
      q_path <- "observations.csv"
      page_query <- paste(search,"&per_page=200&page=1",sep="")
	
data<-httr::GET(base_url, path = q_path, 
		query = "lat=-22.220087&lng=-45.93&radius=15&place_id=any&quality_grade=research&per_page=200&page=1",sep="")

data

str(data)


entries = data$headers$`x-total-entries`


head(read.csv(textConnection(content(data, 'text'))))


