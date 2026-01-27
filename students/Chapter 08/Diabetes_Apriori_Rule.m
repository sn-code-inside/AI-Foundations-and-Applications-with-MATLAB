
% Find association rules by using Apriori Algorithm for dataset - Diabetes_AR.csv
% Name: Diabetes_Apriori_Rule.m
% Input: Modified dataset - Diabetes_AR.csv
% Output: Association rules
% Jul 12, 2024

path = 'C:\\Artificial Intelligence Book\Students\Datasets\Diabetes Dataset\\Diabetes_AR.csv';
T = readtable(path);                                                            
N = 20; M = 3;
m12 = 0; m13 = 0; m23 = 0; pairRemove = 0; SThreshold = 5;
supportC1 = zeros(M, 1); supportC2 = zeros(M, 1); 
supportC12 = 0; supportC13 = 0; supportC23 = 0; supportC123 = 0;

GLUCOSE = table2array(T(1:N, 1));                   % Glucose is located at column 1 in database
BMI = table2array(T(1:N, 2));                            % BMI is located at column 2 in database
OUTPUT = table2array(T(1:N, 5));                      % Outcome is located at column 5 in database
X = [GLUCOSE BMI OUTPUT];

for i = 1:M
    for j =1:N
    if (X(j, i) == 1) supportC1(i) = supportC1(i) + 1; end
    end
end

for k = 1:M
    if (supportC1(k, 1) > SThreshold) supportC2(k, 1) = supportC1(k, 1); end
end
supportC2(supportC2 == 0) = []

for j =1:N
    if (X(j, 1) == 1) && (X(j, 2) == 1)  supportC12 = supportC12 + 1;   end           % columns 1 & 2
    if (X(j, 1) == 1) && (X(j, 3) == 1)  supportC13 = supportC13 + 1;   end           % columns 1 & 3
    if (X(j, 2) == 1) && (X(j, 3) == 1)  supportC23 = supportC23 + 1;   end           % columns 2 & 3
end

if (supportC12 < SThreshold) m12 = m12 + 1; end
if (supportC13 < SThreshold) m13 = m13 + 1; end
if (supportC23 < SThreshold) m23 = m23 + 1; end
if ((m12 && m13 && m23) == 0) disp('No double pair removed'); 
else pairRemove = 1; end

supportC3 = X;                              % for testing purpose, can set pairRemove = m12=m13=m23 = 1

for j =1:N
     if (m12 ~= 0)
         if (X(j, 1) == 1) && (X(j, 2) == 1) supportC3(j, :, :) = 5
         end
     else if (m13 ~= 0) 
         if (X(j, 1) == 1) && (X(j, 3) == 1) supportC3(j, :, :) = 5
          end
     else if (m23 ~= 0)
          if (X(j, 2) == 1) && (X(j, 3) == 1) supportC3(j, :, :) = 5
          end
     else if (X(j, 1) == 1) && (X(j, 2) == 1)  && (X(j, 3) == 1)                   % columns 1 & 2 & 3
          supportC123 = supportC123 + 1
     end
  end
end
end
end

if (m12 == 1 || m13 == 1 || m23 == 1)
    supportC3(supportC3 == 5) = [];
    [row, col] = size(supportC3)
    supportC3 = reshape(supportC3, col/3, 3)
end























