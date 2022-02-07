%clear all;
%close all;

%% loading mnist
load_mnist;

%% finding 3's locations 
threes_loactions = [];
for i = 1:10000
    label = mnist_labels(i);
    if label == 3
        threes_loactions{end+1}=i;
    end
end

%% creating set of training images for 3
threes_size = numel(threes_loactions);
image_size = 28*28;
threes = zeros(image_size, threes_size);
for index = 1:threes_size
    image3 = mnist_digits(:,:,threes_loactions{index});
    threes(:, index) = image3(:);
end

%% normalizing training set of threes
% set mean of all elements of set to 0, and std to 1.
number3 = size(threes, 2);
for index = 1: number3
    three = threes(:, index);
    three = (three - mean(three)) / std(three);
    threes(:, index) = three;
end
[average3, eigenvectors3, eigenvalues3] = compute_pca(threes);

%% displaying top 5 eigenvectors
for i = 1:5
    figure(i);imshow(reshape(eigenvectors3(:, i),28, 28),[]);
end

%figure();imshow(reshape(average3, 28, 28),[]);












