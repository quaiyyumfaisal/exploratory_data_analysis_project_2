## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
## which of these four sources have seen decreases in emissions from 1999 to 2008 for Baltimore City? 
## Which have seen increases in emissions from 1999 2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
library(dplyr)

## constructing and saving the plot in png format.

baltimore_total_emissions <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year, type) %>%
    summarise(Emissions = sum(Emissions))

png("plot3.png")
baltimore_ggplot <- ggplot(data = baltimore_total_emissions, aes(x = factor(year), y = Emissions, fill = type, color = "black"))+
    geom_bar(stat = "identity")+facet_grid(. ~ type)+xlab("Year")+ylab(expression('PM'[2.5]*' in Kilotons'))+
    ggtitle("Baltimore City Emissions by Souce Type from 1999 to 2008")
print(baltimore_ggplot)
dev.off()
    