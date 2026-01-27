
% Evaluate K-Means clustering with Diabetes Dataset - with Labels
% Name: Eval_Diabetes_Func.m
% Input: Diabetes.csv dataset
% Output: Evaluation results
% Date: Jul 8,2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600; 

GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                             % BMI is located at column 6 in database

X = [GLUCOSE BMI];
M = 1:N;

figure;
plot(M, X(:,1), 'r+', M, X(:,2),'k*', 'MarkerSize',5);
title 'Glucose and BMI Data';
xlabel 'Glucose'; 
ylabel 'BMI';
legend('Glucose', 'BMI');
grid;

eva = evalclusters(X, 'kmeans', 'silhouette', 'KList', 1:6)
[idx, C] = kmeans(X, eva.OptimalK);

figure;                                                                                                             % figure;
plot(X(idx==1,1), X(idx==1,2), 'r.','MarkerSize', 12)                         
hold on                                                                                                            % hold on
plot(X(idx==2,1), X(idx==2,2), 'b.','MarkerSize', 12)                              
plot(C(:,1), C(:,2), 'kx', 'MarkerSize',15,'LineWidth', 3) 
legend('Cluster 1','Cluster 2', 'Centroids', 'Location','SE')
title 'Cluster Assignments and Centroids'
grid;
hold off

MM = 602;
NN = 99;
GLUCOSE = table2array(T(MM:MM+NN, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(MM:MM+NN, 6));                             % BMI is located at column 6 in database
XX = [GLUCOSE BMI];
[icdx, C] = kmeans(XX, eva.OptimalK, 'Start','sample');

OUTPUT = table2array(T(MM:MM+NN, 9));                       % Get the Outcome column - Labels
icdx = changem(icdx, 0, 2);
msg =['sum(icdx == OUTPUT) = ',  num2str(sum(icdx== OUTPUT))];
disp(msg)
if (sum(icdx == OUTPUT) < 80)
    disp('Enter the if loop...')
    icdx = ~(icdx);
end
CR = ['The correct cluster rate is ', num2str(sum(icdx == OUTPUT)), '%'];
disp(CR)


