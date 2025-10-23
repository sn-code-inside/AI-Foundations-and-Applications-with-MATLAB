
% Name: Deep_MAG_Func_Eval.m
% Evaluate the trained Deep Learning model.
% Prior to running this script, run Deep_MAG_Func.m to generate the trained model net & export to Workspace
% The dataset is silver_m.csv and we will use the 2nd 3000 data as the testing data
% May 31, 2024

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_m.csv');
N = 3000;               % size of the testing data
M = 50;                   % length or number of data points along the x-axis in plot                  

% Assign each column to a related local variable...
LATI = table2array(T(N+1:2*N, 1))';                             % LATI is located at column 1 in database
LONG = table2array(T(N+1:2*N, 2))';                           % LONG is located at column 2 in database
DEPTH = table2array(T(N+1:2*N, 3))';                         % DEPTH is located at column 3 in database
HOUR = table2array(T(N+1:2*N, 6))';                           % HOUR is located at column 6 in dataset

input = [LATI; LONG; DEPTH; HOUR];                            % The 2nd 3000 testing data

% One must use table2array() to convert the output mag to double array to plot it later. 
target = table2array(T(N+1:2*N, 4))';                           % MAG is located at column 4 in database
target = single(target);                                                    % convert target to 1x3000 single array

% calculate the predicted MAG with the trained model
y = net.predict(input);
%y = predict(net, input);
e = gsubtract(target, y);
error = rmse(y, target)                                                     % get RMSE value between the predicted & actual MAG

% Plots Evaluation Results in the first 50 data points
x = 1:M;
figure, plot(x, y(1:M),'*r-', x, target(1:M), '.b-');    % Need to transpose MAG & preMAG since they are 100 x 1 array
legend('Predicted MAG','Actual MAG', 'Location','SouthEast');
grid;




