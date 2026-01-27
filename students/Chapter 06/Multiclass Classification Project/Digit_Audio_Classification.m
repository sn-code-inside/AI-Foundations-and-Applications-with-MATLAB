
% Digit audio feature extract and classifications (digit audio word - 0 ~  9)
% Name: Digit_Audio_Classification.m
% Input: Digit 0 - 9 audio signals located at folder - C:\Artificial Intelligence Book\Students\Datasets\FSDD\
% Output: Classified digit sounds result - confusion table
% March 14, 2024

dataset = 'C:\Artificial Intelligence Book\Students\Datasets\FSDD\';
ads = audioDatastore(dataset, IncludeSubfolders=true);
[~, filenames] = fileparts(ads.Files);
ads.Labels = extractBefore(filenames, "_");

[adsTrain, adsTest] = splitEachLabel(ads, 0.85);
[x, xinfo] = read(adsTrain);
sound(x, xinfo.SampleRate)

t = (0:numel(x)-1)/xinfo.SampleRate;
figure
plot(t, x)
title("Label: " + xinfo.Label)
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

features = extract(afe, adsTrain);
N = cellfun(@(x)size(x, 1), features);
T = repelem((adsTrain.Labels), N);
X = cat(1, features{:});
[featureSelectionIdx, featureSelectionScores] = fscmrmr(X, T);

% Training the model with fitcknn() function
numFeatures = 30;
selectedFeatureIndex = featureSelectionIdx(1:numFeatures);
Mdl = fitcknn(X(:, selectedFeatureIndex),T, Standardize=true);

% Evaluate trained model. Read a sample from the test set. 
[x, xInfo] = read(adsTest);
sound(x, xInfo.SampleRate)

% Extract features from analysis windows.
yPerWindow = extract(afe, x);

% Predict the correct label per window.
t = predict(Mdl, yPerWindow(:, selectedFeatureIndex));
trueLabel = categorical(xInfo.Label)
predictionsPerWindow = categorical(t')

% Create a file-level prediction by taking the mode of window-level predictions.
prediction = mode(predictionsPerWindow)

% Analyze the whole-word performance over the entire test set.
Tfile = categorical(adsTest.Labels);
featuresTest = extract(afe, adsTest, UseParallel=canUseParallelPool);
Y = cellfun(@(x)mode(categorical(predict(Mdl, x(:, selectedFeatureIndex)))), featuresTest, UniformOutput=false);
Y = cat(1, Y{:});

figure
confusionchart(Tfile, Y, Title="Accuracy = " + 100*mean(Tfile==Y) + " (%)")

% end


















