
% Modify the heart1_M.xlsx to make it as boolean dataset
% Name: Modify_Heart.m
% Input: Source dataset - heart1_M.xlsx
% Output: Target dataset - Heart_AR.csv
% Jul 17, 2024

s_path = 'C:\\Artificial Intelligence Book\Students\Datasets\Heart Dataset\\heart1_M.xlsx';
t_path = 'C:\\Artificial Intelligence Book\Students\Datasets\Heart Dataset\\Heart_AR.csv';
T = readtable(s_path);                                                            
N = 280;
%{
GLUCOSE = table2array(T(1:N, 2));                    % Glucose is located at column 2 in database
BMI = table2array(T(1:N, 6));                             % BMI is located at column 6 in database
BP =  table2array(T(1:N, 3));                              % Blood pressure is located at column 3 in database
AGE =  table2array(T(1:N, 8));                            % Age is located at column 8 in database
OUTPUT = table2array(T(1:N, 9));                      % Outcome is located at column 9 in database
%}
AGE = table2array(T(1:N, 1));                             % Age is located at column 1 in database
CHOL = table2array(T(1:N, 5));                           % Chol is located at column 5 in database
OLDPEAK = table2array(T(1:N, 10));                  % Oldpeak is located at column 10 in database
TRTBPS = table2array(T(1:N, 4));                       % Trtbps is located at column 4 in database
OUTPUT = table2array(T(1:N, 14));                    % Outcome is located at column 14 in dataset


mid = median([AGE CHOL OLDPEAK TRTBPS])

for i = 1:N
    if AGE(i, :) >= mid(:, 1)
        AGE(i, :) = 1;
    else
        AGE(i, :) = 0;
    end
    if CHOL(i, :) >= mid(:, 2)
        CHOL(i, :) = 1;
    else
        CHOL(i, :) = 0;
    end
    if OLDPEAK(i, :) >= mid(:, 3)
        OLDPEAK(i, :) = 1;
    else
        OLDPEAK(i, :) = 0;
    end
    if TRTBPS(i, :) >= mid(:, 4)
        TRTBPS(i, :) = 1;
    else
        TRTBPS(i, :) = 0;
    end
end

Tab = {'Age', 'Chol', 'Oldpeak', 'Trtbps', 'Outcome'};
X = [AGE CHOL OLDPEAK TRTBPS OUTPUT];
writecell(Tab, t_path);
writematrix(X, t_path, 'WriteMode', 'append');






