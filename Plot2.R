# Plot2.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: January 2014
##############################################################################
# Description:
#    Timeseries of 'Global Active Power'
#    from 2007-02-01 to 2007-02-02
##############################################################################

##############################################################################
# READ DATA
setwd("/Users/adakemia/Documents/Academic/Coursera/DataScienceSpecialization/04ExploratoryDataAnalysis/Projects/Project1/ExData_Plotting1")

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

# Plot timeseries of Global Active Power
plot(data$TimeStamp,data$Global_active_power,main="Global Active Power",
     xlab="Day",ylab="Global Active Power (kilowatts)",type="l")


# Copy Plot to a PNG file
dev.copy(png, file = "Plot2.png")  
dev.off()
