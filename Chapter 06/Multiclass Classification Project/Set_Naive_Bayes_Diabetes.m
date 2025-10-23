
% Calculate mean, variance for Diabetes test table
% Name: Set_Naive_Bayes_Diabetes.m
% 02-13-2024

n = 5;                                                 % number of columns for diabetes
vm = zeros(4);                                  % variances for 4 rows - diabetes
vw = zeros(4);                                  % variances for 4 rows - nondiabetes

a = [59 51 31 31 26;                        % 4 x 5 matrix for Diabetes = 1, each row = 5 inputs for one feature, such as Age, Glucose, ...
        189 166 118 107 78;                % totally 4 rows = 4 inputs, Age, Glucose, BP (Blood Pressure), BMI
         60 72 84 74 50;
         30.1 25.8 45.8 29.6 31];
b = [26 37 48 42 21;                        % 4 x 5 matrix for Diabetes = 0, each row = 5 inputs for one feature, such as Age, Glucose, ...
        180 133 106 150 73;                % totally 4 rows = 4 inputs, Age, Glucose, BP (Blood Pressure), BMI
         64 84 92 66 50;
         34 40.2 22.7 34.7 23];

for j=1:n-1                                         % get mean for 4 rows
    mm(j) = mean(a(j, :))                   % mean for Diabetes = 1 (Diabetes)
    mw(j) =mean(b(j, :))                    % mean for Diabetes = 0 (Non-Diabetes)
end

% get variances for Diabetes = 1 (Diabetes)
for i = 1:4                                             % outer-loop for 4 rows
    for j =1:n                                          % inner-loop for 5 columns
    vm(i) = vm(i) + (a(i, j)-mm(i))^2;% calculate variance for each column - numerator only
    end
vm(i) = vm(i)/n                                    % divided by n to get variances
end

% get variances for Diabetes = 0 (Non-Diabetes)
for i = 1:4                                             % outer-loop for 4 rows
    for j =1:n                                          % inner-loop for 5 columns
    vw(i) = vw(i) + (b(i, j)-mw(i))^2;% calculate variance for each column - numerator only
    end
vw(i) = vw(i)/n                                     % divided by n to get variances
end
