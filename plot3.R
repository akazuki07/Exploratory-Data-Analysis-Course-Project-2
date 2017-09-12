library(dplyr)
library(RColorBrewer)
library(ggplot2)


if(!file.exists("E:/R/Exploratory Data Analysis/Assignment")){dir.create("E:/R/Exploratory Data Analysis/Assignment")}
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip",method="auto") 
unzip ("E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip", exdir = "E:/R/Exploratory Data Analysis/Assignment")


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

head(NEI)
str(NEI)

NEI_BALTIMORE<-filter(NEI,fips =="24510")
str(NEI_BALTIMORE)

data<-summarize(group_by(NEI_BALTIMORE, type,year), Emissions = mean(Emissions, na.rm = TRUE))
data

ggplot(data, aes(factor(year),Emissions), y=Emissions) +
    geom_bar(stat="identity",aes(fill = type))+
 	facet_grid(. ~ type)+
		labs(title = "Total PM2.5 emission (tons) in Baltimore City, by various source types.")+ 
		labs(x = "Years", y = "Total PM2.5 emission (tons)")

dev.copy(png, file="plot3.png")
dev.off()

##qplot(year,Emissions, data = data, facets =  type ~.)   