Code Book :: 'Getting and Cleaning Data' Course Project
=======================================================

Study design
------------



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

