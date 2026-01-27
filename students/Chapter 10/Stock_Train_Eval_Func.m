
% Train and evaluate the ANFIS model performance - normalized dataset via ANFIS Functions
% Name: Stock_Train_Eval_Func.m
% The Script file: Generate_Stock_Data.m should be run prior to running this program
% Aug 11, 2024

M = 25;                                 % Epoch number
load train_data.dat;
load check_data.dat;

genOpt = genfisOptions('GridPartition');
genOpt.NumMembershipFunctions = [3 3 3 3];
genOpt.InputMembershipFunctionType = 'gauss2mf';
genOpt.OutputMembershipFunctionType = 'linear';
inFIS = genfis(train_data(:, 1:4), train_data(:, 5), genOpt);

opt = anfisOptions('InitialFIS', inFIS, 'EpochNumber', M);
opt.DisplayANFISInformation = 1;
opt.DisplayErrorValues = 1;
opt.DisplayStepSize = 0;
opt.DisplayFinalResults = 1;
opt.ValidationData = check_data;

[fis, trainError, stepSize, chkFIS, chkError] = anfis(train_data, opt);
x = 1:M;
figure
plot(x, trainError, '.b', x, chkError, '*r');              % plot RMS value on ANFIS for each epoch 
legend('Training Error', 'Checking Error', 'Location', 'NorthWest');
grid;

path = 'C:\Artificial Intelligence Book\Students\Datasets\Google Stock DataSet\';
name = 'Google_Stock_Price_Test.csv';
fname = strcat(path, name);
T = readtable(fname);                                                            
N = 20;               % max row number in testing dataset - 20

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

finput = [OPEN HIGH LOW VOLUME];  
foutput = evalfis(fis, finput);
save foutput;

figure
x = 1:N;
p = plot(x, foutput, 'b-o', x, CLOSE, 'r-o');
p(1).LineWidth = 2;
p(2).LineWidth = 2;
grid;
legend('Predicted Stock Price', 'Actual Stock Price', 'Location', 'NorthWest')









