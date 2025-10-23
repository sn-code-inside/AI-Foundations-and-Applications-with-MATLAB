
% Using functions to perform linear regression
% Input: fire dataset
% Output: Regressed model

fileName = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Motor.xlsx';
ds = readtable(fileName);
m_mdl = fitlm(ds, 'linear')
plot(m_mdl);
grid;

