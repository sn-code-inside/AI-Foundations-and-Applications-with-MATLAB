
% Using fcm with three features to cluster Diabetes dataset
% Name: Diabetes_FCM3_Func.m
% Input: Diabetes.csv dataset
% Output: Clustering results

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600; 

GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BLOODP = table2array(T(1:N, 3));                      % Blood Pressure is located at column 3 in database
BMI = table2array(T(1:N, 6));  

X = [GLUCOSE BLOODP BMI]

options = fcmOptions(NumClusters=3, Exponent=3.0, Verbose=true);
[centers, U, ~, info] = fcm(X, options);
NC = info.OptimalNumClusters

maxU = max(U);
index1 = find(U(1,:) == maxU);
index2 = find(U(2,:) == maxU);
index3 = find(U(3,:) == maxU);

figure
scatter3(X(index1, 1), X(index1, 2), X(index1, 3), "ob")
grid;
hold on
scatter3(X(index2, 1), X(index2, 2), X(index2, 3), "or")
scatter3(X(index3, 1), X(index3, 2), X(index3, 3), "oy")
plot3(centers(1,1), centers(1,2), centers(1,3), "xk",MarkerSize=25,LineWidth=5)
plot3(centers(2,1), centers(2,2), centers(2,3), "xk",MarkerSize=25,LineWidth=5)
plot3(centers(3,1), centers(3,2), centers(3,3), "xk",MarkerSize=25,LineWidth=5)
xlabel("Glucose")
ylabel("Blood Pressure")
zlabel("BMI")
hold off
grid;
