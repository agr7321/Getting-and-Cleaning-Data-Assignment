##Install packages
install.packages ("dplyr")
install.packages ("reshape2")
install.packages ("plyr")
library (reshape2)
library(dplyr)
library (plyr)

##Download files and unzip

AccUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

Accdest<-"Accelerometer Data"
download.file (AccUrl, Accdest)
accfiles <- unzip (Accdest)

##Read tables into R

testx<- read.table ("./UCI HAR Dataset/test/X_test.txt") 
testy<- read.table ("./UCI HAR Dataset/test/y_test.txt")  
sub_test<- read.table ("./UCI HAR Dataset/test/subject_test.txt" )
trainx<- read.table ("./UCI HAR Dataset/train/X_train.txt")
trainy<- read.table ("./UCI HAR Dataset/train/y_train.txt" )
sub_train<- read.table ("./UCI HAR Dataset/train/subject_train.txt" )

##Label variables (columns)
colnames (sub_train)[1]<-"subject"
colnames (sub_test)[1]<-"subject"
colnames (trainy)[1]<-"activity"
colnames (testy)[1]<-"activity"

##Label activities
trainy[,1]<-mapvalues (trainy[,1], from = c(1,2,3,4,5,6), to =c("walking", "walking up", "walking down", "sitting", "standing", "laying"))
testy[,1]<-mapvalues (testy[,1], from = c(1,2,3,4,5,6), to =c("walking", "walking up", "walking down", "sitting", "standing", "laying"))

##Merge training and test sets to create table1
alltrain<-cbind (sub_train, trainy, trainx)
alltest<-cbind (sub_test, testy, testx)
table1<-rbind (alltrain, alltest)
table1<-arrange (table1, subject, activity)
table1a<-melt (table1, id=c("subject", "activity"))

##Extract mean and sd
meancalc<-dcast(table1a, subject + activity ~ variable,mean)
sdcalc<-dcast(table1a, subject + activity ~ variable, sd)
meancalc2<-melt (meancalc, id=c("subject", "activity"))
sdcalc2<-melt (sdcalc, id=c("subject", "activity"))

##Create table2
table2<-cbind (meancalc2, sdcalc[,4])
colnames(table2)[colnames(table2)=="value"] <- "mean"
colnames(table2)[colnames(table2)=="sdcalc[, 4]" ]<- "standard deviation"
print (table2)
