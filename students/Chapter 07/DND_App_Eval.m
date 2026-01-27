
% Name: DND_App_Eval.m
% Evaluate the trained Deep Learning model with Deep Network Designer.
% Prior to running this script, run Generate_Data_Store.m and generate the trained model trainedNetwork_1 & export to Workspace
% The dataset is silver_test.csv that is a collection of data rows 8000 ~ 8100 from the original dataset silver.csv
% May 29, 2024

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_test.csv');
N = 100;                                                                % size of the testing data

% Assign each column to a related local variable...
LATI = table2array(T(1:N, 1));                             % LATI is located at column 1 in database
LONG = table2array(T(1:N, 2));                           % LONG is located at column 2 in database
DEPTH = table2array(T(1:N, 3));                         % DEPTH is located at column 3 in database
HOUR = table2array(T(1:N, 6));                           % HOUR is located at column 6 in dataset

input = [LATI; LONG; DEPTH; HOUR];                  % The 100 testing data

% One must use table2array() to convert the output mag to double array to plot it later. 
target = table2array(T(1:N, 4));                            % MAG is located at column 4 in database
target = repmat(target, 4);
outputs = predict(trainedNetwork_1, input);
errors = gsubtract(outputs, target);

% Plots Evaluation Results
x = 1:400;
figure, plot(x, abs(errors'));
xlabel('The absolute errors between the predicted and the actual outputs');
grid;
figure, plot(trainInfoStruct_1.TrainingRMSE); 
xlabel('The training RMSE values');
grid;

