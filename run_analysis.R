#Step 1: merges the training and test sets to create one dataset

#1a. Create three tables: testSubject, testLabels, testData
library(dplyr)
testSubject<-read.table("./UCI HAR Dataset/test/subject_test.txt")
testSubject<-rename(testSubject,subject=V1) #Part of Step 4
testLabels<-read.table("./UCI HAR Dataset/test/y_test.txt") 
testLabels<-rename(testLabels,activity=V1) #Part of Step 4
testData<-read.table("./UCI HAR Dataset/test/X_test.txt")

#1b. Merge these to create the dataset test
test<-cbind(testSubject,testLabels,testData) #merges the data as one set

#1c. Create three tables: trainSubject, trainLabels, trainData
trainSubject<-read.table("./UCI HAR Dataset/train/subject_train.txt")
trainSubject<-rename(trainSubject,subject=V1) #Part of Step 4
trainLabels<-read.table("./UCI HAR Dataset/train/y_train.txt")
trainLabels<-rename(trainLabels,activity=V1) #Part of Step 4
trainData<-read.table("./UCI HAR Dataset/train/X_train.txt")

#1d. Merge these to create the dataset train
train<-cbind(trainSubject,trainLabels,trainData) #merges the data as one set

#1e. Merges both
data<-rbind(test,train) 
data<-arrange(data,subject)

#Step 2: Extracts only measurements on mean and sd for each measurement
namesTable<-read.table("UCI HAR Dataset/features.txt")$V2
namesTable<-as.character(namesTable)
names(data)[3:563]<-namesTable # now the 561 measurements are named correctly. This is part of Step 4.

cols<-c(1,2,grep("mean",names(data)),grep("std",names(data))) #I will only keep my 3 original columns plus columns that have "mean" or "std" in their name
dataExt<-data[,sort(cols)] #Extract of variables that include mean and sd. Unfortunately, this includes meanFreq.

cols2<-grep("meanFreq",names(dataExt))
dataExt2<-dataExt[,-cols2] #This is my clean dataset, with columns "subject", "activity" and mean or sd measurements

#Step 3: Uses appropriate activity names to name the activities in the dataset
dataExt2[dataExt2$activity==1,2]<-"WALKING"
dataExt2[dataExt2$activity==2,2]<-"WALKING_UPSTAIRS"
dataExt2[dataExt2$activity==3,2]<-"WALKING_DOWNSTAIRS"
dataExt2[dataExt2$activity==4,2]<-"SITTING"
dataExt2[dataExt2$activity==5,2]<-"STANDING"
dataExt2[dataExt2$activity==6,2]<-"LAYING"

#Step 4: Labels the data set with descriptive variable names
#Done in steps 1 and 2.

#Step 5: Creates a tidy dataset with the average of each variable for each activity and subject
dataTidy<-summarise_each(group_by(dataExt2,subject,activity),funs(mean)) #Tidy data, wide

dataTidyNarrow<-melt(dataTidy,id=c("subject","activity")) #Tidy data, narrow

write.table(dataTidyNarrow,"./data/dataFinal.txt",row.name=FALSE)

dataTidyNarrow #Prints my final tidy narrow dataset

