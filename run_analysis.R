#Title: Getting and Cleaning Data Course Project
#Author: Varenya Pathak
#Date: 12th March 2022

#loading the library dplyr created by Hardely Wickam 

library(dplyr)


#creates a file if it doesn't exist

if(!file.exists("./data")){dir.create("./data")}


#downloading the information from provided link 

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")


# Unzipping the folder

unzip(zipfile="./data/Dataset.zip",exdir="./data")


#Creating variables by extracting information from respective text files
#Giving respective column names to improve readability for users

features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "code")


#Part 1- Combining two tables and storing them as variables X and Y respectively

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)

#Binding the rows and storing in variable Subject and Merged_data
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)


#Part 2- Extracts only the measurements on the mean and standard deviation for each measurement
#Using forward pipe operator(%>%) to make the code cleaner and easier to read

Cleaned <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))


#Part 3- Using descriptive activity names to name the activities in the data set
Cleaned$code <- activities[Cleaned$code, 2]


#Part 4- Using gsub to Substitute the headings with proper names to improve readability 

names(Cleaned)[2] = "activity"
names(Cleaned)<-gsub("Acc", "Accelerometer", names(Cleaned))
names(Cleaned)<-gsub("Gyro", "Gyroscope", names(Cleaned))
names(Cleaned)<-gsub("BodyBody", "Body", names(Cleaned))
names(Cleaned)<-gsub("Mag", "Magnitude", names(Cleaned))
names(Cleaned)<-gsub("^t", "Time", names(Cleaned))
names(Cleaned)<-gsub("^f", "Frequency", names(Cleaned))
names(Cleaned)<-gsub("tBody", "TimeBody", names(Cleaned))
names(Cleaned)<-gsub("-mean()", "Mean", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("-std()", "STD", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("-freq()", "Frequency", names(Cleaned), ignore.case = TRUE)
names(Cleaned)<-gsub("angle", "Angle", names(Cleaned))
names(Cleaned)<-gsub("gravity", "Gravity", names(Cleaned))


#Part 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
#Using forward pipe operator(%>%) for making code cleaner

FinalData <- Cleaned %>%
  #grouping by subject first(in ascending order and then by activity in ascending order)
  group_by(subject, activity) %>%
  #Finding the mean
  summarise_all(funs(mean))


#Writing in the cleaned data into the text file FinalData.txt
write.table(FinalData, "FinalData.txt", row.name=FALSE)