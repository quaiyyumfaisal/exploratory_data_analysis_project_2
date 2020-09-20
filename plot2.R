## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 2: Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland ( fips == “24510”) from 1999 to 2008? Use the base plotting system 
## to make a plot answering this question.

## constructing and saving the plot in png format.

library(dplyr)
baltimore_total_emissions <- NEI %>%
    filter(fips == "24510") %>%
    group_by(year) %>%
    summarise(Emissions = sum(Emissions))

png("plot2.png")
color_range <- 2:(length(total_annual_emissions$year)+1)
with(baltimore_total_emissions,
     barplot(height = Emissions/1000, names.arg = year, col = color_range,
             xlab = "Year", ylab = expression('PM'[2.5]*' in Kilotons'),
             main = expression('Baltimore City, Maryland Emissions from 1999 to 2008'))
     )
dev.off()

