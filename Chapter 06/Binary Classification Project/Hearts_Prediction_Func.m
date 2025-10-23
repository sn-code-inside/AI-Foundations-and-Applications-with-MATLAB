
% Test to train binary classification model for heart disease using function fitsvm() & TreeBagger()
% Name: Hearts_Prediction_Func.m
% Input: heart1_M.xlsx

T = readtable("C:\\Artificial Intelligence Book\\Students\\Datasets\\Heart Dataset\\" + ...
                         "heart1_M.xlsx");
M = 1:180;                    % training data - 180 training data 
N = 181:280;                % testing data - 100 testing data

X = [T.age(M, :), T.sex(M, :), T.cp(M,:), T.trtbps(M,:), T.chol(M, :), T.fbs(M, :), T.restecg(M, :) +...
         T.thalachh(M, :), T.exng(M, :), T.oldpeak(M,:), T.slp(M,:), T.caa(M, :), T.thall(M, :)];

% Get testing data XX to perform prediction or classification
XX = [T.age(N, :), T.sex(N, :), T.cp(N,:), T.trtbps(N,:), T.chol(N, :), T.fbs(N, :), T.restecg(N, :) +...
           T.thalachh(N, :), T.exng(N, :), T.oldpeak(N,:), T.slp(N,:), T.caa(N, :), T.thall(N, :)];

Y = T.output(M, :);
TLabel = T.output(N, :);

% Use TreeBagger() function to fit the model
mdl_tree = TreeBagger(100, X, Y);
labelt = predict(mdl_tree, XX);
labelt =str2double(labelt);
Title = 'The Confusion Chart for TreeBagger() function';
figure(1)
plotConfChart(Title, TLabel, labelt);           % call confusionchart() to plot confusion chart

% Use fitcsvm() function to fit the model
mdl_svm = fitcsvm(X, Y);
labels = predict(mdl_svm, XX);
Title = 'The Confusion Chart for fitcsvm() function';
figure(2)
plotConfChart(Title, TLabel, labels);           % call confusionchart() to plot confusion chart

function[] = plotConfChart(title, tLabel, pLabel)
cm = confusionchart(tLabel, pLabel);
cm.Title = title;
cm.RowSummary = 'row-normalized';
cm.ColumnSummary = 'column-normalized';
end









