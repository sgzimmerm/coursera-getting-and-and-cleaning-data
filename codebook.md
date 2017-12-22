#Codebook for tidydata data set
##           Getting and Cleaning Data Course Project
###          Author: Sandra Zimmerman
###          Date: December 22, 2017
#
####*********************************************************************************************************************************************************

**Synopsis of smartphone study:** Each of 30 subjects performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear accelerations and 3-axial angular velocities were captured at a constant rate of 50Hz. 70% of the volunteers were selected for generating the training data and 30% the test data. The signals were normalized, resulting in unitless values between -1 and +1.

A full description can be found at the following website:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
and in the **features_info.txt** file included in the downloaded files.

The **README.txt** for this assignment provides a description of the R script that creates the tidydata data set described in this codebook.

####*********************************************************************************************************************************************************




####**Description of original data - the description below is reproduced from the features_info.txt**


The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain 
Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were 
calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag<table>

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

####*********************************************************************************************************************************************************


####**Extraction of mean() and std() data**

Only the 66 **mean()** and **std()**: standard deviation data were extracted for this assignment. The five additional variables (gravityMean, tBodyAccMean, etc) are used in calculating the angle() variable and were not extracted for this assignment.

####*********************************************************************************************************************************************************


####**Units**

The measurements for each of the mean and std observation were normalized. These values are unitless and range between -1 and +1.

####*********************************************************************************************************************************************************


####**Description of variables, locations (column numbers), definitions and changes made to variable and factor names**

===============================================================================================================================

**Variable name:** subject

**Location:** 1

**Storage mode:** integer
   
   There are 30 subjects, numbered 1-30
   
===============================================================================================================================
**Variable name:** activity

**Location:** 2

**Storage mode:** integer
   
   Factor with 6 levels
   
   The names for each level (category) were changed as follows:
   
|Original Name     |New tidydata Data Set Name|
|------------------|--------------------------|
|LAYING            |Laying                    |
|SITTING           |Sitting                   |
|STANDING          |Standing                  |
|WALKING           |Walking                   |
|WALKING_DOWNSTAIRS|WalkingDownstairs         |
|WALKING_UPSTAIRS  |WalkingUpstairs           |

===============================================================================================================================

**Variable name: See Table 1 below**

**Storage mode:**
double

There are 66 feature variables shown in Table 1. The names were changed to make them more descriptive by spelling out the parts of the name and to make them more amenable to downstream analyses by making them all lower case and removing special characters. 

These variables each represent the averages of the means and standard deviations of time or frequency domain measurements of various types of movements recorded by motion sensors in a Samsung Galaxie phone worn by a subject while engaged in a category of activity (sitting, standing, walking, walking downstairs, or walking upstairs). 

**Note that these are means of means and means of standard deviations of these measurements.**

**(see Table 2 for definitions of the variables)**

**Table 1: Locations (column numbers) of variables, and transformations made to variable names. See Table 2 below for definitions of the components of the variable names.**

