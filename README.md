# Getting And Cleaning Data Project
## David Ritchie 24/10/2015

run_analysis.R processes the datasets in the 'datasets' folder, and produces a tidy dataset out of it.
The datasets folder contains the original readme and codebooks for the input datasets.  These should not be be confused
with the codebooks for this script, which are based on the original but are different.

In order to run the script the input files should be moved to the working directory or the run_analysis.R script.

Input Files:

	*	subject_test.txt
	*	y_test.txt
	*	x_test.txt
	*	subject_train.txt
	*	y_train.txt
	*	x_train.txt
	
The script creates a test and train dataset by merging the respective files, then makes an overall dataset by merging the test and train datasets.

After the datasets have been merged the script extracts the columns which contain mean and standard deviation data for each subject and activity.  The
rest of the data is discarded.
This extracted intermediate dataset then has the activity variable updated to reflect the textual value of the activity.

Finally this dataset is grouped by subject and activity, and the mean of all the included variables are calculated.
This dataset is then output as the file subjectActivity.txt

The columns of the output dataset are contained within columns.txt

Attribute Information:

For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

