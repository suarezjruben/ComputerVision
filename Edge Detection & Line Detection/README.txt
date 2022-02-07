Assignment 3
Author: Ruben Suarez Rodriguez
Student_id: A04052618 
Files: 	oriented_edges.m, road_orientation.m, blur_image.m, canny4.m, double_gray.m, 
	gradient_orientations.m, hysthresh.m, nonmaxsup.m

oriented_edges: 	result_img = oriented_edges(imgage, sigma, threshold, direction, tolerance)
			returns a binary image of pixels at requested orientation and within a specified
			threshold. Takes into acount thresholds < 0 and > 180.

road_orientation: 	orientation = road_orientation(image)
			takes in a grayscale image of a straigh road and computes and returns the angle
			the road is positioned in from top left corner.
			calls oriented_edges funtion to find edges of road and return their orientation.
			