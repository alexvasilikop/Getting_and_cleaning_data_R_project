#download data and unzip file change to directory
setwd(dir = "/home/alex/Getting_and_cleaning_data_R_project/")

if (! file.exists("/home/alex/Getting_and_cleaning_data_R_project/data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
  zipped.file <- "/home/alex/Getting_and_cleaning_data_R_project/data.zip"
  unzip(zipfile = zipped.file, exdir = "/home/alex/Getting_and_cleaning_data_R_project/Data")
}

#cd to wd with data
setwd(dir = "/home/alex/Getting_and_cleaning_data_R_project/Data/UCI HAR Dataset/")

#Read datasets test and train and subject
x.train.df <- read.table("train/X_train.txt", header = FALSE)
x.test.df  <- read.table("test/X_test.txt", header = FALSE)

y.train.df <- read.table("train/y_train.txt", header = FALSE)
y.test.df <- read.table("test/y_test.txt", header = FALSE)

subject.train.df <- read.table("train/subject_train.txt", header = FALSE)
subject.test.df <- read.table("test/subject_test.txt", header = FALSE)

#Reading features
features.df <- read.table("features.txt", header = FALSE)

#read activity labels
activity.labels <- read.table("activity_labels.txt", header = FALSE)