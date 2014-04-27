
# Getting and Cleaning Data: Peer Assessment Description

The repo includes the following files:

* `README.md` (this description file)
* `CodeBook.md` (describes the variables, the data and the transformations that were made to clean up the Samsung data set)
* `run_analysis.R` (the R script that performs all the transformations)
* `tidyUCI.txt` (the tidy data set produced as a result of running the R script)

In order to run the script `run_analysis.R`, the folder `UCI HAR Dataset` containing the Samsung data must be in the current working directory.
The script reads the measurements from the files `X_train.txt` and `X_test.txt`, the subject numbers from the files `subject_train.txt` and
`subject_test.txt` and the corresponding activity labels from the files `y_train.txt` and `y_test.txt`. The training and test data sets are
merged into one, and the activity labels are replaced with the activity descriptions (taken from the file `activity_labels.txt`). Then a
smaller data set is formed by extracting only those variables whose names contain either the string `mean()` or the string `std()`. Finally,
for each activity and each subject, the average of the observations of each variable is calculated. These averages form the new tidy data set,
which is then written as a table to the file `tidyUCI.txt`.