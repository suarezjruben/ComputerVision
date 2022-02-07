%task_3.m
%Assignment 2
%Author: Ruben Suarez
%Date: 9/13/2021
%Course: CS 4379C Intro to Computer Vision
restoredefaultpath;
clear all;
close all;

% Replace this path with your repository path that holds the
% ocean2.jpg image
%addpath('G:\My Drive\School\Fall 2021\INTRO TO COMPUTER VISION\Assignments\2\Data');
ocean = imread('ocean2.jpg');
ocean = double(ocean);
neighborhood = [1 1 1; 1 1 1; 1 1 1];

%Sky area
sky_area = (ocean > 190);
eroded = imerode(sky_area, neighborhood); 
sky_area = ~(remove_holes(~eroded));
figure(); imshow(sky_area, []); title('Showing the sky area');



%Tree line
tree_line = (ocean > 100);
tree_line = remove_holes(~tree_line);

%Mountain line
mount_line = (ocean > 150);
eroded = imerode(mount_line, neighborhood);
mount_line = ~(remove_holes(~eroded));
eroded = imerode(mount_line, neighborhood);
mount_line = ~(remove_holes(~eroded));
eroded = imerode(mount_line, neighborhood);
mount_line = ~(remove_holes(~eroded));
test = abs(sky_area - mount_line);
sky_area = sky_area + test;

%Ocean area
ocean_area = (ocean > 300);
ocean_area = ocean_area + tree_line;
ocean_area = ocean_area + sky_area + tree_line;
ocean_area = ~ocean_area;
ocean_area =+ abs(ocean_area - test);
figure(); imshow(ocean_area, []); title('Showing the ocean area');





