
% Digit audio evaluation (digit audio word - 0 ~  9)
% Name: Digit_Audio_Evaluation.m
% Input: Trained model Mdl obtained from the running result of project Digit_Audio_Classification.m
% Output: Evaluated digit sounds result
% Note: Prior to running this project, run the project Digit_Audio_Classification.m first to get Mdl
% March 15, 2024

cd 'C:\Artificial Intelligence Book\Students\Datasets\FSDD\recordings\';

[x, fs] = audioread('5_theo_30.wav');
sound(x, fs);
Label = {5};

t = (0:numel(x)-1)/fs;
figure
plot(t, x)
title("Label: " + Label)
grid on
axis tight
ylabel("Amplitude")
xlabel("Time (s)")

afe = audioFeatureExtractor(SampleRate=fs, Window=hann(round(0.03*fs), "periodic"), ...
          OverlapLength=round(0.02*fs));

% Set all feature extractors to true to enable all of them
[idx, params] = info(afe, "all");
cfeatures = fieldnames(idx);
for i = 1:numel(cfeatures)
    afe.(cfeatures{i}) = true;
end

% Extract features from analysis windows.
yPerWindow = extract(afe, x);
numFeatures = 30;
selectedFeatureIndex = featureSelectionIdx(1:numFeatures);

% Predict the correct label per window.
t = predict(Mdl, yPerWindow(:, selectedFeatureIndex));
trueLabel = Label
predictionsPerWindow = categorical(t')

% Create a file-level prediction by taking the mode of window-level predictions.
prediction = mode(predictionsPerWindow)

% end


















