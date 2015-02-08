# Plot3.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: February 2015
##############################################################################
# Description:
#    Timeseries of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02
##############################################################################
# ENVIRONMENT SETUP
##############################################################################
# Set working directory
# Edit this information to match your system
setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Projects/Project1/ExData_Plotting1")

# The following file contains all shared functions for Plot[1-4].R
source("Functions_ExData_Plotting1.R")

# Package dependencies
LoadPackageDependencies()
##############################################################################
# DATA FILE PROCESSING
##############################################################################
# File / data dependencies
# Sets 'file1','fileURL','zipName', and 'exDir'
files <- SetDataFileInformation()

# Check if file exists, and download (and extract) if necessary
CheckForGetDataFile(files$file1, files$fileURL, files$zipName, files$exDir)

# Uses fread from data.table and 'ggrep'
# If you don't have ggrep installed, you can use grep
data <- LoadData()

# Updates a few data types for graphing
data <- ProcessData(data)

##############################################################################
# MAIN - Plot3.R
##############################################################################


# Plot Energy Sub-Metering
png(filename="Plot3.png", width=480, height=480, units="px", pointsize=12,
    bg="white")
par(mfrow = c(1,1), mar=c(4,4,4,4),oma=c(0,0,0,0))
plot(data$TimeStamp,data$Sub_metering_1,main="",
     xlab="",ylab="Energy sub metering",cex.lab=1,cex.axis=1,
     type="l")
lines(data$TimeStamp,data$Sub_metering_2, col="red")
lines(data$TimeStamp,data$Sub_metering_3, col="blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2",
                              "Sub_metering_3"),lty=1, 
       col=c("black", "red", "blue"), cex=1)

# close png device  
dev.off()


