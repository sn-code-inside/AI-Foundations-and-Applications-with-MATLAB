
% Name: ANN_App_Eval.m
% Evaluate the trained Deep Learning model.
% Prior to running this script, run Project 11 to generate the trained model ANN_MAG_Model & export to Workspace
% The dataset is silver_test.csv that is a collection of data rows 8000 ~ 8100 from the original dataset silver.csv
% May 23, 2024
% Y. Bai

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_test.csv');
N = 100;                                                                % szie of the testing data

% Assign each column to a related local variable...
LATI = table2array(T(1:N, 1))';                             % LATI is located at column 1 in database
LONG = table2array(T(1:N, 2))';                           % LONG is located at column 2 in database
DEPTH = table2array(T(1:N, 3))';                         % DEPTH is located at column 3 in database
HOUR = table2array(T(1:N, 6))';                           % HOUR is located at column 6 in dataset

input = [LATI; LONG; DEPTH; HOUR];                       % The 100 testing data

% One must use table2array() to convert the output mag to double array to plot it later. 
target = table2array(T(1:N, 4))';      % MAG is located at column 4 in database

outputs = ANN_MAG_Model.Network(input);
errors = gsubtract(outputs, target);
performance = perform(ANN_MAG_Model.Network, target, outputs)

view(ANN_MAG_Model.Network)

% Plots Results
figure, plotperform(ANN_MAG_Model.TrainingResults)
figure, plottrainstate(ANN_MAG_Model.TrainingResults)
figure, plotfit(ANN_MAG_Model.Network, input, target)
figure, plotregression(target, outputs)
figure, ploterrhist(errors)





