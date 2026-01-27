
% Modify 'Dataset of Diabetes.xlsx' DataSet to make it random distributions
% Feb 5, 2024
 
dtPath = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset2\\';
tData = 'Dataset of Diabetes_M.xlsx';
sData = 'Dataset of Diabetes.xlsx'; 

sDataSet = strcat(dtPath, sData);       % source dataset
tDataSet = strcat(dtPath, tData);       % target dataset

T = readtable(sDataSet);
M = 1000;               % max row number on dataset
N = 1000;               % max row number on (train + check + test) data
Tab = {'ID', 'No_Pation', 'Gender', 'AGE', 'Urea', 'Cr', 'HbA1c', 'Chol', 'TG', 'HDL', 'LDL', 'VLDL', 'BMI', 'CLASS'};

g_M = strcmp(T.Gender,'M');
 T.Gender(g_M) = {1};
 g_F = strcmp(T.Gender,'F');
 T.Gender(g_F) = {0};

for i = 1:N 
    j = randi(M, 1, 1);
    writecell(Tab, tDataSet);
    writetable(T(j, :), tDataSet,'WriteMode','append');
end






