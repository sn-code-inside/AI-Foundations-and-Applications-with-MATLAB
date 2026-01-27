
% Use K-Means clustering to cluster Earthquake Perception Dataset
% Name: Earthquake_KM_Func.m
% Input: Earthquake_Emotion.csv dataset
% Output: Clustering results
% Date: June 20,2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Earthquake Emotion\\Earthquake Emotion.csv';
T = readtable(path);
N = 300;                                                                 % use the first 300 observations as k-means clustering

% Assign each column to a related local variable...
AGE = table2array(T(1:N, 1));                             % Age is located at column 1 in database
FAMILY_NO = table2array(T(1:N, 2));               % Number of persons is located at column 2 in database
FLOOR = table2array(T(1:N, 3));                         % Floor is located at column 3 in database
SHOCK = table2array(T(1:N, 4));                         % Shock is located at column 4 in dataset
FEAR = table2array(T(1:N, 5));                            % Fear is located at column 5 in database

X = [AGE FAMILY_NO FLOOR SHOCK FEAR];   
XX = X(:, 1:2);
M = 1:N;

figure;
plot(M, XX(:,1), 'r+', M, XX(:,2),'k*', 'MarkerSize',5);
title 'Age and Family Member Data';
xlabel 'Age'; 
ylabel 'Family Member';
legend('Age', 'Family Member');
grid;

[idx, C] = kmeans(X, 3);

figure;                                                                                                             % figure;
plot(XX(idx==1,1), XX(idx==1,2), 'r.','MarkerSize', 12)                         % gscatter(XX(:,1), XX(:,2), idx, 'bgm')
hold on                                                                                                            % hold on
plot(XX(idx==2,1), XX(idx==2,2), 'b.','MarkerSize', 12)                         % plot(C(:,1), C(:,2), 'kx')
plot(XX(idx==3,1), XX(idx==3,2), 'g.','MarkerSize', 12)                         % legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid')

plot(C(:,1), C(:,2), 'kx', 'MarkerSize',15,'LineWidth', 3) 
legend('Cluster 1','Cluster 2', 'Cluster 3', 'Centroids', 'Location','SE')
title 'Cluster Assignments and Centroids'
grid;
hold off

