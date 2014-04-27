
# Getting and Cleaning Data: Peer Assessment Code Book


## Raw data

The raw data used for this project was collected by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto
from a group of 30 volunteers aged 19-48 (reference [1]). The initial measurements came from the embedded accelerometer
and gyroscope in a Samsung Galaxy S II smartphone worn on the waist by the subjects, while they performed six activities:

* Laying
* Sitting
* Standing
* Walking
* Walking downstairs
* Walking upstairs

The raw data was randomly partitioned into two sets, with 21 subjects (70%) placed in the training data set and
the other 9 subjects (30%) placed in the test data set.



## Variables

### Variables in the raw data set

The following is copied *verbatim* from the file `features_info.txt` that accompanies the raw data set used for this project.

> The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
> 
> Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 
> 
> Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
> 
> These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

A total of 561 variables were estimated from these signals (the entire list is available in the file `features.txt`, but is too long to
reproduce here). The variables that are of interest to us are the mean and standard deviation for each of the 33 signals, leading to a
total of 66 variables:

* tBodyAcc-mean()-XYZ and tBodyAcc-std()-XYZ
* tGravityAcc-mean()-XYZ and tGravityAcc-std()-XYZ
* tBodyAccJerk-mean()-XYZ and tBodyAccJerk-std()-XYZ
* tBodyGyro-mean()-XYZ and tBodyGyro-std()-XYZ
* tBodyGyroJerk-mean()-XYZ and tBodyGyroJerk-std()-XYZ
* tBodyAccMag-mean() and tBodyAccMag-std()
* tGravityAccMag-mean() and tGravityAccMag-std()
* tBodyAccJerkMag-mean() and tBodyAccJerkMag-std()
* tBodyGyroMag-mean() and tBodyGyroMag-std()
* tBodyGyroJerkMag-mean() and tBodyGyroJerkMag-std()
* fBodyAcc-mean()-XYZ and fBodyAcc-std()-XYZ
* fBodyAccJerk-mean()-XYZ and fBodyAccJerk-std()-XYZ
* fBodyGyro-mean()-XYZ and fBodyGyro-std()-XYZ
* fBodyAccMag-mean() and fBodyAccMag-std()
* fBodyAccJerkMag-mean() and fBodyAccJerkMag-std()
* fBodyGyroMag-mean() and fBodyGyroMag-std()
* fBodyGyroJerkMag-mean() and fBodyGyroJerkMag-std()

### Variables in the tidy data set

The tidy data set has the same 66 variables as the ones listed above. However, in the tidy data set, each value is calculated as the
average of the observations of the corresponding variable in the raw data set, for every activity and every subject. In addition,
two new variables are introduced: the activity description (`activity`) and the subject number (`subject`).



## Transformations

The script `run_analysis.R` included in this repo performs the following transformations on the raw data set described above.

1. Read the measurements of all 561 variables from the files `X_train.txt` and `X_test.txt`.
* Read the corresponding activity labels (1 through 6) from the files `y_train.txt` and `y_test.txt`.
* Read the subject numbers (1 through 30) from the files `subject_train.txt` and `subject_test.txt`.
* Merge the training and test data sets into one using the `rbind()` function.
* Create a single `data.frame` containing the subject numbers, activity labels and the observations
of all 561 variables using the `cbind()` function.
* Replace the activity labels (1 through 6) with the corresponding activity descriptions, taken
from the file `activity_labels.txt`.
* Extract those columns from the entire `data.frame` whose name contains either the string `mean()` or the string `std()`.
* Split the new data frame by activity description and by subject number.
* Compute the column means for each of the resulting 180 tables.
* Combine the results back into a single `data.frame` containing 180 observations of the 66 variables.
* Add two columns at the beginning of this data frame, containing the corresponding activity descriptions and subject numbers.
This is the tidy data set we need to produce.
* Write this tidy data set as a table to the file `tidyUCI.txt` in the current working directory.



## References

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012