README
======

The script run_analysis.R proceeds with the instructions given in the Getting and Cleaning Data course project.

It prepares tidy data that can be used for later analysis from the raw dataset obtained from:

*Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012*

This raw dataset has to be unzipped and left in a directory called 'dataset' in your `R` work directory. It can be obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Then, when running the script, these actions are executed automatically:

1.The raw files are read from their sources

  * Training data (X_train.txt), labels (y_train.txt), and subjects (subject_train.txt)
  * Test data (X_test.txt), labels (y_test.txt), and subjects (subject_test.txt)

2.The raw files containing the list of features and activities are read

  * Features are extracted from the file features.txt
  * Activities are hardcoded from the file activity_labels.txt

3.The 3 training files (subjects, activities, measurement) are bind, as well as the 3 test files

4.Both the aggregate training file and the aggregate test file are merged

5.Using a pattern, only the columns with means and std deviations for features are selected

6.Activities variable is recoded using activities list

7.Averages for every variable at subject-activity level are calculated

8.The variables are renamed for making them human readable (several functions are applied for achieving this)

9.New dataset with averages is saved in the working directory as tidydata.txt; each row contains the pair subject-activity, and each column contains the different features


Further information about the variables can be obtained from the Code Book (CodeBook.txt).



Francisco Marco-Serrano, 26 July 2014
