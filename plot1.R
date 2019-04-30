##download files
if(!file.exists("./data")) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/dataset.zip", mode = "wb")

##unzip the files
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## get total emission data for years 1999, 2002, 2005, 2008
emissionsTotal <- aggregate(Emissions ~ year,NEI, sum)
##make barplot
barplot(
        emissionsTotal$Emissions,
        names.arg=emissionsTotal$year,
        xlab="Year",
        ylab="PM2.5 Emissions",
        main="Total PM2.5 Emissions From All US Sources"
)