
% Name: Animal_Sounds_Classify.m
% Func: Train the animal-sound net model with deep learning
% Dataset: Animal Sounds Data located at: C:\Artificial Intelligence Book\Students\Datasets
% June 6, 2024

mPath = "C:\Artificial Intelligence Book\Students\Datasets\Animal Sounds Data\";
datafolder = fullfile(mPath, 'Train Data');

ads = audioDatastore(datafolder, ...
    'IncludeSubfolders', true, ...
    'FileExtensions', '.wav', ...
    'LabelSource', 'foldernames');

fs = 44100;                             % sampling time for melspectrogram
for i = 1:length(ads.Files)
    [filepath, filename, ext] = fileparts(ads.Files{i});
    audiodata = read(ads);
    if length(audiodata) < fs
        audiodata = [audiodata; audiodata];
    end
    spath = fullfile(filepath, filename);
    % save spectrogram as image
    spectro(audiodata, fs, spath);
end

move_file(ads);
imds = imageDatastore(fullfile('C:\Artificial Intelligence Book', 'Students', 'Datasets', ...
             'Animal Sounds Data', 'Spectrograms'), 'IncludeSubfolders', true,'LabelSource',...
             'foldernames','ReadFcn',@(f) imresize(imread(f),[100 100]));

[trainImgs, valImgs, testImgs] = splitEachLabel(imds, 0.8, 0.1, 0.1, 'randomized');
numClasses = numel(categories(trainImgs.Labels));
%dropoutProb = 0.2;

inputSize = [100 100 3];
layers = [
   imageInputLayer(inputSize); 
   reluLayer
   fullyConnectedLayer(numClasses);
   softmaxLayer();
   classificationLayer()];
      
options = trainingOptions('adam', ...
    'Plots','training-progress', ...
    'MiniBatchSize', 32, ...
    'ValidationData', valImgs) 

net = trainNetwork(trainImgs, layers, options);
s_trainedNet = net;
save s_trainedNet;
f_path = 'C:\Artificial Intelligence Book\Students\Class Projects\Chapter 8\';
s_path = 'Animal Sounds Classifier\s_trainedNet.mat';
save_path = append(f_path, s_path);
save(save_path, 's_trainedNet');

% test the classification ressult and accuracy
predict = classify(net,testImgs)
acc = mean(testImgs.Labels == predict)*100;
word = ['Classification accuracy = ', num2str(acc), '%']; 
disp(word);

% plot confusion matrix
confusionchart(testImgs.Labels, predict)

function spectro(audiodata, fs, path)
    melSpectrogram(audiodata, fs);
    colorbar ('off');
    axis off;
    f = gcf;
    saveas(f,path,'jpg');
    % crop spectrogram data only
    file = [path, '.jpg'];
    img = imread(file);
    crop_im = imcrop(img,[115 50 675 535]);
    imwrite(crop_im, file, "jpg");
end

% move spectrogram image to according folder
function move_file(ads)
    mPath = "C:\Artificial Intelligence Book\Students\Datasets\Animal Sounds Data\";
    num_labels=countEachLabel(ads);
    num_cate = categories(num_labels.Label);
    for i=1:numel(num_cate)
        source_folder = fullfile(mPath, 'Train Data', num_cate{i});
        source_imds = imageDatastore(source_folder, "FileExtensions", '.jpg');
        des_folder = fullfile(mPath,'\Spectrograms' , num_cate{i});
        mkdir (des_folder);
        for j=1: length(source_imds.Files)
            movefile (source_imds.Files{j}, des_folder);
        end
    end
end









