
% Name: Shallow_MAG_Func.m
% Using shallow training and testing functions to build a shallow neural network for earthquake dataset
% May 29, 2024

T = readtable('C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Dataset\\silver_m.csv');
N = 3000;                                          % size of the training and testing data

% Assign each column to a related local variable...
LATI = table2array(T(1:N, 1))';                             % LATI is located at column 1 in database
LONG = table2array(T(1:N, 2))';                           % LONG is located at column 2 in database
DEPTH = table2array(T(1:N, 3))';                         % DEPTH is located at column 3 in database
HOUR = table2array(T(1:N, 6))';                           % HOUR is located at column 6 in dataset
MAG = table2array(T(1:N, 4))';                             % MAG is located at column 4 in database

trainData = [LATI; LONG; DEPTH; HOUR];   
targetData = MAG;

% Choose a Training Function, For a list of all training functions type: help nntrain
% 'trainlm' is usually fastest; 'trainbr' takes longer but may be better for challenging problems.
% 'trainscg' uses less memory. 
trainFcn = 'trainlm'; % Levenberg-Marquardt backpropagation.

% Create a shallow neural network
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize, trainFcn);
%net = fitrnet(trainData, targetData);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;
[net, tr] = train(net, trainData, targetData);

% Test the Network
y = net(trainData);
e = gsubtract(targetData, y);
performance = perform(net, targetData, y)

% View the Network
view(net)

% Plots training and testing results
figure, plotperform(tr);
figure, plottrainstate(tr);
figure, ploterrhist(e);
figure, plotregression(targetData, y);


