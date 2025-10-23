
% Evaluate the clustering result without using the output labels
% Name: Eval_Diabetes_NL_Func.m
% Input: Diabetes.csv dataset
% Output: Evaluated clustering results
% Date: Jul 9,2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
T = readtable(path);                                                            
N = 500; 

GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                             % BMI is located at column 6 in database

X = [GLUCOSE BMI];
M = 1:N;
eva = evalclusters(X, 'kmeans', 'silhouette', 'KList', 1:6)
[idx, C] = kmeans(X, eva.OptimalK);

figure;                                                                                                             % figure;
plot(X(idx==1,1), X(idx==1,2), 'r.','MarkerSize', 12)                         
hold on                                                                                                            % hold on
plot(X(idx==2,1), X(idx==2,2), 'b.','MarkerSize', 12)                              % plot(C(:,1), C(:,2), 'kx')

plot(C(:,1), C(:,2), 'kx', 'MarkerSize',15,'LineWidth', 3) 
legend('Cluster 1','Cluster 2', 'Centroids', 'Location','SE')
title 'Cluster Assignments and Centroids'
grid;
hold off

MM = 502;
NN = 99;
GLUCOSE = table2array(T(MM:MM+NN, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(MM:MM+NN, 6));                             % BMI is located at column 6 in database

XX = [GLUCOSE BMI];
[icdx, C] = kmeans(XX, eva.OptimalK);

m_XC1 = mean(X(idx==1, :));
m_XC2 = mean(X(idx==2, :));
if m_XC1 < m_XC2
    mXC = m_XC1;
    m_XC1 = m_XC2;
    m_XC2 = mXC;
end
%m_XC1
%m_XC2

XC= zeros(100, 1);
mup_Limit = 165;

for j = 1:NN+1
    m = mean((XX(j, 1) + XX(j, 2)));
    if m > mup_Limit
        XC(j) = 1;
    else
        XC(j) = 2;
    end
end

if sum(XC == icdx) <50
    disp('Enter the if loop...')
    icdx = reverse(icdx, NN+1);
end

sum(XC == icdx)

CR = ['The correct clustering rate is ', num2str(sum(XC==icdx)), '%'];
disp(CR)

function cidx = reverse(x, n)
for i = 1:n
    if x(i) == 1
        x(i) = 2;
    else
        x(i) = 1;
    end
    cidx = x;
end
end

