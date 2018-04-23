# Getting-and-Cleaning-Data-Assignment

This script accesses the UCI HAR Dataset, downloads it and unzips the files. Six of the files were read into R
1) subject_train-the individuals whose data was used for the training dataset
2) train_y: the activities of the individuals in the training database
3) train_X: the readings of the individuals in the training database
4) subject_test-the individuals whose data was used for the test dataset
5) test_y: the activities of the individuals in the test database
6) test_X: the readings of the individuals in the test database


Several columns were then relabeled (Note: I tried to use the rename function in dplyr on table1 but it appears the reshape package was interfering so I labeled the files with colnames first before combining the dataset as a workaround). Also, the mapvalues function of plyr was used to relabel individual activities, from numeric (1:6) to character labels (walking, walking up, walking down, sitting, standing, laying), respectively. 

The training data was combined so that each subjects number, their activities, and the readings collected were included in a single table. Likewise, the test data was combined so that each subjects number, their activities, and the readings were collected in a single table. These two tables were combined and sorted by subject and activity to produce table1. This table was melted to produce a tidy dataset

Each individual has a set of readings for each variable of each activity. A mean and standard deviation was calculated for each set of readings. The resulting data was matched with each subject/activity combination to create table2. The mean and standard deviation columns were labeled accordingly. 
