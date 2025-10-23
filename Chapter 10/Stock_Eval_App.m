
% Evaluation the ANFIS model performance - normalized dataset
% Name: Stock_Eval_App.m
% The stock model, ANFIS_Stock.fis, should have been built prior to running this one.
% Aug 11, 2024

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

stock_fis = readfis('ANFIS_Stock_App');

finput = [OPEN HIGH LOW VOLUME];  
foutput = evalfis(stock_fis, finput);
save foutput;

x = 1:N;
p = plot(x, foutput, 'b-o', x, CLOSE, 'r-o');
p(1).LineWidth = 2;
p(2).LineWidth = 2;
axis([1 20 0.4 1.1]);
legend('Predicted Stock Price','Actual Stock Price','Location','SouthWest')
grid;








