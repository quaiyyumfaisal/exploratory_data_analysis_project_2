## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 6: Compare emissions from motor vehicle sources in Baltimore City 
## with emissions from motor vehicle sources in Los Angeles County, California ( == “06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
library(dplyr)

## Constructing and saving the plot in png format.

fips_lookup <- data.frame(fips = c("06037", "24510"), county = c("Los Angeles", "Baltimore"))

vehicles_SCC <- SCC[grep("[Vv]ehicle", SCC$EI.Sector), "SCC"]
vehicle_emissions <- NEI %>%
    filter(SCC %in% vehicles_SCC & fips %in% fips_lookup$fips) %>%
    group_by(fips, year) %>%
    summarize(Emissions = sum(Emissions))

vehicle_emissions <- merge(vehicle_emissions, fips_lookup)

png("plot6.png")

mv_plot <- ggplot(vehicle_emissions, aes(x = factor(year), y = round(Emissions/1000, 2), 
                                          label=round(Emissions/1000,2), fill = year)) +
    geom_bar(stat = "identity") + facet_grid(. ~ county) +xlab("Year") +
    ylab(expression('PM'[2.5]*' Emissions in Kilotons')) +
    geom_label(aes(fill = year),colour = "white", fontface = "bold") +
    ggtitle("Vehicles Emissions from 1999 to 2008 : Los Angeles vs Baltimore")
print(mv_plot)
dev.off()
