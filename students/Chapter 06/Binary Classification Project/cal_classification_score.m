
% Simulated calculations for linear classification training process.
% Name: cal_linear_classification.m
% Output: Calculated score for Cat
%

W = [0.3 -0.4 0.2 1.2 2.1; 0.7 1.4 1.8 2.3 0.1; 0.1 0.25 0.5 0.1 0.2]
B = [2.1 2.6 -1.2]'
X = [38 56 221 14 2]'
S = W*X + B
