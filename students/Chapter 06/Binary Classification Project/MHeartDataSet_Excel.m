% Modify heart.xlsx DataSet to make it random distributions
% Jan 30, 2024
 
tDataSet = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Heart Dataset\\heart1_M.xlsx';      % target dataset
sDataSet = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Heart Dataset\\heart1.xlsx';           % source dataset
[num,txt,raw] = xlsread(sDataSet);
M = 289;               % max row number on dataset
N = 280;               % max row number on (train + check + test) data
Tab = {'age', 'sex', 'cp', 'trtbps', 'chol', 'fbs', 'restecg', 'thalachh', 'exng', 'oldpeak', 'slp', 'caa', 'thall', 'output'};
for i = 1:N 
    j = randi(M,1,1);
    num(j,:)
    writecell(Tab, tDataSet);
    writematrix(num(j,:), tDataSet,'WriteMode','append');
end



