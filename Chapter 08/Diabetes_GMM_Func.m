
% Using fitgmdist() function to generate 2 fitted GMM and fit it with 2 clusters
% Name: Diabetes_GMM_Func.m
% Input: Diabetes.csv dataset
% Output: GMM cluster result
% Jul 3, 2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 600; 
k = 2;

GLUCOSE = table2array(T(1:N, 2));                     % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                              % BMI is located at column 6 in database
X = [GLUCOSE BMI];

eva = evalclusters(X, 'gmdistribution', 'silhouette', 'KList', 1:6)
figure(3)
plot(eva)
eva.OptimalK

options = statset('MaxIter',1000);
Sigma = 'diagonal';
%Sigma = 'full';

d = 500;                                                                    % Grid length
x1 = linspace(min(X(:,1))-2, max(X(:,1))+2, d);
x2 = linspace(min(X(:,2))-2, max(X(:,2))+2, d);
[x1grid, x2grid] = meshgrid(x1, x2);
X0 = [x1grid(:) x2grid(:)];

threshold = sqrt(chi2inv(0.99, 2));

for j = 1:2
    gmfit = fitgmdist(X, k, 'CovarianceType',Sigma, 'Options', options);
    clusterX = cluster(gmfit, X);                               % Cluster index 
    mahalDist = mahal(gmfit, X0);                           % Distance from each grid point to each GMM component
    % Draw ellipsoids over each GMM component and show clustering result.
    figure(j)
    h1 = gscatter(X(:,1), X(:,2), clusterX);
    hold on
    for m = 1:k
         idx = mahalDist(:, m) <= threshold;
         Color = h1(m).Color*0.75 - 0.5*(h1(m).Color - 1);
         h2 = plot(X0(idx, 1), X0(idx, 2), '.', 'Color', Color, 'MarkerSize', 1);
         uistack(h2, 'bottom');
     end    
     plot(gmfit.mu(:,1), gmfit.mu(:,2), 'kx', 'LineWidth', 2, 'MarkerSize', 10)
     title(sprintf('Sigma is %s\n', Sigma), 'FontSize', 8)
     legend(h1, {'1','2'})
     grid;
     hold off
end

