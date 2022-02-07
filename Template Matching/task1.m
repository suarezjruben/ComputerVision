restoredefaultpath;
clear all;
close all;


load_mnist;

%finding 2's and 3's locations 
twos_locations = [];
threes_loactions = [];
for i = 1:10000
    label = mnist_labels(i);
    if label == 2
        twos_locations{end+1}=i;
    end
    if label == 3
        threes_loactions{end+1}=i;
    end
end

average2 = zeros(28, 28);
average3 = zeros(28, 28);
twos_size = numel(twos_locations);
threes_size = numel(threes_loactions);

%averaging all images with label '2'
for index = 1:twos_size
    image2 = mnist_digits(:,:,twos_locations{index});
    average2 = average2 + image2;
end

%averaging all images with label '3'
for index = 1:threes_size
    image3 = mnist_digits(:,:,threes_loactions{index});
    average3 = average3 + image3;
end

if ~isfloat(average2 & average3)
    average2 = double(average2);
    average3 = double(average3);
end

%converting average2 and average3 to range [0 255]
target_range = 255;
low = min(average2(:));
high = max(average2(:));
range = high - low;
average2 = (average2 - low) * target_range / range ;

low = min(average3(:));
high = max(average3(:));
range = high - low;
average3 = (average3 - low) * target_range / range ;

%displayig and saving average2 and average3
figure(1);imshow(average2, []);
figure(2);imshow(average3, []);
imwrite(uint8(average2), 'average2.gif');
imwrite(uint8(average3), 'average3.gif');


