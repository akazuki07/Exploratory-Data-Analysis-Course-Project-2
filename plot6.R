library(dplyr)
library(RColorBrewer)
library(ggplot2)


if(!file.exists("E:/R/Exploratory Data Analysis/Assignment")){dir.create("E:/R/Exploratory Data Analysis/Assignment")}
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip",method="auto") 
unzip ("E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip", exdir = "E:/R/Exploratory Data Analysis/Assignment")


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

motorVehicle<- grepl("motor vehicle", NEISCC$Short.Name, ignore.case=TRUE)
newdata <- NEISCC[motorVehicle, ]
str(newdata)


NEISCC_B_LA<-filter(NEI,fips =="24510" | fips =="06037")
table(NEISCC_B_LA$fips)
data<-summarize(group_by(NEISCC_B_LA, fips,year), Emissions = mean(Emissions, na.rm = TRUE))
labels<-c("24510"="BALTIMORE (24510)", "06037"="LOS ANGELES (06037)")

ggplot(data, aes(factor(year),Emissions), y=Emissions) +
    geom_bar(stat="identity",aes(fill = fips))+
 	facet_grid(. ~ fips,labeller=labeller(fips=labels))+
		labs(title = "Total PM2.5 emission (tons) from motor vehicle sources \n in Los Angeles County and Baltimore City")+ 
		labs(x = "Years", y = "Total PM2.5 emission (tons)")
		

dev.copy(png, file="plot6.png")
dev.off()
