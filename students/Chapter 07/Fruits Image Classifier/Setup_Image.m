
% File Name: Setup_Image.m
% Pick up source fruit data and store them into 6 sub folders under the folder, fruit_train_data, to prepare to save the pre-processed images.
% The source folder, C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\train_data\ + imgFolds(i), where all original fruit images are located 
% June. 3, 2024
% Y. Bai

n = 0;              % sequence number
M = 6;              % number for sub folders (classes) under the current folder: Tomato 3, Tomato 4, Tomato Cherry Red, Tomato Maroon, ...
N = 20;             % number of test images in the fruit_test_data folder

train_path = "C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_train_data\";
test_path = "C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_test_data\";
orig_path = "C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\train_data\";

% get all 6 sub folders, imgFolds(i), where all original fruit images are stored
imd = dir('C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\train_data\');       % setup source fruit image folder
isub = [imd(:).isdir];                                                % returns logical vector
imgFolds = {imd(isub).name}';
imgFolds(ismember(imgFolds,{'.','..'})) = [];       % get all 6 sub folders excluding the . and .. operators.

% create 6 sub folders under the train folder: ..\fruit_train_data
cd 'C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_train_data\';
for i = 1:M
    ifold = string(imgFolds(i));
    mkdir(ifold);
end

for i = 1:M
    impath = train_path + imgFolds(i);                          % target folder to save the processed images
    path = orig_path + imgFolds(i);                                % source folders to get original images
    fp = fullfile(path, '*.jpg');
    f = dir(fp);
    imgName = {f.name};
   
    for k = 1:numel(imgName)
        n = n + 1;
        fullFileName = fullfile(path, imgName{k});      
        sImg = imread(fullFileName);
        imshow(fullFileName);
        imgfullname = fullfile(impath, imgName{k}); 
        imwrite(sImg, imgfullname);
        n
    end
end

% get top 20 fruit images from the fruit_train_data folder & save them to the fruit_test_data as the testing data to be used later
% create 6 sub folders under the target test folder: ..\fruit_test_data
cd 'C:\Artificial Intelligence Book\Students\Datasets\Fruit Image Dataset\fruit_test_data\'
for i = 1:M
    ifold = string(imgFolds(i));
    mkdir(ifold);
end

for j = 1:M
    impath = test_path + imgFolds(j);       % target folder to save the test images
    path = train_path +  imgFolds(j);         % source folders to get processed images
    fp = fullfile(path, '*.jpg');
    f = dir(fp);
    imgName = {f.name};
    
    for k = 1:N
        fullFileName = fullfile(path, imgName{k});
        cImage{k} = imread(fullFileName);
        delete(fullFileName);
        imgfullname = fullfile(impath, imgName{k}); 
        imwrite(cImage{k}, imgfullname);
    end
end

% END





