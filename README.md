#     Getting and Cleaning Data Course Project
###          Author: Sandra Zimmerman
###          Date: December 22, 2017

#### *****************************************************************************************************************

**Synopsis of smartphone study:** Each of 30 subjects performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear accelerations and 3-axial angular velocities were captured at a constant rate of 50Hz. 70% of the volunteers were selected for generating the training data and 30% the test data. The signals were normalized, resulting in unitless values between -1 and +1.

A full description can be found at the following website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and in the **features_info.txt** file included in the downloaded files.

The **codebook** for this assignment provides a description of the selected variables, their definitions, and transformations performed for the course assingment.

**Program:**          run_analysis.R 

**Purpose:**     Prepare a tidy data set from Human Activity Recognition (HAR) data 
             collected from the Samsung Galaxy S smartphone acceleromenters by performing the following steps:

1. Download data (see file list with descriptions under "**Inputs**" below)
2. Read the data into R
3. Merge training and test data, subject IDs, and activity categories into one data set
4. Extract only the measurements on the mean and standard deviation for each measurement. 
3. Assign descriptive activity names to name the activities in the data set
4. Label the data set with descriptive variable names 
5. From the data set in step 4, create a second tidy data set with the average of each variable for each activity and each subject.
 
**Inputs:**      Smart Phone HAR data in zip file downloadable from:
"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

*Files included in the above zipfile:*
 
 * x_test.txt (measurement data for test subjects)
 * x_train.txt (measurement data for training subjects)
 * subject_test.txt (subject IDs for testing dataset)
 * subject_train.txt (subject IDs for training dataset)
 * features.txt (names for each type of measurement)

**Output:**  	Tidy data set stored in **tidydata.txt**


**View the tidy data set:**

To view the tidy data set, save tidydata.txt to your working directory and use the following code:

```{r}
tidydata <- read.table("tidydata.txt", header = TRUE)
View(tidydata)
```

Note that you will need to have the packages dplyr, data.table, reshape2, and tidyr installed

#### ****************************************************************************************************************

## Detailed description of R script:

#### Load libraries

```{r}library(dplyr)
library(data.table)
library(reshape2)
library(tidyr)
```

#### Download and unzip the files if they have not already been downloaded

```{r}
if(!file.exists("UCI HAR Dataset")){
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        outfile <- "data.zip"
        download.file(fileUrl, destfile = outfile)
        unzip(outfile)
}
```

#### Read data in text files into data tables 

```{r}
     file_path <- file.path("UCI HAR Dataset")

     testx <- fread(file.path(file_path, "test" , "X_test.txt" ))
     testy <- fread(file.path(file_path, "test" , "y_test.txt" ))

     testsubjects <- fread(file.path(file_path, "test" , "subject_test.txt" ))

     trainx <- fread(file.path(file_path, "train" , "X_train.txt" ))
     trainy <- fread(file.path(file_path, "train" , "y_train.txt" ))

     trainsubjects <- fread(file.path(file_path, "train" , "subject_train.txt" ))

     feature_vars <- fread(file.path(file_path, "features.txt" ))
     activity_labels <- fread(file.path(file_path, "activity_labels.txt" ))
```

#### Merge the training and the test sets to create one data set (part 1 of assignment).

```{r}
     datadf <- bind_rows(testx, trainx)
     activitydf <- bind_rows(testy,trainy)
     subjectsdf <- bind_rows(testsubjects, trainsubjects)
```

#### Add the variable names for the columns in the data table (part of part 4 of assignment)

```{r}
     names(datadf) <- feature_vars$V2
     names(activitydf) <- "activity"
     names(subjectsdf) <- "subject"
```

#### Merge subjects, activity and measurement data (part 1 of assignment)

```{r}
     mergedf <- bind_cols(subjectsdf, activitydf, datadf)
```

#### Extract only the measurements on the mean() and stdk() (standard deviation) for each measurement (part 2 of assignment)

```{r}
     mean_std <- grep("mean\\(|std\\(", tolower(names(mergedf)))

     mergedf <- select(mergedf, "subject", "activity", mean_std)
```

#### Use descriptive activity names to name the activities in the data set (part 3 of assignment)

```{r}
     activity_labels$V2 <- activity_labels$V2 %>%
                           {sub("WALKING", "Walking", .)} %>%
                           {sub("_UPSTAIRS", "Upstairs", .)} %>%
                           {sub("_DOWNSTAIRS", "Downstairs", .)} %>%
                           {sub("SITTING", "Sitting", .)} %>%
                           {sub("STANDING", "Standing", .)} %>%
                           {sub("LAYING", "Laying", .)} %>%
                            factor()

                   mergedf$activity <- activity_labels$V2[mergedf$activity]
```

#### Appropriately label the data set with descriptive variable names (part 4 of assignment)

```{r}
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
```

#### Make the tidy data set (part 5 of assignment):

#####*Steps*:
1. Use the melt function to make a narrow data format
2. Group data by the variables "subject", "activity", and "measurementtype"
3. Calculate mean (call it "measurementaverage") of each measurement type per activity per subject
4. Use the spread function to change back to wide data format
    
```{r}
tidydata <-   mergedf %>%
                melt(id = c("subject", "activity")) %>%
                group_by(subject, activity, measurementtype = variable) %>%
                summarize(measurementaverage = mean(value)) %>%
                spread(measurementtype, measurementaverage)
```

#### Write the tidy data set to a space delimited text file stored in "tidydata.txt"

```{r}
write.table(tidydata, file = "tidydata.txt", row.names = FALSE)
View(tidydata)
```

