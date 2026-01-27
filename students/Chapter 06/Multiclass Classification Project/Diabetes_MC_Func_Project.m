
% Test to train multi class classification model for diabetes
% Name: Diabetes_MC_Func_Project.m
% Input: Dataset of Diabetes_M.xlsx

dsPath = 'C:\\Artificial Intelligence Book\\Students\\Datasets\\Diabetes Dataset2\\';
sData = 'Dataset of Diabetes_M.xlsx';
sDataSet = strcat(dsPath, sData);

T = readtable(sDataSet);
M = 1:900;                      % training data - 900 training data 
N = 901:1000;                % testing data - 100 testing data

X = [T.ID(M, :), T.No_Pation(M, :), T.Gender(M, :), T.AGE(M,:), T.Urea(M,:), T.Cr(M, :), T.HbA1c(M, :) + ...
         T.Chol(M, :), T.TG(M, :), T.HDL(M,:), T.LDL(M,:), T.VLDL(M, :), T.BMI(M, :)];
Y = T.CLASS(M, :);
TLabels = T.CLASS(N, :);

% Use fitcknn() function to train the model
mdl_1 = fitcknn(X, Y, "ClassNames", ["N", "P", "Y"])

% Get testing data XX to perform prediction or classification
XX = [T.ID(N, :), T.No_Pation(N, :), T.Gender(N, :), T.AGE(N,:), T.Urea(N,:), T.Cr(N, :), T.HbA1c(N, :) + ...
           T.Chol(N, :), T.TG(N, :), T.HDL(N,:), T.LDL(N,:), T.VLDL(N, :), T.BMI(N, :)];
[label1, score, cost] = predict(mdl_1, XX);
Title = 'The Confusion Chart for fitcknn() function';
figure(1)
plotConfChart(Title, TLabels, label1);           % call confusionchart() to plot confusion chart

% Use fitcnb() function to fit the model
mdl_2 = fitcnb(X, Y);
label2 = predict(mdl_2, XX);
Title = 'The Confusion Chart for fitcnb() function';
figure(2)
plotConfChart(Title, TLabels, label2);           % call confusionchart() to plot confusion chart

% Use fitcecoc() function to fit the model
mdl_3 = fitcecoc(X, Y, "ClassNames", ["N", "P", "Y"]);
label3 = predict(mdl_3, XX);
Title = 'The Confusion Chart for fitcecoc() function';
figure(3)
plotConfChart(Title, TLabels, label3);           % call confusionchart() to plot confusion chart

function[] = plotConfChart(title, tLabel, pLabel)
cm = confusionchart(tLabel, pLabel);
cm.Title = title;
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
end



