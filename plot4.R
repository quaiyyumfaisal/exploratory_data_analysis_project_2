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

coal_SCC <- SCC[grep("[Cc][Oo][Aa][Ll]", SCC$EI.Sector), "SCC"]
coal_NEI <- NEI %>% filter(SCC %in% coal_SCC)
coal_summary <- NEI %>% group_by(year) %>% summarise(Emissions = sum(Emissions))

png("plot4.png")

g <- ggplot(coal_summary, aes(x = year, y = round(Emissions/1000, 2), label=round(Emissions/1000, 2), fill=year))
c_plot <- g+geom_bar(stat = "identity")+xlab("Year")+ylab(expression('PM'[2.5]*' Emissions in Kilotons'))+
    geom_label(aes(fill=year), color = "white", fontface ="bold")+ggtitle("Coal Combustion Emissions from 1999 to 2008")
print(c_plot)
dev.off()

