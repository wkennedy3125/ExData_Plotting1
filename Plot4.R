# Plot4.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: December 2014
##############################################################################
# Description:
#    Timeseries of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02
##############################################################################
# READ DATA
setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Project1/ExData_Plotting1")
library(dplyr) # for filter()
library(data.table) # for fread()
# Read in full data set (after confirming size and requirements)
# NOTE: may need to reduce prior to reading in using grep,sed,awk,etc
#       In this case not needed
data_full <- fread("../household_power_consumption.txt", na.strings="?",
                   stringsAsFactors=FALSE)
# Subset data by Date
data <- filter(data_full, grep("^[1,2]/2/2007", Date))

# Add single timestamp for simplification
data[, TimeStamp := as.POSIXct(strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))]

# Make numeric for graphing
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
data$Voltage <- as.numeric(as.character(data$Voltage))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# Plot timeseries of Global Active Power
par(mfrow = c(2,2), mar=c(4,4,4,2), oma=c(0,0,0,6)) # 2 X 2 plotting pane
# Top left plot
plot(data$TimeStamp,data$Global_active_power,main="",
     xlab="",ylab="Global Active Power",type="l",cex.lab=.75,
     cex.axis=.75)
# Top right plot
plot(data$TimeStamp,data$Voltage,main="",
     xlab="datetime",ylab="Voltage",type="l",cex.lab=.75,
     cex.axis=.75)
# Bottom left plot
plot(data$TimeStamp,data$Sub_metering_1,main="",
     xlab="",ylab="Energy sub metering",cex.lab=.75,cex.axis=.75,
     type="l")
lines(data$TimeStamp,data$Sub_metering_2, col="red")
lines(data$TimeStamp,data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
                              "Sub_metering_3"),lty=1, 
       col=c("black", "red", "blue"), cex=.5,xjust=0,y.intersp=1,
       x.intersp=.75,bty="n")
# Bottom right plot
plot(data$TimeStamp,data$Global_reactive_power,main="",cex.lab=.75,
     cex.axis=.75,xlab="datetime",ylab="Global_reactive_power",type="l")


# Copy Plot to a PNG file
dev.copy(png, pointsize=10, file = "Plot4.png")  
dev.off()
