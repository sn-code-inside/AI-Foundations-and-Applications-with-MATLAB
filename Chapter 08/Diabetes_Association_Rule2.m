
% Find association rules for modified dataset - Diabetes_AR.csv
% Name: Diabetes_Association_Rule.m
% Input: Modified dataset - Diabetes_AR.csv
% Output: Association rules
% Jul 10, 2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes_AR.csv';
T = readtable(path);                                                            
N = 200;
A = 0;
B = 0;
C = 0;

BP = table2array(T(1:N, 3));                                % Blood presure is located at column 1 in database
AGE = table2array(T(1:N, 4));                             % Age is located at column 4 in database
OUTPUT = table2array(T(1:N, 5));                      % Outcome is located at column 5 in database

X = [BP AGE OUTPUT];

for i = 1:N
    if (X(i, 1) == 1) && (X(i, 2) == 1) && (X(i, 3) == 1)
        A = A + 1;
    end
    if (X(i, 1) == 1) && (X(i, 2) == 1)
        B = B + 1;
    end
    if (X(i, 3) == 1) 
        C = C + 1;
    end
end

Support = A/N                                   % Support calculation
Confidence = A/B                              % Confidence calculation
D = B/N;                                             % Support X
E = C/N;                                              % Support Y

AR = Support * Confidence               % Support * Confidence
Lift = Support / (D*E)                        % Lift calculation


