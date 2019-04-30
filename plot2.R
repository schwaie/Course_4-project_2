##download files
if(!file.exists("./data")) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/dataset.zip", mode = "wb")

##unzip the files
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

##subset data, include only fips=24510
baltCity<-subset(NEI, fips=="24510")

## get total emission data for years 1999, 2002, 2005, 2008
emissionsBalt <- aggregate(Emissions ~ year,baltCity, sum)

##plot the data
barplot(emissionsBalt$Emissions, names.arg=emissionsBalt$year, xlab="Year", 
        ylab="PM2.5 Emissions", 
        main="Total PM2.5 Emissions From Baltimore City, Maryland")