%task_2.m
%Assignment 2
%Author: Ruben Suarez
%Date: 9/13/2021
%Course: CS 4379C Intro to Computer Vision
restoredefaultpath;
clear all;
close all;

% Replace this path with your repository path that holds the
% soccer_field4.jpg image
%addpath('G:\My Drive\School\Fall 2021\INTRO TO COMPUTER VISION\Assignments\2\Data');
stadium = double(imread('soccer_field4.jpg'));

red = stadium(:,:,1);
green = stadium(:,:,2);
blue = stadium(:,:,3);

%Soccer field
field = ((green - red > 20 ) & (green - blue > 20));
field = remove_holes(field);
field = remove_holes(~field);
field = ~field;
figure(1); imshow(field); title('Field');

%Red team players
red_players = ((red - green > 100 ) & (red - blue > 100));
red_players = red_players - ~field;
figure(2); imshow(red_players); title('Red players');

%Blue team players
blue_players = ((blue - red > 30 ) & (blue - green > 30));
blue_players = blue_players - ~field;
figure(3); imshow(blue_players); title('Blue players');


