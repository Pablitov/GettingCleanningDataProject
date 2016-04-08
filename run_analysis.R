
# 0. Do a few things before starting
# -----------------------------------------------------------------------
library(data.table)
library(dplyr)
library(curl)
library(reshape2)

setwd("~/R/Module3 GCD/UCI HAR Dataset")
wd <- getwd()
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, destfile = "data.zip")
unzip("data.zip")

# 1. Merges the training and the test sets to create one data set
# -----------------------------------------------------------------------

# "features.txt" contains the names of the variables
features <- read.table("features.txt")

# Load all the data
test_data <- read.table(paste0(wd,"/test/X_test.txt"))
test_subject <- read.table(paste0(wd,"/test/subject_test.txt"))
names(test_subject) <- "subject"
test_activity <- read.table(paste0(wd,"/test/y_test.txt"))
names(test_activity) <- "activity"
test_data <- cbind(test_subject,test_activity,test_data)

# Then the "train" dataset 
train_data <- read.table(paste0(wd,"/train/X_train.txt"))
train_subject <- read.table(paste0(wd,"/train/subject_train.txt"))
names(train_subject) <- "subject"
train_activity <- read.table(paste0(wd,"/train/y_train.txt"))
names(train_activity) <- "activity"
train_data <-cbind(train_subject,train_activity,train_data)

# we merge both sets
Complete_dataset = merge(test_data,train_data,all=TRUE)

# Get the names of the features. We need to add "subject" and "activity" at the end
dsnames <- c("subject","activity",as.character(features$V2))
setnames(Complete_dataset,names(Complete_dataset),dsnames)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# -----------------------------------------------------------------------

# Lets find the indecees of the columns with measurements refering to the "mean" and "std"
mean_std_ind <- c(1,2,grep("(.*)mean(.*)|(.*)std(.*)", dsnames))
Complete_dataset <- Complete_dataset[mean_std_ind,]

# 3. Uses descriptive activity names to name the activities in the data set
# -----------------------------------------------------------------------
activityid <- read.table("activity_labels.txt")
Complete_dataset <- merge(activityid, Complete_dataset, by.x="V1", by.y="activity")
setnames(Complete_dataset,"V1","activity")
setnames(Complete_dataset,"V2","activityname")

# 4. Appropriately labels the data set with descriptive variable names
# -----------------------------------------------------------------------
# We remove duplicates in "body", "t" and "f" are left like that as they are regularly used to designate time and frequency
dsnames <- names(Complete_dataset)
dsnames <- sub("BodyBody","Body",dsnames)
dsnames <- sub("Gyro","Gyroscope",dsnames)
setnames(Complete_dataset,names(Complete_dataset),dsnames)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# -----------------------------------------------------------------------
dsnames <- names(Complete_dataset)
Final_data <-aggregate(. ~subject + activityname, Complete_dataset, mean)
# To end, we write the file 
write.table(Final_data,"Tidydata.txt", row.name=FALSE)
