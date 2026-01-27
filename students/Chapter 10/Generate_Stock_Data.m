
% Program used to generate the training/checking data for the stock project
% (Normalized dataset)
% Name: Generate_Stock_Data.m
% Aug 10, 2024

path = 'C:\Artificial Intelligence Book\Students\Datasets\Google Stock DataSet\Google_Stock_Price_Train.csv';
T = readtable(path);                                                            
N = 600;               % max row number in dataset - 600

OPEN = table2array(T(1:N, 2));
HIGH = table2array(T(1:N, 3));
LOW = table2array(T(1:N, 4));
VOLUME = str2double(table2array(T(1:N, 6)));
CLOSE = table2array(T(1:N, 5));

% Normalize all columns for training data
OPEN = OPEN/max(OPEN);
HIGH = HIGH/max(HIGH);
LOW = LOW/max(LOW);
VOLUME = VOLUME/max(VOLUME);
CLOSE = CLOSE/max(CLOSE);

TrainData = [OPEN HIGH LOW VOLUME CLOSE];       % the first 600 data - training data
 
M = 601;                % Start the second or checking data row from 601

OPEN = table2array(T(M:2*N, 2));
HIGH = table2array(T(M:2*N, 3));
LOW = table2array(T(M:2*N, 4));
VOLUME = str2double(table2array(T(M:2*N, 6)));
CLOSE = table2array(T(M:2*N, 5));

% Normalize all columns for checking data
OPEN = OPEN/max(OPEN);
HIGH = HIGH/max(HIGH);
LOW = LOW/max(LOW);
VOLUME = VOLUME/max(VOLUME);
CLOSE = CLOSE/max(CLOSE);

ChkData = [OPEN HIGH LOW VOLUME CLOSE];       % the second 600 data - checking data
 
save train_data.dat TrainData -ascii
save check_data.dat ChkData -ascii


