# Plot4.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: January 2014
##############################################################################
# Description:
#    Timeseries of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02
##############################################################################
# READ DATA
setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Project1/ExData_Plotting1")

library(data.table) # for fread()
##############################################################################
# File / data dependencies
##############################################################################
# include relative (to wd) or absolute path
file1 <- "./data/household_power_consumption.txt"
# if need to download
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# Since dealing with a zip file
zipName <- "./data/household_power_consumption.zip"
exDir <- "./data" # NOTE: if data were in wd, could omit this

# Check if file exists, and download (and extract) if necessary
# will eventually put this in a separate helper functions list
if(file.exists(file1)){ 
        print("File available. Moving on....")
        
}else{ 
        print("File not available. Downloading now....")
        method <- switch(tolower(OS), # code borrowed from jjmacky
                         "windows" = "internal",
                         "mac" = "curl",
                         "linux" = "wget",
                         "other" = "auto")
        download.file(fileURL, destfile = zipName, method)
        unzip(zipName, exdir = exDir)
}


##############################################################################
# MAIN 
##############################################################################

# READ AND SUBSET using data.table's fread
#-----------------------------
#system.time({ 
# NOTE: only works on unix variants, so my `switch` above is only partially 
# helpful currently
data <- fread("ggrep -e '^Date' -e '^[1,2]/2/2007' ./data/household_power_consumption.txt", na.strings="?",
              stringsAsFactors=FALSE, header=TRUE)
#        })

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
png(filename="Plot4.png", width=480, height=480, units="px", pointsize=12,
    bg="white")
par(mfrow = c(2,2), mar=c(4,4,4,1), oma=c(0,0,0,0)) # 2 X 2 plotting pane
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
#dev.copy(png, pointsize=10, file = "Plot4.png")  
dev.off()
