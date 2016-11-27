#Load ggplot2 package
library(ggplot2)

#Read data sources - assuming the source files are saved in the working directory
 NEI <- readRDS("./summarySCC_PM25.rds")
 SCC <- readRDS("./Source_Classification_Code.rds")

#Sum emission data by year and type (uses bcity variable from plot2 script)
sumEmission <- aggregate(Emissions ~ year + type, bcity, sum)

#Create Plot
g <- ggplot(data, aes(year, Emissions, color = type))
g + geom_line() +
        xlab("Year") +
        ylab(expression("Total PM"[2.5]*" Emissions")) +
        ggtitle("Total Emissions per type in Baltimore")

#Save Plot
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
 
