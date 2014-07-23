'Getting and Cleaning Data' Course Project
==========================================

Study design
------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured. The experiments have been video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See next section for more details. 


Code book
---------

subject

  Id of the participant on the experiment. There are a total of 30 participants.
  
activity

  

  The following variables in the tidy dataset correspond to the mean of the mean values ('mean') and standard deviation values ('stdev') of the raw measurements.
  These measurements comprise the time domain signals ('time') and frequency ('frequency') of the accelerometer ('acc') and gyroscope ('gyro'), separated in a 3-axial system (axis X, Y, and Z). The acceleration signal was separated into body ('body') and gravity acceleration signals ('gravity').
  Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals ('jerk'). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm ('mag').
  
  Then, these variables are named accordingly to these blocks:

+ Statistic -> mean ('mean') or standard deviation ('stdev')
+ Type of signal -> 'time' or 'frequency'
+ Source of acceleration -> 'body' or 'gravity'
+ Device -> accelerometer ('acc') or gyroscope ('gyro')
+ Jerk signal -> 'jerk'
+ Normalised magnitude -> 'mag'
+ Axis -> 'x', 'y', or 'z'

  Time variables are measured in ..., while frequency variables are measured in ...

  The above blocks result in a total of X variables:

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
fBodyGyroJerkMag

