
% Name: Deep_MAG_Func.m
% Using deep training and testing functions to build a deep neural network for earthquake dataset
% May 30, 2024

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_m.csv');
N = 3000;                                          % size of the training and testing data

% Assign each column to a related local variable...
LATI = table2array(T(1:N, 1))';                             % LATI is located at column 1 in database - 1x3000 array
LONG = table2array(T(1:N, 2))';                           % LONG is located at column 2 in database - 1x3000 array
DEPTH = table2array(T(1:N, 3))';                         % DEPTH is located at column 3 in database - 1x3000 array
HOUR = table2array(T(1:N, 6))';                           % HOUR is located at column 6 in dataset - 1x3000 array
MAG = table2array(T(1:N, 4))';                             % MAG is located at column 4 in database - 1x3000 array

trainData = [LATI; LONG; DEPTH; HOUR];           % 4x3000 training data matrix
targetData = MAG;                                                  % 1x3000 target data matrix

layers = [
                sequenceInputLayer(3000, Normalization="zscore")
                lstmLayer(100, OutputMode="last")
                fullyConnectedLayer(3000)
                reluLayer
                fullyConnectedLayer(3000)]

%{
options = trainingOptions("sgdm", ...
   ValidationData={1:3000, targetData}, ...
    MaxEpochs=150, ...
    Verbose=false, ...
    OutputNetwork="best-validation", ...
    Plots="training-progress", ...
    Metrics="rmse");
%}

options = trainingOptions("sgdm", ...
    MaxEpochs=150, ...
    Verbose=false, ...
    Plots="training-progress", ...
    Metrics="rmse");

net = trainnet(trainData, targetData, layers, "mse", options)




