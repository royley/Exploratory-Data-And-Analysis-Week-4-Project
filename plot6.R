#Read data sources - assuming the source files are saved in the working directory
 NEI <- readRDS("./summarySCC_PM25.rds")
 SCC <- readRDS("./Source_Classification_Code.rds")

#Subset NEI by Baltimore and Los Angeles data
bcity <- subset(NEI, fips == "24510")
la <- subset(NEI, fips == "06037")

#Subset SCC by Vehicle
vehicledata  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCCsub <- SCC[vehicledata, ]

#Merge dataframes, including City data
bcitydata <- merge(bcity, SCCsub, by="SCC")
bcitydata$city <- "Baltimore City"
ladata <- merge(la, SCCsub, by="SCC")
ladata$city <- "Los Angeles County"
mergeddata <- rbind(bcitydata, ladata)

#Sum Total emission data by year and type
sumEmissions <- aggregate(Emissions ~ year + city, mergeddata, sum)

#Create Plot
g <- ggplot(sumEmissions, aes(year, Emissions, color = city))
g + geom_line() +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]*" Emissions")) +
        ggtitle("Total Emissions From Baltimore and Los Angeles Motor Sources")

#Save Plot
dev.copy(png, file="plot6.png", height=480, width=480)
dev.off()
