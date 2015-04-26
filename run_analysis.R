# ------------------------------
# Title: Getting and Cleaning Data - Course Project
# By: Lewis Tuff
# Note:
#   As per the project instructions, this script assumes the HAR data
#   set has been downloaded, and extracted into a directory within 
#   your current working directory, e.g. 'UCI HAR Dataset/'
# ------------------------------

# ------
# Helper Functions
# ------

getDatasetPath <- function(datasetName,isTestSet=FALSE) {
  baseDir <- "UCI HAR Dataset/"
  subDir <- "train/"
  
  # Check the file exists
  
  # Build path
  if(isTestSet) {
    subDir <- "test/"
  }
  filePath <- paste(baseDir,subDir,datasetName,".txt",sep='')
  
  # Return the full filepath
  return(filePath)
}

# ------
# Step 1: Merge training/test data sets
# ------

# Initialise the ref data, based upon extracting the Samsung data .zip to a 
# '/UCI HAR Dataset' folder. As per the instructions we are assuming the data 
# set is in the working dir - within the '/UCI HAR Dataset' sub-directory.
dataDir <- "UCI HAR Dataset"
activityLabels <- read.table(paste(dataDir, "/activity_labels.txt", sep=''))
features <- read.table(paste(dataDir, "/features.txt", sep=''))

# Load in the training set and labels
trainingSet = read.table(getDatasetPath("X_train"))
subjectTrainSet = read.table(getDatasetPath("subject_train"))
trainingSetLabels = read.table(getDatasetPath("y_train"))

# Load in the test set and labels
testSet = read.table(getDatasetPath("X_test", TRUE))
subjectTestSet = read.table(getDatasetPath("subject_test", TRUE))
testSetLabels = read.table(getDatasetPath("y_test", TRUE))

# Set the training/test feature names
names(trainingSet) <- features$V2
names(testSet) <- features$V2

# Merge the subject samples, with the respective activites
trainComplete <- cbind(subject=subjectTrainSet$V1, activity=trainingSetLabels$V1, trainingSet)
testComplete <- cbind(subject=subjectTestSet$V1, activity=testSetLabels$V1, testSet)

# Merge the training/test datasets
fullSet <- rbind(testComplete, trainComplete)

# ------
# Step 2: Extract measurements on mean/standard deviation
# ------

# Extract only the required variables of interest, in this case, 
# only the subject, activity, mean(), and std(). 
# (nb. meanFreq has been omitted)
subSet <- fullSet[grep("subject|activity|mean\\(\\)|std\\(\\)", names(fullSet), fixed=FALSE)]

# ------
# Step 3: Use descriptive activity names
# ------

# Map the identifier to its descriptive activity name
subSet$activity <- activityLabels$V2[subSet$activity]

# ------
# Step 4: Appropriately label the data set with descriptive var names
# ------

# Make the domain explicit, renaming 
#   't' -> 'time-', and 
#   'f' -> 'freq-'
names(subSet) <- sub("^t", "time-", names(subSet))
names(subSet) <- sub("^f", "freq-", names(subSet))

# Clean repeated 'Body' in feature name, inline with the documentation
names(subSet) <- sub("(Body)+", "Body", names(subSet))

# Acceleration is abbreviated to 'Acc', let's rename to 'Accel'
names(subSet) <- sub("Acc", "Accel", names(subSet))

# Magnitude is abbreviated to 'Mag', let's rename to 'Magnitude'
names(subSet) <- sub("Mag", "Magnitude", names(subSet))

# Let's strip out the braces, i.e. '(' 
names(subSet) <- gsub("[\\(\\)]", "", names(subSet))

# We want to leverage melt to transform the data set into a 'narrow' format, 
# inline with clean data principles introduced in this course
library(reshape2)

# Add in our factors, for both
#   subject samples (1,...,30), and
#   activity levels (1,...,6) from the activityLabels
subSet$subject <- factor(subSet$subject)
subSet$activity <- factor(subSet$activity, activityLabels$V2)

# Finally melt the dataset, resulting in {subject,activity,measure,value}
finalSet <- melt(subSet, id.vars=c("subject", "activity"), variable.name="measure")

# ------
# Step 5 - Create a second, independent tidy data set with averages
# ------

# Import the plyr package
library(plyr)

# Create a second tidy dataset, applying the mean to each variable
tidySet <- 
  ddply(finalSet, 
        c("subject", "activity", "measure"), 
        summarise, 
        mean=mean(value)
  )

# Finally write-out the tidy data set to file
write.table(tidySet, "activityAnalysis.txt", row.name=FALSE)
