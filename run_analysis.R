
# 0. Do a few things before starting
# -----------------------------------------------------------------------
library(data.table)
library(dplyr)
library(plyr)
library(reshape2)

setwd("~/R/Module3/UCI HAR Dataset")
wd <- getwd()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, destfile = "data.zip")
unzip("data.zip")

# 1. Merges the training and the test sets to create one data set
# -----------------------------------------------------------------------

# let's see the names of the variables
features <- read.table("features.txt")

# By looking at this data, we can indentify the column where the feature names are
names(features)
# the name of the column that we want is "V2".

# Lets work out the "test dataset" first
test_data <- read.table(paste0(wd,"/test/X_test.txt"))
test_subject <- read.table(paste0(wd,"/test/subject_test.txt"))
names(test_subject) <- "subject"
test_activity <- read.table(paste0(wd,"/test/y_test.txt"))
names(test_activity) <- "activity"
test_data <- cbind(test_data,test_subject,test_activity)
# Now we can change the names of the test data to use them later in order to merge the two data sets

# Load the subjects and activities, and then merge them to the test dataframe

# Then the "train" dataset 
train_data <- read.table(paste0(wd,"/train/X_train.txt"))
train_subject <- read.table(paste0(wd,"/train/subject_train.txt"))
names(train_subject) <- "subject"
train_activity <- read.table(paste0(wd,"/train/y_train.txt"))
names(train_activity) <- "activity"
train_data <-cbind(train_data,train_subject,train_activity)

# we merge both sets
Complete_data = merge(test_data,train_data,all=TRUE)

# Get the names of the features. We need to add "subject" and "activity" at the end
dsnames <- c(as.character(features$V2),"subject","activity")
setnames(Complete_data,names(Complete_data),dsnames)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# -----------------------------------------------------------------------

# Lets find the indecees of the columns with measurements refering to the "mean" and "std"
mean_std_ind <- grep("(.*)mean(.*)|(.*)std(.*)", dsnames)
Complete_data <- Complete_data[mean_std_ind,]

# 3. Uses descriptive activity names to name the activities in the data set
# -----------------------------------------------------------------------
activityid <- read.table("activity_labels.txt")
Complete_data <- merge(Complete_data, activityid, by.x="activity", by.y="V1")
setnames(Complete_data,"V2","activityid")

# 4. Appropriately labels the data set with descriptive variable names
# -----------------------------------------------------------------------
# We remove duplicates in "body", "t" and "f" are left like that as they are regularly used to designate time and frequency
dsnames <- names(Complete_data)
dsnames <- sub("BodyBody","Body",dsnames)
dsnames <- sub("Gyro","Gyroscope",dsnames)
setnames(Complete_data,names(Complete_data),dsnames)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------
dsnames2 <- names(Complete_data)[]
Final_data <- aggregate(Complete_data[dsnames2], by=Complete_data[c("subject","activity")], FUN=mean)
# To end, we write the file 
write.table(Final_data,"Final_data.txt", row.name=FALSE)