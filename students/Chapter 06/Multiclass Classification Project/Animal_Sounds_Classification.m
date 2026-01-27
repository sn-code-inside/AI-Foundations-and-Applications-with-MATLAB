
% Animal sounds feature extract and classifications for selected sounds - 4 animal sounds.
% Name: Animal_Sounds_Classification.m
% Input: Animal sounds signals located at folder - C:\Artificial Intelligence Book\Students\Datasets\Animal Sounds\
% Output: Classified noise sounds result - confusion table
% March 15, 2024

ads = dir('C:\Artificial Intelligence Book\Students\Datasets\Animal Sounds\');   % setup the source sounds folder
isub = [ads(:).isdir];                                                                                   % returns logical vector
adsFolds = {ads(isub).name}';
adsFolds(ismember(adsFolds,{'.','..'})) = [];                                          % get 4 sub folders excluding the . and .. operators.

dataset = fullfile('C:', 'Artificial Intelligence Book', 'Students', 'Datasets', 'Animal Sounds', adsFolds);
ads = audioDatastore(dataset, 'LabelSource', 'foldernames', 'FileExtensions', {'.wav'});

% show all sounds and labels
ads.Labels
ads.Files

[adsTrain, adsTest] = splitEachLabel(ads, 0.85);            % Split all input sounds into two parts: training and testing
[x, xinfo] = read(adsTrain);
sound(x, xinfo.SampleRate);

% Display a sample sound - Chicken sound
t = (0:numel(x)-1)/xinfo.SampleRate;
figure
plot(t, x)
title("Label: ", xinfo.Label)
grid on
axis tight
ylabel("Amplitude")
xlabel("Time (s)")

afe = audioFeatureExtractor(SampleRate=xinfo.SampleRate, ...
          Window=hann(round(0.03*xinfo.SampleRate), "periodic"), ...
          OverlapLength=round(0.02*xinfo.SampleRate));

% Set all feature extractors to true to enable all of them
[idx, params] = info(afe, "all");
cfeatures = fieldnames(idx);
for i = 1:numel(cfeatures)
    afe.(cfeatures{i}) = true;
end

% Extract feature matrix structure
featureMatrix = extract(afe, x);
[numWindows, numFeatures] = size(featureMatrix);
outputMap = info(afe)

% Extract features and remove 3D feature cells
features = extract(afe, adsTrain, SampleRateMismatchRule="resample");
for k = 1: numel(features)
    [row, col] = size(features{k, :});
    if col >922                 % the normal cell size is 2D with A x 922 columns, but for 3D cells, it still shows as 2D with bigger column number.
        features{k, :} = [];
    end
end

N = cellfun(@(x)size(x, 1), features);
T = repelem((adsTrain.Labels), N);
X = cat(1, features{:});
[featureSelectionIdx, featureSelectionScores] = fscmrmr(X, T);

% Training the model with fitcknn() function
numFeatures = 30;
selectedFeatureIndex = featureSelectionIdx(1:numFeatures);
Mdl_Animal = fitcknn(X(:, selectedFeatureIndex),T, Standardize=true);

% Evaluate trained model. Read a sample from the test set. Listen to the sample and plot its waveform.
[x, xInfo] = read(adsTest);
sound(x, xInfo.SampleRate);

% Extract features from analysis windows.
yPerWindow = extract(afe, x);

% Predict the correct label per window.
t = predict(Mdl_Animal, yPerWindow(:, selectedFeatureIndex));
trueLabel = categorical(xInfo.Label);
predictionsPerWindow = categorical(t');

% Create a file-level prediction by taking the mode of window-level predictions.
prediction = mode(predictionsPerWindow)

% Analyze the whole-word performance over the entire test set.
Tfile = categorical(adsTest.Labels);
featuresTest = extract(afe, adsTest, SampleRateMismatchRule="resample");
Y = cellfun(@(x)mode(categorical(predict(Mdl_Animal, x(:,selectedFeatureIndex)))), featuresTest, UniformOutput=false);
Y = cat(1, Y{:});

figure
confusionchart(Tfile,Y,Title="Accuracy = " + 100*mean(Tfile==Y) + " (%)")

% end


















