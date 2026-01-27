
% Generate training and target data for earthquake ANN model
% Prior to run this script, make sure the dataset: silver_m.csv is located at the folder C:\JCSU DHS SLA Summer 2024\Dataset.
% May 23, 2024

T = readtable('C:\\Artificial Intelligence Book\\Students\\Datasets\\Earthquake Dataset\\silver_m.csv');
N = 3000;                                                                % size of the training data

% One must use table2array() to convert read values in table to double array to save it as ascii file later. 
% Otherwise one maybe encounter a conversion error for unmatched data type.
LATI = table2array(T(1:N, 1))';                             % LATI is located at column 1 in database
LONG = table2array(T(1:N, 2))';                           % LONG is located at column 2 in database
DEPTH = table2array(T(1:N, 3))';                         % DEPTH is located at column 3 in database
HOUR = table2array(T(1:N, 6))';                           % HOUR is located at column 6 in dataset
MAG = table2array(T(1:N, 4))';                             % MAG is located at column 4 in database

inputData = [LATI; LONG; DEPTH; HOUR];          % the first 3000 data - training data
outputData = MAG;                                                  % the target data

save train_data.dat inputData -ascii
save target_data.dat outputData -ascii