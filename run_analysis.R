# 1. Merge the training and the test sets to create one data set.
# assign table data variable names
xtest <- read.table("UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("UCI HAR Dataset/test/y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
xtrain <- read.table("UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("UCI HAR Dataset/train/y_train.txt")
trainsubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

#merge data sets
xdatas <- rbind(xtest, xtrain)
ydatas <- rbind(ytest, ytrain)
subjectdatas <- rbind(testsubjects, trainsubjects)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement
# grab only mean and standard deviation
featuresdatas <- read.table("UCI HAR Dataset/features.txt")
mean_and_std <- grep("mean\\(\\)|std\\(\\))", featuresdatas[,2])
#assign 
mean_std_datas <- xdatas[,mean_and_std]

#3. Uses descriptive activity names to name the activities in the data set
#read activity labels
act_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
act <- as.factor(ydatas$V1)
levels(act) <- act_labels$V2
sub <- as.factor(subjectdatas$V1)
#names for columns
y_labels <- cbind(act, sub, mean_std_datas)

#4. Appropriately label the data set with descriptive variable names
label_alldatas <- cbind(y_labels, mean_std_datas)

#5. From the dataset in step 4, creates a second, independent tidy dataset with the
#average for each variable for each activity for each and each subject
tidy_datas <- data.table(cbind(sub, act, mean_std_datas))[, lapply(.SD, mean), 
                                                            by=c("sub", "act")]
write.table(tidy_datas, "Tidy_Dataset.txt")







