# Plot2.R
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
# or Windows equivalent
data <- LoadData()

# Updates a few data types for graphing
data <- ProcessData(data)

##############################################################################
# MAIN - Plot2.R
##############################################################################

png(filename="Plot2.png", width=480, height=480, units="px", pointsize=12,
    bg="white")

# Plot timeseries of Global Active Power
plot(data$TimeStamp,data$Global_active_power,main="Global Active Power",
     xlab="Day",ylab="Global Active Power (kilowatts)",type="l")
  
dev.off()
