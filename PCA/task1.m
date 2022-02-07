%clear all;
%close all;

%% loading mnist
load_mnist;

%% finding 2's locations 
twos_locations = [];
for i = 1:10000
    label = mnist_labels(i);
    if label == 2
        twos_locations{end+1}=i;
    end
end

%% creating set of training images for 2 
twos_size = numel(twos_locations);
image_size = 28*28;
twos = zeros(image_size, twos_size); 
for index = 1:twos_size
    image2 = mnist_digits(:,:,twos_locations{index});
    twos(:, index) = image2(:);
end

%% normalizing training set of twos 
% set mean of all set elements to 0, and std to 1.
number2 = size(twos, 2);
for index = 1: number2
    two = twos(:, index);
    two = (two - mean(two)) / std(two);
    twos(:, index) = two;
end
[average2, eigenvectors2, eigenvalues2] = compute_pca(twos);

%% displaying top 5 eigenvectors
for i = 1:5
    figure(i);imshow(reshape(eigenvectors2(:, i),28, 28),[]);
end












