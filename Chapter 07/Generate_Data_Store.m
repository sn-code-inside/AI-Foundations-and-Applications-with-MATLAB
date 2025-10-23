
% Name: Generate_Data_Store.m
% Convert training and checking data from silver_m to Data Store used for training DL Model with DND.
% The dataset is silver_m.csv 
% May 28, 2024

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_m.csv');
N = 3000;                                          % szie of the training and testing data

% Assign each column to a related local variable...
LATI = T(1:N, 1);                             % LATI is located at column 1 in database
LONG = T(1:N, 2);                           % LONG is located at column 2 in database
DEPTH = T(1:N, 3);                         % DEPTH is located at column 3 in database
HOUR = T(1:N, 6);                           % HOUR is located at column 6 in dataset
MAG = T(1:N, 4);                             % MAG is located at column 4 in database

trainDataInput = [LATI LONG DEPTH HOUR];          
trainDataOutput = MAG;

trainData = [trainDataInput trainDataOutput];
trainStore = arrayDatastore(trainData,"ReadSize", N, "OutputType","same");

LATI = T(N+1:2*N, 1);                             % LATI is located at column 1 in database
LONG = T(N+1:2*N, 2);                           % LONG is located at column 2 in database
DEPTH = T(N+1:2*N, 3);                         % DEPTH is located at column 3 in database
HOUR = T(N+1:2*N, 6);                           % HOUR is located at column 6 in dataset
MAG = T(N+1:2*N, 4);                             % MAG is located at column 4 in database

testDataInput = [LATI LONG DEPTH HOUR];                     
testDataOutput = MAG;
testData = [testDataInput testDataOutput];
testStore = arrayDatastore(testData,"ReadSize", N, "OutputType","same");


