#Read data sources - assuming the source files are saved in the working directory
 NEI <- readRDS("./summarySCC_PM25.rds")
 SCC <- readRDS("./Source_Classification_Code.rds")
 
#Subset the SCC by Coal Values
coaldata  <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
SCCsub <- SCC[coaldata, ]

#Merge Dataframes
NEI_SCC <- merge(NEI, SCCsub, by="SCC")

#Sum total emission data per year
sumEmissions <- tapply(NEI_SCC$Emissions, NEI_SCC$year, sum)

#Create Plot
colours <- c("red","blue","green","yellow")
barplot(sumEmissions, xlab = "Year", ylab = "Total Yearly Emissions (tons)", main = "Total Coal Source Emissions", col = colours)

#Save Plot
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
