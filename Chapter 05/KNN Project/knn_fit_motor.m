
% Test KNN Regression for our DC motor system
% Name: knn_fit_motor.m
% Dataset is nl_motor.xls
% 
T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\nl_motor.xls");

cVol = T.inputVol
cMSP = T.motorSP
Xnew = [1 1.2 1.1 1.3 1.5 1.8 2.1 2.0 2.2 2.8 3.0 3.1 7.2 7.5 8.1 8.3 8.7 8.8 9.5 9.1 9.3 12.2 15.5 15.7 16.1... 
                16.8 18.2 19 20.3 20.8 21.1 21.8 22]';

K = 5;
metric = 'euclidean';
weights = {'uniform', 'distance'};

for i = 1:2
    mdl = kNNeighborsRegressor(K,metric,weights(i));
    mdl = mdl.fit(cVol, cMSP);
    Ypred = mdl.predict(Xnew);
    subplot(2,1,i)
    plot(cVol,cMSP,'o', Xnew, Ypred)
    grid;
    legend('data','prediction')
    title(strcat('kNNeighborsRegressor (K = 5, metric = ''euclidean'', weights = ''', weights(i), ''')'))
end

cd 'C:\\Artificial Intelligence Book\\Students\\Class Projects\\Chapter 5\\KNN Project';
saveas(gcf, 'Regression_results', 'jpeg')
