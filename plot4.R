## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999 to 2008?

library(ggplot2)
library(dplyr)

## Constructing and saving the plot in png format.


combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[combustion.coal,]

# Find emissions from coal combustion-related sources
emissions.coal.combustion <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

emissions.coal.related <- summarise(group_by(emissions.coal.combustion, year), Emissions=sum(Emissions))

png("plot4.png")
ggplot(emissions.coal.related, aes(x=factor(year), y=Emissions/1000,fill=year, label = round(Emissions/1000,2))) +
    geom_bar(stat="identity") +
    #geom_bar(position = 'dodge')+
    # facet_grid(. ~ year) +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in kilotons")) +
    ggtitle("Emissions from coal combustion-related sources in kilotons")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")

dev.off()
