

%% Loading Dataset

load faces1000;
load nonfaces1000;

%% Splitting dataset 70/30

% Training dataset
TrainingFaces = faces(:,:,1:700);
TrainingNonFaces = nonfaces(:,:,1:700);
Xtrain = cat(3,TrainingFaces,TrainingNonFaces);
Ytrain = ones(1, 1400);
Ytrain(1, 701:end) = 0;
% Testing dataset
TestFaces = faces(:,:,701:end);
TestNonFaces = nonfaces(:,:,701:end);
Xtest = cat(3,TestFaces, TestNonFaces);
Ytest = ones(1, 600);
Ytest(1, 301:end) = 0;

%% Data network transform

h = size(Xtrain, 1);
w = size(Xtrain, 2);
c = 1;

N_train = size(Xtrain, 3); % number of training samples (1400)

Xtrain = reshape(Xtrain, [h, w, c, N_train]);
Ytrain = categorical(Ytrain);

N_test = size(Xtest, 3); % number of test samples (600)

Xtest = reshape(Xtest, [h, w, c, N_test]);
Ytest = categorical(Ytest);

%% Defining network architecture and parameters

layers = [
    imageInputLayer([h w c]) % Dimensions of a single input image.
    
    convolution2dLayer(3, 8, 'Padding','same') % 1st convolutional layer.
    batchNormalizationLayer                    % Batch normalization.
    reluLayer                                  % ReLU activation. 
    
    maxPooling2dLayer(2, 'Stride', 2)          % Max pooling.
    
    convolution2dLayer(3, 16, 'Padding', 'same')% 2nd convolutional layer.
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2, 'Stride', 2)
    
    convolution2dLayer(3, 32, 'Padding', 'same')% 3rd convolutional layer.
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer];

% Show a summary of the layers
%layers

%% Specify Training Options

options = trainingOptions('sgdm', ... % Stochastic gradient descent with momentum.
    'InitialLearnRate', 0.01, ...     % Learning rate.
    'MaxEpochs', 4, ...               % How many epochs to train.
    'Shuffle', 'every-epoch', ...     % Shuffle the training data every epoch.
    'Verbose', true, ...              % Show the progress of the training process.
    'Plots', 'training-progress');    % Plot diagrams of the training process.

%% Train Network Using Training Data

net = trainNetwork(Xtrain, Ytrain, layers, options);


%% Classify Test Images and Compute Accuracy

% Predict the labels of the test data using the trained network, and 
% calculate the final test accuracy. 

Ypred = classify(net, Xtest); % Predict labels of test data.

probY = predict(net, Xtest); % this wil return prediction probabilities for
                             % each class instead of a class label.
                             % This can be useful when we want to know how
                             % confident the classifier is about each class.
                             
                             

% Accuracy is the fraction of labels that the network predicts correctly. 
% In this case, about 97% of the predicted labels match the 
% true labels of the test set.
accuracy = sum(Ypred == Ytest(:))/numel(Ytest)*100;
accuracy = strcat('accuracy=', string(accuracy), '%');
disp(accuracy);

% % Compute confusion matrix
% C = confusionmat(Ytest, Ypred);
% C % show confusion matrix as text
% 
% % Plot a basic confusion matrix chart
% figure; confusionchart(C); % or confusionchart(Ytest, Ypred);
% 
% % Plot a more detailed confusion matrix chart
% figure; plotconfusion(Ytest(:), Ypred);
% 
% 
% %% 
% 
% % Just for fun: find which samples were missclassified
% 
% idxs = find(Ypred ~= Ytest(:));
% Yt = Ytest(:);
% comaprison = [Ypred(idxs), Yt(idxs)];
% 
% % Display the misclassified images
% figure;
% grid_cols = 3;
% grid_rows = ceil(size(idxs,1)/10);
% 
% for i = 1:size(idxs, 1)
%     subplot(grid_rows,grid_cols,i);
%     imshow(Xtest(:,:,idxs(i)));
%     title(strcat('pred:', string(Ypred(idxs(i))), ' true:', string(Yt(idxs(i)))));
% end
% 
% 
% 
%% Test
% t1 = Xtest(:,:,1:5);
% figure;imshow(t1(:,:,1), []);
% t2 = nonfaces(:,:,1:5);
% 
% figure();imshow(Xtest(:,:, idxs(3)), []);
% figure();imshow(t2(:,:, 1), []);
% 
% test = cat(3, t1, t2);
% figure();imshow(test(:,:, 1), []);
% figure();imshow(test(:,:, 10), []);



