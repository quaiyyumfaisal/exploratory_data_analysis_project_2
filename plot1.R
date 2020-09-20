## Reading the NEI and SCC data

if(!exists("NEI")){
    NEI <- readRDS("summarySCC_PM25.rds")
}

if(!exists("SCC")){
    SCC <- readRDS("Source_Classification_Code.rds")
}

## Question 1: Have total emissions from PM2.5 decreased in the United States 
## from 1999 to 2008? Using the base plotting system, make a plot showing the 
## total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, 
## and 2008.

## constructing and saving the plot in png format.

total_annual_emissions <- aggregate(Emissions ~ year, NEI, FUN = sum)

png("plot1.png")
color_range <- 2:(length(total_annual_emissions$year)+1)
with(total_annual_emissions, 
     barplot(height=Emissions/1000, names.arg = year, col = color_range, 
             xlab = "Year", ylab = expression('PM'[2.5]*' in Kilotons'),
             main = expression('Annual Emission PM'[2.5]*' from 1999 to 2008')))
dev.off()