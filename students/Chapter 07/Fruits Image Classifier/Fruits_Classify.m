
% File Name: Fruits_Classify.m
% Purpose: The complete deep learning training codes to train a DL model with fruit images for 6 classes.
% Inputs: Preprocessed images data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_train_data folders.
% Input images numbers: Tomato 3 = 357, Tomato 4 = 458, Tomato Cherry Red = 472, Tomato Maroon = 347, Tomato Yellow = 439, Walnut = 715 
% Outputs: Trained net model f_imageNet.mat & saved it to C:\Artificial Intelligence Book\Students\Class Projects\Chapter 8\Fruits Image Classifier folder.
% Notes: The file Setup_Image.m should be run first prior to runing this code to prepare all images to be used for this one.
% June 3, 2024

trained_path = 'C:\Artificial Intelligence Book\Students\Class Projects\';
trained_name = 'Chapter 8\Fruits Image Classifier\f_imageNet.mat';
save_path = append(trained_path, trained_name);
train_path = 'C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_train_data\';

imd = dir(train_path);    % setup the train source image folder
isub = [imd(:).isdir];                                                                 % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];                         % get 6 sub folders excluding the . and .. operators.

imds = imageDatastore(fullfile('C:', 'Artificial Intelligence Book', 'Students', 'Datasets', 'Fruit Image Dataset', ...
                                                       'fruit_train_data', imgFolds), 'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

% show all images and labels
imds.Labels
imds.Files

% setup training parameters and CNN model: 70% for training & 30% for validations
numTrain = 0.7;                            % 70% fruits images are used for training, and 30% images are for validations 
[imdsTrain,imdsValidation] = splitEachLabel(imds,numTrain);
inputSize = [100 100 3];
numClasses = 6;

layers = [
    imageInputLayer(inputSize)
    %convolution2dLayer(3,16, 'Padding', 'same')
    batchNormalizationLayer
    reluLayer
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

options = trainingOptions('adam', ...
    'InitialLearnRate',0.001, ...
    'MaxEpochs',6, ...
    'miniBatchSize', 10, ...
    'ValidationData',imdsValidation, ...
    'ValidationFrequency',40, ...
    'Verbose',false, ...
    'Plots','training-progress');
    
% training network with input images, layers and options...
net = trainNetwork(imdsTrain, layers, options);
f_imageNet = net;
save f_imageNet;
save(save_path, 'f_imageNet');

% END






