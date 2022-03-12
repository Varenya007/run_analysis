# run_analysis
Introduction
This is a course project for Getting and Cleaning Data
By using various functions and methods explained in course, the objective is to produce and clean, tidy data which is stored, in this case, in a text file called "FinalData.txt"


Method
Firstly, we load the library of dplyr created by Hadley Wickham
The data is taken from the following zipfile:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
After downloading the data and creating a file(if it doesn't exist), we perform the following steps to get a clean dataset:
Merging the training and the test sets to create one data set.
Extracting only the measurements on the mean and standard deviation for each measurement. 
Using descriptive activity names to name the activities in the data set.
Appropriately labeling the data set with descriptive variable names. 
From the data set in step 4, creating a second, independent tidy data set(FinalData.txt) with the average of each variable for each activity and each subject.
the run_analysis.R file contains coed to do the same
