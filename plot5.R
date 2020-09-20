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

baltcitymary.emissions<-NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

baltcitymary.emissions.byyear <- summarise(group_by(baltcitymary.emissions, year), Emissions=sum(Emissions))

png("plot5.png")
ggplot(baltcitymary.emissions.byyear, aes(x=factor(year), y=Emissions,fill=year, label = round(Emissions,2))) +
    geom_bar(stat="identity") +
    xlab("year") +
    ylab(expression("total PM"[2.5]*" emissions in tons")) +
    ggtitle("Emissions from motor vehicle sources in Baltimore City")+
    geom_label(aes(fill = year),colour = "white", fontface = "bold")
dev.off()
