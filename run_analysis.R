#*******************************************************************************
#	Program:	run_analysis.R 
#
#	Purpose:	Prepare a tidy data set from Human Activity Recognition 
#                       (HAR) data collected from the Samsung Galaxy S 
#                       smartphone acceleromenters.
# 
#
#	Inputs:	        Smart Phone HAR data in zip file downloadable from:
#                       "https://d396qusza40orc.cloudfront.net/getdata%2Fproject
#                        files%2FUCI%20HAR%20Dataset.zip"
#			Includes data in x_test.txt, x_train.txt, 
#			  subject vector in subject_test.txt, subject_train.txt
#			  feature names in features.txt
#		
#	Outputs:  	Tidy data set stored in tidydata.txt	
#
#*******************************************************************************

#*******************************************************************************
# Load libraries
#*******************************************************************************

library(dplyr)
library(data.table)
library(reshape2)
library(tidyr)

#*******************************************************************************
# Download and unzip the files if they have not already been downloaded
#*******************************************************************************

outfile <- "./data/data.zip"
if(!file.exists(outfile)){
        if(!file.exists("./data")){dir.create("./data")}
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(fileUrl, destfile = outfile)
        unzip(outfile, exdir ="./data")
}

#*******************************************************************************
# Read data in text files into data tables 
#*******************************************************************************

file_path <- file.path("./data" , "UCI HAR Dataset")

testx <- fread(file.path(file_path, "test" , "X_test.txt" ))
testy <- fread(file.path(file_path, "test" , "y_test.txt" ))

testsubjects <- fread(file.path(file_path, "test" , "subject_test.txt" ))

trainx <- fread(file.path(file_path, "train" , "X_train.txt" ))
trainy <- fread(file.path(file_path, "train" , "y_train.txt" ))

trainsubjects <- fread(file.path(file_path, "train" , "subject_train.txt" ))

feature_vars <- fread(file.path(file_path, "features.txt" ))
activity_labels <- fread(file.path(file_path, "activity_labels.txt" ))

#*******************************************************************************
# Merge the training and the test sets to create one data set (part 1 of assignment).
#*******************************************************************************

datadf <- bind_rows(testx, trainx)
activitydf <- bind_rows(testy,trainy)
subjectsdf <- bind_rows(testsubjects, trainsubjects)

#*******************************************************************************
# Add the variable names for the columns in the data table (part of part 4 of assignment)
#*******************************************************************************

names(datadf) <- feature_vars$V2
names(activitydf) <- "activity"
names(subjectsdf) <- "subject"

#*******************************************************************************
# Merge subjects, activity and measurement data (part 1 of assignment)
#*******************************************************************************

mergedf <- bind_cols(subjectsdf, activitydf, datadf)

#*******************************************************************************
# Extract only the measurements on the mean() and stdk() (standard deviation) for each measurement (part 2 of assignment)
#*******************************************************************************

mean_std <- grep("mean\\(|std\\(", tolower(names(mergedf)))

mergedf <- select(mergedf, "subject", "activity", mean_std)

#*******************************************************************************
# Use descriptive activity names to name the activities in the data set 
# (part 3 of assignment)
#*******************************************************************************

       activity_labels$V2 <- activity_labels$V2 %>%
                             {sub("WALKING", "Walking", .)} %>%
                             {sub("_UPSTAIRS", "Upstairs", .)} %>%
                             {sub("_DOWNSTAIRS", "Downstairs", .)} %>%
                             {sub("SITTING", "Sitting", .)} %>%
                             {sub("STANDING", "Standing", .)} %>%
                             {sub("LAYING", "Laying", .)} %>%
                              factor()

       mergedf$activity <- activity_labels$V2[mergedf$activity]


#*******************************************************************************
# Appropriately label the data set with descriptive variable names 
# (part 4 of assignment)
#*******************************************************************************

names(mergedf) <- tolower(names(mergedf)) %>% 
                {sub("bodybody", "body", .)} %>%
                {sub("^t", "time", .)} %>%
                {sub("^f", "frequency", .)} %>%
                {sub("acc", "accelerometer", .)} %>%
                {sub("gyro", "gyroscope", .)} %>%
                {sub("mag", "magnitude", .)} %>%
                {sub("std", "sd", .)} %>%
                {sub("\\()", "", .)} %>%
                {gsub("-", "", .)}

#*******************************************************************************
# Make the tidy data set (part 5 of assignment).
# This will be in narrow format.
#*******************************************************************************

tidydata <-   mergedf %>%
                melt(id = c("subject", "activity")) %>%
                group_by(subject, activity, measurementtype = variable) %>%
                summarize(measurementaverage = mean(value)) %>%
                spread(measurementtype, measurementaverage)

#*******************************************************************************
# Write the tidy data set to a space delimited text file in "tidydata.txt"
#*******************************************************************************

write.table(tidydata, file = "tidydata.txt", row.names = FALSE)

View(tidydata)

