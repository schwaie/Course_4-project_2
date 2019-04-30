##download files
if(!file.exists("./data")) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/dataset.zip", mode = "wb")

##unzip the files
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## subset data for Baltimore city
baltCity<-subset(NEI, fips=="24510")

## plot the data in ggplot2
library(ggplot2)
ggplot(baltCity, aes(factor(year), Emissions, fill=type)) + geom_bar(stat="identity") + 
        facet_grid(.~type) + labs(x="Year", y="Total PM2.5 Emissions") + 
        labs(title=expression("PM2.5 Emissions from Baltimore City by Source Type"))
