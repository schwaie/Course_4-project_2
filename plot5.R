##download files
if(!file.exists("./data")) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/dataset.zip", mode = "wb")

##unzip the files
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## grab vehicle-related data
vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)

## bind into SCC 
vehicleSCC <- SCC[vehicle,]$SCC

## subset NEI data by vehicle in SCC
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC,]

##subset vehicleNEI data for Baltimore City
baltCityVehicle<-subset(vehicleNEI, fips=="24510")

##get total emissions for vehicles in Baltimore City
emissionsBaltVehicle <- aggregate(Emissions ~ year, baltCityVehicle, sum)

##plot the data
barplot(emissionsBaltVehicle$Emissions, names.arg=emissionsBaltVehicle$year, xlab="Year", 
        ylab="PM2.5 Emissions", 
        main="Total PM2.5 Emissions From Motor Vehicle Sources in Baltimore City, Maryland")

