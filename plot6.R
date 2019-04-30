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
baltCityVehicle <- vehicleNEI[vehicleNEI$fips==24510,]
baltCityVehicle$city <- "Baltimore City"

##subset vehicleNEI data for Los Angeles
losAngelesVehicle <- vehicleNEI[vehicleNEI$fips=="06037",]
losAngelesVehicle$city <- "Los Angeles"

##bind Baltimore City and Los Angeles vehicles into one data frame
BaltLA <- rbind(baltCityVehicle, losAngelesVehicle)

##plot the data
ggplot(BaltLA, aes(x=factor(year), y=Emissions, fill=city)) +
        geom_bar(aes(fill=year),stat="identity") +
        facet_grid(scales="free", space="free", .~city) +
        labs(x="year", y=expression("Total PM2.5 Emissions")) + 
        labs(title=expression("Total PM2.5 Emissions From Motor Vehicle Source 
                              Emissions in Baltimore and Los Angeles"))