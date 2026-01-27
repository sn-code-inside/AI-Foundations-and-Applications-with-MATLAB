
% Use testing data to evaluate K-Means clustering for Earthquake Perception Dataset
% Name: Eval_Earthquake_KM_Func.m
% Input: Earthquake_Emotion.csv dataset
% Output: Clustering evaluation results
% Date: June 22,2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Emotion\\Earthquake Emotion.csv';
T = readtable(path);                                                            
N = 300;                                                                 % Size of data for k-means clustering

% Assign each column to a related local variable...
AGE = table2array(T(1:N, 1));                             % Age is located at column 1 in database
FAMILY_NO = table2array(T(1:N, 2));                % Number of persons is located at column 2 in database
FLOOR = table2array(T(1:N, 3));                         % Floor is located at column 3 in database
SHOCK = table2array(T(1:N, 4));                         % Shock is located at column 4 in dataset
FEAR = table2array(T(1:N, 5));                            % Fear is located at column 5 in database

X = [AGE FAMILY_NO FLOOR SHOCK FEAR];   
[idx, C] = kmeans(X, 3);

figure                                                                        % plot the k-means clustering result
gscatter(X(:,1), X(:,2), idx, 'bgm')
hold on
plot(C(:,1), C(:,2),'kx', 'MarkerSize', 15, 'LineWidth', 3)
legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid', 'Location', 'northeast', 'fontSize', 7.5);
axis([10 100 0 6]);
grid;
                                             
N = 301;                                                                     % using the rest of 172 observations as testing data
P = 171;

% get the testing data for clustering
AGE = table2array(T(N:N+P, 1));                          % Age is located at column 1 in database
FAMILY_NO = table2array(T(N:N+P, 2));            % Number of persons is located at column 2 in database
FLOOR = table2array(T(N:N+P, 3));                     % Floor is located at column 3 in database
SHOCK = table2array(T(N:N+P, 4));                     % Shock is located at column 4 in dataset
FEAR = table2array(T(N:N+P, 5));                        % Fear is located at column 5 in database

Xtest = [AGE FAMILY_NO FLOOR SHOCK FEAR];       % test data matrix

[D, idx_test] = pdist2(C, Xtest, 'euclidean', 'Smallest', 1);

gscatter(Xtest(:,1), Xtest(:,2), idx_test, 'bgm', 'ooo')
legend('Cluster 1', 'Cluster 2', 'Cluster 3', 'Cluster Centroid', 'Test Data-C1','Test Data-C2', 'Test Data-C3');




