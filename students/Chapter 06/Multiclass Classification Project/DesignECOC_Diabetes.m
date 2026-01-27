
% Test to train multi class classification model for diabetes
% Name: Diabetes_MC_Func_Project.m
% Input: Dataset of Diabetes_M.xlsx

dsPath = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset2\\';
sData = 'Dataset of Diabetes_M.xlsx';

sDataSet = strcat(dsPath, sData);       % source dataset
T = readtable(sDataSet);

M = designecoc(10, 'onevsall')

nOM = size(M);
class1VSOrd = [1; -ones(10,1); 0];
class1VSClass16 = [1; zeros(10,1); -1];
OrdVSClass16 = [0; ones(10,1); -1];
Coding = [class1VSOrd class1VSClass16 OrdVSClass16,...
    [zeros(1,nOM(2)); M; zeros(1,nOM(2))]]

X = [T.AGE, T.Urea T.Cr, T.HbA1c, T.Chol, T.TG, T.HDL, T.LDL, T.VLDL, T.BMI];
Y = T.CLASS;
Mdl = fitcecoc(X,Y,'Coding',Coding,'Learner','Tree');
