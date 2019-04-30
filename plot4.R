##download files
if(!file.exists("./data")) {dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, destfile = "./data/dataset.zip", mode = "wb")

##unzip the files
unzip(zipfile="./data/dataset.zip", exdir="./data")

##read the files
NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## use the SCC file to find sources with combustion and coal
## grab combustion and coal-related data
combustion <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coal <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE)

## bind into SCC 
combustionCoal <- (combustion & coal)
combustionCoalSCC <- SCC[combustionCoal,]$SCC

## subset NEI data by coal and combustion in SCC
combustionCoalNEI <- NEI[NEI$SCC %in% combustionCoalSCC,]

#### get total combustion and coal emission data for years 1999, 2002, 2005, 2008
combCoalEmissionsTotal <- aggregate(Emissions ~ year,combustionCoalNEI, sum)

##plot the data
barplot(
        combCoalEmissionsTotal$Emissions,
        names.arg=combCoalEmissionsTotal$year,
        xlab="Year",
        ylab="PM2.5 Emissions",
        main="Total PM2.5 Emissions From Coal Combustion-Related Sources"
)


