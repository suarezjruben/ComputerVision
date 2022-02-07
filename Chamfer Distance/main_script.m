%%

% The addpath and cd lines are the only lines in the code that you may have
% to change, in order to make the rest of the code work. Adjust
% the paths to reflect the locations where you have stored the code 
% and data in your computer.

restoredefaultpath;
clear all;
close all;

% Replace this path with your cs4379c-fall2021 git repository path in your system.
repo_path = 'G:\My Drive\School\Fall 2021\INTRO TO COMPUTER VISION\Git\Computer Vision';

s = filesep; % This gets the file separator character from the  system

addpath([repo_path s 'Code' s '00_common' s '00_detection'])
addpath([repo_path s 'Code' s '00_common' s '00_images'])
addpath([repo_path s 'Code' s '00_common' s '00_utilities'])
addpath([repo_path s 'Code' s '08_chamfer'])
cd([repo_path s 'Data' s '08_chamfer'])


%%

% read an image

clear; close all;
image = read_gray('clutter1.bmp');
figure(1); imshow(image, []);
e1 = canny(image, 7);
figure(2); imshow(e1);

%%

% read a template

t1 = read_gray('hand_lf1.bmp');

% resize template to scale that matches the hand size in the image
t1 = imresize(t1, 0.3, 'bilinear');

figure();imshow(t1);

% convert to binary image
t1 = t1 > 0;

% compute distance transform of edge image.
d1 = bwdist(e1);
[r, c] = size(t1);
figure();imshow(d1, []);



% extract window where hand is located.
i = 80; j = 100;
d1_frame = d1(i:(i+r-1), j:(j+c-1));
figure();imshow(d1_frame, []);
window = d1(i:(i+r-1), j:(j+c-1));

% compute chamfer distance from t1 to the window
sum1 = sum(sum(t1 .* window));

%%

% compute image of chamfer distance scores (from template
% to image windows) with no scaling

result = imfilter(d1, double(t1), 'symmetric');

% normalize result, to make scores between 0 and 1.
% normalize result, to make scores between 0 and 1.
result = result / max(max(result));
figure(1); imshow(e1);
figure(2); imshow(result < .04, []);

% superimpose results on top of original image.
figure(3); imshow(max(imagexdot5, (result < 0.04) * 255), []);

%%

% compute chamfer scores for a specific scale

s = 0.95;
resized = imresize(image, s, 'bilinear');
resized_edges = canny(resized, 7);
resized_dt = bwdist(resized_edges);
chamfer_scores = imfilter(resized_dt, double(t1), 'symmetric');

figure(3); imshow(chamfer_scores, []);
