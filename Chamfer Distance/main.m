%main
clear; close all;

%scale
scale = .9;

%Number of results
number_of_results = 2;

%read in image to gray
image = read_gray('clutter1.bmp');

%edge image
edge_image = canny(image, 7);

%template
template = read_gray('template.gif');


tic
[scores, result_image] = chamfer_search(edge_image, template, scale, number_of_results);
toc
figure();imshow(scores);
figure();imshow(result_image);

%read in image to gray
image = imread('clutter1.bmp');
tic
[scores, result_image] = skin_chamfer_search(image,edge_image, template, scale, number_of_results);
toc
figure();imshow(scores);
figure();imshow(result_image);