
% File Name: HOG_Fruits_Classifier.m
% Purpose: Training & evaluating a SVM model with fitcecoc() function for fruit images in 6 classes.
% Inputs: All train data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data folder.
%               All test data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\test_data folder.
% Input images classes: 6 
% Outputs: Tested results.
% Y. Bai
% Mar 1, 2024

imd = dir('C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\train_data\');   % setup the source image folder
isub = [imd(:).isdir];                                                                 % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];                         % get 6 sub folders excluding the . and .. operators.

setDir = fullfile('C:', 'Artificial Intelligence Book', 'Students', 'Datasets', 'Fruit Dataset', 'train_data', imgFolds);
imds = imageDatastore(setDir, 'LabelSource', 'foldernames', 'FileExtensions', {'.jpg'});

% show all images and labels
imds.Labels
imds.Files
imshow(imds.Files{1});

% setup training parameters and CNN model: 70% for training & 30% for validations
numTrain = 0.7;              % 70% car images are used for training, and 30% images are for validations 
[trainSet, testSet] = splitEachLabel(imds, numTrain);

% Extract HOG features & HOG visualization
img = readimage(trainSet, 300);
[hog_4x4, vis4x4] = extractHOGFeatures(img, 'CellSize', [4 4]);
hogFeatureSize = length(hog_4x4);
numImages = numel(trainSet.Files);
trainFeatures = zeros(numImages, hogFeatureSize, 'single');

for m = 1:numImages
    img = readimage(trainSet, m);
    trainFeatures(m, :) = extractHOGFeatures(img, 'CellSize', [4 4]);
end

% Get labels for each image.
trainLabels = trainSet.Labels;

% fitcecoc uses SVM learners and a 'One-vs-One' encoding scheme.
classifier = fitcecoc(trainFeatures, trainLabels);

% Extract HOG features from the test set. The procedure is similar to get HOG from trainSet above
numImages = numel(testSet.Files);
testFeatures = zeros(numImages, hogFeatureSize, 'single');

for n = 1:numImages
    img = readimage(testSet, n);   
    testFeatures(n, :) = extractHOGFeatures(img, 'CellSize', [4 4]);  
end

% Make class predictions using the test features.
predictedLabels = predict(classifier, testFeatures);

% Get labels for each image.
testLabels = testSet.Labels;

% Tabulate the results using a confusion matrix.
confMat = confusionmat(testLabels, predictedLabels);

helperDisplayConfusionMatrix(confMat);                    % call function to format and display confusion matrix

function helperDisplayConfusionMatrix(confMat)      % Display the confusion matrix in a formatted table.

% Convert confusion matrix into percentage form
confMat = bsxfun(@rdivide,confMat,sum(confMat,2));

digits = '1':'6';
colHeadings = arrayfun(@(x)sprintf('%d',x),1:6,'UniformOutput',false);
format = repmat('%-9s',1,11);
header = sprintf(format,'digit  |',colHeadings{:});
fprintf('\n%s\n%s\n',header,repmat('-',size(header)));
for idx = 1:numel(digits)
    fprintf('%-9s',   [digits(idx) '      |']);
    fprintf('%-9.2f', confMat(idx,:));
    fprintf('\n')
end
end

