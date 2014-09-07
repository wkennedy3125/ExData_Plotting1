

# Exploratory Data Analysis
# Project 1
# Plot3.R
# Description:
#    Timeseries of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02

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
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))

# Plot timeseries of Global Active Power
par(mar=c(4,4,4,0),oma=c(0,0,0,8))
plot(data$TimeStamp,data$Sub_metering_1,main="",
     xlab="",ylab="Energy sub metering",cex.lab=.75,cex.axis=.75,
     type="l")
lines(data$TimeStamp,data$Sub_metering_2, col="red")
lines(data$TimeStamp,data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
                              "Sub_metering_3"),lty=1, 
       col=c("black", "red", "blue"), cex=.75,xjust=0,y.intersp=.8,
       x.intersp=.65)


# Copy Plot to a PNG file
dev.copy(png, pointsize=10, file = "Plot3.png")  
dev.off()
