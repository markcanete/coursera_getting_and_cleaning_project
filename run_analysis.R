## Download and unzip the dataset

markcanete_data_set <- "getdata_dataset.zip"

if(!file.exists(markcanete_data_set))
{

  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,markcanete_data_set)
}
if(!file.exists("UCI HAR Dataset"))
{
  unzip(markcanete_data_set)

}

## Reading Trainiing tables

x_train <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/train/subject_train.txt")

## Reading the testing table
x_test <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/test/subject_test.txt")

## Reading feature vector
features <- read.table("UCI HAR Dataset/features.txt")

## activity labels
activityLabels = read.table("C:/Users/mark.canete/Desktop/Lectures for Data Science/UCI HAR Dataset/activity_labels.txt")

## Assigning Column Names

colnames(x_train) <- features[,2]
colnames(y_train) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2]
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId', 'activityType')

## Merging all data in one set

mark_mrg_train <- cbind(y_train, subject_train, x_train)
mark_mrg_test <- cbind(y_test, subject_test, x_test)
mark_setall <- rbind(mark_mrg_train, mark_mrg_test)

## Reading column names

NewName <- colnames(mark_setall)

## Create vector for defining ID, mean and standard deviation

mark_mean_and_std <- (grepl("activityId", NewName) | grepl("subjectId", NewName) | grepl("mean..", NewName) | grepl("std..", NewName) )

## Set all in one file

Mark_setall_mean_std <- mark_setall[, mark_mean_and_std == TRUE]

## Use descriptive activities

set_descriptive <- merge(Mark_setall_mean_std, activityLabels, by='activityId', all.x = TRUE )

## mAKE SECOND TIDY DATA SET

second_tidy_set <- aggregate(. ~subjectId + activityId, set_descriptive, mean)

second_tidy_set <- second_tidy_set[order(second_tidy_set$subjectId, second_tidy_set$activityId),]

## Writing second tidy data 

write.table(second_tidy_set, "secTidySet.txt", row.name = FALSE)










