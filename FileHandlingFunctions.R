# FileHandlingFunctions.R

# Author: William Kennedy
# Date: December 2014
##############################################################################
# Description:
#    Useful and reusable functions for:
#           1. Checking file/data availability
#           2. Download files if not available
#               (Need to do this in .Rmd)
##############################################################################

# Will check if 'file' is in the current working directory
# fileDir is relative to working directory

IsThisFileAvailable <- function(file, fileDir=NULL) {
        if (!is.null(data)){
                file <- paste( "./", fileDir, "/", file, sep="")
        }
        if (!file.exists(file)) {
                stop("This script requires the file: ", file," 
  Please check or set the working directory.")
        }
        else {
                msg <- paste("The file", file, "is available.")
                print(msg)
        }
}

GetThisFile <- function(getThisFile, fileURL, nameItThis, putItHere) {
        stop("UNDER CONSTRUCTION")
        if (!file.exists(nameItThis)) {
                #for windows
                #download.file(fileURL, destfile = "UCI HAR Dataset.zip", mode = "wb")
                # for mac
                download.file(fileURL, destfile = nameItThis, method = "curl")
                if("check for .zip") {
                        unzip(nameItThis,exdir=getwd())
                }
                
        }
}

SomeFunctionForCheckingSizeAndMemoryRequirements <- function() {
        stop("UNDER CONSTRUCTION")
}


# # jjmacky - some good ideas to consider
# getData = function(fileURL, mainDir, subDir, rawFilePath, OS = NULL) {
#         # If the data doesn't exist download it and setup a folder to store it
#         if (!file.exists(subDir)) {
#                 print("Downloading data and creating file directory...")
#                 method = switch(tolower(OS),
#                                 "windows" = "internal",
#                                 "mac" = "curl",
#                                 "lynx" = "wget",
#                                 "auto")
#                 download.file(fileURL, destfile = rawFilePath, method)
#                 dir.create(file.path(mainDir, subDir), showWarnings = FALSE)
#                 unzip(rawFile, exdir = subDir)
#         }
#         else {
#                 print("Files already download. Ready to read into R memory.")
#         }
# }
