
% Name: Fruits_Eval.m
% Func: Load the trained net, f_imageNet, and evaluate it with fruits testing data
% June 5, 2024

n = 0;                                 % loop counter
M = 6;                                % number of classes is 6: Tomato 3, Tomato 4, Tomato Cherry Red, Tomato Maroon, Tomato Yellow and Walnut
N = 20;                              % number of fruit testing data - images
T = 120;                             % number of total fruit testing data (images)
numTrue = 0;                    % number of result who is true
numFalse = 0;                   % number of result who is false

sz = [20 2];
cTypes = ["string","string"];
cNames = ["Fruit Class","Fruit Result"];
eResult1 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
eResult2 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
eResult3 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
eResult4 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
%eResult5 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
%eResult6 = table("Size", sz, "Fruit Type", cTypes, "Fruit Name", cNames);
csResult = {eResult1, eResult2, eResult3, eResult4};

% load the trained net model
cd 'C:\Artificial Intelligence Book\Students\Class Projects\Chapter 8\Fruits Image Classifier\';
load f_imageNet;
imgNet = f_imageNet;

% load all fruits testing data
imd = dir('C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_test_data\');   % setup the test image folder
isub = [imd(:).isdir];                                                               % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];                      % get all 6 sub folders excluding the . and .. operators.

cPath = "C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_test_data\" ;
for i = 1:M
    path = cPath + imgFolds(i);   % source folders to get test images
        
    fp = fullfile(path, '*.jpg');
    f = dir(fp);
    imgName = {f.name};
   
    for k = 1:N
        n = n + 1;
        fullFileName = fullfile(path, imgName{k});
        %imshow(fullFileName);
        cImage{k} = imread(fullFileName);
        YPred = classify(imgNet, cImage{k});
        fruit_class = imgFolds(i);
        fruit_result = YPred;
        result(:, 1:4) = ['Fruit Class =: ', fruit_class, 'Fruit Result =: ', fruit_result];
        csResult(k,:) = cellstr(result(:, 1:4));
        if k == N
           csResult(k,:) = cellstr(result(:, 1:4))
        end
        if fruit_class == fruit_result
            numTrue = numTrue + 1;
        else
            numFalse = numFalse + 1;
        end
    end
    
    final = ['Matched Fruit =: ', num2str(numTrue), '  Unmatched Fruit =: ', num2str(numFalse)];
    disp(final);
end
    
% END
