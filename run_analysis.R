#step1 Merges the training and the test sets to create one data set.
#Set the path
getwd()
setwd("/Users/Apple/data/l3w4course project")
#Read three data sets
datatest<-read.table("X_test.txt")
datatrain<-read.table("X_train.txt")
features<-read.table("features.txt")
#View the dimensions of each dataset
dim(datatest)
dim(datatrain)
dim(features)
#Pick the second column of data from the featrues data set and transpose it to merge with the other two data sets
featurest<-select(features,V2)
dim(featurest)
dataname<-t(featurest)
head(dataname)
#Add the column name to the datatest and datatrain datasets to be the value in featrues
colnames(datatest)<-dataname
colnames(datatrain)<-dataname
#Combine the datatest and datatrain data sets into a newdata set, newdata
newdata<-rbind(datatest,datatrain)
#View the dimensions of the new dataset
dim(newdata)

#step2Extracts only the measurements on the mean and standard deviation for each measurement.
#Extract columns with "mean" and "std" in the column name
newdata2<-newdata[grep("mean|std",colnames(newdata))]
dim(newdata2)
#Remove the "meanFreq" columns from the column names in the new dataset
newdata3<-newdata2[grep("meanFreq",colnames(newdata2),invert = TRUE)]
dim(newdata3)

#step3 Uses descriptive activity names to name the activities in the data set
#read "activity_labels.txt"file,as"avtivity_id"
activity_id<-read.table("activity_labels.txt")
#read "y_test.txt"file,as"y_test";read "y_train.txt"file,as y_train
y_test<-read.table("y_test.txt")
y_train<-read.table("y_train.txt")
#View the dimensions of the follow datasets:
dim(y_test)
dim(y_train)
dim(datatest)
dim(datatrain)
#Using "cbind"function to merge "datatest" and "y_test",the new set is called "y_datatest";merge "datatrain"and"y_train",the new set is called y_datatrain.
y_datatest<-cbind(datatest,y_test)
y_datatrain<-cbind(datatrain,y_train)
#Uses descriptive activity names to name the activities in "y_datatest" set
names(activity_id)<-c("id","V2")
activity_datatest<-merge(y_datatest,activity_id,by.x = "V1",by.y = "id",all = TRUE)
##Uses descriptive activity names to name the activities in "y_datatrain" set
activity_datatrain<-merge(y_datatrain,activity_id,by.x = "V1",by.y = "id",all = TRUE)
#Uses "rbind"function to merge "activity_datatest"and"activity_datatrain"
activity_data<-rbind(activity_datatest,activity_datatrain)
dim(activity_data)

#step 4
#Extract the column name of the dataset
colnames<-names(activity_data)
#Remove dashes from column names
colnames_x<-gsub("-","",colnames)
head(colnames_x,n=3)
#Remove parentheses from column names
colnames_x<-gsub("\\()","",colnames_x)
head(colnames_x,n=3)
#Rename the dataset column name to the new column name
names(activity_data)<-colnames_x
names(activity_data)

#step 5
newdata5<-activity_data[grep("mean",colnames(activity_data))]
dim(newdata5)

write.table(newdata5,file="newdata5.txt",row.names = FALSE)