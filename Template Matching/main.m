clear all;
close all;

%addpath('G:\My Drive\School\Fall 2021\INTRO TO COMPUTER VISION\Assignments\6\test_data')
addpath('test_data');
image = imread('test34.bmp');
image = im2gray(image);
average2 = imread('average2.gif');
average3 = imread('average3.gif');
coordinates = detect_digit(image, average3);

close all;
threes = 0;
twos = 0;
image_prefix = 'test';
image_postfix = '.bmp';
for i = 1:40
    s = strcat(image_prefix, num2str(i), image_postfix);
    image = imread(s);
    image = im2gray(image);
    result = recognize_digit(image, average2, average3);
    if result == 2
        twos = twos + 1;
    else
        threes = threes + 1;
    end
    disp(result);
    
end
    

