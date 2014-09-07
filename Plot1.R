

# Exploratory Data Analysis
# Project 1
# Plot1.R
# Description:
#    Histogram of 'Global Active Power'
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

# Make numeric for graphing
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Plot a histogram of Global Active Power
hist(data$Global_active_power,breaks=12,main="Global Active Power",
     xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")

# Copy Plot1 to a PNG file
dev.copy(png, file = "Plot1.png")  
dev.off()


