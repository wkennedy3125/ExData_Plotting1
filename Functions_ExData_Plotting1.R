# Functions_ExData_Plotting.R
# Exploratory Data Analysis: Project 1
#
# Author: William Kennedy
# Date: February 2015
##############################################################################
# Description:
#    Shared functions for Project 1
#    
##############################################################################
# System Information
##############################################################################
# For this project:
# R.Version()$platform
# [1] "x86_64-apple-darwin13.4.0"
# R.Version()$version.string
# [1] "R version 3.1.2 (2014-10-31)"
# RStudio Version 0.98.1091
# 
##############################################################################
# Load Package dependencies
##############################################################################
# I've found data.table is more efficient than other data handling packages
LoadPackageDependencies <- function(){
        if(!"data.table" %in% installed.packages())install.packages("data.table")
        library(data.table) # for fread()
}

SetDataFileInformation <- function(){
        # include relative (to wd) or absolute path
        file1 <- "./data/household_power_consumption.txt"
        # if need to download
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        # Since dealing with a zip file
        zipName <- "./data/household_power_consumption.zip"
        exDir <- "./data" # NOTE: if data were in wd, could omit this
        files <- list("file1"=file1,
                      "fileURL"=fileURL,
                      "zipName"=zipName,
                      "exDir"=exDir)
        return(files)
}

# This function 'should' be platform independent
CheckForGetDataFile <- function(file1, fileURL, zipName, exDir){
        print("Checking for data file....")
        if(file.exists(file1)){ 
                print("File available. Moving on....")
                
        }else{ 
                print("File not available. Downloading now....")
                method <- switch(Sys.info()[['sysname']],
                                 "windows" = "internal",
                                 "mac" = "curl",
                                 "linux" = "wget",
                                 "other" = "auto")
                download.file(fileURL, destfile = zipName, method)
                unzip(zipName, exdir = exDir)
        }
}

LoadData <- function(){
        system.time({ 
        # NOTE: grep/ggrep only works on unix variants, so my `switch` above 
        #       is only partially helpful currently. There is a windows
        #       equivalent to grep. 
        # NOTE2: ggrep is 'gnu grep'. If you haven't installed, just use grep
        #        ggrep is MUCH faster than grep on mac osx
        data <- fread("ggrep -E '^Date|^[1,2]/2/2007' ./data/household_power_consumption.txt", na.strings="?",
                      stringsAsFactors=FALSE, header=TRUE)
                })
        return(data)
}

ProcessData <- function(data){
        print("Processing data. Please wait....")
        # Add single timestamp for simplification
        data[, TimeStamp := as.POSIXct(strptime(paste(Date,Time), format = "%d/%m/%Y %H:%M:%S"))]
        
        # Make numeric for graphing
        data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
        data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))
        data$Voltage <- as.numeric(as.character(data$Voltage))
        data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
        data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
        data$Sub_metering_3 <- as.numeric(as.character(data$Sub_metering_3))
        return(data)
}

