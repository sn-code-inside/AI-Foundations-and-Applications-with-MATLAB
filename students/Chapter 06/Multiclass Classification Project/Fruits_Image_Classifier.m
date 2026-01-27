
% File Name: Fruits_Image_Classifier.m
% Purpose: The complete training codes to train a SVM model with fruit images for 6 classes.
% Inputs: All train data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data folder.
% Input images classes: 6 
% Outputs: Trained SVM model named categoryClassfier.
%
% Y. Bai
% Mar 1, 2024

imd = dir('C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data\');   % setup the source image folder
isub = [imd(:).isdir];                                                                                   % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];                                          % get 6 sub folders excluding the . and .. operators.

setDir = fullfile('C:', 'Artificial Intelligence Book', 'Students', 'Datasets', 'Fruit Dataset', 'train_data', imgFolds);
imds = imageDatastore(setDir, 'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

% show all images and labels
imds.Labels
imds.Files

% setup training parameters: 70% for training & 30% for validations
numTrain = 0.7;              % 70% car images are used for training, and 30% images are for validations 
[trainSet, testSet] = splitEachLabel(imds, numTrain);

% Create bag of visual words.
bag = bagOfFeatures(trainSet);

% Train a classifier with the training sets.
categoryClassifier = trainImageCategoryClassifier(trainSet, bag);

% Evaluate the classifier using test images. Display the confusion matrix
confMatrix = evaluate(categoryClassifier, testSet)

% Get the average accuracy of the classification.
mean(diag(confMatrix))

% save trained model to Workspace and folder (not necessary here)
cd 'C:\Artificial Intelligence Book\Students\Class Projects\Chapter 8\Multiclass Classification Project\'
save categoryClassifier;






