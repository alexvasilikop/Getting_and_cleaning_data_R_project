# Codebook

This is the exercise performed in the frame of the project for the course "Getting and cleaning data"

Source of the original data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Original description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Dataset Modifications

The script ```run_analysis.R``` downloads the zipped data (if not already in the existing repository and performs the following tasks:
- Reading data (train and test) into the data frames X.test, X.train, Y.test, Y.train, subject.test, subject.train, activity.labels, features
- Combines data frames from training and test data
- From merged X data extracts only columns that match the mean or stdev using ```grep```
- Provides informative activity names for Y (activity labels for data) using ```merge```
- Label X dataset with activity names by using cbind
- Creates a tidy dataset with mean values of features grouped by subject and activity name
