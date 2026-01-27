
% Modify the Diabetes.csv to make it as boolean dataset
% Name: Modify_Diabetes.m
% Input: Source dataset - Diabetes.csv
% Output: Target dataset - Diabetes_AR.csv
% Jul 10, 2024

s_path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes.csv';
t_path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes_AR.csv';
T = readtable(s_path);                                                            
N = 200;

GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                             % BMI is located at column 6 in database
BP =  table2array(T(1:N, 3));                              % Blood pressure is located at column 3 in database
AGE =  table2array(T(1:N, 8));                            % Age is located at column 8 in database
OUTPUT = table2array(T(1:N, 9));                      % Outcome is located at column 9 in database

mid = median([GLUCOSE BMI BP AGE])

for i = 1:N
    if GLUCOSE(i, :) >= mid(:, 1)
        GLUCOSE(i, :) = 1;
    else
        GLUCOSE(i, :) = 0;
    end
    if BMI(i, :) >= mid(:, 2)
        BMI(i, :) = 1;
    else
        BMI(i, :) = 0;
    end
    if BP(i, :) >= mid(:, 3)
        BP(i, :) = 1;
    else
        BP(i, :) = 0;
    end
    if AGE(i, :) >= mid(:, 4)
        AGE(i, :) = 1;
    else
        AGE(i, :) = 0;
    end
end

Tab = {'Glucose', 'BMI', 'BloodPressure', 'Age', 'Outcome'};
X = [GLUCOSE BMI  BP AGE OUTPUT];
writecell(Tab, t_path);
writematrix(X, t_path, 'WriteMode', 'append');






