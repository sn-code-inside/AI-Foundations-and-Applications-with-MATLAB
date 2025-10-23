
% Find the optimal cluster number for GMM clustering model with Diabetes dataset
% Name: Find_Optimal_NCluster.m
% Input: Diabetes.csv dataset
% Output: Optimal cluster number
% Jul 6, 2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600; 
k = 2;

GLUCOSE = table2array(T(1:N, 2));                     % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                              % BMI is located at column 6 in database
X = [GLUCOSE BMI];

%eva = evalclusters(X, 'gmdistribution', 'silhouette', 'KList', 1:6)
eva = evalclusters(X, 'kmeans', 'silhouette', 'KList', 1:6)
figure(1)
plot(eva)
grid;

figure(2)
clusters = eva.OptimalY;
gscatter(X(:,1), X(:,2), clusters, [], "xod")
grid;




