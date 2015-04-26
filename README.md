README: Getting and Cleaning Data Project
==========

Overview
----------
The scripts contained herein form my submission for the 'Coursera - Getting and Cleaning Data' course project. The script performs analysis on the 'Human Activity Recognition Using Smartphones Dataset' provided by UCI.

The analysis of the dataset is contained within a single script `run_analysis.R`.

Project Instructions
----------
This is a copy of the instructions provided as part of the course project specification. You should create one R script called run_analysis.R that does the following. 

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set.
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

How Do I Run The Analysis?
----------
To run the analysis, there are several high-level steps to follow:

1. You need to obtain a local copy of the [data set](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip),
2. Extract the .zip containing the folder (and contents) named 'UCI HAR Dataset' into your working directory (WD),
3. Within your WD, execute the script `run_analysis.R`,
4. Observe the generated output written to `activityAnalysis.txt`.

Repository Contents
----------
This repository contains the following files for submission:

* `run_analysis.R`: This contains all of the code to perform the analysis, and produce the tidy data set.
* `CodeBook.md`: This contains a description of the transformations, variables and data produced.
* `README.md`: An overview of the scripts, and related project files.

Sources
----------
The following page contains a full description of the data leveraged for this course project. The data set is sourced from [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) produced by UCI. 

A direct link to the data set leveraged for the course project, can be found here:

* <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

