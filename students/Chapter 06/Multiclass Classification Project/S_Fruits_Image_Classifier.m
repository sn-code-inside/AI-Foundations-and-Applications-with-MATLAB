
% File Name: Fruits_Classifier.m
% Purpose: The complete training codes to train a model with fruit images for 6 classes.
% Inputs: all train data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data folder.
% Input images classes: 6 
% Outputs: Trained net model named categoryClassfier.
% Notes: all train & test data should be in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data & test_data folder.
% Y. Bai
% Feb 28, 2024

imd = dir('C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data\');   % setup the source image folder
isub = [imd(:).isdir];                                                                 % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];                                          % get 6 sub folders excluding the . and .. operators.

setDir = fullfile('C:', 'Artificial Intelligence Book', 'Students', 'Datasets', 'Fruit Dataset', 'train_data', imgFolds);
imds = imageDatastore(setDir, 'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

% show all images and labels
imds.Labels
imds.Files

% setup training parameters and CNN model: 70% for training & 30% for validations
numTrain = 0.7;              % 70% car images are used for training, and 30% images are for validations 
[trainSet, testSet] = splitEachLabel(imds, numTrain);
inputSize = [100 100 3];
numClasses = 6;

% Create bag of visual words.
bag = bagOfFeatures(trainSet);
t = templateSVM('Type', 'classification');

% Train a classifier with the training sets.
categoryClassifier = trainImageCategoryClassifier(trainSet, bag, 'LearnerOptions', t);

% Evaluate the classifier using test images. Display the confusion matrix
confMatrix = evaluate(categoryClassifier, testSet)

% Get the average accuracy of the classification.
mean(diag(confMatrix))

% Apply the newly trained classifier to categorize new images.
cd 'C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\test_data\Apple';
img = imread('3_100.jpg');
[labelIdx, score] = predict(categoryClassifier, img);
categoryClassifier.Labels(labelIdx)







