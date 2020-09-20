## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 5: How have emissions from motor vehicle sources changed from 1999 to 2008 in Baltimore City?

library(ggplot2)
library(dplyr)

## Constructing and saving the plot in png format.

scc_vehicles <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
vehicle_emissions <- NEI %>%
    filter(SCC %in% scc_vehicles & fips == "24510") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

png("plot5.png", width = 480, height = 480)
g <- ggplot(coal_summary, aes(x=year, y=round(Emissions/1000,2), label = round(Emissions/1000,2), fill = year))
v_plot <- g+geom_bar(stat = "identity")+xlab("Year")+ylab(expression('PM'[2.5]*' Emissions in Kilotons'))+
    geom_label(aes(fill=year), color ="white", fontface = "bold")+ggtitle("Vehicles Emissions in Baltimore City from 1999 to 2008")
print(v_plot)
dev.off()