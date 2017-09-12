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
str(NEI$type)
table(NEI$type)
head(SCC)
names(SCC)

NEISCC <- merge(NEI, SCC, by="SCC")

coal<- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
newdata <- NEISCC[coal, ]
head(newdata)

data<-summarize(group_by(newdata, year), Emissions = mean(Emissions, na.rm = TRUE))
data
plot4<-barplot(height=data$Emissions,names.arg=data$year,col=cm.colors(4),ylim=c(0,60.00))
title(main = "Total PM2.5 emission (tons) from coal, \n across the United States per year.",xlab="Years", ylab="Total PM2.5 emission (tons)")

dev.copy(png, file="plot4.png")
dev.off()