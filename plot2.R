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



years <- group_by(filter(NEI,fips =="24510"), year)
str(years)
head(years)

data
data<-summarize(years, Emissions = mean(Emissions, na.rm = TRUE))
plot2<-barplot(height=data$Emissions,names.arg=data$year,col=rainbow(4),ylim=c(0,11.00))
title(main = "Total PM2.5 emission (tons) in Baltimore City,\n Maryland per Year",xlab="Years", ylab="Total PM2.5 emission (tons)")
text(x = plot2, y = round(data$Emissions,3), label = round(data$Emissions,3), pos = 3, cex = 0.8, col = "black")

dev.copy(png, file="plot2.png")
dev.off()