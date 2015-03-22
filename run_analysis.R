#!/usr/bin/Rscript

##-------------------------------------------------------------
## The script was created by Kirill Blinichkin at 22.03.2015  |
##                                                            |
## This script should be located in "UCI HAR Dataset" folder  |                                                   
##-------------------------------------------------------------

tempWd <- getwd()
setwd("./")

if(!file.exists("tidy_data/uci_har_dataset.txt")) {
  dir.create("tidy_data")
}

## Loading the test and train data

test.X <- read.table("test/X_test.txt")
test.labels <- read.table("test/y_test.txt")
test.subjects <- read.table("test/subject_test.txt")

train.X <- read.table("train/X_train.txt")
train.labels <- read.table("train/y_train.txt")
train.subjects <- read.table("train/subject_train.txt")

## Loading features

features <- read.table("features.txt")
activityLabels <- read.table("activity_labels.txt")

## Merge data by row

merge.X <- rbind(test.X, train.X)
merge.labels <- rbind(test.labels, train.labels)
merge.subjects <- rbind(test.subjects, train.subjects)

## Extract mean and stangard deviation mesurements

merge.meanAndStd <- merge.X[,which(grepl(".-std[(].|.-mean[(].", features[, 2], perl=TRUE))]
merge.labelNames <- as.data.frame(activityLabels[merge.labels$V1, 2])

## Set the variables' names

colnames(merge.meanAndStd) <- features[which(grepl(".-std[(].|.-mean[(].", features[, 2], perl=TRUE)), 2]
colnames(merge.labelNames) <- "activityLabels"
colnames(merge.subjects) <- "subjects"

## Merge all data to one data set

merge <- cbind(merge.meanAndStd, merge.labelNames, merge.subjects)

## Extract mean of variables for every activity lable

lapply(activityLabels, function(label) {
  merge[which(merge$activityLabels == label),]
  
  ## didn't end...
  
})

## Save data to uci_har_dataset.txt file

write.table(merge, file = "tidy_data/uci_har_dataset.txt", row.name=FALSE)

setwd(tempWd)