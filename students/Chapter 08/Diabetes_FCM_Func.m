
% Using FCM to cluster Diabetes dataset
% Name: Diabetes_FCM_Func.m
% Input: two features in Diabetes.csv dataset
% Output: FCM clustering result
% June 28, 2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600; 

GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BLOODP = table2array(T(1:N, 3));                      % Blood Pressure is located at column 3 in database

X = [GLUCOSE BLOODP];

options = fcmOptions(NumClusters=2, Exponent=3.0, Verbose=true);
[centers, U] = fcm(X, options);

% Classify each data point into the cluster for which it has the highest degree of membership.
maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);

plot(X(index1,1), X(index1,2),"ob")
grid;
hold on
plot(X(index2,1), X(index2,2),"or")
plot(centers(1,1),centers(1,2),"xb",MarkerSize=25,LineWidth=5)
plot(centers(2,1),centers(2,2),"xr",MarkerSize=25,LineWidth=5)
xlabel("Glucose")
ylabel("Blood Pressure")
hold off
