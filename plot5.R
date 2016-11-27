#Read data sources - assuming the source files are saved in the working directory
 NEI <- readRDS("./summarySCC_PM25.rds")
 SCC <- readRDS("./Source_Classification_Code.rds")

#Subset SCC by Vehicle
vehicledata  <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
SCCsub <- SCC[vehicledata, ]

#Merge dataframes
NEI_SCC <- merge(bcity, SCCsub, by="SCC")

#Sum total emission data by year and type
sumEmissions <- tapply(NEI_SCC$Emissions, NEI_SCC$year, sum)

#Create Plot
colours <- c("red","blue","green","yellow")
barplot(sumEmissions, xlab = "Year", ylab = "Total yearly Emissions (tons)", main = "Total Emission From Motor Sources in Baltimore",col = colours)

#Save Plot
dev.copy(png, file="plot5.png", height=480, width=480)
dev.off()
