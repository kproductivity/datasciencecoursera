## Getting and Cleaning Data - Course Project
##
## You should create one R script called run_analysis.R that does the following:
##
## 1.Merges training and test sets to create one data set.
## 2.Extracts only the mean and standard deviation for each measurement. 
## 3.Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5.Creates a second, independent tidy data set with the average of each
##   variable for each activity and each subject. 


# Read files containing the training and test datasets

training.file <- "./dataset/train/X_train.txt"
training.labels <- "./dataset/train/y_train.txt"
training.subjects <- "./dataset/train/subject_train.txt"
test.file <- "./dataset/test/X_test.txt"
test.labels <- "./dataset/test/y_test.txt"
test.subjects <- "./dataset/test/subject_test.txt"

training <- read.table(training.file)
training.activity <- read.table(training.labels, col.names = c("activity"))
training.subject <- read.table(training.subjects, col.names = c("subject"))
test <- read.table(test.file)
test.activity <- read.table(test.labels, col.names = c("activity"))
test.subject <- read.table(test.subjects, col.names = c("subject"))


# Read files containing list of features and activities.

features.list <- read.table("./dataset/features.txt", col.names = c("id", "feature"))
activity.list <- cbind("id" = c(1:6),
                       "activity" = c("walking", "walking_upstairs", "walking_downstairs",
                                      "sitting", "standing", "laying")) # list from activity_labels.txt


# Bind the 3 training files (subjects, activities, measurement)
names(training) <- features.list[,2]
training <- cbind(training.subject, training.activity, training)


# Bind the 3 test files (subjects, activities, measurement)
names(test) <- features.list[,2]
test <- cbind(test.subject, test.activity, test)


# Bind the training and test files
# Previously I have checked with 'unique' that subjects are disimilar
all.data <- rbind(training, test)


# Extract only measurements which are 'mean' or 'standard deviation'
pattern <- "-(mean\\(\\))|(std\\(\\))"
features.index <- grep(pattern, features.list[,2]) + 2  # build index with features including '-mean()' or '-std()'
all.data <- all.data[ , c(1:2, features.index)]         # include first 2 cols, too


# Label the activities using activity.list
oldvalues <- activity.list[, 'id']
newvalues <- activity.list[, 'activity']
all.data[, 'activity'] <- newvalues[ match(all.data[, 'activity'], oldvalues)]


# Calculate averages for every variable at subject-activity level
require(reshape2)
x <- melt(all.data, id=1:2) # First two columns are 'id', rest are 'measured'
average.data <- dcast(x, subject + activity ~ variable, mean)
  

# Rename variables for making them human readable
newnames <- tolower(names(average.data))                       # all small case
newnames <- sub("\\(\\)", "", newnames)                    # remove brackets
newnames <- sub("tbody", "timebody", newnames)             # improve labels
newnames <- sub("fbody", "frequencybody", newnames)        # improve labels
newnames <- sub("tgravity", "timegravity", newnames)       # improve labels
newnames <- sub("fgravity", "frequencygravity", newnames)  # improve labels
newnames <- sub("bodybody", "body", newnames)              # delete duplicate
newnames <- sub("-x", "axisx", newnames)                   # improve labels
newnames <- sub("-y", "axisy", newnames)                   # improve labels
newnames <- sub("-z", "axisz", newnames)                   # improve labels
newnames <- gsub("-", "", newnames)                        # remove dash

means.index <-grep("mean", newnames)
newnames[means.index] <- sub("mean", "", newnames[means.index])
newnames[means.index] <- paste("mean", newnames[means.index], sep = "")
  
std.index <-grep("std", newnames)
newnames[std.index] <- sub("std", "", newnames[std.index])
newnames[std.index] <- paste("stdev", newnames[std.index], sep = "")

names(average.data) <- newnames


# Save into a new file
write.table(average.data, file = "tidydata.txt", row.names = FALSE)
