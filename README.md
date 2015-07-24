# Course Project

**Packages needed**: *dplyr*

**Files read:** You need the *UCI HAR Dataset* folder in your working directory.
- ./UCI HAR Dataset/test/subject_test.txt
- ./UCI HAR Dataset/test/y_test.txt
- ./UCI HAR Dataset/test/X_test.txt
- ./UCI HAR Dataset/train/subject_train.txt
- ./UCI HAR Dataset/train/y_train.txt
- ./UCI HAR Dataset/train/X_train.txt

**Step 1:**
First of all, I created the tables *test* and *train*.
Each one has 563 columns: *subject*, *activity* and the values for the 561 measurements.
Then I concatenated these tables to create *data*. This table has 10299 rows and 563 columns.

**Step 2:**
I used the grep function to choose the column names that had "mean" or "std" in their name.
*dataExt* is an extract of the dataset, choosing only the columns with "mean" or "std".
*dataExt2* is the final extract, since I eliminated columns with names that included "meanFreq" from dataExt.

**Step 3:**
I changed the activity names in the "activity" column of *dataExt2*. 
Instead of 1:6, the rows now say "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING" OR "LAYING".

**Step 4:**
I already had all variable names that were descriptive. This was accomplished in steps 1 (where I named the variables "subject" and "activity) and step 2 (where I named the other variables and chose the ones that included "mean" or "std" in their name.

**Step 5:**
I used the *summarise_each* function in the dplyr package which allows you to summarise many columns at once. I grouped my data by subject and by activity using *group_by*. 







