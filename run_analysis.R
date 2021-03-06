# This function takes the supplied datasets and formats them into merged tidy data for
# downstream analysis.
#
# Reads Features
# Reads and merges test and train dataset
# creates complete features of dataset
# sets meaningful column names of dataset
# filters columns we are interested in (mean and standard deviation)
# replaces numeric activity column with textual representation
# groups and summarizes data
# outputs data


runAnalysis <- function() {
  #main function which controls all activities
  loadLibrary()
  
  featureNames <- readFeaturesDataset()
  
  testDataset <- readTestDatasets()
  trainDataset <- readTrainDatasets()
  outputDataset <- rbind(testDataset, trainDataset)
  
  allFeatures <- c("subject", "activity", as.vector(featureNames))
  setnames(outputDataset, allFeatures)
  
  filteredFeatureNames <- filterFeaturesDataset(featureNames)
  processDT <- select(outputDataset, one_of(c("subject", "activity", as.vector(filteredFeatureNames))))
 
  processDT <- replaceActivityColumn(processDT)
  
  subjectActivity <- group_by(processDT, subject, activity)
  outputDetails <- summarise_each(subjectActivity, funs(mean))
  finalOutput <- arrange(outputDetails, subject)
  write.table(finalOutput, "subjectActivity.txt", row.names = FALSE)
}

loadLibrary <- function() {
  #load required libraries
  library(data.table)
  library(dplyr)
}

readFeaturesDataset <- function() {
  
  #Read the features dataset
  features <- read.table("features.txt")
  
  #create a vector of the names from the features dataset
  featureNames <- features[,2]
  return(featureNames)
}

filterFeaturesDataset <- function(featureNames) {
  #Filter the columns we require
  meanFeatures <- grep("mean\\(", featureNames, value = TRUE)
  stdFeatures <- grep("-std", featureNames, value = TRUE)
  filterFeatureNames <- c(meanFeatures, stdFeatures)
  return(filterFeatureNames)
  
}

readTestDatasets <- function() {
  #read test data
  subjectTest <- read.table("subject_test.txt")
  yTest <- read.table("y_test.txt")
  xTest <- read.table("X_test.txt")
  testDataset <- data.table(cbind(subjectTest), cbind(yTest), cbind(xTest))
  return(testDataset)
}

readTrainDatasets <- function() {
  #read train data
  subjectTrain <- read.table("subject_train.txt")
  yTrain <- read.table("y_train.txt")
  xTrain <- read.table("X_train.txt")
  trainDataset <- data.table(cbind(subjectTrain), cbind(yTrain), cbind(xTrain))
  return(trainDataset)
}

replaceActivityColumn <- function(processDT) {
  #create a vector of textual representations of activity based on the DT
  #replace the numeric activity column with the textual one
  replacementColumn <- vector("character")
  for(i in 1:nrow(processDT)) {
    if(processDT[i,activity] == 1) {
      replacementColumn[i] <- "WALKING"
    } 
    if(processDT[i,activity] == 2) {
      replacementColumn[i] <- "WALKING_UPSTAIRS"
    } 
    if(processDT[i,activity] == 3) {
      replacementColumn[i] <- "WALKING_DOWNSTAIRS"
    } 
    if(processDT[i,activity] == 4) {
      replacementColumn[i] <- "SITTING"
    } 
    if(processDT[i,activity] == 5) {
      replacementColumn[i] <- "STANDING"
    }
    if(processDT[i,activity] == 6) {
      replacementColumn[i] <- "LAYING"
    }
  }
  
  processDT[,2] <- replacementColumn
  return(processDT)
  
}