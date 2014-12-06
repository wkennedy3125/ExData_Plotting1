# Plot2.R
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
setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Projects/Project1/ExData_Plotting1")
library(dplyr) # for filter()
library(data.table) # for fread()
# Read in full data set (after confirming size and requirements)
# NOTE: may need to reduce prior to reading in using grep,sed,awk,etc
#       In this case not needed
data_full <- fread("./data/household_power_consumption.txt", na.strings="?",
                   stringsAsFactors=FALSE)
# Subset data by Date
data <- filter(data_full, grep("^[1,2]/2/2007", Date))

# Add single timestamp for simplification
data[, TimeStamp := as.POSIXct(strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))]

# Make numeric for graphing
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Plot timeseries of Global Active Power
plot(data$TimeStamp,data$Global_active_power,main="Global Active Power",
     xlab="Day",ylab="Global Active Power (kilowatts)",type="l")


# Copy Plot to a PNG file
dev.copy(png, file = "Plot2.png")  
dev.off()
