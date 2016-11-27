#Read data sources - assuming the source files are saved in the working directory
 NEI <- readRDS("./summarySCC_PM25.rds")
 SCC <- readRDS("./Source_Classification_Code.rds")

#Subset data
bcity <- subset(NEI, fips == "24510")

#Sum total emission data per year
sumEmissions <- tapply(bcity$Emissions, bcity$year, sum)

#Create Plot
colours <- c("red","blue","green","yellow")
barplot(sumEmissions, xlab = "Year", ylab = "Total Yearly Emissions (tons)", main = "Total Emissions By Year In Baltimore",col = colours)

#Save Plot
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