|Location       |Original variable name in features.txt         |tidydata data set variable name                        |
|---------------|-----------------------------------------------|-------------------------------------------------------|
|	3	|	tBodyAcc-mean()-X               	|	timebodyaccelerometermeanx			|
|	4	|	tBodyAcc-mean()-Y       		|	timebodyaccelerometermeany			|
|	5	|	tBodyAcc-mean()-Z       		|	timebodyaccelerometermeanz			|
|	6	|	tBodyAcc-std()-X       		       	|	timebodyaccelerometersdx			|
|	7	|	tBodyAcc-std()-Y	       	       	|	timebodyaccelerometersdy			|
|	8	|	tBodyAcc-std()-Z	        	|	timebodyaccelerometersdz			|
|	9	|	tGravityAcc-mean()-X	        	|	timegravityaccelerometermeanx			|
|	10	|	tGravityAcc-mean()-Y	       	        |	timegravityaccelerometermeany			|
|	11	|	tGravityAcc-mean()-Z       		|	timegravityaccelerometermeanz			|
|	12	|	tGravityAcc-std()-X       		|	timegravityaccelerometersdx			|
|	13	|	tGravityAcc-std()-Y	       	       	|	timegravityaccelerometersdy			|
|	14	|	tGravityAcc-std()-Z	       	       	|	timegravityaccelerometersdz			|
|	15	|	tBodyAccJerk-mean()-X	       	       	|	timebodyaccelerometerjerkmeanx			|
|	16	|	tBodyAccJerk-mean()-Y	       	       	|	timebodyaccelerometerjerkmeany			|
|	17	|	tBodyAccJerk-mean()-Z       		|	timebodyaccelerometerjerkmeanz			|
|	18	|	tBodyAccJerk-std()-X	       	       	|	timebodyaccelerometerjerksdx			|
|	19	|	tBodyAccJerk-std()-Y	       	       	|	timebodyaccelerometerjerksdy			|
|	20	|	tBodyAccJerk-std()-Z	       	       	|	timebodyaccelerometerjerksdz			|
|	21	|	tBodyGyro-mean()-X       	       	|	timebodygyroscopemeanx			       	|
|	22	|	tBodyGyro-mean()-Y       	    	|	timebodygyroscopemeany		       		|
|	23	|	tBodyGyro-mean()-Z       	       	|	timebodygyroscopemeanz			       	|
|	24	|	tBodyGyro-std()-X       	     	|	timebodygyroscopesdx			       	|
|	25	|	tBodyGyro-std()-Y       	      	|	timebodygyroscopesdy		       		|
|	26	|	tBodyGyro-std()-Z       	       	|	timebodygyroscopesdz		       		|
|	27	|	tBodyGyroJerk-mean()-X       	       	|	timebodygyroscopejerkmeanx			|
|	28	|	tBodyGyroJerk-mean()-Y	       	       	|	timebodygyroscopejerkmeany			|
|	29	|	tBodyGyroJerk-mean()-Z	       	       	|	timebodygyroscopejerkmeanz			|
|	30	|	tBodyGyroJerk-std()-X	       	       	|	timebodygyroscopejerksdx			|
|	31	|	tBodyGyroJerk-std()-Y	       	       	|	timebodygyroscopejerksdy			|
|	32	|	tBodyGyroJerk-std()-Z	       	       	|	timebodygyroscopejerksdz			|
|	33	|	tBodyAccMag-mean()	       	       	|	timebodyaccelerometermagnitudemean		|
|	34	|	tBodyAccMag-std()	       	       	|	timebodyaccelerometermagnitudesd		|
|	35	|	tGravityAccMag-mean()	       	       	|	timegravityaccelerometermagnitudemean		|
|	36	|	tGravityAccMag-std()	       	       	|	timegravityaccelerometermagnitudesd		|
|	37	|	tBodyAccJerkMag-mean()	       	       	|	timebodyaccelerometerjerkmagnitudemean		|
|	38	|	tBodyAccJerkMag-std()	       	       	|	timebodyaccelerometerjerkmagnitudesd		|
|	39	|	tBodyGyroMag-mean()	       	       	|	timebodygyroscopemagnitudemean			|
|	40	|	tBodyGyroMag-std()	       	       	|	timebodygyroscopemagnitudesd			|
|	41	|	tBodyGyroJerkMag-mean()	       	       	|	timebodygyroscopejerkmagnitudemean		|
|	42	|	tBodyGyroJerkMag-std()	       	       	|	timebodygyroscopejerkmagnitudesd		|
|	43	|	fBodyAcc-mean()-X	       	       	|	frequencybodyaccelerometermeanx			|
|	44	|	fBodyAcc-mean()-Y	       	       	|	frequencybodyaccelerometermeany			|
|	45	|	fBodyAcc-mean()-Z	       	       	|	frequencybodyaccelerometermeanz			|
|	46	|	fBodyAcc-std()-X	       	       	|	frequencybodyaccelerometersdx			|
|	47	|	fBodyAcc-std()-Y	       	       	|	frequencybodyaccelerometersdy			|
|	48	|	fBodyAcc-std()-Z	       	       	|	frequencybodyaccelerometersdz			|
|	49	|	fBodyAccJerk-mean()-X	       	       	|	frequencybodyaccelerometerjerkmeanx		|
|	50	|	fBodyAccJerk-mean()-Y	       	       	|	frequencybodyaccelerometerjerkmeany		|
|	51	|	fBodyAccJerk-mean()-Z	       	       	|	frequencybodyaccelerometerjerkmeanz		|
|	52	|	fBodyAccJerk-std()-X	       	       	|	frequencybodyaccelerometerjerksdx		|
|	53	|	fBodyAccJerk-std()-Y	       	       	|	frequencybodyaccelerometerjerksdy		|
|	54	|	fBodyAccJerk-std()-Z	       	       	|	frequencybodyaccelerometerjerksdz		|
|	55	|	fBodyGyro-mean()-X	       	       	|	frequencybodygyroscopemeanx			|
|	56	|	fBodyGyro-mean()-Y	       	       	|	frequencybodygyroscopemeany			|
|	57	|	fBodyGyro-mean()-Z	       	       	|	frequencybodygyroscopemeanz			|
|	58	|	fBodyGyro-std()-X	       	       	|	frequencybodygyroscopesdx			|
|	59	|	fBodyGyro-std()-Y	       	       	|	frequencybodygyroscopesdy			|
|	60	|	fBodyGyro-std()-Z	       	       	|	frequencybodygyroscopesdz			|
|	61	|	fBodyAccMag-mean()	       	       	|	frequencybodyaccelerometermagnitudemean		|
|	62	|	fBodyAccMag-std()	       	       	|	frequencybodyaccelerometermagnitudesd		|
|	63	|	fBodyBodyAccJerkMag-mean()	       	|	frequencybodyaccelerometerjerkmagnitudemean	|
|	64	|	fBodyBodyAccJerkMag-std()       	|	frequencybodyaccelerometerjerkmagnitudesd	|
|	65	|	fBodyBodyGyroMag-mean()	       	       	|	frequencybodygyroscopemagnitudemean		|
|	66	|	fBodyBodyGyroMag-std()	       	       	|	frequencybodygyroscopemagnitudesd		|
|	67	|	fBodyBodyGyroJerkMag-mean()	       	|	frequencybodygyroscopejerkmagnitudemean		|
|	68	|	fBodyBodyGyroJerkMag-std()	       	|	frequencybodygyroscopejerkmagnitudesd		|

===============================================================================================================================

**Table 2: Definitions of components of variable names.**

|term          |definition                                                                                                    |
|--------------|--------------------------------------------------------------------------------------------------------------|
|time	       |time domain                                                                                                   |
|frequency     |frequency domain                                                                                              |
|body          |body component of acceleration       	                                                                      |
|gravity       |gravity component of acceleration                                                                             |
|accelerometer |measures the rate of change of linear velocity                                                                |
|gyroscope     |measures angular velocity (tilt or rotational velocity)                                     |
|jerk          |rate of change of acceleration                                                                                |
|magnitude     |magnitude component of a vector representing a type of directional movement in 3-D space                      |
|x, y, or z    |components of the direction of movement in the x, y, or z directions                                          |
|mean          |average of a sample of observations (measurements) for a subject engaging in a category of activity           |
|sd            |standard deviation of a sample of observations (measurements) for a subject engaging in a category of activity|


**Examples:**

timebodyaccelerometersdz = the average standard deviations of time domain signals of the z-direction component of body acceleration measured by the accelerometer motion sensor

frequencybodygyroscopemagnitudemean = the average means of frequency domain signals of the magnitude of angular acceleration of the body as measured by the gyroscope motion sensor

===============================================================================================================================


  