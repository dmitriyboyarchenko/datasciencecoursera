## Getting and Cleaning Data
## Peer Assessment project

## This R script assumes that the folder "UCI HAR Dataset"
## with the Samsung data is in the current working directory

## The resulting tidy data set is written to the file "tidyUCI.txt"
## in the current working directory

# Subfolders for extracting various data
folder <- "./UCI HAR Dataset/"
train.folder <- paste0(folder, "train/")
test.folder <- paste0(folder, "test/")

# The file with the list of features
features.file <- paste0(folder, "features.txt")
features <- read.table(features.file, colClasses="character")

# Training: observations, activity labels, subjects
train.obs.file <- paste0(train.folder, "X_train.txt")
train.act.file <- paste0(train.folder, "y_train.txt")
train.subj.file <- paste0(train.folder, "subject_train.txt")
train.obs <- read.table(train.obs.file)
train.act <- read.table(train.act.file)
train.subj <- read.table(train.subj.file)

# Test: observations, activity labels, subjects
test.obs.file <- paste0(test.folder, "X_test.txt")
test.act.file <- paste0(test.folder, "y_test.txt")
test.subj.file <- paste0(test.folder, "subject_test.txt")
test.obs <- read.table(test.obs.file)
test.act <- read.table(test.act.file)
test.subj <- read.table(test.subj.file)

# Activity labels
act.labels.file <- paste0(folder, "activity_labels.txt")
act.labels <- read.table(act.labels.file,
                         col.names=c("label", "description"),
                         colClasses="character")
act.labels$description <- capitalize(tolower(act.labels$description))
act.labels$description <- gsub("_", " ", act.labels$description)

# Merge the train and test data sets into one
observations <- rbind(train.obs, test.obs)
activities <- rbind(train.act, test.act)
subjects <- rbind(train.subj, test.subj)

# Combine the lists of subjects, activities and observations
# into a single data.frame:
alldata <- cbind(subjects, activities, observations)
# Attach appropriate labels to all the columns:
colnames(alldata) <- c("subject", "activity", features[,2])

# Sort the rows of alldata by subject first, and by activity second
# alldata <- alldata[order(alldata$subject, alldata$activity), ]

# Now we extract only the measurements on the mean
# and standard deviation for each measurement
mean_std.features <- grep("mean[(][)]|std[(][)]", features[,2], value=TRUE)
alldata <- alldata[, c("subject", "activity", mean_std.features)]

# Replace activity codes with activity names
alldata$activity <- act.labels$description[alldata$activity]

# Create a tidy data set containing the averages of each variable
# for each activity and each subject
tidydata <- sapply(split(alldata[, 3:68], list(alldata$activity, alldata$subject)), colMeans)
tidydata <- as.data.frame(tidydata)

# Unfortunately, this yields the transpose of the data frame we want
# In addition, the activity names and subject numbers are messed up
# The following solution is perhaps inelegant, but it does the job
vars <- matrix(unlist(strsplit(colnames(tidydata), '\\.')), nrow=2)
acts <- vars[1,]
subjs <- vars[2,]
# Transpose the tidy data frame:
tidydata <- as.data.frame(t(tidydata))
# Add back the activity descriptions and the subject numbers
labels <- data.frame(activity=acts, subject=subjs)
tidydata <- cbind(labels, tidydata)
rownames(tidydata) <- NULL

# Finally, write the tidy data frame to a text file
write.table(tidydata, file="./tidyUCI.txt")
