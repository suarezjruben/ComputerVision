Assignment 1 
Author: Ruben Suarez Rodriguez
Student_id: A04052618 

Task 2 Description:
	For task 2 I reworked some of the code for task 1 until I was able to gather the largest area of motion.
	Once I had the largest area of motion, I set a threshold of 500, because I noticed that in all images where
	the human was partially visible, the area of the human motion was at least 500. The function does not work 
	if the visible area of the human is too small under 500 pixels.

Task 3 Description:
	For task 3 I called the find_bounding_box function twice with different image for each. I then took the 
	left-most column of the drawn rectangles and calculated the diference in pixels for each. 
	Then I called the parse_frame_name function for both images to get the frame number for both. Calculating
	the frame number difference I was able to come up with the speed in pixels per frame by dividing the pixel
	difference by the frame difference. 
	This function will work every time as long as there is a left (l) return from find_bounding_box function
	for each image used. 