%remove_holes.m
%Assignment 2
%Author: Ruben Suarez
%Date: 9/13/2021
%Course: CS 4379C Intro to Computer Vision

function result = remove_holes(image)
negated = ~image;
labels = bwlabel(negated);
holes = (labels > 1);
filled = negated - holes;
result = ~filled;




