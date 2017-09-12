library(dplyr)
library(RColorBrewer)
library(ggplot2)


if(!file.exists("E:/R/Exploratory Data Analysis/Assignment")){dir.create("E:/R/Exploratory Data Analysis/Assignment")}
url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip",method="auto") 
unzip ("E:/R/Exploratory Data Analysis/Assignment/Data_for_Peer Assessment.zip", exdir = "E:/R/Exploratory Data Analysis/Assignment")


NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
NEISCC <- merge(NEI, SCC, by="SCC")

head(NEI)
str(NEI)

motorVehicle<- grepl("motor vehicle", NEISCC$Short.Name, ignore.case=TRUE)
newdata <- NEISCC[motorVehicle, ]
str(newdata)

NEISCC_BALTIMORE<-filter(NEI,fips =="24510")
data<-summarize(group_by(NEISCC_BALTIMORE,year), Emissions = mean(Emissions, na.rm = TRUE))

plot5<-barplot(height=data$Emissions,names.arg=data$year,col=cm.colors(4),ylim=c(0,12.00))
title(main = "Total PM2.5 emission (tons) in Baltimore City \n from motor vehicle sources, per year.",xlab="Years", ylab="Total PM2.5 emission (tons)")

dev.copy(png, file="plot5.png")
dev.off()
