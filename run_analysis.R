library(dplyr)

#download data and unzip file change to directory
setwd(dir = "/home/alex/Desktop/Getting_and_cleaning_data_R_project/")

if (! file.exists("/home/alex/Desktop/Getting_and_cleaning_data_R_project/data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "data.zip")
  zipped.file <- "/home/alex/Getting_and_cleaning_data_R_project/data.zip"
  unzip(zipfile = zipped.file, exdir = "/home/alex/Desktop/Getting_and_cleaning_data_R_project/Data")
}

#cd to wd with data
setwd(dir = "/home/alex/Desktop/Getting_and_cleaning_data_R_project/Data/UCI HAR Dataset/")

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
colnames(activity.labels) <- c("activity_label", "activity_name")

# 1 Merge test and training datasets X
x.merged.df <- rbind(x.train.df, x.test.df)

# 1 Merge test and training dataset Y
y.merged.df <- rbind(y.train.df, y.test.df)
colnames(y.merged.df) <- "activity_label"

# 1 Merge test and training dataset subjects
subject.merged.df <- rbind(subject.train.df, subject.test.df)
colnames(subject.merged.df) <- "subject"

# 1 Merge all X,Y, subject, activity labels (not performed)
#add labels and subjects columns
#x.y.subject.merged.df <- cbind(subject.merged.df, y.merged.df, x.merged.df)

# 2 Extract only measurement of mean and standard deviation for each measurement (column)
colnames(x.merged.df) <- features.df[[2]]
idx <- grep("mean|std", colnames(x.merged.df))
x.merged.df <- x.merged.df[,idx]

# 3 Name activities with informative names
y.merged.df <- merge(y.merged.df, activity.labels, by = "activity_label")

# 4 Appropriately label the dataset with descriptive activity names
x.y.subject.merged.df <- cbind(y.merged.df$activity_name, subject.merged.df, x.merged.df)
colnames(x.y.subject.merged.df)[1] <- "activity_name"  # Rename the first column to activity_name

# 5  creates a second, independent tidy data set with the average of each variable for each activity and each subject
tidy.dataset <- x.y.subject.merged.df %>%
  group_by(activity_name, subject) %>%
  summarise(across(everything(), ~ mean(.x, na.rm = TRUE), .names = "mean_{.col}"))

#write tidy dataset
write.table(tidy.dataset, file = "/home/alex/Desktop/Getting_and_cleaning_data_R_project/tidy_dataset.tsv", row.names = FALSE)

