
% Modify 'Dataset of Diabetes.xlsx' DataSet to make it random distributions only without convert Gender to number
% Name: MDiabeteDataSet_NCC_Excel.m
% Feb 5, 2024
 
dtPath = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset2\\';
tData = 'Dataset of Diabetes_MM.xlsx';
sData = 'Dataset of Diabetes.xlsx'; 

sDataSet = strcat(dtPath, sData);       % source dataset
tDataSet = strcat(dtPath, tData);        % target dataset

T = readtable(sDataSet);
M = 1000;               % max row number on dataset
N = 1000;               % max row number on (train + check + test) data
Tab = {'ID', 'No_Pation', 'Gender', 'AGE', 'Urea', 'Cr', 'HbA1c', 'Chol', 'TG', 'HDL', 'LDL', 'VLDL', 'BMI', 'CLASS'};

for i = 1:N 
    j = randi(M, 1, 1);
    writecell(Tab, tDataSet);
    writetable(T(j, :), tDataSet,'WriteMode','append');
end






