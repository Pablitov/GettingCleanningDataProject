# Code book for the Getting and Cleanning Data course.

This codebook contains the description of the information needed to characterize the UCI HAR Dataset, namely:
1. Identifiers
2. Variables

Detailed information may be found in the README.txt file


## 1. Identifiers

There are two main identifiers * Subject: identifier of the subject who performed the activity for each window sample. * Activity: the following list contains the names of the activities made by the users while utilizing the devices:
1.WALKING
2.WALKING UPSTAIRS
3.WALKING DOWNSTAIRS
4.SITTING
5.STANDING
6.LAYING


## 2. Variables

Variable names are composed by concatenation of the following letters and codes:
1.A letter: t denotes time, f denotes frequency (obtained via Finally a Fast Fourier Transform)
2.A suffix indicating whether the 3-axial raw signals (XYZ) belongs to the device accelerometer (Acc) or the gyroscope (Gyro), which measure acceleration and angular speed respectively.
3.A suffix indicating the body (Body) or gravity (Gravity) components of the acceleration (Acc) signal.
4.A “Jerk” suffix indicating the Time derivatives sginal -Jerk signals- of the acceleration and angular speed
5.The set of variables that were estimated from these signals are:
•mean(): Mean value
•std(): Standard deviation
•mad(): Median absolute deviation
•max(): Largest value in array
•min(): Smallest value in array
•sma(): Signal magnitude area
•energy(): Energy measure. Sum of the squares divided by the number of values.
•iqr(): Interquartile range
•entropy(): Signal entropy
•arCoeff(): Autorregresion coefficients with Burg order equal to 4
•correlation(): correlation coefficient between two signals
•maxInds(): index of the frequency component with largest magnitude
•meanFreq(): Weighted average of the frequency components to obtain a mean frequency
•skewness(): skewness of the frequency domain signal
•kurtosis(): kurtosis of the frequency domain signal
•bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
•angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:
•gravityMean
•tBodyAccMean
•tBodyAccJerkMean
•tBodyGyroMean
•tBodyGyroJerkMean

The complete list of variables of each feature vector is available in ‘features.txt’
