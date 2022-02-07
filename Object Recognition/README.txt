Assignment 8 - Image Moments and Nearest Neighbor Classification
Author: Ruben Suarez Rodriguez
Net_id: jrs208
Student_id: A04052618 

Task 1
Description: 	For this task I created a function central_moment(shape, i, j) that returns the (i,j) central moment of shape.

Task 2
Description: 	For this task I created a function normalized_moment(shape, i, j) that returns the (i,j) normalized central moment of shape.

Task 3
Description: 	For this task I created a function hu_moment(shape, m) that returns the mth Hu moment of shape.

Task 4
Description: 	For this task I created a function classify_digit_cm(digit, database) that classifies a digit image and returns a value from 0 to 9.
		The digit parameter is a digit image that gets converted to a binary image by the use of a condition statement (image > 0), where all pixel values
		grater than 0 will return 1 (true) and get replaced by the number 1. Then, 10 central moments are extracted from the binary image and inserted into a
		vector. I decided to do 10 central moment extractions because I wanted the euclidean distance to be as precise as possible with minimum calculations.
		I picked moment of order up to 3 so that only data related to the center of detected figure is measured. Accuracy rate was 72%

Task 5
Description: 	For this task I created a function classify_digit_nm(digit, database) that has the same function as classify_digit_cm but extracts normalized central moments
		from the image instead. Same moment of order were used for this function which resulted in a lower accuracy rate. I believe the lower accuracy might be due
		to the added complexity of of the normalized contral moments and because it was not used in conjunction with the central moments extraction.
		Accuracy rate was 65%

Task 6
Description: 	For this task I created a function classify_digit_hu(digit, database) has the same function as classify_digit_cm  but extracts Hu moments from the image instead. 
		Extracted all 7 Hu moments for each image. Accuracy rate was even lower at 37%. I belive the added complexity and being used on its own had an effect on the accuracy.



Files: 		raw_moment.m, central_moment.m, normalized_moment.m, hu_moment.m, classify_digit_cm.m, classify_digit_nm.m, classify_digit_hu.m, load_mnist.m, scrambled_mnist10000.bin, euclidean_dist.m,
				
		**Must load mnist data**
		**All files are necessary for program to run successfully!**


		
		

