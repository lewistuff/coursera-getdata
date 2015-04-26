CodeBook: Getting and Cleaning Data Project
==========

Project Overview
----------
The resultant data set is contained within `activityAnalysis.txt`, and has been produced by executing `run_analysis.R` on the [UCI](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) data set. The `README.md` contained within this repository contains further details on this project.

A summary of the data transformations are as follows:

* The training and test data has been combined,
* Measurements of the standard deviation and mean have been extracted,
* Numerical identifiers for activity have been replaced with descriptive names,
* The feature names were amended to provide further clarity,
* Melt was used to transform the dataset from *wide*, to *long*,
* The final tidy dataset was aggregated calculating the mean for each measurement.

subject
----------
*column: #1, type: Integer, Factor*

This represents the individual subject who performed the observations, and has been sampled. The range is from 1 to 30.

activity
----------
*column: #2, type: Character, Factor*

This is the type of activity observed, there are six possible activities present in the original data set. These have been copied here for completeness:

```
Level Value
----- -------------------
1     WALKING
2     WALKING_UPSTAIRS
3     WALKING_DOWNSTAIRS
4     SITTING
5     STANDING
6     LAYING
```
*source: activity_labels.txt*

measure
----------
*column: #3, type: Number, Factor*

This is the measurement (or 'feature') that was recorded as part of the study. The analysis contained within this repository extracts all measurements containing 'mean()' or 'std()', e.g. this will exclude 'meanFreq'.

To improve the readability of the measurements, some abbreviations have been used (here, the syntax specifies 'original name -> new name' where an enhancement has been made):

1. `Acc` -> `Accel`: the accelerometer reading measured in Hz
2. `Mag` -> `Magnitude`: abbreviated version of magnitude
3. `t` -> `time`: abbreviated version representing the time domain
4. `f` -> `freq`: abbreviated version representing the frequency domain
5. `Gyro`: abbreviated version of Gyroscope
6. `XYZ`: measurements in a specific axis direction
7. `mean()` -> `mean`: the mean, parenthesis have been stripped
8. `std()` -> `std`: the standard deviation, parenthesis have been stripped

Mapping examples:
```
Source Dataset      Target Dataset
-----------------   ---------------------
tBodyAcc-mean()-X   time-BodyAccel-mean-X
fBodyAcc-mean()-X   freq-BodyAccel-mean-X
...
tBodyAcc-std()-X    time-BodyAccel-std-X
fBodyAcc-std()-X    freq-BodyAccel-std-X
...
```
*(where 'Source Dataset' is the `UCI HAR Dataset/features.txt`, and 'Target Dataset' is the `activityAnalysis.txt`)*

mean
----------
*column: #4, type: Number, [-1,1]*

This is the mean of each variable for a given subject, and given activity. The source data is normalised, and therefore the result is an average of each measure of standard deviation and mean.

