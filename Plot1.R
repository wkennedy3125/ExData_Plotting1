# Plot1.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: December 2014
##############################################################################
# Description:
#    Histogram of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02
##############################################################################
# Package dependencies
##############################################################################
library(dplyr) # for filter()
library(data.table) # for fread()
##############################################################################
# Source file and function dependencies
##############################################################################
# IsThisFileAvailable(file, fileDir=NULL<optional>)
#          NOTE: fileDir is RELATIVE to WORKING DIRECTORY
source("./FileHandlingFunctions.R")
##############################################################################
# File / data dependencies
##############################################################################
file1 <- "household_power_consumption.txt"
# Data directory: where the files / data are located relative to 
# working directory (i.e., the data subdirectory)
dataDir <- "data"
##############################################################################
# MAIN 
##############################################################################
# Set working directory
#setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Projects/Project1/ExData_Plotting1")
#list.files("../")

# Check if file exists in the working directory
#-------------------------
IsThisFileAvailable(file1, fileDir)

# Read data
#-------------------------

# Read in full data set (after confirming size and requirements)
# NOTE: may need to reduce prior to reading in using grep,sed,awk,etc
#       In this case, on my current machine, not needed
data_full <- fread("./data/household_power_consumption.txt", na.strings="?",
            stringsAsFactors=FALSE)
#dim(data_full)
# Subset data by Date using dplyr
data <- filter(data_full, grep("^[1,2]/2/2007", Date))
#dim(data)
# OR subset using data.table (better probably)
# (will add this later)

# OR subset prior to importing (best but need to get first line so needs work)
#system("egrep '^household|^[1,2]/2/2007' ./data/household_power_consumption.txt > ./data/household_power_consumption_subset.txt")
#data <- fread("./data/household_power_consumption_subset.txt", na.strings="?",
#                   stringsAsFactors=FALSE, header=TRUE)
#dim(data)
#str(data)
# Data cleaning
#---------------------------
# Make numeric for graphing
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Plot data
#---------------------------
# Plot a histogram of Global Active Power
hist(data$Global_active_power,breaks=12,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")

# Copy Plot1 to a PNG file
#---------------------------
dev.copy(png, file = "Plot1.png")  
dev.off()


