'Getting and Cleaning Data' Course Project
==========================================

Study design
------------
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured. The experiments have been video-recorded to label the data manually.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See next section for more details on the variables. See [1] for further details on the study.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012



Code book
---------

subject

  Id of the participant on the experiment. There are a total of 30 subjects.
  
activity

  Label of the activity. There are a total of 6 activities. All 30 subjects have completed all 6 activities.
  Activity list:
  
  ++laying
  ++sitting
  ++standing
  ++walking
  ++walking_downstairs
  ++walking_upstairs
  
  

  The following variables in the tidy dataset correspond to the mean of the mean values ('mean') and standard deviation values ('stdev') of the raw measurements.
  These measurements comprise the time domain signals ('time') and frequency ('frequency') of the accelerometer ('acc') and gyroscope ('gyro'), separated in a 3-axial system (axis X, Y, and Z). The acceleration signal was separated into body ('body') and gravity acceleration signals ('gravity').
  Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals ('jerk'). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm ('mag').
  
  Then, these variables are named accordingly to these blocks:

  ++Statistic -> mean ('mean') or standard deviation ('stdev')
  ++Type of signal -> 'time' or 'frequency'
  ++Source of acceleration -> 'body' or 'gravity'
  ++Device -> accelerometer ('acc') or gyroscope ('gyro')
  ++Jerk signal -> 'jerk'
  ++Normalised magnitude -> 'mag'
  ++Axis -> X ('axisx'), Y ('axisy'), or Z ('axisz')

  Time variables have been normalised and are bounded between [-1, 1].

  The above blocks result in a total of 66 variables:

meantimebodyaccaxisx
meantimebodyaccaxisy
meantimebodyaccaxisz
stdevtimebodyaccaxisx
stdevtimebodyaccaxisy
stdevtimebodyaccaxisz
meantimegravityaccaxisx
meantimegravityaccaxisy
meantimegravityaccaxisz
stdevtimegravityaccaxisx
stdevtimegravityaccaxisy
stdevtimegravityaccaxisz
meantimebodyaccjerkaxisx
meantimebodyaccjerkaxisy
meantimebodyaccjerkaxisz
stdevtimebodyaccjerkaxisx
stdevtimebodyaccjerkaxisy
stdevtimebodyaccjerkaxisz
meantimebodygyroaxisx
meantimebodygyroaxisy
meantimebodygyroaxisz
stdevtimebodygyroaxisx
stdevtimebodygyroaxisy
stdevtimebodygyroaxisz
meantimebodygyrojerkaxisx
meantimebodygyrojerkaxisy
meantimebodygyrojerkaxisz
stdevtimebodygyrojerkaxisx
stdevtimebodygyrojerkaxisy
stdevtimebodygyrojerkaxisz
meantimebodyaccmag
stdevtimebodyaccmag
meantimegravityaccmag
stdevtimegravityaccmag
meantimebodyaccjerkmag
stdevtimebodyaccjerkmag
meantimebodygyromag
stdevtimebodygyromag
meantimebodygyrojerkmag
stdevtimebodygyrojerkmag
meanfrequencybodyaccaxisx
meanfrequencybodyaccaxisy
meanfrequencybodyaccaxisz
stdevfrequencybodyaccaxisx
stdevfrequencybodyaccaxisy
stdevfrequencybodyaccaxisz
meanfrequencybodyaccjerkaxisx
meanfrequencybodyaccjerkaxisy
meanfrequencybodyaccjerkaxisz
stdevfrequencybodyaccjerkaxisx
stdevfrequencybodyaccjerkaxisy
stdevfrequencybodyaccjerkaxisz
meanfrequencybodygyroaxisx
meanfrequencybodygyroaxisy
meanfrequencybodygyroaxisz
stdevfrequencybodygyroaxisx
stdevfrequencybodygyroaxisy
stdevfrequencybodygyroaxisz
meanfrequencybodyaccmag
stdevfrequencybodyaccmag
meanfrequencybodyaccjerkmag
stdevfrequencybodyaccjerkmag
meanfrequencybodygyromag
stdevfrequencybodygyromag
meanfrequencybodygyrojerkmag
stdevfrequencybodygyrojerkmag
