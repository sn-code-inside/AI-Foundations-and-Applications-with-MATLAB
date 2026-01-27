
% Test to train stock price model with nonlinear regression method
% Nam: stock_ensemble_treebagger_func.m
% Input: Google_Stock_Price_Train.csv

M = 20;             % testing data with 20 rows
T1 = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\Google Stock Dataset\\" + ...
                            "Google_Stock_Price_Train.csv");
T2 = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\Google Stock Dataset\\" + ...
                           "Google_Stock_Price_Test.csv");

% Use ensemble tree algorithm to train the model
X = table(T1.Open/max(T1.Open), T1.High/max(T1.High), T1.Low/max(T1.Low), ...
                  str2double(T1.Volume)/max(str2double(T1.Volume)));
Y = T1.Close/max(T1.Close);
mdl_1 = fitrensemble(X, Y);

Xnew = table(T2.Open/max(T2.Open), T2.High/max(T2.High), T2.Low/max(T2.Low), ...
                         str2double(T2.Volume)/max(str2double(T2.Volume)));
Y1 = predict(mdl_1, Xnew);
Yact = T2.Close/max(T2.Close);

% Use fitnlm() function to fit the model
tbl = table(T1.Open/max(T1.Open), T1.High/max(T1.High), T1.Low/max(T1.Low), ...
                   str2double(T1.Volume)/max(str2double(T1.Volume)), T1.Close/max(T1.Close));
modelfun = @(b,x)b(1) + b(2)*x(:,1).^b(3) + b(4)*x(:,2).^b(5) + b(6)*x(:,3).^b(7) + b(8)*x(:, 4).^b(9);
%beta0 = [-50 500 -1 500 -1 500 -1 500 -1];
beta0 = [50 500 -1 500 -1 200 -1 500 -1];
mdl_2 = fitnlm(tbl, modelfun, beta0);
Y2 = feval(mdl_2, Xnew);

% Use TreeBagger() and formula to define the model as Close = Open + High + Low + Volume 
mdl_3 = TreeBagger(100, X, Y, Method="regression", NumPredictorsToSample=50);
Y3 = predict(mdl_3, Xnew);

XX = 1:M;
figure(1)
plot(XX, Yact, "b-", XX, Y1, "ro--", XX, Y2, "g+:", XX, Y3, "m*-.", 'LineWidth', 1);
axis([0 20 0.8 1.05]);
grid;
legend(["Actual Stock Price","Ensemble Prediction","fitnlm() Prediction", "TreeBagger() Prediction"], ...
               "Location","northwest");
xlabel('Stock Price Per Day - 20 Days');
ylabel('Stock Prices Predictions');

Yact = detrend(T2.Close/max(T2.Close));
Y1 = detrend(Y1);
Y2 = detrend(Y2);
Y3 = detrend(Y3);

err_1 = Yact - Y1;
err_2 = Yact - Y2;
err_3 = Yact - Y3;

figure(2)
plot(XX, err_1, "bo-", XX, err_2, "r+-", XX, err_3, "m*-")
grid;
legend(["Ensemble Prediction Error","fitnlm() Prediction Error", "TreeBagger() Prediction Error"], ...
               "Location","northwest");
xlabel('Stock Price Per Day - 20 Days');
ylabel('Stock Prices Prediction Errors');
err_sum = abs([max(abs(err_1)) min(abs(err_1)) rmse(Y1, Yact);
                            max(abs(err_2)) min(abs(err_2)) rmse(Y2, Yact);
                            max(abs(err_3)) min(abs(err_3)) rmse(Y3, Yact)])




