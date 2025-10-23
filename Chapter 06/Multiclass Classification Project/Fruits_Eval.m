
%  File Name: Fruits_Eval.m
%  Purpose: Evaluate trained model - categoryClassifier, with test data.
%  All test data is in C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\test_data folder.
%  Input: The trained model - categoryClassifier - shoul have been  in Workspace. To do it, run the Fruits_Classifier.m first.
%  Outputs: Evaluation results.
%  Note: Prior to running this project, run the project Fruits_Classifier.m first to get the trained model - categoryClassifier.
%  Y. Bai
%  Mar 1, 2024

numTrue = 0;                    % number of testing result who is true
numFalse = 0;                   % number of testing result who is false

% Apply the newly trained classifier to categorize new images.
M = 6;          % Number of classes - 6
N = 80;         % Number of test data, 80 for each class, with 6 classes, totally 480 test data.

for i = 1:M
    path = "C:\Artificial Intelligence Book\Students\Datasets\Fruit Dataset\test_data\" + imgFolds(i);   % source folders to get test images
        
    fp = fullfile(path, '*.jpg');
    f = dir(fp);
    imgName = {f.name};
   
    for k = 1:N
         fullFileName = fullfile(path, imgName{k});
         cImage{k} = imread(fullFileName);
         [labelIdx, score] = predict(categoryClassifier, cImage{k});
         YPred = categoryClassifier.Labels(labelIdx);
         fruit_class = imgFolds(i);
         fruit_result = YPred;
         result = ['Fruit Class =: ', fruit_class, 'Fruit Result =: ', fruit_result];
         %disp(result);             
        if cellfun(@isequal, fruit_class, fruit_result)
            numTrue = numTrue + 1;
        else
            numFalse = numFalse + 1;
        end
    end
    final = [newline, 'Matched Fruit =: ', num2str(numTrue), '  Unmatched Fruit =: ', num2str(numFalse)];
    disp(final);
end



