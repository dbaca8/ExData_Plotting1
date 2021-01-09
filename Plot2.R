### Exploratory Data Analysis 
## Week 1 Project
## Plot 2

## 1. Download file household_power_consumption.txt
## 2. Subset the data taken over 2 days: 2007-02-01 and 2007-02-02
## 3. Create plot of Global_active_power vs. time

library(lubridate)

## Directory commands
getwd()
setwd("~/Desktop") 

## Checking and Create Directory "data" if one does not exist
if(!file.exists("data")){
        dir.create("data")
}

## Download Dataset.zip from Web
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip "
zipfilepath <- "./data/exdata_data_household_power_consumption.zip"
download.file(fileUrl, destfile = zipfilepath) 


## unzip Data Set
unzip(zipfilepath, exdir="~/Desktop/data")

list.files("~/Desktop/data")
# [1] "exdata_data_household_power_consumption.zip" "household_power_consumption.txt" 

filepath <- "~/Desktop/data/household_power_consumption.txt"

## Record date of downloaded file
dateDownloaded <- date()
dateDownloaded
# [1] "Fri Jan  8 20:32:54 2021"

## Reading Data Frame
data <- read.table(filepath, sep=";", header=TRUE, stringsAsFactors=FALSE)
str(data)
# 'data.frame':	2075259 obs. of  9 variables:
# $ Date                 : chr  "16/12/2006" "16/12/2006" "16/12/2006" "16/12/2006" ...
# $ Time                 : chr  "17:24:00" "17:25:00" "17:26:00" "17:27:00" ...
# $ Global_active_power  : chr  "4.216" "5.360" "5.374" "5.388" ...
# $ Global_reactive_power: chr  "0.418" "0.436" "0.498" "0.502" ...
# $ Voltage              : chr  "234.840" "233.630" "233.290" "233.740" ...
# $ Global_intensity     : chr  "18.400" "23.000" "23.000" "23.000" ...
# $ Sub_metering_1       : chr  "0.000" "0.000" "0.000" "0.000" ...
# $ Sub_metering_2       : chr  "1.000" "1.000" "2.000" "1.000" ...
# $ Sub_metering_3       : num  17 16 17 17 17 17 17 17 17 16 ...

dim(data)
# [1] 2075259     9

## Create column in table with date and time merged together
Date_Time <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data <- cbind(data, Date_Time)

## Convert classes of all columns to correct class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$Time <- format(data$Time, format="%H:%M:%S")
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Voltage <- as.numeric(data$Voltage)
data$Global_intensity <- as.numeric(data$Global_intensity)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)

## Subset data from 2007-02-01 and 2007-02-02
datasub <- subset(data, Date >= "2007-02-01" & Date <= "2007-02-02")
str(datasub)
# 'data.frame':	2880 obs. of  10 variables:
# $ Date                 : Date, format: "2007-02-01" "2007-02-01" "2007-02-01" ...
# $ Time                 : chr  "00:00:00" "00:01:00" "00:02:00" "00:03:00" ...
# $ Global_active_power  : num  0.326 0.326 0.324 0.324 0.322 0.32 0.32 0.32 0.32 0.236 ...
# $ Global_reactive_power: num  0.128 0.13 0.132 0.134 0.13 0.126 0.126 0.126 0.128 0 ...
# $ Voltage              : num  243 243 244 244 243 ...
# $ Global_intensity     : num  1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1.4 1 ...
# $ Sub_metering_1       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Sub_metering_2       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Sub_metering_3       : num  0 0 0 0 0 0 0 0 0 0 ...
# $ Date_Time            : POSIXct, format: "2007-02-01 00:00:00" "2007-02-01 00:01:00" "2007-02-01 00:02:00" ...
dim(datasub)
# [1] 2880   10

## png Plot of Global_active_power vs Date_Time for those 2 days
png("plot2.png", width=480, height=480)
with(datasub, plot(Date_Time, Global_active_power, type="l", xlab="Day", ylab="Global Active Power (kilowatts)"))
dev.off()
