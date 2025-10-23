
% Use Hierarchical clustering to cluster Diabetes Dataset
% Name: Diabetes_HC_Func.m
% Input: Diabetes.csv dataset (768 by 9 size), we only need 600 by 5 as clustering data
% Output: Clustering results
% Date: June 25,2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600;                                                                 % Size of data for hierarchical clustering

% Assign each column to a related local variable...
GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BLOODP = table2array(T(1:N, 3));                      % Blood Pressure is located at column 3 in database
BMI = table2array(T(1:N, 6));                             % BMI is located at column 6 in database
PEDIGREE = table2array(T(1:N, 7));                   % Pedigree is located at column 7 in dataset
AGE = table2array(T(1:N, 8));                              % Age is located at column 8 in database

X = [GLUCOSE BLOODP BMI PEDIGREE AGE]     % get input observation matrix: 10 observations (10-row)

D = pdist(X);                                                            % get Eucidean distances
Y = squareform(D);
Z = linkage(D)                                                         % get similar clusters
figure 
dendrogram(Z)                                                        % plot hierarhical clustering tree

T1 = cluster(Z, "cutoff", 20)
T2 = cluster(Z,"maxclust",6)
T3 = cluster(Z,"maxclust",2)







